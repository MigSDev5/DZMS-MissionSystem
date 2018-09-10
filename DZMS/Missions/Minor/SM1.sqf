/*
	Bandit Hunting Party by lazyink (Full credit to TheSzerdi & TAW_Tonic for the code)
	Updated to new format by Vampire
*/
private ["_missName","_coords","_vehicle","_marker","_DZMSUnitsMinor","_group1","_group2","_group3","_group4","_status","_endMission"];

//Name of the Mission
_missName = "Bandit Squad";

DZMSMinRunning = DZMSMinRunning + 1;
DZMSMinCount = DZMSMinCount + 1;

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"A Bandit Squad has been spotted!\nStop them from completing their patrol!", "PLAIN",10] call RE;

//DZMSAddMinMarker is a simple script that adds a marker to the location
_marker = [_coords,_missName] call DZMSAddMinMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"SM1"];

_endMission = {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
    DZMSMinRunning = DZMSMinRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["SM1"];
};

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, unitArray]
_group1 = [_coords,2,1] call DZMSAISpawn;
_group2 = [_coords,2,1] call DZMSAISpawn;
_group3 = [_coords,2,1] call DZMSAISpawn;
_group4 = [_coords,2,1] call DZMSAISpawn;

_DZMSUnitsMinor = _group1 + _group2 + _group3 + _group4;

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,_DZMSUnitsMinor,30] call DZMSWaitMissionComp;

if (_status) exitWith {call _endMission;};

//Let everyone know the mission is over
[nil,nil,rTitleText,"The Bandit Squad has been Wiped Out!", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Minor SM1 Bandit Squad Mission has Ended."];

call _endMission;

[DZMSCleanUpTime,10] call DZMSSleep;
_coords call DZMSEndCleanUp;