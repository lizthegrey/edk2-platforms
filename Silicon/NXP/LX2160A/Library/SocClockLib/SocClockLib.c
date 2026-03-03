/** @file

 Copyright 2017-2018 NXP

 This program and the accompanying materials
 are licensed and made available under the terms and conditions of the BSD License
 which accompanies this distribution.  The full text of the license may be found at
 http://opensource.org/licenses/bsd-license.php

 THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
 WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

 **/

#include <Soc.h>
#include <Library/IoLib.h>
#include <Library/DebugLib.h>
#include <Library/BoardInfoLib.h>
#include <Library/SocClockLib.h>

#include "SocClockInternalLib.h"

/**
  Return the input clock frequency to an IP Module.
  If a module is disabled or doesn't exist on platform, then return zero.

  @param[in]  IpModule   The IP module whose input clock frequency is needed.
  @param[in]  Instance   The Instance of IP module whose input clock frequency is needed.
                         if there are multiple modules of same type then this value tells the
                         instance of module for which clock is to be retrieved.
                         (e.g. if there are four i2c controllers in SOC, then this value can be 1, 2, 3, 4)
                         for IP modules which have only single instance in SOC (e.g. one QSPI controller)
                         this value should be 0.

  @return      > 0       Return the input clock frequency to an IP Module
                0        either IP module doesn't exist in SOC
                         or IP module instance doesn't exist in SOC
                         or IP module instance is disabled. i.e. no input clock is provided to IP module instance.
**/
UINT64
SocGetClock (
  IN  IP_MODULES  IpModule,
  IN  UINT32      Instance
  )
{
  CCSR_GUR     *GurBase;
  RCW_FIELDS   *Rcw;
  UINT64       ReturnValue;
  UINT64       SysClkHz;
  UINT64       PlatformClk;
  UINT32       ConfigRegister; // device configuration register. can be used for any device

  if (IpModule >= IP_MAX) {
    return 0;
  }

  GurBase = (VOID *)PcdGet64 (PcdGutsBaseAddr);
  ASSERT (GurBase != NULL);

  Rcw = (RCW_FIELDS *)GurBase->RcwSr;
  ReturnValue = 0;

  SysClkHz = GetBoardSysClk ();
  ASSERT (SysClkHz != 0);
  PlatformClk = (SysClkHz * Rcw->SysPllRat) >> 1;

  switch (IpModule) {
    case IP_SYSCLK:
    case IP_USB_PHY:
      ReturnValue = SysClkHz;
      break;
    case IP_FLEX_SPI:
      ConfigRegister = MmioRead32 ( (UINTN)&GurBase->FlexSPICR1);
      ConfigRegister &= 0x3F; // FlexSPI_CLK_DIV bits in FlexSPI Control Register
      switch (ConfigRegister) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
	case 11:
	case 15:
          ReturnValue = (PlatformClk << 1) / (ConfigRegister + 1);
          break;
	case 16:
          ReturnValue = (PlatformClk << 1) / 20;
          break;
	case 17:
          ReturnValue = (PlatformClk << 1) / 24;
          break;
	case 18:
          ReturnValue = (PlatformClk << 1) / 28;
          break;
	case 19:
          ReturnValue = (PlatformClk << 1) / 32;
          break;
	case 20:
          ReturnValue = (PlatformClk << 1) / 80;
          break;
        default:
          break;
      }
      break;
    case IP_ESDHC:
      ReturnValue = PlatformClk >> 1;
      break;
    case IP_PL011:
      ReturnValue = PlatformClk >> 2;
      break;
    case IP_I2C:
      ReturnValue = PlatformClk >> 3;
      break;
    case IP_CPU:
      {
        CCSR_CLK_CLUSTER *ClkGrpA = (VOID *)FSL_CLK_GRPA_ADDR;
        CCSR_CLT_CTRL *ClkBase = (VOID *)PcdGet64 (PcdClkBaseAddr);
        UINT32 PllRatio = (MmioRead32 ((UINTN)&ClkGrpA->PllnGsr[0].Gsr) >> 1) & 0x3f;
        UINT32 CPllSel = (MmioRead32 ((UINTN)&ClkBase->ClkCnCsr[0].Csr) >> 27) & 0xf;
        STATIC CONST UINT8 CplxPllDivisor[8] = {
          [0] = 1, [1] = 2, [2] = 4, [4] = 1, [5] = 2, [6] = 4,
        };
        UINT8 Divisor = (CPllSel < 8) ? CplxPllDivisor[CPllSel] : 1;
        if (Divisor == 0) {
          Divisor = 1;
        }
        ReturnValue = (SysClkHz * PllRatio) / Divisor;
      }
      break;
    default:
      break;
  }

  return ReturnValue;
}

