/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License: MIT
 */

private _unit = _this select 0;
private _asker = _this select 1;
private _probability  =  if (count _this == 3) then { _this select 2 } else { 50 };


private _pos = getPosASL _unit;
private _potentialIntel = [];
{
    if (_x select 2)then{
        {
            if (!(_x getVariable["DCW_isIntelRevealed",false]) && _x getVariable["DCW_isIntel",false] && _pos distance _x < 500)then{
                _potentialIntel pushBack _x;
            };
        } foreach (_x select 7);
    };
} forEach MARKERS;


if (count _potentialIntel == 0 || random 100 > _probability) exitWith { [false,"I have nothing to tell you ! Leave me alone !"];};

private _intel = _potentialIntel call BIS_fnc_selectRandom;
_task = [_intel,_asker] call fnc_createTask;
_taskId = _task select 0;
_message = _task select 1;
_intel setVariable["DCW_isIntelRevealed",true];
private _marker = createMarker [format["s%1",random 13100],getPos _intel];
_marker setMarkerShape "ICON";
_marker setMarkerColor "ColorBlack";
_marker setMarkerType "hd_objective";
_intel setVariable["DCW_markerIntel",_marker];
_intel setVariable["DCW_task",_taskId];
 //_currentTask setTaskState "SUCCEEDED";
//["destroyMissile", "SUCCEEDED"] call BIS_fnc_taskHint;
[true,_message];