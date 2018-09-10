/*
	Survivors Hostage
	by Mig
*/

private ["_missName","_coords","_church","_tree","_tree2","_tree3","_tree4","_tree5","_tree6","_tree7","_tree8","_tree9","_tree10","_tree11","_tree12","_tree13","_tree14","_tree15","_tree16","_tree17","_tree18","_tree19","_tree20","_tree21","_tree22","_tree23","_tree24","_tree25","_tree26","_tree27","_tree28","_tree29","_tree30","_tree31","_tree32","_hb","_hedge","_hb2","_hedge2","_hedge3","_hedge4","_hedge5","_hedge6","_hedge7","_body1","_body2","_body3","_posO","_otage","_pos","_loop","_crate","_endMission","_group1","_group2","_group3","_group4","_group5","_status","_DZMSUnitsMajor"];

//Name of the Mission
_missName = "Hostage taking";

DZMSMajRunning = DZMSMajRunning + 1;
DZMSMajCount = DZMSMajCount + 1;

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"Many bandits have taken a survivor hostage in a church\n they threaten to execute it if the ransom is not delivered on time.", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
_marker = [_coords,_missname] call DZMSAddMajMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"EM9"];

//Lets add the scenery
_church = createVehicle ["Land_Church_03",_coords, [], 0, "CAN_COLLIDE"];
_church setDir -46.419888;
_church animate ["dvere1",0];
_church animate ["dvere2",0];
_church setVectorUp surfaceNormal position _church;
_tree = createVehicle ["MAP_t_picea3f", [(_coords select 0) - 6.2021,(_coords select 1) + 23.5778,0], [], 0, "CAN_COLLIDE"];
_tree2 = createVehicle ["MAP_t_malus1s", [(_coords select 0) - 3.3051,(_coords select 1) + 17.3262,0], [], 0, "CAN_COLLIDE"];
_tree3 = createVehicle ["MAP_t_picea2s", [(_coords select 0) + 1.2149,(_coords select 1) + 34.3492,0], [], 0, "CAN_COLLIDE"];
_tree4 = createVehicle ["MAP_t_picea2s", [(_coords select 0) + 9.0507,(_coords select 1) + 38,7695,0], [], 0, "CAN_COLLIDE"];
_tree5 = createVehicle ["MAP_t_picea2s", [(_coords select 0) + 27.0005,(_coords select 1) - 12,2852,0], [], 0, "CAN_COLLIDE"];
_tree6 = createVehicle ["MAP_t_picea2s", [(_coords select 0) - 35.1304,(_coords select 1) + 18.6464,0], [], 0, "CAN_COLLIDE"];
_tree7 = createVehicle ["MAP_t_picea2s", [(_coords select 0) - 11.9834,(_coords select 1) + 35.9043,0], [], 0, "CAN_COLLIDE"];
_tree8 = createVehicle ["MAP_t_picea2s", [(_coords select 0) - 40.417,(_coords select 1) - 19.4053,0], [], 0, "CAN_COLLIDE"]; 
_tree9 = createVehicle ["MAP_t_picea3f", [(_coords select 0) - 22.3081,(_coords select 1) + 28.7812,0], [], 0, "CAN_COLLIDE"];
_tree10 = createVehicle ["MAP_t_picea3f", [(_coords select 0) + 6.2251,(_coords select 1) + 55.7412,0], [], 0, "CAN_COLLIDE"];
_tree11 = createVehicle ["MAP_t_picea3f", [(_coords select 0) - 19.2134,(_coords select 1) - 4.544,0], [], 0, "CAN_COLLIDE"]; 
_tree12 = createVehicle ["MAP_t_picea3f", [(_coords select 0) + 29.2329,(_coords select 1) + 8.6006,0], [], 0, "CAN_COLLIDE"]; 
_tree13 = createVehicle ["MAP_t_picea3f", [(_coords select 0) - 19.6275,(_coords select 1) - 33.585,0], [], 0, "CAN_COLLIDE"]; 
_tree14 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 43.5313,(_coords select 1) + 18.2226,0], [], 0, "CAN_COLLIDE"]; 
_tree15 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 0.8906,(_coords select 1) + 47.542,0], [], 0, "CAN_COLLIDE"]; 
_tree16 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 41.6977,(_coords select 1) + 39.917,0], [], 0, "CAN_COLLIDE"];
_tree17 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 19.5761,(_coords select 1) + 43.2431,0], [], 0, "CAN_COLLIDE"];
_tree18 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 28.5044,(_coords select 1) - 0.5655,0], [], 0, "CAN_COLLIDE"]; 
_tree19 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 31.0977,(_coords select 1) - 15.3809,0], [], 0, "CAN_COLLIDE"];
_tree20 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 44.5264,(_coords select 1) - 10.6348,0], [], 0, "CAN_COLLIDE"];
_tree21 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 6.0396,(_coords select 1) - 32.2036,0], [], 0, "CAN_COLLIDE"];
_tree22 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 19.4273,(_coords select 1) - 41.2266,0], [], 0, "CAN_COLLIDE"];
_tree23 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 23.4707,(_coords select 1) - 38.3389,0], [], 0, "CAN_COLLIDE"];
_tree24 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 15.396,(_coords select 1) - 17.252,0], [], 0, "CAN_COLLIDE"];
_tree25 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 43.9814,(_coords select 1) + 10.7851,0], [], 0, "CAN_COLLIDE"];
_tree26 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 37.6425,(_coords select 1) - 13.9707,0], [], 0, "CAN_COLLIDE"];
_tree27 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 3.6889,(_coords select 1) - 49.21,0], [], 0, "CAN_COLLIDE"];
_tree28 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 1.6475,(_coords select 1) + 28.8877,0], [], 0, "CAN_COLLIDE"];
_tree29 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) - 10.7134,(_coords select 1) + 22.165,0], [], 0, "CAN_COLLIDE"];
_tree30 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 22.768,(_coords select 1) - 1.2217,0], [], 0, "CAN_COLLIDE"];
_tree31 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 20.2651,(_coords select 1) + 21.5332,0], [], 0, "CAN_COLLIDE"];
_tree32 = createVehicle ["MAP_t_fagus2f", [(_coords select 0) + 11.8017,(_coords select 1) + 23.6552,0], [], 0, "CAN_COLLIDE"];
_hb = createVehicle ["Land_HBarrier5", [(_coords select 0) - 23.3409,(_coords select 1) - 18.5088,0], [], 0, "CAN_COLLIDE"];
_hb setDir 80.546021;
_hedge = createVehicle ["Hedgehog", [(_coords select 0) - 17.5445,(_coords select 1) - 14.0059,0], [], 0, "CAN_COLLIDE"];
_hb2 = createVehicle ["Land_HBarrier5", [(_coords select 0) - 13.9038,(_coords select 1) - 17.6885,0], [], 0, "CAN_COLLIDE"];
_hb2 setDir 179.98015;
_hedge2 = createVehicle ["Hedgehog", [(_coords select 0) - 19.3843,(_coords select 1) - 24.835,0], [], 0, "CAN_COLLIDE"];
_hedge3 = createVehicle ["Hedgehog", [(_coords select 0) - 28.1118,(_coords select 1) - 16.4717,0], [], 0, "CAN_COLLIDE"];
_hedge4 = createVehicle ["Hedgehog", [(_coords select 0) - 24.4444,(_coords select 1) - 7.5674,0], [], 0, "CAN_COLLIDE"];
_hedge5 = createVehicle ["Hedgehog", [(_coords select 0) - 2.1206,(_coords select 1) - 26.6328,0], [], 0, "CAN_COLLIDE"];
_hedge6 = createVehicle ["Hedgehog", [(_coords select 0) - 17.0132,(_coords select 1) - 29.6353,0], [], 0, "CAN_COLLIDE"];
_hedge7 = createVehicle ["Hedgehog", [(_coords select 0) - 27.0474,(_coords select 1) - 22.8355,0], [], 0, "CAN_COLLIDE"];
_body1 = createVehicle ["Body", [(_coords select 0) - 24.2032,(_coords select 1) - 11.1778,0], [], 0, "CAN_COLLIDE"];
_body2 = createVehicle ["Body", [(_coords select 0) - 20.7056,(_coords select 1) - 8.8741,0], [], 0, "CAN_COLLIDE"];
_body3 = createVehicle ["Body", [(_coords select 0) - 22.6563,(_coords select 1) - 4.7744,0], [], 0, "CAN_COLLIDE"];
 
_posO = _church modelToWorld [9.29639,-2.6543,-13.7567]; 
_otage = createAgent ["Citizen2_EP1",_posO, [], 0, "CAN_COLLIDE"];

_otage setdir (random 360);
_otage setCaptive 1;
_otage setDammage 0.5;
removeAllWeapons _otage;
removeAllItems _otage;
[objNull, _otage, rswitchmove ,"CivilSitting"] call RE;
_otage allowDammage false;
_otage AddEventHandler ["HandleDamage", {false}];

// spawn special statick ai inside building ,this ai not move 
{
    _pos = _church modelToWorld _x;
    _group5 = [_pos,1,3,-46.419888] call DZMSAIStaticDefender;
} count [[9.59766,-4.39307,-13.7586],[9.45801,3.38086,-13.7585],[5.31982,7.41602,-14.3019],[1.48145,-0.223633,-14.2947],[-2.42139,-7.67285,-14.3019],[-2.81152,7.95996,-14.3018],[-8.25439,-5.03223,-14.3019],[-8.55127,4.7793,-14.3018]];

//Add and fill the boxes
_crate = createVehicle [if (DZMSEpoch) then {"USLaunchersBox"} else {"AmmoBoxBig"},_church modelToWorld [9.93359,1.79541,-13.8533],[], 0, "CAN_COLLIDE"];
[_crate,"weapons"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;

_endMission = {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
    DZMSMajRunning = DZMSMajRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["EM9"];
};

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, unitArray]
_group1 = [[(_coords select 0) + 25,(_coords select 1) - 20, 0],6,1] call DZMSAISpawn;
_group2 = [[(_coords select 0) - 15,(_coords select 1) + 25, 0],6,1] call DZMSAISpawn;
_group3 = [[(_coords select 0) + 16,(_coords select 1) - 15, 0],4,1] call DZMSAISpawn;
_group4 = [[(_coords select 0) + 20,(_coords select 1) - 10.8799, 0],4,1] call DZMSAISpawn;

_DZMSUnitsMajor = _group1 + _group2 + _group3 + _group4 + _group5;

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,_DZMSUnitsMajor,10] call DZMSWaitMissionComp;

if (_status) exitWith {call _endMission;};

//Let everyone know the mission is over
[nil,nil,rTitleText,"[Hostage] All the bandits are dead, the hostage is safe.!", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Major SM9 Hostage taking Mission has Ended."];

call _endMission;

_loop = true;
while {_loop} do {
    {
        if((isPlayer _x) AND (_x distance _posO <= 4)) then {
            _loop = false;
			[objNull, _otage, rswitchmove ,""] call RE;
		};
	}forEach playableUnits;
};

[DZMSCleanUpTime,10] call DZMSSleep;
_coords call DZMSEndCleanUp;
