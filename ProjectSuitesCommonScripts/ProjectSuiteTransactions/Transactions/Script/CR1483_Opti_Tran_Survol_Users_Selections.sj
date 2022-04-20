//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Tran_Common_Functions


/*
  Description : Vérifier les libellés de la fenêtre "Travailler en tant que" (Onglets Branches, Codes CP et Utilisateurs)
  
  Regrouper les scripts suivants:
  CR1483_Tran_Survol_Users_Selection_TabUsers
  CR1483_Tran_Survol_Users_Selection_TabIACodes
  CR1483_Tran_Survol_Users_Selection_TabBranches
   
  
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation : Philippe Maurice 
  Version de scriptage:		ref90.22.2020.12-56
*/


function Opti_CR1483_Tran_Survol_Users_Selections() 
{
         
    //lien pour TestLink
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3356","Lien du Cas de test sur Testlink");
    
    try {
        
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                
        Login(vServerTransactions, userNameUNI00, passwordUNI00, language);
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        
        Log.Message("Survol Branch Tab");
        CR1483_Survol_Users_Selection_TabBranches2(vServerTransactions, Get_ModulesBar_BtnTransactions(), filePath_Transactions);
        
        Log.Message("Survol IA Code Tab");
        CR1483_Survol_Users_Selection_TabIACodes2(vServerTransactions,Get_ModulesBar_BtnTransactions(),filePath_Transactions);
        
        Log.Message("Survol User Tab");
        CR1483_Survol_Users_Selection_TabUsers2(vServerTransactions,Get_ModulesBar_BtnTransactions(),filePath_Transactions);
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



function CR1483_Survol_Users_Selection_TabBranches2(vServer, Button, filePath, ExpectedFile, ExpectedFolder, ResultFolder)
{ 
    var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR1483", "CR1483_WinSelection_TabBranches_ExpectedFile", language+client);
    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Transactions\\WinSelection\\"+language+"\\";
    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Transactions\\WinSelection\\"+language+"\\";  
    
    //Cliquer le menu Utilisateurs
    Delay(10000);
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
    //Colonne Branch Name
    Get_WinUserMultiSelection_TabBranches_ChBranchName().Click();
    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchName", language+client),"BranchName");
    Get_WinUserMultiSelection_TabBranches_ChBranchName().Click();
    Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchName", language+client),"BranchName");

    //Colonne Branch Code
    Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");
    Get_WinUserMultiSelection_TabBranches_ChBranchCode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_BranchCode", language+client),"BranchId");
                   
    //Colonne City
    Get_WinUserMultiSelection_TabBranches_ChCity().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_City", language+client),"City");
    Get_WinUserMultiSelection_TabBranches_ChCity().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_City", language+client),"City");

    //Colonne Province
    Get_WinUserMultiSelection_TabBranches_ChProvince().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_Province", language+client),"Province");
    Get_WinUserMultiSelection_TabBranches_ChProvince().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabBranches_DgBranches(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabBranches_Province", language+client),"Province");
    
    Get_WinUserMultiSelection_BtnCancel().Click();

}


function CR1483_Survol_Users_Selection_TabIACodes2(vServer, Button, filePath) {
         
    var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_TabIACodes_ExpectedFile", language+client);
    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Transactions\\WinSelection\\"+language+"\\";
    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Transactions\\WinSelection\\"+language+"\\";
                    
    //Cliquer le menu Utilisateurs
    Delay(10000);
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
  
    aqObject.CheckProperty(CR1483_Tran_Common_Functions.Get_WinQuickSearch_RdoIACode().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_RdoIACode", language+client));  
    aqObject.CheckProperty(CR1483_Tran_Common_Functions.Get_WinQuickSearch_RdoIACode(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(CR1483_Tran_Common_Functions.Get_WinQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
                    
    aqObject.CheckProperty(CR1483_Tran_Common_Functions.Get_WinQuickSearch_TabIACodes_RdoBranchCode().DataContext, "Label", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_QuickSearch_RdoBranchCode", language+client));  
    aqObject.CheckProperty(Get_WinQuickSearch_TabIACodes_RdoBranchCode(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickSearch_TabIACodes_RdoBranchCode(), "IsEnabled", cmpEqual, true);
                    
    Get_WinQuickSearch_BtnCancel().Click();
                    
    //Vérifier le tri des colonnes de la grille
    Log.Message("Vérifier le tri des colonnes de la grille Utilistaeurs");
    
    //Colonne IA Code
    Get_WinUserMultiSelection_TabIACodes_ChIACode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_IACode", language+client),"RepresentativeNumber");
    Get_WinUserMultiSelection_TabIACodes_ChIACode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_IACode", language+client),"RepresentativeNumber");

    //Colonne Branch Code
    Get_WinUserMultiSelection_TabIACodes_ChBranchCode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchCode", language+client),"BranchNumber");
    Get_WinUserMultiSelection_TabIACodes_ChBranchCode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchCode", language+client),"BranchNumber");
                    
    //Colonne Name
    Get_WinUserMultiSelection_TabIACodes_ChName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_Name", language+client),"Name");
    Get_WinUserMultiSelection_TabIACodes_ChName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_Name", language+client),"Name");

    //Colonne Branch Name
    Get_WinUserMultiSelection_TabIACodes_ChBranchName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchName", language+client),"BranchName");
    Get_WinUserMultiSelection_TabIACodes_ChBranchName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabIACodes_DgvIACodes(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabIACodes_BranchName", language+client),"BranchName");
    
    Get_WinUserMultiSelection_BtnCancel().Click();
}



function CR1483_Survol_Users_Selection_TabUsers2(vServer,Button,filePath) {

    var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_TabUsers_ExpectedFile", language+client);
    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Transactions\\WinSelection\\"+language+"\\";
    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Transactions\\WinSelection\\"+language+"\\";  
                    
    //Cliquer le menu Utilisateurs
    Delay(10000);
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
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_FirstName", language+client),"FirstName");
    Get_WinUserMultiSelection_TabUsers_ChFirstName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_FirstName", language+client),"FirstName");

    //Colonne Last Name
    Get_WinUserMultiSelection_TabUsers_ChLastName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_LastName", language+client),"LastName");
    Get_WinUserMultiSelection_TabUsers_ChLastName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_LastName", language+client),"LastName");

    //Colonne Branch Name
    Get_WinUserMultiSelection_TabUsers_ChBranchName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchName", language+client),"BranchName");
    Get_WinUserMultiSelection_TabUsers_ChBranchName().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchName", language+client),"BranchName");

    //Colonne Branch Code
    Get_WinUserMultiSelection_TabUsers_ChBranchCode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchCode", language+client),"BranchId");
    Get_WinUserMultiSelection_TabUsers_ChBranchCode().Click();
    CR1483_Tran_Common_Functions.Check_columnAlphabeticalSort( Get_WinUserMultiSelection_TabUsers_DgvUsers(),ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_TabUsers_BranchCode", language+client),"BranchId");
                  
    Get_WinUserMultiSelection_BtnCancel().Click();
}