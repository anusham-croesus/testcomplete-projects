//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Valider le comportement pour les comptes fictifs
    Module      : Comptes
    CR          : 1917
    Cas de test : Croes-4733
    
    Préconditions: PREF_EDIT_REAL_ACCOUNT_ASC_CODE = NO
    
    1- Créer un compte fictif
    2- Valider l'existance du champs Sous-type avec une liste déroulante
    3- Supprimer le compte ficif créé.

    Auteur :                Abdel Matmat
    Version de scriptage:	90-08-Dy-2
    
*/


function CR1917_Croes_4733_Acc_ValidateBehaviorForFictitiousAccounts() {
         
          try {
              
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4733","Lien du Cas de test sur Testlink");
                    
                    //Mettre la pref PREF_EDIT_REAL_ACCOUNT_ASC_CODE = NO
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_REAL_ACCOUNT_ASC_CODE", "NO", vServerAccounts);
                    RestartServices(vServerAccounts);
          
                    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
                    var accountNo_Croes_4733 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_accountNo_Croes_4733", language+client);
                    var fictitiousAccount_Croes_4733 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_fictitiousAccount_Croes_4733", language+client);
                    var comboPosition = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4733_ComboPosition", language+client);;
                    
                    Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Ajout d'un compte fictif a travers Simulation
                    SelectAccounts(accountNo_Croes_4733);
                    Get_MenuBar_Modules().Click();
                    Get_MenuBar_Modules_Portfolio().Click();
                    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
                    WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");
                    Get_PortfolioBar_BtnWhatIf().Click();
                    WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd");
                    Get_PortfolioBar_BtnSave().Click();
                    Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().Keys(fictitiousAccount_Croes_4733.charAt(0));
                    Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().Keys(fictitiousAccount_Croes_4733.slice(1));
                    Get_WinWhatIfSave_BtnOK().Click();
                    Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
     
                    //Acceder au module comptes
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    
                    //Filtrer les comptes fictifs
                    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
                    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["ContextMenu","1"],10);
                    Get_Toolbar_BtnQuickFilters_ContextMenu_FictitiousAccounts().Click();
                    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
                    SearchAccount(fictitiousAccount_Croes_4733);
                    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["XamTextEditor",fictitiousAccount_Croes_4733],10).DblClick();
                    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
     
                    //Valider le combo Sous Type
                    validateComboSubType(comboPosition);
       
                    Get_WinDetailedInfo().Close();   
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    //Supprimer le compte fictif créé
                    SearchAccount(fictitiousAccount_Croes_4733);
                    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["XamTextEditor",fictitiousAccount_Croes_4733],10).Click();
                    Get_Toolbar_BtnDelete().Click();
                    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
                    
                    // Remove Comptes Fictifs filter from Accounts pad
                    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").WPFObject("MainWindow").WPFObject("contentContainer").WPFObject("tabControl").WPFObject("_currentPlugin").WPFObject("_mainTabCtrl").WPFObject("CurrentPad").WPFObject("_CRMGrid").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 2).Click();
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess(); 
                    
                    //Mettre la pref PREF_EDIT_REAL_ACCOUNT_ASC_CODE = YES (État initial)
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_REAL_ACCOUNT_ASC_CODE", "YES", vServerAccounts);
                    RestartServices(vServerAccounts);  
          }
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_FictitiousAccounts()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Comptes fictifs", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Fictitious Accounts", 10)}
}

function validateComboSubType(comboPosition)
{
         var LabelSubType_Croes_4733 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_LabelSubType_Croes_4733", language+client);
         
        //Valider le Label Sous-type
        aqObject.CheckProperty(Get_WinDetailedInfo().FindChild(["ClrClassName","WPFControlOrdinalNo"],["UniLabel","10"],10), "Text", cmpEqual, LabelSubType_Croes_4733);
     
        // Valider que le combo box est disponible
        Log.Message("Valider que le combo Sous-Type est actif");
        if (language == "french"){
            aqObject.CheckProperty(Get_WinDetailedInfo().WPFObject("UniGroupBox", "Compte", 1).WPFObject("CFComboBox", "", comboPosition), "Enabled", cmpEqual, true);
            Get_WinDetailedInfo().WPFObject("UniGroupBox", "Compte", 1).WPFObject("CFComboBox", "", comboPosition).Click();
        }else{
            aqObject.CheckProperty(Get_WinDetailedInfo().WPFObject("UniGroupBox", "Account", 1).WPFObject("CFComboBox", "", comboPosition), "Enabled", cmpEqual, true);
            Get_WinDetailedInfo().WPFObject("UniGroupBox", "Account", 1).WPFObject("CFComboBox", "", comboPosition).Click();
        }
        var NbrItem = Get_SubMenus().ChildCount;
        if (NbrItem == 0) Log.Error("La liste déroulante est vide");
        else Log.Checkpoint("La liste déroulante est disponible");
     
        for (i=1; i<=NbrItem; i++) 
            if (Get_SubMenus().WPFObject("ComboBoxItem", "", i).Exists)
            {
                Log.Checkpoint("La liste déroulante est disponible");
                Log.Message("L'item numéro "+i+" est: "+ Get_SubMenus().WPFObject("ComboBoxItem", "", i).WPFControlText);
             }
}