# Report Software – fedora
_Generated on Sun Nov 23 08:38:07 AM CET 2025_

## Sistema operativo
```
NAME="Fedora Linux"
VERSION="43 (Workstation Edition)"
RELEASE_TYPE=stable
ID=fedora
VERSION_ID=43
VERSION_CODENAME=""
PRETTY_NAME="Fedora Linux 43 (Workstation Edition)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:43"
DEFAULT_HOSTNAME="fedora"
HOME_URL="https://fedoraproject.org/"
DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora/f43/"
SUPPORT_URL="https://ask.fedoraproject.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=43
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=43
SUPPORT_END=2026-12-02
VARIANT="Workstation Edition"
VARIANT_ID=workstation
```

## Kernel
```
Linux fedora 6.17.8-300.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Nov 14 01:47:12 UTC 2025 x86_64 GNU/Linux

libreport-plugin-kerneloops-2.17.15-9.fc43.x86_64
kernel-core-6.17.1-300.fc43.x86_64
kernel-modules-core-6.17.1-300.fc43.x86_64
kernel-modules-6.17.1-300.fc43.x86_64
kernel-modules-extra-6.17.1-300.fc43.x86_64
abrt-addon-kerneloops-2.17.7-1.fc43.x86_64
kernel-6.17.1-300.fc43.x86_64
kernel-tools-libs-6.17.8-300.fc43.x86_64
kernel-core-6.17.8-300.fc43.x86_64
kernel-modules-core-6.17.8-300.fc43.x86_64
kernel-modules-6.17.8-300.fc43.x86_64
kernel-modules-extra-6.17.8-300.fc43.x86_64
kernel-6.17.8-300.fc43.x86_64
kernel-tools-6.17.8-300.fc43.x86_64
kernel-headers-6.17.4-300.fc43.x86_64
kernel-devel-6.17.8-300.fc43.x86_64
kernel-devel-matched-6.17.8-300.fc43.x86_64
kernel-srpm-macros-1.0-27.fc43.noarch
```

## FileSystem
### Mount attivi
```
bpf on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate,memory_recursiveprot)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime,seclabel)
/dev/nvme0n1p1 on /boot/efi type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=ascii,shortname=winnt,errors=remount-ro)
/dev/nvme0n1p2 on /boot type ext4 (rw,relatime,seclabel)
/dev/nvme0n1p3 on /home type btrfs (rw,relatime,seclabel,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=257,subvol=/home)
/dev/nvme0n1p3 on / type btrfs (rw,relatime,seclabel,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/root)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,seclabel,gid=5,mode=600,ptmxmode=000)
devtmpfs on /dev type devtmpfs (rw,nosuid,seclabel,size=16160144k,nr_inodes=4040036,mode=755,inode64)
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
gvfsd-fuse on /run/user/1000/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,relatime,user_id=1000,group_id=1000)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,nosuid,nodev,relatime,seclabel,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime,seclabel)
none on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime,seclabel)
portal on /run/user/1000/doc type fuse.portal (rw,nosuid,nodev,relatime,user_id=1000,group_id=1000)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
selinuxfs on /sys/fs/selinux type selinuxfs (rw,nosuid,noexec,relatime)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime,seclabel)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=42,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=7733)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,seclabel,inode64,usrquota)
tmpfs on /run/credentials/systemd-journald.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,inode64,noswap)
tmpfs on /run/credentials/systemd-resolved.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,inode64,noswap)
tmpfs on /run type tmpfs (rw,nosuid,nodev,seclabel,size=6495184k,nr_inodes=819200,mode=755,inode64)
tmpfs on /run/user/0 type tmpfs (rw,nosuid,nodev,relatime,seclabel,size=3247588k,nr_inodes=811897,mode=700,inode64)
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,seclabel,size=3247588k,nr_inodes=811897,mode=700,uid=1000,gid=1000,inode64)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,seclabel,size=16237956k,nr_inodes=1048576,inode64,usrquota)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime,seclabel)
```

### /etc/fstab
```

#
# /etc/fstab
# Created by anaconda on Sat Nov 22 06:11:13 2025
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
UUID=6126682e-d557-4b88-aa42-a47de5554b0d / btrfs subvol=root,compress=zstd:1 0 0
UUID=84392aeb-bcf2-4c65-bd95-d51ae2b876c2 /boot ext4 defaults 1 2
UUID=3BF9-3BC3 /boot/efi vfat umask=0077,shortname=winnt 0 2
UUID=6126682e-d557-4b88-aa42-a47de5554b0d /home btrfs subvol=home,compress=zstd:1 0 0
```

## Driver GPU in uso
```
00:02.0 VGA compatible controller [0300]: Intel Corporation CometLake-H GT2 [UHD Graphics] [8086:9bc4] (rev 05)
	DeviceName: Onboard - Video
	Subsystem: Dell Device [1028:09c3]
	Kernel driver in use: i915
--
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU117GLM [Quadro T1000 Mobile] [10de:1fb9] (rev a1)
	Subsystem: Dell Device [1028:09c3]
	Kernel driver in use: nvidia
	Kernel modules: nouveau, nvidia_drm, nvidia
```

## GPU assegnate all'host (driver attivi)
```
GPU 00:02.0
../../../bus/pci/drivers/i915

GPU 01:00.0
../../../../bus/pci/drivers/nvidia

```

## Moduli kernel attivi
```
ac97_bus               12288  1 snd_soc_core
acpi_pad              184320  0
acpi_thermal_rel       28672  1 int3400_thermal
bluetooth            1097728  36 btrtl,btmtk,btintel,btbcm,bnep,btusb,rfcomm
bnep                   36864  2
bridge                475136  0
btbcm                  24576  1 btusb
btintel                73728  1 btusb
btmtk                  32768  1 btusb
btrtl                  36864  1 btusb
btusb                  81920  0
cec                   106496  2 drm_display_helper,i915
cfg80211             1531904  3 iwlmvm,iwlwifi,mac80211
coretemp               24576  0
crc8                   12288  1 soundwire_cadence
dcdbas                 24576  1 dell_smbios
dell_laptop            45056  0
dell_pc                12288  0
dell_rbtn              20480  0
dell_smbios            36864  3 dell_wmi,dell_pc,dell_laptop
dell_smm_hwmon         28672  0
dell_wmi               32768  1 dell_laptop
dell_wmi_descriptor    20480  2 dell_wmi,dell_smbios
dell_wmi_sysman        61440  0
drm_buddy              32768  1 i915
drm_display_helper    331776  1 i915
drm_ttm_helper         16384  1 nvidia_drm
e1000e                393216  0
ee1004                 16384  0
fat                   126976  1 vfat
firmware_attributes_class    12288  1 dell_wmi_sysman
fuse                  278528  5
ghash_clmulni_intel    12288  0
hid_logitech_hidpp     81920  0
hid_multitouch         36864  0
hid_sensor_gyro_3d     20480  0
hid_sensor_hub         32768  3 hid_sensor_gyro_3d,hid_sensor_trigger,hid_sensor_iio_common
hid_sensor_iio_common    24576  2 hid_sensor_gyro_3d,hid_sensor_trigger
hid_sensor_trigger     20480  2 hid_sensor_gyro_3d
i2c_algo_bit           20480  1 i915
i2c_dev                28672  0
i2c_hid                49152  1 i2c_hid_acpi
i2c_hid_acpi           12288  0
i2c_i801               40960  0
i2c_smbus              20480  1 i2c_i801
i915                 5373952  51
idma64                 20480  0
industrialio          155648  4 industrialio_triggered_buffer,hid_sensor_gyro_3d,hid_sensor_trigger,kfifo_buf
industrialio_triggered_buffer    12288  1 hid_sensor_trigger
int3400_thermal        24576  0
int3403_thermal        16384  0
int340x_thermal_zone    16384  2 int3403_thermal,processor_thermal_device
intel_cstate           20480  0
intel_hid              28672  0
intel_ish_ipc          40960  0
intel_ishtp            86016  2 intel_ishtp_hid,intel_ish_ipc
intel_ishtp_hid        36864  0
intel_oc_wdt           12288  0
intel_pch_thermal      20480  0
intel_pmc_bxt          16384  1 iTCO_wdt
intel_pmc_core        147456  0
intel_pmc_ssram_telemetry    16384  1 intel_pmc_core
intel_powerclamp       24576  0
intel_rapl_common      61440  2 intel_rapl_msr,processor_thermal_rapl
intel_rapl_msr         20480  0
intel_soc_dts_iosf     16384  1 processor_thermal_device_pci_legacy
intel_tcc_cooling      12288  0
intel_uncore          282624  0
intel_uncore_frequency    12288  0
intel_uncore_frequency_common    16384  1 intel_uncore_frequency
intel_vsec             28672  2 intel_pmc_ssram_telemetry,pmt_telemetry
intel_wmi_thunderbolt    16384  0
irqbypass              16384  1 kvm
iTCO_vendor_support    12288  1 iTCO_wdt
iTCO_wdt               16384  0
iwlmvm                925696  0
iwlwifi               589824  1 iwlmvm
joydev                 36864  0
kfifo_buf              12288  1 industrialio_triggered_buffer
kvm                  1490944  1 kvm_intel
kvm_intel             544768  0
libarc4                12288  1 mac80211
llc                    16384  2 bridge,stp
loop                   49152  0
lz4_compress           24576  1 zram
lz4hc_compress         20480  1 zram
mac80211             1949696  1 iwlmvm
mc                     94208  6 videodev,videobuf2_v4l2,uvcvideo,videobuf2_common
mei                   208896  7 mei_wdt,mei_hdcp,mei_pxp,mei_me
mei_hdcp               28672  0
mei_me                 57344  3
mei_pxp                20480  0
mei_wdt                16384  0
mmc_core              303104  1 rtsx_pci_sdmmc
Module                  Size  Used by
mtd                   110592  4 spi_nor
mxm_wmi                12288  0
nf_conntrack          212992  4 nf_nat,nft_ct,nf_conntrack_netbios_ns,nf_conntrack_broadcast
nf_conntrack_broadcast    12288  1 nf_conntrack_netbios_ns
nf_conntrack_netbios_ns    12288  1
nf_defrag_ipv4         12288  1 nf_conntrack
nf_defrag_ipv6         24576  1 nf_conntrack
nf_nat                 65536  1 nft_chain_nat
nfnetlink              20480  3 nf_tables
nf_reject_ipv4         12288  1 nft_reject_inet
nf_reject_ipv6         24576  1 nft_reject_inet
nf_tables             430080  429 nft_ct,nft_reject_inet,nft_fib_ipv6,nft_fib_ipv4,nft_chain_nat,nft_reject,nft_fib,nft_fib_inet
nft_chain_nat          12288  3
nft_ct                 28672  9
nft_fib                12288  3 nft_fib_ipv6,nft_fib_ipv4,nft_fib_inet
nft_fib_inet           12288  1
nft_fib_ipv4           12288  1 nft_fib_inet
nft_fib_ipv6           12288  1 nft_fib_inet
nft_reject             12288  1 nft_reject_inet
nft_reject_inet        12288  16
nvidia              15872000  65 nvidia_uvm,nvidia_modeset
nvidia_drm            159744  8
nvidia_modeset       2260992  5 nvidia_drm
nvidia_uvm           4079616  0
nvme                   73728  3
nvme_auth              32768  1 nvme_core
nvme_core             274432  4 nvme
nvme_keyring           20480  1 nvme_core
pcspkr                 12288  0
pinctrl_cannonlake     36864  0
platform_profile       20480  1 dell_pc
platform_temperature_control    20480  1 processor_thermal_device
pmt_class              20480  2 pmt_telemetry,pmt_discovery
pmt_discovery          20480  1 pmt_telemetry
pmt_telemetry          16384  1 intel_pmc_core
polyval_clmulni        12288  0
processor_thermal_device    24576  1 processor_thermal_device_pci_legacy
processor_thermal_device_pci_legacy    12288  0
processor_thermal_mbox    12288  4 processor_thermal_power_floor,processor_thermal_wt_req,processor_thermal_rfim,processor_thermal_wt_hint
processor_thermal_power_floor    12288  1 processor_thermal_device
processor_thermal_rapl    16384  1 processor_thermal_device
processor_thermal_rfim    49152  1 processor_thermal_device
processor_thermal_wt_hint    16384  1 processor_thermal_device
processor_thermal_wt_req    12288  1 processor_thermal_device
qrtr                   57344  2
rapl                   20480  0
rfcomm                110592  4
rfkill                 45056  11 iwlmvm,bluetooth,dell_laptop,dell_rbtn,cfg80211
rtsx_pci              143360  1 rtsx_pci_sdmmc
rtsx_pci_sdmmc         40960  0
serio_raw              20480  0
snd                   155648  26 snd_ctl_led,snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_hda_codec,snd_sof,snd_soc_sdca,snd_timer,snd_hda_codec_realtek_lib,snd_compress,snd_hda_codec_alc269,snd_soc_core,snd_pcm
snd_compress           28672  2 snd_soc_avs,snd_soc_core
snd_ctl_led            28672  0
snd_hda_codec         233472  11 snd_hda_codec_generic,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_codec_nvhdmi,snd_hda_codec_realtek_lib,snd_soc_hdac_hda,snd_hda_codec_alc269,snd_sof_intel_hda,snd_hda_codec_intelhdmi
snd_hda_codec_alc269   147456  1
snd_hda_codec_generic   139264  2 snd_hda_codec_realtek_lib,snd_hda_codec_alc269
snd_hda_codec_hdmi     65536  2 snd_hda_codec_nvhdmi,snd_hda_codec_intelhdmi
snd_hda_codec_intelhdmi    28672  1
snd_hda_codec_nvhdmi    16384  1
snd_hda_codec_realtek_lib    65536  1 snd_hda_codec_alc269
snd_hda_core          159744  13 snd_hda_codec_generic,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_ext_core,snd_hda_codec,snd_sof_intel_hda_common,snd_hda_codec_realtek_lib,snd_soc_hdac_hda,snd_hda_codec_alc269,snd_sof_intel_hda,snd_hda_codec_intelhdmi
snd_hda_ext_core       36864  7 snd_sof_intel_hda_sdw_bpt,snd_soc_avs,snd_soc_hda_codec,snd_sof_intel_hda_common,snd_soc_hdac_hda,snd_sof_intel_hda_mlink,snd_sof_intel_hda
snd_hda_intel          73728  4
snd_hda_scodec_component    20480  1 snd_hda_codec_alc269
snd_hrtimer            12288  1
snd_hwdep              24576  1 snd_hda_codec
snd_intel_dspcfg       45056  5 snd_soc_avs,snd_hda_intel,snd_sof,snd_sof_intel_hda_common,snd_sof_intel_hda_generic
snd_intel_sdw_acpi     16384  2 snd_intel_dspcfg,snd_sof_intel_hda_generic
snd_pcm               212992  14 snd_soc_avs,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,soundwire_intel,snd_sof,snd_soc_sdca,snd_sof_intel_hda_common,snd_compress,snd_sof_intel_hda_generic,snd_soc_core,snd_sof_utils,snd_hda_core,snd_pcm_dmaengine
snd_pcm_dmaengine      20480  1 snd_soc_core
snd_seq               135168  7 snd_seq_dummy
snd_seq_device         16384  1 snd_seq
snd_seq_dummy          12288  0
snd_soc_acpi           16384  2 snd_soc_acpi_intel_match,snd_sof_intel_hda_generic
snd_soc_acpi_intel_match   143360  2 snd_sof_intel_hda_generic,snd_sof_pci_intel_cnl
snd_soc_acpi_intel_sdca_quirks    12288  1 snd_soc_acpi_intel_match
snd_soc_avs           278528  0
snd_soc_core          491520  7 snd_soc_avs,snd_soc_hda_codec,soundwire_intel,snd_sof,snd_soc_sdca,snd_sof_intel_hda_common,snd_soc_hdac_hda
snd_soc_hdac_hda       24576  1 snd_sof_intel_hda_common
snd_soc_hda_codec      28672  1 snd_soc_avs
snd_soc_sdca          110592  2 snd_soc_acpi_intel_sdca_quirks,soundwire_bus
snd_sof               516096  6 snd_sof_intel_hda_sdw_bpt,snd_sof_pci,snd_sof_intel_hda_common,snd_sof_intel_hda_generic,snd_sof_intel_hda,snd_sof_pci_intel_cnl
snd_sof_intel_hda      20480  2 snd_sof_intel_hda_common,snd_sof_intel_hda_generic
snd_sof_intel_hda_common   221184  3 snd_sof_intel_hda_sdw_bpt,snd_sof_intel_hda_generic,snd_sof_pci_intel_cnl
snd_sof_intel_hda_generic    45056  1 snd_sof_pci_intel_cnl
snd_sof_intel_hda_mlink    49152  4 snd_sof_intel_hda_sdw_bpt,soundwire_intel,snd_sof_intel_hda_common,snd_sof_intel_hda_generic
snd_sof_intel_hda_sdw_bpt    24576  1 soundwire_intel
snd_sof_pci            24576  2 snd_sof_intel_hda_generic,snd_sof_pci_intel_cnl
snd_sof_pci_intel_cnl    20480  0
snd_sof_utils          16384  1 snd_sof
snd_sof_xtensa_dsp     16384  1 snd_sof_intel_hda_generic
snd_timer              57344  3 snd_seq,snd_hrtimer,snd_pcm
soundcore              12288  2 snd_ctl_led,snd
soundwire_bus        1212416  3 soundwire_intel,soundwire_generic_allocation,soundwire_cadence
soundwire_cadence      57344  1 soundwire_intel
soundwire_generic_allocation    24576  1 soundwire_intel
soundwire_intel        98304  1 snd_sof_intel_hda_generic
sparse_keymap          12288  2 intel_hid,dell_wmi
spi_intel              36864  1 spi_intel_pci
spi_intel_pci          12288  1
spi_nor               184320  1
stp                    12288  1 bridge
sunrpc                921600  1
thunderbolt           602112  1 typec
ttm                   135168  2 drm_ttm_helper,i915
typec                 118784  1 typec_ucsi
typec_ucsi             77824  1 ucsi_acpi
ucsi_acpi              12288  0
uhid                   28672  1
uinput                 32768  0
uvc                    12288  1 uvcvideo
uvcvideo              192512  2
vfat                   24576  1
video                  81920  4 dell_wmi,dell_laptop,i915,nvidia_modeset
videobuf2_common      102400  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
videobuf2_memops       16384  1 videobuf2_vmalloc
videobuf2_v4l2         40960  1 uvcvideo
videobuf2_vmalloc      20480  1 uvcvideo
videodev              421888  2 videobuf2_v4l2,uvcvideo
wmi                    32768  9 dell_wmi_sysman,video,intel_wmi_thunderbolt,dell_wmi,wmi_bmof,dell_smm_hwmon,dell_smbios,dell_wmi_descriptor,mxm_wmi
wmi_bmof               12288  0
x86_pkg_temp_thermal    16384  0
zram                   73728  1
```

## Virtualizzazione (KVM/QEMU)
```
inactive

 Id   Name   State
--------------------


CPU flags:
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi pku ospke md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple shadow_vmcs pml ept_violation_ve ept_mode_based_exec
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi pku ospke md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple shadow_vmcs pml ept_violation_ve ept_mode_based_exec
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi pku ospke md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple shadow_vmcs pml ept_violation_ve ept_mode_based_exec
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi pku ospke md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple shadow_vmcs pml ept_violation_ve ept_mode_based_exec
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi pku ospke md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple shadow_vmcs pml ept_violation_ve ept_mode_based_exec

```

## GPU assegnate a KVM (PCI passthrough)
```
pci_0000_00_00_0
pci_0000_00_01_0
pci_0000_00_02_0
pci_0000_00_04_0
pci_0000_00_08_0
pci_0000_00_12_0
pci_0000_00_13_0
pci_0000_00_14_0
pci_0000_00_14_2
pci_0000_00_14_3
pci_0000_00_15_0
pci_0000_00_15_1
pci_0000_00_16_0
pci_0000_00_1b_0
pci_0000_00_1c_0
pci_0000_00_1c_5
pci_0000_00_1f_0
pci_0000_00_1f_3
pci_0000_00_1f_4
pci_0000_00_1f_5
pci_0000_00_1f_6
pci_0000_01_00_0
pci_0000_01_00_1
pci_0000_02_00_0
pci_0000_03_00_0
pci_0000_04_00_0
pci_0000_04_01_0
pci_0000_04_02_0
pci_0000_04_04_0
pci_0000_05_00_0
pci_0000_39_00_0
pci_0000_6e_00_0

Binding VFIO:
```

## Immagini VM
```
Nessuna immagine trovata
```

## Firewalld
```
running
FedoraWorkstation (default, active)
  target: default
  ingress-priority: 0
  egress-priority: 0
  icmp-block-inversion: no
  interfaces: br0 wlo1
  sources: 
  services: dhcpv6-client samba-client ssh
  ports: 1025-65535/udp 1025-65535/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
```

## Servizi principali (systemd)
```
  UNIT                                         LOAD   ACTIVE SUB     DESCRIPTION
  abrt-journal-core.service                    loaded active running ABRT coredumpctl message creator
  abrt-oops.service                            loaded active running ABRT kernel log watcher
  abrt-xorg.service                            loaded active running ABRT Xorg log watcher
  abrtd.service                                loaded active running ABRT Daemon
  accounts-daemon.service                      loaded active running Accounts Service
  alsa-state.service                           loaded active running Manage Sound Card State (restore and store)
  atd.service                                  loaded active running Deferred execution scheduler
  auditd.service                               loaded active running Security Audit Logging Service
  avahi-daemon.service                         loaded active running Avahi mDNS/DNS-SD Stack
  bluetooth.service                            loaded active running Bluetooth service
  bolt.service                                 loaded active running Thunderbolt system service
  chronyd.service                              loaded active running NTP client/server
  colord.service                               loaded active running Manage, Install and Generate Color Profiles
  crond.service                                loaded active running Command Scheduler
  cups.service                                 loaded active running CUPS Scheduler
  dbus-:1.2-org.freedesktop.problems@0.service loaded active running dbus-:1.2-org.freedesktop.problems@0.service
  dbus-broker.service                          loaded active running D-Bus System Message Bus
  firewalld.service                            loaded active running firewalld - dynamic firewall daemon
  flatpak-system-helper.service                loaded active running flatpak system helper
  fwupd.service                                loaded active running Firmware update daemon
  gdm.service                                  loaded active running GNOME Display Manager
  geoclue.service                              loaded active running Location Lookup Service
  gssproxy.service                             loaded active running GSSAPI Proxy Daemon
  irqbalance.service                           loaded active running irqbalance daemon
  low-memory-monitor.service                   loaded active running Low Memory Monitor
  mcelog.service                               loaded active running Machine Check Exception Logging Daemon
  ModemManager.service                         loaded active running Modem Manager
  NetworkManager.service                       loaded active running Network Manager
  pcscd.service                                loaded active running PC/SC Smart Card Daemon
  polkit.service                               loaded active running Authorization Manager
  rsyslog.service                              loaded active running System Logging Service
  rtkit-daemon.service                         loaded active running RealtimeKit Scheduling Policy Service
  smartd.service                               loaded active running Self Monitoring and Reporting Technology (SMART) Daemon
  sshd.service                                 loaded active running OpenSSH server daemon
  sssd-kcm.service                             loaded active running SSSD Kerberos Cache Manager
  switcheroo-control.service                   loaded active running Switcheroo Control Proxy service
  systemd-journald.service                     loaded active running Journal Service
  systemd-logind.service                       loaded active running User Login Management
  systemd-machined.service                     loaded active running Virtual Machine and Container Registration Service
  systemd-resolved.service                     loaded active running Network Name Resolution
  systemd-udevd.service                        loaded active running Rule-based Manager for Device Events and Files
  systemd-userdbd.service                      loaded active running User Database Manager
  thermald.service                             loaded active running Thermal Daemon Service
  tuned-ppd.service                            loaded active running PPD-to-TuneD API Translation Daemon
  tuned.service                                loaded active running Dynamic System Tuning Daemon
  udisks2.service                              loaded active running Disk Manager
  upower.service                               loaded active running Daemon for power management
  uresourced.service                           loaded active running User resource assignment daemon
  user@0.service                               loaded active running User Manager for UID 0
  user@1000.service                            loaded active running User Manager for UID 1000
  wpa_supplicant.service                       loaded active running WPA supplicant

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

51 loaded units listed.
```

## Pacchetti critici installati
### Virtualizzazione
```
libvirt-gconfig-5.0.0-7.fc43.x86_64
virt-what-1.27-4.fc43.x86_64
ipxe-roms-qemu-20240119-4.gitde8a0821.fc43.noarch
virtiofsd-1.13.2-2.fc43.x86_64
libvirt-glib-5.0.0-7.fc43.x86_64
libvirt-gobject-5.0.0-7.fc43.x86_64
spice-server-0.16.0-2.fc43.x86_64
spice-glib-0.42-7.fc43.x86_64
spice-gtk3-0.42-7.fc43.x86_64
spice-vdagent-0.23.0-1.fc43.x86_64
virtualbox-guest-additions-7.1.8-2.fc43.x86_64
spice-webdavd-3.0-12.fc43.x86_64
qemu-common-10.1.2-1.fc43.x86_64
libvirt-libs-11.6.0-2.fc43.x86_64
qemu-device-display-virtio-gpu-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-gpu-pci-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-vga-10.1.2-1.fc43.x86_64
libvirt-daemon-lock-11.6.0-2.fc43.x86_64
libvirt-daemon-log-11.6.0-2.fc43.x86_64
qemu-device-display-virtio-gpu-gl-10.1.2-1.fc43.x86_64
libvirt-daemon-proxy-11.6.0-2.fc43.x86_64
qemu-img-10.1.2-1.fc43.x86_64
qemu-block-rbd-10.1.2-1.fc43.x86_64
qemu-audio-jack-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-gpu-pci-gl-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-vga-gl-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-vga-rutabaga-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-gpu-pci-rutabaga-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-gpu-ccw-10.1.2-1.fc43.x86_64
qemu-device-display-virtio-gpu-rutabaga-10.1.2-1.fc43.x86_64
libvirt-daemon-common-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-core-11.6.0-2.fc43.x86_64
libvirt-daemon-plugin-lockd-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-network-11.6.0-2.fc43.x86_64
libvirt-daemon-config-network-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-disk-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-gluster-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-iscsi-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-iscsi-direct-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-logical-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-mpath-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-rbd-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-scsi-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-storage-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-interface-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-nodedev-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-secret-11.6.0-2.fc43.x86_64
libvirt-daemon-driver-qemu-11.6.0-2.fc43.x86_64
libvirt-client-11.6.0-2.fc43.x86_64
libvirt-ssh-proxy-11.6.0-2.fc43.x86_64
qemu-block-curl-10.1.2-1.fc43.x86_64
qemu-audio-pipewire-10.1.2-1.fc43.x86_64
qemu-pr-helper-10.1.2-1.fc43.x86_64
qemu-audio-alsa-10.1.2-1.fc43.x86_64
qemu-audio-dbus-10.1.2-1.fc43.x86_64
qemu-audio-oss-10.1.2-1.fc43.x86_64
qemu-audio-pa-10.1.2-1.fc43.x86_64
qemu-audio-sdl-10.1.2-1.fc43.x86_64
qemu-block-blkio-10.1.2-1.fc43.x86_64
qemu-block-dmg-10.1.2-1.fc43.x86_64
qemu-block-gluster-10.1.2-1.fc43.x86_64
qemu-block-iscsi-10.1.2-1.fc43.x86_64
qemu-block-nfs-10.1.2-1.fc43.x86_64
qemu-block-ssh-10.1.2-1.fc43.x86_64
qemu-char-baum-10.1.2-1.fc43.x86_64
qemu-device-uefi-vars-10.1.2-1.fc43.x86_64
qemu-device-usb-host-10.1.2-1.fc43.x86_64
qemu-device-usb-redirect-10.1.2-1.fc43.x86_64
qemu-device-usb-smartcard-10.1.2-1.fc43.x86_64
qemu-ui-curses-10.1.2-1.fc43.x86_64
qemu-ui-opengl-10.1.2-1.fc43.x86_64
qemu-ui-spice-core-10.1.2-1.fc43.x86_64
qemu-char-spice-10.1.2-1.fc43.x86_64
qemu-ui-spice-app-10.1.2-1.fc43.x86_64
qemu-audio-spice-10.1.2-1.fc43.x86_64
qemu-device-display-qxl-10.1.2-1.fc43.x86_64
qemu-ui-egl-headless-10.1.2-1.fc43.x86_64
qemu-ui-gtk-10.1.2-1.fc43.x86_64
qemu-ui-sdl-10.1.2-1.fc43.x86_64
qemu-device-display-vhost-user-gpu-10.1.2-1.fc43.x86_64
libvirt-daemon-driver-nwfilter-11.6.0-2.fc43.x86_64
edk2-ovmf-20250812-24.fc43.noarch
qemu-system-x86-core-10.1.2-1.fc43.x86_64
qemu-system-x86-10.1.2-1.fc43.x86_64
qemu-kvm-10.1.2-1.fc43.x86_64
libvirt-daemon-kvm-11.6.0-2.fc43.x86_64
qemu-kvm-core-10.1.2-1.fc43.x86_64
libvirt-daemon-11.6.0-2.fc43.x86_64
qemu-guest-agent-10.1.2-1.fc43.x86_64
edk2-shell-x64-20250812-24.fc43.noarch
python3-libvirt-11.6.0-2.fc43.x86_64
virt-manager-common-5.1.0-2.fc43.noarch
virt-install-5.1.0-2.fc43.noarch
virt-manager-5.1.0-2.fc43.noarch
virt-viewer-11.0-16.fc43.x86_64
```

### Driver grafici
```
mesa-libGLU-9.0.3-7.fc43.x86_64
mesa-filesystem-25.2.7-2.fc43.x86_64
mesa-dri-drivers-25.2.7-2.fc43.x86_64
mesa-libgbm-25.2.7-2.fc43.x86_64
mesa-libEGL-25.2.7-2.fc43.x86_64
mesa-libGL-25.2.7-2.fc43.x86_64
mesa-vulkan-drivers-25.2.7-2.fc43.x86_64
mesa-va-drivers-25.2.7-2.fc43.x86_64
nvidia-gpu-firmware-20251111-1.fc43.noarch
nvidia-modprobe-580.105.08-1.fc43.x86_64
xorg-x11-drv-nvidia-cuda-libs-580.105.08-1.fc43.x86_64
nvidia-persistenced-580.105.08-1.fc43.x86_64
xorg-x11-drv-nvidia-libs-580.105.08-1.fc43.x86_64
xorg-x11-drv-nvidia-kmodsrc-580.105.08-1.fc43.x86_64
akmod-nvidia-580.105.08-1.fc43.x86_64
xorg-x11-drv-nvidia-cuda-580.105.08-1.fc43.x86_64
xorg-x11-drv-nvidia-580.105.08-1.fc43.x86_64
nvidia-settings-580.105.08-1.fc43.x86_64
xorg-x11-drv-nvidia-power-580.105.08-1.fc43.x86_64
kmod-nvidia-6.17.8-300.fc43.x86_64-580.105.08-1.fc43.x86_64
```
