//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
  Description : Note sur plusieurs positions
  
  Regrouper les cas suivants:
  Croes-891 Validation de l'ajout d'une note sur plusieurs positions a la fois par classe d'actifs
  Croes-894 Validation d'insertion d'une note à l'enregistrement sélectionné pour regroupement par titre
  Croes-896 Validation d'insertion d'une note sur plusieurs positions pour un regroupement par panier
  Croes-701 Validation d'insertion d'une note à plusieurs positions à la fois dans l'onglet proj.de liquidité
  ////////À supprimer -----  Croes-889 Validation d'insertion d'une note sur position a partir d'info dans l'onglet proj. de liquidité
  Croes-888 Validation d'insertion d'une note sur position a partir d'info sur une simulation sauvegardée

    
  Analyste d'assurance qualité : Karima Mo
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-21-2020-11-34
*/


 function CR1501_OptiTCVE_3677_NoteOnSeveralPositions()
 {  
    try{
      //Afficher le lien de cas de test global
      Log.Link("https://jira.croesus.com/browse/TCVE-3677", "Cas de test sur Jira: TCVE-3677");  
      
      var keynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var pswKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw"); 
            
     //Les variables
      var numberClient800285=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800285", language+client);
      var positionNoteCROES891=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES891", language+client);          
          
      Log.Message("se connercter avec keynej");
      Login(vServerPortefeuille, keynej, pswKeynej, language);
          
      //********************************** Étape 1 : Validation de l'ajout d'une note sur plusieurs positions a la fois par classe d'actifs **********************************/
      Log.AppendFolder("Étape 1: Croes-891 - Validation de l'ajout d'une note sur plusieurs positions a la fois par classe d'actifs");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-891", "Cas de test TestLink: Croes-891");  
     //**********************************************************************************************************************************************************************/
    
      Log.Message("Choisir le module clients"); 
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");   
      Get_MainWindow().Maximize();
      
      Log.Message("Sélectionner le client "+numberClient800285);
      Search_Client(numberClient800285);
          
      Log.Message("Mailler vers le module portefeuille");
      Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800285, 10), Get_ModulesBar_BtnPortfolio());
      Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
      
      Log.Message("Cliquer sur le bouton 'Classe d'actif' puis sélectionner plusieurs groupes.");
      Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsChecked", cmpEqual, true);
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");

      //sélectionner 2  positions
      Get_Portfolio_AssetClassesGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click();           
      Sys.Desktop.KeyDown(0x10);           
      //Sélectionner le 2ème élèment
      Get_Portfolio_AssetClassesGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).Click();
      //Relâcher la touche Shift
      Sys.Desktop.KeyUp(0x10);
      
      Log.Message("Clic droit --> Ajouter une note");
      Get_Portfolio_AssetClassesGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).ClickR(); 
      Get_PortfolioGrid_ContextualMenu_AddANote().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
      Log.Message("Ajouter heure &date, une note '"+positionNoteCROES891+"' puis sauvegarder");//J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
      Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
      WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
      Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("IsEnabled", true, 30000);
           
      Get_WinCRUANote_GrpNote_TxtNote().Click();
      Get_WinCRUANote_GrpNote_TxtNote().set_Text(positionNoteCROES891);
      Get_WinCRUANote_GrpNote_BtnDateTime().Click();
      var txtAddedNoteCroes891=Get_WinCRUANote_GrpNote_TxtNote().Text;
      
      Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);
      Get_WinCRUANote_BtnSave().Click();
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");
      
      Log.Message("Étape 2: Exploser le petit + pour chaque groupe et vérifier que la note '"+txtAddedNoteCroes891+"' est ajoutée dans chaque position du groupe.");    
      for(var i = 1; i < 3; i++){
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",i).set_IsExpanded(true);
  
        var Explospluscount=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.count
        Log.Message(Explospluscount);
  
        for(var j=1; j<Explospluscount+1; j++){
           Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", j).WPFObject("RecordSelector", "", 1).Click()
           //Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", j).WPFObject("RecordSelector", "", 1).WaitProperty("IsSelected", true, 30000);
           Get_PortfolioBar_BtnInfo().Click()
           WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
           WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes soit visible
           //Les points de vérifications
           Get_WinPositionInfo_TabNotes().Click();
           WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
           Get_WinInfo_Notes_TabGrid().Click();
           
           // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, txtAddedNoteCroes891);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, positionNoteCROES891);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes891), 10).DataContext.DataItem,"Comment", cmpEqual, txtAddedNoteCroes891);
           
           var FindNote= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes891), 10)
           if(FindNote.Exists && FindNote.VisibleOnScreen)
              Log.Checkpoint("La note est ajoutée","Groupe Line = "+i+" Position Line = "+j);
           else
              Log.Error("La note n'est pas ajoutée","Groupe Line = "+i+" Position Line = "+j);
           
           Get_WinPositionInfo_BtnCancel().Click(); 
           WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        }
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).set_IsExpanded(false);
      }
      
      Log.PopLogFolder();      
      
      //********************************** Étape 3 : Validation d'insertion d'une note à l'enregistrement sélectionné pour regroupement par titre **********************************/
      Log.AppendFolder("Étape 3: Croes-894 - Validation d'insertion d'une note à l'enregistrement sélectionné pour regroupement par titre");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-894", "Cas de test TestLink: Croes-894");  
      //**********************************************************************************************************************************************************************/
      
      var positionNoteCROES894 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES894", language+client);
      var positionSymbolXCB = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PositionSymbolXCB", language+client);
      
      Log.Message("Cliquer sur le bouton 'Par titre'.");    
      Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity().Click();
      Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity().WaitProperty("IsChecked", true, 30000);
           
      if (client == "CIBC")
        aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsChecked", cmpEqual, false);     
      else
        aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsChecked", cmpEqual, true);
     
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");

      Log.Message("Sélectionner la  position "+positionSymbolXCB+" Clic droit --> Ajouter une note");    
      Search_Position(positionSymbolXCB);             
      Get_Portfolio_AssetClassesGrid().FindChild("Value", positionSymbolXCB, 10).Click();
      Get_Portfolio_AssetClassesGrid().FindChild("Value", positionSymbolXCB, 10).ClickR(); 
      Get_PortfolioGrid_ContextualMenu_AddANote().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
      Log.Message("Ajouter heure &date, une note '"+positionNoteCROES894+"' puis sauvegarder");//J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
      WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
      Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("IsEnabled", true, 30000);
           
      Get_WinCRUANote_GrpNote_TxtNote().Click();
      Get_WinCRUANote_GrpNote_TxtNote().set_Text(positionNoteCROES894);
      Get_WinCRUANote_GrpNote_BtnDateTime().Click();
      var txtAddedNoteCroes894 = Get_WinCRUANote_GrpNote_TxtNote().Text;
      
      Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);
      Get_WinCRUANote_BtnSave().Click();
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");      
       
      Log.Message("Valider que la note '"+txtAddedNoteCroes894+"' est ajoutée pour la position "+positionSymbolXCB); 
      Get_Portfolio_AssetClassesGrid().FindChild("Value", positionSymbolXCB, 10).Click();
      Get_PortfolioBar_BtnInfo().Click();
      WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes soit visible
      Get_WinPositionInfo_TabNotes().Click();
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
      Get_WinInfo_Notes_TabGrid().Click();
           
      // Les points de vérifications : la note a été bien ajouté
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, txtAddedNoteCroes894);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, positionNoteCROES894);
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes894), 10).DataContext.DataItem,"Comment", cmpEqual, txtAddedNoteCroes894);
           
      var FindNote= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes894), 10)
      if(FindNote.Exists && FindNote.VisibleOnScreen)
        Log.Checkpoint("La note est ajoutée.");
      else
        Log.Error("La note n'est pas ajoutée.");
           
      Get_WinPositionInfo_BtnCancel().Click(); 
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
            
      Log.PopLogFolder();
     
     //********************************** Étape 4 : Validation d'insertion d'une note sur plusieurs positions pour un regroupement par panier **********************************/
      Log.AppendFolder("Étape 4: Croes-896 - Validation d'insertion d'une note sur plusieurs positions pour un regroupement par panier");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-896", "Cas de test TestLink: Croes-896");  
     //**********************************************************************************************************************************************************************/
      
      var positionNoteCROES896 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotCROES896", language+client);
      
      Log.Message("Cliquer sur le bouton 'Par Panier'.");
      Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket().Click(); 
      if(Get_DlgInformation().Exists) //lors de click sur Btn Par Panier, un message d'information s'affiche: 'Certains paniers que vous tentez de grouper comportent des titres qui ne sont détenus dans aucun compte.2,500 paniers 844000 dans le compte 800285-RE'
        Get_DlgInformation_BtnOK().Click(); 
           
      Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket().WaitProperty("IsChecked", true, 30000);       
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsChecked", cmpEqual, true);
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");

      Log.Message("Sélectionner les 6 premieres positions qui n'ont pas de notes");
      var positionsSymbolArray = new Array();
      var count = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count;
      var i=0;      
      while(positionsSymbolArray.length < 6 && i < count){
        var positionSymbol = VarToStr(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Symbol);
        var ifHasNote = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.HasNote;
        var ifIsNotExpandableField = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.NbPositions == 0;
        if(!ifHasNote && ifIsNotExpandableField)   
            positionsSymbolArray.push(positionSymbol);        
        i++;
           
      }
      var selectedPositionsStr = positionsSymbolArray.join(",");      
               
      //Sélectionner les éléments de positionsSymbolArray      
      for(var i = 0; i < positionsSymbolArray.length; i++){
         var positionSymbolCell = Get_Portfolio_AssetClassesGrid().FindChildEx("Value", positionsSymbolArray[i], 10, true, 30000); 
         if (positionSymbolCell.Exists)
            positionSymbolCell.Click(-1, -1, skCtrl);
         else
            Log.Error("The position Symbol '" + positionsSymbolArray[i] + "' cell was not found.");
      }
      
      Log.Message("les positions sélectionnées: "+selectedPositionsStr);
      
      Log.Message("Clic droit --> Ajouter une note");
      Get_Portfolio_AssetClassesGrid().FindChild("Value", positionsSymbolArray[positionsSymbolArray.length-1], 10).ClickR(); 
      Get_PortfolioGrid_ContextualMenu_AddANote().Click();            
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
      Log.Message("Ajouter heure &date, une note '"+positionNoteCROES896+"' puis sauvegarder");//J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
      Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
      WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
      Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
           
      Get_WinCRUANote_GrpNote_TxtNote().Click();
      Get_WinCRUANote_GrpNote_TxtNote().set_Text(positionNoteCROES896);
      Get_WinCRUANote_GrpNote_BtnDateTime().Click();
      var txtAddedNoteCroes896=Get_WinCRUANote_GrpNote_TxtNote().Text;
      
      Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);
      Get_WinCRUANote_BtnSave().Click();
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");
      
      Log.Message("Étape 5: Valider que la note '"+txtAddedNoteCroes896+"' est ajoutée pour chacune des positions "+selectedPositionsStr); 
      for(var i = 0; i < positionsSymbolArray.length; i++)
      {
        var positionSymbolCell = Get_Portfolio_AssetClassesGrid().FindChild("Value", positionsSymbolArray[i], 10);        
        
        Get_Portfolio_AssetClassesGrid().FindChild("Value", positionsSymbolArray[i], 10).DblClick(); 
        WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
        WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes soit visible
          
        Get_WinPositionInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
       // Les points de vérifications : la note a été bien ajouté
       aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, txtAddedNoteCroes896);
       aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, positionNoteCROES896);
       aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes896), 10).DataContext.DataItem,"Comment", cmpEqual, txtAddedNoteCroes896);
           
       var FindNote= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes896), 10)
       if(FindNote.Exists && FindNote.VisibleOnScreen)
          Log.Checkpoint("La note est ajoutée pour la position "+positionsSymbolArray[i]);
       else
          Log.Error("La note n'est pas ajoutée pour la position "+positionsSymbolArray[i]);
           
       Get_WinPositionInfo_BtnCancel().Click(); 
       WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
          
        
          
      }
        
      Log.PopLogFolder();
      
      //********************************** Étape 6 : Validation d'insertion d'une note à plusieurs positions à la fois dans l'onglet proj.de liquidité **********************************/
      Log.AppendFolder("Étape 6: Croes-701 - Validation d'insertion d'une note à plusieurs positions à la fois dans l'onglet proj.de liquidité");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-701", "Cas de test TestLink: Croes-701");  
     //**********************************************************************************************************************************************************************/
      
      var positionNoteCROES701 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES701", language+client);
      
      Log.Message("Cliquer sur le bouton  'Projection de liquidités'.");
      Get_PortfolioBar_BtnCashFlowProject().Click();    
      Get_PortfolioBar_BtnCashFlowProject().WaitProperty("IsChecked", true, 30000);       
      aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsChecked", cmpEqual, true);
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_e480");
      
      Log.Message("Sélectionner les 6 premieres positions qui n'ont pas de notes");
      var positionsSymbolArrayCroes701 = new Array();
      var count = Get_Portfolio_ProjLiquiditesGrid().WPFObject("RecordListControl", "", 1).Items.Count;
      var i=0;      
      while(positionsSymbolArrayCroes701.length < 6 && i < count){
        var positionDescription = VarToStr(Get_Portfolio_ProjLiquiditesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription);
        if(!Get_Portfolio_ProjLiquiditesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.HasNote && aqString.Contains(positionsSymbolArrayCroes701, positionDescription) == -1)   
            positionsSymbolArrayCroes701.push(positionDescription);        
        i++;
           
      }
      var selectedPositionsStr = positionsSymbolArrayCroes701.join(",");      
               
      //Sélectionner les éléments de positionsSymbolArrayCroes701
      for(var i = 0; i < positionsSymbolArrayCroes701.length; i++){
         var positionDescriptionCell = Get_Portfolio_ProjLiquiditesGrid().FindChildEx("Value", positionsSymbolArrayCroes701[i], 10, true, 30000); 
         if (positionDescriptionCell.Exists)
            positionDescriptionCell.Click(-1, -1, skCtrl);
         else
            Log.Error("The position description '" + positionsSymbolArrayCroes701[i] + "' cell was not found.");
      }
              
      Log.Message("les positions sélectionnées: "+selectedPositionsStr);
      
      Log.Message("Clic droit --> Ajouter une note");
      Get_Portfolio_ProjLiquiditesGrid().FindChild("Value", positionsSymbolArrayCroes701[positionsSymbolArrayCroes701.length-1], 10).ClickR(); 
      Get_PortfolioGrid_ContextualMenu_AddANote().Click();            
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
      Log.Message("Ajouter heure &date, une note '"+positionNoteCROES701+"' puis sauvegarder");//J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
      Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
      WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
      Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("IsEnabled", true, 30000);
           
      Get_WinCRUANote_GrpNote_TxtNote().Click();
      Get_WinCRUANote_GrpNote_TxtNote().set_Text(positionNoteCROES701);
      Get_WinCRUANote_GrpNote_BtnDateTime().Click();
      var txtAddedNoteCroes701=Get_WinCRUANote_GrpNote_TxtNote().Text;
      
      Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);
      Get_WinCRUANote_BtnSave().Click();
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");
      
      Log.Message("Étape 7: Valider que la note '"+txtAddedNoteCroes701+"' est ajoutée pour chacune des positions "+selectedPositionsStr); 
      for(var i = 0; i < positionsSymbolArrayCroes701.length; i++)
      {
        Get_Portfolio_ProjLiquiditesGrid().FindChild("Value", positionsSymbolArrayCroes701[i], 10).DblClick(); 
        Get_WinPositionInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
         // Les points de vérifications : la note a été bien ajouté
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, txtAddedNoteCroes701);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, positionNoteCROES701);
         aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes701), 10).DataContext.DataItem,"Comment", cmpEqual, txtAddedNoteCroes701);
           
         var FindNote= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes701), 10)
         if(FindNote.Exists && FindNote.VisibleOnScreen)
            Log.Checkpoint("La note est ajoutée pour la position "+positionsSymbolArrayCroes701[i]);
         else
            Log.Error("La note n'est pas ajoutée pour la position "+positionsSymbolArrayCroes701[i]);
           
         Get_WinPositionInfo_BtnCancel().Click(); 
         WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
      }          
      
      Log.Message("Cliquer sur le bouton  'Projection de liquidités' pour le déselectionné.");
      Get_PortfolioBar_BtnCashFlowProject().Click();    
      Get_PortfolioBar_BtnCashFlowProject().WaitProperty("IsChecked", false, 30000);       
      aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsChecked", cmpEqual, false);
      
      Log.PopLogFolder();
      
      //********************************** Étape 8 :  Validation d'insertion d'une note sur position a partir d'info sur une simulation sauvegardée **********************************/
      Log.AppendFolder("Étape 8: Croes-888 - Validation d'insertion d'une note sur position a partir d'info sur une simulation sauvegardée");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-888", "Cas de test TestLink: Croes-888");  
     //**********************************************************************************************************************************************************************/
      
      var positionNoteCROES888=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotCROES888", language+client);
      var NameAccountSimuCROES888=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "NameAccountSimuCROES888", language+client);
      var positionSymbolV90094 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PositionSymbolV90094", language+client)
      
      Log.Message("Cliquer sur le bouton  'Simulation'.");
      Get_PortfolioBar_BtnWhatIf().Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");        
        
      Log.Message("Cliquer le bouton sauvegarder.");
      Get_PortfolioBar_BtnSave().WaitProperty("IsEnabled", true, 30000);
      Get_PortfolioBar_BtnSave().Click();
      
      Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Click();
      Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(NameAccountSimuCROES888);
      Get_WinWhatIfSave_BtnOK().Click();
      Get_DlgInformation().Close();      
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
     
     Log.Message("Sélectionner la  position "+positionSymbolV90094+" Clic droit --> Ajouter une note");    
     Search_Position(positionSymbolV90094);             
     Get_Portfolio_AssetClassesGrid().FindChild("Value", positionSymbolV90094, 10).Click();
     Get_Portfolio_AssetClassesGrid().FindChild("Value", positionSymbolV90094, 10).ClickR(); 
     Get_PortfolioGrid_ContextualMenu_AddANote().Click();
     WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["NoteDetailWindow_2d5e", true]); 
      
     Log.Message("Ajouter heure &date, une note '"+positionNoteCROES888+"' puis sauvegarder");//J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
     WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
     Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("IsEnabled", true, 30000);
           
     Get_WinCRUANote_GrpNote_TxtNote().Click();
     Get_WinCRUANote_GrpNote_TxtNote().set_Text(positionNoteCROES888);
     Get_WinCRUANote_GrpNote_BtnDateTime().Click();
     var txtAddedNoteCroes888 = Get_WinCRUANote_GrpNote_TxtNote().Text;
      
     Get_WinCRUANote_BtnSave().WaitProperty("IsEnabled", true, 30000);
     Get_WinCRUANote_BtnSave().Click();
     WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");      
       
     Log.Message("Étape 9: Valider que la note '"+txtAddedNoteCroes888+"' est ajoutée pour la position "+positionSymbolV90094); 
     Get_Portfolio_AssetClassesGrid().FindChild("Value", positionSymbolV90094, 10).Click();
     Get_PortfolioBar_BtnInfo().Click();
     WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
     WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_dca0", true]);//attendre que le TabNotes soit visible
     Get_WinPositionInfo_TabNotes().Click();
     WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TabItem_fc72", true]);//attendre que le TabGrid soit visible
     Get_WinInfo_Notes_TabGrid().Click();
           
     // Les points de vérifications : la note a été bien ajouté
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, txtAddedNoteCroes888);
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, positionNoteCROES888);
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes888), 10).DataContext.DataItem,"Comment", cmpEqual, txtAddedNoteCroes888);
           
     var FindNote= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(txtAddedNoteCroes888), 10)
     if(FindNote.Exists && FindNote.VisibleOnScreen)
      Log.Checkpoint("La note est ajoutée.");
     else
      Log.Error("La note n'est pas ajoutée.");
           
     Get_WinPositionInfo_BtnCancel().Click(); 
     WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
       
     Log.PopLogFolder();    
     
    }
    catch(e){
       Log.Error("Exception: " + e.message, VarToStr(e.stack));        
    }
    finally{
      
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
  	  
      //Supprimer les notes créées
      Delete_Note(positionNoteCROES891, vServerPortefeuille);
      Delete_Note(positionNoteCROES894, vServerPortefeuille);
      Delete_Note(positionNoteCROES896, vServerPortefeuille);
      Delete_Note(positionNoteCROES701, vServerPortefeuille);
      Delete_Note(positionNoteCROES888, vServerPortefeuille);
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();         
      Runner.Stop(true)  
    
    }   
 }

 