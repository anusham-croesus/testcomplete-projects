//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-891
    
   
    Description :
         1-Choisir le module client: Le module client s'ouvre correctement.      
         2-Sélectionner un client: Le client est bien sélectionné.
         3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Cliquer sur le bouton Cliquer sur le bouton 'Par classe d'actifs ':La fenêtre de regroupement par classe d'actifs
          est ouverte.
         5-Sélectionner plusieurs regroupements.:Les regroupements sont bien selectionnés.:Les regroupements sont bien selectionnés.
         6-Faire un right-click ensuite choisir l'option 'Ajouter une note'.:L'option 'Ajouter une note' est disponible et la fenêtre
          'Ajouter une note' est ouverte.
         7-Ajouter 'heure & date',  une phrase prédéfinie ensuite cliquer sur le bouton sauvegarder.:La phrase prédéfinie et ''heure & date ' sont insérés 
          correctemet.La fenêtre 'ajouter une note est fermée.
         8-Exploser le '+' pour chaque regroupement ensuite vérifier que la note est ajoutée dans chaque position du regroupement.:
          La note est bien ajoutée sur chaque position de chaque regroupement.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_891_Port_ValidatAdditionNoteOnSeveralPositionsAtTimeByAssetClass()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-891");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
            var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800300", language+client);
            var PortTextAddNotTestCROES891=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES891", language+client);
          
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
           
           Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
           aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsChecked", cmpEqual, true);

          // sélectionner 2  positions
           Get_Portfolio_AssetClassesGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click();
           
           Sys.Desktop.KeyDown(0x10);
           
           //Sélectionner le 2 élèment
          Get_Portfolio_AssetClassesGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).Click();
           //Relâcher la touche Shift
           Sys.Desktop.KeyUp(0x10);
           Get_Portfolio_AssetClassesGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).ClickR(); 
           Get_PortfolioGrid_ContextualMenu_AddANote().Click();
            
            //Ajouter une note. J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
            Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
            Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
             WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
            Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
             Get_ModulesBar_BtnPortfolio().WaitProperty("IsEnabled", true, 30000);
          // WaitObject(Get_WinCRUANote(), ["UID", "IsLoaded","IsEnabled"], ["Button_4da0", true,true]);
           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES891);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNote)
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
          WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd")    
         
           
       for(n = 1; n < 3; n++)
        {
          Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n).set_IsExpanded(true);
  
     var countExplospluscount=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.count
     Log.Message(countExplospluscount)
  
      var d;
        for(d=1;d<countExplospluscount+1;d++){
           Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", d).WPFObject("RecordSelector", "", 1).Click()
           Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", d).WPFObject("RecordSelector", "", 1).WaitProperty("IsSelected", true, 30000);
           Get_PortfolioBar_BtnInfo().Click()
           WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee")
          //Les points de vérifications
           Get_WinPositionInfo_TabNotes().Click();
           Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotTestCROES891);
            var textNotCROES891= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES891.Exists;
            Log.Message(x);
          if(textNotCROES891.Exists && textNotCROES891.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
            Get_WinPositionInfo_BtnCancel().Click();
 
     Log.Message(d)
      }
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n).set_IsExpanded(false);
      }
          
        
       
      
         
         
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES891, vServerPortefeuille)
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES891, vServerPortefeuille)
        
    }
}
