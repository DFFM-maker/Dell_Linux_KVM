# Report Hardware – fedora
_Generated on Sun Nov 23 08:33:44 AM CET 2025_

## CPU
```
Architecture:                            x86_64
CPU op-mode(s):                          32-bit, 64-bit
Address sizes:                           39 bits physical, 48 bits virtual
Byte Order:                              Little Endian
CPU(s):                                  16
On-line CPU(s) list:                     0-15
Vendor ID:                               GenuineIntel
Model name:                              Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz
CPU family:                              6
Model:                                   165
Thread(s) per core:                      2
Core(s) per socket:                      8
Socket(s):                               1
Stepping:                                2
CPU(s) scaling MHz:                      17%
CPU max MHz:                             5300.0000
CPU min MHz:                             800.0000
BogoMIPS:                                4800.00
Flags:                                   fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi pku ospke md_clear flush_l1d arch_capabilities
Virtualization:                          VT-x
L1d cache:                               256 KiB (8 instances)
L1i cache:                               256 KiB (8 instances)
L2 cache:                                2 MiB (8 instances)
L3 cache:                                16 MiB (1 instance)
NUMA node(s):                            1
NUMA node0 CPU(s):                       0-15
Vulnerability Gather data sampling:      Mitigation; Microcode
Vulnerability Ghostwrite:                Not affected
Vulnerability Indirect target selection: Mitigation; Aligned branch/return thunks
Vulnerability Itlb multihit:             KVM: Mitigation: Split huge pages
Vulnerability L1tf:                      Not affected
Vulnerability Mds:                       Not affected
Vulnerability Meltdown:                  Not affected
Vulnerability Mmio stale data:           Mitigation; Clear CPU buffers; SMT vulnerable
Vulnerability Old microcode:             Not affected
Vulnerability Reg file data sampling:    Not affected
Vulnerability Retbleed:                  Mitigation; Enhanced IBRS
Vulnerability Spec rstack overflow:      Not affected
Vulnerability Spec store bypass:         Mitigation; Speculative Store Bypass disabled via prctl
Vulnerability Spectre v1:                Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:                Mitigation; Enhanced / Automatic IBRS; IBPB conditional; PBRSB-eIBRS SW sequence; BHI SW loop, KVM SW loop
Vulnerability Srbds:                     Mitigation; Microcode
Vulnerability Tsa:                       Not affected
Vulnerability Tsx async abort:           Not affected
Vulnerability Vmscape:                   Mitigation; IBPB before exit to userspace
```

## GPU
```
00:02.0 VGA compatible controller: Intel Corporation CometLake-H GT2 [UHD Graphics] (rev 05)
01:00.0 VGA compatible controller: NVIDIA Corporation TU117GLM [Quadro T1000 Mobile] (rev a1)
```

## RAM – Dettagli
```
# dmidecode 3.6
Getting SMBIOS data from sysfs.
SMBIOS 3.2.0 present.

Handle 0x001C, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 128 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x001D, DMI type 17, 84 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM A
	Bank Locator: Not Specified
	Type: Unknown
	Type Detail: None

Handle 0x001E, DMI type 17, 84 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM A
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: 3200 MT/s
	Manufacturer: 80CE000080CE
	Serial Number: 209A372E
	Asset Tag: 03212800
	Part Number: M471A2G43AB2-CWE    
	Rank: 1
	Configured Memory Speed: 2933 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Not Specified
	Module Manufacturer ID: Bank 1, Hex 0xCE
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 16 GB
	Cache Size: None
	Logical Size: None

Handle 0x001F, DMI type 17, 84 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM B
	Bank Locator: Not Specified
	Type: Unknown
	Type Detail: None

Handle 0x0020, DMI type 17, 84 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM C
	Bank Locator: Not Specified
	Type: DDR4
	Type Detail: Synchronous
	Speed: 3200 MT/s
	Manufacturer: 80CE000080CE
	Serial Number: 209A3801
	Asset Tag: 03212800
	Part Number: M471A2G43AB2-CWE    
	Rank: 1
	Configured Memory Speed: 2933 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Not Specified
	Module Manufacturer ID: Bank 1, Hex 0xCE
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 16 GB
	Cache Size: None
	Logical Size: None

```

## RAM – Utilizzo
```
               total        used        free      shared  buff/cache   available
Mem:            30Gi       5.6Gi        19Gi       974Mi       7.4Gi        25Gi
Swap:          8.0Gi          0B       8.0Gi
```

## Dischi
### Layout
```
NAME          SIZE MODEL                    TYPE MOUNTPOINT
zram0           8G                          disk [SWAP]
nvme0n1     953.9G PC601A NVMe SK hynix 1TB disk 
├─nvme0n1p1   600M                          part /boot/efi
├─nvme0n1p2     2G                          part /boot
└─nvme0n1p3 951.3G                          part /home
```

### SMART
#### /dev/nvme0n1
```
smartctl 7.5 2025-04-30 r5714 [x86_64-linux-6.17.8-300.fc43.x86_64] (local build)
Copyright (C) 2002-25, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

```

## PCI
```
00:00.0 Host bridge: Intel Corporation 10th Gen Core Processor Host Bridge/DRAM Registers (rev 02)
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 1
	Capabilities: <access denied>
	Kernel driver in use: skl_uncore

00:01.0 PCI bridge: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) (rev 02) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 123
	IOMMU group: 2
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 3000-3fff [size=4K] [16-bit]
	Memory behind bridge: b3000000-b40fffff [size=17M] [32-bit]
	Prefetchable memory behind bridge: 70000000-81ffffff [size=288M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation CometLake-H GT2 [UHD Graphics] (rev 05) (prog-if 00 [VGA controller])
	DeviceName: Onboard - Video
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 179
	IOMMU group: 0
	Region 0: Memory at 604a000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at 4000000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 4000 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 02)
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 3
	Region 0: Memory at 604b110000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: <access denied>
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device_pci_legacy

00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	IOMMU group: 4
	Region 0: Memory at 604b12a000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <access denied>

00:12.0 Signal processing controller: Intel Corporation Comet Lake PCH Thermal Controller
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 5
	Region 0: Memory at 604b129000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:13.0 Serial controller: Intel Corporation Comet Lake PCH Integrated Sensor Solution (prog-if 00 [8250])
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	IOMMU group: 6
	Region 0: Memory at 604b122000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: <access denied>
	Kernel driver in use: intel_ish_ipc
	Kernel modules: intel_ish_ipc

00:14.0 USB controller: Intel Corporation Comet Lake USB 3.1 xHCI Host Controller (prog-if 30 [XHCI])
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 129
	IOMMU group: 7
	Region 0: Memory at 604b100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: xhci_hcd

00:14.2 RAM memory: Intel Corporation Comet Lake PCH Shared SRAM
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7
	Region 0: Memory at 604b120000 (64-bit, non-prefetchable) [disabled] [size=8K]
	Region 2: Memory at 604b128000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <access denied>

00:14.3 Network controller: Intel Corporation Comet Lake PCH CNVi WiFi
	DeviceName: Onboard - Ethernet
	Subsystem: Intel Corporation Device 4070
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 8
	Region 0: Memory at 604b11c000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

00:15.0 Serial bus controller: Intel Corporation Comet Lake PCH Serial IO I2C Controller #0
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 9
	Region 0: Memory at 4010000000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss

00:15.1 Serial bus controller: Intel Corporation Comet Lake PCH Serial IO I2C Controller #1
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	IOMMU group: 9
	Region 0: Memory at 4010001000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss

00:16.0 Communication controller: Intel Corporation Comet Lake HECI Controller
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 180
	IOMMU group: 10
	Region 0: Memory at 604b125000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:1b.0 PCI bridge: Intel Corporation Comet Lake PCI Express Root Port #21 (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 124
	IOMMU group: 11
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: b4200000-b42fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.0 PCI bridge: Intel Corporation Comet Lake PCIe Root Port #1 (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 125
	IOMMU group: 12
	Bus: primary=00, secondary=03, subordinate=6d, sec-latency=0
	I/O behind bridge: 5000-7fff [size=12K] [16-bit]
	Memory behind bridge: 84000000-b20fffff [size=737M] [32-bit]
	Prefetchable memory behind bridge: 6000000000-6049ffffff [size=1184M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation Comet Lake PCIe Port #6 (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 126
	IOMMU group: 13
	Bus: primary=00, secondary=6e, subordinate=6e, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: b4100000-b41fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation WM490 Chipset LPC/eSPI Controller
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 14

00:1f.3 Audio device: Intel Corporation Comet Lake PCH cAVS (prog-if 80)
	DeviceName: Onboard - Sound
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 201
	IOMMU group: 14
	Region 0: Memory at 604b118000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at 604b000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_soc_avs, snd_sof_pci_intel_cnl, snd_hda_intel

00:1f.4 SMBus: Intel Corporation Comet Lake PCH SMBus Controller
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 14
	Region 0: Memory at 604b124000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Serial bus controller: Intel Corporation Comet Lake PCH SPI Controller
	DeviceName: Onboard - Other
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 14
	Region 0: Memory at fe010000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (11) I219-LM
	DeviceName: Onboard - Ethernet
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 181
	IOMMU group: 14
	Region 0: Memory at b4300000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: e1000e
	Kernel modules: e1000e

01:00.0 VGA compatible controller: NVIDIA Corporation TU117GLM [Quadro T1000 Mobile] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 200
	IOMMU group: 2
	Region 0: Memory at b3000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at 70000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at 80000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at 3000 [size=128]
	Expansion ROM at b4000000 [virtual] [disabled] [size=512K]
	Capabilities: <access denied>
	Kernel driver in use: nvidia
	Kernel modules: nouveau, nvidia_drm, nvidia

01:00.1 Audio device: NVIDIA Corporation Device 10fa (rev a1)
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	IOMMU group: 2
	Region 0: Memory at b4080000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

02:00.0 Non-Volatile memory controller: SK hynix PC601 NVMe Solid State Drive (prog-if 02 [NVM Express])
	Subsystem: SK hynix PC601 NVMe Solid State Drive
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 15
	Region 0: Memory at b4200000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at b4205000 (32-bit, non-prefetchable) [size=4K]
	Region 3: Memory at b4204000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: nvme
	Kernel modules: nvme

03:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Physical Slot: 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 16
	Bus: primary=03, secondary=04, subordinate=6d, sec-latency=0
	I/O behind bridge: 5000-6fff [size=8K] [16-bit]
	Memory behind bridge: 84000000-b20fffff [size=737M] [32-bit]
	Prefetchable memory behind bridge: 6000000000-6049ffffff [size=1184M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 17
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: b2000000-b20fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

04:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 127
	IOMMU group: 18
	Bus: primary=04, secondary=06, subordinate=38, sec-latency=0
	I/O behind bridge: 5000-5fff [size=4K] [16-bit]
	Memory behind bridge: 84000000-9befffff [size=383M] [32-bit]
	Prefetchable memory behind bridge: 6000000000-601fffffff [size=512M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

04:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 18
	IOMMU group: 19
	Bus: primary=04, secondary=39, subordinate=39, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: 9bf00000-9bffffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

04:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 128
	IOMMU group: 20
	Bus: primary=04, secondary=3a, subordinate=6d, sec-latency=0
	I/O behind bridge: 6000-6fff [size=4K] [16-bit]
	Memory behind bridge: 9c000000-b1ffffff [size=352M] [32-bit]
	Prefetchable memory behind bridge: 6020000000-6049ffffff [size=672M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

05:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 21
	Region 0: Memory at b2000000 (32-bit, non-prefetchable) [size=256K]
	Region 1: Memory at b2040000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: thunderbolt
	Kernel modules: thunderbolt

39:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06) (prog-if 30 [XHCI])
	Subsystem: Dell Device 09c3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 137
	IOMMU group: 22
	Region 0: Memory at 9bf00000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: xhci_hcd

6e:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5260 PCI Express Card Reader (rev 01)
	Subsystem: Dell Device 09c3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 145
	IOMMU group: 23
	Region 0: Memory at b4100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: rtsx_pci
	Kernel modules: rtsx_pci

```

## USB
```
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 0a5c:5843 Broadcom Corp. BCM58200 ControlVault 3 (FingerPrint sensor + Contacted SmartCard)
Bus 001 Device 003: ID 1bcf:28c4 Sunplus Innovation Technology Inc. Integrated_Webcam_HD
Bus 001 Device 004: ID 8087:0026 Intel Corp. AX201 Bluetooth
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
```

## Rete
### Interfacce
```
lo               UNKNOWN        127.0.0.1/8 ::1/128 
eno2             DOWN           
wlo1             UP             192.168.1.43/24 fe80::af95:8bc3:21c3:7cd3/64 
br0              DOWN           
```

### Hardware di rete
```
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (11) I219-LM
```

## Temperature (se presenti sensori)
```
sensori non disponibili
```

## Batteria
```
  native-path:          BAT0
  vendor:               SMP
  model:                DELL 17C0611
  serial:               2269
  power supply:         yes
  updated:              Sun 23 Nov 2025 08:33:44 AM CET (1 seconds ago)
  has history:          yes
  has statistics:       yes
  battery
    present:             yes
    rechargeable:        yes
    state:               fully-charged
    warning-level:       none
    energy:              45.2352 Wh
    energy-empty:        0 Wh
    energy-full:         45.2352 Wh
    energy-full-design:  68.001 Wh
    voltage-min-design:  11.4 V
    capacity-level:      Full
    energy-rate:         0.0114 W
    voltage:             12.022 V
    charge-cycles:       N/A
    time to empty:       165.3 days
    percentage:          100%
    capacity:            66.5214%
    technology:          lithium-polymer
    charge-start-threshold:        75%
    charge-end-threshold:          80%
    charge-threshold-supported:    yes
    icon-name:          'battery-full-charged-symbolic'

```

## Thunderbolt
```
```
