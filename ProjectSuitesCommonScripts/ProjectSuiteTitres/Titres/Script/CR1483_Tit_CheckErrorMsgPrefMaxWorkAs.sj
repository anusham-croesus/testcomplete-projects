//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Securities
    CR                   :  1483
    TestLink             :  Croes-3352
    Description          :  Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre de succursales 
                            plus grand que la valeur de la pref on reçoit un message d'erreur. .
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  26/11/2018
    
*/


function CR1483_Tit_CheckErrorMsgPrefMaxWorkAs() {
         
          try {     
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3352","Lien du Cas de test sur Testlink");
                
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    
                    //Mettre la pref "PREF_MAX_WORKAS_ELEMENTS" à la valeur 4
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_MAX_WORKAS_ELEMENTS","4",vServerTitre);
                    RestartServices(vServerTitre);
                    
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
                                        
                    //Selectionner 5 succursales (Plus que la valeur définie dans la pref) et appliquer la selection
                    Log.Message("Selectionner les cinq (05) succursales");
                    Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
                    Get_WinUserMultiSelection_TabBranches_DgBranches().Keys("[Hold]![Down][ReleaseLast][Down][ReleaseLast][Down][ReleaseLast][Down][Release]");
                    Get_WinUserMultiSelection_BtnApply().Click();
                     
                    //Vérifier que le message d'erreur est affiché
                    aqObject.CheckProperty(Get_DlgWarning(), "Title", cmpEqual,ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_ErrorTitle", language+client));
                    aqObject.CheckProperty(Get_DlgWarning(), "CommentTag", cmpEqual,ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_TabBranches_ErrorMsg", language+client));
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
                    
                    //Remise de la pref par défaut
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_MAX_WORKAS_ELEMENTS","30",vServerTitre);
                    RestartServices(vServerTitre);
          }
}

