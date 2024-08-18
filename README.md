# Acer Aspire E1-572G OpenCore Configuration


[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.0-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![OpenCore](https://img.shields.io/badge/macOS-Sonoma-green.svg)](https://github.com/acidanthera/OpenCorePkg)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](https://github.com/unitedastronomer/E1-572G-Hackintosh/blob/main/LICENSE.md)<br>

Please refer the Dortania Opencore Install Guide as your main guide. Consider this a reference.


### 💻 System Specification

| Category       | Component                               |
|----------------|-----------------------------------------|
| **CPU**        | Intel® Core™ i5-4200U Processor         |
| **iGPU**       | Intel HD Graphics 4400                |
| **dGPU**       | AMD Radeon R7 M265  <br><sup>_Disabled_, not supported on macOS</sup>        |
| **Wi-Fi & BT** | Qualcomm Atheros AR9565 <br><sup>Spoofed as AR93xx; partly compatible </sup>      |
| **Ethernet**   | Broadcom NetXtreme BCM57786 <br><sup>Spoofed as BCM57785</sup>                           |
| **Audio Codec**| Realtek ALC282<br><sup>Layout ID: 28</sup>                                   |
| **Trackpad**   | Synaptics TM2682 <br><sup>PS/2</sup>                                          |


### What's not working?

- AirDrop, and other Airport related features.
	- This laptop has a mPCIe slot, if you need these features, replace to **BCM94360HMB** and stay on Big Sur — as some airport features does not properly work on this card since Monterey.
- DRM
	- Broken on any non-mac Intel iGPUs. Workaround is to use  chromium-based browsers or Firefox.
- Bluetooth (on macOS Monterey and newer)
	- Apple rewrote the macOS' Bluetooth stack in Monterey.  `Ath3KBT.kext` has been abandoned by its author, and thus was not updated to accomodate those changes.
- Lid Wake (from sleep)
	- Requires keyboard intervention.
- Fan reading
	- VirtualSMC does not support fan reading on ENE ECs.
- Hibernation[.](https://github.com/acidanthera/bugtracker/issues/386#issuecomment-503042790)


# Preparation

### BIOS 

*  **Update BIOS to the** [**latest version**](https://www.acer.com/us-en/support/product-support/Aspire_E1-572G). This resolves the issue of the laptop failing to fully power down when shutting down.
* Configure the BIOS with these settings: **Secure Boot** -> **Disabled**

### config.plist

In the config.plist, section <code>PlatformInfo > Generic</code> is currently left empty, generate your own SMBIOS data. Use a **MacbookPro11,1** SMBIOS.

# Post-Install

## macOS Big Sur and earlier
> [!WARNING]  
> This can't be applied for Monterey and newer.

This OC configuration has disabled AMFI, and SIP partially disabled, these are necessary for root patching.  You can leave this config as-is or re-enable them by:
* Disable `AMFIPass.kext`
* Delete `amfi=0x80` in boot-arg to re-enable AMFI
* Set `csr-active-config` to `00000000` fully enable SIP
 * Disable these Kernel -> Patches:
   * Force FileVault on Broken Seal
   * Disable Library Validation Enforcement
   * Disable _csr_check() in _vnode_check_signature
* Set `SecureBootModel` to `Default`, and then do an NVRAM Reset before booting into macOS


## macOS Monterey, Ventura and Sonoma

Patches are needed to be applied using Opencore Legacy Patcher to restore WiFi functionality since Monterey, and Graphics Acceleration since Ventura. 

> If you made the macOS installer through OCLP, and booted through this EFI, the patches for Graphics and WiFi will automatically be applied during installation — thus graphics acceleration and WiFi will _work out of the box_.

<div align="center">
<img align="center" src="./assets/oclp.png" alt="" width="600">
</div>

After root patching, remove `amfi=0x80` in boot-args. Just re-add if root patches are needed to be re-applied — typically after an OS update. 
> **AMFIPass.kext** present in this OC configuration will allow the device to boot without this boot-arg. However, this boot-arg is still **required** and must be present in every fresh installations, or after an OS update to allow OCLP apply the root patches, it can only be removed if root patches are already applied. Leaving this boot-arg present will cause unnecessary issue down the lane as permission prompts may not show up if apps ask certain permissions (Mic, Camera, etc.).

 * Do not use Migration Assistant within the Setup Assistant (setup screen right after macOS installation)
 * Do not use Migration Assistant if root patches are applied, revert patches first then apply it back after using Migration Assistant.

## ⚠️ macOS Seqouia

Root patches for Haswell's integrated graphics and Atheros WiFi (Legacy Wireless) is currently not supported by OCLP.

## Multi-boot with Windows
Windows keeps taking over boot order, or unable to [set the boot option back to macOS](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) after booting on windows?

<br><br>

# Troubleshoot
* Don't stop midway of the installation process; **patience is key!**
	* If you can't get past a looping error code, (from e.g., `failed lookup: name = com.apple.logd`): remove the battery, and press power button for at least 30 seconds.
* [Fixing Window features after installing macOS](https://github.com/5T33Z0/OC-Little-Translated/blob/main/I_Windows/Windows_fixes.md)
* [Use Windows partition under macOS via VMWare](https://github.com/mackonsti/s145-14iwl/blob/master/Fusion.md)


#### Note:
* If you at least once booted from Windows then macOS, certain ports transfer from XHC to EHC after sleep.
* Fun fact: VGA port is actually a DisplayPort internally according to the schematics, you may need to adjust the device properties - such as the connector type, bus ID, etc.  
* WiFi icon will only show one bar, this is a known issue with this WiFi card.

## Credits

Guides:
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html): OpenCore Install Guide
- [5T33Z0](https://github.com/5T33Z0): [Remapping Brightness Keys](https://github.com/5T33Z0/OC-Little-Translated/blob/main/05_Laptop-specific_Patches/Fixing_Keyboard_Mappings_and_Brightness_Keys/Customizing_ThinkPad_Keyboard_Shortcuts.md), [Slimming AppleALC](https://github.com/5T33Z0/AppleALC-Guides/tree/main/Slimming_AppleALC)
- [PG7](https://www.insanelymac.com/forum/topic/359007-wifi-atheros-monterey-ventura-sonoma-work/): Enabling Legacy Wireless on Monterey+

Tools:
- [CorpNewt](https://github.com/corpnewt/SSDTTime): SSDTTime, GenSMBIOS, Propertree, and USBMap
- [Acidanthera](https://github.com/acidanthera/MaciASL): MaciASL, and OpenCorePkg
- [Benbaker76](https://github.com/benbaker76/Hackintool): Hackintool


# 📜 **License** 

This OpenCore configuration is made of multiple external applications from different people and organizations. [See each program for their licensing](assets/REFERENCE.md).

