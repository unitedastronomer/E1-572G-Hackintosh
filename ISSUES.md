#### Note:
* **Do not update AppleALC**. `-alcbeta` boot-arg allows AppleALC to load up until macOS Sequoia. It is compiled to only contain layout 28 of ALC282. 
	* 86KB (vs. originally 3.43 MB).
* The install is taking too long?; **patience is key!**
	* Do not manually power off or reboot your machine as this will break the installation and require reinstalling. 
	* However, if you can't get past a looping error (`-v` boot-arg must be present to see), remove the battery, and press the power button for at least 30 seconds.

Other Issues:
* Sleep may randomly break if the machine is still doing a heavy task while it is transitioning into sleep mode on it's own. Temporary disable sleep via `pmset` command if you are doing something important.
* If you at least once booted from Windows then macOS, certain ports transfer from XHC to EHC after sleep.
* VGA port is actually a DisplayPort internally according to the schematics, you may need to adjust the device properties - such as the connector type, bus ID, etc.  
* WiFi icon will only show one bar, this is a known issue with this WiFi card.

### What's not working?

- AirDrop; Universal Control
	- If you need these features, replace card with **BCM94360HMB** and stay on macOS 11.x — most airport features do not work on this card starting macOS 12.x.
		- This laptop uses mPCIe slot for the WiFi Card
- Playing DRM content (on Safari 14+ and macOS 11+)
	- To work around this, use a Chromium-based browser or Firefox.
- Bluetooth (Atheros; on macOS 12+)
	- To work around this, use a Bluetooth dongle with Broadcom/CSR chip (e.g, ASUS BT400, and TP-Link UB400).
- Lid Wake (from sleep)
	- Press a key to wake.
- USB wake (from sleep)
	- Wake from **USB** Mouse/keyboard does not work,  press a key from built-in keyboard to wake.
- Automatic Sleep on critical battery level
	- To work around this, use [this app](https://github.com/HsOjo/SleeperX).
- Hibernation[.](https://github.com/acidanthera/bugtracker/issues/386#issuecomment-503042790)
	- Disable it. 
- Fan reading
	- VirtualSMC does not support fan reading on ENE ECs.
 - Multi-finger (3+) Trackpad Gestures
	- Hardware limitation, trackpad is PS2.
 - & a [lot more](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/1008) on macOS Ventura+
