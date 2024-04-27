# Acer Aspire E1-572G — OpenCore Configuration

  <img align="right" src="assets/laptop_monterey.png" alt="laptop_monterey.png" width="250">
  
[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.9-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](https://github.com/unitedastronomer/E1-572G-Hackintosh/blob/main/LICENSE.md)


<p align="center">
<strong>Status: Maintained</strong><br>
&nbsp;&nbsp;
<a href="https://github.com/unitedastronomer/E1-572G-Hackintosh/archive/refs/heads/main.zip"><strong>Download »</strong></a> 
&nbsp;·&nbsp;
<a href="https://github.com/unitedastronomer/E1-572G-Hackintosh/issues">Report issue</a>
&nbsp;&nbsp;
</p>
<br>

🛠️ This OpenCore configuration is optimized for this specific hardware. 

   * Tested to work from **High Sierra** (10.13) up to **Sonoma** (14)
   * Additional configuration is needed for **Ventura** (13) and **Sonoma** (14)
   * [Read this](assets/INFO.md) for more details.

<h1>💻 System Specification</h1>

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
          <td><strong>Ethernet</strong></td>
          <td>Broadcom NetXtreme BCM57786<i>x</i></td>
        </tr>
        <tr>
          <td><strong>Audio Codec</strong></td>
          <td>Realtek ALC282<br ><sup>Layout 28</sup></td>
        </tr>
</table>

<details>
   <summary><b>⚠️ What's not working?</b></summary>
  <br>
   
🛜 WiFi & Bluetooth on Monterey and newer<br >
<sup>There's no working kext for AR9565 on Monterey and newer</sup>

🚀 Graphics Acceleration on Ventura and newer<br >
<sup>Root patching via OCLP is required</sup>

💻 Automatic Lid Wake<br >
<sup>Waking up from sleep requires keyboard tap<sup>

📲 AirDrop<br >
<sup>; and other Airport related features</sup>

🔑 Accessing DRM content<br >
<sup>Use chromium based browsers instead</sup>

💨 Fan reading<br >
<sup>(and so under Windows)</sup>

</details>
   

