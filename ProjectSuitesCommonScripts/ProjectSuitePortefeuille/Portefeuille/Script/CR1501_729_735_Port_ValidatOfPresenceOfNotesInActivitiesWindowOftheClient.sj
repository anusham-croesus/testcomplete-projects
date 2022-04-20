//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-729
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-735
    
   
    Description du cas CROES-729 :
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
         4-Sélectionner une position.:La position est bien sélectionnée.
         5-Cliquer sur le bouton 'Info':La fenêtre d'info s'ouvre correctement.
         6-Choisir l'onglet 'Notes ' et cliquer sur le bouton 'Ajouter':La fenêtre d'ajout d'une note est affichée.
         7-Saisir une note et sauvegarder.:La note est ajoutée à la position.
         8-Mailler la position vers le module client.:Le module client s'affiche bien.
         9-Cliquer sur le bouton 'Activité'.:La fenêtre activités du client s'ouvre bien.
         10-Côcher le choix 'Inclure les éléments sous-jacents’.:La note crée sur la position est présente.
         
    Description du cas CROES-735 :     
            1- Choisir le module client: Le module client s'ouvre correctement.      
            2- Sélectionner un client: Le client est bien sélectionné.
            3-Mailler ce client vers le module portefeuille:Le module portefeuille s'ouvre correctement.
            4-Sélectionner une position.:La position est bien sélectionnée.
            5-Cliquer sur le bouton 'Info':La fenêtre d'info s'ouvre correctement.
            6-Choisir l'onglet 'Notes ' et cliquer sur le bouton 'Ajouter':La fenêtre d'ajout d'une note est affichée.
            7-Saisir une note et sauvegarder.:La note est ajoutée à la position.
            8-Mailler la position vers le module client.:Le module client s'affiche bien.
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


function CR1501_729_Port_ValidatOfPresenceOfNotesInActivitiesWindowOftheClient()
{
    try {
        Log.Message("CR1501_729_Port_ValidatOfPresenceOfNotesInActivitiesWindowOftheClient()");
        
        /*Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-729", "CR1501_729_Port_ValidatOfPresenceOfNotesInActivitiesWindowOftheClient()");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-735", "CR1501_729_Port_ValidatOfPresenceOfNotesInActivitiesWindowOftheClient()");*/
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
        //Les variables
        var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800300", language+client);
        var numberClient800205=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberClient800205", language+client);
        var numberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800300NA", language+client);
        var numberAccount800205NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "numberAccount800205NA", language+client);
        var PortTextAddNotTestCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES729", language+client);
        var ActivDiscriptionCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivDiscriptionCROES729", language+client);
        var ActivCreateByCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivCreateByCROES729", language+client);
        var ActivReferenceNameCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivReferenceNameCROES729", language+client);
        var ActivTypeDescriptionCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivTypeDescriptionCROES729", language+client);
        var ActivSourceCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivSourceCROES729", language+client);
        var TypeActiviteCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "TypeActiviteCROES729", language+client);
        var symbolPositionCROES729=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "symbolPositionCROES729", language+client);
        var PortTextAddNotTestCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "PortTextAddNotTestCROES735", language+client);
        var ActivSourceCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "ActivSourceCROES735", language+client);
        var positionDescripCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "positionDescripCROES735", language+client);
        var symbolPositionCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "symbolPositionCROES735", language+client);
        var DescriTitreCROES735=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "CR1501", "DescriTitreCROES735", language+client);
         
        Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);//debut
        //Choisir le module client
        Get_ModulesBar_BtnClients().Click();
        //Sélectionner le client 800300
         
        Search_Client(numberClient800300)
         
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          
        //Mailler vers le module portefeuille
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().OpenMenu();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        //  4-Sélectionner une position.:La position est bien sélectionnée.
        //faire la recherche par description et par symbol
           
        Search_Position(symbolPositionCROES729);
        Search_PositionByAccountNo(numberAccount800300NA)
        //Search_PositionByDescription(ActivReferenceNameCROES729)
         
           
        firstRowDescription = VarToStr(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem.SecurityDescription.OleValue);
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
        Get_WinCRUANote_GrpNote_TxtNote().Keys(PortTextAddNotTestCROES729);
        
        var textAjoutNoteCROES729 = Get_WinCRUANote_GrpNote_TxtNote().Text;
        Log.Message(textAjoutNoteCROES729);
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
          
        //WaitObject(Get_CroesusApp(),"UID","NoteDataGrid_ddf6");  
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotTestCROES729, 10).Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "UID", "NoteDetailWindow_2d5e",30000);
        Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
        WaitObject(Get_WinCRUANote(), ["Uid", "IsEnabled", "VisibleOnScreen"], ["Button_eb1f", true, true]);  
        var dateCreationCROES729 = Get_WinCRUANote_TxtCreationDateForPositionAndSecurity().wText;
        Get_WinCRUANote_BtnCancel1().Click();
        Get_WinPositionInfo_BtnCancel().Click();
           
        // 8-Mailler la position vers le module client.:Le module client s'affiche bien.
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Clients().OpenMenu();
        Get_MenuBar_Modules_Clients_DragSelection().Click();
           
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        // 9-Cliquer sur le bouton 'Activité'.:La fenêtre activités du client s'ouvre bien.
        Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
        // 10-Côcher le choix 'Inclure les éléments sous-jacents’.:La note crée sur la position est présente.
        Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true);
        Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType().Keys(TypeActiviteCROES729);
        Log.Message("Problème d’affichage des dates dans la fenêtre Activités, le numéro d'anomalie est : TCVE-396")
        //Les points de vérifications : La note crée sur la position est présente.
        var displaNotdesccripCROES729 = Get_WinActivities_LstActivities().FindChild("DisplayText", PortTextAddNotTestCROES729, 10);
        if (displaNotdesccripCROES729.Exists && displaNotdesccripCROES729.VisibleOnScreen){
            Log.Checkpoint("La note existe sur la liste des activité");
            
             //var displayActivDateCROES729 = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamDateTimeEditor", "", 1).DisplayText; //Fm-22
             var displayActivDateCROES729 = Get_WinActivities_LstActivities().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamTextEditor", "", 1).DisplayText; //Hf-12
             var displayActivTypeDescriptionCROES729 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TypeDescription.OleValue; 
             var displayActivSourceCROES729 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReferenceNo;
             var displayActivReferenceNameCROES729 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReferenceName.OleValue;
             var displayActivCreateByCROES729 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.OwnerName.OleValue;
             var displayActivDiscriptionCROES729 = Get_WinActivities_LstActivities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Description.OleValue;
             
             /*
             //Ancienne version
             if (language == "french")
                 CheckEquals(displayActivDateCROES729, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d %#I:%M:%S"), "La date est ");
             
             //Ancienne version
             if (language == "english")
                CheckEquals(displayActivDateCROES729, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d %#I:%M:%S %p"), "La date est ");
             */
             
             //Adaptation faite pour Fm-22             
             if (language == "french")
                CheckEquals(displayActivDateCROES729, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"), "La date est ");
             
             //Adaptation faite pour Fm-22
             if (language == "english")
                CheckEquals(displayActivDateCROES729, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"), "La date est ");
             
            CheckEquals(displayActivTypeDescriptionCROES729,ActivTypeDescriptionCROES729,"Le type de l'activité est ");
            CheckEquals(displayActivSourceCROES729, ActivSourceCROES729, "Le source est ");
            Log.Message("CROES-10935");
            CheckEquals(displayActivReferenceNameCROES729, ActivReferenceNameCROES729, "Le nom est ");
            CheckEquals(displayActivCreateByCROES729, ActivCreateByCROES729, " crée par ");
            CheckEquals(displayActivDiscriptionCROES729, ActivDiscriptionCROES729, "La description est ");
             
            Get_WinActivities_LstActivities().FindChild("Value", PortTextAddNotTestCROES729, 10).Click(); 
          
            //les points de vérifications  de la partie Details
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES729);
           
            Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
          
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
             
            if (language == "french"){
                /*
                //Ancienne version
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES729, "%Y-%m-%d %H:%M:%S"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%Y-%m-%d"));
                */
                
                //Adaptation faite pour Fm-22
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES729, "%Y/%m/%d %H:%M"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%Y/%m/%d"));
            }
              
            if (language == "english"){
                if (client == "CIBC"){
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES729, "%m/%d/%Y %I:%M"));
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y %#I:%M"))
                }
                else {
                    /*
                    //Ancienne version
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES729, "%Y-%m-%d %#I:%M:%S %p"));
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%Y-%m-%d"));
                    */
                    
                    //Adaptation faite pour Fm-22
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES729, "%m/%d/%Y %H:%M"));
                    aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y"));
                }
            }
            
            //aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES729, "%Y-%m-%d %#I:%M:%S %p"));
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES729);
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, ActivDiscriptionCROES729);
        }
        else {
            Log.Error("La note n'existe pas sur la liste des activité");
        }
        
        Get_WinActivities_BtnClose().Click();
        //Faire le test pour un titre qui n'as pas de symbole
         
        //Choisir le module client
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        Search_Client(numberClient800205);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800205, 10).Click();
        
        //Mailler vers le module titre
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Securities().HoverMouse();
        Get_MenuBar_Modules_Securities().HoverMouse();
        Get_MenuBar_Modules_Securities_DragSelection().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
        Search_Security(symbolPositionCROES735);
        Get_SecurityGrid().FindChild("Value", symbolPositionCROES735, 10).Click();
          
        Drag(Get_SecurityGrid().FindChild("Value", symbolPositionCROES735, 10), Get_ModulesBar_BtnPortfolio());
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
        WaitObject(Get_WinPositionInfo(), ["UID", "IsSelected","IsEnabled"], ["TabItem_fc72", true, true]);
        
        //7-Saisir une note et sauvegarder.:La note est ajoutée à la position.
        Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        WaitObject(Get_WinCRUANote(), ["UID", "VisibleOnScreen","IsEnabled"], ["TextBox_e970", true, true]);
        Get_WinCRUANote_GrpNote_TxtNote().Clear();
        Get_WinCRUANote_GrpNote_TxtNote().Keys(PortTextAddNotTestCROES735);
         
        var textAjoutNoteCROES735 = Get_WinCRUANote_GrpNote_TxtNote().Text;
        Log.Message(textAjoutNoteCROES735);
          
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
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", PortTextAddNotTestCROES735, 10).Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "UID", "NoteDetailWindow_2d5e",30000)
        Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
        WaitObject(Get_WinCRUANote(), ["Uid", "IsEnabled", "VisibleOnScreen"], ["Button_eb1f", true, true]); 
        var dateCreationCROES735=Get_WinCRUANote_TxtCreationDateForPositionAndSecurity().wText;
        Get_WinCRUANote_BtnCancel1().Click();
        Get_WinPositionInfo_BtnCancel().Click()
           
        // 8-Mailler la position vers le module client.:Le module client s'affiche bien.
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Clients().OpenMenu();
        Get_MenuBar_Modules_Clients_DragSelection().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        
        // 9-Cliquer sur le bouton 'ActiGet_WinActivities_DetailsExpander_TxtCreationDatevité'.:La fenêtre activités du client s'ouvre bien.
        Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
        // 10-Côcher le choix 'Inclure les éléments sous-jacents’.:La note crée sur la position est présente.
        Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().set_IsChecked(true)
          
        //Les points de vérifications
        Get_WinActivities_LstActivities().FindChild("Value", PortTextAddNotTestCROES735, 10).Click(); 
        Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
        
        //les points de vérifications  de la partie Details
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtSource(), "Text", cmpEqual, ActivSourceCROES735);
        Get_WinActivities_BtnClose().WaitProperty("Enabled", true, 30000);
        WaitObject(Get_WinActivities(),"UID","ActivitiesList_e025");
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtEffectiveDate(), "Text", cmpEqual, "");
        
        if (language == "french"){
            /*
            //Ancienne version
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES735, "%Y-%m-%d %H:%M:%S"));
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d"));
            */
            
            //Adaptation faite pour Fm-22
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES735, "%Y/%m/%d %H:%M"));
            aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d"));
        }
               
        if (language == "english"){
            if (client == "CIBC"){
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES729, "%m/%d/%Y %#I:%M"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(),  "%m/%d/%Y %#I:%M"))
            }
            else {
                /*
                //Ancienne version
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES735, "%Y-%m-%d %#I:%M:%S %p"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d"));
                */
                
                //Adaptation faite pour Fm-22
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpEqual, aqConvert.DateTimeToFormatStr(dateCreationCROES735, "%m/%d/%Y %H:%M"));
                aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreationDate(), "Text", cmpContains, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y"));
            }             
        }
        
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtUpdateDate(), "Text", cmpEqual, "");
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtCreatedByDate(), "Text", cmpEqual, ActivCreateByCROES729);
        aqObject.CheckProperty(Get_WinActivities_DetailsExpander_TxtDescription(), "Text", cmpEqual, PortTextAddNotTestCROES735);  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES729, vServerPortefeuille)
        Delete_Note(PortTextAddNotTestCROES735, vServerPortefeuille)
    }
    finally {
        Terminate_CroesusProcess();
        Delete_Note(PortTextAddNotTestCROES729, vServerPortefeuille)
        Delete_Note(PortTextAddNotTestCROES735, vServerPortefeuille)
    }
}


function test(){
  Log.Message(aqConvert.DateTimeToFormatStr(aqDateTime.ToDay(), "%m/%d/%Y %I:%M"));
  Log.Message(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y %I:%M"));
}