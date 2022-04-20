//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1264

     Préconditions : 
     Se connecter avec COPERN
     Mettre la préférence PREF_ENABLE_REVIEW à 1
     
     1-Choisir le module relation.:Le module relation s'ouvre correctement.
     2-Sélectionner une relation qui contient une note de révision.:
     La relation est sélectionnée.
     3-Cliquer sur le bouton 'Info'.:La fenêtre d'info est ouverte.
     4-Choisir pour le champ fréquence le choix 'Annuellement'.:La fréquence est à 'Annuellement'
     5-Cliquer sur le bouton 'Ajouter ':La fenêtre d'ajout d'une note est ouverte.
     6-Côcher la case à côché 'Révision':
     La case à côché est côchée.
     7-Sélectionner l'heure & date, la phrase prédéfinie ensuite cliquer sauvegarder.:
     La note de révision est ajoutée.
     8-Cliquer sur le bouton 'OK'.:
     La fenêtre info de la relation est fermée.
     9-Sélectionner la relation.:La date Dern.révision est égale à la date de création de
     la note et la date de Proch.révision est égale à la date création +une année.
     10-Cliquer sur le bouton 'Info':La fenêtre info est ouverte.
     11-Supprimer la note de révision crée précédemment.:
     La note de révision est supprimée  et la date du dernier révision et prochaine révision sont recalculé .

    
     
     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1264_Rel_ValidatingTheDeletionOfRevisionNote()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1264");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
           
            var RelTextAddNotCROES1264=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1264", language+client);
            var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var frequencyCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "frequencyCROES1344", language+client);
            var nameRelation1CROES1264=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1264", language+client);
            var RelTextAddNotNormalCROES1264=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotNormalCROES1264", language+client);
           
           
            
              //Mettre la PREF_ENABLE_REVIEW a la valeur 1
         Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerRelations);
         RestartServices(vServerRelations);
            
           Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
         CreateRelationship(nameRelation1CROES1264)
         // Ajouter une note a la relation : nameRelation1CROES1264
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).DblClick(); 
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinDetailedInfo_TabInfo().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
           
            Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
            
            
            Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
             Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotNormalCROES1264);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNoteNomrmal=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNoteNomrmal)
          Get_WinCRUANote_BtnSave().Click();
          Get_WinDetailedInfo_BtnOK().Click();
       
          WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000);  
             //  Changer la fréquence a la relation
      
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).DblClick(); 
         Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10).Click()//SA: j'ai pas utilisé la fonction get parce que la propriété WPFcontrolNO change d'un utilisateur a un autre Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency()
         Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency_ItemAnnual().Click();
          Get_WinDetailedInfo_BtnApply().Click();
         // ajout d'une note de révision a partir du bouton add
         Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_ChkReview().Set_IsChecked(true);
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1264);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote)
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
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).Click()
       
         // les points de vérification
         var x=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10);
         Log.Message("Le nom de la relation est "+VarToString(nameRelation1CROES1264))
          var indice=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).Record.Index;
          Log.Message(indice);
         
         
           var displaynextReviewDate =VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.NextReviewDate.Date)
          var displaylastReviewDate=VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewDate.Date)//ReviewDate
          var displayreviewfrequency=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewFrequencyDescription//ReviewFrequency
          
            
          var date = new Date(aqDateTime.Now())
          var yearAddOneYear=VarToString(date.getFullYear()+1)
          var dateCreationCROES1264=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/"))
          var dateCreationWithYearCROES1264=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/%Y"))
          var DateNowAddYear=aqString.Concat(dateCreationCROES1264, yearAddOneYear)
          Log.Message(DateNowAddYear)
          Log.Message("Si l'erreur est :Expecting '3/09/2021', got '3/9/2021', il faut adapter le script. Voir Sana ")
          
          CheckEquals(displaynextReviewDate,DateNowAddYear,"La date de la prochaine révision est ")//1/24/2020
          CheckEquals(displaylastReviewDate,dateCreationWithYearCROES1264,"La date de la derniére révision est ")
          CheckEquals(displayreviewfrequency,frequencyCROES1344,"La fréquence est");
        //Vérification des deux dates pour 
        var indiceLineSelected=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).Record.Index;
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).Click(); 
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo", "IsSelected"], ["DataRecordPresenter", indiceLineSelected, true]);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).DblClick(); 
        
        
        Get_WinDetailedInfo_TabInfo().Click();
        Get_WinInfo_Notes_TabGrid().Click();
          // Les points de vérifications : la note a été bien ajouté
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, RelTextAddNotCROES1264);
            var textNotCROES1264= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES1264.Exists;
            Log.Message(x);
          if(textNotCROES1264.Exists && textNotCROES1264.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["UniButton","OK"]);
            SearchRelationshipByName(nameRelation1CROES1264)
           /* 11-Supprimer la note de révision crée précédemment.:
         La note de révision est supprimée  et la date du dernier révision et prochaine révision sont recalculé .*/
     //Vérification des deux dates pour 
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).DblClick(); 
        Get_WinDetailedInfo_TabInfo().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        // clic sur le bouton delete pour supprimer la note
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", textAjoutNote, 10).Click(); 
        Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
        Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        //Click sur le bouton delete de la fenêtre de confirmation
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);  
        //click sur le bouton OK de la fenêtre info
         Get_WinDetailedInfo_BtnOK().Click();
         WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["UniButton","OK"]);
        /*Les points de vérifications:Dans ce cas dern.révision 
         = vide et Prochaine révision = [date de création de la relation] + fréquence =  [date de création de la relation] + 1 an*/
         
         SearchRelationshipByName(nameRelation1CROES1264)
         
          var x=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10);
         Log.Message("Le nom de la relation est "+VarToString(nameRelation1CROES1264))
          var indice=Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1264, 10).Record.Index;
          Log.Message(indice);
         
         
           var displaynextReviewDate =VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.NextReviewDate.Date)
          var displaylastReviewDate=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewDate
          var displayreviewfrequency=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewFrequencyDescription
          
            
          var date = new Date(aqDateTime.Now())
          var yearAddOneYear=VarToString(date.getFullYear()+1)
          var dateCreationCROES1264=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/"))
         
          var DateNowAddYear=aqString.Concat(dateCreationCROES1264, yearAddOneYear)
          Log.Message(DateNowAddYear)
          Log.Message("Si l'erreur est un zéro retranché Ex.: Expecting '3/09/2021', got '3/9/2021', adapter pour retancher le zéro. %m/%d/ vs #%m/%d/")
          
          CheckEquals(displaynextReviewDate,DateNowAddYear,"La date de la prochaine révision est ")//1/24/2020
          CheckEquals(displaylastReviewDate,null,"La date de la dernière révision est ")
          CheckEquals(displayreviewfrequency,frequencyCROES1344,"La fréquence est")
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1264)
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations);
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1264)
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations);
       
        
    }
    
}