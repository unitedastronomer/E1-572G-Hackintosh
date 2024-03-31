# Acer Aspire E1-572G — Opencore Configuration
[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.9-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![macOS](https://img.shields.io/badge/macOS-Monterey-brightgreen.svg)]()

<img align="right" src="Images/laptop_monterey.png" alt="laptop_monterey.png" width="250">


This OpenCore configuration is optimized for this specific hardware.
   * Tested to work from **High Sierra** up to **Sonoma**
     * However, additional configuration is needed for Ventura and newer
   * Kexts for WiFi and Bluetooth are not included
     * Replace it with an Intel - this will save you from headache!

### What's not working?
- [ ] AirDrop & other Airport related features
- [ ] Multi-touch gestures (4 fingers)
- [ ] Accessing DRM content (use chromium based browsers instead)
- [ ] WiFi & Bluetooth (macOS 12+)
- [ ] Graphics Acceleration (macOS 13+) 
- [ ] Automatic Lid Wake when at sleep
- [ ] Fan reading (and so under Windows), so don't bother adding `SMCSuperIO.kext`

## Hardware

|**Category**|**Component**|
|------------|-------------|
|**CPU**	 |Intel® Core™ i5-4200U Processor	|
|**iGPU**	 |Intel HD Graphics 4400          |
|**dGPU**	 | (Unsupported)                  |
|**Wi-Fi/BT**|Qualcomm Atheros AR9565       |
|**Ethernet**|Broadcom NetXtreme BCM57786   |
|**Audio** 	 |Realtek ALC282				 	      |

# Requirements
1. **Ethernet** or Android Phone for USB Tethering<br >
   <sup>iPhone USB Tethering does not work in Recovery</sup>
2. USB Drive <br >
<sup>`>=4GB` for Onlline installer</sup>
3.  Replace mPCIe WiFi Card with an Intel one<br >
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
2. Open **GenSMBIOS.bat** (on Windows)
3. Type `1`, and press enter to install/update MacSerial
4. Type `2`, and press enter to select config.plist
5. Drag and drop **config.plist** file and press enter
6. Type `Y`, **if** "The following keys will be removed..." is prompted
7. Enter `3` and enter to select Generate SMBIOS
8. Type `MacbookPro11,1`, and press enter, the SMBIOS will be automatically apply into your chosen config.plist. <br >

9. While the command prompt still open, type `6` to see Current SMBIOS.

Now enter the serial into the [Apple Check Coverage page](www.checkcoverage.apple.com), you will get 1 of 3 responses:
1. **ⓘ Please enter a valid serial number.** <br >
<sup>This is what we're after</sup>
2. **Valid Purchase Date** <br >
<sup>Avoid!</sup>
4. **Purchase Date not Validated** <br >
<sup>Can also be used, but not recommended as there may be a chance of a conflict with an actual Mac</sup>


## macOS Ventura and Sonoma
Please only use Propertree to configure these settings.

#### Before Installation
* Add `amfi=0x80` in boot-args
* Download the LATEST Opencore Legacy Patcher, and place it where you can easily access it under macOS.
* INSTALL macOS
#### After
* Run OCLP, accept permissions. Then click the reboot when prompted by OCLP app.
* Remove `amfi=0x80`

# Post-Install
Enter the following in terminal, this may resolve sleep randomly break.
```
sudo pmset -a lidwake 0
sudo pmset -a autopoweroff 0
sudo pmset -a powernap 0
sudo pmset -a standby 0
sudo pmset -a proximitywake 0
sudo pmset -a tcpkeepalive 0
```
### Disable Powernap and Wake for Network Access in Settings! Settings -> Battery.

### Troubleshoot
* Unable to [set the boot option back to macOS](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) after booting on windows?
* Stuck on a loop under verbose mode: NVRAM Reset; remove the battery, and press power button for 30 seconds.
* Broadcom Ethernet not detected in any OS: NVRAM Reset; remove the battery, and press power button for 30 seconds.

Intel mPCIe WiFI + BT Card specific:
* Bluetooth becomes unusable when WiFi is active and connected on the 2.4 GHz band (e.g., stuttering sound when playing from a BT speaker). A workaround is to connect to the 5 GHz band of the WiFi, or set up a hotspot on your phone and configure it to use the 5 GHz band. [More info](https://openintelwireless.github.io/itlwm/FAQ.html#can-i-use-bluetooth-with-wi-fi)
* The AR9565 card only uses one antenna. Intel mPCIe cards typically come with two antenna connectors, so consider purchasing the appropriate antenna for the second connector to enhance coverage. Also note that only having one antenna in use still works without having to add another one. 

### Cosmetic

* Disable Verbose Mode: Remove `-v` under NVRAM -> Add > 7C436110-AB2A-4BBB-A880-FE41995C9F82 > boot-args.
* Hide boot picker: Misc -> Boot -> ShowPicker. Set it to **`Disabled`**.
  - Only do if you are not multi-booting.


# Don't consider this as a guide, but rather just a pointer. I am not responsible if you have somehow bricked your device!
Please refer to the Dortania Opencore Install Guide, more things are detailed in there that I did not add here.


## Credits
- [doesprintfwork](https://github.com/doesprintfwork/All-in-one-Vanilla-AMD-Hackintosh-Guide/blob/f1a73610d02397f3291686c127a8918fea40f3ec/prerequisites/amd-clover-config.plist/smbios.md) GenSMBIOS guide
- [Jwise](https://github.com/jwise/HoRNDIS) for HoRNDIS
- [DhinakG](https://github.com/USBToolBox/tool) USBToolbox
- [CorpNewt](https://github.com/corpnewt/SSDTTime) GenSMBIOS and Propertree
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html) Guide
- [Acidanthera](https://github.com/acidanthera) Opencore and Lilu-based kexts


etc.



