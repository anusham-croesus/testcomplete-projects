//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/*
     Description: Contient les fonctions communes entre les différents modules du CR1483 de la fenêtre "Work As"
     Objectif   : Factorisation du code pour faciliter la maintenance
     Analyste   : Abdel Matmat
     
     
*/

function CR1483_CheckErrorMsgPrefMaxWorkAs(vServer,Button,TabName, FilePath, IdExcel) {
          try {
                     
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    
                    //Mettre la pref "PREF_MAX_WORKAS_ELEMENTS" à la valeur 4
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_MAX_WORKAS_ELEMENTS","4",vServer);
                    RestartServices(vServer);
                    
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                    if (TabName == "Branches")
                    {     
                        //Accéder à l'onglet Succursales
                        Get_WinUserMultiSelection_TabBranches().Click();
                                        
                        //Selectionner 5 succursales (Plus que la valeur définie dans la pref) et appliquer la selection
                        Log.Message("Selectionner les cinq (05) "+TabName);
                        Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
                        Get_WinUserMultiSelection_TabBranches_DgBranches().Keys("[Hold]![Down][ReleaseLast][Down][ReleaseLast][Down][ReleaseLast][Down][Release]");
                    }else
                    {
                         if (TabName == "Users")
                         {     
                         //Accéder à l'onglet users
                         Get_WinUserMultiSelection_TabUsers().Click();
                                        
                         //Selectionner 5 users (Plus que la valeur définie dans la pref) et appliquer la selection
                         Log.Message("Selectionner les cinq (05) "+TabName);
                         Get_WinUserMultiSelection_TabUsers_DgvUsers().FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
                         Get_WinUserMultiSelection_TabUsers_DgvUsers().Keys("[Hold]![Down][ReleaseLast][Down][ReleaseLast][Down][ReleaseLast][Down][Release]");
                         }else
                         {
                             //Accéder à l'onglet IA Codes
                            Get_WinUserMultiSelection_TabIACodes().Click();
                                        
                            //Selectionner 5 IA Codes (Plus que la valeur définie dans la pref) et appliquer la selection
                            Log.Message("Selectionner les cinq (05) "+TabName);
                            Get_WinUserMultiSelection_TabIACodes_DgvIACodes().FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
                            Get_WinUserMultiSelection_TabIACodes_DgvIACodes().Keys("[Hold]![Down][ReleaseLast][Down][ReleaseLast][Down][ReleaseLast][Down][Release]");
                         }
                    }
                    Get_WinUserMultiSelection_BtnApply().Click();
                    
                    //Vérifier que le message d'erreur est affiché
                    aqObject.CheckProperty(Get_DlgWarning(), "Title", cmpEqual,ReadDataFromExcelByRowIDColumnID(FilePath, "CR1483", "CR1483_WinSelection_ErrorTitle", language+client));
                    aqObject.CheckProperty(Get_DlgWarning(), "CommentTag", cmpEqual,ReadDataFromExcelByRowIDColumnID(FilePath, "CR1483", IdExcel, language+client));
                    var width = Get_DlgWarning().Width;
                    var height = Get_DlgWarning().Height;
                    Get_DlgWarning().Click(width/2,height-50);
                    Get_WinUserMultiSelection_BtnCancel().Click();    
                   
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally {         
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
                    
                    //Remise de la pref par défaut
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_MAX_WORKAS_ELEMENTS","30",vServer);
                    RestartServices(vServer);
          }
}


function CR1483_RememberMySelection(vServer,Button,TabName, filePath, ItemSelection) {
         
          try {
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                    
                    if (TabName == "Branches")
                    {
                        //Accéder à l'onglet Succursales
                        Get_WinUserMultiSelection_TabBranches().Click();
                    
                        //Selectionner un filtre et appliquer exemple "Toronto"
                        Search_Branch(ItemSelection);
                        Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",ItemSelection],10).Click();
                        Get_WinUserMultiSelection_BtnApply().Click();
                        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
                        
                        //Valider le titre de la fenêtre Croesus avec la nouvelle selection
                        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
                    }else
                    {
                        if (TabName == "Users")
                        {
                            //Accéder à l'onglet Utilisateurs
                            Get_WinUserMultiSelection_TabUsers().Click();
                    
                            //Selectionner un filtre et appliquer exemple "COPERN"
                            Search_Client(ItemSelection);
                            Get_WinUserMultiSelection_TabUsers_DgvUsers().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",ItemSelection],10).Click();
                            Get_WinUserMultiSelection_BtnApply().Click();
                            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
                    
                            //Valider le titre de la fenêtre Croesus avec la nouvelle selection
                            aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
                        }else
                        {
                            //Accéder à l'onglet Codes de CP
                            Get_WinUserMultiSelection_TabIACodes().Click();
                    
                            //Selectionner un filtre et appliquer exemple "COPERN"
                            Search_IACode(ItemSelection);
                            Get_WinUserMultiSelection_TabIACodes_DgvIACodes().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",ItemSelection],10).Click();
                            Get_WinUserMultiSelection_BtnApply().Click();
                            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
                    
                            //Valider le titre de la fenêtre Croesus avec la nouvelle selection
                            aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
                    
                            //Valider les codes de CP affichés dans la grille Client que juste "BD88"
                            CheckSelectedIACodes(ItemSelection);
                        }
                    }
                    
                    // Cocher l'option "Remember my selection
                    Log.Message("Cocher l'option Remember my selection");
                    Get_MenuBar_Users().Click();
                    Get_MenuBar_Users_RememberMySelection_Check();
                    
                    //Fermer Croesus
                    Terminate_CroesusProcess();
                    
                    //Reconnecter à Croesus
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    Log.Message("Jira CROES-10927")
                    //Valider que la selection est toujours prise en charge
                    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
                    
                    if (TabName == "IACodes")
                    {
                        //Valider les codes de CP affichés dans la grille Client que juste "BD88"
                        CheckSelectedIACodes(ItemSelection);
                    }
                    
                    //Decocher Remember my selection
                    Log.Message("Décocher l'option Remember my selection");
                    Get_MenuBar_Users().Click();
                    Get_MenuBar_Users_RememberMySelection_UnCheck();
                    
                    //Fermer Croesus
                    Terminate_CroesusProcess();
                    
                    //Reouvrir Croesus
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Valider que la selection précédente n'est pas prise en charge
                    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_Uni00", language+client));      
                   
                   
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally {         
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
          }
}

function Search_IACode(IACode){
      
      Get_WinUserMultiSelection_TabIACodes_DgvIACodes().Keys("C");
      Get_WinQuickSearch_TxtSearch().SetText(IACode);
      Get_WinQuickSearch_RdoIACode().set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
}
function Search_Branch(Branch){
      
      Get_WinUserMultiSelection_TabBranches_DgBranches().Keys("L");
      Get_WinQuickSearch_TxtSearch().SetText(Branch);
      Get_WinQuickSearch_RdoBranchName().set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
}
function Search_Client(Client){
      
      Get_WinUserMultiSelection_TabUsers_DgvUsers().Keys("C");
      Get_WinQuickSearch_TxtSearch().SetText(Client);
      Get_WinQuickSearch_RdoLastName().set_IsChecked(true);
      Get_WinQuickSearch_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
}

function Get_WinQuickSearch_RdoBranchCode()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "BRANCHID - Code de succursale"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "BRANCHID - Branch Code"], 10)}
}

function Get_WinQuickSearch_TabIACodes_RdoBranchCode()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOSUCC - Code de succursale"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOSUCC - Branch Code"], 10)}
}

function CheckSelectedIACodes(IACode){
    
    var NbrItem = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Count;
    Log.Message("Le nombre de clients qui ont le code de CP "+IACode+" est : "+NbrItem);
    for (var i=0; i<NbrItem; i++)
    {
      var Item = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).DataItem.RepresentativeNumber;
      if (Item == IACode) Log.Checkpoint("The item "+i+" is "+IACode);
      else Log.Error("The item "+i+" is different than "+IACode);
    }
}

function Get_WinQuickSearch_RdoIACode()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOREP - Codes de CP"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOREP - IA Codes"], 10)}
}

function CR1483_Check_BranchSelection_IACodes(vServer,Button,BranchSelection) {
         
          try {
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                   // var BranchSelection = "Toronto";
                    
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                           
                    //Accéder à l'onglet Succursales
                    Get_WinUserMultiSelection_TabBranches().Click();
                    
                    //Selectionner une Succursale exemple "Toronto"
                    Search_Branch(BranchSelection);
                    Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",BranchSelection],10).Click();
                    Get_WinUserMultiSelection_BtnApply().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
                    
                    //Valider dans la grille client que seulement les code de CP qui commence par AC sont affichés
                    CheckSelectedBranchIACodes(BranchSelection);   
                    
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));   
                                    
          }         
          finally {    
                    //Decocher Remember my selection
                    Log.Message("Décocher l'option Remember my selection");
                    Get_MenuBar_Users().Click();
                    Get_MenuBar_Users_RememberMySelection_UnCheck();
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
          }
}

function CheckSelectedBranchIACodes(BranchName){
    
    var NbrItem = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Count;
    Log.Message("Le nombre de clients de la succursale "+BranchName+" est : "+NbrItem);
    for (var i=0; i<NbrItem; i++)
    {
      var Item = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).DataItem.RepresentativeNumber;
      var Result = aqString.Find(Item, "AC");
      var Position = aqConvert.IntToStr(Result);
      if (Result != -1 && Position == 0)
         Log.Checkpoint("The Item "+i +" of IACodes start with AC: "+Item);
      else 
         Log.Error("The item "+i+" of IACodes doesn't start with AC "+Item);
    }
}

function CR1483_Check_UserSelection_IACodes(vServer,Button,UserSelection,IACode1, IACode2) {
         
          try {
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                           
                    //Accéder à l'onglet Utilisateurs
                    Get_WinUserMultiSelection_TabUsers().Click();
                    
                    //Selectionner un Utilisateur exemple "COPERN"
                    Search_Client(UserSelection);
                    Get_WinUserMultiSelection_TabUsers_DgvUsers().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter","Copernic"],10).Click();
                    Get_WinUserMultiSelection_BtnApply().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
                    
                    //Valider dans la grille client que seulement les code de CP "BD88" et "OAED" sont affichés
                    CheckSelectedMultiIACodes(IACode1,IACode2)
                    
                    
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally {         
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
          }
}


/*function Get_WinClientsQuickSearch_RdoLastName()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LASTNAME - Nom"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LASTNAME - Last Name"], 10)}
}*/

function Check_ComboIACode()
{
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForClientCreation().Click();
    var NbrItem = Get_SubMenus().ChildCount;
    var Item;
    if (NbrItem == 2) Log.Checkpoint("Le Nombre de codes de CP affichés est 2 pour COPERN");
    else Log.Error("Le nombre de codes de CP affichés est différent de celui de COPERN soit 2");
    
    for (var i=1; i<=NbrItem; i++)
    {
      if (i==1) Item = "OAED";
      else Item = "BD88";
      var IsFound = Get_SubMenus().FindChild(["ClrClassName", "WPFControlText","WPFControlOrdinalNo"], ["ComboBoxItem", Item,i], 10);
      if (IsFound)Log.Checkpoint("Le code de CP "+ Item +" appartient à COPERN existe dans la liste");
      else Log.Error("Le code de CP "+Item+" n'existe pas dans la liste")  ;
    }
}

function CheckSelectedMultiIACodes(IACode1,IACode2){
    
    var NbrItem = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Count;
    Log.Message("Le nombre de clients qui ont le code de CP "+IACode1+" et "+ IACode2+" est : "+NbrItem);
    for (var i=0; i<NbrItem; i++)
    {
      var Item = Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).DataItem.RepresentativeNumber;
      if (Item == IACode1 || Item == IACode2) Log.Checkpoint("The item "+i+" is "+IACode1 +" or "+IACode2);
      else Log.Error("The item "+i+" is different than "+IACode1+" and "+IACode2);
    }
}


function CR1483_Survol_Users_Selection_TabBranches(vServer,Button,filePath) {
         
          try {
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_TabBranches_ExpectedFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Accounts\\WinSelection\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Accounts\\WinSelection\\"+language+"\\";  
                    
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                    
                    //Vérification du titre de la fenêtre
                    aqObject.CheckProperty(Get_WinUserMultiSelection(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTitle", language+client));
                    
                    //Vérification des 3 onglets
                    Log.Message("Vérifier les trois onglets de la fenêtre Work As");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabBranches", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabUsers", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabIACodes", language+client));
                    
                    //Accéder à l'onglet Succursales
                    Get_WinUserMultiSelection_TabBranches().Click();
                    
                    //Vérification du pied de la fenêtre
                    Log.Message("Vérifier le bas de la fenêtre")
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TextNumberOfSelectedBranches(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTxtNumSelect", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ValueNumberOfSelectedBranches(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionValNumSelect", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TxtImpossibleToSelectMoreThen30Branches(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTxtImpSelect", language+client));
                    
                    //Vérification des boutons "Apply" et "Cancel"
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionBtnApply", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsEnabled", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionBtnCancel", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsEnabled", cmpEqual, true);
                    
                    //Vérification des champs de la Grille Succursales
                    Log.Message("Vérifier les entetes de la grille succursales");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChBranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChBranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchCode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChCity(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_City", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChProvince(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_Province", language+client));
                    
                    // Accéder au menu Filter (Click sur l'icone Filter
                    Get_WinUserMultiSelection_ClickButtonFilter();
                    
                    //Vérification des éléments du menu contextuel
                    Log.Message("Vérifier le menu contextuel du bouton Filter");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_AddFilter(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_AddFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_ManageFilters(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_ManageFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_FilterFields(), "Tag", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_FilterFields", language+client));
                    
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_BranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabBranches_BranchCode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_BranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabBranches_BranchName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_City(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabBranches_City", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_Province(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabBranches_Province", language+client));   
                    
                    //Validation des données exportées vers Excel
                    Get_WinUserMultiSelection_TabBranches_ButtonExportExcel().Click();
                   
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel  "+ExpectedFile);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile,ResultFolder);
                    
                    //Vérification du menu contextuel après un click droit sur une colonne
                    Log.Message("Vérifier le menu contextuel du clic droit sur une entete de la grille");
                    Get_WinUserMultiSelection_TabBranches_ChBranchCode().ClickR();
                    Get_WinUserMultiSelection_TabBranches_ChBranchCode().ClickR();
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_AddColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_AddColumn", language+client));   
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ReplaceColumnWith(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_ReplaceWith", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_RemoveThisColumn", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ColumnStatus(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_ColumnStatus", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_InsertField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_InsertField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_RemoveThisField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_DefaultConfiguration(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_DefaultConfiguration", language+client));  
                    
                    //Vérification du menu contextuel après clic droit dans la grille
                    Log.Message("Vérifier le menu contextuel après clic droit sur la grille");
                    Get_WinUserMultiSelection_TabBranches_DgBranches().ClickR();
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_Copy(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_Copy", language+client));  
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_CopyWithHeader(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_CopyWithHeader", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToFile(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToFile", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToExcel(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToExcel", language+client)); 
                    
                    //Vérification de la fenêtre de recherche "Uniquement par Nom de succursale"
                    Log.Message("Vérifier la fenêtre de recherche rapide");
                    Get_WinUserMultiSelection_TabBranches_DgBranches().Keys("F");
                    aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_QuickSearch_Title", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_QuickSearch_BtnOk", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_QuickSearch_BtnFilter", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_QuickSearch_BtnCancel", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty( Get_WinQuickSearch_LblSearch(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_QuickSearch_LblSearch", language+client));  
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_LblIn(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_QuickSearch_LblIn", language+client));  
  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchName().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_QuickSearch_RdoBranchName", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchName(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchName(), "IsEnabled", cmpEqual, true);
                    
                    Get_WinQuickSearch_BtnCancel().Click();
                    
                    //Vérifier le tri des colonnes de la grille
                    Log.Message("Vérifier le tri des colonnes de la grille");
                    //Colonne Branche Name
                    Get_WinUserMultiSelection_TabBranches_ChBranchName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchName", language+client),"BranchName");
                    Get_WinUserMultiSelection_TabBranches_ChBranchName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchName", language+client),"BranchName");

                    //Colonne Branch Code
                    Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");
                    Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");

                    //Colonne City
                    Get_WinUserMultiSelection_TabBranches_ChCity().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_City", language+client),"City");
                    Get_WinUserMultiSelection_TabBranches_ChCity().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_City", language+client),"City");

                    //Colonne Province
                    Get_WinUserMultiSelection_TabBranches_ChProvince().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_Province", language+client),"Province");
                    Get_WinUserMultiSelection_TabBranches_ChProvince().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_Province", language+client),"Province");
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally { 
                    //fermer les fichiers excel
                    CloseExcel();
          
                    //Delete files exported
                     aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory+"\CroesusTemp\\*.txt");   
                                      
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
          }
}


function CR1483_Survol_Users_Selection_TabIACodes(vServer, Button, filePath) {
         
          try {
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_TabIACodes_ExpectedFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Accounts\\WinSelection\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Accounts\\WinSelection\\"+language+"\\";  
                    
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                    
                    //Vérification du titre de la fenêtre
                    aqObject.CheckProperty(Get_WinUserMultiSelection(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTitle", language+client));
                    
                    //Vérification des 3 onglets
                    Log.Message("Vérifier les trois onglets de la fenêtre Work As");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabBranches", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabUsers", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabIACodes", language+client));
                    
                    //Accéder à l'onglet Codes de CP
                    Get_WinUserMultiSelection_TabIACodes().Click();
                    
                    //Vérification du pied de la fenêtre
                    Log.Message("Vérifier le bas de la fenêtre")
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_TxtNumberOfSelectedIACodes(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTxtNumSelectIACodes", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ValueNumberOfSelectedIACodes(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionValNumSelectIACodes", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_TxtImpossibleToSelectMoreThan30IACodes(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTxtImpSelectIACodes", language+client));
                    
                    //Vérification des boutons "Apply" et "Cancel"
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionBtnApply", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsEnabled", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionBtnCancel", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsEnabled", cmpEqual, true);
                    
                    //Ajout de la Colonne Branch Name qui n'est pas affichée
                    Add_AllColumnsWithoutProfiles(Get_WinUserMultiSelection_TabIACodes_ChName()); 
                    
                    //Vérification des champs de la Grille Codes de CP
                    Log.Message("Vérifier les entetes de la grille Codes de CP");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ChIACode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_IACode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ChBranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchCode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ChName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_Name", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ChBranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchName", language+client));
                    
                    // Accéder au menu Filter (Click sur l'icone Filter
                    Get_WinUserMultiSelection_ClickButtonFilter();
                    
                    //Vérification des éléments du menu contextuel
                    Log.Message("Vérifier le menu contextuel du bouton Filter");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_AddFilter(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_AddFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_ManageFilters(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_ManageFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_FilterFields(), "Tag", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_FilterFields", language+client));
                    
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_IACode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabIACodes_IACode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_BranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabIACodes_BranchCode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_Name(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabIACodes_Name", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_BranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabIACodes_BranchName", language+client));   
                    
                    //Validation des données exportées vers Excel
                    Get_WinUserMultiSelection_TabIACodes_ButtonExportExcel().Click();
                   
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel  "+ExpectedFile);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile,ResultFolder);
                    
                    //Vérification du menu contextuel après un click droit sur une colonne
                    Log.Message("Vérifier le menu contextuel du clic droit sur une entete de la grille");
                    Get_WinUserMultiSelection_TabIACodes_ChName().ClickR();
                    Get_WinUserMultiSelection_TabIACodes_ChName().ClickR();
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_AddColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_AddColumn", language+client));   
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ReplaceColumnWith(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_ReplaceWith", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_RemoveThisColumn", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ColumnStatus(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_ColumnStatus", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_InsertField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_InsertField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_RemoveThisField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_DefaultConfiguration(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_DefaultConfiguration", language+client));  
                    
                    //Vérification du menu contextuel après clic droit dans la grille
                    Log.Message("Vérifier le menu contextuel après clic droit sur la grille");
                    Get_WinUserMultiSelection_TabIACodes_DgvIACodes().ClickR();
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_Copy(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_Copy", language+client));  
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_CopyWithHeader(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_CopyWithHeader", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToFile(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToFile", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToExcel(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToExcel", language+client)); 
                    
                    //Vérification de la fenêtre de recherche par "IACode", et "Branch Code"
                    Log.Message("Vérifier la fenêtre de recherche rapide");
                    Get_WinUserMultiSelection_TabIACodes_DgvIACodes().Keys("F");
                    aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_Title", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_BtnOk", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_BtnFilter", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_BtnCancel", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty( Get_WinQuickSearch_LblSearch(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_LblSearch", language+client));  
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_LblIn(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_LblIn", language+client));  
  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoIACode().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_RdoIACode", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoIACode(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
                    
                    aqObject.CheckProperty(Get_WinQuickSearch_TabIACodes_RdoBranchCode().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_RdoBranchCode", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_TabIACodes_RdoBranchCode(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_TabIACodes_RdoBranchCode(), "IsEnabled", cmpEqual, true);
                    
                    Get_WinQuickSearch_BtnCancel().Click();
                    
                    //Vérifier le tri des colonnes de la grille
                    Log.Message("Vérifier le tri des colonnes de la grille Utilistaeurs");
                    //Colonne IA Code
                    Get_WinUserMultiSelection_TabIACodes_ChIACode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_IACode", language+client),"RepresentativeNumber");
                    Get_WinUserMultiSelection_TabIACodes_ChIACode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_IACode", language+client),"RepresentativeNumber");

                    //Colonne Branch Code
                    Get_WinUserMultiSelection_TabIACodes_ChBranchCode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchCode", language+client),"BranchNumber");
                    Get_WinUserMultiSelection_TabIACodes_ChBranchCode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchCode", language+client),"BranchNumber");

                    //Colonne Name
                    Get_WinUserMultiSelection_TabIACodes_ChName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_Name", language+client),"Name");
                    Get_WinUserMultiSelection_TabIACodes_ChName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_Name", language+client),"Name");

                    //Colonne Branch Name
                    Get_WinUserMultiSelection_TabIACodes_ChBranchName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchName", language+client),"BranchName");
                    Get_WinUserMultiSelection_TabIACodes_ChBranchName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchName", language+client),"BranchName");
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally { 
                    //Set the default configuration of columns
                    SetDefaultConfiguration(Get_WinUserMultiSelection_TabIACodes_ChName());
                    
                    //fermer les fichiers excel
                    CloseExcel();
          
                    //Delete files exported
                     aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory+"\CroesusTemp\\*.txt");   
                                      
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
          }
}

function CR1483_Survol_Users_Selection_TabUsers(vServer,Button,filePath) {
         
          try {
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_TabUsers_ExpectedFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Accounts\\WinSelection\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Accounts\\WinSelection\\"+language+"\\";  
                    
                    Login(vServer, userNameUNI00, passwordUNI00, language);
                    Button.Click();
                    Button.WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                    
                    //Vérification du titre de la fenêtre
                    aqObject.CheckProperty(Get_WinUserMultiSelection(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTitle", language+client));
                    
                    //Vérification des 3 onglets
                    Log.Message("Vérifier les trois onglets de la fenêtre Work As");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabBranches", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabUsers", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTabIACodes", language+client));
                    
                    //Accéder à l'onglet Utilisateurs
                    Get_WinUserMultiSelection_TabUsers().Click();
                    
                    //Vérification du pied de la fenêtre
                    Log.Message("Vérifier le bas de la fenêtre")
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_TxtNumberOfSelectedUsers(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTxtNumSelectUsers", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ValueNumberOfSelectedUsers(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionValNumSelectUsers", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_TxtNumberOfSelectedIACodes(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTxtNumSelectIACodes", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ValueNumberOfSelectedIACodes(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionValNumSelectIACodes", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_TxtImpossibleToSelectMoreThan30Users(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionTxtImpSelectUsers", language+client));
                    
                    //Vérification des boutons "Apply" et "Cancel"
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionBtnApply", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsEnabled", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelectionBtnCancel", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsEnabled", cmpEqual, true);
                    
                    //Vérification des champs de la Grille Utilisateurs
                    Log.Message("Vérifier les entetes de la grille Utilisateurs");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ChFirstName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_FirstName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ChLastName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_LastName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ChBranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ChBranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchCode", language+client));
                    
                    // Accéder au menu Filter (Click sur l'icone Filter
                    Get_WinUserMultiSelection_ClickButtonFilter();
                    
                    //Vérification des éléments du menu contextuel
                    Log.Message("Vérifier le menu contextuel du bouton Filter");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_AddFilter(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_AddFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_ManageFilters(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_ManageFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_FilterFields(), "Tag", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_FilterFields", language+client));
                    
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_BranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabUsers_BranchCode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_BranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabUsers_BranchName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_FirstName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabUsers_FirstName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_FullName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabUsers_FullName", language+client));   
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_LastName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_MenuFilter_TabUsers_LastName", language+client));   
                    
                    //Validation des données exportées vers Excel
                    Get_WinUserMultiSelection_TabUsers_ButtonExportExcel().Click();
                   
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel  "+ExpectedFile);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile,ResultFolder);
                    
                    //Vérification du menu contextuel après un click droit sur une colonne
                    Log.Message("Vérifier le menu contextuel du clic droit sur une entete de la grille");
                    Get_WinUserMultiSelection_TabUsers_ChLastName().ClickR();
                    Get_WinUserMultiSelection_TabUsers_ChLastName().ClickR();
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_AddColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_AddColumn", language+client));   
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ReplaceColumnWith(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_ReplaceWith", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_RemoveThisColumn", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ColumnStatus(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_ColumnStatus", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_InsertField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_InsertField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_RemoveThisField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_DefaultConfiguration(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_DefaultConfiguration", language+client));  
                    
                    //Vérification du menu contextuel après clic droit dans la grille
                    Log.Message("Vérifier le menu contextuel après clic droit sur la grille");
                    Get_WinUserMultiSelection_TabUsers_DgvUsers().ClickR();
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_Copy(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_Copy", language+client));  
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_CopyWithHeader(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_CopyWithHeader", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToFile(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToFile", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToExcel(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToExcel", language+client)); 
                    
                    //Vérification de la fenêtre de recherche par "Last Name", "First Name" et "Branch Code"
                    Log.Message("Vérifier la fenêtre de recherche rapide");
                    Get_WinUserMultiSelection_TabUsers_DgvUsers().Keys("F");
                    aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_Title", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_BtnOk", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_BtnFilter", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_BtnCancel", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty( Get_WinQuickSearch_LblSearch(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_LblSearch", language+client));  
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_LblIn(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_LblIn", language+client));  
  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoLastName().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_RdoLastName", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoLastName(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoLastName(), "IsEnabled", cmpEqual, true);
                    
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoFirstName().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_RdoFirstName", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoFirstName(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoFirstName(), "IsEnabled", cmpEqual, true);
                    
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchCode().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_QuickSearch_RdoBranchCode", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchCode(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchCode(), "IsEnabled", cmpEqual, true);
                    
                    Get_WinQuickSearch_BtnCancel().Click();
                    
                    //Vérifier le tri des colonnes de la grille
                    Log.Message("Vérifier le tri des colonnes de la grille Utilistaeurs");
                    //Colonne First Name
                    Get_WinUserMultiSelection_TabUsers_ChFirstName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_FirstName", language+client),"FirstName");
                    Get_WinUserMultiSelection_TabUsers_ChFirstName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_FirstName", language+client),"FirstName");

                    //Colonne Last Name
                    Get_WinUserMultiSelection_TabUsers_ChLastName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_LastName", language+client),"LastName");
                    Get_WinUserMultiSelection_TabUsers_ChLastName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_LastName", language+client),"LastName");

                    //Colonne Branch Name
                    Get_WinUserMultiSelection_TabUsers_ChBranchName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchName", language+client),"BranchName");
                    Get_WinUserMultiSelection_TabUsers_ChBranchName().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchName", language+client),"BranchName");

                    //Colonne Branch Code
                    Get_WinUserMultiSelection_TabUsers_ChBranchCode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchCode", language+client),"BranchId");
                    Get_WinUserMultiSelection_TabUsers_ChBranchCode().Click();
                    Check_columnAlphabeticalSort_CR1483( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchCode", language+client),"BranchId");
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally { 
                    //fermer les fichiers excel
                    CloseExcel();
          
                    //Delete files exported
                     aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory+"\CroesusTemp\\*.txt");   
                                      
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
          }
}
