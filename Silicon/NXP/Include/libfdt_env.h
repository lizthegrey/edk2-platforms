/** @file
  libfdt environment header for NXP EDK2 platform code.

  This header overrides the upstream libfdt_env.h (from BaseFdtLib/libfdt/libfdt/)
  to provide the necessary type definitions and function mappings using EDK2
  primitives, without pulling in BaseFdtLib's C standard library shim headers
  (string.h, stddef.h, etc.) which would shadow real headers and break
  non-FDT modules.

  Based on MdePkg/Library/BaseFdtLib/LibFdtSupport.h and the original
  libfdt/libfdt/libfdt_env.h.

  Copyright (c) 2023, Intel Corporation. All rights reserved.<BR>
  SPDX-License-Identifier: BSD-2-Clause-Patent
**/

#ifndef LIBFDT_ENV_H
#define LIBFDT_ENV_H

#include <Base.h>
#include <Library/BaseLib.h>
#include <Library/BaseMemoryLib.h>

/*
 * C standard type definitions mapped to EDK2 types
 */
typedef UINT8   uint8_t;
typedef UINT16  uint16_t;
typedef INT32   int32_t;
typedef UINT32  uint32_t;
typedef UINT64  uint64_t;
typedef UINTN   uintptr_t;
typedef UINTN   size_t;

#if defined __STDC_VERSION__ && __STDC_VERSION__ > 201710L
/* bool, true and false are keywords in C23+.  */
#else
typedef BOOLEAN bool;
#define true   (1 == 1)
#define false  (1 == 0)
#endif

/*
 * Limits constants used by libfdt
 */
#define INT_MAX     0x7FFFFFFF
#define INT32_MAX   0x7FFFFFFF
#define UINT32_MAX  0xFFFFFFFF

/*
 * C standard library function mappings to EDK2 equivalents
 */
#define memcpy(dest, source, count)   CopyMem(dest, source, (UINTN)(count))
#define memset(dest, ch, count)       SetMem(dest, (UINTN)(count), (UINT8)(ch))
#define memchr(buf, ch, count)        ScanMem8(buf, (UINTN)(count), (UINT8)ch)
#define memcmp(buf1, buf2, count)     (int)(CompareMem(buf1, buf2, (UINTN)(count)))
#define memmove(dest, source, count)  CopyMem(dest, source, (UINTN)(count))
#define strlen(str)                   (size_t)(AsciiStrLen(str))
#define strnlen(str, count)           (size_t)(AsciiStrnLenS(str, count))
#define strchr(str, ch)               ScanMem8(str, AsciiStrSize(str), (UINT8)ch)
#define strcmp(s1, s2)                (int)(AsciiStrCmp(s1, s2))
#define strncmp(s1, s2, n)            (int)(AsciiStrnCmp(s1, s2, n))

/*
 * FDT byte-order conversion macros and types
 */
#ifdef __CHECKER__
#define FDT_FORCE __attribute__((force))
#define FDT_BITWISE __attribute__((bitwise))
#else
#define FDT_FORCE
#define FDT_BITWISE
#endif

typedef uint16_t FDT_BITWISE fdt16_t;
typedef uint32_t FDT_BITWISE fdt32_t;
typedef uint64_t FDT_BITWISE fdt64_t;

#define EXTRACT_BYTE(x, n)  ((unsigned long long)((uint8_t *)&x)[n])
#define CPU_TO_FDT16(x) ((EXTRACT_BYTE(x, 0) << 8) | EXTRACT_BYTE(x, 1))
#define CPU_TO_FDT32(x) ((EXTRACT_BYTE(x, 0) << 24) | (EXTRACT_BYTE(x, 1) << 16) | \
                          (EXTRACT_BYTE(x, 2) << 8) | EXTRACT_BYTE(x, 3))
#define CPU_TO_FDT64(x) ((EXTRACT_BYTE(x, 0) << 56) | (EXTRACT_BYTE(x, 1) << 48) | \
                          (EXTRACT_BYTE(x, 2) << 40) | (EXTRACT_BYTE(x, 3) << 32) | \
                          (EXTRACT_BYTE(x, 4) << 24) | (EXTRACT_BYTE(x, 5) << 16) | \
                          (EXTRACT_BYTE(x, 6) << 8) | EXTRACT_BYTE(x, 7))

static inline uint16_t fdt16_to_cpu(fdt16_t x)
{
  return (FDT_FORCE uint16_t)CPU_TO_FDT16(x);
}

static inline fdt16_t cpu_to_fdt16(uint16_t x)
{
  return (FDT_FORCE fdt16_t)CPU_TO_FDT16(x);
}

static inline uint32_t fdt32_to_cpu(fdt32_t x)
{
  return (FDT_FORCE uint32_t)CPU_TO_FDT32(x);
}

static inline fdt32_t cpu_to_fdt32(uint32_t x)
{
  return (FDT_FORCE fdt32_t)CPU_TO_FDT32(x);
}

static inline uint64_t fdt64_to_cpu(fdt64_t x)
{
  return (FDT_FORCE uint64_t)CPU_TO_FDT64(x);
}

static inline fdt64_t cpu_to_fdt64(uint64_t x)
{
  return (FDT_FORCE fdt64_t)CPU_TO_FDT64(x);
}

#undef CPU_TO_FDT64
#undef CPU_TO_FDT32
#undef CPU_TO_FDT16
#undef EXTRACT_BYTE

#endif /* LIBFDT_ENV_H */
