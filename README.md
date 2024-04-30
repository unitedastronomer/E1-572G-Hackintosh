# Acer Aspire E1-572G — OpenCore Configuration


[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.9-blue.svg)](https://github.com/acidanthera/OpenCorePkg)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](https://github.com/unitedastronomer/E1-572G-Hackintosh/blob/main/LICENSE.md)<br>
 
### 🛠️ This OpenCore configuration is optimized for this specific hardware. 
   * [Read this](assets/INFO.md) for more details.


### 💻 System Specification

| Category       | Component                               |
|----------------|-----------------------------------------|
| **CPU**        | Intel® Core™ i5-4200U Processor         |
| **iGPU**       | Intel HD Graphics 4400 <br><sup>Support dropped since Ventura, requires root patching via OCLP to restore Graphics Acceleration</sup>                  |
| **dGPU**       | AMD Radeon HD 8670M <br><sup>_Disabled_, not supported on macOS</sup>        |
| **Wi-Fi & BT** | Qualcomm QCA9565 / AR9565 Wireless <br><sup>Limited only up to Big Sur, no working kext since Monterey</sup>      |
| **Ethernet**   | Broadcom NetXtreme BCM57786 Gigabit Ethernet PCIe                            |
| **Audio Codec**| Realtek ALC282<br><sup>Layout ID: 28</sup>                                   |
| **Trackpad**   | Synaptics TM2682 <br><sup>PS/2</sup>                                          |


