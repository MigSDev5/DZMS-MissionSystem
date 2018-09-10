/*
	DayZ Mission System Timer by Vampire
	Based on fnc_hTime by TAW_Tonic and SMFinder by Craig
	This function is launched by the Init and runs continuously.
*/
private ["_timeDiff","_timeVar","_wait","_cntMis","_ranMis","_varName","_cnt","_decal"];

_timeDiff = DZMSMinorMax - DZMSMinorMin;
_timeVar = _timeDiff + DZMSMinorMin;

diag_log "[DZMS]: Minor Mission Clock Starting!";

while {true} do {
	_cnt = {alive _x} count playableUnits;
	if (DZMSMinCount >= DZMSMaxMissionsMin) then {
	    _wait  = round(random _timeVar);
	    [_wait,5] call DZMSSleep;
	}else{
	    //_decal = DZMSIntMinDefault + round random 120;
	    sleep DZMSIntMinDefault;
	};
	
	_cntMis = count DZMSMinorArray;
	if (_cntMis == 0) exitWith {};
    _ranMis = floor (random _cntMis);
	_varName = DZMSMinorArray select _ranMis;
	
	if (DZMSMinRunning < DZMSMaxMissionsMin and (_cnt >= 1) and !(_varName in DZMSInProgress)) then {
     
	    [] execVM format ["\z\addons\dayz_server\DZMS\Missions\Minor\%1.sqf",_varName];
	    diag_log text format ["[DZMS]: Running Minor Mission %1.",_varName];
	};
};