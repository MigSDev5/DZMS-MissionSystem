<b>Features:
- Automatic ai kill coins.
- Coins on AI.
- Multiples missions major and minor.
- New static AI system.
- Marker color.
- 2 new missions major and 1 new misison minor.
- Mission is locked if the player is within 600 meters.
- it takes at least 1 player on the server for misisons to begin appearing.</b>

 <i>Everything is configurable in the file DZMSConfig.sqf.</i>

Installation: 
Download the Github Zip folder and open it with your unPacker of choice.

https://github.com/MigSDev5/DZMS-MissionSystem/archive/master.zip

Extract it to your Desktop or somewhere where you won't lose it. Inside the Zip is this Readme.MD, a folder called DZMS.

Open your Server.PBO with the PBO unPacker of your choice.

Put the "DZMS" folder into your Server.pbo.

Open up your server_monitor.SQF in the system folder in your server.PBO.

Search for this line

allowConnection = true;

And insert this line directly above it.
[] ExecVM "\z\addons\dayz_server\DZMS\DZMSInit.sqf";

Now just rePack your PBO and enjoy!

Credits: 
https://github.com/SMVampire
