# Acer Aspire E1-572G — Opencore Configuration
[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.9-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![macOS](https://img.shields.io/badge/macOS-Monterey-brightgreen.svg)]()

This OpenCore configuration is optimized for this specific hardware. 
   * Tested to work from **High Sierra** (10.13) up to **Sonoma** (14)
     * However, additional configuration is needed for Ventura (13) and newer

## 💻 System Specification

<table>
  <tr>
    <td rowspan="2">
          <table>
        <tr>
          <th>Category</th>
          <th>Component</th>
        </tr>
        <tr>
          <td><strong>CPU</strong></td>
          <td>Intel® Core™ i5-4200U Processor</td>
        </tr>
        <tr>
          <td><strong>iGPU</strong></td>
          <td>(Unsupported) 0</td>
        </tr>
        <tr>
          <td><strong>dGPU</strong></td>
          <td>Intel HD Graphics 4400</td>
        </tr>
        <tr>
          <td><strong>Wi-Fi & BT</strong></td>
          <td>Qualcomm Atheros AR9565</td>
        </tr>
        <tr>
          <td><strong>Audio</strong></td>
          <td>Broadcom NetXtreme BCM57786</td>
        </tr>
        <tr>
          <td><strong>Ethernet</strong></td>
          <td>Realtek ALC282</td>
        </tr>
      </table>
    </td>
    <td>
      <table>
        <tr>
          <strong>Screenshot</strong>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <img align="center" src="Images/laptop_monterey.png" alt="laptop_monterey.png" width="250">
    </td>
  </tr>
</table>

### What's not working? 
- [ ] AirDrop & other Airport related features
- [ ] Multi-touch gestures (4 fingers)
- [ ] Cannot access DRM content (Use chromium based browsers instead)
- [ ] WiFi & Bluetooth (macOS 12+)
- [ ] Graphics Acceleration (macOS 13+) 
- [ ] Automatic Lid Wake when at sleep
- [ ] Fan reading (and so under Windows), so don't bother adding `SMCSuperIO.kext`

   * Kexts for WiFi and Bluetooth are not included
     * Replace it with an Intel - this will save you from headache!


# Requirements
1. **Ethernet** or Android Phone for USB Tethering<br >
   <sup>iPhone USB Tethering does not work in Recovery</sup>
2. USB Drive <br >
<sup>`>=4GB` for Onlline installer</sup>
3.  Replace mPCIe WiFi Card with an Intel one<br >
<sup>`Optional` Notorious for having a really slow internet speed. >. Replace it with an Intel - this will save you from headache! There's no working kext for AR9565 on Monterey and newer, max speed is ≤ 200 kilobits under Big Sur and earlier.</sup>

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

|**macOS**   |**SMBIOS**      |
|------------|----------------|
| <= Big Sur |`MacbookPro11,1`|
|	Monterey   |`MacbookPro11,4`|
|	Ventura and Sonoma |`iMacPro1,1`|

9. While the command prompt still open, type `6` to see Current SMBIOS.

Now enter the serial into the [Apple Check Coverage page](www.checkcoverage.apple.com), you will get 1 of 3 responses:
1. **ⓘ Please enter a valid serial number.** <br >
<sup>This is what we're after</sup>
2. **Valid Purchase Date** <br >
<sup>Avoid!</sup>
4. **Purchase Date not Validated** <br >
<sup>Can also be used, but not recommended as there may be a chance of a conflict with an actual Mac</sup>

> [!NOTE]  
> * For **Monterey**, you have the option to either keep the current SMBIOS or regenerate it and switch to `MacbookPro11,1` after installation, as it closely matches our CPU. Make sure to include `-no_compat_check` under boot-args. 
> * For **Ventura** and **Sonoma**, we will temporarily utilize a supported SMBIOS for installation purposes. After installation, regenerate and switch to `MacbookPro11,1`, and remember to include `-no_compat_check` under boot-args. <br >

## macOS Ventura and Sonoma
Please only use Propertree to configure these settings.

#### Before Installation
* Temporarily generate `iMacPro1,1` SMBIOS in config.plist
* Set `csr-active-config` to `FF0F0000`
* Set `SecureBootModel` to `Disabled`
* Add `amfi=0x80` in boot-args
* Download the LATEST Opencore Legacy Patcher, and place it where you can easily access it under macOS.
* INSTALL macOS
#### After
* Run OCLP, accept permissions. Then click the reboot when prompted by OCLP app.
* Remove `amfi=0x80`, add `-no_compat_check` and `ipc_control_port_options=0`
* Download [AMFIPass.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/bbc89022704343e55231f59a064acef1e57100bf/payloads/Kexts/Acidanthera), and add to OC/Kexts, then OC Snapshot.
* Generate SMBIOS, use `MacbookPro11,1`.

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

## BIOS

<table>
    <tr>
      <td>
          <table>
        <p>Configure the BIOS with these settings:</p>
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
        <p>Other required settings are non-existent in BIOS, however a workaround is applied in the config.plist:</p>
          <tr>
            <th>Unavailable Option</th>
            <th>Setting</th>
          </tr>
          <tr>
            <td>CFG Lock</td>
            <td>AppleXcpmCfgLock</code> is set to <code>True</code> under <code>Kernel</code> -> <code>Quirks</code></td>
          </tr>
          <tr>
            <td>DVMT</td>
            <td>VRAM patches applied under <code>DeviceProperties</code> -> <code>PciRoot(0x0)/Pci(0x2,0x0)</code></td>
          </tr>
        </table>
      </td>
   </tr>
<table>

* Other required settings are non-existent in BIOS, however some quirks in config.plist are enabled as a workaround.

## ACPI 

#### The **E1-572G.aml** in the OC/ACPI is a combination of all of these SSDTs.
<table>
    <tr>
        <td><b>SSDT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
        <td><b>Description</b></td>
    </tr>
        <tr>
        <td>
        <b>SSDT-GPRW</b>
        <details>
            <summary>Patches</summary>
            <table>
          <tr>
            <th>Find</th>
            <th>Replace</th>
            <th>Comment</th>
          </tr>
          <tr>
            <td>47505257 02</td>
            <td>58505257 02</td>
            <td>GPRW,2,N to XPRW</td>
          </tr>
        </table>
        </details>
        </td>
    <td>
        Resolves sleep issue, where going to sleep shuts down the laptop instead. 
    </td>
    </tr>
        <tr>
        <td>
        <b>SSDT-KBC0</b>
        <details>
            <summary>Patches</summary>
            <table>
          <tr>
            <th>Find</th>
            <th>Replace</th>
            <th>Comment</th>
          </tr>
          <tr>
            <td>5F513131</td>
            <td>58513131</td>
            <td>_Q11 to XQ11</td>
          </tr>
      <tr>
            <td>5F513132</td>
            <td>58513132</td>
            <td>_Q12 to XQ12</td>
          </tr>
        </table>
        </details>
        </td>
        <td>
    Reroutes brightness key to <b>Fn</b> + <b>Left</b> / <b>Right</b> arrow keys. 
           <ul>
                     <li>Disables <b>Fn</b> + <b>F12</b>, and <b>Pause Break</b>.
                 <ul>
                     <li><b>Fn</b> + <b>F12</b> acts as <b>F14</b>, which is the decrease brightness key in macOS.
                     </li>
                     <li><b>Pause Break</b> acts as <b>F15</b>, which is the increase brightness key in macOS.
                     </li>
                 </ul>
             </li>
          </ul><br />
    </td>
    </tr>
    <tr>
        <td>
        <b>SSDT-HPET</b>
        <details>
            <summary>Patches</summary>
            <table>
          <tr>
            <th>Find</th>
            <th>Replace</th>
            <th>Comment</th>
          </tr>
          <tr>
            <td>275F5354 41</td>
            <td>27585354 41</td>
            <td>HPET _STA to XSTA</td>
          </tr>
      <tr>
            <td>46055F43 5253</td>
            <td>46055843 5253</td>
            <td>HPET _CRS to XCRS</td>
          </tr>
      <tr>
            <td>22040079 00</td>
            <td>22000079 00</td>
            <td>IPIC IRQ Patch</td>
          </tr>
      <tr>
            <td>22000179 00</td>
            <td>22000079 00</td>
            <td>RTC IRQ Patch</td>
          </tr>
      <tr>
            <td>22010079 00</td>
            <td>22000079 00</td>
            <td>TIMR IRQ Patch</td>
          </tr>
        </table>
        </details>
        </td>
        <td>
        Resolves audio device not being detected.<br /><br />
    </td>
    </tr>
    <tr>
        <td>
        <p><b>SSDT-EC</b>
        </td>
     <td>
        Provides macOS a dummy Embedded Controller.    
        </td>
    </tr>
     <tr>
        <td>
        <b>SSDT-PLUG</b>
        </td>
        <td>
        Enables CPU Power Management.
        </td>
    </tr>
    <tr>
        <td>
        <b>SSDT-ALS0</b>
        </td>
    <td>
        Provides macOS with a fake Ambient Light Sensor device (ALS), so it could store the current brightness level and keep it after reboots.
    </td>
    </tr>
    <tr>
        <td>
        <b>SSDT-SBUS-MCHC</b>
        </td>
    <td>
        Apparently fixes AppleSMBus support.
    </td>
    </tr>
    <tr>
        <td>
        <b>SSDT-dGPU_OFF</b>
        </td>
    <td>
        Disables unsupported dGPU.
    </td>
    </tr>
    <tr>
        <td>
        <b>SSDT-EHCx_OFF</b>
        </td>
    <td>
        <i>Optional</i>, disables the EHC1 controller.
    </td>
    </tr>
</table>

<br >

## Device Properties

<table>
    <tr>
      <td>
        <p><b>Display Controller</b>:<br />
            <code>PciRoot(0x0)/Pci(0x1B,0x0)</code><br /><br />
            <code>framebuffer-con1-type</code> sets the correct connector type for DisplayPort.<br />
                 <ul>
                     <li>The VGA port is actually a DisplayPort internally</li>
                     <li>I have not tested this, if it does not work, you may need to set the correct bus ID for it. Not guaranteed to work as it maybe hardwired to the dGPU.</li>
                 </ul>
     <code>framebuffer-con2-type</code> sets the correct connector type for HDMI, and resolves HDMI audio.<br /><br />
     <code>enable-backlight-smoother</code> enabling smoother brightness transition when adjusting the brightness.<br /><br />
     <code>backlight-smoother-lowerbound</code> prevents the display from fully going black when brightness is set to the lowest.<br /><br />
          More explanation here:<br />
                     <a href="https://dortania.github.io/OpenCore-Post-Install/gpu-patching/intel-patching/#terminology">Intel iGPU Patching</a>
                      <br />
                     <a href="https://dortania.github.io/OpenCore-Post-Install/gpu-patching/intel-patching/vram.html#creating-our-patch">Patching VRAM</a>
                      <br />
                      <a href="https://dortania.github.io/OpenCore-Post-Install/gpu-patching/intel-patching/busid.html#parsing-the-framebuffer">Patching Bus ID</a>
                      <br /> 
           <a href="https://www.s-manuals.com/pdf/motherboard/compal/compal_la-9531p_r1.0_schematics.pdf">E1-572G Schematics</a>
          <br />
        </p>
      </td>
      <td>
        <table>
          <tr>
            <th>Key*</th>
            <th>Value</th>
            <th>Type</th>
          </tr>
          <tr>
            <td>AAPL,ig-platform-id</td>
            <td>0500260A</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>device-id</td>
            <td>12040000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>framebuffer-patch-enable</td>
            <td>01000000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>framebuffer-cursormem</td>
            <td>00009000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>framebuffer-stolenmem</td>
            <td>00003001</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>framebuffer-fbmem</td>
            <td>00009000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>framebuffer-con1-enable</td>
            <td>01000000</td>
            <td>Data</td>
          </tr>
           <tr>
            <td>framebuffer-con2-enable</td>
            <td>01000000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>framebuffer-con1-type</td>
            <td>00040000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>framebuffer-con2-type</td>
            <td>00080000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>enable-backlight-smoother</td>
            <td>01000000</td>
            <td>Data</td>
          </tr>
          <tr>
            <td>backlight-smoother-lowerbound</td>
            <td>05000000</td>
            <td>Data</td>
          </tr>
        </table>
      </td>
</tr>
      <tr>
      <td>
        <p><b>Audio Controller</b>:<br /><code>PciRoot(0x0)/Pci(0x1B,0x0)</code>
        </p>
      </td>
      <td>
        <table>
          <tr>
            <th>Key*</th>
            <th>Value</th>
            <th>Type</th>
          </tr>
          <tr>
            <td>layout-id</td>
            <td>28</td>
            <td>Number</td>
          </tr>
        </table>
      </td>
    </tr>
        <tr>
      <td>
        <p><b>Network Controller</b>:<br /><code>PciRoot(0x0)/Pci(0x1C,0x3)/Pci(0x0,0x0)</code>
        <br />
        <br />
        Sets the WiFi as <code>built-in</code>.
        </p>
      </td>
      <td>
        <table>
          <tr>
            <th>Key*</th>
            <th>Value</th>
            <th>Type</th>
          </tr>
          <tr>
            <td>built-in</td>
            <td>01</td>
            <td>Data</td>
          </tr>
        </table>
      </td>
    </tr>
        <tr>
      <td>
        <p><b>Ethernet Controller</b>:<br /><code>PciRoot(0x0)/Pci(0x1C,0x0)/Pci(0x0,0x0)</code>
        <br />
    <br />
        Sets the Ethernet as <code>built-in</code>. <br /><br />
    In combination with Kernel Patch, <code>device-id</code> and <code>compatible</code> is to spoof into a natively supported Broadcom ethernet for Catalina and earlier. AppleBCM57XXEthernet.kext is used for Big Sur and newer.
        </p>
      </td>
      <td>
        <table>
          <tr>
            <th>Key*</th>
            <th>Value</th>
            <th>Type</th>
          </tr>
          <tr>
            <td>built-in</td>
            <td>01</td>
            <td>Data</td>
          </tr>
      <tr>
            <td>compatible</td>
            <td>pci14e4,16b4</td>
            <td>String</td>
          </tr>
      <tr>
            <td>device-id</td>
            <td>B4160000</td>
            <td>Data</td>
          </tr>
        </table>
      </td>
    </tr>
<table>


## Kernel Extensions
This EFI <b>does not</b> contain any kext for the WiFi and BT.<br ><br >

### Kernel -> Add 

<table>
    <tr>
      <th>Kext</th>
      <th>Description</th>
    </tr>
      <tr>
      <td>
        <b>Lilu</b>
      </td>
      <td>
      </td>
    </tr>
        <tr>
        <tr>
      <td>
        <b>WhateverGreen</b>
      </td>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <b>AppleALC</b>
      </td>
      <td>Compiled specifically for ALC282, Layout ID 28.
      </td>
    </tr>
    <tr>
      <td>
        <b>ECEnabler</b>
      </td>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <b>VirtualSMC</b>
      </td>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <b>SMCProcessor</b>
      </td>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <b>SMCBatteryManager</b>
      </td>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <b>SMCLightSensor</b>
      </td>
      <td>In combination with SSDT-ALS0. Resolves brightness jump when adjusting brightness, further smoothens brightness transition.
      </td>
    </tr>
    <tr>
      <td>
        <b>VoodooPS2Controller & Plugins</b>
      </td>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <b>RTCMemoryFixup</b>
      </td>
      <td>In combination of an NVRAM entry <code>rtc-blacklist</code> : <code>B2</code>, resolves where laptop restarts when woken up from sleep.
      </td>
    </tr>
<tr>
      <td>
        <b>HibernationFixup</b>
      </td>
      <td>Adjusted to autohibernate when battery is set to 15%. In combination with the hbfx-ahbm nvram entry.
      </td>
    </tr>
    <tr>
      <td>
        <b>HoRNDIS</b>
      </td>
      <td>Allows USB Tethering from an Android phone.
      </td>
    </tr>
        <tr>
    <tr>
            <td>USBToolBox</td>
            <td rowspan="2" class="merged-cell"> Used instead of USBMap as that is SMBIOS dependent, and breaks if different SMBIOS model is used.
        </tr>
        <tr>
            <td>UTBMap</td>
        </tr>
        <tr>
        </tr>
        <tr>
      <td>
        <b>AppleBCM57XXEthernet</b>
      </td>
      <td>Enables Ethernet for Big Sur and newer.<table>
          <tr>
            <th>MinKernel</th>
            <th>MaxKernel</th>
          </tr>
          <tr>
            <td>20.00.0</td>
            <td></td>
          </tr>
        </table></td>
        </tr>
        <tr>
      </td>
    </tr>  
<table>

### Kernel ->  Patch
Broadcom BCM57786 Patch <br />
(Cosmetic) IOReg model

## NVRAM

**Added NVRAM Entries**:

Under **Add** > `7C436110-AB2A-4BBB-A880-FE41995C9F82`:

| Key* | Value | Type |
| :--- | :--- | :--- |
| SystemAudioVolume | 46 | Data |
| csr-active-config | 00000000  | Data |


   - `SystemAudioVolume` sets the boot chime volume to 70%.
        -  `46` is the Hexadecimal equivalent of 70.
   - `csr-active-config`'s entry `00000000` enabled SIP. FF0F0000 to disable, required for root patching.

<br />

Under **Add** and **Delete** > `4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102`:
| Key* | Value | Type |
| :--- | :--- | :--- |
| rtc-blacklist | B2 | Data |

- `rtc-blacklist` resolves wake, where it restarts instead of resuming from sleep.
        -  In combination with RTCMemoryFixup.kext

### What's not working?

[- [ ] AirDrop & other Airport related features
- [ ] Multi-touch gestures (4 fingers)
- [ ] Cannot access DRM content (Use chromium based browsers instead)
- [ ] WiFi & Bluetooth (macOS 12+) Notorious for having a really slow internet speed. >Available kexts are only upto Big Sur. Replace it with an Intel - this will save you from headache!</sup>
- [ ] Graphics Acceleration (macOS 13+) 
- [ ] Automatic Lid Wake when at sleep
- [ ] Fan reading (and so under Windows), so don't bother adding `SMCSuperIO.kext`]
- [ ] (https://github.com/unitedastronomer/E1-572G-Hackintosh/edit/Redo-README-for-simplicity/README.md#whats-not-working-1)

## Credits
- [doesprintfwork](https://github.com/doesprintfwork/All-in-one-Vanilla-AMD-Hackintosh-Guide/blob/f1a73610d02397f3291686c127a8918fea40f3ec/prerequisites/amd-clover-config.plist/smbios.md) GenSMBIOS guide
- [Jwise](https://github.com/jwise/HoRNDIS) for HoRNDIS
- [DhinakG](https://github.com/USBToolBox/tool) USBToolbox
- [CorpNewt](https://github.com/corpnewt/SSDTTime) GenSMBIOS and Propertree
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html) Guide
- [Acidanthera](https://github.com/acidanthera) Opencore and Lilu-based kexts


etc.



