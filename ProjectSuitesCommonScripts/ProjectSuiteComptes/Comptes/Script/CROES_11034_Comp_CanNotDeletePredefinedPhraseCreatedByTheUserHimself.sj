//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**

        Anomalie:CROES-11034
        Se connecter en KEYNEJ
        Aller dans le module Comptes et sélectionner un compte (ex. 800217-RE)
        Double-cliquer sur le compte pour ouvrir la fenêtre Info compte
        Sous l'onglet Notes > Grille, cliquer sur le bouton Ajouter
        Sélectionner une phrase prédéfinie dans la liste et cliquer sur le bouton Copier
        Sélectionner la copie de la phrase prédéfinie

    Auteur : Sana Ayaz
    Version de scriptage:ref90-09-Er-12--V9-croesus-co7x-1_5_550
*/
function CROES_11034_Comp_CanNotDeletePredefinedPhraseCreatedByTheUserHimself()
{
    try {
        
            Log.Link("https://jira.croesus.com/browse/CROES-10678");
            userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            userNameLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
            passwordLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw");
//        
            Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);//L'utilisateur Keynej qui a crée la phrase donc il doit être capable de supprimer et de modifier meêm si la pref pref_edit_firm_function a NO.
            RestartServices(vServerAccounts)
            var numberAccount800217=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "numberAccount800217", language+client);
            var numberAccount800218=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "numberAccount800218", language+client);
            var sentencePredefinedCROES11034KEYNEJ=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "sentencePredefinedCROES11034KEYNEJ", language+client);
            var namePredefinSentenceCROES11034KEYNEJ=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "namePredefinSentenceCROES11034KEYNEJ", language+client);
      
            var namePredefinSentenceCROES11034LINCOA=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "namePredefinSentenceCROES11034LINCOA", language+client);
            var sentencePredefinedCROES11034LINCOA=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "sentencePredefinedCROES11034LINCOA", language+client);
            var namePredefinSentenceCROES11034LINCOACopy=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "namePredefinSentenceCROES11034LINCOACopy", language+client);
            var createdBySentPrefedCROES11034=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "createdBySentPrefedCROES11034", language+client);
            var namePredefinSentenceCROES11034KEYNEJEnglish=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "namePredefinSentenceCROES11034KEYNEJEnglish", language+client);
            var sentencePredefinedCROES11034KEYNEJEnglish=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "sentencePredefinedCROES11034KEYNEJEnglish", language+client); 
            var francais=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "LangueFrancais", language+client); 
            var english=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "EnglishLanguage", language+client); 
            var sentencePredefinedCROES11034KEYNEJCopie=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "sentencePredefinedCROES11034KEYNEJCopie", language+client);
            var sentencePredefinedCROES11034KEYNEJCopy=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "sentencePredefinedCROES11034KEYNEJCopy", language+client);
            var namePredefinSentenceCROES11034KEYNEJCopy=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "namePredefinSentenceCROES11034KEYNEJCopy", language+client);
            var namePredefinSentenceCROES11034KEYNEJCopie=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "namePredefinSentenceCROES11034KEYNEJCopie", language+client);
            var identifiantPhrasePred=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "DescriptionPredefinedSentence", language+client);
            var identifiantPhrasePredCopy=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "DescriptionPredefinedSentenceCopy", language+client);
            
     
            Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
            //Choisir le module compte
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            SearchAccount(numberAccount800217);
            Get_MainWindow().Maximize();          
            Get_RelationshipsClientsAccountsGrid().Find("Value",numberAccount800217,10).DblClick();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["TabItem", "Notes"]);
            
            Get_WinInfo_Notes_TabNote().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
       
       
            Get_WinCRUANote().Parent.maximize();
            WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
            //Ajout d'une phrase prédéfinie avec laquelle on va faire le test pour KEYNEJ dans les deux langues Francais et Anglais
            Get_WinCRUANote_BtnAddPredefinedSentences().Click();
            Get_WinAddNewSentence_TxtName().Click(Get_WinAddNewSentence_TxtName().get_ActualWidth()-9,  Get_WinAddNewSentence_TxtName().get_ActualHeight()/2);
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",francais ,10).Click();
            Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES11034KEYNEJ);
            Get_WinAddNewSentence_TxtSentence().Click(Get_WinAddNewSentence_TxtSentence().get_ActualWidth()-6,  Get_WinAddNewSentence_TxtSentence().get_ActualHeight()-10); 
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",francais ,10).Click();
            Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES11034KEYNEJ);
          
          
            Get_WinAddNewSentence_TxtName().Click(Get_WinAddNewSentence_TxtName().get_ActualWidth()-9,  Get_WinAddNewSentence_TxtName().get_ActualHeight()/2);
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",english ,10).Click();
            Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES11034KEYNEJEnglish);        
            Get_WinAddNewSentence_TxtSentence().Click(Get_WinAddNewSentence_TxtSentence().get_ActualWidth()-6,  Get_WinAddNewSentence_TxtSentence().get_ActualHeight()-10); 
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",english,10).Click();
            Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES11034KEYNEJEnglish);
          
            Get_WinAddNewSentence_BtnSave().Click();         
            Get_WinCRUANote_GrpNote_TxtNote().WaitProperty("VisibleOnScreen", true, 20000);
    
           
            //La phrase prédéfinie est ajoutée
             
            var displaySenPredefCROES11034=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePred, 10)//.WPFControlText
            if(displaySenPredefCROES11034.Exists)
            {
            var textDisplaySenPredefCROES11034=displaySenPredefCROES11034.WPFControlText;
            Log.Message(textDisplaySenPredefCROES11034)
            CheckEquals(textDisplaySenPredefCROES11034,identifiantPhrasePred,"Le nom de la phrase prédéfinie ");
            var indexKeynej =displaySenPredefCROES11034.Record.index
            var displayCreatedByCROES11034=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(indexKeynej).DataItem.FullName.OleValue
         
            CheckEquals(displayCreatedByCROES11034,createdBySentPrefedCROES11034,"Créée par est ")
            }
              else 
            {
            Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
            }
           
          
            //Ajout de la phrase prédéfinie pour faire le test pour lincoa           
            Get_WinCRUANote_BtnAddPredefinedSentences().Click();
            Get_WinAddNewSentence_TxtName().Click()
            Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES11034LINCOA);
            Get_WinAddNewSentence_TxtSentence().Click()
            Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES11034LINCOA);
            Get_WinAddNewSentence_BtnSave().Click();
            //La phrase prédéfinie est ajoutée
             
            var display1SenPredefCROES11034=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES11034LINCOA, 10)//.WPFControlText
            if(display1SenPredefCROES11034.Exists)
            {
            var textDisplay1SenPredefCROES11034=display1SenPredefCROES11034.WPFControlText;
            Log.Message(textDisplay1SenPredefCROES11034)
            CheckEquals(textDisplay1SenPredefCROES11034,namePredefinSentenceCROES11034LINCOA,"Le nom de la phrase prédéfinie ");
            var indexLincoa =display1SenPredefCROES11034.Record.index
            var display1CreatedByCROES11034=Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(indexLincoa).DataItem.FullName.OleValue
         
            CheckEquals(displayCreatedByCROES11034,createdBySentPrefedCROES11034,"Créée par est ")
            }
              else 
            {
            Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
            }
           
           
            Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePred, 10).Click();
            Get_WinCRUANote_BtnCopyPredefinedSentences().Click();    
                             
           
            Get_WinEditSentence_TxtName().Click(Get_WinEditSentence_TxtName().get_ActualWidth()-9, Get_WinEditSentence_TxtName().get_ActualHeight()/2);
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",francais ,10).Click();
            Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES11034KEYNEJCopie);
            Get_WinEditSentence_TxtSentence().Click(Get_WinEditSentence_TxtSentence().get_ActualWidth()-6,  Get_WinEditSentence_TxtSentence().get_ActualHeight()-10); 
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",francais ,10).Click();
            Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES11034KEYNEJCopie);
          
            Get_WinEditSentence_TxtName().Click(Get_WinEditSentence_TxtName().get_ActualWidth()-9, Get_WinEditSentence_TxtName().get_ActualHeight()/2);
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",english ,10).Click();
            Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES11034KEYNEJCopy);        
            Get_WinAddNewSentence_TxtSentence().Click(Get_WinAddNewSentence_TxtSentence().get_ActualWidth()-6,  Get_WinAddNewSentence_TxtSentence().get_ActualHeight()-10); 
            Get_SubMenus().WaitProperty("IsEnabled", true, 2000);
            Get_SubMenus().Find("WPFControlText",english,10).Click();
            Get_WinAddNewSentence_TxtSentence().Keys(sentencePredefinedCROES11034KEYNEJCopy);
          
            Get_WinAddNewSentence_BtnSave().Click();         
        
            //les points de vérifications
            //Valider la copie de la phrase prédéfinie  
            Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePredCopy, 10).Click();
            aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePredCopy, 10),"Exists", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePredCopy, 10),"VisibleOnScreen", cmpEqual, true);    
           
            aqObject.CheckProperty(Get_WinCRUANote_BtnEditPredefinedSentences(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinCRUANote_BtnEditPredefinedSentences(), "VisibleOnScreen", cmpEqual, true);
            //Les points de vérifications
            aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "VisibleOnScreen", cmpEqual, true);
            Get_WinCRUANote_BtnCancel1().Click();
            Get_WinDetailedInfo_BtnCancel().Click();
            Terminate_CroesusProcess();
            
            //Je me connecte avec LINCOA et je vais vérifier si je choisis la phrase prédéfinie crée par KEYNEJ ensuite je fais copier et je sélectionne la copie de la phrase prédéfinie : les 2 boutons modifier et supprimer ne sont pas grisés pour pouvoir voir la phrase prédéfinie crée par KEYNEJ il faut que la pref_edit_firm_function doit être a YES
            Activate_Inactivate_Pref(userNameLINCOA, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerAccounts);
            RestartServices(vServerAccounts)                    
            Login(vServerAccounts, userNameLINCOA, passwordLINCOA, language);
            
            //Choisir le module compte            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            SearchAccount(numberAccount800218);
            Get_MainWindow().Maximize();          
            Get_RelationshipsClientsAccountsGrid().Find("Value",numberAccount800218,10).DblClick();
            Get_WinInfo_Notes_TabNote().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
            Get_WinCRUANote().Parent.maximize();
            WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
                   
            //faire une copie de la phrase prédéfinie Lincoa
            Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES11034LINCOA, 10).Click();
            Get_WinCRUANote_BtnCopyPredefinedSentences().Click();
            Get_WinAddNewSentence_TxtName().Keys(namePredefinSentenceCROES11034LINCOACopy);
            Get_WinAddNewSentence_TxtSentence().Keys(namePredefinSentenceCROES11034LINCOACopy);
            Get_WinAddNewSentence_BtnSave().Click();  
           
            //Sélectionner la copie de la phrase prédéfinie
            Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES11034LINCOACopy, 10).Click();
            aqObject.CheckProperty(Get_WinCRUANote_BtnEditPredefinedSentences(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinCRUANote_BtnEditPredefinedSentences(), "VisibleOnScreen", cmpEqual, true);
            //Les points de vérifications
            aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "VisibleOnScreen", cmpEqual, true);
            //Valider l'ajout de la copie de la phrase prédéfinie
            aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES11034LINCOACopy, 10),"Exists", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentenceCROES11034LINCOACopy, 10),"VisibleOnScreen", cmpEqual, true);
            Get_WinCRUANote_BtnClose().Click();
            Get_WinDetailedInfo_BtnCancel().Click();
            

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_PredefinedSentences(namePredefinSentenceCROES11034LINCOA, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceCROES11034LINCOACopy, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
        Delete_PredefinedSentences(DescriptionPredefinedSentenceCopy, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
        Delete_PredefinedSentences(identifiantPhrasePredCopy, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
     
       
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_PredefinedSentences(namePredefinSentenceCROES11034LINCOA, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
        Delete_PredefinedSentences(namePredefinSentenceCROES11034LINCOACopy, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
        Delete_PredefinedSentences(identifiantPhrasePred, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
        Delete_PredefinedSentences(identifiantPhrasePredCopy, vServerAccounts)
        Delete_PredefinedSentencesGRD(vServerAccounts)
        
      }  
}
function test()
{
 var identifiantPhrasePredCopy=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "DescriptionPredefinedSentenceCopy", language+client);
       

Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePredCopy, 10).Click();
            aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePredCopy, 10),"Exists", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",identifiantPhrasePredCopy, 10),"VisibleOnScreen", cmpEqual, true);    
}