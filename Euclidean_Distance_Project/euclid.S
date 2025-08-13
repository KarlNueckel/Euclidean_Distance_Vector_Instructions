	.file	"euclid.c"
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mfma -msse3 -mtune=generic -march=x86-64 -O2 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.p2align 4
	.globl	euclid_scalar
	.type	euclid_scalar, @function
euclid_scalar:
.LFB5512:
	.cfi_startproc
	endbr64	
# euclid.c:24:   double sum = 0.0;
	vxorpd	%xmm1, %xmm1, %xmm1	# <retval>
# euclid.c:35:   for (i=0; i<dimension; i++)
	testq	%rdx, %rdx	# dimension
	jle	.L1	#,
# euclid.c:35:   for (i=0; i<dimension; i++)
	xorl	%eax, %eax	# i
	.p2align 4,,10
	.p2align 3
.L3:
# euclid.c:42:     f0 = s0[i] - s1[i];
	vmovss	(%rdi,%rax,4), %xmm0	# MEM[(float *)s0_13(D) + _31 * 4], MEM[(float *)s0_13(D) + _31 * 4]
	vsubss	(%rsi,%rax,4), %xmm0, %xmm0	# MEM[(float *)s1_14(D) + _31 * 4], MEM[(float *)s0_13(D) + _31 * 4], f0
# euclid.c:35:   for (i=0; i<dimension; i++)
	addq	$1, %rax	#, i
# euclid.c:43:     f1 = f0 * f0;
	vmulss	%xmm0, %xmm0, %xmm0	# f0, f0, f1
# euclid.c:44:     sum += f1;
	vcvtss2sd	%xmm0, %xmm0, %xmm0	# f1, tmp95
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp95, <retval>, <retval>
# euclid.c:35:   for (i=0; i<dimension; i++)
	cmpq	%rax, %rdx	# i, dimension
	jne	.L3	#,
.L1:
# euclid.c:48: }
	vmovsd	%xmm1, %xmm1, %xmm0	# <retval>,
	ret	
	.cfi_endproc
.LFE5512:
	.size	euclid_scalar, .-euclid_scalar
	.p2align 4
	.globl	euclid_vector
	.type	euclid_vector, @function
euclid_vector:
.LFB5513:
	.cfi_startproc
	endbr64	
# euclid.c:66:   for (i=0; i<(dimension/4); i++)
	testq	%rdx, %rdx	# dimension
	leaq	3(%rdx), %rcx	#, tmp99
	cmovns	%rdx, %rcx	# tmp99,, dimension, dimension
	sarq	$2, %rcx	#, tmp100
# euclid.c:66:   for (i=0; i<(dimension/4); i++)
	cmpq	$3, %rdx	#, dimension
	jle	.L10	#,
	xorl	%eax, %eax	# ivtmp.30
# euclid.c:54:   __m128 sum0 = _mm_setzero_ps();
	vxorps	%xmm1, %xmm1, %xmm1	# sum0
# euclid.c:66:   for (i=0; i<(dimension/4); i++)
	xorl	%edx, %edx	# i
	.p2align 4,,10
	.p2align 3
.L9:
# /usr/lib/gcc/x86_64-linux-gnu/11/include/xmmintrin.h:192:   return (__m128) ((__v4sf)__A - (__v4sf)__B);
	vmovups	(%rdi,%rax), %xmm2	# MEM[(__m128_u * {ref-all})s0_9(D) + ivtmp.30_50 * 1], tmp114
	vsubps	(%rsi,%rax), %xmm2, %xmm0	# MEM[(__m128_u * {ref-all})s1_10(D) + ivtmp.30_50 * 1], tmp114, _15
# euclid.c:66:   for (i=0; i<(dimension/4); i++)
	addq	$1, %rdx	#, i
# euclid.c:66:   for (i=0; i<(dimension/4); i++)
	addq	$16, %rax	#, ivtmp.30
# /usr/lib/gcc/x86_64-linux-gnu/11/include/fmaintrin.h:57:   return (__m128)__builtin_ia32_vfmaddps ((__v4sf)__A, (__v4sf)__B,
	vfmadd231ps	%xmm0, %xmm0, %xmm1	# _15, _15, sum0
# euclid.c:66:   for (i=0; i<(dimension/4); i++)
	cmpq	%rcx, %rdx	# tmp100, i
	jl	.L9	#,
.L8:
# /usr/lib/gcc/x86_64-linux-gnu/11/include/pmmintrin.h:71:   return (__m128) __builtin_ia32_movshdup ((__v4sf)__X);
	vmovshdup	%xmm1, %xmm0	# sum0, tmp104
# /usr/lib/gcc/x86_64-linux-gnu/11/include/xmmintrin.h:186:   return (__m128) ((__v4sf)__A + (__v4sf)__B);
	vaddps	%xmm1, %xmm0, %xmm1	# sum0, tmp104, _19
# /usr/lib/gcc/x86_64-linux-gnu/11/include/xmmintrin.h:787:   return (__m128) __builtin_ia32_movhlps ((__v4sf)__A, (__v4sf)__B);
	vmovhlps	%xmm1, %xmm0, %xmm0	# _19, tmp104, tmp106
# /usr/lib/gcc/x86_64-linux-gnu/11/include/xmmintrin.h:130:   return (__m128) __builtin_ia32_addss ((__v4sf)__A, (__v4sf)__B);
	vaddss	%xmm0, %xmm1, %xmm1	# tmp106, _19, tmp107
# euclid.c:88:   sum = _mm_cvtss_f32(sums);               // Extract scalar float
	vcvtss2sd	%xmm1, %xmm1, %xmm0	# tmp109, sum
# euclid.c:91: }
	ret	
	.p2align 4,,10
	.p2align 3
.L10:
# euclid.c:54:   __m128 sum0 = _mm_setzero_ps();
	vxorps	%xmm1, %xmm1, %xmm1	# sum0
	jmp	.L8	#
	.cfi_endproc
.LFE5513:
	.size	euclid_vector, .-euclid_vector
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
