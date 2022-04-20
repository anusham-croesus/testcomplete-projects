//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Titres
    CR                   :  Regression
    TestLink             :  Croes-2030, Croes-2031, Croes-2032, Croes-2033
    Description          :  Ajouter un titre par:
                            - Bouton ajouter
                            - Menu Edition/ ajouter
                            - Clic-droit
                            - Ctrl + N
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-12
    Date                 :  13/03/2019
    
*/

function Regression_2030_2031_2032_2033_Tit_AddSecurity() {
         
      try {
            //lien pour TestLink
            Log.Message("Le script décrit l'ajout d'un titre à 4 façons différentes");
            Log.Message("Le lien de test link qui suit ce message pointe sur la 1ere façon de l'ajout");
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2030","Lien du Cas de test sur Testlink");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var frenchDescriptionEquityButton = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionEquityButton", language+client);
            var englishDescriptionEquityButton = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionEquityButton", language+client);
            var country = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "country", language+client);
            var StrikePrice = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "StrikePrice", language+client);
            
            var frenchDescriptionMutualFund = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionMutualFund", language+client);
            var englishDescriptionMutualFund = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionMutualFund", language+client);
           
            var frenchDescriptionBond = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionBond", language+client);
            var englishDescriptionBond = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionBond", language+client);
            
            var frenchDescriptionOption = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionOption", language+client);
            var englishDescriptionOption = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionOption", language+client);
            
            var frenchDescriptionIndex = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionIndex", language+client);
            var englishDescriptionIndex = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionIndex", language+client);
                        
            var frenchDescriptionFutures = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionFutures", language+client);
            var englishDescriptionFutures = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionFutures", language+client);
            
            var frenchDescriptionOther = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionOther", language+client);
            var englishDescriptionOther = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionOther", language+client);
            
            var frenchDescriptionEquityEditMenu = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionEquityEditMenu", language+client);
            var englishDescriptionEquityEditMenu = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionEquityEditMenu", language+client);
            
            var frenchDescriptionEquityClickR = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionEquityClickR", language+client);
            var englishDescriptionEquityClickR = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionEquityClickR", language+client);
            
            var frenchDescriptionEquityCtrlN = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "frenchDescriptionEquityCtrlN", language+client);
            var englishDescriptionEquityCtrlN = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "englishDescriptionEquityCtrlN", language+client);
                    
            //Se connecter à croesus et aller au module Titre
            Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize(); 
            
            
            //-------------CROES-2030 Ajout d'un titre par bouton ajouter ----------------------------------------------------------------------------
            // option Action (Equity)
            Log.Message("----------------- Ajout de tous les types titre avec le bouton Ajouter ----------------------");
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemEquity(),frenchDescriptionEquityButton, englishDescriptionEquityButton, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionEquityButton);
            else Check_SecurityInGrid(englishDescriptionEquityButton);
                
            //Option Fonds d'investissement (Mutual Fund)
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemMutualFund(),frenchDescriptionMutualFund, englishDescriptionMutualFund, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionMutualFund);
            else Check_SecurityInGrid(englishDescriptionMutualFund);
           
            //Option Obligation (Bond)
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemBond(),frenchDescriptionBond, englishDescriptionBond, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionBond);
            else Check_SecurityInGrid(englishDescriptionBond);
            
            //Option Option (Option)
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemOption(),frenchDescriptionOption, englishDescriptionOption, country,StrikePrice);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionOption);
            else Check_SecurityInGrid(englishDescriptionOption);
            
            //Option Indice (Index)
            if (client != "CIBC"){
                Get_Toolbar_BtnAdd().Click();
                WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
                Add_Security(Get_WinCreateSecurity_LstCategories_ItemIndex(),frenchDescriptionIndex, englishDescriptionIndex, country);
                if (language == "french") Check_SecurityInGrid(frenchDescriptionIndex);
                else Check_SecurityInGrid(englishDescriptionIndex);
                }
            //Option Contrat à terme (Futures)
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemFutures(),frenchDescriptionFutures, englishDescriptionFutures, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionFutures);
            else Check_SecurityInGrid(englishDescriptionFutures);
            
            //Option Autre (Other)
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemOther(),frenchDescriptionOther, englishDescriptionOther, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionOther);
            else Check_SecurityInGrid(englishDescriptionOther);
                       
            //-------------CROES-2031 Ajout d'un titre par Menu Edition- ajouter ---------------------------------------------------------------------
            Log.Message("---------------------- Ajout d'un titre par Menu Edition- Ajouter -----------------");
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Add().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemEquity(),frenchDescriptionEquityEditMenu, englishDescriptionEquityEditMenu, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionEquityEditMenu);
            else  Check_SecurityInGrid(englishDescriptionEquityEditMenu);

            //-------------CROES-2032 Ajout d'un titre par Clic-droit de la souris -------------------------------------------------------------------
            Log.Message("-------------------- Ajout d'un titre par Clic-droit de la souris ------------------");
            Get_SecurityGrid().ClickR() ;
            Get_SecurityGrid_ContextualMenu_Add().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemEquity(),frenchDescriptionEquityClickR, englishDescriptionEquityClickR, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionEquityClickR);
            else Check_SecurityInGrid(englishDescriptionEquityClickR);
               
            //-------------CROES-2033 Ajout d'un titre par CTRL+N --------------------------------------------------------------------------------------
            Log.Message("------------------ Ajout d'un titre par CTRL+N -------------------------------------");
            Get_SecurityGrid().Keys("^n");
            WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
            Add_Security(Get_WinCreateSecurity_LstCategories_ItemEquity(),frenchDescriptionEquityCtrlN, englishDescriptionEquityCtrlN, country);
            if (language == "french") Check_SecurityInGrid(frenchDescriptionEquityCtrlN);
            else Check_SecurityInGrid(englishDescriptionEquityCtrlN);    
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

function Add_Security(Item,frenchDescription,englishDescription,country,StrikePrice){
      var text = Item.WPFControlText;
      Item.Click();
      Get_WinCreateSecurity_BtnOK().Click();
      WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
      
      //Champs obligatoire communs entre tous les types
      Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(frenchDescription);
      Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(englishDescription);
      Get_WinInfoSecurity_GrpDescription_CmbCountry().Click();
      Get_SubMenus().Find("WPFControlText",country,10).Click();
      // Champs obligatoire pour le type Bond
      if (text == "[Bond, Obligation]" || text == "[Bond, Bond]"){
            ClickOnCalendarEcheance();
      }
      //Champs obligatoire pour le type Option
      if (text == "[Option, Option]"){
            Get_WinInfoSecurity_GrpDescription_TxtStrikePrice().Keys(StrikePrice);
            var fieldExpiration = Get_WinInfoSecurity().WPFObject("GroupBox", "Description", 1).WPFObject("DateField", "", 5);
            fieldExpiration.Click(fieldExpiration.Width-10,fieldExpiration.Height-10);
            Get_Calendar_BtnOK().Click();
            Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_BtnChange().Click()
            Get_WinPickerWindow().Click();
            Get_WinPickerWindow_BtnOK().Click();
      }
      //Champs obligatoires pour le type Contrat à terme
      if (text == "[Future, Contrat à terme]" || text == "[Future, Futures]"){
           ClickOnCalendarEcheance();
      } 
      
      Get_WinInfoSecurity_BtnOK().Click();
      if (Get_DlgConfirmation().Exists)
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448"); 
}
function Check_SecurityInGrid(description){
      Search_SecurityByDescription(description);
      aqObject.CheckProperty(Get_SecurityGrid().Find("Value",description,10), "Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_SecurityGrid().Find("Value",description,10), "VisibleOnScreen", cmpEqual, true);   
}

function Delete_SecurityInGrid(description){
      Get_SecurityGrid().Find("Value",description,10).Click() ;
      Get_Toolbar_BtnDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
}

function ClickOnCalendarEcheance(){
      if (language == "english") var fieldCalendar = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("GroupBox", "Dividends", 3).WPFObject("DateField", "", 1);
      else  var fieldCalendar = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("GroupBox", "Dividendes", 3).WPFObject("DateField", "", 1);
      fieldCalendar.Click(fieldCalendar.Width-10,fieldCalendar.Height-10)
      Get_Calendar_BtnOK().Click();
}

function ClickOnCalendarExpiration(){
      if (language == "english") var fieldCalendar = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("GroupBox", "Dividends", 3).WPFObject("DateField", "", 1);
      else  var fieldCalendar = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("GroupBox", "Dividendes", 3).WPFObject("DateField", "", 1);
      fieldCalendar.Click(fieldCalendar.Width-10,fieldCalendar.Height-10);
      Get_Calendar_BtnOK().Click();
}

