#include <stdlib.h>
#include <stdio.h>

#ifdef IGNORE
#include <arm_neon.h>
#endif

#include <time.h>
#include <unistd.h>
#include <sys/mman.h>
#include "euclid.h"

#define MEMSZ	(1024*1024*1024)
#define MAX_DIMENSION	(MEMSZ / sizeof(float))

int main(int argc, char *argv[])
{
  long i, j, k;
  unsigned int seedp;
  long elapsed;
  struct timespec ts0, ts1;
  float *s0, *s1;
  double sum = 0.0;
  int dimension, loops;
  int pagesz = sysconf(_SC_PAGESIZE);

  if (argc != 3)
  {
    printf("usage: %s <dimension> <loops>\n", argv[0]);
    exit(0);
  }

  dimension = atoi(argv[1]);
  loops = atoi(argv[2]);

  if (dimension > MAX_DIMENSION)
  {
    printf("dimension %d > max dimension %ld\n", dimension, MAX_DIMENSION);
    exit(0);
  }

  //printf("before mmap\n");
  //s0 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_HUGETLB,0,0);
  //s1 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_HUGETLB,0,0);
  s0 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,0,0);
  s1 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,0,0);

  if (s0 == NULL || s1 == NULL)
  {
    perror("mmap");
    exit(0);
  }

  seedp = (long)s0 * getpid();

  //printf("init\n");
  for (i=0; i<dimension; i++)
  {
    s0[i] = (rand_r(&seedp) % 10) * 1.2345;
    s1[i] = (rand_r(&seedp) % 10) * 5.4321;
  }
  
  printf("Dimensions: %d, Loops: %d \n", dimension, loops);

  clock_gettime(CLOCK_MONOTONIC, &ts0);

  //SCALAR VERSION 
  for (i=0; i<loops; i++)
    sum += euclid_scalar(s0, s1, dimension);

  clock_gettime(CLOCK_MONOTONIC, &ts1);

  elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
  

  printf("Elapsed Time (Scalar): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);

  sum = 0.0;

  clock_gettime(CLOCK_MONOTONIC, &ts0);

  //VECTOR 
  for (i=0; i<loops; i++)
    sum += euclid_vector(s0, s1, dimension);

  clock_gettime(CLOCK_MONOTONIC, &ts1);

  elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
  
  printf("Elapsed Time (Vector): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);

  sum = 0.0;

  clock_gettime(CLOCK_MONOTONIC, &ts0);

  #ifdef IGNORE
  //VECTOR4 
  for (i=0; i<loops; i++)
    sum += euclid_vector4(s0, s1, dimension);

  clock_gettime(CLOCK_MONOTONIC, &ts1);

  elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
  printf("%ld,%lf\n", elapsed/(1000*1000), sum);
  
  #endif 

  munmap(s0, MEMSZ);
  munmap(s1, MEMSZ);

  return 0;
}
