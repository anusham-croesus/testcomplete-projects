//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT CR1352_1038_Cli_Edit_TempFilter


/* Description ::Mailler des clients vers le module clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1456
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1456_Cli_DragClients_toClientModule()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click(); 
    
    Get_MainWindow().Maximize();
      
    //Sélectionner 3 clients 
    for(var i=0; i <=2; i++){
          Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
    }  
 
    //Mailler les clients sélectionnés ver le module client    
    Get_MenuBar_Modules().Click()
    Get_MenuBar_Modules_Clients().Click()
    Get_MenuBar_Modules_Clients_DragSelection().Click()
 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",133,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    //Vérifier qu’il y a 10 clients affichés dans la grille 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 3);
    
    //Vérifier le tooltip 
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, GetData(filePath_Clients,"CR1352",143,language)); //Le fichier Excel n'a pas fonctionné 
    if (client == "BNC"){
        if(language=="french"){
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Client(s) maillé(s) =800300\n800303\n90099A\n");
        }
        else{
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Dragged Client(s) =800300\n800303\n90099A\n");
        }
    }
    else{//RJ
          if(language=="french"){
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Client(s) maillé(s) =800300\n800301\n800302\n");
        }
        else{
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Dragged Client(s) =800300\n800301\n800302\n");
        }
    }
       
    Close_Croesus_MenuBar();
 }
 
