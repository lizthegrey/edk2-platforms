/** @file
 *
 *  Copyright 2017-2020 NXP
 *
 * SPDX-License-Identifier: BSD-2-Clause-Patent
 *
 **/

#ifndef IO_ACCESS_LIB_H_
#define IO_ACCESS_LIB_H_

#include <Base.h>

///
///  Structure to have pointer to R/W
///  Mmio operations for 16 bits.
///
typedef struct _MMIO_OPERATIONS {
  UINT16 (*Read16) (UINTN Address);
  UINT16 (*Write16) (UINTN Address, UINT16 Value);
  UINT16 (*Or16) (UINTN Address, UINT16 OrData);
  UINT16 (*And16) (UINTN Address, UINT16 AndData);
  UINT16 (*AndThenOr16) (UINTN Address, UINT16 AndData, UINT16 OrData);
  UINT32 (*Read32) (UINTN Address);
  UINT32 (*Write32) (UINTN Address, UINT32 Value);
  UINT32 (*Or32) (UINTN Address, UINT32 OrData);
  UINT32 (*And32) (UINTN Address, UINT32 AndData);
  UINT32 (*AndThenOr32) (UINTN Address, UINT32 AndData, UINT32 OrData);
  UINT64 (*Read64) (UINTN Address);
  UINT64 (*Write64) (UINTN Address, UINT64 Value);
  UINT64 (*Or64) (UINTN Address, UINT64 OrData);
  UINT64 (*And64) (UINTN Address, UINT64 AndData);
  UINT64 (*AndThenOr64) (UINTN Address, UINT64 AndData, UINT64 OrData);
} MMIO_OPERATIONS;

/**
  Function to return pointer to Mmio operations.

  @param  Swap  Flag to tell if Swap is needed or not
                on Mmio Operations.

  @return       Pointer to Mmio Operations.

**/
MMIO_OPERATIONS *
GetMmioOperations  (
  IN  BOOLEAN  Swap
  );

/**
  Compatibility macros for SolidRun modules that call the old SwapMmio*
  API directly.  Upstream made these STATIC in IoAccessLib.c and removed
  the public declarations; the canonical API is GetMmioOperations(TRUE).
  Guarded to avoid expanding inside IoAccessLib.c where the STATIC
  functions are defined.
**/
#ifndef IO_ACCESS_LIB_IMPLEMENTATION
#define SwapMmioRead16(Address)                GetMmioOperations(TRUE)->Read16((Address))
#define SwapMmioRead32(Address)                GetMmioOperations(TRUE)->Read32((Address))
#define SwapMmioRead64(Address)                GetMmioOperations(TRUE)->Read64((Address))
#define SwapMmioWrite16(Address, Value)        GetMmioOperations(TRUE)->Write16((Address), (Value))
#define SwapMmioWrite32(Address, Value)        GetMmioOperations(TRUE)->Write32((Address), (Value))
#define SwapMmioWrite64(Address, Value)        GetMmioOperations(TRUE)->Write64((Address), (Value))
#define SwapMmioOr16(Address, OrData)          GetMmioOperations(TRUE)->Or16((Address), (OrData))
#define SwapMmioOr32(Address, OrData)          GetMmioOperations(TRUE)->Or32((Address), (OrData))
#define SwapMmioOr64(Address, OrData)          GetMmioOperations(TRUE)->Or64((Address), (OrData))
#define SwapMmioAnd16(Address, AndData)        GetMmioOperations(TRUE)->And16((Address), (AndData))
#define SwapMmioAnd32(Address, AndData)        GetMmioOperations(TRUE)->And32((Address), (AndData))
#define SwapMmioAnd64(Address, AndData)        GetMmioOperations(TRUE)->And64((Address), (AndData))
#define SwapMmioAndThenOr16(Address, And, Or)  GetMmioOperations(TRUE)->AndThenOr16((Address), (And), (Or))
#define SwapMmioAndThenOr32(Address, And, Or)  GetMmioOperations(TRUE)->AndThenOr32((Address), (And), (Or))
#define SwapMmioAndThenOr64(Address, And, Or)  GetMmioOperations(TRUE)->AndThenOr64((Address), (And), (Or))
#endif /* IO_ACCESS_LIB_IMPLEMENTATION */

#endif /* IO_ACCESS_LIB_H_ */
