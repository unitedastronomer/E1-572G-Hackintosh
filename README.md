# Acer Aspire E1-572G OpenCore Configuration


[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.9-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](https://github.com/unitedastronomer/E1-572G-Hackintosh/blob/main/LICENSE.md)<br>

Please refer the Dortania Opencore Install Guide as your main guide. Consider this a reference.


### 💻 System Specification

| Category       | Component                               |
|----------------|-----------------------------------------|
| **CPU**        | Intel® Core™ i5-4200U Processor         |
| **iGPU**       | Intel HD Graphics 4400                  |
| **dGPU**       | AMD Radeon HD 8670M <br><sup>_Disabled_, not supported on macOS</sup>        |
| **Wi-Fi & BT** | Qualcomm Atheros AR9565  </sup>      |
| **Ethernet**   | Broadcom NetXtreme BCM57786 Gigabit Ethernet PCIe                            |
| **Audio Codec**| Realtek ALC282<br><sup>Layout ID: 28</sup>                                   |
| **Trackpad**   | Synaptics TM2682 <br><sup>PS/2</sup>                                          |


### What's not working?

- AirDrop, and other Airport related features.
- DRM (macOS 11+)
- Bluetooth (macOS 12+)
- Lid Wake, requires keyboard intervention.
- Fan reading
- Hibernation[.](https://github.com/acidanthera/bugtracker/issues/386#issuecomment-503042790)


# Preparation

### BIOS 

*  **Update BIOS to the** [**latest version**](https://www.acer.com/us-en/support/product-support/Aspire_E1-572G). This resolves the issue of the laptop failing to fully power down when shutting down.
* Configure the BIOS with these settings: **Secure Boot** -> **Disabled**

### config.plist

In the config.plist, section <code>PlatformInfo > Generic</code> is currently left empty, generate your own SMBIOS data. 
* Use a **MacbookPro11,1** SMBIOS

This OpenCore configuration was set up to allow booting macOS versions as early as High Sierra up to Sonoma. Some security was lifted up needed to allow root patching.
* If you choose to install Big Sur or earlier, you can leave this config as-is or re-enable security features by:
    * Delete `amfi=0x80` in boot-args
    * Set `csr-active-config` to `00000000`
    * Disable these Kernel -> Patches
      * Force FileVault on Broken Seal
      * Disable Library Validation Enforcement
      * Disable _csr_check() in _vnode_check_signature
    * Set `SecureBootModel` to `Default`, and do an NVRAM reset if you have set this setting after OS was already installed.

## macOS Monterey, Ventura and Sonoma
Root patching via Opencore Legacy Patcher is needed to restore Graphics Acceleration since Ventura, and WiFi functionality since Monterey. 

![](assets/oclp.png)


 * Do not use Migration Assistant within the Setup Assistant (setup screen right after macOS installation)
 * Do not use Migration Assistant if root patches are applied, revert patches first then apply it back after using Migration Assistant.

# Post-Install


### Troubleshoot
* Don't stop midway of the installation process; **patience is key!**
	* If you can't get past a looping error code, (from e.g., `failed lookup: name = com.apple.logd`): remove the battery, and press power button for at least 30 seconds.
* Unable to [set the boot option back to macOS](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) after booting on windows?
* [Fixing Window features after installing macOS](https://github.com/5T33Z0/OC-Little-Translated/blob/main/I_Windows/Windows_fixes.md)
* [Use Windows partition under macOS via VMWare](https://github.com/mackonsti/s145-14iwl/blob/master/Fusion.md)


#### Note:
* Fun fact: VGA port is actually a DisplayPort internally according to the schematics, you may need to adjust the device properties - such as the connector type, bus ID, etc. 

## Credits

Guides:
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html): OpenCore Install Guide
- [5T33Z0](https://github.com/5T33Z0): [Remapping Brightness Keys](https://github.com/5T33Z0/OC-Little-Translated/blob/main/05_Laptop-specific_Patches/Fixing_Keyboard_Mappings_and_Brightness_Keys/Customizing_ThinkPad_Keyboard_Shortcuts.md), [Slimming AppleALC](https://github.com/5T33Z0/AppleALC-Guides/tree/main/Slimming_AppleALC)
- [PG7](https://www.insanelymac.com/forum/topic/359007-wifi-atheros-monterey-ventura-sonoma-work/): Enabling Legacy Wireless on Monterey+

Tools:
- [CorpNewt](https://github.com/corpnewt/SSDTTime): SSDTTime, GenSMBIOS, Propertree, and USBMap
- [Acidanthera](https://github.com/acidanthera/MaciASL): MaciASL
- [Benbaker76](https://github.com/benbaker76/Hackintool): Hackintool
<br>


# 📜 **License** <br>

This OpenCore configuration is made of multiple external applications from different people and organizations. [See each program for their licensing](assets/REFERENCE.md).

