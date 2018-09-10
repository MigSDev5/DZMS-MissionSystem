
/*
 save jacky created by Mig

*/

private ["_missName","_coords","_marker","_build1","_build2","_build3","_build4","_build5","_build6","_build7","_build8","_build9","_build10","_build11","_build12","_build13","_build13","_jacky","_grJacky","_crate","_table","_radio","_wp1","_DZMSUnitsMajor","_status","_endMission","_group1","_group2","_group3","_group4","_status","_objects"];

//Name of the Mission
_missName = "Save Jacky";

DZMSMajRunning = DZMSMajRunning + 1;
DZMSMajCount = DZMSMajCount + 1;

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"Jacky is stuck in a bar, surrounded by armed bandits, he defends himself as best he can, but he drank too much and struggled to aim, help him out of this bad situation!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
_marker = [_coords,_missname] call DZMSAddMajMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"EM8"];

//Buildings 
_build1 = createVehicle ["Land_A_Pub_01",[(_coords select 0) - 0.01, (_coords select 1) - 0.01,-0.02],[], 0, "CAN_COLLIDE"];
_build2 = createVehicle ["Land_Hlidac_budka",[(_coords select 0) - 16, (_coords select 1) + 25,-0.02],[], 0, "CAN_COLLIDE"];
_build3 = createVehicle ["Land_Shed_M02",[(_coords select 0) +10, (_coords select 1) + 17,-0.02],[], 0, "CAN_COLLIDE"];
_build4 = createVehicle ["Land_houseV_2T1", [(_coords select 0) -22, (_coords select 1) -22,-0.02],[], 0, "CAN_COLLIDE"];
_build5 = createVehicle ["Barrels", [(_coords select 0) - 5, (_coords select 1) + 6,-0.02],[], 0, "CAN_COLLIDE"];
_build6 = createVehicle ["Garbage_container", [(_coords select 0) + 10, (_coords select 1) - 17,-0.02],[], 0, "CAN_COLLIDE"];
_build7 = createVehicle ["MAP_t_fagus2f",[(_coords select 0) + 12, (_coords select 1) + 9,-0.02],[], 0, "CAN_COLLIDE"];
_build8 = createVehicle ["MAP_t_fagus2f",[(_coords select 0) + 22, (_coords select 1) + 19,-0.02],[], 0, "CAN_COLLIDE"];
_build9 = createVehicle ["MAP_t_fagus2f",[(_coords select 0) + 19, (_coords select 1) - 19,-0.02],[], 0, "CAN_COLLIDE"];
_build10 = createVehicle ["MAP_t_fagus2f",[(_coords select 0) - 12, (_coords select 1) - 12,-0.02],[], 0, "CAN_COLLIDE"];
_build11 = createVehicle ["MAP_t_fagus2f",[(_coords select 0) + 10, (_coords select 1) + 23,-0.02],[], 0, "CAN_COLLIDE"];
_build12 = createVehicle ["MAP_t_fagus2f",[(_coords select 0) -27, (_coords select 1) + 27,-0.02],[], 0, "CAN_COLLIDE"];
_build13 = createVehicle ["datsun1_civil_2_covered",[(_coords select 0) + 5, (_coords select 1) - 15,0],[], 0, "CAN_COLLIDE"];
_build13 setVehicleLock "LOCKED";
_build14 = createVehicle ["hilux1_civil_1_open",[(_coords select 0) + 8, (_coords select 1) - 18,0],[], 0, "CAN_COLLIDE"];
_build14 setVehicleLock "LOCKED";
_table = createVehicle ["Land_Table_EP1",[(_coords select 0) - 10,(_coords select 1) + 12,0], [], 0, "CAN_COLLIDE"];
_table setDir -12.647605;
_chair = createVehicle ["Land_Chair_EP1", [(_coords select 0) - 10,(_coords select 1) + 12,0], [], 0, "CAN_COLLIDE"];
_chair setDir 40.746967;
_radio = createVehicle ["Radio",[(_coords select 0) - 10,(_coords select 1) + 12, 0.84897929], [], 0, "CAN_COLLIDE"];

_grJacky = createGroup WEST;
_jacky = _grJacky createUnit ["Worker1",[(_coords select 0) - 10, (_coords select 1) + 10,0],[],0,"CAN COLLIDE"];
_jacky addEventHandler ["HandleDamage", {false}];
removeAllWeapons _jacky;
removeAllItems _jacky;
_jacky setposATL [(_coords select 0) + 4, (_coords select 1) - 4,3];
[_jacky] joinSilent _grJacky;

//_jacky setCaptive true;

PVDZ_obj_Fire = [_build1,2,time,false,false];
publicVariable "PVDZ_obj_Fire";

_endMission = {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
    //Let the timer know the mission is over
    DZMSMajRunning = DZMSMajRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["EM8"];
};

//Usage: [_coords, count, skillLevel, unitArray]
_group1 = [[(_coords select 0) + 13,(_coords select 1) +15, 0],6,1] call DZMSAISpawn;
_group2 = [[(_coords select 0) - 23,(_coords select 1) - 25, 0],6,1] call DZMSAISpawn;
_group3 = [[(_coords select 0) - 13,(_coords select 1) + 15, 0],4,1] call DZMSAISpawn;
_group4 = [[(_coords select 0) - 33,(_coords select 1) + 35, 0],4,1] call DZMSAISpawn;

_DZMSUnitsMajor = _group1 + _group2 + _group3 +_group4;

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,_DZMSUnitsMajor,30] call DZMSWaitMissionComp;

if (_status) exitWith {call _endMission;};

//Let everyone know the mission is over
[nil,nil,rTitleText,"yes,  Jacky is safe and sound, but still alcoholic !.", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Major SM7 Save Jacky Mission has Ended."];

//DZMSBoxFill fills the box, DZMSProtectObj prevents it from disappearing
_crate = createVehicle [if (DZMSEpoch) then {"USLaunchersBox"} else {"AmmoBoxBig"},[(_coords select 0) - 10,(_coords select 1) + 10,0],[], 0, "CAN_COLLIDE"];

[_crate,"weapons"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;

call _endMission;

_jacky setPos [(_coords select 0) - 12, (_coords select 1) + 12, 0];

[_jacky] spawn {
	_jacky = _this select 0;
    while {alive _jacky} do {
        _jacky playMoveNow "ActsPercMstpSnonWnonDnon_DancingDuoIvan";
		sleep 2;
    };
};

[DZMSCleanUpTime,10] call DZMSSleep;
_coords call DZMSEndCleanUp;
