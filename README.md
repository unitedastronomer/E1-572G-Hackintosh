# Acer Aspire E1-572G — Opencore Configuration
[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.8-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![macOS](https://img.shields.io/badge/macOS-Monterey-brightgreen.svg)]()

<img align="right" src="Images/laptop_monterey.png" alt="laptop_monterey.png" width="250">


This OpenCore configuration is optimized for this specific hardware.
   * Tested to work from **High Sierra** up to **Monterey**
   * Kexts for WiFi and Bluetooth are not included
   * Not configured for Ventura and newer

### What's not working?
- [ ] AirDrop & other Airport related features
- [ ] Multi-touch gestures (4 fingers)
- [ ] Accessing DRM content (use chromium based browsers instead)
- [ ] WiFi & Bluetooth (macOS 11+)
- [ ] Graphics Acceleration (macOS 13+) 
- [ ] Automatic Lid Wake when at sleep

## Hardware

|**Category**|**Component**|
|------------|-------------|
|**CPU**	 |Intel® Core™ i5-4200U Processor	 	              |
|**iGPU**	 |Intel HD Graphics 4400                              |
|**Wi-Fi/BT**|Qualcomm Atheros AR9565                             |
|**Ethernet**|Broadcom NetXtreme BCM57786                         |
|**Audio** 	 |Realtek ALC282				 	      |

# Requirements
1. **Ethernet** or Android Phone for USB Tethering<br >
   <sup>iPhone USB Tethering does not work in Recovery</sup>
2. USB Drive <br >
<sup>`>=4GB` for Onlline installer</sup>
3.  Replace mPCIe WiFI Card with an Intel one<br >
<sup>`Optional` There's no working kext for AR9565 on Monterey and newer, max speed is ≤ 200 kilobits under Big Sur and earlier.</sup>

# Preparation

### BIOS

Update to the [latest version](https://www.acer.com/us-en/support/product-support/Aspire_E1-572G), this resolves the issue of the laptop failing to fully power down after doing a shutdown under macOS. <br >

Configure the BIOS with these settings:
<table>
          <tr>
            <th>Option</th>
            <th>Setting</th>
          </tr>
          <tr>
            <td>Boot Mode</td>
            <td>UEFI</td>
          </tr>
          <tr>
            <td>SATA Mode</td>
            <td>AHCI</td>
          </tr>
          <tr>
            <td>Secure Boot<e/td>
            <td>Disabled</td>
          </tr>
        </table>
      </td>
      <td>
<table>	

 
### config.plist

In the config.plist, section `PlatformInfo > Generic` is currently left empty, generate your own SMBIOS data. 

1. Download [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)
3. Open **GenSMBIOS.bat** \(on Windows\)
4. Type `1`, and press enter to install/update MacSerial
5. Type `2`, and press enter to select config.plist
6. Drag and drop **config.plist** file and press enter
7. Type `Y`, **if** "The following keys will be removed..." is prompted
9. Enter `3` and enter to select Generate SMBIOS
10. Type `MacbookPro11,1`, and press enter, the SMBIOS will be automatically apply into your chosen config.plist. <br >
12. While the command prompt still open, type `6` to see Current SMBIOS.

Now enter the serial into the [Apple Check Coverage page](www.checkcoverage.apple.com), you will get 1 of 3 responses:
1. **ⓘ Please enter a valid serial number.** <br >
<sup>This is what we're after</sup>
2. **Valid Purchase Date** <br >
<sup>Avoid!</sup>
4. **Purchase Date not Validated** <br >
<sup>Can also be used, but not recommended as there may be a chance of a conflict with an actual Mac</sup>

If installing Monterey, use `MacbookPro11,4` SMBIOS. You could re-generate and use `MacbookPro11,1` after installation, and add `-no_compat_check` under boot-args. <br >

# Post-Install
Enter the following in terminal, this may resolve laptop randomly not powering down properly on sleep.
```
sudo pmset -a lidwake 0
```
### Troubleshoot
* Unable to [set the boot option back to macOS](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) after booting on windows?
* Stuck on a loop under verbose mode: NVRAM Reset; remove the battery, and press power button for 30 seconds.
* Broadcom Ethernet not detected in any OS: NVRAM Reset; remove the battery, and press power button for 30 seconds.


### Cosmetic

* Disable Verbose Mode: Remove `-v` under NVRAM -> Add > 7C436110-AB2A-4BBB-A880-FE41995C9F82 > boot-args.
* Hide boot picker: Misc -> Boot -> ShowPicker. Set it to **`Disabled`**.
  - Only do if you are not multi-booting.

## macOS Ventura and Sonoma
Use Propertree to configure these settings.
#### Before Installation
* Temporarily generate `iMacPro1,1` SMBIOS in config.plist
* Set `csr-active-config` to `FF0F000`
* Set `SecureBootModel` to `Disabled`
* Add `amfi=0x80` in boot-args
* Download the LATEST Opencore Legacy Patcher
* INSTALL macOS
#### After
* Run OCLP, accept permissions. Then click the reboot when prompted by OCLP app.
* Remove `amfi=0x80`, add `-no_compat_check` and `ipc_control_port _options=0`
* Download [AMFIPass.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/bbc89022704343e55231f59a064acef1e57100bf/payloads/Kexts/Acidanthera), and add to OC/Kexts, then OC Snapshot.
* Generate SMBIOS, use `MacbookPro11,1`.

## Credits
- [doesprintfwork](https://github.com/doesprintfwork/All-in-one-Vanilla-AMD-Hackintosh-Guide/blob/f1a73610d02397f3291686c127a8918fea40f3ec/prerequisites/amd-clover-config.plist/smbios.md) GenSMBIOS guide
- [Jwise](https://github.com/jwise/HoRNDIS) for HoRNDIS
- [DhinakG](https://github.com/USBToolBox/tool) USBToolbox
- [CorpNewt](https://github.com/corpnewt/SSDTTime) GenSMBIOS and Propertree
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html) Guide
- [Acidanthera](https://github.com/acidanthera) Opencore and Lilu-based kexts


etc.



