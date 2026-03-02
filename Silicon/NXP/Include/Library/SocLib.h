/** @file

  Copyright 2020 NXP
  SPDX-License-Identifier: BSD-2-Clause-Patent

**/

#ifndef SOC_LIB_H__
#define SOC_LIB_H__

#include <Uefi.h>

/**
  Function to initialize SoC specific constructs
 **/
VOID
SocInit (
  VOID
  );

/**
  Function to get System Version Register(SVR) of SoC
**/
UINT32
SocGetSvr (
  VOID
  );
#endif // SOC_LIB_H__
