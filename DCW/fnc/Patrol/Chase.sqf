/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


private ["_lastKnownPosition","_flrObj"];
private _leader = _this select 0;
private _unitChased = _this select 1;

private _marker = createMarker [format["sold%1",random 13100], position player];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [6,6];
_marker setMarkerColor "ColorBlack";
_marker setMarkerBrush "SolidBorder";


while { alive _leader && alive _unitChased }do{
    if (_leader knowsAbout _unitChased >= .5) then {
        if (time > LAST_FLARE_TIME + 120)then{
            _flrObj = "F_40mm_white" createvehicle ((_unitChased) modelToWorld [50-round(random 25),50-round(random 25),200]); 
            _flrObj setVelocity [0,0,-.1];
            LAST_FLARE_TIME = time;
        };
        _lastKnownPosition = _leader getHideFrom _unitChased;
    }else{
        //Si déclenchement de la recherche
        if (CHASER_TRIGGERED)then{
            _leader setBehaviour "AWARE";
            _leader setSpeedMode "FULL";
            _lastKnownPosition = [position _unitChased , 0, 100, 1, 0, 20, 0] call BIS_fnc_FindSafePos;
        }else{
            _leader setBehaviour "SAFE";
            _leader setSpeedMode "LIMITED";
            _lastKnownPosition = [position _leader , 0, 500, 1, 0, 20, 0] call BIS_fnc_FindSafePos;
        };
    };
    
    _marker setMarkerPos _lastKnownPosition;

    group _leader move _lastKnownPosition;
    
    sleep 30;
};

