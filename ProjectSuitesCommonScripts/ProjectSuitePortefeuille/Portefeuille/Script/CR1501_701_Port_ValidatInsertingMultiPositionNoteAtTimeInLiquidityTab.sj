//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-701
    
   
    Description :
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Cliquer sur le bouton 'Projections des liquidités ':Les projections de liquidités est affiché.
         5-Sélectionner plusieurs lignes, 6 par exemple.:Les 6 lignes sont bien sélectionnées.
         6-Faire un right-click et choisir l'option 'Ajouter une note'.:L'option 'Ajouter une note' est disponible et la fenêtre 'Ajouter une note a 6 positions' est affichée.
         7-Côcher le choix '6 positions sélectionnés'.:Le choix '6 positions sélectionnés' est bien côché.
         8.Ajouter 'heure & date',  une phrase prédéfinie ensuite cliquer sur le bouton sauvegarder.:La phrase prédéfinie et ''heure & date ' sont insérés correctemet.
         La fenêtre 'ajouter une note à 6 position' est fermée.
         9-Ouvrir la fenêtre info de chaque position (6 sélectionnés précédemment) ensuite sélectionner l'onglet note.:La note est bien ajoutée sur chaque position.
                   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_701_Port_ValidatInsertingMultiPositionNoteAtTimeInLiquidityTab()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-701");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
          
          var PortTextAddNotTestCROES701=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES701", language+client);
          
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
           
           Get_PortfolioBar_BtnCashFlowProject().Click();
           aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsChecked", cmpEqual, true);
          
          var arrayContentOfDescription = new Array();
          
            for(i = 0; i < 6; i++){
              firstRowDescription = VarToStr(Get_Portfolio_ProjLiquiditesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription);
            
            arrayContentOfDescription.push(firstRowDescription);
            Log.Message(arrayContentOfDescription[i])
            
           
          }
          // sélectionner les 6 premiers positions
          
           Get_Portfolio_ProjLiquiditesGrid().FindChild("Value", arrayContentOfDescription[0], 10).Click();
           //Maintenir la touche SHIFT enfoncée
           Sys.Desktop.KeyDown(0x10);
           
           //Sélectionner le 6 éme élmenet 
          Get_Portfolio_ProjLiquiditesGrid().FindChild("Value", arrayContentOfDescription[5], 10).Click(); 
           //Relâcher la touche Shift
           Sys.Desktop.KeyUp(0x10);
           Get_Portfolio_ProjLiquiditesGrid().FindChild("Value", arrayContentOfDescription[5], 10).ClickR(); 
           Get_PortfolioGrid_ContextualMenu_AddANote().Click();
            
            //Ajouter une note. J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
            Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
            Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
            Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
             Get_ModulesBar_BtnPortfolio().WaitProperty("IsEnabled", true, 30000);
          // WaitObject(Get_WinCRUANote(), ["UID", "IsLoaded","IsEnabled"], ["Button_4da0", true,true]);
           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES701);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNote)
          Get_WinCRUANote_BtnSave().Click();
              
            var numberOftries=0;  
        while ( numberOftries < 5 && Get_WinCRUANote().Exists){
           Get_WinCRUANote_BtnSave().Click();
          numberOftries++;
           } 
           
       for(n = 0; n < 6; n++)
        {
        Get_Portfolio_ProjLiquiditesGrid().FindChild("Value", arrayContentOfDescription[n], 10).DblClick(); 
        Get_WinPositionInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotTestCROES701);
            var textNotCROES701= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES701.Exists;
            Log.Message(x);
          if(textNotCROES701.Exists && textNotCROES701.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
            Get_WinPositionInfo_BtnCancel().Click();
        }
         
         
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNote, vServerPortefeuille)
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNote, vServerPortefeuille)
        
    }
}
