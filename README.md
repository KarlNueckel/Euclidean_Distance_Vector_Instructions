# Euclidean Distance Vector Instructions Project

This project implements and benchmarks different approaches to calculate Euclidean distance between vectors using various SIMD (Single Instruction, Multiple Data) instruction sets.

## Overview

The project demonstrates the performance benefits of vectorized computations by implementing Euclidean distance calculation using:
- **Scalar implementation** (baseline)
- **SSE/AVX implementation** (4-float vectors)
- **AVX2 implementation** (8-float vectors with 4x unrolling)

## Files

- `euclid.h` - Header file with function declarations
- `euclid.c` - Main implementation with scalar, SSE, and AVX2 versions
- `vec.c` - Benchmarking program
- `h.sh` - Test script for automated benchmarking
- `vec` - Compiled executable (Linux/WSL)
- `euclid.S` - Assembly implementation
- `vec.s` - Assembly output

## Implementations

### 1. Scalar Implementation (`euclid_scalar`)
- Basic C implementation using loops
- Processes one float at a time
- Serves as performance baseline

### 2. SSE/AVX Implementation (`euclid_vector`)
- Uses `__m128` vectors (4 floats per vector)
- Processes 4 floats per iteration
- Uses `_mm_fmadd_ps` for fused multiply-add operations

### 3. AVX2 Implementation (`euclid_vector4`)
- Uses `__m256` vectors (8 floats per vector)
- 4x loop unrolling for better performance
- Processes 32 floats per iteration
- Multiple accumulators to reduce dependency chains

## Performance Results

Typical performance improvements:
- **Scalar**: Baseline (100%)
- **SSE/AVX**: ~2.3x faster
- **AVX2**: ~13.7x faster

## Compilation

### Prerequisites
- GCC compiler with AVX2 support
- Linux/WSL environment (for `sys/mman.h`)

### Compile with AVX2 support:
```bash
gcc -O3 -mavx2 -mfma -o vec vec.c euclid.c
```

### Compile without AVX2 (SSE only):
```bash
gcc -O3 -msse4.2 -mfma -o vec vec.c euclid.c
```

## Usage

### Run benchmark with default parameters:
```bash
./vec 1000 1000000
```

### Run with custom parameters:
```bash
./vec <dimension> <loops>
```

### Use the test script:
```bash
./h.sh
```

### Parameters:
- `dimension`: Number of floats in each vector (default: 1000)
- `loops`: Number of iterations for benchmarking (default: 1000000)

## Output Format

The program outputs timing and sum results for each implementation:
```
Dimensions: 1000, Loops: 1000000 
Elapsed Time (nanoseconds)(Scalar): 824, Sum: 601082814254.339966 
Elapsed Time (nanoseconds)(Vector): 361, Sum: 601082812500.000000 
Elapsed Time (nanoseconds)(Vector4): 60, Sum: 60594767750000.000000
```

## Technical Details

### AVX2 Implementation Features:
- **8-float vectors**: `__m256` type for wider data processing
- **4x unrolling**: Processes 4 vectors per iteration
- **Multiple accumulators**: Uses 4 separate sum registers
- **Fused multiply-add**: `_mm256_fmadd_ps` for efficient computation
- **Horizontal reduction**: Manual sum of vector elements

### Memory Access Pattern:
- Strided access for better cache utilization
- Prefetching support (optional)
- Unaligned loads for flexibility

### Mathematical Formula:
Implements: `Σ(s0[i] - s1[i])²` for i = 0 to dimension-1

Returns the **squared** Euclidean distance (no square root) for performance.

## Platform Support

- **Primary**: Linux/WSL with x86_64 architecture
- **Requirements**: CPU with AVX2 support (Haswell and newer)
- **Optional**: ARM NEON support (commented out in code)

## Performance Tips

1. **Use AVX2**: Ensure `-mavx2 -mfma` flags for best performance
2. **Optimization level**: Use `-O3` for maximum optimization
3. **Memory alignment**: For even better performance, ensure 32-byte alignment
4. **Cache-friendly**: Large vectors benefit from prefetching

## Future Enhancements

- ARM NEON implementation for ARM processors
- AVX-512 implementation for newer Intel processors
- Multi-threaded versions
- Different distance metrics (Manhattan, Cosine, etc.)

## License

[Add your license information here]

## Contributing

[Add contribution guidelines here]
