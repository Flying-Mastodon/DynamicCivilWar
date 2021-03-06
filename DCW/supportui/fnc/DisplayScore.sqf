/**
 * DYNAMIC CIVIL WAR
 * Created: 2017-11-29
 * Author: BIDASS
 * License : GNU (GPL)
 */

if (isNull player) exitWith{false;};


private _points = DCW_SCORE;
private _colorChaser = "";
private _labelChaser = "";
private _statusUnd = "";
private _colorUnd = "";

// Chasing status
if (CHASER_TRIGGERED) then{
	_colorChaser = "#e46b6b";
	_labelChaser = "Calling reinforcements";
} else {
	_colorChaser = "#2f9581";
	_labelChaser = "Safe";
};

// Undercover status
if (player getVariable["DCW_undercover",false]) then{
	_statusUnd = "hidden";
	_colorUnd = "#2f9581";
	if (player getVariable["DCW_watched",false]) then{
		_statusUnd = "watched";
		_colorUnd = "#e0923a";
	};
}else{
	_statusUnd = "Inactive";
	_colorUnd = "#e46b6b";
};


("RscStatusBar" call BIS_fnc_rscLayer) cutRsc ["RscStatusBar","PLAIN"];	
	disableSerialization;
	((uiNamespace getVariable "RscStatusBar")displayCtrl 55554) ctrlSetStructuredText
parseText format ["<t shadow='1' shadowColor='#000000' color='#FFFFFF'>Score : %1 points | Lives : %2 | Enemies state : <t color='%3'>%4</t> | Undercover : <t color='%5'>%6</t></t>",_points,REMAINING_RESPAWN,_colorChaser,_labelChaser,_colorUnd,_statusUnd];