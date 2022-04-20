﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
            Préconditions:
            Se connecter avec "COPERN"

          https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1246
          Description :
         1-Choisir le module client.:  Le module client est ouvert.
         2-  Sélectionner un client:Le client est sélectionné.
         3-Mailler le client vers le module portefeuille.:Le module portefeuille est ouvert.
         4-Sélectionner une position qui contient des notes.:La position est sélectionnée.
         5-Cliquer sur le bouton info.:La fenêtre info est ouverte.
         6-Cliquer filtre et choisir un filtre par exemple filtre 'date de création'.:
          La liste des filtres s'ouvre correctement et la fenêtre 'Créer un filtre'  de 'Date de création' est ouverte.
         7-Choisir 'Égal(e) à' pour le champ 'Opérateur' ,saisir une valeur ensuite cliquer sur le bouton 'Appliquer':
          Les notes correspondant au filtre sont affichées.
         8-Cliquer sur le crayon du filtre pour le modifier.:La fenêtre de modification d'un filtre est ouverte.
         9-Modifier le filtre ensuite cliquer sur 'Appliquer'.:La fenêtre de modification du filtre est fermée, 
         le filtre est modifié ainsi que le résultat du filtre modifié est affiché.
                            
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1246_Port_ValidatingTheModificationOfSearchFilter()
{
    try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1246");
      
        //Les variables
          var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800300", language+client);
          var positionDescripCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES566", language+client);
          var PortTextAddNotCROES1246=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotCROES1246", language+client);
          var descriptionFiltreNoteCROES566=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "descriptionFiltreNoteCROES566", language+client);
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
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).DblClick();
         
         // Get_PortfolioBar_BtnInfo().Click();
          //Ajouter une note a une position  
          Get_WinPositionInfo_TabNotes().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotCROES1246);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Delay(8000)
          Get_WinCRUANote_BtnSave().Click();
          Get_WinPositionInfo_BtnOK().Click();
          
          Search_PositionByAccountNo(numberAccount800300NA)
           Search_PositionByDescription(positionDescripCROES566)
  
           Get_Portfolio_AssetClassesGrid().FindChild("IsActive", true, 10).DblClick();
         
  
          Get_WinPositionInfo_TabNotes().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          
            Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreationDate().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
           Get_WinCreateFilter_DtpValue().Click();
           Time1 = aqDateTime.Now();
           Time2 = aqDateTime.AddDays(Time1, 5);
               if(language == "french")
               {
  
               Get_WinCreateFilter_DtpValue().Keys(aqConvert.DateTimeToFormatStr(Time2, "%Y/%m/%d"))
               }
 
 
                if(language == "english")
               {
                 Get_WinCreateFilter_DtpValue().Keys(aqConvert.DateTimeToFormatStr(Time2, "%m/%d/%Y"))
               }
              Get_WinCreateFilter_BtnApply().Click();
               aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
         
          //Les points de vérifications
          
             var displaySenPredefCROES1244=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",PortTextAddNotCROES1246, 10)//.WPFControlText
           if(displaySenPredefCROES1244.Exists && displaySenPredefCROES1244.VisibleOnScreen)
           {
            Log.Error("La note ajoutée précédemment existe  parmi la liste des phrases prédéfinies aprés avoir appliqué le filtre ")
           }
           else 
           {
             Log.Checkpoint("La note ajoutée précédemment n'existe  parmi la liste des phrases prédéfinies aprés avoir appliqué le filtre ")
           }
          //   6-Cliquer sur le crayon du filtre pour le modifier.:La fenêtre de modification d'un filter est ouverte.
          var descriptionFilter=Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext.FilterDescription.OleValue
          Log.Message(descriptionFilter)
          Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription_BtnEditView(descriptionFilter).Click();
          
          Get_WinCreateFilter_CmbOperator().Click();
          Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
          Get_WinCreateFilter_DtpValue().Click();

          if(language == "french")
               {
  
               Get_WinCreateFilter_DtpValue().Keys(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"))
               }
 
 
          if(language == "english")
               {
                 Get_WinCreateFilter_DtpValue().Keys(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"))
               }
              Get_WinCreateFilter_BtnApply().Click();
               aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
          // les points de vérifications
          var existenceNoteCreeAujour= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotCROES1246, 10).Exists;
          var visiblNoteCreeAujour= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotCROES1246, 10).VisibleOnScreen;
           if(existenceNoteCreeAujour == true && visiblNoteCreeAujour== true)
             {
                Log.Checkpoint("Les note créées aujourd'hui sont  affichées aprés avoir appliqué le filtre")
             }
           else {
                Log.Error("Les note créées aujourd'hui ne sont pas affichées aprés avoir appliqué le filtre") 
            } 
           Get_WinPositionInfo_BtnOK().Click()
           
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Delete_Note(PortTextAddNotCROES1246, vServerPortefeuille)
       
        Terminate_CroesusProcess();
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotCROES1246, vServerPortefeuille)
        
    }
}

