#include <stdlib.h>
#include <stdio.h>


#ifdef IGNORE
#include <arm_neon.h>
#endif

#include <immintrin.h>
#include <time.h>
#include "euclid.h"

#define MEMBAR	{__asm__ __volatile__("":::"memory");}

#define printvec(v,c,n)		\
	printf("%s:  ", c); 	\
	for (i=0; i<n; i++) 	\
	  printf("%f ", v[i]);\
	printf("\n");

double __attribute__ ((noinline)) euclid_scalar(float *s0, float *s1, long dimension)
{
  long i;
  double sum = 0.0;
  float f0, f1;

#ifdef PREFETCH
  for (i=0; i<PREFDIST; i++)
  {
    __builtin_prefetch(((const char *)s0) + (i*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (i*64), 0, 3);
  }
#endif

  for (i=0; i<dimension; i++)
  { 
#ifdef PREFETCH
    __builtin_prefetch(((const char *)s0) + (i*sizeof(float)) + (PREFDIST*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (i*sizeof(float)) + (PREFDIST*64), 0, 3);
#endif

    f0 = s0[i] - s1[i];
    f1 = f0 * f0;
    sum += f1;
  }

  return sum;
}
double __attribute__ ((noinline)) euclid_vector(float *s0, float *s1, long dimension)
{
  long i;
  double sum = 0.0;
  __m128 v0, v1, diff; //creates 4 single precision float lanes 
  __m128 sum0 = _mm_setzero_ps();  //set all float lanes to 0.0

  sum = 0.0;

#ifdef PREFETCH
  for (i=0; i<PREFDIST; i++)
  {
    __builtin_prefetch(((const char *)s0) + (i*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (i*64), 0, 3);
  }
#endif

  for (i=0; i<(dimension/4); i++)
  { 
#ifdef PREFETCH
    __builtin_prefetch(((const char *)s0) + (PREFDIST*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (PREFDIST*64), 0, 3);
#endif

    v0 = _mm_loadu_ps(s0); //loads 4 floats starting at mem address s0 into register v0
    v1 = _mm_loadu_ps(s1); //load 4 floats starting at s1 into v1
    diff = _mm_sub_ps(v0, v1); //subtract v1 - v0 for each vector element

    sum0 = _mm_fmadd_ps(diff, diff, sum0); //square result then add result to sum0

    s0 += 4;
    s1 += 4;
  }

  
  __m128 t = _mm_hadd_ps(sum0,sum0); //add together all of the sum0's
  t = _mm_hadd_ps(t,t); //
  sum = (double)_mm_cvtss_f32(t);

  return sum;

}


double __attribute__ ((noinline)) euclid_vector4(float *s0, float *s1, long dimension)
{
  long i;
  double sum = 0.0;
  __m256 v0, v1, v2, v3, v4, v5, v6, v7, v8;
  __m256 sum0, sum1, sum2, sum3;

  sum = 0.0;
  sum0 = _mm256_setzero_ps();
  sum1 = _mm256_setzero_ps();
  sum2 = _mm256_setzero_ps();
  sum3 = _mm256_setzero_ps();

#ifdef PREFETCH
  for (i=0; i<PREFDIST; i++)
  {
    __builtin_prefetch(((const char *)s0) + (i*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (i*64), 0, 3);
  }
#endif

  for (i=0; i<(dimension/32); i++)
  { 
#ifdef PREFETCH
    __builtin_prefetch(((const char *)s0) + (PREFDIST*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (PREFDIST*64), 0, 3);
#endif

    v0 = _mm256_loadu_ps((float *)(s0+0));
    v1 = _mm256_loadu_ps((float *)(s0+8));
    v2 = _mm256_loadu_ps((float *)(s0+16));
    v3 = _mm256_loadu_ps((float *)(s0+24));

    v4 = _mm256_loadu_ps((float *)(s1+0));
    v5 = _mm256_loadu_ps((float *)(s1+8));
    v6 = _mm256_loadu_ps((float *)(s1+16));
    v7 = _mm256_loadu_ps((float *)(s1+24));

    v0 = _mm256_sub_ps(v0, v4);
    v1 = _mm256_sub_ps(v1, v5);
    v2 = _mm256_sub_ps(v2, v6);
    v3 = _mm256_sub_ps(v3, v7);

    sum0 = _mm256_fmadd_ps(v0, v0, sum0);
    sum1 = _mm256_fmadd_ps(v1, v1, sum1);
    sum2 = _mm256_fmadd_ps(v2, v2, sum2);
    sum3 = _mm256_fmadd_ps(v3, v3, sum3);

    s0 += 32;
    s1 += 32;
  }

  // Horizontal sum of all elements in each vector
  __m256 temp_sum = _mm256_add_ps(sum0, sum1);
  temp_sum = _mm256_add_ps(temp_sum, sum2);
  temp_sum = _mm256_add_ps(temp_sum, sum3);
  
  // Extract the 8 float values and sum them
  float temp_array[8];
  _mm256_storeu_ps(temp_array, temp_sum);
  sum = temp_array[0] + temp_array[1] + temp_array[2] + temp_array[3] + 
        temp_array[4] + temp_array[5] + temp_array[6] + temp_array[7];

  return sum;
}


#ifdef IGNORE
double __attribute__ ((noinline)) euclid_vector(float *s0, float *s1, long dimension)
{
  long i;
  double sum = 0.0;
  float32x4_t v0, v1;
  float32x4_t sum0;

  sum = 0.0;
  sum0 = vdupq_n_f32(0);

#ifdef PREFETCH
  for (i=0; i<PREFDIST; i++)
  {
    __builtin_prefetch(((const char *)s0) + (i*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (i*64), 0, 3);
  }
#endif

  for (i=0; i<(dimension/4); i++)
  { 
#ifdef PREFETCH
    __builtin_prefetch(((const char *)s0) + (PREFDIST*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (PREFDIST*64), 0, 3);
#endif

    v0 = vld1q_f32((float32_t *)s0);
    v1 = vld1q_f32((float32_t *)s1);

    v0 = vsubq_f32(v0, v1);
    sum0 = vfmaq_f32(sum0, v0, v0);

    s0 += 4;
    s1 += 4;
  }

  sum = vaddvq_f32(sum0);

  return sum;
}

double __attribute__ ((noinline)) euclid_vector4(float *s0, float *s1, long dimension)
{
  long i;
  double sum = 0.0;
  float32x4_t v0, v1, v2, v3, v4, v5, v6, v7, v8;
  float32x4_t sum0, sum1, sum2, sum3;

  sum = 0.0;
  sum0 = vdupq_n_f32(0);
  sum1 = vdupq_n_f32(0);
  sum2 = vdupq_n_f32(0);
  sum3 = vdupq_n_f32(0);

#ifdef PREFETCH
  for (i=0; i<PREFDIST; i++)
  {
    __builtin_prefetch(((const char *)s0) + (i*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (i*64), 0, 3);
  }
#endif

  for (i=0; i<(dimension/16); i++)
  { 
#ifdef PREFETCH
    __builtin_prefetch(((const char *)s0) + (PREFDIST*64), 0, 3);
    __builtin_prefetch(((const char *)s1) + (PREFDIST*64), 0, 3);
#endif

    v0 = vld1q_f32((float32_t *)(s0+0));
    v1 = vld1q_f32((float32_t *)(s0+4));
    v2 = vld1q_f32((float32_t *)(s0+8));
    v3 = vld1q_f32((float32_t *)(s0+12));

    v4 = vld1q_f32((float32_t *)(s1+0));
    v5 = vld1q_f32((float32_t *)(s1+4));
    v6 = vld1q_f32((float32_t *)(s1+8));
    v7 = vld1q_f32((float32_t *)(s1+12));

    v0 = vsubq_f32(v0, v4);
    v1 = vsubq_f32(v1, v5);
    v2 = vsubq_f32(v2, v6);
    v3 = vsubq_f32(v3, v7);

    sum0 = vfmaq_f32(sum0, v0, v0);
    sum1 = vfmaq_f32(sum1, v1, v1);
    sum2 = vfmaq_f32(sum2, v2, v2);
    sum3 = vfmaq_f32(sum3, v3, v3);

    s0 += 16;
    s1 += 16;
  }

  sum = vaddvq_f32(sum0);
  sum += vaddvq_f32(sum1);
  sum += vaddvq_f32(sum2);
  sum += vaddvq_f32(sum3);

  return sum;
}
#endif
