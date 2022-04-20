//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-556
    Description :
       
            
                   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
*/

/*Ce script je peux pas l'automatiser parqu'il y a une anomalie au niveau des filtres : il y a pas le filtre par date de modification*/
function CR1501_556_Port_SearchByFilterByDateModifiedAndOperatorIsEqualTo()
{
    try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-556")
      
        //Les variables
        /*  var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800300", language+client);
          var positionDescripCROES556=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES556", language+client);
          var PortTextAddNotCROES556=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotCROES556", language+client);
          var descriptionFiltreNoteCROES556=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "descriptionFiltreNoteCROES556", language+client);
          var donesNotContaiNoteCROES556=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "donesNotContaiNoteCROES556", language+client);
          var PortTextAddNotTestCROES556=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES556", language+client);
          var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
  
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
           Search_PositionByDescription(positionDescripCROES556)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).DblClick();
         
         // Get_PortfolioBar_BtnInfo().Click();
          //Ajouter une note a une position  
          Get_WinPositionInfo_TabNotes().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotCROES556);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Delay(8000)
          Get_WinCRUANote_BtnSave().Click();
          
          
          Get_WinPositionInfo_TabNotes().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES556);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Delay(8000)
          Get_WinCRUANote_BtnSave().Click();
          
          Get_WinPositionInfo_BtnOK().Click();
          
          Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES556)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).DblClick();
         
          //Get_PortfolioBar_BtnInfo().Click();
          Get_WinPositionInfo_TabNotes().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          /*6- Cliquer sur filtre et choisir le filtre 'Note': La liste des filtres s'ouvre correctement et la fenêtre 'Créer un filtre'
            de 'Note' est ouverte.*/
           /* Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_Note().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCreateFilter_CmbOperator_ItemNotContaining().Click();
            Get_WinCreateFilter_TxtValue().Click();
            Get_WinCreateFilter_TxtValue().SetText(donesNotContaiNoteCROES556);
            Get_WinCreateFilter_BtnApply().Click();
           //Les points de vérification 
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, descriptionFiltreNoteCROES556);
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
        //Vérifier que la note qui contient le mot note est affichée
     /*   aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, PortTextAddNotCROES556);
        var displayNoteAfterFiltre=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10).WPFObject("XamTextEditor", "", 1)
        aqObject.CheckProperty(displayNoteAfterFiltre, "DisplayText", cmpEqual, PortTextAddNotCROES556);
        aqObject.CheckProperty(displayNoteAfterFiltre, "Enabled", cmpEqual, true);
        aqObject.CheckProperty(displayNoteAfterFiltre, "Exists", cmpEqual, true);
        aqObject.CheckProperty(displayNoteAfterFiltre, "VisibleOnScreen", cmpEqual, true);*/
        Log.Error("Je peux pas automatiser ce cas de test suite a l'anomalie: CROES-10858")
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
       /* Delete_Note(PortTextAddNotCROES556, vServerPortefeuille)
        Delete_Note(PortTextAddNotTestCROES556, vServerPortefeuille)*/
        Terminate_CroesusProcess();
    }
    finally {
   
        Terminate_CroesusProcess();
       /* Delete_Note(PortTextAddNotCROES556, vServerPortefeuille)
        Delete_Note(PortTextAddNotTestCROES556, vServerPortefeuille)*/
    }
}
