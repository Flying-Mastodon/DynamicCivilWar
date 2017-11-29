params ["_unit","_side"];

[_unit] joinSilent grpNull;
[_unit] joinSilent (createGroup _side);

_unit removeEventHandler ["HandleDamage",0];
_unit removeEventHandler ["FiredNear",0];
//_unit setVariable ["",""];

private _marker = _unit getVariable["marker",""];
if (_side == ENEMY_SIDE)then{
        _marker setMarkerColor "ColorRed";
        _unit setVariable["IH_type","enemy"];
}else{
        _marker setMarkerColor "ColorGreen";
        _unit setVariable["IH_type","civ"];
};

// Random weapon loadout

_unit stop true;
_unit playActionNow  "TakeFlag";
removeAllActions _unit;
sleep 2;

switch (floor(random 3)) do
{
case 0:
{       
        _unit addVest "V_BandollierB_khk";
        _unit addMagazines ["30Rnd_545x39_Mag_F", 3];
        _unit addWeapon "arifle_AKS_F"; 
        _unit addMagazine "HandGrenade";
};
case 1:
{
        _unit addVest "V_Chestrig_oli";
	_unit addMagazines ["30Rnd_762x39_Mag_F", 3];
        _unit addWeapon "arifle_AKM_F";
        _unit addMagazine "HandGrenade";
};
case 2:
{
      	_unit addMagazines ["30Rnd_762x39_Mag_F", 3];
        _unit addWeapon "arifle_AKM_FL_F";
};
case 3:
{
          _unit addVest "V_BandollierB_oli";
	_unit addMagazines ["30Rnd_762x39_Mag_F", 3];
        _unit addWeapon "arifle_AKM_F";
};
};
_unit addItem "FirstAidkit";

_unit setskill ["Endurance",1];
_unit setskill ["aimingSpeed",1];
_unit setskill ["aimingAccuracy",1];
_unit setskill ["Endurance",1];
_unit setskill ["general",1];

sleep 4;
_unit playActionNow  "MountOptic";
sleep 3;
_unit stop false;
_unit SetBehaviour "COMBAT";
_unit allowFleeing .1;



_unit;