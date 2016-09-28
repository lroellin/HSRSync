# HSRSync
HSR Sync script for Windows. Automatically establishes VPN (if installed) and quite customizable.

## Does
* Check network connection. If not in HSR network, connect via VPN
  * Ask for credentials (with default username as you don't want to type that every time)
  * Check if it succeeded, or abort
* Maps the network drive
* Syncs, will only display new or changed files

## Customizability
Almost every aspect is customizable by changing a single variable at the top.
* Network drive
* Network drive letter
* Base path on that network drive
* Base path on your computer
* VPN connection endpoint
* Default VPN user name
* Host to test if VPN connection is established
* How long to wait before testing if the VPN connection is established after trying to connect

You can also customize your modules to sync.

## How to run
* Customize the values to your environment
* This is an unsigned Powershell Script. You may need to change your Execution Policy. There are many manuals on the Internet
* Right click / Run with Powershell

## Requirements
You need to have the Cisco AnyConnect VPN client installed. If it's not found, check the parameters in VPN.ps1

## Credits
VPN.ps1 is the work of www.cze.cz and only customized slightly. 
