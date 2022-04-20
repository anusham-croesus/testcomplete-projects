//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Securities
    CR                   :  1483
    TestLink             :  Croes-3350
    Description          :  Vérifier les libellés de la fenêtre  Travailler en tant que.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  26/11/2018
    
*/


function CR1483_Tit_Survol_Users_Selection_TabBranches() {
         
          try {
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3350","Lien du Cas de test sur Testlink");
                    
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelection_TabBranches_ExpectedFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Securities\\WinSelection\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Securities\\WinSelection\\"+language+"\\";  
                    
                    Login(vServerTitre, userNameUNI00, passwordUNI00, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Cliquer le menu Utilisateurs
                    Get_MenuBar_Users().Click();
                   
                    //Accéder à Selection "Travailler en tant que"
                    Get_MenuBar_Users_Selection().Click();
                    
                    //Vérification du titre de la fenêtre
                    aqObject.CheckProperty(Get_WinUserMultiSelection(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionTitle", language+client));
                    
                    //Vérification des 3 onglets
                    Log.Message("Vérifier les trois onglets de la fenêtre Work As");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionTabBranches", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabUsers(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionTabUsers", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabIACodes(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionTabIACodes", language+client));
                    
                    //Accéder à l'onglet Succursales
                    Get_WinUserMultiSelection_TabBranches().Click();
                    
                    //Vérification du pied de la fenêtre
                    Log.Message("Vérifier le bas de la fenêtre")
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TextNumberOfSelectedBranches(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionTxtNumSelect", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ValueNumberOfSelectedBranches(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionValNumSelect", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TxtImpossibleToSelectMoreThen30Branches(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionTxtImpSelect", language+client));
                    
                    //Vérification des boutons "Apply" et "Cancel"
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionBtnApply", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnApply(), "IsEnabled", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_WinSelectionBtnCancel", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinUserMultiSelection_BtnCancel(), "IsEnabled", cmpEqual, true);
                    
                    //Vérification des champs de la Grille Succursales
                    Log.Message("Vérifier les entetes de la grille succursales");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChBranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChBranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchCode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChCity(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_City", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ChProvince(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_Province", language+client));
                    
                    // Accéder au menu Filter (Click sur l'icone Filter
                    Get_WinUserMultiSelection_ClickButtonFilter();
                    
                    //Vérification des éléments du menu contextuel
                    Log.Message("Vérifier le menu contextuel du bouton Filter");
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_AddFilter(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_MenuFilter_AddFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_ManageFilters(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_MenuFilter_ManageFilter", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_Filter_FilterFields(), "Tag", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_MenuFilter_FilterFields", language+client));
                    
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_BranchCode(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_MenuFilter_TabBranches_BranchCode", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_BranchName(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_MenuFilter_TabBranches_BranchName", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_City(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_MenuFilter_TabBranches_City", language+client));
                    aqObject.CheckProperty(Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_Province(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_MenuFilter_TabBranches_Province", language+client));   
                    
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
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_AddColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_AddColumn", language+client));   
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ReplaceColumnWith(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_ReplaceWith", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisColumn(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_RemoveThisColumn", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_ColumnStatus(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_ColumnStatus", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_InsertField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_InsertField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_RemoveThisField(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_RemoveThisField", language+client));  
                    aqObject.CheckProperty(Get_GridHeader_ContextualMenu_DefaultConfiguration(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_DefaultConfiguration", language+client));  
                    
                    //Vérification du menu contextuel après clic droit dans la grille
                    Log.Message("Vérifier le menu contextuel après clic droit sur la grille");
                    Get_WinUserMultiSelection_TabBranches_DgBranches().ClickR();
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_Copy(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR_1483_WinSelection_ContextualMenu_Copy", language+client));  
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_CopyWithHeader(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR_1483_WinSelection_ContextualMenu_CopyWithHeader", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToFile(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToFile", language+client)); 
                    aqObject.CheckProperty(Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToExcel(), "WPFControlText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR_1483_WinSelection_ContextualMenu_ExportToExcel", language+client)); 
                    
                    //Vérification de la feêtre de recherche "Uniquement par Nom de succursale"
                    Log.Message("Vérifier la fenêtre de recherche rapide");
                    Get_WinUserMultiSelection_TabBranches_DgBranches().Keys("F");
                    aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_QuickSearch_Title", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_QuickSearch_BtnOk", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_QuickSearch_BtnFilter", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnFilter(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_QuickSearch_BtnCancel", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty( Get_WinQuickSearch_LblSearch(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_QuickSearch_LblSearch", language+client));  
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  
                    aqObject.CheckProperty(Get_WinQuickSearch_LblIn(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_QuickSearch_LblIn", language+client));  
  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchName().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_QuickSearch_RdoBranchName", language+client));  
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchName(), "IsVisible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinQuickSearch_RdoBranchName(), "IsEnabled", cmpEqual, true);
                    
                    Get_WinQuickSearch_BtnCancel().Click();
                    
                    //Vérifier le tri des colonnes de la grille
                    Log.Message("Vérifier le tri des colonnes de la grille");
                    //Colonne Branche Name
                    Get_WinUserMultiSelection_TabBranches_ChBranchName().Click();
                    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchName", language+client),"BranchName");
                    Get_WinUserMultiSelection_TabBranches_ChBranchName().Click();
                    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchName", language+client),"BranchName");

                    //Colonne Branch Code
                    if (client == "CIBC"){
                        Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
                        Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");
                        Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
                        Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");
                    }
                    else{
                        Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
                        Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");
                        Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
                        Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");
                    }
                    //Colonne City
                    Get_WinUserMultiSelection_TabBranches_ChCity().Click();
                    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_City", language+client),"City");
                    Get_WinUserMultiSelection_TabBranches_ChCity().Click();
                    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_City", language+client),"City");

                    //Colonne Province
                    Get_WinUserMultiSelection_TabBranches_ChProvince().Click();
                    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_Province", language+client),"Province");
                    Get_WinUserMultiSelection_TabBranches_ChProvince().Click();
                    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1483", "CR1483_TabBranches_Province", language+client),"Province");
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
          }
}

