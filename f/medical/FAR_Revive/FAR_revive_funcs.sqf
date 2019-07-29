FAR_fnc_unitInit = {
	params ["_unit"];
	
	_unit addEventHandler ["Killed", FAR_fnc_HandleDeath]; // Used in instant death
	
	_unit setVariable ["FAR_var_isDragged", false, true];
	_unit setVariable ["FAR_var_isDragging", false, true];
	
	if !(isPlayer _unit) exitWith {};
	
	_unit addEventHandler ["Respawn", { params ["_unit", "_corpse"]; [_unit] spawn FAR_fnc_unitInit; if (captive _unit) then { _unit setCaptive false }; if (FAR_var_SpawnInMedical) then { [_unit] spawn FAR_fnc_TeleportNearestVehicle }; }];
	
	[_unit] spawn FAR_fnc_PlayerActions;
};

FAR_fnc_PlayerActions = {
	params ["_unit","_newUnit"];
	
	// SP Team Switch Fix
	if (!isNil "_newUnit") then {
		{
			if ((missionNamespace getVariable [_x,""]) isEqualType 0) then { _unit removeAction (missionNamespace getVariable _x) } 
		} forEach ["FAR_act_Revive", "FAR_act_Bag", "FAR_act_Stabilise", "FAR_act_Dragging", "FAR_act_Carry", "FAR_act_Release", "FAR_act_UnitLoad", "FAR_act_UnitUnload"];
		
		{ _x ppEffectEnable false } forEach [FAR_eff_ppVig, FAR_eff_ppBlur];
		
		_unit = _newUnit; 
	}; 
	
	if (alive _unit && _unit isKindOf "CAManBase") then {	
		// Revive
		if (!isNil "FAR_act_Revive") then { _unit removeAction FAR_act_Revive };
		FAR_act_Revive = _unit addAction ["Revive", FAR_fnc_Revive,[], 11, true, true, "", "call FAR_fnc_CheckRevive && {(cursorTarget distance _target) <= 2.8}",2.8];
				
		// Bagging
		if (!isNil "FAR_act_Bag") then { _unit removeAction FAR_act_Bag };		
		FAR_act_Bag = _unit addAction ["Bag Body", FAR_fnc_Bag, [], 8, false, true, "", "(call FAR_fnc_CheckBag) && {(cursorObject distance _target) <= 2.8}",2.8];
		
		// If everyone can revive so skip extended actions.
		if (FAR_var_ReviveMode != 1) then {
			// Stabilising
			if (!isNil "FAR_act_Stabilise") then { _unit removeAction FAR_act_Stabilise };
			FAR_act_Stabilise = _unit addAction ["Stabilize", FAR_fnc_Stabilize, [], 10, true, true, "", "(call FAR_fnc_CheckStabilize) && {(cursorTarget distance _target) <= 2.5}",2.5];
			
			// Dragging
			if (!isNil "FAR_act_Dragging") then { _unit removeAction FAR_act_Dragging };
			FAR_act_Dragging = _unit addAction ["Drag", FAR_fnc_UnitMove, ["drag"], 9, false, true, "", "(call FAR_fnc_CheckDragging) && {(cursorTarget distance _target) <= 2.5}",2.5];
		
			// Carrying
			if (!isNil "FAR_act_Carry") then { _unit removeAction FAR_act_Carry };
			FAR_act_Carry = _unit addAction ["Carry", FAR_fnc_UnitMove, ["carry"], 8, false, true, "", "(call FAR_fnc_CheckUnitCarry) && {(cursorTarget distance _target) <= 2.5}",2.5];
			
			// Loading
			if (!isNil "FAR_act_UnitLoad") then { _unit removeAction FAR_act_UnitLoad };
			FAR_act_UnitLoad = _unit addAction ["Load", FAR_fnc_UnitLoad, [], 10, false, true, "", "(call FAR_fnc_CheckUnitLoad)"];
		};
	};
};

FAR_fnc_DeathMessage = {
	params ["_killed", ["_killer", objNull], ["_type", "killed"]];
	
	// Are DMs enabled?
	if (isNull _killer || !(missionNamespace getVariable ["FAR_var_DeathMessages",false])) exitWith {};
	
	// Death message
	if (_killer != _killed) then {	
		
		// Never announce enemy or Zeus kills.
		if (
			!([side (group _killed), side (group _killer)] call BIS_fnc_sideIsEnemy) && 
			!([getAssignedCuratorLogic _killer] call BIS_fnc_isCurator) &&
			((isPlayer _killed && isPlayer _killer) || !isMultiPlayer)
		) then {
			if (vehicle _killer != _killer) then {
				format["<TeamKill> %1 was %4 by %2 (%3)", name _killed, name _killer, getText(configFile >> "CfgVehicles" >> typeOf vehicle _killer >> "displayName"), _type] remoteExec ["systemChat"];
			} else {
				format["<TeamKill> %1 was %3 by %2", name _killed, name _killer, _type] remoteExec ["systemChat"];
			};
		};
	};
};

FAR_fnc_HandleDamage = {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
	if (alive _unit && 
		_damage >= 0.9 && 
		!(lifeState _unit == "INCAPACITATED") && 
		_selection in ["","head","face_hub","neck","spine1","spine2","spine3","pelvis","body"]
	) then {
		// systemChat format["U: %1  S: %2  D: %3  K1: %4  P: %5  I: %6  K2: %7  H: %8", _unit, _selection, _damage, _source, _projectile, _hitIndex, _instigator, _hitPoint];
		// If not instant death check allowed values, otherwise just make them unconscious
		if ((random 100 < FAR_var_DeathChance  && (_damage < FAR_var_DeathDmgHead && _selection in ["head", "face_hub"] || _damage < FAR_var_DeathDmgBody && _selection == "")) || { !FAR_var_InstantDeath }) then {
			_unit allowDamage false;
			[_unit, if (isNull _instigator) then { _source } else { _instigator }] spawn FAR_fnc_SetUnconscious;
			0
		};
	};
};

FAR_fnc_HandleDeath = {
	params ["_unit", "_killer", "_instigator"];
	
	_target = if (_instigator == objNull) then { _killer } else { _instigator };
	
	// Player EH won't fire for AI so increase casualty counter.
	if !(isPlayer _unit) then {
		_unit spawn {
			{
				_x params ["_side","_marker"];
				if (side group _this == _side) exitWith {
					_cas = missionNamespace getVariable [format["f_var_casualtyCount_%1",_side],0];
					// Change the respawn marker to reflect # of casualties.
					missionNamespace setVariable [format["f_var_casualtyCount_%1",_side],_cas + 1,true];
					_marker setMarkerText format["Casualties: %1",(_cas + 1)];
					// Increase the groups own casualty value.
					(group _this) setVariable ["f_var_casualtyCount", ((group _this) getVariable ["f_var_casualtyCount",0]) + 1, true];
				};
			} forEach [
				[west,"respawn_west"],
				[east,"respawn_east"],
				[resistance,"respawn_guerrila"],
				[civilian,"respawn_civilian"]
			];
		};
	};
	
	if (isPlayer _target) then { [_unit, _target] spawn FAR_fnc_DeathMessage };
};

FAR_fnc_SetUnconscious = {
	params ["_unit", ["_killer", objNull]];
	
	// Eject unit if inside vehicle
	if (vehicle _unit != _unit) then {
		moveOut _unit;
		_unit action ["getOut", vehicle _unit];
		sleep 0.5;
	};
	
	if (random 3 > 1.7) then {
		playSound3D [format["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]], _unit, false, getPosASL _unit, 1.5, 1, 50];
	};
	
	//_unit switchMove "";
	_unit setUnconscious true;
	_unit setCaptive true;
	_unit setDamage 0.35;
		
	// Allow the downed unit to be damaged?
	if (FAR_var_InstantDeath) then { _unit allowDamage true } else { _unit allowDamage false };
	
	// Allow unit time to rag-doll.
	sleep 5;
	
	// If the unit was killed (instant death) exit.
	if (!alive _unit) exitWith {};
	
	if (FAR_var_AICanHeal && !isMultiPlayer) then { [_unit] spawn FAR_fnc_AIHeal };
	
	// Casualty Count Update.
	_unit spawn {
		// Random sleep to allow network sync if multiple casualties.
		sleep random 15;
		{
			_x params ["_side","_marker"];
			if (side group _this == _side) exitWith {
				_cas = missionNamespace getVariable [format["f_var_casualtyCount_%1",_side],0];
				// Change the respawn marker to reflect # of casualties.
				missionNamespace setVariable [format["f_var_casualtyCount_%1",_side],_cas + 1,true];
				_marker setMarkerText format["Casualties: %1",(_cas + 1)];
				// Increase the groups own casualty value.
				(group _this) setVariable ["f_var_casualtyCount", ((group _this) getVariable ["f_var_casualtyCount",0]) + 1, true];
			};
		} forEach [
			[west,"respawn_west"],
			[east,"respawn_east"],
			[resistance,"respawn_guerrila"],
			[civilian,"respawn_civilian"]
		];
	};
	
	// Apply visual effects.
	if (isPlayer _unit) then {
		disableUserInput true;
		titleText ["", "BLACK FADED"];
		disableUserInput false;
		disableUserInput true;
		disableUserInput false;
		
		FAR_eff_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[1,1,0,0,0,0.2,1]];
		FAR_eff_ppBlur ppEffectAdjust [0];
		
		{
			_x ppEffectCommit 0;
			_x ppEffectEnable true;
			_x ppEffectForceInNVG true;
		} forEach [FAR_eff_ppVig, FAR_eff_ppBlur];
		
		[100] call BIS_fnc_bloodEffect;
	};
	
	// Announce Message.
	[_unit, _killer, ["killed", "injured"] select FAR_var_InstantDeath] spawn FAR_fnc_DeathMessage;
	
	private _bPool = createSimpleObject [selectRandom ["BloodSpray_01_New_F","BloodSplatter_01_Medium_New_F"], getPosWorld _unit]; 
	_bPool setDir random 360; 
	_bPool setVectorUp surfaceNormal getPosWorld _unit;
    
	if (isPlayer _unit) then {
		titleText ["", "BLACK IN", 1];
		
		if (FAR_var_BleedOut > 600) then {
			["Initialize", [_unit, [playerSide], false, false]] call BIS_fnc_EGSpectator;
		};
	};
		
	_bleedOut = time + FAR_var_BleedOut;
	
	// Deduct 1m from bleed-out timer.
	if (FAR_var_BleedOut > 60 && FAR_var_BleedOut <= 600) then { FAR_var_BleedOut = FAR_var_BleedOut - 60 };
	
	private _tick = 0;
	
	while { alive _unit && 
			(lifeState _unit == "INCAPACITATED") &&
			!(_unit getVariable ["FAR_var_isStable",false]) && 
			(FAR_var_BleedOut < 0 || time < _bleedOut) 
	} do {
		if (isPlayer _unit) then  {
			if (FAR_var_BleedOut > 600) then {
				hintSilent format["Waiting for a medic\n\n%1", call FAR_fnc_CheckFriendlies];
			} else { 
				hintSilent format["Bleedout in %1 seconds\n\n%2", round (_bleedOut - time), call FAR_fnc_CheckFriendlies];
			};
		};
			
		// Bleeding and sounds
		if (_tick % ((round random 5) + 5) == 0) then { if (isPlayer _unit) then { [100] call BIS_fnc_bloodEffect}; };
		if (_tick % ((round random 15) + 15) == 0) then {  
			_scream = selectRandom [
				["Person0", ["P0_moan_13_words.wss", "P0_moan_14_words.wss", "P0_moan_15_words.wss", "P0_moan_16_words.wss", "P0_moan_17_words.wss", "P0_moan_18_words.wss", "P0_moan_19_words.wss", "P0_moan_20_words.wss"]],
				["Person1", ["P1_moan_19_words.wss", "P1_moan_20_words.wss", "P1_moan_21_words.wss", "P1_moan_22_words.wss","P1_moan_23_words.wss", "P1_moan_24_words.wss", "P1_moan_25_words.wss", "P1_moan_26_words.wss","P1_moan_27_words.wss", "P1_moan_28_words.wss", "P1_moan_29_words.wss", "P1_moan_30_words.wss","P1_moan_31_words.wss", "P1_moan_32_words.wss", "P1_moan_33_words.wss"]],
				["Person2", ["P2_moan_14_words.wss", "P2_moan_15_words.wss", "P2_moan_16_words.wss", "P2_moan_17_words.wss","P2_moan_18_words.wss", "P2_moan_19_words.wss", "P2_moan_20_words.wss", "P2_moan_21_words.wss"]],
				["Person3", ["P3_moan_10_words.wss", "P3_moan_11_words.wss", "P3_moan_12_words.wss", "P3_moan_13_words.wss","P3_moan_14_words.wss", "P3_moan_15_words.wss", "P3_moan_16_words.wss", "P3_moan_17_words.wss","P3_moan_18_words.wss", "P3_moan_19_words.wss", "P3_moan_20_words.wss"]]
			];
			
			playSound3D [format["a3\sounds_f\characters\human-sfx\%1\%2", _scream select 0, selectRandom (_scream select 1)], _unit, false, getPosASL _unit, 1.5, 1, 50];	
		};
		
		// Handle stuck dragging player D/C
		if ((_unit getVariable ["FAR_var_isDragged", false]) &&
			!isNull (attachedTo _unit) &&
			!alive (attachedTo _unit)
		) then {
			detach _unit;
			[_unit, "UnconsciousReviveDefault"] remoteExec ["switchMove"];
			_unit setVariable ["FAR_var_isDragged", false, true];
		};
		
		// Check unit is in correct animation.
		if ((animationState _unit) select [0,3] != "unc" && 
			!(_unit getVariable ["FAR_var_isDragged", false]) &&
			isNull (attachedTo _unit)
		) then {
			systemChat format["[DEBUG] animationState incorrect - Report this issue!", animationState _unit];
			diag_log text format["[DEBUG] animationState was incorrect: %1", animationState _unit];
			[_unit, "UnconsciousReviveDefault"] remoteExec ["switchMove"];
		};
		
		_tick = _tick + 0.5;
		sleep 0.5;
	};
	
	//Unit has been stabilized. Disregard bleedout timer.
	if (_unit getVariable ["FAR_var_isStable",false]) then {
		while { 
			alive _unit && lifeState _unit == "INCAPACITATED"
		} do {
			if (isPlayer _unit) then  {		
				hintSilent format["You have been stabilized\n\n%1", call FAR_fnc_CheckFriendlies];	
			};
			// Handle stuck dragging player D/C
			if ((_unit getVariable ["FAR_var_isDragged", false]) &&
				!isNull (attachedTo _unit) &&
				!alive (attachedTo _unit)
			) then { 
				detach _unit;
				[_unit, "UnconsciousReviveDefault"] remoteExec ["switchMove"];
				_unit setVariable ["FAR_var_isDragged", false, true];
			};
			
			sleep 0.5;
		};
	};
	
	// Disable effects if set.
	{ _x ppEffectEnable false } forEach [FAR_eff_ppVig, FAR_eff_ppBlur];
	
	// Bled out
	if (FAR_var_BleedOut > 0 && 
			{time > _bleedOut} && 
			(lifeState _unit == "INCAPACITATED") &&
			!(_unit getVariable ["FAR_var_isStable",false])
	) then {
		// Kill player, stop the camera.
		["Terminate"] call BIS_fnc_EGSpectator;
		_unit setCaptive false;
		_unit allowDamage true;
		_unit setDamage 1;
	} else {	
		// Player got revived		
		["Terminate"] call BIS_fnc_EGSpectator;
		sleep 3;
		
		// Clear the "medic nearby" hint
		hintSilent "";
		_unit setDamage 0;
		_unit allowDamage true;
		_unit setCaptive false;
		_unit setUnconscious false;
		_unit playAction "Stop";
		
		if ((primaryWeapon _unit == "" && secondaryWeapon _unit == "") || currentWeapon _unit == binocular _unit) then { 
			_unit playAction "Civil"
		} else {
			_unit action ["SwitchWeapon", _unit, _unit, 0]
		};
		
		//sleep 3; 
		//[_unit,animationState _unit] remoteExec ["switchMove"];
	};
	
	// Reset variables
	_unit setVariable ["FAR_var_isStable", false, true];
	_unit setVariable ["FAR_var_isDragged", false, true];
};

FAR_fnc_CheckRevive = {
	private _caller = _originalTarget;
	private _cursorTarget = cursorTarget; // Can't be passed in addAction arguments!

	if (isNull _cursorTarget) exitWith { false };
	
	// Variable for CASVAC Missions etc...
	if !(_cursorTarget getVariable ["FAR_var_AllowRevive", true]) exitWith {};
		
	if (!(_caller getVariable ["FAR_var_isDragging", false]) && 
		_cursorTarget in (playableUnits + switchableUnits) && 
		!([side group _cursorTarget, side group _caller] call BIS_fnc_sideIsEnemy) && 
		((_caller getUnitTrait "Medic" && FAR_var_ReviveMode == 0) || ('FirstAidKit' in (items _caller) && FAR_var_ReviveMode == 1) || ('Medikit' in (items _caller) && FAR_var_ReviveMode == 2) || ('Medikit' in (items _cursorTarget) && FAR_var_ReviveMode == 2)) &&
		{lifeState _cursorTarget == 'INCAPACITATED'})
	exitWith { 
		_caller setUserActionText [FAR_act_Revive , format["<t color='#FF0000'>Revive<img image='%2'/>(%1)</t>", name _cursorTarget, (getText (configFile >> "CfgVehicles" >> (typeOf _cursorTarget) >> "icon") call bis_fnc_textureVehicleIcon)], "<img size='3' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa'/>"];
		true
	};

	false
};

FAR_fnc_Revive = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	private _cursorTarget = cursorTarget; // Can't be passed in addAction arguments!
	
	if !([_caller] call FAR_fnc_isUnderwater) then {
		_caller playMove format["AinvP%1MstpSlayW%2Dnon_medicOther", ["knl","pne"] select (stance _caller == "PRONE"), [["rfl","pst"] select (currentWeapon _caller isEqualTo handgunWeapon _caller), "non"] select (currentWeapon _caller isEqualTo "")];
	};
	_cursorTarget setVariable ["FAR_var_isDragged", false, true]; 
			
	sleep 4;
			
	if (lifeState _cursorTarget == "INCAPACITATED") then {
		private _simpleObj = createSimpleObject [selectRandom [ "MedicalGarbage_01_1x1_v1_F", "MedicalGarbage_01_1x1_v2_F", "MedicalGarbage_01_1x1_v3_F" ], getPosWorld _caller];
		_simpleObj setDir random 360;
		_simpleObj setVectorUp surfaceNormal getPosWorld _caller;
		
		if !("Medikit" in (items _caller)) then { _caller removeItem "FirstAidKit" };
		
		[_cursorTarget, false] remoteExec ["setUnconscious", _cursorTarget];
		sleep 1;
		[[format["You were revived by %1",name _caller],"PLAIN DOWN", 2]] remoteExec ["TitleText", _cursorTarget];
	};
};

FAR_fnc_CheckStabilize = {
	private _caller = _originalTarget;
	private _cursorTarget = cursorTarget; // Can't be passed in addAction arguments!
	
	if (isNull _cursorTarget) exitWith { false };
	
	if (!(_caller getVariable ["FAR_var_isDragging", false]) && 
		_cursorTarget in (playableUnits + switchableUnits) && 
		!([side group _cursorTarget, side group _caller] call BIS_fnc_sideIsEnemy) && 
		!( _cursorTarget getVariable ["FAR_var_isDragged",false]) && 
		!(_cursorTarget getVariable ['FAR_var_isStable',false]) && 
		('FirstAidKit' in (items _caller) || 'Medikit' in (items _caller) || 'FirstAidKit' in (items _cursorTarget)) &&
		{lifeState _cursorTarget == 'INCAPACITATED'}) 
	exitWith { 
		
		_caller setUserActionText [FAR_act_Stabilise, format["<t color='#FF0000'>Stabilize<img image='%2'/>(%1)</t>", name _cursorTarget, (getText (configFile >> "CfgVehicles" >> (typeOf _cursorTarget) >> "icon") call bis_fnc_textureVehicleIcon)], "<img size='3' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa'/>"];
		true };
	
	false
};

FAR_fnc_Stabilize = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	private _cursorTarget = cursorTarget; // Can't be passed in addAction arguments!
	
	if !([_caller] call FAR_fnc_isUnderwater) then {
		_caller playMove format["AinvP%1MstpSlayW%2Dnon_medicOther", ["knl","pne"] select (stance _caller == "PRONE"), [["rfl","pst"] select (currentWeapon _caller isEqualTo handgunWeapon _caller), "non"] select (currentWeapon _caller isEqualTo "")];
	};
	playSound3D [
		selectRandom ["a3\sounds_f\characters\ingame\AinvPknlMstpSlayWpstDnon_medic.wss","a3\sounds_f\characters\ingame\AinvPknlMstpSlayWrflDnon_medic.wss","a3\sounds_f\characters\ingame\AinvPpneMstpSlayWpstDnon_medic.wss","a3\sounds_f\characters\ingame\AinvPpneMstpSlayWrflDnon_medic.wss"],
		objNull,
		false,
		getPos _caller,
		1,
		1,
		50
	];
		
	if (lifeState _cursorTarget == "INCAPACITATED" && !(_cursorTarget getVariable ["FAR_var_isStable",false])) then {
		private _simpleObj = createSimpleObject ["MedicalGarbage_01_FirstAidKit_F", getPosWorld _caller];
		_simpleObj setDir random 360;
		_simpleObj setVectorUp surfaceNormal getPosWorld _caller;
		
		if !("Medikit" in (items _caller)) then {
			if !("FirstAidKit" in (items _caller)) then {
				_cursorTarget removeItem "FirstAidKit";
				[[format["%1 used a FAK from your inventory to stabilise you",name _caller],"PLAIN DOWN", 2]] remoteExec ["TitleText", _cursorTarget];
			} else {
				_caller removeItem "FirstAidKit";
			};
		};
		
		_cursorTarget setVariable ["FAR_var_isStable", true, true];
	};
};

FAR_fnc_CheckDragging = {
	private _caller = _originalTarget;
	private _cursorTarget = cursorTarget; // Can't be passed in addAction arguments!
	
	if (isNull _cursorTarget) exitWith { false };

	if (!(_caller getVariable ["FAR_var_isDragging", false]) && 
		!( _cursorTarget getVariable ["FAR_var_isDragged",false]) && 
		!([_caller] call FAR_fnc_isUnderwater) &&
		!([_cursorTarget] call FAR_fnc_isUnderwater) &&
		{lifeState _cursorTarget == 'INCAPACITATED'}) 
	exitWith { 
		_caller setUserActionText [FAR_act_Dragging, format["<t color='#FF0000'>Drag<img image='%2'/>(%1)</t>",name _cursorTarget, (getText (configFile >> "CfgVehicles" >> (typeOf _cursorTarget) >> "icon") call bis_fnc_textureVehicleIcon)], "<img size='3' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa'/>"];
		true };
		
	false
};

FAR_fnc_CheckBag = {
	private _caller = _originalTarget;
	private _cursorTarget = cursorObject; // Can't be passed in addAction arguments!	
	
	if (isNull _cursorTarget) exitWith { false };
	
	if (!(_caller getVariable ["FAR_var_isDragging", false]) && 
		!([_caller] call FAR_fnc_isUnderwater) &&
		!(_caller nearObjects ["CAManBase", 2.5] select { lifeState _x in ['DEAD','DEAD-RESPAWN'] && !(isObjectHidden _x) } isEqualTo []) && 
		{"Medikit" in (items _caller)}) 
	exitWith { 
		_caller setUserActionText [FAR_act_Bag , format["<t color='#FF0000'>Bag Body%1</t>", if (name _cursorTarget != "Error: No unit") then { format[" (%1)", name _cursorTarget] } else {""}], "<img size='3' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa'/>"];
		true 
	};
	
	false
};

FAR_fnc_Bag = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	private _cursorTarget = cursorObject; // Can't be passed in addAction arguments!
	
	// Looking at weapons holder - Find the body.
	if !(lifeState _cursorTarget in ['DEAD','DEAD-RESPAWN']) then {
		_cursorTarget = (_caller nearObjects ["CAManBase", 2.5] select { lifeState _x in ['DEAD','DEAD-RESPAWN'] }) # 0;
	};
	
	// Exit if we lost the body!
	if !(_cursorTarget isKindOf "CAManBase") exitWith {};
	
	_caller playMove format["AinvP%1MstpSlayW%2Dnon_medicOther", ["knl","pne"] select (stance _caller == "PRONE"), [["rfl","pst"] select (currentWeapon _caller isEqualTo handgunWeapon _caller), "non"] select (currentWeapon _caller isEqualTo "")];

	private _simpleObj = createSimpleObject [switch (getNumber(configFile >> "CfgVehicles" >> typeOf _cursorTarget >> "side")) do { case 0: { "Land_Bodybag_01_black_F" }; case 1: { "Land_Bodybag_01_blue_F" }; default { "Land_Bodybag_01_white_F" } }, getPosWorld _cursorTarget];
	_simpleObj setDir getDir _cursorTarget;
	_simpleObj setVectorUp surfaceNormal getPosWorld _cursorTarget;

	if (FAR_var_RespawnBagTime > 0 && isPlayer _cursorTarget && !([side group _cursorTarget, side group _caller] call BIS_fnc_sideIsEnemy)) then {
		{ 
			if (!alive player && playerRespawnTime > FAR_var_RespawnBagTime) then { 
				setPlayerRespawnTime FAR_var_RespawnBagTime;
				[format["Respawn in %1 Minutes",round FAR_var_RespawnBagTime / 60], 0] call BIS_fnc_respawnCounter;
				titleText ["<t size='2'>Your dead body was recovered.<br/>","PLAIN DOWN", 2, true, true] 
			}
		} remoteExec ["BIS_fnc_spawn", _cursorTarget];
	};

	[_cursorTarget, true] remoteExec ["hideObjectGlobal", 2];
};

FAR_fnc_IsFriendlyMedic = {
	private _unit = _this;
				
	if ((_unit getUnitTrait "Medic" || (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant") == 1)) &&
		alive _unit && 
		(isPlayer _unit || !isMultiPlayer) && 
		side (group _unit) == playerSide && 
		!(lifeState _unit == "INCAPACITATED")
	) exitWith { true };
	
	false
};

FAR_fnc_CheckFriendlies = {
	private ["_unit", "_units", "_medics", "_hintMsg"];

	_units = (position player) nearEntities [["Man", "Air", "Car"], 300];
	//_units = nearestObjects [getPos player, ["Man", "Car", "Air", "Ship"], 300];
	_medics = [];
	_dist = 300;
	_hintMsg = "";
	
	// Find nearby friendly medics
	if (count _units > 1) then {
		{
			if (_x isKindOf "Car" || _x isKindOf "Air" || _x isKindOf "Ship") then {
				if (alive _x && count (crew _x) > 0) then {
					{
						if (_x call FAR_fnc_IsFriendlyMedic) then {
							_medics = _medics + [_x];
							
							if (true) exitWith {};
						};
					} forEach crew _x;
				};
			} else {
				if (_x call FAR_fnc_IsFriendlyMedic) then {
					_medics = _medics + [_x];
				};
			};
		} forEach _units;
	};
	
	// Sort medics by distance
	if (count _medics > 0) then {
		{
			if (player distance _x < _dist) then {
				_unit = _x;
				_dist = player distance _x;
			};
		
		} forEach _medics;
		
		if (!isNull _unit) then {
			_unitName	= name _unit;
			_distance	= floor (player distance _unit);
			
			_hintMsg = format["Nearby Medic:\n%1 is %2m away.", _unitName, _distance];
		};
	} else {
		_hintMsg = "No medics within 300m.";
	};
	
	_hintMsg
};

FAR_fnc_getMedicalVehicles = {
	_allUnits = [];
	_vehicles = [];
	
	// Get all units from allied groups.
	{
		if ((side _x getFriend side group player >= 0.6) && ({_x in playableUnits + switchableUnits} count units _x) > 0) then { _allUnits append units _x };
	} forEach allGroups;

	// Find nearby medical vehicles within 100m.
	{
		_veh = _x;
		if (_allUnits findIf { _x distance2D _veh < 50 } >= 0) then { _vehicles pushBackUnique _veh };
	} forEach (vehicles select { 
		locked _x < 2 && 
		fuel _x > 0 && 
		_x isKindOf "AllVehicles" &&
		getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> "attendant") == 1
	});
	
	_vehicles
};

FAR_fnc_TeleportNearestVehicle = {
	params ["_unit", ["_foundVehs",([] call FAR_fnc_getMedicalVehicles)]];
	
	[0, "BLACK", 3, 1] call BIS_fnc_fadeEffect;
	
	if !(isPlayer _unit) exitWith {};
	
	_target = objNull;
	
	{
		if (_unit distance2d _x < _unit distance2d _target) then { _target = _x };
	} forEach (((missionNamespace getVariable ["FAR_var_MedicalVehs",[]]) + _foundVehs) select { alive _x });
	
	if (isNull _target) exitWith {};
	
	sleep random 4;
	
	_result = _unit moveInCargo _target;
	
	if !_result then { _unit setVehiclePosition [_target, [], 5, "NONE"] };
	
	[1, "BLACK", 3, 1] call BIS_fnc_fadeEffect; 
};

FAR_fnc_AIHeal = {
	params [["_unit", player]];
	
	if (isNil "_unit") exitWith {};
	
	_units = (units _unit) select { lifeState _x in ["HEALTHY","INJURED"] && !isPlayer _x && ('Medikit' in (items _x))};

	// No nearby medics, so get any near units.
	if (count _units == 0) then {
		_friendSides = [side group _unit] call BIS_fnc_friendlySides;
		_units = (_unit nearEntities ["Man", 50]) select { side _x in _friendSides && lifeState _x in ["HEALTHY","INJURED"] && !isPlayer _x };
	};
	
	_ai = objNull;
	
	// Find the closest AI
	{
		if (_unit distance2D _x < _unit distance2D _ai) then { _ai = _x };
	} forEach _units;
	
	if (isNull _ai || _ai distance _unit > 150) exitWith {
		if (isPlayer _unit && local _unit) then {
			_drone = createVehicle ["C_IDAP_UAV_06_medical_F", _unit getPos [100, random 360], [], 0, "FLY"];		
			createVehicleCrew _drone;
			
			_drone setVariable ["var_target",_unit];
			_drone allowDamage false;
			_drone flyInHeight 20;
			
			[_unit, format["Medical UAV En-route to %1 (%2)", name _unit, mapGridPosition _unit]] remoteExec ["GroupChat", side group _unit];
			
			_wp = (group _drone) addWaypoint [_unit, 0];
			_wp setWaypointType "SCRIPTED";
			_wp setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
			_wp setWaypointStatements ["true", "
				_injured = (vehicle this) getVariable ['var_target',objNull];
				if (alive _injured) then {
					[_injured, format['Medical UAV located %1 (%2)', name _injured, mapGridPosition _injured]] remoteExec ['GroupChat', side group _injured];
					[_injured, false] remoteExec ['setUnconscious', _injured];
					_tempSmoke = SmokeShell' createVehicle _injured;
				};
				vehicle this flyInHeight 100;
			"];
					
			_wp = (group _drone) addWaypoint [_unit getPos [200, random 360], 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} forEach thisList; deleteGroup (group this);"];
		} else {
			[_unit, format["Man Down! No available units near %1", mapGridPosition _unit]] remoteExec ["SideChat", side group _unit];
		};
	};
	
	[[_ai, _unit], { 
		params ["_medic","_target"];
		
		//BIS_fnc_showSubtitle
		[_medic, format["Man down! Attending to %1 (%2m)", name _target, round (_medic distance2D _target)]] remoteExec ["GroupChat", side group _target];
		
		_medic allowDamage false;
		
		{ _medic disableAI _x } forEach ["AUTOCOMBAT", "AUTOTARGET", "TARGET", "SUPPRESSION"];
		
		if (_medic distance2D _target < 25) then { _medic setUnitPos "MIDDLE" };
		
		doStop _medic;
		waitUntil { sleep 1; _medic doMove (getPos _target); (_medic distance2D _target < 3 || lifeState _target != "INCAPACITATED"); };
		
		if (lifeState _target == "INCAPACITATED") then {
			_medic playMove format["AinvP%1MstpSlayW%2Dnon_medicOther", ["knl","pne"] select (stance _medic == "PRONE"), [["rfl","pst"] select (currentWeapon _medic isEqualTo handgunWeapon _medic), "non"] select (currentWeapon _medic isEqualTo "")];
			_medic lookAt _target;
			
			sleep 1;
			
			private _simpleObj = createSimpleObject [selectRandom [ "MedicalGarbage_01_1x1_v1_F", "MedicalGarbage_01_1x1_v2_F", "MedicalGarbage_01_1x1_v3_F" ], getPosWorld _medic];
			_simpleObj setDir random 360;
			_simpleObj setVectorUp surfaceNormal getPosWorld _medic;
			
			sleep 3;
			
			[_target, false] remoteExec ["setUnconscious", _target];
		};

		{ _medic enableAI _x } forEach ["AUTOCOMBAT", "AUTOTARGET", "TARGET", "SUPPRESSION"];
		
		_medic setUnitPos "AUTO";
		_medic allowDamage true;	
		//doStop _medic;
		_medic doFollow (leader group _medic);
	}] remoteExec ["BIS_fnc_spawn", _ai];	
};

FAR_fnc_isUnderwater = {
	params [["_man", objNull]];
	(((animationState _man) select [1, 3]) in ["bdv","bsw","dve","sdv","ssw","swm"])
};

FAR_fnc_CheckUnitCarry = {
	private _caller = _originalTarget;
	private _cursorTarget = cursorTarget;
	
	if (isNull _cursorTarget) exitWith { false };
	
	if ((_cursorTarget getVariable ["FAR_var_isStable", false]) &&
		!(_caller getVariable ["FAR_var_isDragging", false]) && 
		!( _cursorTarget getVariable ["FAR_var_isDragged", false]) && 
		!([_caller] call FAR_fnc_isUnderwater) &&
		!([_cursorTarget] call FAR_fnc_isUnderwater) &&
		{lifeState _cursorTarget == 'INCAPACITATED'}) 
	exitWith { 
		_caller setUserActionText [FAR_act_Carry , format["<t color='#FF0000'>Carry<img image='%2'/>(%1)</t>", name _cursorTarget, (getText (configFile >> "CfgVehicles" >> (typeOf _cursorTarget) >> "icon") call bis_fnc_textureVehicleIcon)], "<img size='3' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa'/>"];
		true
	};
		
	false
};

FAR_fnc_CheckUnitLoad = { 
	private _caller = _originalTarget;
	private _cursorTarget = if (_caller getVariable ["FAR_var_isDragging", false]) then {(attachedObjects _caller) # 0} else { cursorTarget };
	private _nearVehs = (nearestObjects [_caller, ["Car", "Air", "Tank", "Ship_F"], 8]) select { locked _x < 2 && _x emptyPositions "cargo" > 0 };

	if (_nearVehs isEqualTo [] || isNil "_cursorTarget" || isNull _cursorTarget) exitWith {};
	
	_veh = _nearVehs # 0;
	
	if (vehicle _caller == _caller &&
		(_cursorTarget getVariable ["FAR_var_isStable", false]) &&
		(lifeState _caller in ["HEALTHY","INJURED"]) &&
		{lifeState _cursorTarget == 'INCAPACITATED'})
	exitWith { 
		_caller setUserActionText [FAR_act_UnitLoad , format["<t color='#FF0000'>Load<img image='%3'/>(%1) [%2]</t>", name _cursorTarget, getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName"), (getText (configFile >> "CfgVehicles" >> (typeOf _cursorTarget) >> "icon") call bis_fnc_textureVehicleIcon)], "<img size='3' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa'/>"];
		true
	};
	
	false
};

FAR_fnc_UnitLoad = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	private _cursorTarget = if (_caller getVariable ["FAR_var_isDragging", false]) then {(attachedObjects _caller) # 0} else { cursorTarget };
	private _nearVehs = (nearestObjects [_cursorTarget, ["Car", "Air", "Tank", "Ship_F"], 15]) select { locked _x < 2 && _x emptyPositions "cargo" > 0 };
	
	if (_nearVehs isEqualTo [] || isNil "_cursorTarget" || isNull _cursorTarget) exitWith {};
	
	_veh = _nearVehs # 0;
	
	[[format["Loaded %1 into %2 (%3m)", name _cursorTarget, getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName"), round (_cursorTarget distance _veh)], "PLAIN DOWN", 2]] remoteExec ["TitleText", [_caller, _cursorTarget]];
	
	[_cursorTarget, _veh] remoteExec ["moveInCargo",_cursorTarget];	
	
	_cursorTarget setVariable ["FAR_var_isDragged", false, true];
	
	[_cursorTarget, "Unconscious"] remoteExec ["playActionNow", _cursorTarget];
};

FAR_fnc_UnitMove = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	
	_arguments params [["_type","drag"]];
		
	private _cursorTarget = cursorTarget;
		
	_caller selectWeapon primaryWeapon _caller;	
	_caller setVariable ["FAR_var_isDragging", true, false];
	
	_cursorTarget setVariable ["FAR_var_isDragged", true, true];
	
	_animList = ["acinpercmstpsnonwnondnon", "acinpknlmstpsraswrfldnon", "acinpknlmstpsnonwpstdnon", "acinpknlmstpsnonwnondnon", "acinpknlmwlksraswrfldb", "acinpknlmwlksnonwnondb"];
	
	if (_type == "drag") then {
		[_caller, "grabDrag"] remoteExec ["playActionNow", _caller];
		
		_cursorTarget attachTo [_caller, [0, 1.1, 0.092]];
		[_cursorTarget,180] remoteExec ["setDir",_cursorTarget];
		
		[_cursorTarget, "AinjPpneMrunSnonWnonDb_still"] remoteExec ["switchMove"];
	} else {
		[_caller, "AcinPknlMstpSnonWnonDnon_AcinPercMrunSnonWnonDnon"] remoteExec ["switchMove"];
		_caller forceWalk true;
		
		_caller setDir (getDir _cursorTarget + 180);
		_caller setPosASL (getPosASL _cursorTarget vectorAdd (vectorDir _cursorTarget));

		[_cursorTarget, "AinjPfalMstpSnonWrflDnon_carried_Up"] remoteExec ["switchMove"];
	};
	
	_time = time + 14;
	waitUntil { sleep 0.5; (!(lifeState _caller in ["HEALTHY","INJURED"]) || time > _time || (((animationState _caller) select [1, 3]) != "cin" && ((animationState _caller) select [26, 3]) != "cin") || animationState _caller in _animList) };
	
	// Unit was injured before completing animation so exit
	if ((!(lifeState _caller in ["HEALTHY","INJURED"])) || lifeState _cursorTarget != "INCAPACITATED" || (((animationState _caller) select [1, 3]) != "cin" && ((animationState _caller) select [26, 3]) != "cin")) exitWith {
		detach _cursorTarget;
		if (lifeState _caller in ["HEALTHY","INJURED"]) then { [_caller, ""] remoteExec ["switchMove"]; };
		[_cursorTarget, "UnconsciousReviveDefault"] remoteExec ["switchMove"];
		_cursorTarget setVariable ["FAR_var_isDragged", false, true];
		_caller setVariable ["FAR_var_isDragging", false, false];
		_caller forceWalk false;
	};

	if (_type != "drag") then { 
		[_cursorTarget, "AinjPfalMstpSnonWnonDf_carried_dead"] remoteExec ["switchMove"];
		_cursorTarget attachTo [_caller, [0.4, -0.1, -1.25], "LeftShoulder"];
		[_cursorTarget, 180] remoteExec ["setDir", _cursorTarget];
	};
			
	// Add release action for carrier
	FAR_act_Release = _caller addAction ["Release", {
		params ["_target", "_caller", "_actionId", "_arguments"];
		_injured = (attachedObjects _caller) select { _x getVariable ["FAR_var_isDragged", false] };		
		_caller setVariable ["FAR_var_isDragging", false, false];
		if (count _injured > 0) then { [(_injured#0), "UnconsciousReviveDefault"] remoteExec ["switchMove"] };
		[_caller, ""] remoteExec ["switchMove"];
		_caller removeAction _actionId;
	}, [], 10, true, true, "", "true"];
	
	_caller setUserActionText [FAR_act_Release, format["<t color='#FF0000'>Drop<img image='%2'/>(%1)</t>", name _cursorTarget, (getText (configFile >> "CfgVehicles" >> (typeOf _cursorTarget) >> "icon") call bis_fnc_textureVehicleIcon)], "<img size='3' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa'/>"];
		
	// Wait until anim changes
	waitUntil { 
		sleep 0.5;
		(((animationState _caller) select [1, 3]) != "cin" && ((animationState _caller) select [26, 3]) != "cin") ||
		_caller distance _cursorTarget > 5 ||
		!(lifeState _caller in ["HEALTHY","INJURED"]) ||
		!(lifeState _cursorTarget == "INCAPACITATED") ||
		!(_caller getVariable ["FAR_var_isDragging", false]) ||
		!(_cursorTarget getVariable ["FAR_var_isDragged",false])
	};
	
	detach _cursorTarget;
	
	_caller forceWalk false;

	// Target was dropped by other means, so cancel the dragging animation
	if (_caller getVariable ["FAR_var_isDragging", false]) then {
		if (lifeState _caller in ["HEALTHY","INJURED"]) then { [_caller,""] remoteExec ["switchMove"] };
		if (vehicle _cursorTarget == _cursorTarget && alive _cursorTarget) then { [_cursorTarget, "UnconsciousReviveDefault"] remoteExec ["switchMove"] };
	};

	_cursorTarget setVariable ["FAR_var_isDragged", false, true];
	
	_caller setVariable ["FAR_var_isDragging", false, false];
	_caller removeAction FAR_act_Release;
};