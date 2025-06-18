### What's not working?
- Bluetooth
  - Atheros BT are unsupported on Monterey and newer. However if you wish to use Bluetooth, figure it out on your own. If you wish to use BT theough dongle or another card, disable the kernel patch in the config.plist that disables entire BT stack entirely.
- Airport features
	- If you need these features, replace card with **BCM94360HMB** and stay on macOS 11.x — most airport features do not work on this card starting macOS 12.x.
		- This laptop uses mPCIe slot for the Wi-Fi Card
- Playing DRM content (on Safari 14+ and macOS 11+)
	- To work around this, use a Chromium-based browser or Firefox.
- Lid Wake (from sleep)
	- Press a key to wake.
- USB wake (from sleep)
	- Wake from **USB** Mouse/keyboard does not work,  press a key from built-in keyboard to wake.
- Automatic Sleep on critical battery level
	- To work around this, use [this app](https://github.com/HsOjo/SleeperX).
- Hibernation
- Fan reading
	- VirtualSMC does not support fan reading on ENE ECs.
 - 3+ Multi-touch Trackpad Gestures
	- Hardware limitation, trackpad is PS2.
 - Clamshell mode (when connected to A/C and external display)
 - & a [lot more](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/1008) on macOS macOS 13+

### Fixing Sleep issues
If you have issues with sleep, run the following commands in Terminal:

```
sudo pmset hibernatemode 0
sudo rm /var/vm/sleepimage
sudo touch /var/vm/sleepimage
sudo chflags uchg /var/vm/sleepimage
```
Disable these settings:
- Wake on LAN
- Power Nap
- In Bluetooth Settings, "Advanced Options…" disable the 3rd entry about allowing Bluetooth devices to exit sleep

### Note
* The install is taking too long? Just be patient! Do not manually power off or reboot your machine as this will break the installation and require reinstalling. 
* Do not use Migration Assistant within Setup Assistant (setup screen right after macOS installation) on macOS 13+ (Ventura and newer). It would be too laggy to navigate.
* Do not use Migration Assistant if OCLP root patches are applied, revert patches first.
* Can't add or adjust Memoji in settings?
	* Scroll through the emojis, this will zoom out the icons allowing you to edit memojis.
* Sleep may randomly break if the machine is still doing a **heavy** task while it is transitioning into sleep mode on it's own. 
     * If you are doing something important, temporary disable sleep via `pmset` command.
```
sudo pmset disablesleep 1
```
> Set it to `0` to re-enable sleep option.
* VGA port is actually a DisplayPort internally according to the schematics, you may need to adjust the device properties. 

### Other Weird Issues:

* If you at least once booted from Windows then macOS, certain ports switch from XHC to EHC after sleep.  
* WiFi icon will only show one bar, this is a known issue with this WiFi card.
