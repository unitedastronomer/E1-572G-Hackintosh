# Acer Aspire E1-572G — OpenCore Configuration
[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.9-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![macOS](https://img.shields.io/badge/macOS-Monterey-brightgreen.svg)]()


🛠️ This OpenCore configuration is optimized for this specific hardware. 
   * Tested to work from **High Sierra** (10.13) up to **Sonoma** (14)
   * Additional configuration is needed for **Ventura** (13) and **Sonoma** (14)
   * [Additional info](ADDITIONAL_INFO.md)

<h1>💻 System Specification</h1>

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
          <td>Intel HD Graphics 4400</td>
        </tr>
        <tr>
          <td><strong>dGPU</strong></td>
          <td><i>Unsupported</i></td>
        </tr>
        <tr>
          <td><strong>Wi-Fi & BT</strong></td>
          <td>Qualcomm Atheros AR9565 <br ><sup>Limited only up to Big Sur</sup></td>
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
  </tr>
  <tr>
    <td>
      <img align="right" src="Images/laptop_monterey.png" alt="laptop_monterey.png" width="250">
    </td>
  </tr>
</table>


<details>
<summary>⚠️ <strong>What's not working?</strong></summary><br >

* 🛜 WiFi & Bluetooth on Monterey (12)+<br >
<sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;There's no working kext for AR9565 on Monterey and newer</sup>
* 🚀 Graphics Acceleration on Ventura (13)+<br >
<sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Root patching using OCLP is required</sup>
* 💻 Automatic Lid Wake<br >
<sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waking up from sleep requires keyboard tap.<sup>
* 📲 AirDrop<br >
<sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and other Airport related features</sup>
* 🫳 Multi-touch gestures<br >
<sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;with 4 fingers<sup>
* 🔒 Accessing DRM content<br >
<sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Use chromium based browsers instead</sup>
* 🌀 Fan reading<br >
<sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(and so under Windows), so don't bother adding `SMCSuperIO.kext`</sup>
</details>


## Credits
- [Jwise](https://github.com/jwise/HoRNDIS) for HoRNDIS
- [CorpNewt](https://github.com/corpnewt/SSDTTime) SSDTTime, GenSMBIOS, Propertree, and USBMap
- [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html) Guide, OCLP, and kexts
- [Acidanthera](https://github.com/acidanthera) Opencore and Lilu-based kexts


etc.



