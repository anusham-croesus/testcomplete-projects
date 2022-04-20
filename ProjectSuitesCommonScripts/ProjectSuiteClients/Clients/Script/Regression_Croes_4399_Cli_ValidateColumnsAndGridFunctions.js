//USEUNIT CR1352_1508_Cli_ChangingSortOrder_forAdvancedCriteria
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4399
    
   
    Description :valider les différentes fonctionnalités (Triage, déplacement et le menu contextuel) des colonnes et les différentes fonctions du menu contextuel de la grille du module Clients.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-2--V9-croesus-co7x-1_5_565
    
    Date: 25/030/2019
*/

function Regression_Croes_4399_Cli_ValidateColumnsAndGridFunctions()
{
  
  try{
    
   Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4399", "Croes-4399");
   
    var SortByName=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "SortByName", language+client)
    var SortByClientNo=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "SortByClientNo", language+client)
    var columnName=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "columnName", language+client)    
     
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //mettre les colonnes à la config par défaut
    Get_ClientsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
      
    //Ajouter la colonne 'Langue' 
    Log.Message("Add the 'Language' column.");        
    ExecuteActionAndExpectSubmenus(Get_ClientsGrid_ChClientNo(), "CLICKR", 3); 
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Language().Click();
   
    //Vérifier que la colonne 'Langue' est affichée
    if (!(Get_ClientsGrid_ChLangue().Exists)){
            Log.Error("'Language' column not displayed. This is not expected.");
            return;
        }
       Log.Checkpoint("Language is displayed.") 
       
    //Ajouter la colonne Date de naissance
    Log.Message("Add the 'Date of birth' column.");        
    ExecuteActionAndExpectSubmenus(Get_ClientsGrid_ChClientNo(), "CLICKR", 3); 
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_DateOfBirth().Click();
   
    //Vérifier que la colonne 'Date of birth' est affichée
    if (!(Get_ClientsGrid_ChLangue().Exists)){
            Log.Error("'Date of birth' column not displayed. This is not expected.");
            return;
        }
       Log.Checkpoint("Date of birth is displayed.") 
    
    //Ajouter la colenne Nom Complet    
    Log.Message("Add the 'Full name' column.");        
    ExecuteActionAndExpectSubmenus(Get_ClientsGrid_ChClientNo(), "CLICKR", 3); 
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_FullName().Click();
   
    //Vérifier que la colonne 'Date of birth' est affichée
    if (!(Get_ClientsGrid_ChLangue().Exists)){
            Log.Error("'Full name' column not displayed. This is not expected.");
            return;
        }
       Log.Checkpoint("Full name is displayed.") 
           
   //Déplacer la colonne Langue
   MoveColumn(Get_ClientsGrid_ChLangue())
   aqObject.CheckProperty(Get_ClientsGrid_ChLangue(), "IsFixed", cmpEqual,true);
   aqObject.CompareProperty(Get_ClientsGrid_ChLangue().Field.FixedLocation,cmpEqual,"FixedToFarEdge",true);
   
   //Supprimer la colonne Nom Complet
   DeleteColumn(Get_ClientsGrid_ChLangue())
   aqObject.CheckProperty(Get_ClientsGrid_ChLangue(), "Exists", cmpEqual,false);
   
   //tri par Nom
    ExecuteActionAndExpectSubmenus(Get_RelationshipsClientsAccountsGrid(), "CLICKR", 3); 
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy().Click();  
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy_Name().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(),columnName,SortByName)     
    
    //tri par No Client
    ExecuteActionAndExpectSubmenus(Get_RelationshipsClientsAccountsGrid(), "CLICKR", 3); 
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy().Click();  
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy_ClientNo().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(),columnName, SortByClientNo)   
    
    //valider l'affichage du menu contextuel
    ExecuteActionAndExpectSubmenus(Get_RelationshipsClientsAccountsGrid(), "CLICKR", 3); 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ContextualMenu(), "Exists", cmpEqual,true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ContextualMenu(), "VisibleOnScreen", cmpEqual,true);
    
  }
    
   catch(e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
      // Terminate_CroesusProcess();
       
    }
    finally {
    ExecuteActionAndExpectSubmenus(Get_ClientsGrid_ChClientNo(), "CLICKR", 3); 
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();//rétablir la configuration par défaut des colonnes 
    Terminate_CroesusProcess(); //Fermer Croesus
  
     
    }  
}
    
function ExecuteActionAndExpectSubmenus(componentObject, action, maxNbOfTries)
{
    try {
        SetAutoTimeOut(500);
        
        if (maxNbOfTries == undefined)
            maxNbOfTries = 5;
        
        var nbOfTries = 0;
        do {
            if (aqString.ToUpper(action) == "CLICKR" || aqString.ToUpper(action) == "CLICKR()")
                componentObject.ClickR();
            else if (aqString.ToUpper(action) == "CLICK" || aqString.ToUpper(action) == "CLICK()")
                componentObject.Click();
            else
                componentObject.Keys(action);
            
            Delay(200);
             Aliases.CroesusApp.Refresh();
        } while (!(Get_SubMenus().Exists && Get_SubMenus().VisibleOnScreen) && (++nbOfTries < maxNbOfTries))
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        if (!(Get_SubMenus().Exists && Get_SubMenus().VisibleOnScreen)) Log.Error("Submenus was not displayed.");
        RestoreAutoTimeOut();
    }
}
