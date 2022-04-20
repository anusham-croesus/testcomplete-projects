//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-731
    
   
    Description :
         1- Choisir le module relation.: Le module relation s'ouvre correctement.
         2- Sélectionner une relation.:La relation est sélectionnée.
         3-Mailler ce compte vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Sélectionner une position.:La position est bien sélectionnée.
         5-Cliquer sur le bouton 'Info':La fenêtre d'info s'ouvre correctement.
         6-Choisir l'onglet 'Notes ' et cliquer sur le bouton 'Ajouter':La fenêtre d'ajout d'une note est affichée.
         7-Saisir une note et sauvegarder.:La note est ajoutée à la position.
         8-Mailler la position vers le module relation.:Le module relation s'affiche bien.
         9-Cliquer sur le bouton 'Activité'.:La fenêtre activités du client s'ouvre bien.
         10-Côcher le choix 'Inclure les éléments sous-jacents’.:La note crée sur la position est présente.
         
         
         
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-737      
    
    Description :
    
      1- Choisir le module relation.: Le module relation s'ouvre correctement.
         2- Sélectionner une relation.:La relation est sélectionnée.
         3-Mailler ce compte vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Sélectionner une position.:La position est bien sélectionnée.
         5-Cliquer sur le bouton 'Info':La fenêtre d'info s'ouvre correctement.
         6-Choisir l'onglet 'Notes ' et cliquer sur le bouton 'Ajouter':La fenêtre d'ajout d'une note est affichée.
         7-Saisir une note et sauvegarder.:La note est ajoutée à la position.
         8-Mailler la position vers le module relation.:Le module relation s'affiche bien.
         9-Cliquer sur le bouton 'Activité'.:La fenêtre activités du client s'ouvre bien.
         10-Côcher 'Inclure les éléments sous-jacents' et sélectionner la position.:
          Vérifier que les colonnes de la fenêtre 'Activité' sont présentés comme suit:

                          Date:date de la note.

                          Type:'Note'.

                          Source:No.compte:symbole sinon Source:No.compte:no.Titre si le symbole est vide.

                          Nom : Description du titre.

                          Utilisateur : créé_par.

                          Description: première ligne de la note.
                   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_731_737_Port_ValidatOfPresenceOfNotesInActivitiesWindowOftheRelationShip()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-731", "CR1501_731_737_Port_ValidatOfPresenceOfNotesInActivitiesWindowOftheRelationShip()");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-737", "CR1501_731_737_Port_ValidatOfPresenceOfNotesInActivitiesWindowOftheRelationShip()");
    
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
        //Les variables
        var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
        var PortTextAddNotTestCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES731", language+client);
        var ActivDiscriptionCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivDiscriptionCROES731", language+client);
        var ActivCreateByCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivCreateByCROES731", language+client);
        var ActivReferenceNameCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivReferenceNameCROES731", language+client);
        var ActivTypeDescriptionCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivTypeDescriptionCROES731", language+client);
        var ActivSourceCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivSourceCROES731", language+client);
        var TypeActiviteCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "TypeActiviteCROES731", language+client);
        var symbolPositionCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "symbolPositionCROES731", language+client);
        var relationNumberCROES731=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "relationNumberCROES731", language+client);
        var PortTextAddNotTestCROES737=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES737", language+client);
        var portRelationTitrSansSymbolCROES737=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "portRelationTitrSansSymbolCROES737", language+client);
        var symbolPositionCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "symbolPositionCROES735", language+client);
        var numberAccount800205NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800205NA", language+client);
        var ActivSourceCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivSourceCROES735", language+client);
       
         
        Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
        //Choisir le module relation
        Get_ModulesBar_BtnRelationships().Click();
        //Sélectionner la relation RELATION_FAMILLE dont le numéro 0000L
        SearchRelationshipByNo(relationNumberCROES731)
          
         
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationNumberCROES731, 10).Click();
          
        //Mailler vers le module portefeuille
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().OpenMenu();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        //  4-Sélectionner une position.:La position est bien sélectionnée.
        //faire la recherche par description et par symbol
        Search_PositionByDescription(ActivReferenceNameCROES731)
        Search_Position(symbolPositionCROES731);
           
        //            firstRowDescription = VarToStr(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem.SecurityDescription);
        //            Get_Portfolio_PositionsGrid().FindChild("Value", firstRowDescription, 10).Click(); 

        Get_Portfolio_PositionsGrid().FindChild("Value", ActivReferenceNameCROES731, 10).Click();     //Modifié par Amine A.
        //5-Cliquer sur le bouton 'Info':La fenêtre d'info s'ouvre correctement.
        Get_PortfolioBar_BtnInfo().Click();
        // 6-Choisir l'onglet 'Notes ' et cliquer sur le bouton 'Ajouter':La fenêtre d'ajout d'une note est affichée.
        Get_WinPositionInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
           
        //7-Saisir une note et sauvegarder.:La note est ajoutée à la position.
        Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        WaitObject(Get_WinCRUANote(), ["UID", "VisibleOnScreen","IsEnabled"], ["TextBox_e970", true,true]);
        Get_WinCRUANote_GrpNote_TxtNote().Clear();
        Get_WinCRUANote_GrpNote_TxtNote().Keys(PortTextAddNotTestCROES731);
         
        var textAjoutNote=Get_WinCRUANote_GrpNote_TxtNote().Text;
        Log.Message(textAjoutNote);
        WaitObject(Get_WinCRUANote(), ["Uid", "IsEnabled", "VisibleOnScreen"], ["Button_eb1f", true, true]);  
        Get_WinCRUANote_BtnSave().Click();
        SetAutoTimeOut();
        var nbOfTries = 0;
        while (Get_WinCRUANote().Exists && nbOfTries < 5){
            Get_WinCRUANote_BtnSave().Click();           
            Delay(200);
            nbOfTries++;
        }
        RestoreAutoTimeOut();
         
        WaitObject(Get_CroesusApp(),"UID","NoteDataGrid_ddf6");
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotTestCROES731, 10).Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "UID", "NoteDetailWindow_2d5e",30000)
        Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
        WaitObject(Get_WinCRUANote(), ["Uid", "IsEnabled", "VisibleOnScreen"], ["Button_eb1f", true, true]);  
        var dateCreationCROES731=Get_WinCRUANote_TxtCreationDateForPositionAndSecurity().wText;
        Get_WinCRUANote_BtnCancel1().Click();
        Get_WinPositionInfo_BtnCancel().Click();
           
           
        // 8-Mailler la position vers le module compte.:Le module compte s'affiche bien.
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Relationships().OpenMenu();
        Get_MenuBar_Modules_Relationships_DragSelection().Click();
           
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        // 9-Cliquer sur le bouton 'Activité'.:La fenêtre activités du client s'ouvre bien.
        Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
        // 10-Côcher le choix 'Inclure les éléments sous-jacents’.:La note crée sur la position est présente.
        Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true);
        Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType().Keys(TypeActiviteCROES731);
        Log.Message("Problème d’affichage des dates dans la fenêtre Activités, le numéro d'anomalie est : TCVE-396")  
        //Les points de vérifications : La note crée sur la position est présente.
        var displaNotdesccripCROES731 = Get_WinActivities_LstActivities().FindChild("DisplayText", PortTextAddNotTestCROES731, 10);
        if (displaNotdesccripCROES731.Exists && displaNotdesccripCROES731.VisibleOnScreen){
             Log.Checkpoint("La note existe sur la liste des activité");
             
             //var displayActivDateCROES731 = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamDateTimeEditor", "", 1).DisplayText; //Fm-22
             var displayActivDateCROES731 = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1).DisplayText; //Hf-12
             var displayActivTypeDescriptionCROES731 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TypeDescription.OleValue; 
             var displayActivSourceCROES731 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReferenceNo
             var displayActivReferenceNameCROES731 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReferenceName.OleValue;
             var displayActivCreateByCROES731 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.OwnerName.OleValue;
             var displayActivDiscriptionCROES731 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Description.OleValue;
             
            /*
            //Ancienne version
            if (language == "french")
                CheckEquals(displayActivDateCROES731, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y-%m-%d %H:%M"), "La date est ");
             
            //Ancienne version
            if (language == "english"){
                if (client == "CIBC")
                    CheckEquals(displayActivDateCROES731, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y-%m-%d %#I:%M %p"), "La date est ");
                else
                    CheckEquals(displayActivDateCROES731, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y-%m-%d %#I:%M:%S %p"), "La date est ");         
            }
            */
            
            //Adaptation faite pour Fm-22
            if (language == "french")
                CheckEquals(displayActivDateCROES731, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y/%m/%d"), "La date est ");
            
            if (language == "english"){
                if (client == "CIBC")
                    CheckEquals(displayActivDateCROES731, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y-%m-%d %#I:%M %p"), "La date est ");
                else
                    //Adaptation faite pour Fm-22
                    CheckEquals(displayActivDateCROES731, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%m/%d/%Y"), "La date est ");
            }
             
             CheckEquals(displayActivTypeDescriptionCROES731, ActivTypeDescriptionCROES731, "Le type de l'activité est ")
             CheckEquals(displayActivSourceCROES731, ActivSourceCROES731, "Le source est ");
             Log.Message("CROES-10935");
             CheckEquals(displayActivReferenceNameCROES731, ActivReferenceNameCROES731, "Le nom est ");
             CheckEquals(displayActivCreateByCROES731, ActivCreateByCROES731," crée par ");
             CheckEquals(displayActivDiscriptionCROES731, ActivDiscriptionCROES731, "La description est ");
            
             
             Get_WinActivities_LstActivities().FindChild("Value", PortTextAddNotTestCROES731, 10).Click(); 
             //les points de vérifications  de la partie Details
             aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES731);
             aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
            if (language == "french"){
                /*
                //Ancienne version
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y-%m-%d %H:%M:%S"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y-%m-%d"));
                */
                
                //Adaptation faite pour Fm-22
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y/%m/%d %H:%M"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d"));    
            }
               
            if (language == "english"){
                if (client == "CIBC"){
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%m/%d/%Y %#H:%M"));
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y"));                  
                }
                else {
                    /*
                    //Ancienne version
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y-%m-%d %#I:%M:%S %p"));
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y-%m-%d"));
                    */
                
                    //Adaptation faite pour Fm-22
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%m/%d/%Y %H:%M"));
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y"));
                }
            }
            
             aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
             aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES731);
             aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, ActivDiscriptionCROES731);
            
        }
       else {
            Log.Error("La note n'existe pas sur la liste des activité");
       }
       
       Get_WinActivities_BtnClose().Click();
       
        //Faire le test pour un titre qui n'as pas de symbole
         
        //Choisir le module relation
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);

        //Chercher la relation 00001
        SearchRelationshipByNo(portRelationTitrSansSymbolCROES737)
         
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", portRelationTitrSansSymbolCROES737, 10).Click();
        //Mailler vers le module titre
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Securities().OpenMenu();
        Get_MenuBar_Modules_Securities_DragSelection().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
        Search_Security(symbolPositionCROES735);
        Get_SecurityGrid().FindChild("Value", symbolPositionCROES735, 10).Click();
          
        Drag( Get_SecurityGrid().FindChild("Value", symbolPositionCROES735, 10), Get_ModulesBar_BtnPortfolio())
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
           
           
           
        //  4-Sélectionner une position.:La position est bien sélectionnée.
           
    
        Search_PositionByAccountNo(numberAccount800205NA);
         
           
        firstRowDescription = VarToStr(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem.SecurityDescription);
        Get_Portfolio_PositionsGrid().FindChild("Value", firstRowDescription, 10).Click(); 
        //5-Cliquer sur le bouton 'Info':La fenêtre d'info s'ouvre correctement.
        Get_PortfolioBar_BtnInfo().Click();
        // 6-Choisir l'onglet 'Notes ' et cliquer sur le bouton 'Ajouter':La fenêtre d'ajout d'une note est affichée.
        Get_WinPositionInfo_TabNotes().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        WaitObject(Get_WinPositionInfo(), ["UID", "IsSelected","IsEnabled"], ["TabItem_fc72", true,true]);
        //7-Saisir une note et sauvegarder.:La note est ajoutée à la position.
        Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        WaitObject(Get_WinCRUANote(), ["UID", "VisibleOnScreen","IsEnabled"], ["TextBox_e970", true,true]);
        Get_WinCRUANote_GrpNote_TxtNote().Clear();
        Get_WinCRUANote_GrpNote_TxtNote().Keys(PortTextAddNotTestCROES737);
         
        var textAjoutNoteCROES737=Get_WinCRUANote_GrpNote_TxtNote().Text;
        Log.Message(textAjoutNoteCROES737);
        WaitObject(Get_WinCRUANote(), ["Uid", "IsEnabled", "VisibleOnScreen"], ["Button_eb1f", true, true]); 
        Get_WinCRUANote_BtnSave().Click();
        //Si le click ne fonctionne pas
        SetAutoTimeOut();
        var nbOfTries = 0;
        while (Get_WinCRUANote().Exists && nbOfTries < 5){
            Get_WinCRUANote_BtnSave().Click();           
            Delay(200);
            nbOfTries++;
        }
        RestoreAutoTimeOut();
               
        WaitObject(Get_CroesusApp(),"UID","NoteDataGrid_ddf6");   
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotTestCROES737, 10).Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "UID", "NoteDetailWindow_2d5e",30000)
        Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
        WaitObject(Get_WinCRUANote(), ["Uid", "IsEnabled", "VisibleOnScreen"], ["Button_eb1f", true, true]); 
        var dateCreationCROES737=Get_WinCRUANote_TxtCreationDateForPositionAndSecurity().wText;
        Get_WinCRUANote_BtnCancel1().Click();
        Get_WinPositionInfo_BtnCancel().Click()
        // 8-Mailler la position vers le module relation.:Le module relation s'affiche bien.
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Relationships().OpenMenu();
        Get_MenuBar_Modules_Relationships_DragSelection().Click();
           
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        // 9-Cliquer sur le bouton 'Activité'.:La fenêtre activités du compte s'ouvre bien.
        Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
       
           
        // 10-Côcher le choix 'Inclure les éléments sous-jacents’.:La note crée sur la position est présente.
        Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true)
          
        //Les point sde vérifications
        Get_WinActivities_LstActivities().FindChild("Value", PortTextAddNotTestCROES737, 10).Click(); 
        Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
        //les points de vérifications  de la partie Details
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES735);
        Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
        WaitObject(Get_WinActivities(),"UID", "ActivitiesList_e025");
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
        
        if (language == "french"){
            /*
            //Ancienne version
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES737, "%Y-%m-%d %H:%M:%S"));
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y-%m-%d"));              
            */
          
            //Adaptation faite pour Fm-22
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES737, "%Y/%m/%d %H:%M"));
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d"));
        }         
        
        if (language == "english"){
            if (client == "CIBC"){
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%m/%d/%Y %#H:%M"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y"));                  
            }                      
            else {
                /*
                //Ancienne version
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%Y-%m-%d %#I:%M:%S %p"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y-%m-%d"));
                */
                  
                //Adaptation faite pour Fm-22
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES731, "%m/%d/%Y %H:%M"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y"));
            }
        }
        
         aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
         aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES731);
         aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, PortTextAddNotTestCROES737);
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNote, vServerPortefeuille);
        Delete_Note(PortTextAddNotTestCROES737, vServerPortefeuille);
    }
    finally {
        Terminate_CroesusProcess();
        Delete_Note(textAjoutNote, vServerPortefeuille);
        Delete_Note(PortTextAddNotTestCROES737, vServerPortefeuille);
    }
}

