//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
   https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-896
   Préconditions: Se connecter avec KEYNEJ
    
   
    Description :
    1-Choisir le module compte.﻿:Le module compte s'ouvre correctement.
    2-Sélectionner le compte '800285-RE' (un compte qui détient des paniers).:Le compte est bien sélectionné.
    3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
    4-Cliquer sur le bouton 'Par panier':La fenêtre de regroupement par panier est affichée.
    5-Sélectionner 6 positions.:Les positions sont sélectionnées.
    6-Faire un right-click ensuite choisir l'option 'Ajouter une note'.:La fenêtre d'ajout d'une note est ouverte.
    7-Côcher le choix '6 positions'.:Le choix '6 positions' est côché.
    8-Ajouter 'heure & date',  une phrase prédéfinie ensuite cliquer sur le bouton sauvegarder.:La phrase prédéfinie et ''heure & date '
     sont insérés correctemet.La fenêtre 'ajouter une note à 6 position' est fermée.
    9-Ouvrir la fenêtre info de chaque position (6 sélectionnés précédemment) ensuite sélectionner l'onglet note.:
    La note est bien ajoutée sur chaque position.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_896_Port_ValidationOfInsertionOfANoteOnSeveralPositionsForGroupingByBasket()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-896");
    
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         //Les variables
            var numberAccount800285RE=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800285RE", language+client);
            var PortTextAddNotCROES896=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotCROES896", language+client);
            var positionDescripCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
          
          Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
          //Choisir le module compte
          Get_ModulesBar_BtnAccounts().Click()
          
          //Sélectionner le compte 800285-RE
          Search_Account(numberAccount800285RE)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800285RE, 10).Click();
          
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
           Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           
           Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket().Click();
           
           aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsChecked", cmpEqual, true);

           
             var arrayContentOfDescription = new Array();
          
            for(i = 0; i < 6; i++){
              firstRowDescription = VarToStr(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription);
            
            arrayContentOfDescription.push(firstRowDescription);
            Log.Message(arrayContentOfDescription[i])
            
           
          }
          // sélectionner les 6 premiers positions
          
           Get_Portfolio_AssetClassesGrid().FindChild("Value", arrayContentOfDescription[0], 10).Click();
           //Maintenir la touche SHIFT enfoncée
           Sys.Desktop.KeyDown(0x10);
           
           //Sélectionner le 6 éme élmenet 
          Get_Portfolio_AssetClassesGrid().FindChild("Value", arrayContentOfDescription[5], 10).Click(); 
           //Relâcher la touche Shift
           Sys.Desktop.KeyUp(0x10);
           Get_Portfolio_AssetClassesGrid().FindChild("Value", arrayContentOfDescription[5], 10).ClickR(); 
           Get_PortfolioGrid_ContextualMenu_AddANote().Click();
            
            //Ajouter une note. J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
            Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
            Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
            Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
             Get_ModulesBar_BtnPortfolio().WaitProperty("IsEnabled", true, 30000);
          // WaitObject(Get_WinCRUANote(), ["UID", "IsLoaded","IsEnabled"], ["Button_4da0", true,true]);
           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotCROES896);
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
        Get_Portfolio_AssetClassesGrid().FindChild("Value", arrayContentOfDescription[n], 10).DblClick(); 
        Get_WinPositionInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, PortTextAddNotCROES896);
            var textNotCROES896= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES896.Exists;
            Log.Message(x);
          if(textNotCROES896.Exists && textNotCROES896.VisibleOnScreen)
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
        Delete_Note(PortTextAddNotCROES896, vServerPortefeuille)
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotCROES896, vServerPortefeuille)
        
    }
}
