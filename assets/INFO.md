# ⚠️ Proceed at your own risk!
Please refer to the Dortania Opencore Install Guide as your main guide. Consider this as supplemental.

### ⚠️ What's not working?

|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| Note |
|---------------------------|------|
| WiFi & Bluetooth (macOS 12+)<br><sup>Qualcomm QCA9565 / AR9565 Wireless</sup> | There's no working kext for it since Monterey, so if you need WiFi, it's best to stay on Big Sur. It's recommended to switch to an Intel card, as the speed with this one is infuriatingly slow on any macOS version it can run.|
| Graphics Acceleration (macOS 13+)| Support for Haswell iGPU had been dropped in Ventura. Root patching using OCLP is required, this requires relaxing some security feature to restore it. If you feel uncomfortable about this, better stay in Monterey.                           |
| AirDrop<br><sup>;and other Airport related features</sup> |  Requires [supported](https://dortania.github.io/Wireless-Buyers-Guide/types-of-wireless-card/mpcie.html) Broadcom **mPCIe** WiFi card. However, these mPCIe cards have a limitation where features like AirDrop only work correctly up to the Big Sur. To work around this, you can use a BCM94360NG card with an mPCIe to M.2 A+E key adapter. Just keep in mind that you might need to modify it to properly fit inside your device.
| Automatic Lid Wake | Waking up from sleep requires keyboard intervention. I got it to work one time, but I was not able to replicate it again. |
| Accessing DRM content (Safari 14+ and macOS 11+) | Use Firefox, or any chromium based browsers instead. |
| Fan reading | and so under Windows. |
| Hibernation | :) |

# Preparation

*  **Ethernet**, or an Android Phone for USB Tethering. iPhone USB Tethering does not work in Recovery
* `Optional` Replace WiFi card with an Intel or [supported](https://dortania.github.io/Wireless-Buyers-Guide/types-of-wireless-card/mpcie.html) Broadcom **mPCIe** (WiFi + BT card) <br >

### BIOS 

*  **Update BIOS to the** [**latest version**](https://www.acer.com/us-en/support/product-support/Aspire_E1-572G). This resolves the issue of the laptop failing to fully power down when shutting down.

* Configure the BIOS with these settings: **Secure Boot** -> **Disabled**

### config.plist

In the config.plist, section <code>PlatformInfo > Generic</code> is currently left empty, generate your own SMBIOS data. 
   * Use a **MacbookPro11,1** SMBIOS

* This OC configuration has disabled AMFI, and SIP partially disabled, these are necessary for root patching. **Leave config.plist AS IS if installing Ventura and Sonoma**. If you choose to install Monterey or earlier, you can leave this config as-is or re-enable them by:
    * Delete `amfi=0x80` in boot-args, re-enables AMFI.
    * Set `csr-active-config` to `00000000` fully enable SIP. 
    * Disable these Kernel -> Patches
      * Force FileVault on Broken Seal
      * Disable Library Validation Enforcement
      * Disable _csr_check() in _vnode_check_signature
    * Set `SecureBootModel` to `Default`

# Installation 

#### Note:

* Don't stop midway of the installation process; **patience is key!**
If you can't get past a looping error code (from e.g., `failed lookup: name = com.apple.logd`): remove the battery, and press power button for at least 30 seconds.



### macOS Ventura+
Graphics Acceleration had been dropped in Ventura, so you'll need to bring it back with the help of Opencore Legacy Patcher.

1. Before Installation
 * Download the **LATEST** Opencore Legacy Patcher, and place it where you can easily access it under macOS.
 * Proceed with macOS installation.
2. After Installation
 * Run OCLP, accept permissions. Then click the reboot when prompted by OCLP app.

#
 * Do not use Migration Assistant within the Setup Assistant (setup screen right after macOS installation)
 * Do not use Migration Assistant if root patches are applied, revert patches first then apply it back after using Migration Assistant.

#

Altenatively, you can actually make a USB installer that will automatically patch the graphics on the fly without the need to install OCLP post-installation of macOS. [Proceed to step 3 of this guide](https://github.com/AppleOSX/PatchSonomaWiFiOnTheFly?tab=readme-ov-file)



# Post-Install



### Troubleshoot
* Unable to [set the boot option back to macOS](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) after booting on windows?
* Any PCI device not detected (e.g., Broadcom Ethernet): Remove the battery, and press power button for at least 30 seconds.
* [Fixing Window features after installing macOS](https://github.com/5T33Z0/OC-Little-Translated/blob/main/I_Windows/Windows_fixes.md)
* [Use Windows partition under macOS via VMWare](https://github.com/mackonsti/s145-14iwl/blob/master/Fusion.md)
* [Install Windows on a partition without USB](https://github.com/5T33Z0/OC-Little-Translated/blob/main/I_Windows/Install_Windows_NoBootcamp.md)
  * Just wait when booting for the first time, it will take a while!
  * Set macOS as Startup Disk so that the selector on boot menu will automatically highlight macOS, instead of what comes first in the picker.
* It is recommended to edit config.plist with Propertree.
  * If you choose to use Opencore Configurator, it's known to corrupt plist.
    * If that happens, open the config.plist with a text editor, check the last line `</plist>`, if it is missing the last character: `>`, add it back. It rarely happens but it can happen.
    * When you use it, do not immediately restart the laptop after saving a .plist, wait for at least some seconds.
  * If you choose to use OCAT, the ocvalidate it uses is outdated. It should still work, but the ocvalidate will throw errors, just ignore it.



* There is a weird issue where once you boot from Windows, and then to macOS. The USB 2.0 and internal ports transfers from XHC to EHC aftersleep. I am not sure if this break anything, but I disabled the EHC controller anyway.

<details>
<summary>For those who will replace into Intel mPCIe WiFi and BT card:</summary><br >

* Bluetooth can be unstable when WiFi is active and connected on the 2.4 GHz band (e.g., stuttering sound when playing audio from a BT speaker). This is a [known issue](https://openintelwireless.github.io/itlwm/FAQ.html#can-i-use-bluetooth-with-wi-fi) with Intel bluetooth. 
* The AR9565 card only uses one antenna. Intel mPCIe cards typically come with two antenna connectors, so consider purchasing the appropriate antenna for the second connector to enhance coverage. Also note that only having one antenna in use still works without having to add another one. Adding another one might improve bluetooth connectivity.
</details>


### Cosmetic

* Disable Verbose Mode: Remove `-v` under NVRAM -> Add > 7C436110-AB2A-4BBB-A880-FE41995C9F82 > boot-args.
* Hide boot picker: Misc -> Boot -> ShowPicker. Set it to **`Disabled`**.
  - Only do if you are **NOT** multi-booting.



# config.plist details
This is incomplete.


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
                     The VGA port is actually a DisplayPort internally, you may need to adjust the device properties - such as the connector type, and the BUS ID. Not guaranteed to work as it maybe hardwired to the dGPU.<br /><br />
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
            <td>framebuffer-con2-enable</td>
            <td>01000000</td>
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
<table>

### Booter
* Skip Board ID check

## Kernel Extensions

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
       Patching engine
      </td>
    </tr>
        <tr>
        <tr>
      <td>
        <b>WhateverGreen</b>
      </td>
      <td>
       Graphics patcher
      </td>
    </tr>
    <tr>
      <td>
        <b>AppleALC</b>
      </td>
      <td>
       Audio patcher <br />
       Compiled specifically for ALC282, Layout ID 28.
      </td>
    </tr>
    <tr>
      <td>
        <b>ECEnabler</b>
      </td>
      <td>
       Enable EC reading longer than 8 bytes, useful for battery reading.
      </td>
    </tr>
    <tr>
      <td>
        <b>VirtualSMC</b>
      </td>
      <td>
       SMC emulator
      </td>
    </tr>
    <tr>
      <td>
        <b>SMCProcessor</b>
      </td>
      <td>
       Allow CPU temperature reading
      </td>
    </tr>
    <tr>
      <td>
        <b>SMCBatteryManager</b>
      </td>
      <td>
       Allow battery percentage reading
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
       Trackpad, mouse, and keyboard
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
        <b>USBMap</b>
      </td>
      <td>
      </td>
    </tr>
<tr>
      <td>
        <b>AMFIPass</b>
      </td>
      <td>
Partially re-enables AMFI on root patched systems. This can be handy if running into issues with an application you use related to AMFI.
      </td>
    </tr>
        </tr>
<tr>
      <td>
        <b>RestrictEvents</b>
      </td>
      <td>
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
            <td>FakePCIID</td>
            <td rowspan="2" class="merged-cell"> Enables Ethernet for Catalina and older.
        </tr>
        <tr>
            <td>FakePCIID_BCM57XX_as_BCM57765</td>
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

Additional kext I recently added:
* `HibernationFixup` - Configured to automatically hibernate when battery reaches critical battery level.
* `RSRHelper` - taken from an EFI made with OCLP for real macs, "Fixes Rapid Security Response Support on root patched installs"."





### Kernel ->  Patch
* Broadcom BCM57786 Patch
  * This is just a FakePCIID alternative, this is disabled by default.
* BCM57786 SysReport model (Cosmetic) (com.apple.iokit.AppleBCM5701Ethernet)
* BCM57786 SysReport model (Cosmetic) (com.apple.iokit.AppleBCM57XXEthernet)
* Force FileVault on Broken Seal
* Disable Library Validation Enforcement
* Disable _csr_check() in _vnode_check_signature
* Disable RTC wake scheduling
* Enable SATA Hot Plugging (Big Sur+)


## NVRAM

**Added NVRAM Entries**:

Under -> `7C436110-AB2A-4BBB-A880-FE41995C9F82`:

| Key* | Value | Type |
| :--- | :--- | :--- |
| SystemAudioVolume | 46 | Data |
| csr-active-config |   | Data |
| boot-arg| -v amfi=0x80 ipc_control_port _options=0 | String |


   - `SystemAudioVolume` sets the boot chime volume to 70%.
        -  `46` is the Hexadecimal equivalent of 70.
   - `csr-active-config` is SIP setting.

- `-v` shows verbose on boot
- `amfi=0x80` disables Apple Mobile File Integrity, needed to allow patching.
- `ipc_control_port_options=0` a workaround on root patched systems on Sonoma where some apps don't start or crash immediately

<br />

Under -> `4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102`:
| Key* | Value | Type |
| :--- | :--- | :--- |
| rtc-blacklist | B2 | Data |
| rev patch | sbvmm | String |

- `sbvmm` forces VMM SB model, allowing OTA updates for unsupported models on macOS 11.3 or newer
- `rtc-blacklist` resolves wake, where it restarts instead of resuming from sleep.
        -  In combination with RTCMemoryFixup.kext

This is incomplete.

## Credits

Guides:
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html): OpenCore Install Guide
- [5T33Z0](https://github.com/5T33Z0): [Remapping Brightness Keys](https://github.com/5T33Z0/OC-Little-Translated/blob/main/05_Laptop-specific_Patches/Fixing_Keyboard_Mappings_and_Brightness_Keys/Customizing_ThinkPad_Keyboard_Shortcuts.md), [Slimming AppleALC](https://github.com/5T33Z0/AppleALC-Guides/tree/main/Slimming_AppleALC)

Tools:
- [CorpNewt](https://github.com/corpnewt/SSDTTime): SSDTTime, GenSMBIOS, Propertree, and USBMap
- [Acidanthera](https://github.com/acidanthera/MaciASL): MaciASL
- [Benbaker76](https://github.com/benbaker76/Hackintool): Hackintool
<br>


# 📜 **License** <br>

This repo is licensed under the [MIT License](https://github.com/unitedastronomer/E1-572G-Hackintosh/blob/main/LICENSE.md), this OpenCore configuration is made of multiple external applications from different people and organizations. [See each program for their licensing](REFERENCE.md).
