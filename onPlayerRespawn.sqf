params ["_newUnit","_oldUnit","_respawn","_respawnDelay"];
if (isNull _oldUnit) exitWith {};

// Disable Spectator
[false] call f_fnc_spectateInit;

// Assign the unit their gear. or gear from death
if (_oldUnit getVariable ["f_var_assignGear",""] != "") then {
	[(_oldUnit getVariable ["f_var_assignGear",""]),_newUnit] call f_fnc_assignGear;
} else {
	[_newUnit, [missionNamespace, "f_var_savedGear"]] call BIS_fnc_loadInventory;
};

// Rejoin group if we're not in it
if (group _newUnit != missionNamespace getVariable ["f_var_lastGroup", group _newUnit]) then { [_newUnit] joinSilent f_var_lastGroup; _newUnit assignTeam (_oldUnit getVariable ["ST_STHud_assignedTeam","MAIN"]) };

// Migrate Zeus Curator
if (!isNull (getAssignedCuratorLogic _oldUnit)) then {
	_curator = getAssignedCuratorLogic _oldUnit;
	unassignCurator _curator;
	_newUnit assignCurator _curator;
};