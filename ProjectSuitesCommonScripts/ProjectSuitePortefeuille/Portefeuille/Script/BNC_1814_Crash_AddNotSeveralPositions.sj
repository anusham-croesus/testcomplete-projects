//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    Description :
                  Étapes de reproduction et de validatin dans l`environnement QA :
                  1.se connecter comme KEYNEJ
                  2.du module Relations, mailler toutes les relations vers portefeuille
                  3.Faire contrôle A pour sélectionner toutes les positions
                  4.clic droit, ajouter une note aux 1787 positions sélectionnées 
                  5.Sauvegarder

                   Résultat sur la 90.04.BNC-59, l`application crash

                   Résultat sur la 90.04.BNC.59B-1, note ajoutée sans crash(voir pieces jointes ajoutées aujourd`hui 30/Jan/2018)
                   
    Auteur : Sana Ayaz
*/
function BNC_1814_Crash_AddNotSeveralPositions()
{
    try {
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
      
        //Les variables
          var PortAddNotBNC_1814=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "PortAddNotBNC_1814", language+client);
          var PortTextAddNotBNC_1814=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "PortTextAddNotBNC_1814", language+client);

          //1.se connecter comme KEYNEJ
          Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
          // 2.du module Relations, mailler toutes les relations vers portefeuille
          Get_ModulesBar_BtnRelationships().Click();
          //Sélectionner toutes les raltaions
          Get_RelationshipsClientsAccountsGrid().Keys("^a");
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          
          // cliquer sur Intraday
            if(Get_PortfolioBar_BtnIntraday().VisibleOnScreen && Get_PortfolioBar_BtnIntraday().Enabled) {
           Get_PortfolioBar_BtnIntraday().Click();
           }
          // sélectionner toutes les positions
          Get_Portfolio_PositionsGrid().Keys("^a");
          
          Get_Portfolio_PositionsGrid().Keys("[Apps]");
       
  
          var numberOftries=0;  
        while ( numberOftries < 5 && !Get_SubMenus().Exists){
          Get_Portfolio_PositionsGrid().Keys("[Apps]");
          numberOftries++;
           } 
           
           
           Get_PortfolioGrid_ContextualMenu_AddANote().Click()
           
           // Les points de vérifications : la fenêtre d'ajout d'une note est affichée
           aqObject.CheckProperty(Get_WinCRUANote(), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Get_WinCRUANote(), "Title", cmpEqual, PortAddNotBNC_1814);
           aqObject.CheckProperty(Get_WinCRUANote(), "Visible", cmpEqual, true);
           
           Get_WinCRUANote_GrpNote_TxtNote().Click()
           Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotBNC_1814);
           Get_WinCRUANote_BtnSave().Click();
           
            var numberOftries=0;  
        while ( numberOftries < 5 && Get_WinCRUANote().Exists){
           Get_WinCRUANote_BtnSave().Click();
          numberOftries++;
           } 
           //
          
           Get_PortfolioBar_BtnInfo().Click();
            var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinPositionInfo().Exists){
            Get_PortfolioBar_BtnInfo().Click();
          numberOftries++;
           } 
           
          //Get_WinPositionInfo().Click();
          Get_WinPositionInfo_TabNotes().Click();
          Get_WinInfo_Notes_TabGrid().Click()
          //L'application ne crashe pas
           maxWaitTime = 10000;
        waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
        while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
            Delay(1000);
            waitTime += 1000;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
        }
        
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error("Bug BNC-1814");
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
          // Les points de vérifications : la note a été bien ajouté
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, PortTextAddNotBNC_1814);
          Get_WinPositionInfo_BtnCancel().Click();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotBNC_1814, vServerPortefeuille)
    }
}



