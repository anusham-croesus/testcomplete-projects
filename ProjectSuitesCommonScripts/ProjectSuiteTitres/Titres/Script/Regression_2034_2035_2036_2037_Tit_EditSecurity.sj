//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Titres
    CR                   :  Regression
    TestLink             :  Croes-2034, Croes-2035, Croes-2036, Croes-2037
    Description          :  Modifier un titre par:
                            - Bouton Info
                            - Menu Edition/ modifier
                            - Clic-droit
                            - Ctrl + E

    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-12
    Date                 :  13/03/2019
    
    NB: Ce script nécessite l'execution du script AddSecurity
    
*/

function Regression_2034_2035_2036_2037_Tit_EditSecurity() {
         
      try {
            //lien pour TestLink
            Log.Message("Le script décrit la modification d'un titre à 4 façons différentes");
            Log.Message("Le lien de test link qui suit ce message pointe sur la 1ere façon de la modification");
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2034","Lien du Cas de test sur Testlink");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var descriptionEquityButton = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityButton", language+client);
            var newFrenchDescriptionEquityButton = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionEquityButton", language+client);
            var newEnglishDescriptionEquityButton = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionEquityButton", language+client);
            var newCountry = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newCountry", language+client);
            var newPriceCurrency = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newPriceCurrency", language+client);
            
            var descriptionMutualFund = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionMutualFund", language+client);
            var newFrenchDescriptionMutualFund = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionMutualFund", language+client);
            var newEnglishDescriptionMutualFund = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionMutualFund", language+client);
            
            var descriptionBond = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionBond", language+client);
            var newFrenchDescriptionBond = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionBond", language+client);
            var newEnglishDescriptionBond = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionBond", language+client);
            
            var descriptionOption = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionOption", language+client);
            var newFrenchDescriptionOption = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionOption", language+client);
            var newEnglishDescriptionOption = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionOption", language+client);
            
            var descriptionIndex = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionIndex", language+client);
            var newFrenchDescriptionIndex = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionIndex", language+client);
            var newEnglishDescriptionIndex = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionIndex", language+client);
                        
            var descriptionFutures = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionFutures", language+client);
            var newFrenchDescriptionFutures = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionFutures", language+client);
            var newEnglishDescriptionFutures = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionFutures", language+client);
            
            var descriptionOther = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionOther", language+client);
            var newFrenchDescriptionOther = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionOther", language+client);
            var newEnglishDescriptionOther = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionOther", language+client);
            
            var descriptionEquityEditMenu  = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityEditMenu", language+client);
            var newFrenchDescriptionEquityEditMenu = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionEquityEditMenu", language+client);
            var newEnglishDescriptionEquityEditMenu = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionEquityEditMenu", language+client);
            
            var descriptionEquityClickR = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityClickR", language+client);
            var newFrenchDescriptionEquityClickR = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionEquityClickR", language+client);
            var newEnglishDescriptionEquityClickR = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionEquityClickR", language+client);
            
            var descriptionEquityCtrlE = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "descriptionEquityCtrlE", language+client);
            var newFrenchDescriptionEquityCtrlE = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newFrenchDescriptionEquityCtrlE", language+client);
            var newEnglishDescriptionEquityCtrlE = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "newEnglishDescriptionEquityCtrlE", language+client);
            
                    
            //Se connecter à croesus et aller au module Titre
            Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize(); 
                        
            //-------------CROES-2034 Modification d'un titre par bouton modifier ----------------------------------------------------------------------------
            // option Action (Equity)
            Log.Message("-------------------- Modifier tous les types titre avec le bouton Modifier ----------------------------");
            EditSecurity(descriptionEquityButton,newFrenchDescriptionEquityButton,newEnglishDescriptionEquityButton,newCountry,newPriceCurrency);
            CheckEditSecurity(newFrenchDescriptionEquityButton,newEnglishDescriptionEquityButton,newCountry,newPriceCurrency);
          
            //Option Fonds d'investissement (Mutual Fund)
            EditSecurity(descriptionMutualFund,newFrenchDescriptionMutualFund,newEnglishDescriptionMutualFund,newCountry,newPriceCurrency);
            CheckEditSecurity(newFrenchDescriptionMutualFund,newEnglishDescriptionMutualFund,newCountry,newPriceCurrency);
            Delete_SecurityInGrid(newFrenchDescriptionMutualFund,newEnglishDescriptionMutualFund);
           
            //Option Obligation (Bond)
            EditSecurity(descriptionBond,newFrenchDescriptionBond,newEnglishDescriptionBond,newCountry,newPriceCurrency);
            CheckEditSecurity(newFrenchDescriptionBond,newEnglishDescriptionBond,newCountry,newPriceCurrency);
            Delete_SecurityInGrid(newFrenchDescriptionBond,newEnglishDescriptionBond);
            
            //Option Option (Option)
            EditSecurity(descriptionOption,newFrenchDescriptionOption,newEnglishDescriptionOption,newCountry,newPriceCurrency);
            CheckEditSecurity(newFrenchDescriptionOption,newEnglishDescriptionOption,newCountry,newPriceCurrency);
            Delete_SecurityInGrid(newFrenchDescriptionOption,newEnglishDescriptionOption);
            
            //Option Indice (Index)
            if (client != "CIBC"){
                EditSecurity(descriptionIndex,newFrenchDescriptionIndex,newEnglishDescriptionIndex,newCountry,newPriceCurrency);
                CheckEditSecurity(newFrenchDescriptionIndex,newEnglishDescriptionIndex,newCountry,newPriceCurrency);
                Delete_SecurityInGrid(newFrenchDescriptionIndex,newEnglishDescriptionIndex);
            }
            //Option Contrat à terme (Futures)
            EditSecurity(descriptionFutures,newFrenchDescriptionFutures,newEnglishDescriptionFutures,newCountry,newPriceCurrency);
            CheckEditSecurity(newFrenchDescriptionFutures,newEnglishDescriptionFutures,newCountry,newPriceCurrency);
            Delete_SecurityInGrid(newFrenchDescriptionFutures,newEnglishDescriptionFutures);
           
            //Option Autre (Other)
            EditSecurity(descriptionOther,newFrenchDescriptionOther,newEnglishDescriptionOther,newCountry,newPriceCurrency);
            CheckEditSecurity(newFrenchDescriptionOther,newEnglishDescriptionOther,newCountry,newPriceCurrency);
            Delete_SecurityInGrid(newFrenchDescriptionOther,newEnglishDescriptionOther);
                 
            //-------------CROES-2035 Modification d'un titre par Menu Edition- modifier ---------------------------------------------------------------------
            Log.Message("------------------- Modifier un titre par Menu Edition- Modifier --------------------------------");
            Search_SecurityByDescription(descriptionEquityEditMenu);
            if (Get_SecurityGrid().Find("Value",descriptionEquityEditMenu,10).Exists)
            {
                Get_SecurityGrid().Find("Value",descriptionEquityEditMenu,10).Click();
                Get_MenuBar_Edit().OpenMenu();
                Get_MenuBar_Edit_Edit().Click();
                EditSecurityAlternate(newFrenchDescriptionEquityEditMenu,newEnglishDescriptionEquityEditMenu,newCountry,newPriceCurrency);
            }else {
                Log.Error("Le titre qu'on veut modifier n'existe pas");
            } 
            CheckEditSecurity(newFrenchDescriptionEquityEditMenu,newEnglishDescriptionEquityEditMenu,newCountry,newPriceCurrency);
             
            //-------------CROES-2036 Modification d'un titre par Clic-droit de la souris -------------------------------------------------------------------
            Log.Message("---------------------------- Modifier un titre par Clic-droit de la souris ---------------------------");
            Search_SecurityByDescription(descriptionEquityClickR);
            if (Get_SecurityGrid().Find("Value",descriptionEquityClickR,10).Exists)
            {
                Get_SecurityGrid().Find("Value",descriptionEquityClickR,10).ClickR();
                Get_SecurityGrid_ContextualMenu_Edit().Click();
                EditSecurityAlternate(newFrenchDescriptionEquityClickR,newEnglishDescriptionEquityClickR,newCountry,newPriceCurrency);
            }else {
                Log.Error("Le titre qu'on veut modifier n'existe pas");
            } 
            CheckEditSecurity(newFrenchDescriptionEquityClickR,newEnglishDescriptionEquityClickR,newCountry,newPriceCurrency);
            
            //-------------CROES-2037 Modification d'un titre par CTRL+E --------------------------------------------------------------------------------------
            Log.Message("----------------------------- Modifier un titre par CTRL+E -------------------------------------------");
            Search_SecurityByDescription(descriptionEquityCtrlE);
            if (Get_SecurityGrid().Find("Value",descriptionEquityCtrlE,10).Exists)
            {
                Get_SecurityGrid().Find("Value",descriptionEquityCtrlE,10).Click();
                Get_SecurityGrid().Keys("^e");
                EditSecurityAlternate(newFrenchDescriptionEquityCtrlE,newEnglishDescriptionEquityCtrlE,newCountry,newPriceCurrency);
            }else {
                Log.Error("Le titre qu'on veut modifier n'existe pas");
            } 
            CheckEditSecurity(newFrenchDescriptionEquityCtrlE,newEnglishDescriptionEquityCtrlE,newCountry,newPriceCurrency);
               
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

function EditSecurity(description,newFrenchDescription,newEnglishDescription,newCountry,newCurrency){
        Search_SecurityByDescription(description);
        if (Get_SecurityGrid().Find("Value",description,10).Exists)
        {
            Get_SecurityGrid().Find("Value",description,10).DblClick();
            Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(newFrenchDescription);
            Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(newEnglishDescription);
            Get_WinInfoSecurity_GrpDescription_CmbCountry().Click();
            Get_SubMenus().Find("Text",newCountry,10).Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_CmbCurrency().Click();
            Get_SubMenus().Find("WPFControlText",newCurrency,10).Click(); 
            Get_WinInfoSecurity_BtnOK().Click();
        }else {
            Log.Error("Le titre qu'on veut modifier n'existe pas");
        }
}

function EditSecurityAlternate(newFrenchDescription,newEnglishDescription,newCountry,newCurrency){
            Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(newFrenchDescription);
            Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(newEnglishDescription);
            Get_WinInfoSecurity_GrpDescription_CmbCountry().Click();
            Get_SubMenus().Find("Text",newCountry,10).Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_CmbCurrency().Click();
            Get_SubMenus().Find("WPFControlText",newCurrency,10).Click(); 
            Get_WinInfoSecurity_BtnOK().Click();
}

function CheckEditSecurity(newFrenchDescription,newEnglishDescription,newCountry,newCurrency){
        var description;
        if (language == "french") description = newFrenchDescription;
        else description = newEnglishDescription;
        Search_SecurityByDescription(description);
        if (Get_SecurityGrid().Find("Value",description,10).Exists)
        {
            aqObject.CheckProperty(Get_SecurityGrid().Find("Value",description,10), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_SecurityGrid().Find("Value",description,10), "VisibleOnScreen", cmpEqual, true);
            var grid = Get_MainWindow().MainWindow.contentContainer.tabControl.SecurityPlugin.zsecurityPad.zsecurityGrid.RecordListControl;
            var count = grid.Items.Count;
            for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.Description == description){
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem, "DescriptionL1", cmpEqual, newFrenchDescription);
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem, "DescriptionL2", cmpEqual, newEnglishDescription);
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem.Country, "Description", cmpEqual, newCountry);
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem, "PriceCurrency", cmpEqual, newCurrency);
                    break;
                }
            }
        }else{
            Log.Error("Le titre modifié n'existe pas");
        }
}

function Delete_SecurityInGrid(newFrenchDescription,newEnglishDescription){
      var description;
      if (language == "french") description = newFrenchDescription;
      else description = newEnglishDescription;
      Search_SecurityByDescription(description);
      if (Get_SecurityGrid().Find("Value",description,10).Exists)
      {
          Get_SecurityGrid().Find("Value",description,10).Click() ;
          Get_Toolbar_BtnDelete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       }else{
            Log.Error("Le titre modifié n'existe pas");
       }
}
