#define PREFDIST	64

double __attribute__ ((noinline)) euclid_scalar(float *s0, float *s1, long dimension);
double __attribute__ ((noinline)) euclid_vector(float *s0, float *s1, long dimension);
double __attribute__ ((noinline)) euclid_vector4(float *s0, float *s1, long dimension);
