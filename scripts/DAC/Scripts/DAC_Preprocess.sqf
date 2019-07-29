//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Preprocess        //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

DAC_Path = "scripts\DAC\Configs\";DAC_AI_AddOn = 1;
DAC_Basic_Value = 0;DAC_Init_Zone = [];DAC_Obj_Init = [];DAC_CheckZones = [];
DAC_SayArrayE = [];DAC_SayArrayW = [];DAC_SayArrayD = [];DAC_RadioArrayE = [];DAC_RadioArrayW = [];
DAC_Radio_Settings = [1000,[0,0],5,2,objNull];
DAC_Marker_Val = [0,0,[],0,[],0,[],[],0,0,0,0,0,0,[],[]];
	
	DAC_Activate 				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Activate_Zone.sqf";
	DAC_Deactivate 				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Deactivate_Zone.sqf";
	DAC_Objects					= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Create_Objects.sqf";
	DAC_Weapons 				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Change_Weapons.sqf";
	DAC_Zone 					= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Init_Zone.sqf";
	DAC_fAIRadio        		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_AIRadio.sqf";
	DAC_fAISpeak        		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_AISpeak.sqf";
	DAC_fAddBehaviour     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Add_Behaviour.sqf",DAC_AI_AddOn];
	DAC_fAddGroup	    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Add_Group.sqf";
	DAC_fApplyPointsWithinZone 	= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Apply_Points_WithinZone.sqf";
	DAC_fArtiConditions 		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Arti_Conditions.sqf",DAC_AI_AddOn];
	DAC_fArtiFire       		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Arti_Fire.sqf",DAC_AI_AddOn];
	DAC_fCallArti       		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Call_Arti.sqf",DAC_AI_AddOn];
	DAC_fCallHelp       		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Call_Help.sqf",DAC_AI_AddOn];
	DAC_fChangeZone      		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Change_Zone.sqf";
	DAC_fCheckCargo     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Check_Cargo.sqf",DAC_AI_AddOn];
	DAC_fCheckCrew      		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Check_Crew.sqf",DAC_AI_AddOn];
	DAC_fCheckNewTarget    		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Check_NewTarget.sqf",DAC_AI_AddOn];
	DAC_fCheckTarget     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Check_Target.sqf",DAC_AI_AddOn];
	DAC_fClearZone 				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Clear_Zone.sqf";
	DAC_fClientCheck    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_ClientCheck.sqf";
	DAC_fClientRadio    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_ClientRadio.sqf";
	DAC_fClientSayer    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_ClientSayer.sqf";
	DAC_fClientSpeak    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_ClientSpeak.sqf";
	DAC_fCommandUnit    		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Command_Unit.sqf",DAC_AI_AddOn];
	DAC_fConfigArti		   		= compile preprocessFileLineNumbers format["%1DAC_Config_Arti.sqf",DAC_Path];
	DAC_fConfigBehav    		= compile preprocessFileLineNumbers format["%1DAC_Config_Behaviour.sqf",DAC_Path];
	DAC_fConfigCamps    		= compile preprocessFileLineNumbers format["%1DAC_Config_Camps.sqf",DAC_Path];
	DAC_fConfigEvents       	= compile preprocessFileLineNumbers format["%1DAC_Config_Events.sqf",DAC_Path];
	DAC_fConfigMarker   		= compile preprocessFileLineNumbers format["%1DAC_Config_Marker.sqf",DAC_Path];
	DAC_fConfigObj       		= compile preprocessFileLineNumbers format["%1DAC_Config_Objects.sqf",DAC_Path];
	DAC_fConfigSound			= compile preprocessFileLineNumbers format["%1DAC_Config_Sound.sqf",DAC_Path];
	DAC_fConfigUnits    		= compile preprocessFileLineNumbers format["%1DAC_Config_Units.sqf",DAC_Path];
	DAC_fConfigWP       		= compile preprocessFileLineNumbers format["%1DAC_Config_Waypoints.sqf",DAC_Path];
	DAC_fConfigWeapons    		= compile preprocessFileLineNumbers format["%1DAC_Config_Weapons.sqf",DAC_Path];
	DAC_fCreateCamp     		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Create_Camp.sqf";
	DAC_fDelPlayer      		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Del_Player.sqf";
	DAC_fDeleteObject   		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Delete_Object.sqf";
	DAC_fDeleteUnit     		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Delete_Unit.sqf";
	DAC_fDeleteZone 			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Delete_Zone.sqf";
	DAC_fEnemyCond      		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Enemy_Conditions.sqf",DAC_AI_AddOn];
	DAC_fEnterGun		   		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Enter_Gun.sqf",DAC_AI_AddOn];
	DAC_fEnterVehicle   		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Enter_Vehicle.sqf",DAC_AI_AddOn];
	DAC_fFillArray 				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Fill_Array.sqf";
	DAC_fFindCover	    		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Find_Cover.sqf",DAC_AI_AddOn];
	DAC_fFindEllipsPos			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Find_EllipsPos.sqf";
	DAC_fFindGroup      		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Find_Group.sqf",DAC_AI_AddOn];
	DAC_fFindMClass     		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Find_MClass.sqf";
	DAC_fFindPolyLog			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Find_PolyLog.sqf";
	DAC_fFindPolyPos			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Find_PolyPos.sqf";
	DAC_fFindPos        		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Find_Pos.sqf";
	DAC_fFindSpUnit				= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Find_SpUnit.sqf",DAC_AI_AddOn];
	DAC_fFindVehicle    		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Find_Vehicle.sqf",DAC_AI_AddOn];
	DAC_fFindWpLog				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Find_WpLog.sqf";
	DAC_fFireArti       		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Fire_Arti.sqf",DAC_AI_AddOn];
	DAC_fFlashMarker    		= compile preprocessFileLineNumbers "scripts\DAC\Marker\DAC_FlashMarker.sqf";
	DAC_fForceSpeed	    		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Force_Speed.sqf",DAC_AI_AddOn];
	DAC_fGetMovepoints 			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Get_Movepoints.sqf";
	DAC_fGetWaypoints      		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Get_Waypoints.sqf";
	DAC_fGetZoneWaypoints 		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Get_Zone_Waypoints.sqf";
	DAC_fGroupGetin     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Group_Getin.sqf",DAC_AI_AddOn];
	DAC_fGroupMarker     		= compile preprocessFileLineNumbers "scripts\DAC\Marker\DAC_GroupMarker.sqf";
	DAC_fGroupAir     			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Group_Air.sqf";
	DAC_fGroupCamp	     		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Group_Camp.sqf";
	DAC_fGroupTank	     		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Group_Tank.sqf";
	DAC_fGroupVehicle   		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Group_Vehicle.sqf";
	DAC_fGroupSoldier     		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Group_Soldier.sqf";
	DAC_fHeliConditions	    	= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Heli_Conditions.sqf",DAC_AI_AddOn];
	DAC_fHitByEnemy     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Hit_by_Enemy.sqf",DAC_AI_AddOn];
	DAC_fHoldArtiGroup  		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Hold_ArtiGroup.sqf",DAC_AI_AddOn];
	DAC_fHoldBuilding   		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Hold_Building.sqf",DAC_AI_AddOn];
	DAC_fInitSector				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Init_Sector.sqf";
	DAC_fInsertGroup    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Insert_Group.sqf";
	DAC_fInsertVehicle  		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Insert_Vehicle.sqf";
	DAC_fInsideOfZones 			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Inside_Of_Zones.sqf";
	DAC_fLeaderMarker   		= compile preprocessFileLineNumbers "scripts\DAC\Marker\DAC_LeaderMarker.sqf";
	DAC_fLeaveVehicle   		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Leave_Vehicle.sqf",DAC_AI_AddOn];
	DAC_fMoveAround	     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_Around.sqf",DAC_AI_AddOn];
	DAC_fMoveCamp	     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_Camp.sqf",DAC_AI_AddOn];
	DAC_fMoveNear	     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_Near_Pos.sqf",DAC_AI_AddOn];
	DAC_fMoveNot	     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_Not.sqf",DAC_AI_AddOn];
	DAC_fMoveRandom     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_Random.sqf",DAC_AI_AddOn];
	DAC_fMoveSimple     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_Simple.sqf",DAC_AI_AddOn];
	DAC_fMoveToBuilding 		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_to_Building.sqf",DAC_AI_AddOn];
	DAC_fMoveToEnemy    		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_to_Enemy.sqf",DAC_AI_AddOn];
	DAC_fMoveToFriendly 		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_to_Friendly.sqf",DAC_AI_AddOn];
	DAC_fMoveToVH       		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_to_VH.sqf",DAC_AI_AddOn];
	DAC_fMoveToWaypoint 		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_to_WP.sqf",DAC_AI_AddOn];
	DAC_fMoveWithTank 			= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_with_TA.sqf",DAC_AI_AddOn];
	DAC_fMoveWithVH     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Move_with_VH.sqf",DAC_AI_AddOn];
	DAC_fNewWaypoints   		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_New_Waypoints.sqf";
	DAC_fNewZone 				= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_New_Zone.sqf";
	DAC_fOtherConditions		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Other_Conditions.sqf",DAC_AI_AddOn];
	DAC_fReadAllCustomPoints 	= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Read_AllCustom_Points.sqf";
	DAC_fReadMarkers 			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Read_Markers.sqf";
	DAC_fReduceGroup    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Reduce_Group.sqf";
	DAC_fReleaseGroup    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Release_Group.sqf";
	DAC_fRebuildGroup    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Rebuild_Group.sqf";
	DAC_fRemoveGroup    		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Remove_Group.sqf",DAC_AI_AddOn];
	DAC_fReplaceZoneWaypoints 	= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Replace_Zone_Waypoints.sqf";
	DAC_fResizeMarker   		= compile preprocessFileLineNumbers "scripts\DAC\Marker\DAC_ResizeMarker.sqf";
	DAC_fRouteMarker    		= compile preprocessFileLineNumbers "scripts\DAC\Marker\DAC_RouteMarker.sqf";
	DAC_fScanBuilding   		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Scan_Buildings.sqf",DAC_AI_AddOn];
	DAC_fSectorCheck    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Sector_Check.sqf";
	DAC_fServerCheck    		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_ServerCheck.sqf";
	DAC_fSetWaypoints      		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Set_Waypoints.sqf";
	DAC_fShowRadio      		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Show_Radio.sqf";
	DAC_fShuffleArray 			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Shuffle_Array.sqf";
	DAC_fSimpleConditions 		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Simple_Conditions.sqf",DAC_AI_AddOn];
	DAC_fSmokeGren				= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Smoke_Gren.sqf",DAC_AI_AddOn];
	DAC_fSomeConditions 		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Some_Conditions.sqf",DAC_AI_AddOn];
	DAC_fSplitWPWay 			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Split_WP_Way.sqf";
	DAC_fSumWaypoints   		= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Sum_Waypoints.sqf";
	DAC_fUnitMarker     		= compile preprocessFileLineNumbers "scripts\DAC\Marker\DAC_UnitMarker.sqf";
	DAC_fVehicleArray     		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Vehicle_Array.sqf",DAC_AI_AddOn];
	DAC_fWaitForHelp			= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Wait_for_Help.sqf",DAC_AI_AddOn];
	DAC_fWaitingForEnd  		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Waiting_For_End.sqf",DAC_AI_AddOn];
	DAC_fWritePosition			= compile preprocessFileLineNumbers "scripts\DAC\Scripts\DAC_Write_Position.sqf";
	DAC_fsetBehaviour   		= compile preprocessFileLineNumbers format["scripts\DAC\AI_%1\DAC_Set_Behaviour.sqf",DAC_AI_AddOn];