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
An XML configuration file is **nescessary** for running the script.
The location of this file can be changed at the top of the script.

The example below is based on the XML-schema defined in *settings.xsd*.
Your own configuration must follow this schema to be interpreted properly.
```xml
<?xml version='1.0' encoding='UTF-8'?>
<sync
	xmlns="https://github.com/lroellin/HSRSync"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<configuration>
		<network>
			<drive>\\hsr.ch\root</drive>
			<driveLetter>Y</driveLetter>
		</network>
		<basePath>
			<source>alg\skripte</source>
			<destination>YOUR_DESTINATION_FOLDER</destination>
		</basePath>
		<vpn>
			<host>vpn.hsr.ch</host>
			<username>YOUR_HSR_USERNAME</username>
			<testHost>skripte.hsr.ch</testHost>
			<waitTime>10</waitTime>
		</vpn>
	</configuration>
	<sources>
		<source>Informatik\Fachbereich\Algorithmen_und_Datenstrukturen_2</source>
		<source>Informatik\Fachbereich\C++</source>
		<source>Informatik\Fachbereich\Computernetze_1</source>
		<source>Informatik\Fachbereich\Informations-_und_Codierungstheorie</source>
	</sources>
</sync>

```

## How to run
* Customize the values to your environment
* This is an unsigned Powershell Script. You may need to change your Execution Policy. There are many manuals on the Internet
* Right click / Run with Powershell. For convenience, there is also a batch file that does exactly that.

## How to update
Currently you'll have to overwrite the whole script whenver I publish an update you want to install. In the future, there will be an XML-based configuration.

## Requirements
You need to have the Cisco AnyConnect VPN client installed. If it's not found, check the parameters in VPN.ps1

## License
I used the MIT license as I don't want you to open-source everything when you use this code in any of your code. It's appreciated though and I'm always happy about pull requests.

## Credits
* VPN.ps1 is the work of www.cze.cz. Customized slightly
* Toast notification code is the work of 'altrive'. Customized slightly.
