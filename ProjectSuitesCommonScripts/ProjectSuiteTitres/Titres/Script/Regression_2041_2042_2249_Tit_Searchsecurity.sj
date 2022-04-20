//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Titres
    CR                   :  Regression
    TestLink             :  Croes-2041, Croes-2042, Croes-2249
    Description          :  Rechercher un titre par:
                            - Touche clavie
                            - Bouton recherche
                            - Menu Edition/ rechercher
                            
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-Fm-2
    Date                 :  20/03/2019
    
*/

function Regression_2041_2042_2249_Tit_Searchsecurity() {
         
      try {
            //lien pour TestLink
            Log.Message("Le script décrit la recherche d'un titre à 3 façons différentes");
            Log.Message("Le lien de test link qui suit ce message pointe sur la 1ere façon de la recherche");
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2041","Lien du Cas de test sur Testlink");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var securityDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "securityDescription", language+client);
            var securitySecurity = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "securitySecurity", language+client);
            var securitySymbol = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "securitySymbol", language+client);
            
            //Se connecter à croesus et aller au module Titre
            Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize(); 
            
            //-------------CROES-2041 Recherche d'un titre par touche de clavier ----------------------------------------------------------------------------
            //Taper une lettre exemple "a"
            Get_SecurityGrid().Keys("a");
            
            //Valider que le checkbox Description est coché
            aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoDescription(), "IsChecked", cmpEqual, true);
            aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSymbol(), "IsChecked", cmpEqual, false);
            aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSecurity(), "IsChecked", cmpEqual, false);
            
            //Saisir "Banque Nationale" et faire OK et Valider que le curseur est placé sur le premier Titre de Banque Nationale
            CheckDescription(securityDescription);
            
            //Taper un chiffre exemple "5"
            Get_SecurityGrid().Keys("5");
            
            //Valider que le checkbox "Titre" est coché
             aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSecurity(), "IsChecked", cmpEqual, true);
            
            //Saisir "456" et valider par OK et Valider que le curseur se positionne sur le premier titre qui commence par "456"
            CheckSecurity(securitySecurity);
            
            //Taper le point "."
            Get_SecurityGrid().Keys(".");
            
            //Valider que le checkbox "Symbol" est coché
            aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSymbol(), "IsChecked", cmpEqual, true);
            
            //Saisir "BCE" et valider par OK et Valider que le curseur se positionne sur le premier titre qui a le symbole BCE
            CheckSymbol(securitySymbol);
             
            //-------------CROES-2042 Recherche d'un titre par bouton rechercher ----------------------------------------------------------------------------    
            //Cliquer sur le bouton de recherche
            Get_Toolbar_BtnSearch().Click();
            
            //Valider que le checkbox Description est coché par défaut
            aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoDescription(), "IsChecked", cmpEqual, true);
            
            //Saisir "Banque Nationale" et faire OK et Valider que le curseur est placé sur le premier Titre de Banque Nationale
            CheckDescription(securityDescription);
            
            //Cliquer sur le bouton de recherche
            Get_Toolbar_BtnSearch().Click();
            
            //Cocher le bouton radio "Symbole"
            Get_WinSecuritiesQuickSearch_RdoSymbol().set_IsChecked(true);
            
            //Saisir "BCE" et valider par OK et Valider que le curseur se positionne sur le premier titre qui a le symbole BCE
            CheckSymbol(securitySymbol);
            
            //Cliquer sur le bouton de recherche
            Get_Toolbar_BtnSearch().Click();
            
            //Cocher le bouton radio "Symbole"
            Get_WinSecuritiesQuickSearch_RdoSecurity().set_IsChecked(true);
            
            //Saisir "456" et valider par OK et Valider que le curseur se positionne sur le premier titre qui commence par "456"
            CheckSecurity(securitySecurity);
            
            //-------------CROES-2249 Recherche d'un titre par Menu Edition/Rechercher ----------------------------------------------------------------------------
            //Cliquer sur le bouton Menu Edition/Rechercher
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Search().Click();
            
            //Valider que le checkbox Description est coché par défaut
            aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoDescription(), "IsChecked", cmpEqual, true);
            
            //Saisir "Banque Nationale" et faire OK et Valider que le curseur est placé sur le premier Titre de Banque Nationale
            CheckDescription(securityDescription);
            
            //Cliquer sur le bouton Menu Edition/Rechercher
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Search().Click();
            
            //Cocher le bouton radio "Symbole"
            Get_WinSecuritiesQuickSearch_RdoSymbol().set_IsChecked(true);
            
            //Saisir "BCE" et valider par OK et Valider que le curseur se positionne sur le premier titre qui a le symbole BCE
            CheckSymbol(securitySymbol);
            
            //Cliquer sur le bouton Menu Edition/Rechercher
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Search().Click();
            
            //Cocher le bouton radio "Symbole"
            Get_WinSecuritiesQuickSearch_RdoSecurity().set_IsChecked(true);
            
            //Saisir "456" et valider par OK et Valider que le curseur se positionne sur le premier titre qui commence par "456"
            CheckSecurity(securitySecurity);
          } 
      catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
      finally {         
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    //Terminate_IEProcess();
          }
}

function CheckDescription(description){
      Get_WinQuickSearch_TxtSearch().SetText(description);
      Get_WinQuickSearch_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
      var grid = NameMapping.Sys.CroesusClient.HwndSource_MainWindow.MainWindow.contentContainer.tabControl.SecurityPlugin.zsecurityPad.zsecurityGrid.RecordListControl
      if(grid.WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordSelector", "", 1).IsActive)
          aqObject.CheckProperty(grid.Items.Item(0).DataItem,"Description", cmpContains, description);
}

function CheckSecurity(security){
      Get_WinQuickSearch_TxtSearch().SetText(security);
      Get_WinQuickSearch_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
      var grid = NameMapping.Sys.CroesusClient.HwndSource_MainWindow.MainWindow.contentContainer.tabControl.SecurityPlugin.zsecurityPad.zsecurityGrid.RecordListControl
      if(grid.WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordSelector", "", 1).IsActive)
          aqObject.CheckProperty(grid.Items.Item(0).DataItem,"SecuFirm", cmpStartsWith, security);
}
function CheckSymbol(symbol){
      Get_WinQuickSearch_TxtSearch().SetText(symbol);
      Get_WinQuickSearch_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
      var grid = NameMapping.Sys.CroesusClient.HwndSource_MainWindow.MainWindow.contentContainer.tabControl.SecurityPlugin.zsecurityPad.zsecurityGrid.RecordListControl
      if(grid.WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordSelector", "", 1).IsActive)
          aqObject.CheckProperty(grid.Items.Item(0).DataItem,"Symbol", cmpStartsWith, symbol);
}
