//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

/* Description : Ajouter des adresses a des clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2021
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_2021_Cli_Edit_InfoClient_Helpdsk()
{
    try {
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "FORTIM", "username");
        if ( client == "US" || client == "TD" || client == "CIBC" ){
            var clientNum ="800214"
        }
        else { 
            var clientNum ="900294";
        }
        
        Activate_Inactivate_Pref("FORTIM","PREF_DISPLAY_WHATS_NEW","NO",vServerClients);
        Login(vServerClients, user, psw, language);
        Get_ModulesBar_BtnClients().Click();  
    
        Get_MainWindow().Maximize();      
                  
        Search_Client(clientNum);             
        Get_ClientsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(), "WindowMetricTag", "CLIENT_NOTEBOOK", 2000)
    
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(), "IsEnabled", cmpEqual, false);
        //aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_dtp, "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClientCreation(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient(), "IsReadOnly", cmpEqual, true);
    
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtBalance(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtMarginOrExcessMargin(), "IsReadOnly", cmpEqual, true);
    
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_DtpCreationForClient(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_DtpUpdateForClient(), "IsReadOnly", cmpEqual, true);
    
    
        // Valider que seuls les sections Suivi et Note qui sont modifiables dans info client
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(), "IsEnabled", cmpEqual, true); 
        if (client == "BNC" ){
            aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(), "IsEnabled", cmpEqual, true);   
        }
  
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, true);
    
        if (client == "BNC" ){
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpNotes_TabGrid_BtnCopy(), "IsEnabled", cmpEqual, true);
        }
        
        Get_WinDetailedInfo_BtnOK().Click();
        
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }  
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } 
    finally {
        Activate_Inactivate_PrefBranch('0',"PREF_EDIT_ADDRESS","Sysadm",vServerClients)
        RestartVserver(vServerClients);
        Terminate_CroesusProcess();
    }
}
 