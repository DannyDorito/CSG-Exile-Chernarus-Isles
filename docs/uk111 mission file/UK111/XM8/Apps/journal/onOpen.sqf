private["_display"];
_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
_notes = profileNamespace getVariable ["ExAd_Journal_Notes",[]];
_listCtrl = [_display,"APPS_journal","listNotes"] call XM8_Apps_fnc_getAppCtrl;
lbClear _listCtrl;
{
	_index = _listCtrl lbAdd _x;
	_listCtrl lbSetTooltip [_index, _x];
} forEach _notes;
