//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
   https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-889
    
   
    Description :
         1-Choisir le module client: Le module client s'ouvre correctement.      
         2-Sélectionner un client: Le client est bien sélectionné.
         3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Cliquer sur le bouton 'Projections des liquidités ':Les projections de liquidités sont affichées.
         5-Sélectionner une position.:La position est bien sélectionnée.
         6-Cliquer sur le bouton 'Info' .:La fenêtre info est ouverte.
         7-Sélectionner l'onglet note ensuite cliquer sur le bouton 'Ajouter' pour ajouter une note.:La fenêtre d'ajout d'une note est ouverte.
         8-Ajouter 'heure & date',  une phrase prédéfinie ensuite cliquer sur le bouton sauvegarder.:
         La phrase prédéfinie et ''heure & date ' sont insérés correctemet.La fenêtre 'ajouter une note' est fermée.
         9-Ouvrir la fenêtre info de la position sélectionnée ensuite sélectionner l'onglet note.:La note est bien ajoutée.
         
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_889_Port_ValidatInsertionOfNoteOnPositionFromInfoInTheProjLiquidity()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-889");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
            var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800300", language+client);
            var PortTextAddNotTestCROES889=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES889", language+client);
          
          Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          //Sélectionner le client 800300
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
           Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           
           Get_PortfolioBar_BtnCashFlowProject().Click();
           aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsChecked", cmpEqual, true);

          // sélectionner une position
          Get_Portfolio_ProjLiquiditesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click()
          //Cliquer sur le bouton info
           Get_PortfolioBar_BtnInfo().Click();
           Get_WinPositionInfo_TabNotes().Click();
           Get_WinInfo_Notes_TabGrid().Click();
            //Ajouter une note. J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
            Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
            Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
             WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
            Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
             Get_ModulesBar_BtnPortfolio().WaitProperty("IsEnabled", true, 30000);
          // WaitObject(Get_WinCRUANote(), ["UID", "IsLoaded","IsEnabled"], ["Button_4da0", true,true]);
           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES889);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNote)
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
          //Les points de vérifications
           Get_WinPositionInfo_TabNotes().Click();
         Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotTestCROES889);
            var textNotCROES889= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES889.Exists;
            Log.Message(x);
          if(textNotCROES889.Exists && textNotCROES889.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
          Get_WinPositionInfo_BtnCancel().Click();    
         //sélectionner de nouveau la premiére position
         Get_Portfolio_ProjLiquiditesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click()
         Get_PortfolioBar_BtnInfo().Click()
         //Les points de vérifications
         Get_WinPositionInfo_TabNotes().Click();
         Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotTestCROES889);
            var textNotCROES889= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES889.Exists;
            Log.Message(x);
          if(textNotCROES889.Exists && textNotCROES889.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
            Get_WinPositionInfo_BtnCancel().Click();

        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES889, vServerPortefeuille)
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES889, vServerPortefeuille)
        
    }
}
