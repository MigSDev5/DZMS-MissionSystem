/*
	Weapon Truck Crash by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)
	Updated to new format by Vampire
*/
private ["_missName","_units","_road","_dir","_truck","_people","_coords","_road2","_coords2","_dir2","_grid","_marker","_markerA","_markerB","_v3s","_chair","_dude","_loop","_E","_status","_position"];

//Name of the Mission
_missName = "Civilian Truck";

DZMSMinRunning = DZMSMinRunning + 1;
DZMSMinCount = DZMSMinCount + 1;
_units = [];

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result

_road = 150 call findPos_Near_Road;
_coords = getPos _road;
_dir = getDir _road;

[nil,nil,rTitleText,"The driver of a truck carrying civilians, was killed!\nGo on the spot and help them.!", "PLAIN",10] call RE;

//DZMSAddMinMarker is a simple script that adds a marker to the location
_marker = [_coords,_missName] call DZMSAddMinMarker;

DZMSMissionCoord set [count DZMSMissionCoord,_marker select 1];
DZMSInProgress set [count DZMSInProgress,"SM7"];

//Add scenery
_truck = createVehicle ["UralCivil2",_coords,[], 0, "CAN_COLLIDE"];
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _truck];
_truck setDir _dir;
[_truck] call DZMSProtectObj;
_truck setVelocity [0,0,1];

{
    _people = createAgent [_x, getPos _truck, [], 0, "FORM"];
	_people allowDamage false;
	_people moveInCargo _truck;
	_people setCaptive true;
	_units set [count _units,_people];
} forEach ["Worker4","Rocker4","Rocker2","SurvivorWpink_DZ","SurvivorWurban_DZ","Villager1","SurvivorWdesert_DZ","SurvivorWcombat_DZ"];

//Wait until the player is within 30 meters and also meets the kill req
_status = [_coords,[],5] call DZMSWaitMissionComp;

if (_status) exitWith {
    deleteMarker (_marker select 0);
    deleteMarker (_marker select 1);
	{deleteVehicle _x} count _units;
	DZMSMinRunning = DZMSMinRunning - 1;
    DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
    DZMSInProgress = DZMSInProgress - ["SM7"];
};

deleteMarker (_marker select 0);
deleteMarker (_marker select 1);


_E = true;
while {_E} do {
	_position = call DZMSFindPos;
    _roads = _position nearRoads 500;
    _count = count _roads;
    _Select = floor(random _count);
    _road2 = _roads select _Select;
	if (!(isNil "_road2") and (_road2 distance _coords) > 3000) then {
	    _E = false;
	};
};

[nil,nil,rTitleText,"[Civilian Truck] Drive the truck and these occupants alive to the green marker, it will know how to reward you.", "PLAIN",6] call RE;
	
_coords2 = getPos _road2;
_dir2 = getDir _road2;

_markerA = createMarker ["CivCarPartII",_coords2];
_markerA setMarkerColor "ColorGreen";
_markerA setMarkerShape "ELLIPSE";
_markerA setMarkerBrush "Grid";
_markerA setMarkerSize [150,150];

_markerB = createMarker ["CivCarPartIIB",_coords2];
_markerB setMarkerColor "ColorRed";
_markerB setMarkerType "Vehicle";
_markerB setMarkerText "Arrived Civilian Car";

[_markerA,_markerB,_coords2,"Arrived Civilian Car","ColorGreen","ColorRed"] spawn DZMSMarkerLoop;

_v3s = createVehicle ["V3S_Gue",[(_coords2 select 0) + 15,_coords2 select 1,0],[], 0, "CAN_COLLIDE"];
[_v3s] call DZMSProtectObj;
_v3s setDir _dir2;
_v3s setVehicleLock "LOCKED";
_v3s allowDamage false;
_v3s setVelocity [0,0,1];

_chair = createVehicle ["FoldChair_with_Cargo",[(_coords2 select 0) + 11,_coords2 select 1,0],[], 0, "CAN_COLLIDE"];
[_chair] call DZMSProtectObj;
_dude = createAgent ["Ins_Bardak",[0,0,0], [],0,"NONE"];
_dude setDir (_dir2 + 90);
_dude allowDamage false;
_dude setCaptive true;
_dude moveInCargo _chair;

_loop = true;
while {_loop} do {
    {
        if((isPlayer _x) AND (_x distance _coords2 <= 10) and (_truck distance _coords2) <= 10) then {
            _loop = false;
		};
	}forEach playableUnits;
};

deleteMarker _markerA;
deleteMarker _markerB;

{
	_x action ["Eject",_truck];
	sleep 0.7;
	deleteVehicle _x;
} forEach _units;

[nil,nil,rTitleText,"[Civilian Truck] Yea! Everyone is alive.\n your reward is in the truck", "PLAIN",6] call RE;
[_truck,"weapons"] ExecVM DZMSBoxSetup;

DZMSMinRunning = DZMSMinRunning - 1;
DZMSMissionCoord = DZMSMissionCoord - [_marker select 1];
DZMSInProgress = DZMSInProgress - ["SM7"];

diag_log text format["[DZMS]: Minor SM7 Civilian Truck Mission has Ended."];

[DZMSCleanUpTime,10] call DZMSSleep;
_coords2 call DZMSEndCleanUp;
