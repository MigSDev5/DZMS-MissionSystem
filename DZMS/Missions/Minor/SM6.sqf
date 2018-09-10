/*
	Weapon Truck Crash by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)
	Updated to new format by Vampire
*/
private ["_missName","_coords","_crash","_crate","_crate1","_crate2","_marker","_DZMSUnitsMinor","_group1","_group2","_group3","_group4","_status","_endMission"];

//Name of the Mission
_missName = "Weapons Truck";

DZMSMinRunning = DZMSMinRunning + 1;
DZMSMinCount = DZMSMinCount + 1;

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"A Weapons Truck has Crashed!\nGo Recover the Supplies!", "PLAIN",10] call RE;

//DZMSAddMinMarker is a simple script that adds a marker to the location
_marker = [_coords,_missName] call DZMSAddMinMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"SM6"];

//Add scenery
_crash = createVehicle ["UralWreck",_coords,[], 0, "CAN_COLLIDE"];

//DZMSProtectObj prevents it from disappearing
[_crash] call DZMSProtectObj;

//Add and fill the boxes
_crate = createVehicle [if (DZMSEpoch) then {"USLaunchersBox"} else {"AmmoBoxBig"},[(_coords select 0) + 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate,"weapons"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;

_crate1 = createVehicle [if (DZMSEpoch) then {"USLaunchersBox"} else {"AmmoBoxBig"},[(_coords select 0) - 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate1,"weapons"] ExecVM DZMSBoxSetup;
[_crate1] call DZMSProtectObj;

_crate2 = createVehicle [if (DZMSEpoch) then {"RULaunchersBox"} else {"AmmoBoxBig"},[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2,"weapons"] ExecVM DZMSBoxSetup;
[_crate2] call DZMSProtectObj;

_endMission = {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
    DZMSMinRunning = DZMSMinRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["SM6"];
};

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, unitArray]
_group1 = [_coords,3,0,"DZMSUnitsMinor"] call DZMSAISpawn;
_group2 = [_coords,3,0,"DZMSUnitsMinor"] call DZMSAISpawn;
_group3 = [_coords,3,0,"DZMSUnitsMinor"] call DZMSAISpawn;
_group4 = [_coords,3,0,"DZMSUnitsMinor"] call DZMSAISpawn;

_DZMSUnitsMinor = _group1 + _group2 + _group3 + _group4;

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,_DZMSUnitsMinor,30] call DZMSWaitMissionComp;

if (_status) exitWith {call _endMission;};

//Let everyone know the mission is over
[nil,nil,rTitleText,"The Weapons Truck has been Secured by Survivors!", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Minor SM6 Weapons Truck Mission has Ended."];

call _endMission;

[DZMSCleanUpTime,10] call DZMSSleep;
_coords call DZMSEndCleanUp;
