/*
	Marker Resetter by Vampire
	Marker Resetter checks if a Mission is running and resets the marker for JIPs
*/

private["_markerA","_markerB","_DZMSMajCoords","_DZMSMajName","_DZMSColorMarker","_DZMSColorMarker2"];

_MarkerA       = _this select 0;
_MarkerB       = _this select 1;
_DZMSMajCoords = _this select 2;
_DZMSMajName   = _this select 3;
_DZMSColorMarker = _this select 4;

if (count _this > 5) then {
    _DZMSColorMarker2 = _this select 5;
}else{
    _DZMSColorMarker2 = "ColorBlack";
};

diag_log format ["[DZMS]: Mission Marker Loop for JIPs Starting!"];


while {true} do {
	
	if (getMarkerColor _MarkerA == "") exitWith {};
	
	if (!(getMarkerColor _MarkerA == "")) then {
	    
		deleteMarker _markerA;
		deleteMarker _markerB;
		
		_markerA = createMarker [_markerA,_DZMSMajCoords];
		_markerA setMarkerColor _DZMSColorMarker;
		_markerA setMarkerShape "ELLIPSE";
		_markerA setMarkerBrush "Grid";
		_markerA setMarkerSize [175,175];
	
		_markerB = createMarker [_markerB,_DZMSMajCoords];
		_markerB setMarkerColor _DZMSColorMarker2;
		_markerB setMarkerType "Vehicle";
		_markerB setMarkerText _DZMSMajName;
		
	};
	sleep 30;
};