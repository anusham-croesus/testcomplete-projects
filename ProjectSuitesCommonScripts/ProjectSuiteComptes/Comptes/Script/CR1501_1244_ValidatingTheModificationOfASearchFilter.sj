//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1244
   
         1-Choisir le module compte.: Le module compte est ouvert.
         2-Sélectionner un compte qui contient des notes:Le compte est sélectionné.
         3-Cliquer sur le bouton info.:La fenêtre info est ouverte.
         4-Cliquer filtre et choisir un filtre par exemple filter 'date de création'.:La liste des filtres s'ouvre correctement et la fenêtre 
         'Créer un filtre'  de 'Date de création' est ouverte.
         5-Choisir 'Égal(e) à' pour le champ 'Opérateur' ,saisir une valeur ensuite cliquer sur le bouton 'Appliquer':
         Les notes correspondant au filtre sont affichées.
         6-Cliquer sur le crayon du filtre pour le modifier.:La fenêtre de modification d'un filter est ouverte.
         7-Modifier le filtre ensuite cliquer sur 'Appliquer'.:
         La fenêtre de modification du filtre est fermée, le filtre est modifié ainsi que le résultat du filtre modifié est affiché.

            
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-Er-1--V9-croesus-co7x-1_4_546
*/


function CR1501_1244_ValidatingTheModificationOfASearchFilter()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1244");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberAccount800083=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "numberAccount800083", language+client);
         var CompTextAddNotTestCROES1244=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "CompTextAddNotTestCROES1244", language+client);
         var textphrasePredefiniCROES842=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1501", "textphrasePredefiniCROES842", language+client);
        
         Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
         //Choisir le module compte
         
         Get_ModulesBar_BtnAccounts().Click();
         SearchAccount(numberAccount800083);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
          //Ajouter une note au client 800300
          Get_AccountsBar_BtnInfo().Click();
          WaitObject(Get_CroesusApp(), "Uid", "Button_ddd2");
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(CompTextAddNotTestCROES1244);
          
         
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES842, 10).Click();
          Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          
           var textAjoutNoteCROES1244=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNoteCROES1244);
          Get_WinCRUANote_BtnSave().Click();
      
          Get_WinDetailedInfo_BtnCancel().Click()
          //Cliquer sur le bouton Info 
          Search_Account(numberAccount800083)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberAccount800083, 10).Click();
          //Ajouter une note au client 800300
           Get_AccountsBar_BtnInfo().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           
           Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
           Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
           Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreationDate().Click();
           Get_WinCreateFilter_CmbOperator().Click();
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
          
             var displaySenPredefCROES1244=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",textAjoutNoteCROES1244, 10)//.WPFControlText
           if(displaySenPredefCROES1244.Exists)
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
          var existenceNoteCreeAujour= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", textAjoutNoteCROES1244, 10).Exists;
           if(existenceNoteCreeAujour == true)
             {
                Log.Checkpoint("Les note créées aujourd'hui sont  affichées aprés avoir appliqué le filtre")
             }
           else {
                Log.Error("Les note créées aujourd'hui ne sont pas affichées aprés avoir appliqué le filtre") 
            } 
          
           Get_WinDetailedInfo_BtnCancel().Click()
          
           
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNoteCROES1244, vServerAccounts)
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNoteCROES1244, vServerAccounts)
       
        
    }
    
    
   
}
