//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Securities
    CR                   :  1483
    TestLink             :  Croes-3351
    Description          :  Vérifier l'option "Remember my selection" du menu Users.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  26/11/2018
    
*/


function CR1483_Tit_RememberMySelection() {
         
          try {
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3351","Lien du Cas de test sur Testlink");          
          
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    
                    Login(vServerTitre, userNameUNI00, passwordUNI00, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                           
                    //Accéder à l'onglet Succursales
                    Get_WinUserMultiSelection_TabBranches().Click();
                    
                    //Selectionner un filtre et appliquer exemple "Toronto"
                    Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
                    Get_WinUserMultiSelection_BtnApply().Click();
                    //WaitUntilObjectDisappears(Get_WinUserMultiSelection(),"",15000)
                    Delay(1500)
                    //Valider le titre de la fenêtre Croesus avec la nouvelle selection
                    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_Toronto", language+client));
                    
                    // Cocher l'option "Remember my selection
                    Log.Message("Cocher l'option Remember my selection");
                    Get_MenuBar_Users().Click();
                    Delay(1500)
                    Get_MenuBar_Users_RememberMySelection_Check()
                    
                    //Fermer Croesus
                    Terminate_CroesusProcess();
                    
                    //Reconnecter à Croesus
                    Login(vServerTitre, userNameUNI00, passwordUNI00, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Valider que la selection est toujours prise en charge
                    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_Toronto", language+client));
                    
                    //Decocher Remember my selection
                    Log.Message("Décocher l'option Remember my selection");
                    Get_MenuBar_Users().Click();
                    Get_MenuBar_Users_RememberMySelection_UnCheck()
                    
                    //Appliquer une selection
                    Log.Message("Selectionner les trois premières succursales");
                    Get_MenuBar_Users().Click();
                    Get_MenuBar_Users_Selection().Click();
                    Get_WinUserMultiSelection_TabBranches().Click();
                    Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
                    Get_WinUserMultiSelection_TabBranches_DgBranches().Keys("[Hold]![Down][ReleaseLast][Down][Release]");
                    Get_WinUserMultiSelection_BtnApply().Click();
                    Delay(10000)
                    //Valider le titre de la fenêtre Croesus avec la nouvelle selection
                    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_TorontoLavalSherbrooke", language+client));
                    
                    //Fermer Croesus
                    Terminate_CroesusProcess();
                    
                    //Reouvrir Croesus
                    Login(vServerTitre, userNameUNI00, passwordUNI00, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Valider que la selection précédente n'est pas prise en charge
                    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_Uni00", language+client));
                   
                    
                   
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally {         
                    // Close Croesus 
                    Terminate_CroesusProcess();
          }
}

function test(){
    
                 aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_TorontoLavalSherbrooke", language+client));

}


