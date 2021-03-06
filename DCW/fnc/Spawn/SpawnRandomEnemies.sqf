/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


if (!isServer) exitWith{false};

private _numberOfmen = 1;
private _minRange = 300;
private _side = ENEMY_SIDE;
private _unit = objNull;
private _firstTrigger = true;
private _worldSize = if (isNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize")) then {getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");} else {8192;};
private _worldCenter = [_worldSize/2,_worldSize/2,0];

while{true}do {
	if ({ _x getVariable["DCW_type",""] == "patrol" } count UNITS_SPAWNED < MAX_RANDOM_PATROL)then{
		//Get random pos
		_side = ENEMY_SIDE;

		if (_firstTrigger) then {_minRange = 150; _firstTrigger = false;}else{_minRange = 500;};

		_pos = [position (allPlayers call BIS_fnc_selectRandom), _minRange, 550, 1, 0, 20, 0, MARKER_WHITE_LIST + PLAYER_MARKER_LIST,[]] call BIS_fnc_FindSafePos;
		if (_pos isEqualTo [] || _pos isEqualTo [2048,2048,2048]) then{
			sleep 3;
		} else {
			_numberOfmen =  (PATROL_SIZE select 0) + round(random(PATROL_SIZE SELECT 1));
			if (floor random 100 < PERCENTAGE_FRIENDLIES) then {
				_side = SIDE_CURRENT_PLAYER;
				_numberOfmen = 4;
			};

			_grp = createGroup _side;

			for "_j" from 1 to _numberOfmen do {

				if (_side == SIDE_CURRENT_PLAYER) then{
					_unit = [_grp,_pos,false] call fnc_spawnFriendly;
					/*
					if (_j == 1) then {
						_grpMarker = createMarker["mkr-"+str(floor random 10000), _pos];
						_grpMarker setMarkerShape "ICON";
						_grpMarker setMarkerColor "ColorGreen";
						_grpMarker setMarkerType "o_motor_inf";
						_unit call fnc_deleteMarker;
						_unit setVariable["marker", _grpMarker];
					};*/
				} else {
					_unit = [_grp,_pos,false] call fnc_spawnEnemy;
				};

				_unit setVariable["DCW_Type","patrol"];
				_unit setDir random 360;
				_unit setBehaviour "SAFE";
				sleep .4;
			};
			[leader _grp, 500] spawn fnc_simplePatrol;
			
		};
	};	
	
	/* moved to server.sqf for performance
	{
		_player= _x;
		{
			if(_x distance _player > 600)then{
				UNITS_SPAWNED - [_x];
				_unitPool = _unitPool - [_x];
				_x call fnc_deleteMarker;
				deleteVehicle _x;
			}
		}foreach _unitPool;
	} foreach allPlayers;*/

	sleep 12;
};
