/*																					//
	Weapons Cache Mission by lazyink (Original Full Code by TheSzerdi & TAW_Tonic)
	New Mission Format by Vampire
*/																					//

private ["_missName","_coords","_net","_veh1","_veh2","_vehicle","_vehicle1","_crate","_crate1","_crate2","_crate3","_marker","_markerA","_markerB","_group1","_group2","_group3","_group4","_status","_endMission","_DZMSUnitsMajor"];

DZMSMajRunning = DZMSMajRunning + 1;
DZMSMajCount = DZMSMajCount + 1;

//Name of the Mission
_missName = "NATO Weapons Cache";

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"Bandits have Overrun a NATO Weapons Cache!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
_marker = [_coords,_missname] call DZMSAddMajMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"EM2"];

//Lets add the scenery
_net = createVehicle ["Land_CamoNetB_NATO",[(_coords select 0) - 0.0649, (_coords select 1) + 0.6025,0],[], 0, "CAN_COLLIDE"];
[_net] call DZMSProtectObj;

//We create the vehicles like normal
_veh1 = ["small"] call DZMSGetVeh;
_veh2 = ["large"] call DZMSGetVeh;
_vehicle = createVehicle [_veh1,[(_coords select 0) + 10.0303, (_coords select 1) - 12.2979,10],[], 0, "CAN_COLLIDE"];
_vehicle1 = createVehicle [_veh2,[(_coords select 0) - 6.2764, (_coords select 1) - 14.086,10],[], 0, "CAN_COLLIDE"];

//DZMSSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_vehicle] call DZMSSetupVehicle;
[_vehicle1] call DZMSSetupVehicle;

_crate = createVehicle [if (DZMSEpoch) then {"USVehicleBox"} else {"AmmoBoxBig"},_coords,[], 0, "CAN_COLLIDE"];
_crate1 = createVehicle ["DZ_AmmoBoxUS",[(_coords select 0) - 3.7251,(_coords select 1) - 2.3614, 0],[], 0, "CAN_COLLIDE"];
_crate2 = createVehicle ["DZ_AmmoBoxRU",[(_coords select 0) - 3.4346, 0, 0],[], 0, "CAN_COLLIDE"];
_crate3 = createVehicle ["DZ_AmmoBoxUS",[(_coords select 0) + 4.0996,(_coords select 1) + 3.9072, 0],[], 0, "CAN_COLLIDE"];

//DZMSBoxFill fills the box, DZMSProtectObj prevents it from disappearing
[_crate,"weapons"] execVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;
[_crate1,"ammoUS"] execVM DZMSBoxSetup;
[_crate1] call DZMSProtectObj;
[_crate2,"ammoRU"] execVM DZMSBoxSetup;
[_crate2] call DZMSProtectObj;
[_crate3,"ammoUS"] execVM DZMSBoxSetup;
[_crate3] call DZMSProtectObj;

_endMission = {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
    DZMSMajRunning = DZMSMajRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["EM2"];
};

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, unitArray]
_group1 = [[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],6,1] call DZMSAISpawn;
_group2 = [[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],6,1] call DZMSAISpawn;
_group3 = [[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],4,1] call DZMSAISpawn;
_group4 = [[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],4,1] call DZMSAISpawn;

_DZMSUnitsMajor = _group1 + _group2 + _group3 + _group4;

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,_DZMSUnitsMajor,30] call DZMSWaitMissionComp;

if (_status) exitWith {call _endMission;};

//Call DZMSSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_vehicle] ExecVM DZMSSaveVeh;
[_vehicle1] ExecVM DZMSSaveVeh;

//Let everyone know the mission is over
[nil,nil,rTitleText,"The Weapons Cache is Under Survivor Control!", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Major SM1 Weapon Cache Mission has Ended."];

call _endMission;

[DZMSCleanUpTime,10] call DZMSSleep;
_coords call DZMSEndCleanUp;
