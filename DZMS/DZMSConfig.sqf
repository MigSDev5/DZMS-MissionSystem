/*
	DayZ Mission System Config by Vampire
	DZMS: https://github.com/SMVampire/DZMS-DayZMissionSystem
*/

///////////////////////////////////////////////////////////////////////
// Do you want your players to gain humanity from killing mission AI?
DZMSMissHumanity = true;

// How Much Humanity?
DZMSCntHumanity = 25;

// put coin on units
DZMSUseCoins = true;

// Coins Amount
DZMSCoinsAmount = 100; // if you want a random amount, use this: DZMSCoinsAmount = round random 100;

// Do You Want AI to use NVGs?
//(They are deleted on death)
DZMSUseNVG = true;

// Do you want AI to use RPG7V's?
//(Only one unit per group spawn will have one)
DZMSUseRPG = false;

// Do you want AI kills to count as bandit kills?
DZMSCntBanditKls = true;

// Do you want AI to disappear instantly when killed?
DZMSCleanDeath = false;

// Do you want AI that players run over to not have gear?
// (If DZMSCleanDeath is true, this doesn't matter)
DZMSRunGear = false;

// How long before bodies disappear? (in seconds) (default = 2400)
DZMSBodyTime = 2400;

// Percentage of AI that must be dead before mission completes (default = 0)
//( 0 is 0% of AI / 0.50 is 50% / 1 is 100% )
DZMSRequiredKillPercent = 1;

// How long in seconds before mission scenery disappears (default = 1800 / 0 = disabled)
DZMSSceneryDespawnTimer = 1000;

// Should crates despawn with scenery? (default = false)
DZMSSceneryDespawnLoot = false;

//////////////////////////////////////////////////////////////////////////////////////////
// You can adjust the weapons that spawn in weapon crates inside DZMSWeaponCrateList.sqf
// You can adjust the AI's gear inside DZMSAIConfig.sqf in the ExtConfig folder also.
//////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////
// Do you want to use static coords for missions?
// Leave this false unless you know what you are doing.
DZMSStaticPlc = false;

// Array of static locations. X,Y,Z
DZMSStatLocs = [
	[0,0,0],
	[0,0,0]
];

//////////////////////////////////////////////////////////////////////////////////////////
// Do you want to place some static AI in a base or similar?
// Leave this false unless you know what you are doing.
DZMSStaticAI = false;

// How long before they respawn? (in seconds) (default 2 hours)
// If set longer than the amount of time before a server restart, they respawn at restart
DZMSStaticAITime = 7200;

// How many AI in a group? (Past 6 in a group it's better to just add more positions)
DZMSStaticAICnt = 4;

// Array of Static AI Locations
DZMSStaticSpawn = [
	[0,0,0],
	[0,0,0]
];

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Do you want vehicles from missions to save to the Database? (this means they will stay after a restart)
// If False, vehicles will disappear on restart. It will warn a player who gets inside of a vehicle.
// This is experimental, and off by default in this version.
DZMSSaveVehicles = false;

/////////////////////////////////////////////////////////////////////////////////////////////
// These are arrays of vehicle classnames for the missions.
// Adjust to your liking.

//Armed Choppers (Huey)
DZMSChoppers = ["UH1H_DZ","Mi17_DZ"];

//Small Vehicles (Humvees)
DZMSSmallVic = ["hilux1_civil_3_open_EP1","SUV_TK_CIV_EP1","HMMWV_DZ","UAZ_Unarmed_UN_EP1"];

//Large Vehicles (Urals)
DZMSLargeVic = ["Ural_TK_CIV_EP1","Ural_INS"];

/*///////////////////////////////////////////////////////////////////////////////////////////
There are two types of missions that run simultaneously on a the server.
The two types are Major and Minor missions.

Major missions have a higher AI count, but also have more crates to loot.
Minor missions have less AI than Major missions, but have crates that reflect that.

Below is the array of mission file names and the minimum and maximum times they run.
Do not edit the Arrays unless you know what you are doing.
*/
DZMSMajorArray = ["EM1","EM2","EM3","EM4","EM5","EM6","EM7","EM8","EM9"];
DZMSMinorArray = ["SM1","SM2","SM3","SM4","SM5","SM6","SM7"];

// maximum of major missions that spawn at the same time
DZMSMaxMissionsMaj = 2;

// maximum of minor missions that spawn at the same time
DZMSMaxMissionsMin = 2;

// distance between missions
DZMSMissionsDistance = 700;

// color marker for the major misisons
DZMSMajColorMarker = "ColorRed";

// color marker for the minor misions
DZMMinColorMarker = "ColorBlue";

// player's proximity to block the mission
DZMSMissionPlayerRange = 600;

// The Minumum time in seconds before a major mission will run.
// At least this much time will pass between major missions. Default = 300 (5 Minutes)
DZMSMajorMin = 300;

// Maximum time in seconds before a major mission will run.
// A major mission will always run before this much time has passed. Default = 900 (15 Minutes)
DZMSMajorMax = 900;

// Time in seconds before a minor mission will run.
// At least this much time will pass between minor missions. Default = 240 (4 Minutes)
DZMSMinorMin = 240;

// Maximum time in seconds before a minor mission will run.
// A minor mission will always run before this much time has passed. Default = 400 (6.6 Minutes)
DZMSMinorMax = 400;

// time in second of the spawn of the first Major four missions
DZMSIntMajDefault = 15;

// time in second of the spawn of the first Minor four missions
DZMSIntMinDefault = 10;

// time in seconds or the mission will be cleaned once validated by the player
DZMSCleanUpTime = 2100;

// Blacklist Zone Array -- missions will not spawn in these areas
// format: [[x,y,z],radius]
// Ex: [[06325,07807,0],300] //Starry Sobor
DZMSBlacklistZones = [
	[[0,0,0],50]
];

/*=============================================================================================*/
// Do Not Edit Below This Line
/*=============================================================================================*/
DZMSVersion = "1.2";
