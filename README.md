# Acer Aspire E1-572G OpenCore Configuration


[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.0-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![OpenCore](https://img.shields.io/badge/macOS-Sonoma-green.svg)](https://github.com/acidanthera/OpenCorePkg)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](https://github.com/unitedastronomer/E1-572G-Hackintosh/blob/main/LICENSE.md)<br>

Please refer the Dortania Opencore Install Guide as your main guide. Consider this a reference.


### 💻 System Specification

| Category       | Component                               |
|----------------|-----------------------------------------|
| **CPU**        | Intel® Core™ i5-4200U Processor         |
| **iGPU**       | Intel HD Graphics 4400                  |
| **dGPU**       | AMD Radeon R7 M265  <br><sup>_Disabled_, not supported on macOS</sup>        |
| **Wi-Fi & BT** | Qualcomm Atheros AR9565  </sup>      |
| **Ethernet**   | Broadcom NetXtreme BCM57786                           |
| **Audio Codec**| Realtek ALC282<br><sup>Layout ID: 28</sup>                                   |
| **Trackpad**   | Synaptics TM2682 <br><sup>PS/2</sup>                                          |


### What's not working?

- AirDrop, and other Airport related features.
	- Replace to `BCM94360HMB`, and stay on Big Sur for full functionality.
- DRM
	- Broken on any non-mac Intel iGPUs.
- Bluetooth (macOS 12+)
	- `Ath3kBT.kext` is not being maintained anymore.
- Lid Wake
	- Requires keyboard intervention.
- Fan reading
	- VirtualSMC does not support fan reading on ENE ECs.
- Hibernation[.](https://github.com/acidanthera/bugtracker/issues/386#issuecomment-503042790)


# Preparation

### BIOS 

*  **Update BIOS to the** [**latest version**](https://www.acer.com/us-en/support/product-support/Aspire_E1-572G). This resolves the issue of the laptop failing to fully power down when shutting down.
* Configure the BIOS with these settings: **Secure Boot** -> **Disabled**

### config.plist


There are two versions of EFI.

* macOS 10.13 - 11.7
	* macOS Big Sur is the last natively supported OS without the need to apply root-patches.
* macOS 10.13 - 14.4
	* Configured to boot up to **Sonoma**, however some security are partially lifted in order for root patches be applied.


In the config.plist, section <code>PlatformInfo > Generic</code> is currently left empty, generate your own SMBIOS data. 
* Use a **MacbookPro11,1** SMBIOS


## macOS Monterey, Ventura and Sonoma
Patches are needed to be applied using Opencore Legacy Patcher to restore WiFi functionality on since Monterey, and Graphics Acceleration since Ventura. 

![](assets/oclp.png)


 * Do not use Migration Assistant within the Setup Assistant (setup screen right after macOS installation)
 * Do not use Migration Assistant if root patches are applied, revert patches first then apply it back after using Migration Assistant.

# Post-Install


### Troubleshoot
* Don't stop midway of the installation process; **patience is key!**
	* If you can't get past a looping error code, (from e.g., `failed lookup: name = com.apple.logd`): remove the battery, and press power button for at least 30 seconds.
* Windows keeps taking over boot order, or unable to [set the boot option back to macOS](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) after booting on windows?
* [Fixing Window features after installing macOS](https://github.com/5T33Z0/OC-Little-Translated/blob/main/I_Windows/Windows_fixes.md)
* [Use Windows partition under macOS via VMWare](https://github.com/mackonsti/s145-14iwl/blob/master/Fusion.md)


#### Note:
* If you at least once booted from Windows then macOS, certain ports transfer from EHC to XHC after sleep.
* Fun fact: VGA port is actually a DisplayPort internally according to the schematics, you may need to adjust the device properties - such as the connector type, bus ID, etc. 

## Credits

Guides:
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html): OpenCore Install Guide
- [5T33Z0](https://github.com/5T33Z0): [Remapping Brightness Keys](https://github.com/5T33Z0/OC-Little-Translated/blob/main/05_Laptop-specific_Patches/Fixing_Keyboard_Mappings_and_Brightness_Keys/Customizing_ThinkPad_Keyboard_Shortcuts.md), [Slimming AppleALC](https://github.com/5T33Z0/AppleALC-Guides/tree/main/Slimming_AppleALC)
- [PG7](https://www.insanelymac.com/forum/topic/359007-wifi-atheros-monterey-ventura-sonoma-work/): Enabling Legacy Wireless on Monterey+

Tools:
- [CorpNewt](https://github.com/corpnewt/SSDTTime): SSDTTime, GenSMBIOS, Propertree, and USBMap
- [Acidanthera](https://github.com/acidanthera/MaciASL): MaciASL, and OpenCorePkg
- [Benbaker76](https://github.com/benbaker76/Hackintool): Hackintool
<br>


# 📜 **License** <br>

This OpenCore configuration is made of multiple external applications from different people and organizations. [See each program for their licensing](assets/REFERENCE.md).

