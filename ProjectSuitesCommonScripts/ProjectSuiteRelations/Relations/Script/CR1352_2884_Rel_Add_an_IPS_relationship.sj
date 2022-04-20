//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_0695_Rel_Create_an_IPS_type_filter


/**
    Description : Ajouter une relation IPS
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2884
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_2884_Rel_Add_an_IPS_relationship()
{
    var IPSRelationName = "#7 TEST_IPS";
    
    try {
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-2884","Cas de test TestLink : Croes-2884")
    
         //Activer la pref PREF_EDIT_FIRM_FUNCTIONS pour GP1859 dans le cas du client US
        if(client == "US" || client == "TD" ) 
            Activate_Inactivate_Pref('GP1859', "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
    
        //Activer les prefs pour COPERN
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_IPS", "YES", vServerRelations);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_IPS_FIRM_EDIT", "YES", vServerRelations);
        
        //Enlever la propriété ReadOnly de dictionnaire
        Execute_SQLQuery("update b_dictrp set READ_ONLY='N' where  CODE_DICT=119", vServerRelations)  
        RestartServices(vServerRelations);       
        
    
        //Ajouter le type de relation IPS dans le dictionnaire des types de relation
        CreateIPSRelationType();
         var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        //Se connecter avec COPERN et ajouter une relation de type IPS
        Login(vServerRelations, userName, psw, language);
        
        Log.Message("Create the relationship \"" + IPSRelationName + "\".");
    
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", IPSRelationName, 10);
        if (SearchResult.Exists)
            Log.Message("The relationship " + IPSRelationName + " already exists.");
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["AddDropDownMenu", true, true]);
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);       
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(IPSRelationName);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(IPSRelationName);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemIPSRelation().Click()
            Get_WinDetailedInfo_BtnOK().Click();
        }
        
        //Faire Info sur la relation IPS et vérifier la présence d'un nouvel onglet IPS Governance
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
       
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", IPSRelationName, 10).DblClick();
        
        Get_WinDetailedInfo().WaitProperty("VisibleOnScreen",true,3000);
        
        if (Get_WinDetailedInfo_TabIPSGovernanceForRelationship().Exists)
            Log.Checkpoint("The IPS Governance tab was displayed in the relationship info window. This is expected.");
        else
            Log.Error("The IPS Governance tab was not displayed in the relationship info window. This is not expected.");
        
        Get_WinDetailedInfo_BtnCancel().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(IPSRelationName);
        Terminate_CroesusProcess();
        DeleteIPSRelationType();
        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_IPS", null, vServerRelations);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_IPS_FIRM_EDIT", null, vServerRelations);

        if(client == "US")
            Activate_Inactivate_Pref('GP1859', "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerRelations);
            
        //Réinitialiser la propriété ReadOnly de dictionnaire
        Execute_SQLQuery("update b_dictrp set READ_ONLY='Y' where  CODE_DICT=119", vServerRelations)          
        RestartServices(vServerRelations);
        
    }
}
