private["_type","_price"];

_type  = _this select 0;
_price = _this select 1;

if( ((player getVariable["IH_SCORE",0]) - _price) >= 0)then {

	_nb = (SUPPORT_REQUESTER getVariable [format ["BIS_SUPP_limit_%1", _type], 0]) + 1;
	hint format["%1 x%2",_type,_nb];
	[SUPPORT_REQUESTER, _type,_nb] call BIS_fnc_limitSupport;
	BIS_supp_refresh = TRUE; publicVariable "BIS_supp_refresh";


	closeDialog 0;
	[player,-_price] call fnc_updatescore;
}else{
	player sideChat "You can't afford it, not enough points... Try it later.";
};



