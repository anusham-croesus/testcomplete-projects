//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT CR1037_AP3_AP6_NonPresence_in_ContextualMenuOfAssetClass

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_Fron_AP16_To_AP22_Presence_of_btnSleeves_With_UserAdamsJ()
{
   try{   
                      

       var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ADAMSJ", "username");
       var accountWithSleeve2= GetData(filePath_Sleeves, "DataPool_WithoutModel", 4); //800021-GT
       var accountWithoutSleeve2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800015NA", language+client);
      
       
       Log.PopLogFolder();
       logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec  ADAMSJ  ");
       Login(vServerSleeves, user2 ,psw,language);
       
       Log.PopLogFolder();
       logEtape2 = Log.AppendFolder("Étape 2: Valider la presence du bouton Sleeve dans le modile portefeilles pour un sleevé avec  ADAMSJ  "); 
       Presence_of_Btns(user2,accountWithSleeve2) 
       
       //Log.Message("****************Le cas AP17 avec ADAMSJ*****************")
       Log.PopLogFolder();
       logEtape3 = Log.AppendFolder("Étape 3: Valider la presence de l'option Sleeve dans la liste repartion d'active de la section sommaire avec  ADAMSJ  "); 
       Presence_in_ContextualMenuOfAssetClass(user2,accountWithSleeve2)
       
       
       
       //Log.Message("****************Le cas AP18 AP19 AP20 avec ADAMSJ*****************")
       Log.PopLogFolder();
       logEtape4 = Log.AppendFolder("Étape 4: Valider la presence des boutons :Ajouter, Modifier, supprimer et deplacer de la fenetre creation des sleeve  ");
       Presence_of_btns(user2,accountWithoutSleeve2)
        
       //Fermer l'application
       Close_Croesus_MenuBar(); 
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus     
    }
} 

//Le script
function Presence_of_Btns(user,accountWithSleeve)
{            
          
   
    Get_ModulesBar_BtnAccounts().Click();
 
    Search_Account(accountWithSleeve);
          
    //Verification AP14
    aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "VisibleOnScreen",cmpEqual, true);
          
    DragAccountToPortfolio(accountWithSleeve);  
    if(user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username")){
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, false);
    }
    else{
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, true);
    }
          
    //Verification AP15
    aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "VisibleOnScreen",cmpEqual, true);
    if(user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username")){
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, false);
    }
    else{
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, true);
    }     
                            
    
}

//Le script

function Presence_in_ContextualMenuOfAssetClass(user,account)
{
    var itemSleeves=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
          
    
    Get_ModulesBar_BtnAccounts().Click();
                  
    //Valider la présence des segments         
    Get_ModulesBar_BtnAccounts().Click();         
    Search_Account(account);
    DragAccountToPortfolio(account); 
         
    //Verification
    if(CheckNonPresenceOfItemInContextualMenuAssetAllocation(itemSleeves)){
      Log.Checkpoint("L'item "+itemSleeves+" est présent")
    }
    else{
      Log.Error("L'item "+itemSleeves+" n'est pas présent")
      Log.Message("CROES-5795. Le texte 'Segment' devrait être au pluriel.")  
    }
                            
     
}

function CheckNonPresenceOfItemInContextualMenuAssetAllocation(item)
{
  Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().DropDown();
  
   var found=false;   
   var count = Get_SubMenus().ChildCount
  
   for(var i=1; i<=count; i++){  
      //Log.Message(Get_SubMenus().WPFObject("ComboBoxItem", "", i).WPFControlText)
      if(Get_SubMenus().WPFObject("ComboBoxItem", "", i).WPFControlText==item){         
          found=true;
          break;
      }
   }
  return found;
}

//le script      
function Presence_of_btns(user,accountWithoutSleeve)
{              

    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
    while (Get_ModulesBar_BtnAccounts().IsChecked == false){ 
    Get_ModulesBar_BtnAccounts().Click();
    }
    
 
    Search_Account(accountWithoutSleeve);
          
    DragAccountToPortfolio(accountWithoutSleeve);   
    // grouper par classe d'actif
    Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
    //sélectionner tous les regroupement
    Get_Portfolio_Tab(1).Click();
    Get_Portfolio_Tab(1).Keys("^a");
    //faire un right-click ensuite choisir créer des segements
    Get_PortfolioPlugin().ClickR();
     
    if(user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username")){
      //Verification
      aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_CreateSleeves(), "VisibleOnScreen",cmpEqual, false);
    }
    else{     
      //Verification
      aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_CreateSleeves(), "VisibleOnScreen",cmpEqual, true);
      Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
          
      //Verification
      aqObject.CheckProperty(Get_WinManagerSleeves(), "VisibleOnScreen",cmpEqual, true);         
      aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnAdd(), "VisibleOnScreen",cmpEqual, true);  
      aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnAdd(), "IsEnabled",cmpEqual, true); 
                  
      aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnEdit(), "VisibleOnScreen",cmpEqual, true); 
      aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnEdit(), "IsEnabled",cmpEqual, false);
    
        if( user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ADAMSJ", "username")|| user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username")){ //user qui ne peux pas suprimer des sleeves       
          aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnDelete(), "VisibleOnScreen",cmpEqual, false);
        }
        else{     
          aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnDelete(), "VisibleOnScreen",cmpEqual, true); 
          aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_BtnDelete(), "IsEnabled",cmpEqual, false); 
        } 
                   
      aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove(), "VisibleOnScreen",cmpEqual, true);
      aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove(), "IsEnabled",cmpEqual, false);
          
      Get_WinManagerSleeves_BtnCancel().Click()
    }                        
 
}      
       
       
       