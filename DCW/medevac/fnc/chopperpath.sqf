/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

private _grp = _this select 0;
private _landPos =_this select 1;
TRANSPORTHELO = _this select 2;
private _unit = _this select 3;

interventionGroup = [TRANSPORTHELO,side _unit] call fnc_SpawnHeloCrew;

HASLANDED = false;

private _startPos = position TRANSPORTHELO;
[HQ,format["Be advised: medevac chopper in bound ! ETA : %1min",ceil((_landPos distance _startPos)/1000)*.333] ,true] remoteExec ["fnc_talk", GROUP_PLAYERS, false];

 private _wp0 = _grp addwaypoint [_landPos, 10];
 _wp0 setwaypointtype "MOVE";

TRANSPORTHELO addEventHandler ["handleDamage", {
	params [
		"_unit",			
		"_hitSelection",	
		"_damage",			
		"_source",		
		"_projectile",		
		"_hitPartIndex",	
		"_instigator",		
		"_hitPoint"		
	];
	if (_damage > .2)then{
		MEDEVAC_State = "aborted";
	}
}];


waitUntil {MEDEVAC_State == "aborted" || TRANSPORTHELO distance2D _landPos < 200};
if (MEDEVAC_State == "aborted") exitWith { false };

[HQ,"Squad leader, throw a green smoke to mark the LZ !" ,true] remoteExec ["fnc_talk"];


SmokeShell = objNull;
_unit addEventHandler ["Fired", {
	if ((_this select 4) isKindOf "SmokeShell") then 
	{
		SmokeShell = _this select 6;
	}
}];


private _startTime = time;
waitUntil {!isNull SmokeShell || time > (_startTime + 50 ) };
if (time > (_startTime + 50)) exitWith { MEDEVAC_State = "aborted"; };

sleep 5;

[] spawn{
	sleep 3;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
	sleep 5;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
	sleep 3;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
};

[HQ,"Landing procedure started !" ,true] remoteExec ["fnc_talk"];

_unit removeEventHandler ["Fired", 0];

deleteWaypoint [_grp, 0];
 private _pos = [getposatl SmokeShell, 2, 50, 7, 0, 20, 0] call BIS_fnc_FindSafePos;
 private _landpad = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
 private _wp01 = _grp addwaypoint [_pos, 0];

 _wp01 setwaypointtype "UNLOAD";
 _wp01 setWaypointStatements ["true","HASLANDED = true;"];

_timer = time;
waitUntil {sleep 2; MEDEVAC_state == "aborted" || HASLANDED || time == _timer + 300};
if (MEDEVAC_state == "aborted") exitWith{false};
if (!HASLANDED) exitWith { MEDEVAC_State = "aborted"; };

// Update the dead soldiers
private _soldiersDead = units (group _unit) select {_x getVariable["unit_injured",false] };
replacementGroup = [TRANSPORTHELO,side _unit,_soldiersDead] call fnc_SpawnHeloReplacement;

sleep 1;

TRANSPORTHELO land "GET IN";
replacementGroup leavevehicle TRANSPORTHELO;
interventionGroup leavevehicle TRANSPORTHELO; 

waitUntil{sleep 2; { MEDEVAC_state == "aborted" ||  _x in TRANSPORTHELO} count units  replacementGroup == 0 && {_x in TRANSPORTHELO} count units  interventionGroup == 0  };
if (MEDEVAC_state == "aborted") exitWith{false};

replacementGroup move position _unit;
{_x setUnitPos "MIDDLE"; _x setBehaviour "MIDDLE"; } foreach (units replacementGroup);

{ [_x] joinSilent grpNull; } foreach _soldiersDead;

//Make replacementGroup join player
{unassignVehicle _x;_x setBehaviour "AWARE"; _x enableAI "ALL"; _x setUnitPos "AUTO";}foreach (units replacementGroup);
(units replacementGroup) join group _unit;
[HQ,"Reinforcments arriving.",true] remoteExec ["fnc_talk"];

// Save units
[HQ,format["We're starting the %1 injured's evacuations.",count _soldiersDead],true] remoteExec ["fnc_talk"];
[interventionGroup,_soldiersDead,TRANSPORTHELO] spawn fnc_save;

waitUntil{sleep 2; MEDEVAC_state == "aborted" || ({_x in TRANSPORTHELO} count (units  interventionGroup) == count (units  interventionGroup)) };
if (MEDEVAC_state == "aborted") exitWith { false };

/*
//Suppress des waypoints
while {(count(waypoints _grp))>0} do 
{
	deleteWaypoint ((waypoints _grp) select 1);	
	sleep 0.01;
};*/
/*
private _wp1 = _grp addwaypoint [_startPos, 0];
_wp1 setwaypointtype "MOVE";
_wp1 setWaypointStatements ["true","MEDEVAC_State = ""succeeded"";"];
*/

// Go back home
TRANSPORTHELO move _startPos;

sleep 3;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];
sleep 5;
	TRANSPORTHELO action ["useWeapon",TRANSPORTHELO,driver TRANSPORTHELO,1];

// Check waypoint;
waitUntil{sleep 2; MEDEVAC_state == "succeeded" || (TRANSPORTHELO distance2D _startPos < 150) };
MEDEVAC_State = "succeeded";

