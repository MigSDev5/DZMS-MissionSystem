/*
	Bandit Heli Down! by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)
	Updated to new format by Vampire
*/
private ["_missName","_coords","_crash","_crate","_marker","_DZMSUnitsMinor","_group1","_group2","_group3","_status","_endMission"];

//Name of the Mission
_missName = "Helicopter Crash";

DZMSMinRunning = DZMSMinRunning + 1;
DZMSMinCount = DZMSMinCount + 1;

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"A Helicopter has Crashed!\nGo Check for Survivors!", "PLAIN",10] call RE;

//DZMSAddMinMarker is a simple script that adds a marker to the location
_marker = [_coords,_missName] call DZMSAddMinMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"SM4"];

//Add the scenery
if (DZMSEpoch) then {
	_crash = createVehicle ["UH60_NAVY_Wreck_burned_DZ", _coords,[], 0, "CAN_COLLIDE"];
} else {
	_crash = createVehicle ["CrashSite_US", _coords,[], 0, "CAN_COLLIDE"];
};

//DZMSProtectObj prevents it from disappearing
[_crash] call DZMSProtectObj;

//We create and fill the crates
_crate = createVehicle [if (DZMSEpoch) then {"USLaunchersBox"} else {"AmmoBoxBig"},[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate,"weapons"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;

_endMission = {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
    DZMSMinRunning = DZMSMinRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["SM4"];
};

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, unitArray]
_group1 = [_coords,3,1,"DZMSUnitsMinor"] call DZMSAISpawn;
_group2 = [_coords,3,1,"DZMSUnitsMinor"] call DZMSAISpawn;
_group3 = [_coords,3,1,"DZMSUnitsMinor"] call DZMSAISpawn;

_DZMSUnitsMinor = _group1 + _group2 + _group3;

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,_DZMSUnitsMinor,30] call DZMSWaitMissionComp;

if (_status) exitWith {call _endMission;};

//Let everyone know the mission is over
[nil,nil,rTitleText,"The Helicopter Crash has been Secured by Survivors!", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Minor SM4 Crash Site Mission has Ended."];

call _endMission;

[DZMSCleanUpTime,10] call DZMSSleep;
_coords call DZMSEndCleanUp;
