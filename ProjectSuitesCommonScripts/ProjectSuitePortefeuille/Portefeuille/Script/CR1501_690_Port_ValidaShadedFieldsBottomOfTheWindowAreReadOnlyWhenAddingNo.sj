//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-690
    Description :
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3- Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4- Sélectionner une position qui contient des notes:La position est bien sélectionnées.
         5- Faire un click-right et choisir 'Ajouter une note':La fenêtre 'Ajouter une note' est ouverte.
         6- Vérifier que le contenu des champs 'Position', 'Date de création' et 'Créée par' est grisé.:
         Le contenu des champs 'Position', 'Date de création' et 'Créée par' est grisé.
            
                   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
*/


function CR1501_690_Port_ValidaShadedFieldsBottomOfTheWindowAreReadOnlyWhenAddingNo()
{
    try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         //Les variables
          var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
          var positionDescripCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
          Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
         //Choisir le module compte
          Get_ModulesBar_BtnAccounts().Click();
          //Sélectionner le compte 800300-NA
         Search_Account(numberAccount800300NA)
         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800300NA, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
           Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).ClickR();
           Get_PortfolioGrid_ContextualMenu_AddANote().Click();
           //Les points de vérifications
           //Les points de vérifications pour le contenu du champ position
           aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Get_WinCRUANote_TxtPositionForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
           //Les points de vérifications pour le contenu du champ date de création
           aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
           //Les points de vérifications pour le contenu du champ Créée par
           aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(), "VisibleOnScreen", cmpEqual, true);
           
          
          
         
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
    }
    finally {
   
        Terminate_CroesusProcess();
        
    }
}
