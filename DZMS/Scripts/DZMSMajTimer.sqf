/*
	DayZ Mission System Timer by Vampire
	Based on fnc_hTime by TAW_Tonic and SMFinder by Craig
	This function is launched by the Init and runs continuously.
*/
private ["_timeDiff","_timeVar","_wait","_cntMis","_ranMis","_varName","_cnt"];

_timeDiff = DZMSMajorMax - DZMSMajorMin;
_timeVar = _timeDiff + DZMSMajorMin;

diag_log "[DZMS]: Major Mission Clock Starting!";

while {true} do {
	_cnt = {alive _x} count playableUnits;
	if (DZMSMajCount >= DZMSMaxMissionsMaj) then {
	    _wait  = round(random _timeVar);
	    [_wait,5] call DZMSSleep;
	}else{
	    sleep DZMSIntMajDefault;
	};
	
	_cntMis = count DZMSMajorArray;
	if (_cntMis == 0) exitWith {};
    _ranMis = floor (random _cntMis);
    _varName = DZMSMajorArray select _ranMis;

	if (DZMSMajRunning < DZMSMaxMissionsMaj AND (_cnt >= 1) and !(_varName in DZMSInProgress)) then {

	    [] execVM format ["\z\addons\dayz_server\DZMS\Missions\Major\%1.sqf",_varName];
	    diag_log text format ["[DZMS]: Running Major Mission %1.",_varName];	
	};
};