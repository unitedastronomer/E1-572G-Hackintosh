# Acer Aspire E1-572G OpenCore Configuration


[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.0-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![OpenCore](https://img.shields.io/badge/macOS-Sonoma-green.svg)](https://github.com/acidanthera/OpenCorePkg)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](https://github.com/unitedastronomer/E1-572G-Hackintosh/blob/main/LICENSE.md)<br>

### 💻 System Specification

| Category       | Component                               |
|----------------|-----------------------------------------|
| **CPU**        | Intel® Core™ i5-4200U Processor         |
| **iGPU**       | Intel HD Graphics 4400                |
| **dGPU**       | AMD Radeon 8750M  <br><sup>Disabled, <a href="https://dortania.github.io/GPU-Buyers-Guide/misc/discrete-laptops.html#laptop-dgpus"> not supported</a> on macOS</sup>        |
| **Wi-Fi & BT** | Qualcomm Atheros AR9565 <br><sup>Spoofed as AR93xx</sup>      |
| **Ethernet**   | Broadcom NetXtreme BCM57786 <br><sup>Spoofed as BCM57785</sup>                           |
| **Audio Codec**| Realtek ALC282<br><sup>Layout ID: 28</sup>                                   |
| **Trackpad**   | Synaptics TM2682 <br><sup>PS/2</sup>                                          |


### What's not working?

- AirDrop, and other Airport related features
	- If you need those features, replace with **BCM94360HMB**, and stay on Big Sur — however, most airport features do not work on this card starting Monterey.
		- This machine uses mPCIe slot for the WiFi Card
- Playing DRM content (on Safari 14+ and macOS Big Sur+)
	- To work around this, use a Chromium-based browser or Firefox.
- Bluetooth (Atheros; on macOS Monterey and newer)
	- To work around this, use a USB Bluetooth dongle with Broadcom/CSR chip such as ASUS BT400 and TP-Link UB400.
- Lid Wake (from sleep)
	- Wake through keyboard press works just fine.
- USB Wake  (from sleep)
	- Wake from USB Mouse/keyboard does not work due to 06D Patch.
- Automatic Sleep on critical battery level
	- To work around this, use [this app](https://github.com/HsOjo/SleeperX).
- Hibernation[.](https://github.com/acidanthera/bugtracker/issues/386#issuecomment-503042790)
	- Disable it. 
- Fan reading
	- VirtualSMC does not support fan reading on ENE ECs.
 - Multi-finger (3+) Trackpad Gestures
	- Hardware limitation, trackpad is PS2.
 - & [a lot more](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/1008) on macOS Ventura+

# Preparation

### BIOS 

*  **Update BIOS to the** [**latest version**](https://www.acer.com/us-en/support/product-support/Aspire_E1-572G). This resolves the issue of the laptop failing to fully power down when shutting down.
* Configure BIOS with these settings:
	* **Secure Boot** &rarr; **Disabled**
	* **F12 Boot** &rarr; **Enabled**

### config.plist

In the config.plist, section <code>PlatformInfo > Generic</code> is currently left empty, [generate your own SMBIOS data](https://github.com/corpnewt/GenSMBIOS). Use a **MacbookPro11,1** SMBIOS.

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

 * Do not use Migration Assistant within the Setup Assistant (setup screen right after macOS installation)
 * Do not use Migration Assistant if root patches are applied, revert patches first then apply them back after using Migration Assistant.

<div align="center">
<img align="center" src="./assets/oclp.png" width="600">
</div>


## ⚠️ macOS Seqouia

[OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) currently does not provide patches for Intel Haswell's graphics.
- Legacy Wireless are supported.


# Troubleshoot
* Multi-boot with Windows
	* Once booted through Windows, it will take over the boot order and you'll be unable to boot through OpenCore. Make sure to [install Bootcamp utilities](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) in Windows after installing macOS if you are multi-booting.
* Cannot connect to Wi-Fi
	* To work around this, manually connect using the "Other" option in the Wi-Fi menu bar or manually add the network in the "Network" preference pane.
* [Fixing Window features after installing macOS](https://github.com/5T33Z0/OC-Little-Translated/blob/main/I_Windows/Windows_fixes.md)
* [Use Windows partition under macOS via VMWare](https://github.com/mackonsti/s145-14iwl/blob/master/Fusion.md)


#### Note:
* **Do not update AppleALC**. `-alcbeta` boot-arg allows AppleALC to load up until macOS Sequoia. It is compiled to only contain layout 28 of ALC282. 
	* 86KB (vs. originally 3.43 MB).
* The install is taking too long?; **patience is key!**
	* Do not manually power off or reboot your machine as this will break the installation and require reinstalling. 
	* However, if you can't get past a looping error (`-v` boot-arg must be present to see), remove the battery, and press the power button for at least 30 seconds.

Other Issues:
* Sleep may randomly break if the machine is still doing tasks while it is transitioning into sleep mode on it's own. Temporary disable sleep via `pmset` command if you are doing something important.
* If you at least once booted from Windows then macOS, certain ports transfer from XHC to EHC after sleep.
* VGA port is actually a DisplayPort internally according to the schematics, you may need to adjust the device properties - such as the connector type, bus ID, etc.  
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

