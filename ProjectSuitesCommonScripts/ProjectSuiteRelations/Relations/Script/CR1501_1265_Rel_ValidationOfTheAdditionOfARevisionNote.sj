//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1265

     Préconditions : 
     Se connecter avec COPERN
     Mettre la préférence PREF_ENABLE_REVIEW à 1
     1-Choisir le module relation:Le module relation est ouvert
     2-Sélectionner une relation qui contient une note de révision.:La relation est sélectionnée.
     3-Cliquer sur le bouton 'Info'.:La fenêtre d'info est ouverte.
     4-Choisir pour le champ fréquence le choix 'Annuellement'.:La fréquence est à 'Annuellement'
     5-Cliquer sur le bouton 'Ajouter '﻿:La fenêtre d'ajout d'une note est ouverte.
     6-Côcher la case à côché 'Révision':La case à côché est côché.
     7-Sélectionner l'heure & date, la phrase prédéfinie ensuite cliquer sauvegarder.:La note de révision est ajoutée.
     8-Cliquer sur le bouton OK.:La fenêtre info est fermée.
     9-Sélectionner la relation.:La date derniére révision et la date de prochaine révision sont calculé.


     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1265_Rel_ValidationOfTheAdditionOfARevisionNote()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1265");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
           
            var RelTextAddNotCROES1265=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1265", language+client);
            var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var frequencyCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "frequencyCROES1344", language+client);
            var nameRelation1CROES1265=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1265", language+client);
            var RelTextAddNot1CROES1265=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNot1CROES1265", language+client);
           
           
            
              //Mettre la PREF_ENABLE_REVIEW a la valeur 1
         Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerRelations);
         RestartServices(vServerRelations);
            
           Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
         CreateRelationship(nameRelation1CROES1265)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1265, 10).Click(); 
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1265, 10).DblClick(); 
         //Ajout d'une note de révision 
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_ChkReview().Set_IsChecked(true);
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1265);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote)
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          
          WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000); //
          
         //Cliquer sur le bouton "Info"
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1265, 10).Click()
          Get_RelationshipsBar_BtnInfo().Click()
          //Changer la férquence a annuelle
         Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10).Click()//SA: j'ai pas utilisé la fonction get parce que la propriété WPFcontrolNO change d'un utilisateur a un autre Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency()
         Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency_ItemAnnual().Click();
          Get_WinDetailedInfo_BtnApply().Click();
          
            //Ajout de l deuxiéme note de révision a partir du bouton add
         Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_ChkReview().Set_IsChecked(true);
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNot1CROES1265);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote1=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote1)
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
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1265, 10).Click()
         // les points de vérification
         var x=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1265, 10);
         Log.Message("Le nom de la relation est "+VarToString(nameRelation1CROES1265))
          var indice=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1265, 10).Record.Index;
          Log.Message(indice);
         
         
           var displaynextReviewDate =VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.NextReviewDate.Date)
          var displaylastReviewDate=VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewDate.Date)//ReviewDate
          var displayreviewfrequency=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewFrequencyDescription//ReviewFrequency
          
            
          var date = new Date(aqDateTime.Now())
          var yearAddOneYear=VarToString(date.getFullYear()+1)
          var dateCreationCROES1265=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/"))
          var dateCreationWithYearCROES1265=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/%Y"))
          var DateNowAddYear=aqString.Concat(dateCreationCROES1265, yearAddOneYear)
          Log.Message(DateNowAddYear)
          Log.Message("Si l'erreur est :Expecting '3/09/2021', got '3/9/2021', il faut adapter le script. Voir Sana ")
          
          CheckEquals(displaynextReviewDate,DateNowAddYear,"La date de la prochaine révision est ")//1/24/2020
          CheckEquals(displaylastReviewDate,dateCreationWithYearCROES1265,"La date de la derniére révision est ")
          CheckEquals(displayreviewfrequency,frequencyCROES1344,"La fréquence est");
        
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1265)
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations);
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1265)
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations);
       
        
    }
    
}