//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    Description :
                  Mailler un compte vers le module portefeuille 
                  Cliquer sur simulation 
                  Cliquer sur le bouton Sauvegarder du module portefeuille
                  Sur la fenêtre Sauvegarder la simulation, choisir l'option "Nouveau modèle" et cliquer sur le bouton Sauvegarde détaillée 
                  Croesus crash
                  
     Auteur : Sana Ayaz
     Anomalie:CROES-9433
     Version de scriptage:ref90-07-Co-15--V9-Be_1-co6x
*/
function CROES_9433_CrashInTheWalletModulPortfolio()
{
    try {
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
      
         //Les variables
         
          var NumberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "NumberAccount800300NA", language+client);

          //se connecter comme KEYNEJ
          Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
          //   Mailler un compte vers le module portefeuille 
          Get_ModulesBar_BtnAccounts().Click();
          //Chercher le compte 800300-NA
          Search_Account(NumberAccount800300NA)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumberAccount800300NA, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          // Cliquer sur simulation 
          Get_PortfolioBar_BtnWhatIf().Click();
          
          // Cliquer sur le bouton Sauvegarder du module portefeuille
          
          Get_PortfolioBar_BtnSave().Click();
          
          // Sur la fenêtre Sauvegarder la simulation, choisir l'option "Nouveau modèle" et cliquer sur le bouton Sauvegarde détaillée 
          Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Click();
         
          //cliquer sur le bouton Sauvegarde détaillée
           Get_WinWhatIfSave_BtnDetailedSave().Click();
          
          
          //Les points de vérifications
          aqObject.CheckProperty(Get_WinModelInfo(), "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_WinModelInfo(), "VisibleOnScreen", cmpEqual, true);
          
          Log.Message("CROES-9433")
         
          Terminate_CroesusProcess();
          
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
    }
    finally {
   
        Terminate_CroesusProcess();
        
    }
}



