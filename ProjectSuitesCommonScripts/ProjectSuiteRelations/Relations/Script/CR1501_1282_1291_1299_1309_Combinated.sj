//USEUNIT Clients_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1501_1275_1276_1277_1278_1280_1319_1325_Combinated

/**
    Ce script regroupe les 4 scripts:

         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1282
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1291
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1299
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1309
    
    regroupé par: A.A   
    Version de scriptage:	ref90-20-12
*/


function CR1501_1282_1291_1299_1309_Combinated()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1282");
    
            userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
            passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
            userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
            
            //Variables pour note
            var noteText_CR1501        = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_NoteText", language+client);
            var relationshipName       = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_RelationshipName", language+client);
            var notePredefinedSentence = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_NotePredefinedSentence", language+client);
            var IACode                 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
                        
            var filter_CreationDate     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_Filter_CreationDate", language+client);            
            var filter_ModificationDate = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_Filter_ModificationDate", language+client);
            var filter_CallBackOn       = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_Filter_CallBackOn", language+client);
            var filter_CreatedBy        = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_Filter_CreatedBy", language+client);
           
            Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);

            var Today = aqConvert.DateTimeToFormatStr(aqDateTime.ToDay(), "%Y/%m/%d");           
            if(language == "english")
                    Today = aqConvert.DateTimeToFormatStr(aqDateTime.ToDay(), "%m/%d/%Y");

            //Choisir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            
            //Création de la relation
            CreateRelationship(relationshipName, IACode);
            
            //Ajout d'une note
            var textAjoutNote = AddNoteToRelationship(relationshipName , noteText_CR1501, notePredefinedSentence);
       
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"],3000);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
            Get_RelationshipsBar_BtnInfo().Click()
            Get_WinDetailedInfo_TabInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click(); 
          
           //---------------------------------------- Script 1282 filtrer par la date de création égale à

            //Ajouter un filtre 'Date de création'
            Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreationDate().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
            Get_WinCreateFilter_DtpValue().Click();
            Get_WinCreateFilter_DtpValue().Keys(Today);
            Get_WinCreateFilter_BtnApply().Click();
            
            //Les points de vérification 
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter_CreationDate + Today);
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); 
		
            //Vérifier que les notes dont la date de création est aujourd'hui ne sont pas affichées
            var  ExistenceResultatFiltreOnGrill = Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Text",Today,10);
            if(ExistenceResultatFiltreOnGrill.Exists)
                Log.Checkpoint("Le résultat du filtre est correct");
            else
                Log.Error("Le résultat du filtre n'est pas correct");

            //Fermer le filtre
            Get_WinDetailedInfo_ToggleButton(1).WPFObject("Button", "", 2).Click();
          
            //--------------------------------------------- Script 1291 filtrer par la date de modification
            //Modifier la note
            Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",textAjoutNote,10).Click();
            Get_WinInfo_Notes_TabGrid_BtnEdit().Click();  
            WaitObject(Get_CroesusApp(), "Uid", "NoteDetailWindow_2d5e", 25000);    
            Get_WinCRUANote_BtnSave().Click();
        
            //Ajouter un filtre note/ne contenant pas
            Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_ModificationDate().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCRUFilter_CmbOperator_ItemIsPriorTo().Click();
            Get_WinCreateFilter_DtpValue().Click();
            Get_WinCreateFilter_DtpValue().Keys(Today);
            Get_WinCreateFilter_BtnApply().Click();
            
            //Les points de vérification 
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter_ModificationDate + Today);
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1);
        
            //Vérifier que la note qui contient le mot note est affichée
            var  ExistenceResultatFiltreOnGrill = Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",textAjoutNote,10)
            if(ExistenceResultatFiltreOnGrill.Exists)
                Log.Error("Le résultat du filtre n'est pas correct"); 
            else
                Log.Checkpoint("Le résultat du filtre est correct");
           
            //Fermer le filtre
            Get_WinDetailedInfo_ToggleButton(1).WPFObject("Button", "", 2).Click();
           
            //---------------------------------------------------- Script 1299 filtrer par note/ne contenant pas           
            //Ajouter un filtre 'Date de création'
            Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_Note().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCreateFilter_CmbOperator_ItemNotContaining().Click();
            Get_WinCreateFilter_TxtValue().Click();
            Get_WinCreateFilter_TxtValue().Keys(filter_CallBackOn);
            Get_WinCreateFilter_BtnApply().Click();
            
            //Les points de vérification 
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, "Note <> " + filter_CallBackOn);
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); 
            //Vérifier que la note qui contient le mot note est affichée
            var  ExistenceResultatFiltreOnGrill = Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", textAjoutNote, 10)
            if(ExistenceResultatFiltreOnGrill.Exists)
                Log.Checkpoint("Le résultat du filtre est correct");
            else
                Log.Error("Le résultat du filtre n'est pas correct");
            //Fermer le filtre
            Get_WinDetailedInfo_ToggleButton(1).WPFObject("Button", "", 2).Click();  
          
            //---------------------------------------------------- Script 1309 filtrer par crée par/parmi 'copern'         
            //Ajouter un filtre 'Date de création'
            Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10);
            Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreatedBy().Click()
            Get_WinCreateFilter_CmbOperator().Click()
            Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
            Get_WinCreateFilter().Find("WPFControlText", "Nicolas Copernic", 10).Click();
            Get_WinCreateFilter_BtnApply().Click();
            
            //Les points de vérification 
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter_CreatedBy);
            aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1);
              
            //Vérifier que la note qui contient le mot note est affichée
            var  ExistenceResultatFiltreOnGrill = Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value", textAjoutNote, 10);
            if(ExistenceResultatFiltreOnGrill.Exists)
                Log.Error("Le résultat du filtre n'est pas correct");
            else
               Log.Checkpoint("Le résultat du filtre est correct"); 

            //Fermer le filtre
            Get_WinDetailedInfo_ToggleButton(1).WPFObject("Button", "", 2).Click();             
            Get_WinDetailedInfo_BtnOK().Click(); 
            
            //Supprimer la relation
            //var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
            Get_Toolbar_BtnDelete().Click();
            Delay(100);          
            Get_DlgConfirmation().WaitProperty("VisibleOnScreen",true,5000);
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
          
    }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));    
    }
    finally {
//            DeleteRelationship(relationshipName);
            Terminate_CroesusProcess();
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
            Activate_Inactivate_Pref(userNameDALTOJ, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
            RestartServices(vServerRelations);           
    }    
}

function Get_WinDetailedInfo_ToggleButton(i){
    return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", i], 10)}
    
//function Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_ModificationDate(){
//  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Date de modification", 10)}
//  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText","Modification Date", 10)}
//} 