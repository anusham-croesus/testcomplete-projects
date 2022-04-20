//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    Ce script regroupe les 4 scripts:

         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1264
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1265
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1266
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1268
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1344
    
    regroupé par: A.A   
    Version de scriptage:	ref90-20-12
*/

function CR1501_1264_1265_1266_1268_1344_Combinated()
{
    try {
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1344");
    
            userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
            passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
            userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
            //Les variables
           
            var RelTextAddNotCROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1344", language+client);
            var textphrasePredefiniCROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
            var frequencyCROES1344     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "frequencyCROES1344", language+client);
            var nameRelation1CROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1344", language+client);
            var nameRelation2CROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation2CROES1344", language+client);
            var nameRelation3CROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation3CROES1344", language+client);
            var nameRelation4CROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation4CROES1344", language+client);
            var nameRelation5CROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation5CROES1344", language+client);
            var nameRelation6CROES1344 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation6CROES1344", language+client);
                          
            
            //Mettre la PREF_ENABLE_REVIEW a la valeur 1
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerRelations);
            Activate_Inactivate_Pref(userNameDALTOJ, "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerRelations);
            RestartServices(vServerRelations);
          
            Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
            //Choisir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
           
            var arrayRelationshipSelecte = new Array(nameRelation1CROES1344,nameRelation2CROES1344,nameRelation3CROES1344,nameRelation4CROES1344,nameRelation5CROES1344,nameRelation6CROES1344);
          
            for(i = 0; i < 6; i++){
                CreateRelationship(arrayRelationshipSelecte[i])
                Log.Message(arrayRelationshipSelecte[i])
            }
            //  Changer la fréquence de 6 relations a annuelle
            for(n = 0; n < 6; n++){
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayRelationshipSelecte[n], 10).Click();
                Get_RelationshipsBar_BtnInfo().Click(); 
                WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Info"]);
                Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10).Click()//SA: j'ai aps utilisé la fonction get parce que la propriété WPFcontrolNO change d'un utilisateur a un autre Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency()
                Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency_ItemAnnual().Click();
                Get_WinDetailedInfo_BtnOK().Click();     
                WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000);
            }
         
            SelectRelationships(arrayRelationshipSelecte);
            
            // 3-Faire un right-click et choisir 'ajouter une note.':La fenêtre d'ajout de note est ouverte.
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayRelationshipSelecte[5], 10).ClickR(); 
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         
            //Ajouter une note. J'ai pas ajouter une phrase prédéfinie parce qu'on a pas de phrase prédéfinie sur ce dump
            Get_WinCRUANote_GrpNote_RdoSelectedPositions().Set_IsChecked(true);
            Get_WinCRUANote_GrpNote_ChkReview().Set_IsChecked(true);
            Get_WinCRUANote().WaitProperty("Enabled", true, 30000);
            Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
          
            Get_WinCRUANote_GrpNote_TxtNote().Click()
            Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1344);
            Get_WinCRUANote_GrpNote_BtnDateTime().Click();
          
            Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
            Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
            WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
            var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text;
            Log.Message(textAjoutNote)
            Get_WinCRUANote_BtnSave().Click();
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            
            //Ajout de la colonne last review
            Get_RelationshipsGrid_ChCurrency().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
             
            if(Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_LastReview().Exists){
                Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_LastReview().Click();
            }
            //Ajout de la colonne next review    
            Get_RelationshipsGrid_ChCurrency().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
             
            if(Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_NextReview().Exists){
                Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_NextReview().Click();
            }
            //Ajout de la colonne frequency
            Get_RelationshipsGrid_ChCurrency().ClickR();
            Get_RelationshipsGrid_ChCurrency().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
  
            if(Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Frequency().Exists){
                Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Frequency().Click();
            }
            
            //Chercher la premiére relation pour qu'elle devien visible 
            SearchRelationshipByName(arrayRelationshipSelecte[0]);
            for(n = 0; n < 6; n++)
            {
                var x=Get_RelationshipsClientsAccountsGrid().FindChild("Value", VarToString(arrayRelationshipSelecte[n]), 10);
                Log.Message("Le nom de la relation est "+VarToString(arrayRelationshipSelecte[n]))
                var indice=Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayRelationshipSelecte[n], 10).Record.Index;
                Log.Message(indice);
                var displaynextReviewDate =VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.NextReviewDate.Date)
                var displaylastReviewDate=VarToString(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewDate.Date)//ReviewDate
                var displayreviewfrequency=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(indice).DataItem.ReviewFrequencyDescription//ReviewFrequency
          
            
                var date = new Date(aqDateTime.Now())
                var yearAddOneYear=VarToString(date.getFullYear()+1)
                var dateCreationCROES1344=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/"))
                var dateCreationWithYearCROES1344=VarToString(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/%Y"))
                var DateNowAddYear=aqString.Concat(dateCreationCROES1344, yearAddOneYear)
                Log.Message(DateNowAddYear)
                Log.Message("Si l'erreur est :Expecting '3/09/2021', got '3/9/2021', il faut adapter le script. Voir Sana ")
          
                CheckEquals(displaynextReviewDate,DateNowAddYear,"La date de la prochaine révision est ")//1/24/2020
                CheckEquals(displaylastReviewDate,dateCreationWithYearCROES1344,"La date de la derniére révision est ")
                CheckEquals(displayreviewfrequency,frequencyCROES1344,"La fréquence est")
                //Vérification des deux dates pour 
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayRelationshipSelecte[n], 10).Click(); 
                Get_RelationshipsBar_BtnInfo().Click();
                WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Info"]);
                Get_WinDetailedInfo_TabInfo().Click();
                Get_WinInfo_Notes_TabGrid().Click();
                // Les points de vérifications : la note a été bien ajouté
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, RelTextAddNotCROES1344);
                var textNotCROES1344= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10)
                var x=textNotCROES1344.Exists;
                Log.Message(x);
                if(textNotCROES1344.Exists && textNotCROES1344.VisibleOnScreen){
                    Log.Checkpoint("La note est ajoutée")
                }
                else{
                    Log.Error("La note n'est pas ajoutée")
                }
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000);
                WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            }
            
            
            //Modifier la note à non révision
            SearchRelationshipByName(arrayRelationshipSelecte[0]);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayRelationshipSelecte[0], 10).Click();
            Get_RelationshipsBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Info"]);
            Get_WinDetailedInfo_TabInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
            Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
            //Décôcher la case 'Révision'.
            Get_WinCRUANote_GrpNote_ChkReview().Set_IsChecked(false);
            Get_WinCRUANote_BtnSave().Click();
            
            //Click sur le bouton delete de la fenêtre de confirmation
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
            Get_WinDetailedInfo_BtnOK().Click();
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            
            // Supprimer la note de révision pour la 1ere relation
            SearchRelationshipByName(arrayRelationshipSelecte[0]);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayRelationshipSelecte[0], 10).Click();
            Get_RelationshipsBar_BtnInfo().Click(); 
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Info"]);
            Get_WinDetailedInfo_TabInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            
            // clic sur le bouton delete pour supprimer la note
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
            Delay(5000);
            Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
//            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
            
            //Click sur le bouton delete de la fenêtre de confirmation
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); 
            
            //Valider la supppression
            if(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Exists)
                Log.Error("La note n'est pas supprimée!"); 
            
            Get_WinDetailedInfo_BtnOK().Click();
            
            //Supprimer les relations
            for(i = 0; i < 6; i++)
                DeleteRelationship(arrayRelationshipSelecte[i]); 
            
            Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
    }
    finally {
        Terminate_CroesusProcess();   
    }
}