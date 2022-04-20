//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1266

     Préconditions : 
     Se connecter avec COPERN
     Mettre la préférence PREF_ENABLE_REVIEW à 1
     
     1-Choisir le module relation.:Le module relation est ouvert
     2-Sélectionner une relation qui contient une note de révision.﻿:La relation est sélectionnée.
     3-Cliquer sur le bouton info:La fenêtre info est ouverte.
     4-Cliquer sur le bouton 'Ajouter':La fenêtre d'ajout d'une note est ouverte.
     5-Sélectionner l'heure & date, la phrase prédéfinie ensuite cliquer sauvegarder.:La note est ajoutée.
     6-Cliquer sur le bouton 'OK'.:La fenêtre info de la relation est fermée.
     7-Cliquer sur le bouton info de la relation.:La fenêtre info est ouverte
     8-Sélectionner la note crée précédemment.:La note est sélectionnée.
     9-Cliquer sur le bouton 'Modifier':La fenêtre de modification est ouverte.
     10-Côcher le case à côché 'Révision'.:La case à côché est cochée.
     11-Cliquer sur le bouton sauvegarder.:La fenêtre de modification est fermée.
     12-Cliquer sur le bouton OK.:La fenêtre info est fermée.
     13-Sélectionner la relation.:La date Dern.Révision et la date Proch.Révision sont recaluculé
     
     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1266_Rel_ValidateModificationOfAnExistingNoteToCheck_Revision()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1266");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
           
            var RelTextAddNotCROES1266=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1266", language+client);
            var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var frequencyCROES1266=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "frequencyCROES1266", language+client);
            var nameRelation1CROES1266=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1266", language+client);
            var RelTextAddNot1CROES1266=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNot1CROES1266", language+client);
            
              //Mettre la PREF_ENABLE_REVIEW a la valeur 1
         Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerRelations);
         RestartServices(vServerRelations);
            
           Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
         CreateRelationship(nameRelation1CROES1266)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1266, 10).Click(); 
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1266, 10).DblClick(); 
         //Ajout d'une note de révision 
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_ChkReview().Set_IsChecked(true);
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1266);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote)
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          
          WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000); 
          
         //Cliquer sur le bouton "Info"
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1266, 10).Click()
          Get_RelationshipsBar_BtnInfo().Click()
        
            //Ajout d'une note qui n'est pas de révision
         Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNot1CROES1266);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote1=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote1)
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          
          WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000); 
          
          //Cliquer sur le bouton info de la relation nameRelation1CROES1266
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1266, 10).Click()
          Get_RelationshipsBar_BtnInfo().Click()
        
          //Ajout d'une note qui n'est pas de révision
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote1), 10).Click();
          Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
          //Côcher le case à côché 'Révision'.
          Get_WinCRUANote_GrpNote_ChkReview().Set_IsChecked(true);
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          
          //Mettre la configuration par défaut
         Get_RelationshipsGrid_ChCurrency().ClickR(); 
         Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
          
            //Ajout de la colonne last review
              Get_RelationshipsGrid_ChCurrency().ClickR();
              Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
             
              if(Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_LastReview().Exists)
              {
              Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_LastReview().Click();
              }
              //Ajout de la colonne next review
    
               Get_RelationshipsGrid_ChCurrency().ClickR();
              Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
             
              if(Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_NextReview().Exists)
              {
              Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_NextReview().Click();
              }
              //Ajout de la colonne frequency
    
               Get_RelationshipsGrid_ChCurrency().ClickR();
               Get_RelationshipsGrid_ChCurrency().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               
              if(Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Frequency().Exists)
              {
              Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Frequency().Click();
              }
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1266, 10).Click()
         // les points de vérification
         var x=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1266, 10);
         Log.Message("Le nom de la relation est "+VarToString(nameRelation1CROES1266))
          var indice=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1266, 10).Record.Index;
          Log.Message(indice);
         
         
           var displaynextReviewDate =Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.NextReviewDate
          var displaylastReviewDate=VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewDate.Date)//ReviewDate
          var displayreviewfrequency=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewFrequencyDescription//ReviewFrequency
          
          var dateCreationWithYearCROES1266=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/%Y"))
      
          
          
          CheckEquals(displaynextReviewDate,null,"La date de la prochaine révision est ")//1/24/2020
          Log.Message("Si l'erreur est :Expecting '3/09/2021', got '3/9/2021', il faut adapter le script. Voir Sana ")
          CheckEquals(displaylastReviewDate,dateCreationWithYearCROES1266,"La date de la derniére révision est ")
          CheckEquals(displayreviewfrequency,frequencyCROES1266,"La fréquence est");
        
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1266)
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations);
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1266)
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations);
       
        
    }
    
}