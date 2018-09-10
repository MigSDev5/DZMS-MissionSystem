/*
	Adds a marker for Major Missions. Only runs once.
	DZMSMarkerLoop.sqf keeps this marker updated.
	Usage: [coordinates,missionname]
*/

private["_DZMSMinCoords","_DZMSMinName","_markerA","_markerB","_markers","_num","_MarkerNameA","_MarkerNameB"];

_DZMSMinCoords = _this select 0;
_DZMSMinName = _this select 1;

_num = floor(random 999);

_MarkerNameA = format ["Min%1%2",_DZMSMinName,_num];
_MarkerNameB = format ["MinD%1%2",_DZMSMinName,_num];

_markerA = createMarker [_MarkerNameA,_DZMSMinCoords];
_markerA setMarkerColor DZMMinColorMarker;
_markerA setMarkerShape "ELLIPSE";
_markerA setMarkerBrush "Grid";
_markerA setMarkerSize [150,150];

_markerB = createMarker [_MarkerNameB,_DZMSMinCoords];
_markerB setMarkerColor "ColorBlack";
_markerB setMarkerType "Vehicle";
_markerB setMarkerText _DZMSMinName;

[_markerA,_markerB,_DZMSMinCoords,_DZMSMinName,DZMMinColorMarker] spawn DZMSMarkerLoop;

[_markerA,_markerB]