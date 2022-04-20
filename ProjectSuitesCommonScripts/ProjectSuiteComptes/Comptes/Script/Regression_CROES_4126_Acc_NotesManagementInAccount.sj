//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/*
    Description : Valider la gestion de note dans le module Comptes.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4126
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/


function Regression_CROES_4126_Acc_NotesManagementInAccount()
{
  try{
     Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4126", "Croes-4126");
    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
    var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo_4126", language+client);
    var CompTextAddNotTestCROES4126=ReadDataFromExcelByRowIDColumnID(filePath_Accounts,"Regression", "CompTextAddNotTestCROES4126", language+client);
    var phrasePredefinie= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "phrasePredefinie", language+client);
    var phrasePredefinieModifie= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "phrasePredefinieModifie", language+client);
      
    Activate_Inactivate_Pref(userNameUNI00, "PREF_DELETE_RELATIONSHIP_COPY_NOTESS", "YES", vServerAccounts);
    Activate_Inactivate_Pref(userNameUNI00, "PREF_EXTERNAL_ACCOUNT_INSTITUTION ", "YES", vServerAccounts);
    Activate_Inactivate_Pref(userNameUNI00, "PREF_EXTERNAL_ACCOUNT_INSTITUTION_MANDATORY", "YES", vServerAccounts); 
    RestartServices(vServerAccounts);     
    
    //se connecter avec UNI00
    Login(vServerAccounts, userNameUNI00, passwordUNI00, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //Sélectionner le compte 800272-DQ
    SearchAccount(accountNo);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();
    
   //Les points de vérifications: la fenêtre d'ajout d'un compte est affichée à l'écran' 
    aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo().Parent, "VisibleOnScreen", cmpEqual, true);
    
    //cliquer sur l'onglet Note ensuite sur le bouton Ajouter
    Get_WinInfo_Notes_TabNote().Click();
    Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
    
    //Ajouter une note manuelle
    Get_WinCRUANote_GrpNote_TxtNote().set_Text(CompTextAddNotTestCROES4126);
    
    //Ajouter une phrase prédéfinies 
    Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", phrasePredefinie, 10).Click();
    Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
    Get_WinCRUANote_BtnSave().Click();
    
    //faire une modification sur la note ajoutée (ajouter [Date+Time])
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie+CompTextAddNotTestCROES4126, 10).DblClick();
    Get_WinCRUANote().WaitProperty("VisibleOnScreen", true, 20000);
    
    Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", phrasePredefinieModifie, 10).Click();
    Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
    Get_WinCRUANote_BtnSave().Click();
    
    //Valider la modification
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie+CompTextAddNotTestCROES4126+phrasePredefinieModifie, 10), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie+CompTextAddNotTestCROES4126+phrasePredefinieModifie, 10), "VisibleOnScreen", cmpEqual, true);
    
    //Supprimer la note ajoutée    
   Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie+CompTextAddNotTestCROES4126+phrasePredefinieModifie, 10).Click();
   Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
   Get_DlgConfirmation_BtnDelete().Click();
   
   //valider que la note est supprimée
   if (Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie+CompTextAddNotTestCROES4126+phrasePredefinieModifie, 10).Exists){
            Log.Error("Note field displayed. This is not expected.");
     }
    else {
            Log.Checkpoint("Note field not displayed. This is expected.");
     }
    // Ajouter de nouveau la note supprimée
    Get_WinInfo_Notes_TabGrid_BtnAdd().Click();  
    Get_WinCRUANote_GrpNote_TxtNote().set_Text(CompTextAddNotTestCROES4126);   
    
    Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", phrasePredefinie, 10).Click();
    Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
    Get_WinCRUANote_BtnSave().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 20000)
   
    //se connecter maintenant avec copern
    Terminate_CroesusProcess();
    Login(vServerAccounts, userName, psw, language);
   
    //Accès au module Comptes
    Get_ModulesBar_BtnAccounts().Click();
    
    //Sélectionner le compte 800272-DQ
    SearchAccount(accountNo);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();
    
    //Sélectionner la note crée avec UNI00
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie+CompTextAddNotTestCROES4126, 10).Click();
    
   //Il est possible de consulter la note le bouton Consulter est accesible
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(),"Enabled", cmpEqual, true)    
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(),"IsEnabled", cmpEqual, true)
        
    //il n'est pas possible de supprimer la note le bouton est grisé
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(),"Enabled", cmpEqual, false)    
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(),"IsEnabled", cmpEqual, false)
     
    //Il est possible d'ajouter un nouvelle note
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(),"Enabled", cmpEqual, true)    
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(),"IsEnabled", cmpEqual, true)
    
    //Il est possible d'imprimer
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(),"Enabled", cmpEqual, true)    
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(),"IsEnabled", cmpEqual, true)
     
    
    //Retablir la configuration initiale
    //se connecter avec UNI00
    Login(vServerAccounts, userNameUNI00, passwordUNI00, language);
    //Accès au module Comptes
    Get_ModulesBar_BtnAccounts().Click();
    
    //Sélectionner le compte 800272-DQ
    SearchAccount(accountNo);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).DblClick();
    //Supprimer la note ajoutée    
   Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phrasePredefinie+CompTextAddNotTestCROES4126, 10).Click();
   Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
   Get_DlgConfirmation_BtnDelete().Click();
   Get_WinDetailedInfo_BtnOK().Click();
   
  }
   catch(e){
     
    Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
  }
    
  finally{   
    Terminate_CroesusProcess();
    //Mettre la pref à l'état initial
    Activate_Inactivate_Pref(userNameUNI00, "PREF_DELETE_RELATIONSHIP_COPY_NOTESS", "NO", vServerAccounts);
    Activate_Inactivate_Pref(userNameUNI00, "PREF_EXTERNAL_ACCOUNT_INSTITUTION ", "NO", vServerAccounts);
    Activate_Inactivate_Pref(userNameUNI00, "PREF_EXTERNAL_ACCOUNT_INSTITUTION_MANDATORY", "NO", vServerAccounts); 
    RestartServices(vServerAccounts);
  }    
}
