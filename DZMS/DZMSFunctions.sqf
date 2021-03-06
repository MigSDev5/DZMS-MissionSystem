/*
	DayZ Mission System Functions
	by Vampire
*/

diag_log text "[DZMS]: Loading ExecVM Functions.";
DZMSMajTimer = "\z\addons\dayz_server\DZMS\Scripts\DZMSMajTimer.sqf";
DZMSMinTimer = "\z\addons\dayz_server\DZMS\Scripts\DZMSMinTimer.sqf";

DZMSAddMajMarker = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSAddMajMarker.sqf";
DZMSAddMinMarker = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSAddMinMarker.sqf";
DZMSMarkerLoop = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSMarkerLoop.sqf";

DZMSAIKilled = "\z\addons\dayz_server\DZMS\Scripts\DZMSAIKilled.sqf";

DZMSBoxSetup = "\z\addons\dayz_server\DZMS\Scripts\DZMSBox.sqf";
DZMSSaveVeh = "\z\addons\dayz_server\DZMS\Scripts\DZMSSaveToHive.sqf";

diag_log text "[DZMS]: Loading Compiled Functions.";
// compiled functions
DZMSAISpawn = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSAISpawn.sqf";
DZMSAIStaticDefender = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\Scripts\DZMSAIStaticDefender.sqf";

diag_log text "[DZMS]: Loading All Other Functions.";
//Attempts to find a mission location
//If findSafePos fails it searches again until a position is found
//This fixes the issue with missions spawning in Novy Sobor on Chernarus
DZMSFindPos = {
    private["_mapHardCenter","_mapRadii","_isTavi","_centerPos","_pos","_disCorner","_hardX","_hardY","_findRun","_posX","_posY","_feel1","_feel2","_feel3","_feel4","_noWater","_tavTest","_tavHeight","_disMaj","_disMin","_okDis","_isBlack","_playerNear","_tooClose"];
  
    //Lets try to use map specific "Novy Sobor Fixes".
    //If the map is unrecognised this function will still work.
	//Better code thanks to Halv
	_mapHardCenter = true;
	_mapRadii = 5500;
	_isTavi = false;
	_tavHeight = 0;
	switch (DZMSWorldName) do {
		case "chernarus":{_centerPos = [7100, 7750, 0];_mapRadii = 5500;};
		case "utes":{_centerPos = [3500, 3500, 0];_mapRadii = 3500;};
		case "zargabad":{_centerPos = [4096, 4096, 0];_mapRadii = 4096;};
		case "fallujah":{_centerPos = [3500, 3500, 0];_mapRadii = 3500;};
		case "takistan":{_centerPos = [5500, 6500, 0];_mapRadii = 5000;};
		case "tavi":{_centerPos = [10370, 11510, 0];_mapRadii = 14090;_isTavi = true;};
		case "lingor":{_centerPos = [4400, 4400, 0];_mapRadii = 4400;};
		case "namalsk":{_centerPos = [4352, 7348, 0]};
		case "napf":{_centerPos = [10240, 10240, 0];_mapRadii = 10240;};
		case "mbg_celle2":{_centerPos = [8765.27, 2075.58, 0]};
		case "oring":{_centerPos = [1577, 3429, 0]};
		case "panthera2":{_centerPos = [4400, 4400, 0];_mapRadii = 4400;};
		case "isladuala":{_centerPos = [4400, 4400, 0];_mapRadii = 4400;};
		case "smd_sahrani_a2":{_centerPos = [13200, 8850, 0]};
		case "sauerland":{_centerPos = [12800, 12800, 0];_mapRadii = 12800;};
		case "trinity":{_centerPos = [6400, 6400, 0];_mapRadii = 6400;};
		//We don't have a supported map. Let's use the norm.
		default{_pos = [getMarkerPos "center",0,5500,60,0,20,0] call BIS_fnc_findSafePos;_mapHardCenter = false;};
	};

    //If we have a hardcoded center, then we need to loop for a location
    //Else we can ignore this block of code and just return the position
    if (_mapHardCenter AND (!(DZMSStaticPlc))) then {
   
        _hardX = _centerPos select 0;
        _hardY = _centerPos select 1;
   
        //We need to loop findSafePos until it doesn't return the map center
        _findRun = true;
        while {_findRun} do {
		
            _pos = [_centerPos,0,_mapRadii,60,0,20,0] call BIS_fnc_findSafePos;
           
            //Apparently you can't compare two arrays and must compare values
            _posX = _pos select 0;
            _posY = _pos select 1;
           
            //Water Feelers. Checks for nearby water within 50meters.
            _feel1 = [_posX, _posY+50, 0];
            _feel2 = [_posX+50, _posY, 0];
            _feel3 = [_posX, _posY-50, 0];
            _feel4 = [_posX-50, _posY, 0];
           
            //Water Check
            _noWater = (!surfaceIsWater _pos && !surfaceIsWater _feel1 && !surfaceIsWater _feel2 && !surfaceIsWater _feel3 && !surfaceIsWater _feel4);
			
			//Lets test the height on Taviana
			if (_isTavi) then {
				_tavTest = createVehicle ["Can_Small",[_posX,_posY,0],[], 0, "CAN_COLLIDE"];
				_tavHeight = (getPosASL _tavTest) select 2;
				deleteVehicle _tavTest;
			};
          
			_tooClose = false;
			if (count DZMSMissionCoord > 0) then {
	
			    {
				    if (_pos distance (getMarkerPos _x) < DZMSMissionsDistance) then {_tooClose = true;};
			    } forEach DZMSMissionCoord;
		    };
			
            //make sure the point is not blacklisted
            _isBlack = false;
            {
                if ((_pos distance (_x select 0)) <= (_x select 1)) then {_isBlack = true;};
            } forEach DZMSBlacklistZones;
			
			_playerNear = {isPlayer _x} count (_pos nearEntities ["CAManBase", 500]) > 0;
            
			//Lets combine all our checks to possibly end the loop
            if ((_posX != _hardX) AND (_posY != _hardY) AND _noWater AND !_isBlack AND !_playerNear AND !_tooClose) then {
				if (!(_isTavi)) then {
					_findRun = false;
				};
				if (_isTavi AND (_tavHeight <= 185)) then {
					_findRun = false;
				};
            };
			// If the missions never spawn after running, use this to debug the loop.
			// Will Complete if: noWater = true / Distance > 1000 / TaviHeight <= 185 / Blacklisted = false / PlayerNear = false
			//diag_log text format ["[DZMS]: DEBUG: Pos:[%1,%2] / noWater?:%3 / okDistance?:%4 / TaviHeight:%5 / isBlackListed:%6 / isPlayerNear:%7", _posX, _posY, _noWater, _okDis, _tavHeight, _isBlack, _playerNear];
            sleep 2;
        };
       
    };
	
	if (DZMSStaticPlc) then {
		_pos = DZMSStatLocs call BIS_fnc_selectRandom;
	};
   
    _fin = [(_pos select 0), (_pos select 1), 0];
    _fin
};

//Clears the cargo and sets fuel, direction, and orientation
//Direction stops the awkwardness of every vehicle bearing 0
DZMSSetupVehicle = {
	private ["_object","_objectID","_ranFuel","_is50Cal"];
	_object = _this select 0;

	_objectID = str(round(random 999999));
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];	
	
	if (typeOf _object == "M2StaticMG") then {_is50Cal = true;}else{_is50Cal = false;};
	
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	
	waitUntil {(!isNull _object)};
	
	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	
	_ranFuel = random 1;
	if (_ranFuel < .1) then {_ranFuel = .1;};
	if (!_is50Cal) then {
		_object setFuel _ranFuel;
		_object setvelocity [0,0,1];
		_object setDir (round(random 360));
		
		//If saving vehicles to the database is disabled, lets warn players it will disappear
		if (!(DZMSSaveVehicles)) then {
			_object addEventHandler ["GetIn",{
				_nil = [nil,(_this select 2),"loc",rTITLETEXT,"Warning: This vehicle will disappear on server restart!","PLAIN DOWN",5] call RE;
			}];
		};
	};

	true
};

//Prevents an object being cleaned up by the server anti-hack
DZMSProtectObj = {
	private ["_object","_objectID"];
	_object = _this select 0;
	
	_objectID = str(round(random 999999));
	_object setVariable ["ObjectID", _objectID, true];
	_object setVariable ["ObjectUID", _objectID, true];
	
	if (_object isKindOf "ReammoBox") then {
		// PermaLoot on top of ObjID because that "arma logic"
		_object setVariable ["permaLoot",true];
	};

	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _object];
	
    if (!((typeOf _object) in ["USVehicleBox","USLaunchersBox","DZ_AmmoBoxUS","DZ_AmmoBoxRU","DZ_MedBox","USBasicWeaponsBox","USBasicAmmunitionBox","RULaunchersBox","AmmoBoxBig"]) || DZMSSceneryDespawnLoot) then {
        _object setVariable["DZMSCleanup",true];
    };
	true
};

//Gets the weapon and magazine based on skill level
DZMSGetWeapon = {
	private ["_skill","_aiweapon","_weapon","_magazine","_fin"];
	
	_skill = _this select 0;
	
	//diag_log text format ["[DZMS]: AI Skill Func:%1",_skill];
	
	switch (_skill) do {
		case 0: {_aiweapon = DZMSWeps0;};
		case 1: {_aiweapon = DZMSWeps1;};
		case 2: {_aiweapon = DZMSWeps2;};
		case 3: {_aiweapon = DZMSWeps3;};
	};
	_weapon = _aiweapon call BIS_fnc_selectRandom;
	_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
	
	_fin = [_weapon,_magazine];
	
	_fin
};

//This gets the random vehicle to spawn at a mission
DZMSGetVeh = {
	private ["_type","_vehArray","_choseVic"];
	
	_type = _this select 0;
	
	switch (_type) do {
		case "heli": {_vehArray = DZMSChoppers;};
		case "small": {_vehArray = DZMSSmallVic;};
		case "large": {_vehArray = DZMSLargeVic;};
	};
	
	_choseVic = _vehArray call BIS_fnc_selectRandom;
	
	_choseVic
};

//function to wait for mission completion
DZMSWaitMissionComp = {
    private["_objective","_unitArrayName","_numSpawned","_numKillReq","_distance","_return","_proximiter"];
	
    _objective = _this select 0;
    _unitArrayName = _this select 1;
	_distance = _this select 2;
	
	_numSpawned = count _unitArrayName;
    _numKillReq = ceil(DZMSRequiredKillPercent * _numSpawned);
	_startTime = diag_tickTime;
	_return = false;
	_proximiter = false;
	
    diag_log text format["[DZMS]: (%3) Waiting for %1/%2 Units or Less to be Alive and a Player to be Near the Objective.",(_numSpawned - _numKillReq),_numSpawned,_unitArrayName];
	
    while {true} do {
        if (({(isPlayer _x) && (_x distance _objective <= _distance)} count playableUnits > 0) && ({alive _x} count _unitArrayName <= (_numSpawned - _numKillReq))) exitWith {};
		if ((diag_tickTime - _startTime) > DZMSSceneryDespawnTimer and !_proximiter) exitWith {
		    _return = true;
		    {
			    _x call sched_co_deleteVehicle;
			} forEach (_objective nearObjects 50) + _unitArrayName;
		};
		if ({(isPlayer _x) && (_x distance _objective <= DZMSMissionPlayerRange)} count playableUnits > 0) then {
		    _proximiter = true;
		};
	    sleep 5;
    };
	_return
};
// clean mission object after end 
DZMSEndCleanUp = {
    {
	    _x call sched_co_deleteVehicle;
	} forEach (_this nearObjects 50);
};

//sleep function that uses diag_tickTime for accuracy
DZMSSleep = {
    private["_sleepTime","_checkInterval","_startTime"];
	
    _sleepTime = _this select 0;
    _checkInterval = _this select 1;
	
    _startTime = diag_tickTime;
    waitUntil{sleep _checkInterval; (diag_tickTime - _startTime) > _sleepTime;};
};

findPos_Near_Road = {
    private ["_position","_dist","_count","_Select","_roads","_road","_loop","_retour"];
	_dist = _this;
	
	_loop = true;
	while {_loop} do {
	    _position = call DZMSFindPos;
        _roads = _position nearRoads _dist;
        _count = count _roads;
        _Select = floor(random _count);
        _road = _roads select _Select;
		if !(isNil "_road") then {
		    _loop = false;
		};
	};
	_road
};

DZMS_Stop = {
    private["_unit"];
    _unit = _this select 0;
    waituntil {
        sleep 0.03;
        _unit forcespeed 0;
        !alive _unit
    };
    _unit forcespeed - 1;
};

DZMS_Defender = {
    private["_unit","_position"];
    _unit = _this select 0;
    _position =
    if (count _this > 1) then {
        _this select 1;
    } else {
        getposatl _unit;
    };
    dostop _unit;
    [_unit] spawn DZMS_stop;
    sleep 2;
    while {alive _unit}do{
        _unit setunitpos "up";
        sleep(3 + random 10);
        if (alive _unit) then {
            _unit setposatl _position;
            _unit setunitpos "middle";
            sleep(5 + random 15);
        };
    };
};

//------------------------------------------------------------------//
diag_log text format ["[DZMS]: Mission Functions Script Loaded!"];
