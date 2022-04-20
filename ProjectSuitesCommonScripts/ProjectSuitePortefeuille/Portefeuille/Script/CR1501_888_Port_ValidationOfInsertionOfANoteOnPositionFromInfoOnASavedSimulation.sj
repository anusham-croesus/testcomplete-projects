//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**

     Préconditions : Se connecter avec 'COPERN'.
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-888
   
    Description :
         1-Choisir le module client: Le module client s'ouvre correctement.      
         2-Sélectionner un client: Le client est bien sélectionné.
         3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Cliquer sur le bouton 'Simulation'.:Les positions du portefeuille simulé sont affichées.
         5-Cliquer sur le bouton 'Sauvegarder'.:La fenêtre 'Sauvegarder la simulation' s'ouvre correctement.
         6-Choisir un 'Nouveau compte fictif' ensuite cliquer sur le bouton 'OK'.:
         La fenêtre d'information de sauvegarde  de la simulation du compte s'ouvre bien.
         7-Sélectionner une position.:La position est bien sélectionnée.
         8-Cliquer sur le bouton 'info' ensuite cliquer sur le bouton 'Ajouter'.:
         La fenêtre info est ouverte ainsi que la fenêtre 'Ajouter une note' est affichée.
         9-Ajouter 'heure & date',  une phrase prédéfinie ensuite cliquer sur le bouton sauvegarder.:
         La phrase prédéfinie et ''heure & date ' sont insérés correctemet.La fenêtre 'ajouter une note' est fermée.
         10-Ouvrir la fenêtre info de la position sélectionnée ensuite sélectionner l'onglet note.:
         La note est bien ajoutée.
         
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	rref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_888_Port_ValidationOfInsertionOfANoteOnPositionFromInfoOnASavedSimulation()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-888");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
            var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800300", language+client);
            var PortTextAddNotCROES888=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotCROES888", language+client);
            var NameAccountSimuCROES888=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "NameAccountSimuCROES888", language+client);
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
           
           Get_PortfolioBar_BtnWhatIf().Click();
          
           //Clicsur le bouton sauvegarder
           Get_PortfolioBar_BtnSave().Click()
           Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Click();
           Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(NameAccountSimuCROES888);
           Get_WinWhatIfSave_BtnOK().Click();
           Get_DlgInformation().Close();
          // sélectionner une position
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();   //Cliquer sur le bouton info
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
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotCROES888);
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
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotCROES888);
            var textNotCROES888= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES888.Exists;
            Log.Message(x);
          if(textNotCROES888.Exists && textNotCROES888.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
          Get_WinPositionInfo_BtnCancel().Click();    

         Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).Click();
         
         Get_PortfolioBar_BtnInfo().Click()
         //Les points de vérifications
         Get_WinPositionInfo_TabNotes().Click();
         Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotCROES888);
            var textNotCROES888= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES888.Exists;
            Log.Message(x);
          if(textNotCROES888.Exists && textNotCROES888.VisibleOnScreen)
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
        //initialiser la BD supprimer le compte fictif
        Terminate_CroesusProcess();
        Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
        DeleteAccountByName(NameAccountSimuCROES888)
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotCROES888, vServerPortefeuille)
        
    }
    finally {
   
        Terminate_CroesusProcess();
        //initialiser la BD supprimer le compte fictif
        Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
        DeleteAccountByName(NameAccountSimuCROES888)
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotCROES888, vServerPortefeuille)
        
    }
}
