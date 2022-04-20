//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA
//USEUNIT CR1352_1169_Cli_Create_UserAccessFilter

/* Description :États des boutons dans la fenêtre Gestion des filtres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1441
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1441_Cli_StateOfBtns_forGlobalAccessFilter()//YR: Avec LOB FirmFilter
 {          
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
             
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
                          
    //Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value","Global",10).Click()// YR: il n'y plus de "Global" dans la bd
        
    //vérification 
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);
    if(client == "RJ" || client == "CIBC"){
          aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, false);}
    else 
          aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, true);//YR: Corrigé suite à la réponse de Karima (Avant CX false)
    
    if(client  == "RJ" || client == "CIBC")
    {
      aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay(), "IsVisible", cmpEqual, true);//YR: Avnat Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay()
      aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay(), "IsEnabled", cmpEqual, true); //YR: Corrigé suite à la réponse de Karima (Avant Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay() CX )
        
    }
   else{ aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit(), "IsVisible", cmpEqual, true);//YR: Avnat Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay()
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit(), "IsEnabled", cmpEqual, true); }//YR: Corrigé suite à la réponse de Karima (Avant Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay() CX )
        
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsEnabled", cmpEqual, true);
        
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsEnabled", cmpEqual, true);
        
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsEnabled", cmpEqual, true);
               
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
                               
    Get_MainWindow().SetFocus();
    Close_Croesus_X();                  
 }


 