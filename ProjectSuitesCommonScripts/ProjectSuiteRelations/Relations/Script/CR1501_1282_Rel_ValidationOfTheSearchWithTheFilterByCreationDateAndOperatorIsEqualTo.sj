//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1282

     Préconditions : 
    -Se connecter avec 'COPERN
     
     1-Choisir le module relation:Le module relation s'ouvre correctement.
     2-Sélectionner une relation qui contient des notes.:La relation est bien sélectionnée.
     3-Cliquer sur le bouton 'Info':La fenêtre info de la relation sélectionnée est ouverte.
     4-Cliquer sur filtre et choisir le filtre 'date de création':La liste des filtres s'ouvre correctement
      et la fenêtre 'Créer un filtre'  de 'Date de création' est ouverte.
     5-Choisir 'Égal(e) à' pour le champ 'Opérateur' ,saisir une valeur ensuite cliquer sur le bouton 'Appliquer':
     Les notes correspondant au filtre sont affichées.
     
     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1282_Rel_ValidationOfTheSearchWithTheFilterByCreationDateAndOperatorIsEqualTo()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1282");
    
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
         //Les variables
           
            var RelTextAddNotCROES1282=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1282", language+client);
            var textphrasePredefiniCROES1344=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var nameRelation1CROES1282=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1282", language+client);
            var IACodeCROES1275=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
            var descriptionFiltreCreatioDateCROES1282=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "descriptionFiltreCreatioDateCROES1282", language+client);
          
            
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_NOTE_DELETE","YES",vServerRelations);
            RestartServices(vServerRelations);
          
            
          Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
          //Choisir le module relation
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
         CreateRelationship(nameRelation1CROES1282,IACodeCROES1275)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1282, 10).Click();
         Get_RelationshipsBar_BtnInfo().Click()
         Get_WinDetailedInfo_TabInfo().Click();
         Get_WinInfo_Notes_TabGrid().Click(); 
         //Ajout d'une note
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1282);
          Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
          Log.Message(textAjoutNote)
          Get_WinCRUANote_BtnSave().Click();
          
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, RelTextAddNotCROES1282);
            var textNotCROES1282= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
            var x=textNotCROES1282.Exists;
            Log.Message(x);
          if(textNotCROES1282.Exists && textNotCROES1282.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
          Get_WinDetailedInfo_BtnOK().Click();
          
          WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1282, 10).Click();
          Get_RelationshipsBar_BtnInfo().Click()
          Get_WinDetailedInfo_TabInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click(); 
          //Cliquer sur filtre et choisir le filtre 'date de création'
             if(language == "french")
            {
            var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")
            }
            if(language == "english")
            {
              var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y")
            }
            
            var  ExistenceResultatFiltreOnGrill=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Text",ToDay,10)
          
            Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreationDate().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
            Get_WinCreateFilter_DtpValue().Click();
            Get_WinCreateFilter_DtpValue().Keys(ToDay);
            Get_WinCreateFilter_BtnApply().Click();
			    
            var displayFiltrecreation=aqString.Concat(descriptionFiltreCreatioDateCROES1282, ToDay)
            
           //Les points de vérification 
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, displayFiltrecreation);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
		
            //Vérifier que les notes dont la date de création est aujourd'hui ne sont pas affichées
          
           if(ExistenceResultatFiltreOnGrill.Exists)  {
                  Log.Checkpoint("Le résultat du filtre est correct")
                }
                else
                {
                 Log.Error("Le résultat du filtre n'est pas correct") 
                }

            Get_WinDetailedInfo_BtnOK().Click();
               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1282)
        Terminate_CroesusProcess();
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1282)
        Terminate_CroesusProcess();
           
}
    
}
