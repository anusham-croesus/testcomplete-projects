//USEUNIT CR1302_Prerequisites
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Relationships
    CR                   :  1302
    TestLink             :  Croes-6138
    Description          :  Le but de ce cas est d'ajouter une relation de lui attribuer une fréquence pour obtenir la date de prochaine révision et de 
                            valider q'une note de révision s'ajoute automatiquement.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.09.Er-11
    Date                 :  14/02/2019
    
*/


function CR1302_AddFrequencyAndValidateNextRevisionDate() 
{
     try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6138","Lien du Cas de test sur Testlink");
               
                var relationshipName_CR1302 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_relationshipName", language+client);
                var IACode_CR1302 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_IACode", language+client);
                var languageRelation = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_languageRelation", language+client);
                var reviewFrequency = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_reviewFrequency", language+client);
                var currency = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_currency", language+client);
                var ColumnAddNote = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_ColumnAddNote", language+client);
                var CreatedBy = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_CreatedBy", language+client);
                var Note = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_Note", language+client);
                var Review = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_Review", language+client);
                var ColumnAddFrequency = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_ColumnAddFrequency", language+client);
                var ColumnAddLastReview = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_ColumnAddLastReview", language+client);
                var ColumnAddNextReview = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_ColumnAddNextReview", language+client);
    
                //Se connecter à l'application avec COPERN et acceder au module Relations
                Login(vServerRelations, userName, psw, language);
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
                Get_MainWindow().Maximize();
                
                //Créer une relation avec le champ fréquence de révision=annuelle
                CreateRelationship(relationshipName_CR1302,IACode_CR1302, currency, languageRelation, reviewFrequency);
                SearchRelationshipByName(relationshipName_CR1302);
                
                //Acceder à la fenêtre info de la relation créée
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1302, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Accéder à l'onglet Grid de la section Note
                Get_WinInfo_Notes_TabGrid().Click();
                
                //Ajouter la colonne révision dans Grid
                Add_ColumnByLabel(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate(),ColumnAddNote);
                
                //Points de vérification
                //Fréquence de révision = Annuelle et non modifiable
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), "IsEnabled", cmpEqual, false);
                
                //Prochaine révision = date du jour + 1an et non modifiable
                var currentDate = aqDateTime.Today(); 
                var nextYear = aqDateTime.AddMonths(currentDate, 12);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpNextReviewForRelationship(), "IsReadOnly", cmpEqual, true);
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpNextReviewForRelationship(), "Value", cmpEqual, nextYear);
                
                //vérifier la note créée
                //Colonne créé par
                var noteGrid = Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient.WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Notes", 4).WPFObject("NoteSectionControl", "", 1).WPFObject("TabControl", "", 1).WPFObject("NoteGrid").WPFObject("RecordListControl", "", 1)
                var item = noteGrid.Items.Item(0).DataItem;
                aqObject.CheckProperty(item, "FullName", cmpEqual, CreatedBy);
                
                //Colonne Note
                aqObject.CheckProperty(item, "Comment", cmpEqual, Note);
                
                //Colonne révision
                aqObject.CheckProperty(item, "IsReviewDBValue", cmpEqual, Review);
                
                //Bouton Supprimer grisé
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "IsVisible", cmpEqual, true);
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "IsEnabled", cmpEqual, false);
                
                //Bouton Modifier disponible (non grisé)
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnEdit(), "IsVisible", cmpEqual, true);
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnEdit(), "IsEnabled", cmpEqual, true);
                
                //Quitter la fenêtre info
                Get_WinDetailedInfo_BtnCancel().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Ajouter les colonnes Fréquence, dern.révision et Proch. révision à la grille relations
                Add_ColumnByLabel(Get_RelationshipsGrid_ChCurrency() ,ColumnAddFrequency);
                Add_ColumnByLabel(Get_RelationshipsGrid_ChCurrency() ,ColumnAddLastReview);
                Add_ColumnByLabel(Get_RelationshipsGrid_ChCurrency() ,ColumnAddNextReview);
                
                //Vérifier que Fréquence = Annuelle, Proch. Révision = date aujourd'hui + 1an, Dern. Révision = date d'aujourd'hui
                var items = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = items.Count;
                for (i=0; i<count; i++)
                {
                  if (items.Item(i).DataItem.ShortName == relationshipName_CR1302)
                  {
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewFrequencyDescription", cmpEqual, reviewFrequency);
                     aqObject.CheckProperty(items.Item(i).DataItem, "ReviewDate", cmpEqual, currentDate);
                     aqObject.CheckProperty(items.Item(i).DataItem, "NextReviewDate", cmpEqual, nextYear);
                     break;
                  }
                }
                
				        // Selon karima il faut ignorer la validation du tri 
                /*verifier le tri de la colonne Fréquence
                Get_RelationshipsGrid_ChFrequency().Click();
                Check_columnAlphabeticalSort(Get_CroesusApp().Find("Uid","CRMDataGrid_3071",10),ColumnAddFrequency,"ReviewFrequency" );
                Get_RelationshipsGrid_ChFrequency().Click();
                Check_columnAlphabeticalSort(Get_CroesusApp().Find("Uid","CRMDataGrid_3071",10),ColumnAddFrequency,"ReviewFrequency" );
                
                //Vérifier le tri de la colonne Dern. Révision
                Get_RelationshipsGrid_ChLastReview().Click();
                Check_columnAlphabeticalSort(Get_CroesusApp().Find("Uid","CRMDataGrid_3071",10),ColumnAddLastReview,"ReviewDate" );
                Get_RelationshipsGrid_ChLastReview().Click();
                Check_columnAlphabeticalSort(Get_CroesusApp().Find("Uid","CRMDataGrid_3071",10),ColumnAddLastReview,"ReviewDate" );
                
                //Vérifier le tri de la colonne Proch. Révision
                Get_RelationshipsGrid_ChNextReview().Click();
                Check_columnAlphabeticalSort(Get_CroesusApp().Find("Uid","CRMDataGrid_3071",10),ColumnAddNextReview,"NextReviewDate" );
                Get_RelationshipsGrid_ChNextReview().Click();
                Check_columnAlphabeticalSort(Get_CroesusApp().Find("Uid","CRMDataGrid_3071",10),ColumnAddNextReview,"NextReviewDate" );*/    
                
      }
      catch (e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
      }         
      finally { 
                //Supprimer la relation créée
                DeleteRelationship(relationshipName_CR1302);
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();
      }    
      
}
function test(){
  var relationshipName_CR1302 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_relationshipName", language+client);
   DeleteRelationship(relationshipName_CR1302);
}


function CreateRelationship(RelationshipName, IACode, currency, relationshipLanguage,/* isBillable,*/  reviewFrequency)
{
    Log.Message("Create the relationship \"" + RelationshipName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    SearchRelationshipByName(RelationshipName);
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
    SetAutoTimeOut();
    if (searchResult.Exists){
        Log.Message("The relationship " + RelationshipName + " already exists.");
        return;
    }
    RestoreAutoTimeOut(); 
    Get_Toolbar_BtnAdd().Click();
    Delay(100);
    Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
    Delay(1000);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(RelationshipName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(RelationshipName);
    
    if (IACode != undefined){
    
        if (relationshipLanguage != undefined){
            if (language == "french"){
                if (relationshipLanguage.toUpperCase() == "FRANÇAIS" || relationshipLanguage.toUpperCase() == "FRANCAIS")
                    relationshipLanguage = "Français";
                else if (relationshipLanguage.toUpperCase() == "ANGLAIS")
                    relationshipLanguage = "Anglais";
                else
                    Log.Error(relationshipLanguage + " relationshipLanguage not covered.");
            }
            else {
                if (relationshipLanguage.toUpperCase() == "FRENCH")
                    relationshipLanguage = "French";

                else if (relationshipLanguage.toUpperCase() == "ENGLISH")
                    relationshipLanguage = "English";
                else
                    Log.Error(relationshipLanguage + " relationshipLanguage not covered.");
            }
        }
    
        //Si le code CP est un Combobox (when IA Code is a Combobox)
        SetAutoTimeOut();
        if (Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Exists && Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().VisibleOnScreen){
            
            SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(), IACode);
            
            if (currency != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationship(), currency);
            
            if (relationshipLanguage != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationship(), relationshipLanguage);
        

        }
       
        //Si le code CP est un Textbox (when IA Code is a Texbox)
        else {
        
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACode);
            
            if (currency != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox(), currency);
            
            if (relationshipLanguage != undefined)
                SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox(), relationshipLanguage);
        }
         RestoreAutoTimeOut(); 
    }
    
   /* if (isBillable != undefined)
        Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().set_IsChecked(isBillable);
     */   
    if (reviewFrequency != undefined)
        SelectComboBoxItem(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), reviewFrequency);
    
    Get_WinDetailedInfo_BtnOK().Click();
    /*
    if (Get_DlgInformation().Exists){
        Log.Error("There was an error while creating the relationship.");
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        Get_WinDetailedInfo_BtnCancel().Click();
    }*/
}




  