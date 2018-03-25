private["_respawnDelay","_descriptions","_layer"];
_respawnDelay = _this;
//Revive
if (player getVariable["REVIVE",true]) then {
	_descriptions = [
		"KNOCKED OUT",
		"CRITICALLY WOUNDED",
		"BLEEDING OUT",
		"ON DEATHS DOOR"
	];
	player setVariable["revivePermitted",true,true];
} else {
	_descriptions = [
		"WRECKED",
		"REKT",
		"STOMPED",
		"WASTED",
		"SCREWED",
		"TOASTED",
		"REST IN PIECES",
		"TERMINATED",
		"KILLED",
		"EXILED",
		"ANNIHILATED",
		"HAMMERED",
		"NEUTRALIZED",
		"DUMPED",
		"ZAPPED",
		"SLAIN",
		"FRIED",
		"WIPED OUT",
		"VANQUISHED",
		"BUSTED",
		"PULVERIZED",
		"SMASHED",
		"SHREDDED",
		"CRUSHED"
	];
};

[100] call BIS_fnc_bloodEffect;

ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0.39, 0.32, 0.25, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit 0;
ExileClientPostProcessingColorCorrections ppEffectAdjust [1, 1, 0, [0.4, 0.2, 0.3, 0], [0.3, 0.05, 0, 0], [0.5,0.5,0.5,0], [0,0,0,0,0,0,4]];
ExileClientPostProcessingColorCorrections ppEffectCommit _respawnDelay;
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [0];
ExileClientPostProcessingBackgroundBlur ppEffectCommit 0;
ExileClientPostProcessingBackgroundBlur ppEffectEnable true;
ExileClientPostProcessingBackgroundBlur ppEffectAdjust [2];
ExileClientPostProcessingBackgroundBlur ppEffectCommit _respawnDelay;

ExileClientBleedOutHeartbeatPlaying = false;
ExileClientBleedOutCountDownDuration = _respawnDelay;
ExileClientBleedOutCountDownEnd = time + _respawnDelay;
player setVariable ["BleedoutCountDownEnd", ExileClientBleedOutCountDownEnd, true];
_layer = "BIS_fnc_respawnCounter" call bis_fnc_rscLayer;
_layer cutText ["", "plain"];

missionNamespace setVariable ["RscRespawnCounter_description", format ["<t size='2' align='center'>%1</t>",selectRandom _descriptions]];
missionNamespace setVariable ["RscRespawnCounter_colorID", 0];
missionNamespace setVariable ["RscRespawnCounter_Custom", _respawnDelay];

_layer cutRsc ["RscRespawnCounter", "plain"];
showChat true;

if (ExileClientBleedOutThread isEqualTo -1) then {
	ExileClientBleedOutThread = [2, ExileClient_object_player_thread_bleedToDeath, [], true] call ExileClient_system_thread_addtask;
};

true