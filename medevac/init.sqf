
unit = _this select 0;
REVIVETIME_INSECONDS = 10;
HQ = [(side unit),"HQ"];  

fnc_spawnHelo = compile preprocessFileLineNumbers  "medevac\fnc\SpawnHelo.sqf";
fnc_SpawnHeloCrew = compile preprocessFileLineNumbers  "medevac\fnc\SpawnHeloCrew.sqf";
fnc_SpawnHeloReplacement = compile preprocessFileLineNumbers  "medevac\fnc\SpawnHeloReplacement.sqf";
fnc_HandleDamage = compile preprocessFileLineNumbers  "medevac\fnc\HandleDamage.sqf";
fnc_HandleKilled = compile preprocessFileLineNumbers  "medevac\fnc\HandleKilled.sqf";
fnc_Heal = compile preprocessFileLineNumbers "medevac\fnc\heal.sqf";
fnc_Save = compile preprocessFileLineNumbers "medevac\fnc\save.sqf";
fnc_Carry = compile preprocessFileLineNumbers "medevac\fnc\carry.sqf";
fnc_ChopperPath = compile preprocessFileLineNumbers "medevac\fnc\chopperpath.sqf";
fnc_calculateTimeToHeal = compile preprocessFileLineNumbers "medevac\fnc\calculateTimeToHeal.sqf";
fnc_spawnHealEquipement = compile preprocessFileLineNumbers "medevac\fnc\spawnHealEquipement.sqf";
fnc_spawnObject = compile preprocessFileLineNumbers "medevac\fnc\spawnObject.sqf";
fnc_dropInHelo = compile preprocessFileLineNumbers "medevac\fnc\dropInHelo.sqf";
fnc_help = compile preprocessFileLineNumbers "medevac\fnc\help.sqf";
fnc_abortMedevac = compile preprocessFileLineNumbers "medevac\fnc\abortMedevac.sqf";
fnc_removeFAKS = compile preprocessFileLineNumbers "medevac\fnc\removeFAKS.sqf";


transportHelo = objNull;
handle = objNull;
IsInBound = false; 
MEDEVAC_showMenu = false;
MEDEVAC_FirstTrigger = false;
MEDEVAC_marker = "";
MEDEVAC_ISABORTED = false;
SmokeShell = objNull;
unit addItem  "SmokeShellGreen";
unit addItem  "SmokeShellGreen";
unit addItem  "SmokeShellGreen";

SoldiersDead = [];
{	
	if (!isPlayer(_x))then{
		_x addEventHandler ["HandleDamage",{_this call fnc_HandleDamage;}];
		_x addEventHandler ["Killed",{_this call fnc_HandleKilled;}];
	};
}foreach (units (group unit));

_posChopper = objNull;


while {true} do {

	//Push dead soldiers
	{
		_isInjured = _x getVariable["unit_injured",false];
		SoldiersDead = SoldiersDead - [_x];
		if(alive(_x) && _isInjured)then{
			[_x] join grpNull;
			SoldiersDead pushback _x;
		};
	}foreach(units (group unit));


	//Launch chopper
	if (MEDEVAC_FirstTrigger)then{
		MEDEVAC_showMenu = false;
		MEDEVAC_FirstTrigger = false;
		MEDEVAC_marker = "";
		deleteMarker "medevac_marker";

		HQ sideChat "We're waiting now for your mark !";

		//open the map
		if (player == unit) then {
	    	openMap true;


			//move the marker to the click position
			onMapSingleClick {
				MEDEVAC_marker = createMarkerLocal ["medevac_marker",_pos];
				MEDEVAC_marker setMarkerColorLocal "ColorBlack";
				MEDEVAC_marker setMarkerShapeLocal "ELLIPSE";
				MEDEVAC_marker setMarkerBrushLocal "Solid";
				MEDEVAC_marker setMarkerSizeLocal [13, 13];
			};

			//clear the click handle
			waitUntil {MEDEVAC_marker != ""};
			unit onMapSingleClick "";
			HQ sideChat "I copy !";
			sleep 1;
			openMap false;

			if ((count SoldiersDead > 0) && !IsInBound)then {
				IsInBound = true;
				transportHelo = [] call fnc_spawnHelo;
				_posChopper = position transportHelo;
				_tmp = SoldiersDead;
				[group transportHelo,getMarkerPos "medevac_marker",transportHelo,unit,_tmp] call fnc_ChopperPath;
			}else{
				hint "Impossible to request";
				MEDEVAC_showMenu = true;
				[unit, "Medevac"] call BIS_fnc_addCommMenuItem;
			};
		};
	};

	//StandBy
	if(isNull transportHelo)then{ 
		IsInBound = false;
		MEDEVAC_FirstTrigger = false;
		if (count SoldiersDead > 0 && !MEDEVAC_showMenu)then{
			MEDEVAC_showMenu = true;
			[unit, "Medevac"] call BIS_fnc_addCommMenuItem;
		};
	}else{

		if (MEDEVAC_ISABORTED)then{
			sleep 150;
			IsInBound = false;
		}else{
			if (!alive transportHelo || damage transportHelo > .6)then{
				hint "Chopper is destroyed ! Transport available in 150s";
				sleep 150;
				IsInBound = false;
			};
		}
	};


	sleep 3;
};

