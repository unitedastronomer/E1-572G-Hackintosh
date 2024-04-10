# ⚠️ Proceed at your own risk!
Please refer to the Dortania Opencore Install Guide as your main guide. Consider this as supplemental.

#### Reminder:
* In an EFI partition, there is an EFI folder with **BOOT** and **Microsoft** folder, be mindful when copy and pasting. Copy the OC folder within your laptop's EFI folder in your EFI partition, and replace the existing **BOOT** folder with the one from OpenCore.
* It is reccomended to edit config.plist with Propertree. 
* Don't stop midway of installing, either via `install macOS` app or USB installation! **JUST WAIT!**
   * However if it is looping the same error code over and over: remove the battery, and press power button for atleast 30 seconds.


# 📝 Requirements
*  **Ethernet** or Android Phone for USB Tethering<br >
   - iPhone USB Tethering does not work in Recovery
*  Replace AR9565 with an Intel or Broadcom mPCIe WiFi+BT Card<br >
   - No working kext for AR9565 on Monterey+
      - Infuriatingly slow on any macOS it can run.
*  Update BIOS to the [latest version](https://www.acer.com/us-en/support/product-support/Aspire_E1-572G)
   - This resolves the issue of the laptop failing to fully power down when shutting down.

# Preparation

### BIOS 

Configure the BIOS with these settings:
* **Secure Boot** > **Disabled**


<h3>config.plist</h3>

In the config.plist, section <code>PlatformInfo > Generic</code> is currently left empty, generate your own SMBIOS data. 
   * Use a **MacbookPro11,1** SMBIOS, no matter what version you are installing.
      * Using other SMBIOS will break USBMap.


 <br > 


### macOS Monterey and earlier specific
* Delete `amfi=0x80` in boot-arg before or after installation. This boot-arg is only necessary if root patching.
* If upgrading from Catalina or earlier to Ventura and earlier, you will need to temporarily use a supported SMBIOS for that version.

### macOS Ventura and Sonoma specific
* Graphics Acceleration had been dropped in Ventura, so you'll need to re-add it with the help of Opencore Legacy Patcher.

#### Before Installation
* Download the **LATEST** Opencore Legacy Patcher, and place it where you can easily access it under macOS.
* INSTALL macOS
#### After Installation
* Run OCLP, accept permissions. Then click the reboot when prompted by OCLP app.

Altenatively, you can actually make a USB installer that will automatically patch the graphics on the fly without the need to install OCLP post-installation of macOS. [Proceed to step 3 of this guide](https://github.com/AppleOSX/PatchSonomaWiFiOnTheFly?tab=readme-ov-file)


### OCLP users!
* Do not use Migration Assistant within the Setup Assistant (setup screen right after macOS installation)
* Do not use Migration Assistant if root patches are applied, revert patches first then apply it back after using Migration Assistant.


# Post-Install

### Troubleshoot
* Unable to [set the boot option back to macOS](https://dortania.github.io/OpenCore-Post-Install/multiboot/bootcamp.html#installation) after booting on windows?
* Stuck on a loop under verbose mode: NVRAM Reset; remove the battery, and press power button for 30 seconds.
* Broadcom Ethernet/ SSD Caddy/ or any PCI device not detected: NVRAM Reset; remove the battery, and press power button for 30 seconds.
* [Fixing Window features after installing macOS](https://github.com/5T33Z0/OC-Little-Translated/blob/main/I_Windows/Windows_fixes.md)

<details>
<summary>For those who will replace into Intel mPCIe WiFi and BT card:</summary><br >

* Bluetooth can be unstable when WiFi is active and connected on the 2.4 GHz band (e.g., stuttering sound when playing audio from a BT speaker). This is a [known issue](https://openintelwireless.github.io/itlwm/FAQ.html#can-i-use-bluetooth-with-wi-fi) with Intel bluetooth. 
* The AR9565 card only uses one antenna. Intel mPCIe cards typically come with two antenna connectors, so consider purchasing the appropriate antenna for the second connector to enhance coverage. Also note that only having one antenna in use still works without having to add another one. 
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

* I personally use Legacy instead of UEFI, that gets rid of the "8 apples glitch"
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
                     <li>The VGA port is actually a DisplayPort internally, you may need to adjust the device properties - such as the connector type, and the BUS ID. Not guaranteed to work as it maybe hardwired to the dGPU.</li>
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
* BCM57786 IOReg model (Cosmetic) (com.apple.iokit.AppleBCM5701Ethernet)
* BCM57786 IOReg model (Cosmetic) (com.apple.iokit.AppleBCM57XXEthernet)
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
| boot-arg| -v debug=0x100 keepsyms=1 ipc_control_port _options=0 | String |


   - `SystemAudioVolume` sets the boot chime volume to 70%.
        -  `46` is the Hexadecimal equivalent of 70.
   - `csr-active-config` is SIP setting.

- `-v` shows verbose on boot
- `amfi=0x80` disables Apple Mobile File Integrity, needed to allow patching.
- `keepsyms=1` prevent reboot on kernel panic
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
