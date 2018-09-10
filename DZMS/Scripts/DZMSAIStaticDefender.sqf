/*																		//
	DZMSAISpawn.sqf by Vampire
	Usage: [position,unitcount,skillLevel] execVM "dir\DZMSAISpawn.sqf";
		Position is the coordinates to spawn at [X,Y,Z]
		UnitCount is the number of units to spawn
		SkillLevel is the skill number defined in DZMSAIConfig.sqf
*/																		//
private ["_position","_newPos","_unitcount","_skill","_wpRadius","_xpos","_ypos","_unitGroup","_aiskin","_unit","_weapon","_magazine","_wppos1","_wppos2","_wppos3","_wppos4","_wp1","_wp2","_wp3","_wp4","_wpfin","_unitArrayName","_target","_units"];

_position = _this select 0;
_unitcount = _this select 1;
_skill = _this select 2;
_dir = _this select 3;

//diag_log format ["[DZMS]: AI Pos:%1 / AI UnitNum: %2 / AI SkillLev:%3",_position,_unitcount,_skill];

//Create the unit group. We use east by default.
_unitGroup = createGroup east;
_units = [];

//Probably unnecessary, but prevents client AI stacking
if (!isServer) exitWith {};

for "_x" from 1 to _unitcount do {

	//Lets pick a skin from the array
	_aiskin = DZMSBanditSkins call BIS_fnc_selectRandom;

	//Lets spawn the unit
	//_newPos = _position findEmptyPosition [0,20,(DZMSBanditSkins select 0)];
	_unit = _unitGroup createUnit [_aiskin, _position, [], 0, "CAN_COLLIDE"];

	//Make him join the correct team
	[_unit] joinSilent _unitGroup;
	_unit setDir _dir;

	//Add the behaviour
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit setCombatMode "RED";
	_unit setBehaviour "SAFE";
	_unit reveal [player,4];
	
    _target = nearestObjects[_position,["Man","Air", "Car", "Boat", "Truck"],800]; 	
	{
        _unit reveal[_x, 4];
    } forEach _target;
	
	_units set [count _units,_unit];

	//Remove the items he spawns with by default
	removeAllWeapons _unit;
	removeAllItems _unit;
	
	[_unit,_position] spawn DZMS_Defender;

	//Now we need to figure out their loadout, and assign it

	//Get the weapon array based on skill
	_weaponArray = [_skill] call DZMSGetWeapon;

	_weapon = _weaponArray select 0;
	_magazine = _weaponArray select 1;

	//diag_log text format ["[DZMS]: AI Weapon:%1 / AI Magazine:%2",_weapon,_magazine];

	//Get the gear array
	_aigearArray = [DZMSGear0,DZMSGear1,DZMSGear2,DZMSGear3,DZMSGear4];
	_aigear = _aigearArray call BIS_fnc_selectRandom;
	_gearmagazines = _aigear select 0;
	_geartools = _aigear select 1;

	//Gear the AI backpack
	_aipack = DZMSPacklist call BIS_fnc_selectRandom;
	
	if (DZMSUseCoins) then {
	    _unit setVariable[Z_MoneyVariable,DZMSCoinsAmount,true];
	};

	//Lets add it to the Unit
	for "_i" from 1 to 6 do {
		_unit addMagazine _magazine;
	};
	_unit addWeapon _weapon;
	_unit selectWeapon _weapon;

	_unit addBackpack _aipack;

	if (DZMSUseNVG) then {
		_unit addWeapon "NVGoggles";
	};

	{
		_unit addMagazine _x
	} forEach _gearmagazines;

	{
		_unit addWeapon _x
	} forEach _geartools;

	_aicskill = DZMSSkills1;

	//Lets set the skills
	switch (_skill) do {
		case 0: {_aicskill = DZMSSkills0;};
		case 1: {_aicskill = DZMSSkills1;};
		case 2: {_aicskill = DZMSSkills2;};
		case 3: {_aicskill = DZMSSkills3;};
	};

	{
		_unit setSkill [(_x select 0),(_x select 1)]
	} forEach _aicskill;

	//Lets prepare the unit for cleanup
	_unit addEventHandler ["Killed",{ [(_this select 0), (_this select 1)] ExecVM DZMSAIKilled; }];
	_unit setVariable ["DZMSAI", true];
};

//Lets give a launcher if enabled
//The last _unit should still be defined from the FOR above
if (DZMSUseRPG) then {
	_unit addWeapon "RPG7V";
	_unit addMagazine "PG7V";
	_unit addMagazine "PG7V";
};

diag_log format["[DZMS]: %1 AI Spawned.",count (units _unitGroup)];

_units
