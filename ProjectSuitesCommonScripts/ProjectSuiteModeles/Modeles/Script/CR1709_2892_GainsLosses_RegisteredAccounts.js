//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2892
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2892_GainsLosses_RegisteredAccounts()
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles) 
        Execute_SQLQuery("update b_config set note='A,E,J,N,O,R,S,V,W,Y' where cle like '%cash_account%'", vServerModeles); 
        RestartServices(vServerModeles);
                 
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username"); 
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_Global", language+client);
        var relationshipName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RelationshipName_2892", language+client); 
        var client800251=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800251", language+client); 
        var account800038NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800038NA", language+client);   
        var CPBD88=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);            
        var account800251GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800251GT", language+client);      
              
        var realizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGL", language+client);
        var realizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLPercent", language+client);
        var unrealizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGL", language+client);
        var unrealizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLPercent", language+client);
       
        var ndText=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NDText", language+client);
        var realizedGLReg800251=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLReg800251", language+client);
        var unrealizedGLReg800251=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLReg800251", language+client);
        var realizedGLNonReg800038=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLNonReg800038", language+client);
        var unrealizedGLNonReg80038=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLNonReg80038", language+client); 
        RestartServices(vServerModeles);  
                                   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnRelationships().Click();
        Get_MainWindow().Maximize();
        
        //Fermer tous les filtres s'ils existent //EM : 90-06-Be-26 : Modification dûe a l'existance d'un filtre qui cache la relation créé  
        while(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        
        //créé une relation et lui assigner Client 800251 et compte 800038-NA       
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
        
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient().Keys(CPBD88);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");         
        
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName,10).ClickR();
        
        //client
        Get_MenuBar_Edit().Click();
        Get_MenuBar_Edit_AddForRelationshipsAndClients().OpenMenu();
        Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinClientsToRelationship().Click();
        Get_WinPickerWindow_DgvElements().Keys("F"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(client800251);
        Get_WinQuickSearch_RdoClientNo().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().CLick();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
        
        //Compte
        Get_MenuBar_Edit().Click();
        Get_MenuBar_Edit_AddForRelationshipsAndClients().OpenMenu();
        Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinAccountsToRelationship().Click();
        Get_WinPickerWindow_DgvElements().Keys("F"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(account800038NA);
        Get_WinQuickSearch_RdoAccountNo().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
         Get_WinAssignToARelationship_BtnYes().Click();
        
        Get_ModulesBar_BtnModels().Click();
        //associez une relation
        AssociateRelationshipWithModel(modelName,relationshipName)
        
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
              
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
         /*3-sommaire du portefeuille dans Onglet portefeuille projeté*/
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLNonReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLNonReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLNonReg() , "VisibleOnScreen", cmpEqual, true);
        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",account800251GT,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLReg() , "Text", cmpEqual, realizedGLReg800251);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLReg() , "Text", cmpEqual, unrealizedGLReg800251);//avant content
        Log.Message("Jira: BNC-1767")
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg() , "Text", cmpEqual, ndText);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, ndText);//avant content


        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",account800038NA,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLReg() , "Text", cmpEqual, ndText);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLReg() , "Text", cmpEqual, ndText);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg() , "Text", cmpEqual, realizedGLNonReg800038);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, unrealizedGLNonReg80038); //avant content
         
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);  
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(relationshipName,modelName)    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
              
    }
    finally { 
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language); 
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(relationshipName,modelName)
        Execute_SQLQuery("update b_config set note='A,E,J,N,O,R,S,T,V,W,Y' where cle like '%cash_account%'", vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)
        RestartServices(vServerModeles);
        Runner.Stop(true);
    }
}

function ResetData(relationshipName,modelName)
{
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationshipName,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
    
} 
function Test(){
    while(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
}