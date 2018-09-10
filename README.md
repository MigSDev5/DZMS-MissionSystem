Installation
Download the Github Zip folder and open it with your unPacker of choice.

https://github.com/SMVampire/DZMS-DayZMissionSystem/archive/master.zip

Extract it to your Desktop or somewhere where you won't lose it. Inside the Zip is this Readme.MD, a folder called Documentation, and one called DZMS.

Open your Server.PBO with the PBO unPacker of your choice.

Put the "DZMS" folder into your Server.pbo.

Open up your server_monitor.SQF in the system folder in your server.PBO.

Search for this line

allowConnection = true;

And insert this line directly above it.
[] ExecVM "\z\addons\dayz_server\DZMS\DZMSInit.sqf";

Now just rePack your PBO and enjoy!
