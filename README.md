# Acer Aspire E1-572G — OpenCore Configuration
  
[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.9-blue.svg)](https://github.com/acidanthera/OpenCorePkg)<br>
<img align="right" src="assets/laptop_monterey.png" alt="laptop_monterey.png" width="250">
  
🛠️ This OpenCore configuration is optimized for this specific hardware. 

   * Tested to work from **High Sierra** (10.13) up to **Sonoma** (14)
     * Additional step is needed for **Ventura** (13) and **Sonoma** (14)
   * [Read this](assets/INFO.md) for more details.

### 💻 System Specification

| Category       | Component                                | Note |
|----------------|------------------------------------------|-|
| **CPU**        | Intel® Core™ i5-4200U                    ||
| **iGPU**       | Intel HD Graphics 4400                   |Support was dropped on Ventura, requires a OCLP root patch on post install.|
| **dGPU**       |                                          |Disabled, as it is not supported by macOS.|
| **Wi-Fi & Bluetooth** | AR9565                            |Limited only up to Big Sur, no working kext since Monterey.
| **Ethernet**   | BCM57786                                 ||
| **Audio Codec**| Realtek ALC282 <br> <sup>Layout ID: 28</sup>||
|**Input**|Synaptics TM2682|Gestures works, but wonky.|
|...|||



