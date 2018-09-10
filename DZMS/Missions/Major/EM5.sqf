/*
	Bandit Supply Heli Crash by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	New Mission Format by Vampire
*/

private ["_missName","_coords","_ranChopper","_chopper","_truck","_trash","_trash2","_crate","_crate2","_marker","_markerA","_markerB","_group1","_group2","_group3","_group4","_status","_endMission","_DZMSUnitsMajor"];

//Name of the Mission
_missName = "Helicopter Landing";

DZMSMajRunning = DZMSMajRunning + 1;
DZMSMajCount = DZMSMajCount + 1;

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"A Supply Helicopter has been Forced to Land!\nStop the Bandits from Taking Control of it!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
_marker = [_coords,_missname] call DZMSAddMajMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"EM5"];

//We create the vehicles like normal
_ranChopper = ["heli"] call DZMSGetVeh;
_chopper = createVehicle [_ranChopper,_coords,[], 0, "NONE"];

//DZMSSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_chopper] call DZMSSetupVehicle;
_chopper setDir -36.279881;

_truck = createVehicle ["HMMWV_DZ",[(_coords select 0) - 8.7802,(_coords select 1) + 6.874,0],[], 0, "CAN_COLLIDE"];
[_truck] call DZMSSetupVehicle;

//Lets add the scenery
_trash = createVehicle ["Body1",[(_coords select 0) - 3.0185,(_coords select 1) - 0.084,0],[], 0, "CAN_COLLIDE"];
_trash2 = createVehicle ["Body2",[(_coords select 0) + 1.9248,(_coords select 1) + 2.1201,0],[], 0, "CAN_COLLIDE"];
[_trash] call DZMSProtectObj;
[_trash2] call DZMSProtectObj;

//DZMSBoxFill fills the box, DZMSProtectObj prevents it from disappearing
_crate = createVehicle [if (DZMSEpoch) then {"USLaunchersBox"} else {"AmmoBoxBig"},[(_coords select 0) - 6.1718,(_coords select 1) + 0.6426,0],[], 0, "CAN_COLLIDE"];
[_crate,"weapons"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;

_crate2 = createVehicle [if (DZMSEpoch) then {"USLaunchersBox"} else {"AmmoBoxBig"},[(_coords select 0) - 7.1718,(_coords select 1) + 1.6426,0],[], 0, "CAN_COLLIDE"];
[_crate2,"weapons"] ExecVM DZMSBoxSetup;
[_crate2] call DZMSProtectObj;

_endMission = {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
    DZMSMajRunning = DZMSMajRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["EM5"];
};

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, unitArray]
_group1 = [[(_coords select 0) - 8.4614,(_coords select 1) - 5.0527,0],6,1] call DZMSAISpawn;
_group2 = [[(_coords select 0) - 8.4614,(_coords select 1) - 5.0527,0],4,1] call DZMSAISpawn;
_group3 = [[(_coords select 0) + 7.5337,(_coords select 1) + 4.2656,0],4,1] call DZMSAISpawn;
_group4 = [[(_coords select 0) + 7.5337,(_coords select 1) + 4.2656,0],4,1] call DZMSAISpawn;

_DZMSUnitsMajor = _group1 + _group2 + _group3 + _group4;

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,_DZMSUnitsMajor,30] call DZMSWaitMissionComp;

if (_status) exitWith {call _endMission;};

//Call DZMSSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_chopper] ExecVM DZMSSaveVeh;
[_truck] ExecVM DZMSSaveVeh;

//Let everyone know the mission is over
[nil,nil,rTitleText,"The Helicopter has been Taken by Survivors!", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Major SM4 Helicopter Landing Mission has Ended."];

call _endMission;

[DZMSCleanUpTime,10] call DZMSSleep;
_coords call DZMSEndCleanUp;
