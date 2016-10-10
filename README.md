# HSRSync
HSR Sync script for Windows. Automatically establishes VPN (if installed) and quite customizable.

## Does
* Check network connection. If not in HSR network, connect via VPN
  * Ask for credentials (with default username as you don't want to type that every time)
  * Check if it succeeded, or abort
* Maps the network drive
* Syncs, will only display new or changed files
* Displays a small (toast) notification when done

## Customizability
Almost every aspect is customizable by changing your XML configuration.
* Network drive
* Network drive letter
* Base path on that network drive
* Base path on your computer
* VPN connection endpoint
* Default VPN user name
* Host to test if VPN connection is established
* How long to wait before testing if the VPN connection is established after trying to connect

You can also customize your modules to sync.

## Configuration
An XML configuration file is **necessary** for running the script.
The location of this file can be changed at the top of the script. Default is *settings.xml*. There is a template, *settings-template.xml* which you can use. 

The example below is based on the XML-schema defined in *settings.xsd*. Your own configuration must follow this schema to be interpreted properly.
## How to run
* Customize the values to your environment
* This is an unsigned Powershell Script. You may need to change your Execution Policy. There are many manuals on the Internet
* Right click / Run with Powershell. For convenience, there is also a batch file that does exactly that.

## Requirements
You need to have the Cisco AnyConnect VPN client installed. If it's not found, check the parameters in VPN.ps1

## License
I used the MIT license as I don't want you to open-source everything when you use this code in any of your code. It's appreciated though and I'm always happy about pull requests.

## Credits
* VPN.ps1 is the work of www.cze.cz. Customized slightly
* Toast notification code is the work of 'altrive'. Customized slightly.
