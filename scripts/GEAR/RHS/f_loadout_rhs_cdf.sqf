// F3 - Folk ARPS Assign Gear Script - CSAT
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// GENERAL EQUIPMENT USED BY MULTIPLE CLASSES
// ATTACHMENTS - PRIMARY
_attach1 = ["rhs_acc_2dpZenit","rhs_acc_perst1ik"];
_attach2 = "";

_flashHider = "rhs_acc_dtk1";
_silencer1 = "rhs_acc_dtk4short"; // INF suppressor
_silencer2 = "rhs_acc_tgpv"; // SNP suppressor

_scope1 = ["rhs_acc_pkas","rhs_acc_1p63","rhs_acc_ekp1"]; // CQB
_scope2 = ["rhs_acc_pkas","rhs_acc_1p29","rhs_acc_1p78"]; // MED
_scope3 = "rhs_acc_pso1m2"; // DMR
_scope4 = "rhs_acc_pso1m2"; // SNP

_bipod1 = "rhs_bipod"; // Bipod

// Default setup
_attachments = [_flashHider,_attach1,_scope1]; // The default attachment set for most units, overwritten in the individual unitType

// Predefined Class Attachment Setup
_attach_co = [_flashHider,_scope2,_attach1];
_attach_dc = [_flashHider,_scope2,_attach1]; // Also SL!
_attach_fl = [_flashHider,_scope2,_attach1];
_attach_mg = [_scope2,_bipod1];
_attach_dm = [_scope4,_bipod1];
_attach_sn = [_scope4,_bipod1];

// [] = remove all
// [_attach1,_scope1,_silencer] = remove all, add items assigned in _attach1, _scope1 and _silencer1
// [_scope2] = add _scope2, remove rest
// false = keep attachments as they are

// ====================================================================================

// ATTACHMENTS - HANDGUN
_hg_silencer1 = "muzzle_snds_L";	// 9mm suppressor

_hg_scope1 = "optic_MRD";			// MRD

// Default setup
_hg_attachments= []; // The default attachment set for handguns, overwritten in the individual unitType

// ====================================================================================

// WEAPON SELECTION

// Basic magazine counts given to most infantry, MMG etc get _defMags_tr as default count.
_defMags = 4;
_defMags_tr = 3;

// Standard Riflemen ( MMG Assistant Gunner, Assistant Automatic Rifleman, MAT Assistant Gunner, MTR Assistant Gunner, Rifleman)
_rifle = ["rhs_weap_m70ab2","rhs_weap_m70b1","rhs_weap_m70ab2_fold"];
_riflemag = "rhs_30Rnd_762x39mm";
_riflemag_tr = "rhs_30Rnd_762x39mm_tracer";

// Standard Carabineer (Medic, Rifleman (AT), MAT Gunner, MTR Gunner, Carabineer)
_carbine = ["rhs_weap_m92","rhs_weap_m92_fold"];
_carbinemag = "rhs_30Rnd_762x39mm";
_carbinemag_tr = "rhs_30Rnd_762x39mm_tracer";

// Standard Submachine Gun/Personal Defence Weapon (Aircraft Pilot, Submachinegunner)
_smg = ["rhs_weap_m92","rhs_weap_m92_fold"];
_smgmag = "rhs_30Rnd_762x39mm";
_smgmag_tr = "rhs_30Rnd_762x39mm_tracer";

// Diver
_diverWep = "arifle_SDAR_F";
_diverMag1 = "30Rnd_556x45_Stanag";
_diverMag2 = "20Rnd_556x45_UW_mag";

// Rifle with GL and HE grenades (CO, DC, FTLs)
_glrifle = ["rhs_weap_akm_gp25","rhs_weap_akms_gp25"];
_glriflemag = "rhs_30Rnd_762x39mm";
_glriflemag_tr = "rhs_30Rnd_762x39mm_tracer";
_glmag = "rhs_VOG25P";

// Smoke for FTLs, Squad Leaders, etc
_glsmoke = "rhs_GRD40_White";
_glsmokealt1 = "rhs_GRD40_Green";
_glsmokealt2 = "rhs_GRD40_Red";

// Flares for FTLs, Squad Leaders, etc
_glflare = "rhs_VG40OP_white";
_glflarealt = "rhs_VG40OP_red";

// Pistols (CO, DC, Automatic Rifleman, Medium MG Gunner)
_pistol = "rhs_weap_pya";
_pistolmag = "rhs_mag_9x19_17";

// Grenades
_grenade = "rhs_mag_rgd5";
_grenadealt = "MiniGrenade";
_smokegrenade = "rhs_mag_rdg2_white";
_smokegrenadealt = "rhs_mag_rdg2_white";

// misc medical items.
_firstaid = "FirstAidKit";
_medkit = "Medikit";

// Binoculars
_binos1 = "Binocular";
_binos2 = ["Rangefinder","ACE_Yardage450"];

// Night Vision Goggles (NVGoggles)
_nvg = "ACE_NVG_Wide";

// UAV Terminal
_uavterminal = "I_UavTerminal";

// Chemlights
_chem =  "rhs_mag_nspn_red";
_chemalt = "rhs_mag_nspn_green";

// Backpacks
_bagsmall = "B_AssaultPack_khk";			// carries 120, weighs 20
_bagmedium = "B_Kitbag_sgg";				// carries 200, weighs 30
_baglarge =  "B_Carryall_cbr";				// carries 320, weighs 40
_bagmediumdiver =  "B_AssaultPack_blk";		// used by divers
_baguav = "I_UAV_01_backpack_F";			// used by UAV operator
_baghmgg = "I_HMG_01_weapon_F";				// used by Heavy MG gunner
_baghmgag = "I_HMG_01_support_F";			// used by Heavy MG assistant gunner
_baghatg = "I_AT_01_weapon_F";				// used by Heavy AT gunner
_baghatag = "I_HMG_01_support_F";			// used by Heavy AT assistant gunner
_bagmtrg = "I_Mortar_01_weapon_F";			// used by Mortar gunner
_bagmtrag = "I_Mortar_01_support_F";		// used by Mortar assistant gunner
_baghsamg = "I_AA_01_weapon_F";				// used by Heavy SAM gunner
_baghsamag = "I_HMG_01_support_F";			// used by Heavy SAM assistant gunner

// ====================================================================================

// UNIQUE, ROLE-SPECIFIC EQUIPMENT

// Automatic Rifleman
_AR = "rhs_weap_pkm";
_ARmag = "rhs_100Rnd_762x54mmR";
_ARmag_tr = "rhs_100Rnd_762x54mmR_green";

// Medium MG
_MMG = ["rhs_weap_pkp","rhs_weap_pkm"];
_MMGmag = "rhs_100Rnd_762x54mmR";
_MMGmag_tr = "rhs_100Rnd_762x54mmR_green";

// Marksman rifle
_DMrifle = ["rhs_weap_m76","rhs_weap_m38","rhs_weap_kar98k"];
_DMriflemag = "rhsgref_10Rnd_792x57_m76";

// Rifleman AT
_RAT = ["rhs_weap_rpg26","rhs_weap_rshg2"];
//_RATmag = "rhs_rpg26_mag";

// Medium AT
_MAT = "rhs_weap_rpg7_pgo";
_MATmag1 = "rhs_rpg7_PG7VR_mag";
_MATmag2 = "rhs_rpg7_OG7V_mag";

// Surface Air
_SAM = "rhs_weap_igla";
_SAMmag = "rhs_mag_9k38_rocket";

// Heavy AT
_HAT = "rhs_weap_rpg7_pgo";
_HATmag1 = "rhs_rpg7_PG7VR_mag";
_HATmag2 = "rhs_rpg7_OG7V_mag";

// Sniper
_SNrifle = ["rhs_weap_svdp","rhs_weap_svdp_wd","rhs_weap_m76"];
_SNrifleMag = "rhs_10Rnd_762x54mmR_7N1";

// Engineer items
_ATmine = "rhs_mine_tm62m_mag";
_satchel = "DemoCharge_Remote_Mag";
_APmine1 = "rhs_mine_pmn2_mag";
_APmine2 = "rhs_mine_pmn2_mag";

// ====================================================================================

// FACE, CLOTHES AND UNIFORMS

// Define classes. This defines which gear class gets which uniform
// "medium" vests are used for all classes if they are not assigned a specific uniform

_light = [];
_heavy =  ["eng","engm"];
_diver = ["div"];
_pilot = ["pp","pcc","pc"];
_crew = ["vc","vg","vd"];
_ghillie = [];
_specOp = [];

// Basic clothing
// The outfit-piece is randomly selected from the array for each unit

// Woodland-Hex
_baseUniform = ["rhsgref_uniform_ttsko_mountain"];
_baseHelmet = ["rhsgref_6b27m_ttsko_mountain"];
_baseGlasses = ["G_Bandanna_oli","G_Bandanna_blk","G_Balaclava_blk",""];

// Urban
//_baseUniform = ["U_O_CombatUniform_oucamo"];
//_baseHelmet = ["H_HelmetO_oucamo"];

// Vests
_lightRig = ["rhsgref_6b23_ttsko_mountain_nco"];
_mediumRig = ["rhsgref_6b23_khaki_rifleman"]; 	// default for all infantry classes
_heavyRig = ["rhsgref_6b23_khaki"];

// Diver
_diverUniform =  ["U_O_Wetsuit"];
_diverHelmet = [];
_diverRig = ["V_RebreatherIR"];
_diverGlasses = ["G_Diving"];

// Pilot
_pilotUniform = ["rhsgref_uniform_ttsko_mountain"];
_pilotHelmet = ["rhs_zsh7a_mike"];
_pilotRig = ["rhs_6b23_digi"];
_pilotGlasses = [];

// Crewman
_crewUniform = ["rhsgref_uniform_ttsko_mountain"];
_crewHelmet = ["tb_alfr_headset_01"];
_crewRig = ["V_Chestrig_oli"];
_crewGlasses = [];

// Ghillie
_ghillieUniform = ["rhsgref_uniform_ttsko_mountain"]; //DLC alternatives: ["U_O_FullGhillie_lsh","U_O_FullGhillie_ard","U_O_FullGhillie_sard"];
_ghillieHelmet = ["rhsgref_fieldcap_ttsko_mountain"];
_ghillieRig = ["rhsgref_6b23_khaki_sniper"];
_ghillieGlasses = [];

// Spec Op
_sfuniform = ["rhsgref_uniform_ttsko_mountain"];
_sfhelmet = ["rhsgref_6b27m_ttsko_mountain"];
_sfRig = ["rhs_6sh46"];
_sfGlasses = [];

// ====================================================================================

// This block needs only to be run on an infantry unit
if (_isMan) then {

		// PREPARE UNIT FOR GEAR ADDITION
	// The following code removes all existing weapons, items, magazines and backpacks

	removeAllWeapons _unit;
	removeAllItemsWithMagazines _unit;
	removeAllAssignedItems _unit;
	removeBackpack _unit;

	// ====================================================================================

	// HANDLE CLOTHES
	// Handle clothes and helmets and such using the include file called next.

	#include "..\..\f\assignGear\f_assignGear_clothes.sqf";

	// ====================================================================================

	// ADD UNIVERSAL ITEMS
	// Add items universal to all units of this faction

	_unit linkItem _nvg;
	_unit addItem _firstaid;		// Add a single first aid kit (FAK)
	_unit linkItem "ItemMap";		// Add and equip the map
	_unit linkItem "ItemCompass";	// Add and equip a compass
	_unit linkItem "ItemRadio";		// Add and equip A3's default radio
	_unit linkItem "ItemWatch";		// Add and equip a watch
	_unit linkItem "ItemGPS"; 		// Add and equip a GPS
		
	_unit addItem "ACE_IR_Strobe_Item"; 	// Add IR Strobe
	_unit addItem "ACE_Flashlight_KSF1"; 	// Add ACE Flash lights
	//_unit addItem "ACE_MapTools";		// Add Map Tools
};
// ====================================================================================

// SETUP BACKPACKS
// Include the correct backpack file for the faction

_backpack = {
	_typeofBackPack = _this select 0;
	switch (_typeofBackPack) do
	{
		#include "f_backpack.sqf";
	};
};

// ====================================================================================

// DEFINE UNIT TYPE LOADOUTS
// The following blocks of code define loadouts for each type of unit (the unit type
// is passed to the script in the first variable)

switch (_typeofUnit) do
{

	// LOADOUT: COMMANDER
	case "co":
	{
		_unit addHeadGear "rhsgref_fieldcap_ttsko_mountain";
		["g"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,3];
		_unit addMagazines [_glsmoke,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_smokegrenadealt,2];
		[_unit, _binos2] call f_fnc_addWeapon;
		_unit linkItem "ItemGPS";
		_attachments = _attach_co;		_unit addMagazines [_chem,2];
	};

	// LOADOUT: DEPUTY COMMANDER AND SQUAD LEADER
	case "dc":
	{
		_unit addHeadGear "rhsgref_fieldcap_ttsko_mountain";
		["g"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,3];
		_unit addMagazines [_glsmoke,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_smokegrenadealt,2];
		[_unit, _binos2] call f_fnc_addWeapon;
		_attachments = _attach_dc;		_unit addMagazines [_chem,2];
	};

	// LOADOUT: MEDIC
	case "m":
	{
		[_typeofUnit] call _backpack;
		_unit setUnitTrait ["medic",1];
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenadealt,4];
		{_unit addItem _firstaid} forEach [1,2,3,4];
	};

	// LOADOUT: FIRE TEAM LEADER
	case "ftl":
	{
		["g"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,3];
		_unit addMagazines [_glsmoke,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_smokegrenadealt,2];
		[_unit, _binos2] call f_fnc_addWeapon;
		_unit linkItem "ItemGPS";
		_attachments = _attach_fl;
	};


	// LOADOUT: AUTOMATIC RIFLEMAN
	case "ar":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_ARmag,_defMags_tr];
		_unit addMagazines [_ARmag_tr,1];
		[_unit, _AR] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_pistolmag,2];
		[_unit, _pistol] call f_fnc_addWeapon;
		_attachments = _attach_mg;
	};

	// LOADOUT: ASSISTANT AUTOMATIC RIFLEMAN
	case "aar":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_riflemag,_defMags];
		_unit addMagazines [_riflemag_tr,_defMags_tr];
		[_unit, _rifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
		[_unit, _binos1] call f_fnc_addWeapon;
	};

	// LOADOUT: RIFLEMAN (AT)
	case "rat":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
		[_unit, _RAT] call f_fnc_addWeapon;
	};

	// LOADOUT: DESIGNATED MARKSMAN
	case "dm":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_DMriflemag,_defMags];
		[_unit, _DMrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,2];
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_pistolmag,2];
		[_unit, _pistol] call f_fnc_addWeapon;
		_attachments = _attach_dm;
	};

	// LOADOUT: MEDIUM MG GUNNER
	case "mmgg":
	{
		["rpg"] call _backpack;
		_unit addMagazines [_MMGmag,_defMags_tr];
		_unit addMagazines [_MMGmag_tr,1];
		[_unit, _MMG] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_pistolmag,3];
		[_unit, _pistol] call f_fnc_addWeapon;
		_attachments = _attach_mg;
	};

	// LOADOUT: MEDIUM MG ASSISTANT GUNNER
	case "mmgag":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_riflemag,_defMags];
		_unit addMagazines [_riflemag_tr,2];
		[_unit, _rifle] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: HEAVY MG GUNNER
	case "hmgg":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: HEAVY MG ASSISTANT GUNNER
	case "hmgag":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: MEDIUM AT GUNNER
	case "matg":
	{
		["rpg"] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		_unit addMagazines [_smokegrenade,2];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _MAT] call f_fnc_addWeapon;
	};

	// LOADOUT: MEDIUM AT ASSISTANT GUNNER
	case "matag":
	{
		["rpg"] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos2] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: HEAVY AT GUNNER
	case "hatg":
	{
		["rpg"] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _HAT] call f_fnc_addWeapon;
	};

	// LOADOUT: HEAVY AT ASSISTANT GUNNER
	case "hatag":
	{
		["rpg"] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: MORTAR GUNNER
	case "mtrg":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: MORTAR ASSISTANT GUNNER
	case "mtrag":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,2];
		[_unit, _binos2] call f_fnc_addWeapon;
	};

	// LOADOUT: MEDIUM SAM GUNNER
	case "msamg":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
		_unit addMagazines [_chem,1];
		[_unit, _SAM] call f_fnc_addWeapon;
		
	};

	// LOADOUT: MEDIUM SAM ASSISTANT GUNNER
	case "msamag":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos2] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
		_unit addMagazines [_chem,1];
	};

	// LOADOUT: HEAVY SAM GUNNER
	case "hsamg":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
		_unit addMagazines [_chem,1];
	};

	// LOADOUT: HEAVY SAM ASSISTANT GUNNER
	case "hsamag":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos2] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
		_unit addMagazines [_chem,1];
	};

	// LOADOUT: SNIPER
	case "sn":
	{
		_unit addMagazines [_SNrifleMag,_defMags_tr];
		[_unit, _SNrifle] call f_fnc_addWeapon;
		_unit addMagazines [_pistolmag,3];
		[_unit, _pistol] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,1];
		_unit addMagazines [_chem,1];
		_attachments = _attach_sn;
	};

	// LOADOUT: SPOTTER
	case "sp":
	{
		["small"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_SNrifleMag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,3];
		_unit addMagazines [_glsmoke,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,1];
		_unit addMagazines [_chem,1];
		[_unit, _binos2] call f_fnc_addWeapon;
	};

	// LOADOUT: VEHICLE COMMANDER
	case "vc":
	{
		["cc"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit linkItem "ItemGPS";
		[_unit, _binos1] call f_fnc_addWeapon;
	};

	// LOADOUT: VEHICLE DRIVER
	case "vd":
	{
		["cc"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit linkItem "ItemGPS";
	};

	// LOADOUT: VEHICLE GUNNER
	case "vg":
	{
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit linkItem "ItemGPS";
	};

	// LOADOUT: AIR VEHICLE PILOTS
	case "pp":
	{
		["cc"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit linkItem "ItemGPS";
	};

	// LOADOUT: AIR VEHICLE CREW CHIEF
	case "pcc":
	{
		["cc"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: AIR VEHICLE CREW
	case "pc":
	{
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
	};

	// LOADOUT: ENGINEER (DEMO)
	case "eng":
	{
		[_typeofUnit] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit setUnitTrait ["explosiveSpecialist",1];
		_unit addMagazines [_carbinemag,_defMags];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_satchel,2];
	};

	// LOADOUT: ENGINEER (MINES)
	case "engm":
	{
		[_typeofUnit] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit setUnitTrait ["explosiveSpecialist",1];
		_unit addMagazines [_carbinemag,_defMags];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_APmine2,2];
	};

	// LOADOUT: UAV OPERATOR
	case "uav":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,2];
		_unit addMagazines [_grenade,1];
		_unit linkItem _uavterminal;
		_unit addMagazines ["Laserbatteries",4];
	};

	// LOADOUT: Diver
	case "div":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_diverMag1,_defMags];
		_unit addMagazines [_diverMag2,_defMags_tr];
		[_unit, _diverWep] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	// LOADOUT: RIFLEMAN
	case "r":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_riflemag,_defMags];
		_unit addMagazines [_riflemag_tr,_defMags_tr];
		[_unit, _rifle] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

// LOADOUT: CARABINEER
	case "car":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	// LOADOUT: SUBMACHINEGUNNER
	case "smg":
	{
		[_typeofUnit] call _backpack;
		_unit addMagazines [_smgmag,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	// LOADOUT: GRENADIER
	case "gren":
	{
		["g"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_glmag,5];
		_unit addMagazines [_glsmoke,2];
		_unit addMagazines [_glflare,2];
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	case "empty": 
	{
		_skipCheck = true;
	};
	
	#include "f_vehicle_loadout.sqf";

	// LOADOUT: DEFAULT/UNDEFINED (use RIFLEMAN)
   default
   {
		_unit addMagazines [_riflemag,_defMags];
		[_unit, _rifle] call f_fnc_addWeapon;

		_unit selectWeapon primaryWeapon _unit;

		if (true) exitWith {diag_log text format ["[F3] DEBUG (f\assignGear\f_loadout_rhs_insurgent.sqf): Unit = %1. Gear template %2 does not exist, used Rifleman instead.",_unit,_typeofUnit]};
   };

// ====================================================================================

// END SWITCH FOR DEFINE UNIT TYPE LOADOUTS
};

// ====================================================================================
// If this is an ammo box or vehicle check medical component settings and if needed run converter script.
if (!_isMan) exitWith { [_unit] spawn f_fnc_ace_medicalConverter; };

// ====================================================================================

// Handle weapon attachments
#include "..\..\f\assignGear\f_assignGear_attachments.sqf";

// ====================================================================================

// ENSURE UNIT HAS CORRECT WEAPON SELECTED ON SPAWNING

_unit selectWeapon primaryWeapon _unit;