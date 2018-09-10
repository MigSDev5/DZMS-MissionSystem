/*
	Adds a marker for Major Missions. Only runs once.
	DZMSMarkerLoop.sqf keeps this marker updated.
	Usage: [coordinates,missionname]
*/

private["_DZMSMajCoords","_DZMSMajName","_markerA","_markerB","_markers","_num","_MarkerNameA","_MarkerNameB"];

_DZMSMajCoords = _this select 0;
_DZMSMajName = _this select 1;

_num = floor(random 999);

_MarkerNameA = format ["Maj%1%2",_DZMSMajName,_num];
_MarkerNameB = format ["MajD%1%2",_DZMSMajName,_num];

_markerA = createMarker [_MarkerNameA,_DZMSMajCoords]; 
_markerA setMarkerColor DZMSMajColorMarker;
_markerA setMarkerShape "ELLIPSE";
_markerA setMarkerBrush "Grid";
_markerA setMarkerSize [175,175];

_markerB = createMarker [_MarkerNameB,_DZMSMajCoords]; 
_markerB setMarkerColor "ColorBlack";
_markerB setMarkerType "Vehicle";
_markerB setMarkerText _DZMSMajName;

[_markerA,_markerB,_DZMSMajCoords,_DZMSMajName,DZMSMajColorMarker] spawn DZMSMarkerLoop;

[_markerA,_markerB]