#
#  Copyright (c) 2018, ARM Limited. All rights reserved.
#  Copyright 2020 NXP
#
#  SPDX-License-Identifier: BSD-2-Clause-Patent
#

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = NXPMmStandalone
  PLATFORM_GUID                  = A27A486E-D7B9-4D70-9F37-FED9ABE041A2
  PLATFORM_VERSION               = 1.0
  DSC_SPECIFICATION              = 0x00010011
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = DEBUG|RELEASE|NOOPT
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = Platform/NXP/StandAloneMm/StandaloneMm.fdf
  DEFINE DEBUG_MESSAGE           = TRUE

  # LzmaF86
  DEFINE COMPRESSION_TOOL_GUID   = D42AE6BD-1352-4bfb-909A-CA72A6EAE889

!include MdePkg/MdeLibs.dsc.inc

################################################################################
#
# Library Class section - list of all Library Classes needed by this Platform.
#
################################################################################
[LibraryClasses]
  ArmSvcLib|MdePkg/Library/ArmSvcLib/ArmSvcLib.inf
  ArmLib|ArmPkg/Library/ArmLib/ArmBaseLib.inf
  BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
!if $(TARGET) == RELEASE
  DebugLib|MdePkg/Library/BaseDebugLibNull/BaseDebugLibNull.inf
!else
  DebugLib|MdePkg/Library/BaseDebugLibSerialPort/BaseDebugLibSerialPort.inf
!endif
  DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
  ExtractGuidedSectionLib|StandaloneMmPkg/Library/StandaloneMmExtractGuidedSectionLib/StandaloneMmExtractGuidedSectionLib.inf
  FvLib|MdePkg/Library/FvLib/FvLib.inf
  HobLib|StandaloneMmPkg/Library/StandaloneMmCoreHobLib/StandaloneMmCoreHobLib.inf
  HobPrintLib|MdeModulePkg/Library/HobPrintLib/HobPrintLib.inf
  IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
  MemLib|StandaloneMmPkg/Library/StandaloneMmMemLib/StandaloneMmMemLib.inf
  MemoryAllocationLib|StandaloneMmPkg/Library/StandaloneMmCoreMemoryAllocationLib/StandaloneMmCoreMemoryAllocationLib.inf
  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  PeCoffLib|MdePkg/Library/BasePeCoffLib/BasePeCoffLib.inf
  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
  ReportStatusCodeLib|MdePkg/Library/BaseReportStatusCodeLibNull/BaseReportStatusCodeLibNull.inf
  RngLib|MdePkg/Library/BaseRngLibTimerLib/BaseRngLibTimerLib.inf
  SafeIntLib|MdePkg/Library/BaseSafeIntLib/BaseSafeIntLib.inf
  PerformanceLib|MdePkg/Library/BasePerformanceLibNull/BasePerformanceLibNull.inf
  ImagePropertiesRecordLib|MdeModulePkg/Library/ImagePropertiesRecordLib/ImagePropertiesRecordLib.inf
  StackCheckLib|MdePkg/Library/StackCheckLibNull/StackCheckLibNull.inf
  PeCoffGetEntryPointLib|MdePkg/Library/BasePeCoffGetEntryPointLib/BasePeCoffGetEntryPointLib.inf
  VariableFlashInfoLib|MdeModulePkg/Library/BaseVariableFlashInfoLib/BaseVariableFlashInfoLib.inf
  ArmSmcLib|MdePkg/Library/ArmSmcLib/ArmSmcLib.inf
  ArmFfaLib|MdeModulePkg/Library/ArmFfaLib/ArmFfaStandaloneMmCoreLib.inf
  MmServicesTableLib|MdePkg/Library/StandaloneMmServicesTableLib/StandaloneMmServicesTableLib.inf

  #
  # Entry point
  #
  ArmTransferListLib|ArmPkg/Library/ArmTransferListLib/ArmTransferListLib.inf
  StandaloneMmCoreEntryPoint|ArmPkg/Library/ArmStandaloneMmCoreEntryPoint/ArmStandaloneMmCoreEntryPoint.inf
  StandaloneMmDriverEntryPoint|MdePkg/Library/StandaloneMmDriverEntryPoint/StandaloneMmDriverEntryPoint.inf

  StandaloneMmMmuLib|ArmPkg/Library/StandaloneMmMmuLib/ArmMmuStandaloneMmLib.inf
  # CacheMaintenanceLib|ArmPkg/Library/ArmCacheMaintenanceLib/ArmCacheMaintenanceLib.inf
  CacheMaintenanceLib|MdePkg/Library/BaseCacheMaintenanceLibNull/BaseCacheMaintenanceLibNull.inf
  PeCoffExtraActionLib|StandaloneMmPkg/Library/StandaloneMmPeCoffExtraActionLib/StandaloneMmPeCoffExtraActionLib.inf

  # ARM PL011 UART Driver
!if $(TARGET) != RELEASE
  PL011UartClockLib|ArmPlatformPkg/Library/PL011UartClockLib/PL011UartClockLib.inf
  PL011UartLib|ArmPlatformPkg/Library/PL011UartLib/PL011UartLib.inf
  SerialPortLib|ArmPlatformPkg/Library/PL011SerialPortLib/PL011SerialPortLib.inf
!endif

  #
  # It is not possible to prevent the ARM compiler for generic intrinsic functions.
  # This library provides the intrinsic functions generate by a given compiler.
  # NULL means link this library into all ARM images.
  #
  NULL|MdePkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib.inf

  SocClockLib|Silicon/NXP/LX2160A/Library/SocClockLib/SocClockLib.inf
  I2cLib|Silicon/NXP/Library/I2cLib/I2cLib.inf

[LibraryClasses.common.MM_STANDALONE]
  HobLib|StandaloneMmPkg/Library/StandaloneMmHobLib/StandaloneMmHobLib.inf
  MemoryAllocationLib|StandaloneMmPkg/Library/StandaloneMmMemoryAllocationLib/StandaloneMmMemoryAllocationLib.inf
  BoardInfoLib|Platform/SolidRun/LX2160aCex7/Library/BoardInfoLib/BoardInfoLib.inf

  NULL|MdePkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib.inf

  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf
  OpensslLib|CryptoPkg/Library/OpensslLib/OpensslLib.inf
  TlsLib|CryptoPkg/Library/TlsLib/TlsLib.inf
  IntrinsicLib|CryptoPkg/Library/IntrinsicLib/IntrinsicLib.inf
  PlatformSecureLib|SecurityPkg/Library/PlatformSecureLibNull/PlatformSecureLibNull.inf
  SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf
  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLib/ArmGenericTimerPhyCounterLib.inf
  TimerLib|ArmPkg/Library/ArmArchTimerLib/ArmArchTimerLib.inf
 #  TimerLib|MdePkg/Library/BaseTimerLibNullTemplate/BaseTimerLibNullTemplate.inf
################################################################################
#
# Pcd Section - list of all EDK II PCD Entries defined by this Platform
#
################################################################################
[PcdsFixedAtBuild]
  gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x80000000
  gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0xff
  gEfiMdePkgTokenSpaceGuid.PcdReportStatusCodePropertyMask|0x0f

  #Secure Storage
  gEfiSecurityPkgTokenSpaceGuid.PcdUserPhysicalPresence|TRUE
  gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
  gEfiMdeModulePkgTokenSpaceGuid.PcdMaxAuthVariableSize|0x2800

  gNxpQoriqLsTokenSpaceGuid.PcdGutsBaseAddr|0x41000000

  gNxpQoriqLsTokenSpaceGuid.PcdI2c5BaseAddr|0x41001000
  gNxpQoriqLsTokenSpaceGuid.PcdI2cSize|0x10000
  gNxpQoriqLsTokenSpaceGuid.PcdNumI2cController|8

  ## PL011 - Serial Terminal
  gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase|0x41002000
  gEfiMdePkgTokenSpaceGuid.PcdUartDefaultBaudRate|115200
  gArmPlatformTokenSpaceGuid.PL011UartClkInHz|175000000
  gEfiMdePkgTokenSpaceGuid.PcdUartDefaultReceiveFifoDepth|0

  gNxpQoriqLsTokenSpaceGuid.PcdI2cBus|4
  gNxpQoriqLsTokenSpaceGuid.PcdI2cSpeed|400000
  gNxpQoriqLsTokenSpaceGuid.PcdI2cSlaveAddress|0x51

  ## FFA conduit: SP runs at S-EL0 under OP-TEE, must use SVC not SMC
  gEfiMdeModulePkgTokenSpaceGuid.PcdFfaLibConduitSmc|FALSE

  ## BFV is loaded into RAM by OP-TEE's stmm_sp.c, no shadow copy needed
  gStandaloneMmPkgTokenSpaceGuid.PcdShadowBfv|FALSE

[PcdsFeatureFlag]
  gNxpQoriqLsTokenSpaceGuid.PcdI2cErratumA009203|TRUE

[PcdsPatchableInModule]
  # Allocated memory for EDK2 uppers layers
  gEfiMdeModulePkgTokenSpaceGuid.PcdFlashNvStorageVariableBase|0x0
  gEfiMdeModulePkgTokenSpaceGuid.PcdFlashNvStorageVariableSize|0x00010000
  gEfiMdeModulePkgTokenSpaceGuid.PcdFlashNvStorageFtwWorkingBase|0x0
  gEfiMdeModulePkgTokenSpaceGuid.PcdFlashNvStorageFtwWorkingSize|0x00010000
  gEfiMdeModulePkgTokenSpaceGuid.PcdFlashNvStorageFtwSpareBase|0x0
  gEfiMdeModulePkgTokenSpaceGuid.PcdFlashNvStorageFtwSpareSize|0x00010000
  gEfiMdeModulePkgTokenSpaceGuid.PcdVariableStoreSize|0x00010000

###################################################################################################
#
# Components Section - list of the modules and components that will be processed by compilation
#                      tools and the EDK II tools to generate PE32/PE32+/Coff image files.
#
# Note: The EDK II DSC file is not used to specify how compiled binary images get placed
#       into firmware volume images. This section is just a list of modules to compile from
#       source into UEFI-compliant binaries.
#       It is the FDF file that contains information on combining binary files into firmware
#       volume images, whose concept is beyond UEFI and is described in PI specification.
#       Binary modules do not need to be listed in this section, as they should be
#       specified in the FDF file. For example: Shell binary (Shell_Full.efi), FAT binary (Fat.efi),
#       Logo (Logo.bmp), and etc.
#       There may also be modules listed in this section that are not required in the FDF file,
#       When a module listed here is excluded from FDF file, then UEFI-compliant binary will be
#       generated for it, but the binary will not be put into any firmware volume.
#
###################################################################################################
[Components.common]
  #
  # Standalone MM components
  #
  StandaloneMmPkg/Core/StandaloneMmCore.inf {
    <LibraryClasses>
      ExtractGuidedSectionLib|StandaloneMmPkg/Library/StandaloneMmExtractGuidedSectionLib/StandaloneMmExtractGuidedSectionLib.inf
      NULL|MdeModulePkg/Library/LzmaCustomDecompressLib/LzmaCustomDecompressLib.inf
    <PcdsFixedAtBuild>
      gEfiMdePkgTokenSpaceGuid.PcdMaximumGuidedExtractHandler|0x2
  }

  ArmPkg/Drivers/StandaloneMmCpu/StandaloneMmCpu.inf
  Silicon/NXP/Drivers/I2cMm/I2cMm.inf
  Silicon/NXP/Drivers/RtcMm/RtcMm.inf
  Silicon/NXP/Drivers/EepromFvb/EepromFvb.inf
  MdeModulePkg/Universal/FaultTolerantWriteDxe/FaultTolerantWriteStandaloneMm.inf {
    <LibraryClasses>
      NULL|Silicon/NXP/Drivers/EepromFvb/FixupPcd.inf
  }
  MdeModulePkg/Universal/Variable/RuntimeDxe/VariableStandaloneMm.inf {
    <LibraryClasses>
      AuthVariableLib|SecurityPkg/Library/AuthVariableLib/AuthVariableLib.inf
      BaseCryptLib|CryptoPkg/Library/BaseCryptLib/SmmCryptLib.inf
      DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLibBase.inf
      VarCheckLib|MdeModulePkg/Library/VarCheckLib/VarCheckLib.inf
      NULL|MdeModulePkg/Library/VarCheckUefiLib/VarCheckUefiLib.inf
      NULL|MdeModulePkg/Library/VarCheckPolicyLib/VarCheckPolicyLibStandaloneMm.inf
      NULL|Silicon/NXP/Drivers/EepromFvb/FixupPcd.inf
      VariablePolicyLib|MdeModulePkg/Library/VariablePolicyLib/VariablePolicyLib.inf
      VariablePolicyHelperLib|MdeModulePkg/Library/VariablePolicyHelperLib/VariablePolicyHelperLib.inf
  }

###################################################################################################
#
# BuildOptions Section - Define the module specific tool chain flags that should be used as
#                        the default flags for a module. These flags are appended to any
#                        standard flags that are defined by the build process. They can be
#                        applied for any modules or only those modules with the specific
#                        module style (EDK or EDKII) specified in [Components] section.
#
###################################################################################################
[BuildOptions.common.EDKII.MM_STANDALONE, BuildOptions.common.EDKII.MM_CORE_STANDALONE]
GCC:*_*_*_CC_FLAGS = -mstrict-align -mgeneral-regs-only
GCC:*_*_*_DLINK_FLAGS = -z common-page-size=0x1000
