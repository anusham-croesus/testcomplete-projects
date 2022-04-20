//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT CR1352_1038_Cli_Edit_TempFilter


/* Description :Désactiver un filtre de chainage
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1457
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1457_Cli_Deactivate_DraggedFilter()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click(); 
    
    var count= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count
    
    //Aller au module comptes     
    Get_ModulesBar_BtnAccounts().Click();  
   
    //Sélectionner 3 comptes  
    for(var i=0; i <=2; i++){
          Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
    }  
 
    //Mailler les clients sélectionnés ver le module client    
    Get_MenuBar_Modules().Click()
    Get_MenuBar_Modules_Clients().Click()
    Get_MenuBar_Modules_Clients_DragSelection().Click()
 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",140,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    //Désactiver le filtre   
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click()
    
    //Vérifier que le filtre rapide est désactivé et tous les clients du module clients sont affichées 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, count);
        
    Close_Croesus_AltQ();
 }