//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description :Création du filtre permanent à partir de 'Gérer les filtres...
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1154
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1154_Cli_Create_FilterFromManageFilters()
 {
    try{
    
        var filter="CR13521154"
    
        Login(vServerClients, "COPERN" , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant l'icone (Y) en haut a gauche   
        Get_RelationshipsClientsAccountsGrid().Click(10,10)
        Get_RelationshipsClientsAccountsGrid().Click(10,10)
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click(); 
    
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filter);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
        Get_WinCRUFilter_CmbAccess_ItemUser().Click(); 
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
        Get_WinCRUFilter_CmbField_ItemLanguage().Click()
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
        Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value", GetData(filePath_Clients, "CR1352", 60, language), 1000).Click();
        Get_WinCRUFilter_BtnOK().Click();
     
        //Les points de vérification: le texte de filtre
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
       
       //Vérifier le nombre de filtres affichés  (Tous le filtres appliqués sont retirés de la grille )
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 1);
        
        Check_IfPositionOfFilter_AfterPredefinedFilters(filter)
              
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
     }
     catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
     finally{
        Delete_FilterCriterion(filter,vServerClients)//Supprimer le filtre de BD         
     }                  
 }

 