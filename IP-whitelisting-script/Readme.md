README for IP-whitelist-script   

This script is an interactive type. It requires the aws profile, SG, port number as an inputs through prompt.

Dependency packages: jq
On Mac: brew install jq
On linux: apt-get install jq

Before running the script the aws cli should be configured and need to set the credentials within an aws profiles. 
It will list all the profiles and SG's through prompt you need to select the number like

if 1) default
   2) fansportiz

Then you need to enter the input as 1
It will pick the default aws profile to run the CLI command.

You have 2 options to enter the IP address
1) Autodetect 2)manually

If you select the 1, it will pick your IP address and whitelist on your IP address.

If you need to whitelist the another IP address or allow all traffic you need to use the second option.
If you press 2
you need to enter IP like 0.0.0.0/0

It will also prompt you with confirmation before updating the security group.
