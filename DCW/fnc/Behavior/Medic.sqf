/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */


_this remoteExec ["RemoveAllActions",0];

_this setVariable["DCW_Medic",true];
removeGoggles _this;
removeHeadgear _this;

_this stop true;

//Heal action
[_this, ["Heal me and my team ! (45 points / 3 hours)",{
    params["_medic","_unit","_action"];
    if ([GROUP_PLAYERS,45] call fnc_afford) exitWith {false};
    [_unit,"Could you please heal me and my team ?", false] call fnc_talk;
    [_medic,"Ok, Lets take a look at you...", false] call fnc_talk;
    if (!isMultiplayer) then {
        skipTime 3;
    };
    _medic removeAction _action;
    { _x setDamage 0; _x setFatigue 0; } foreach units (group (_unit));
    sleep 1;
    [_medic,"All done, you look good as new.", false] call fnc_talk;
}]] remoteExec ["addAction"];
