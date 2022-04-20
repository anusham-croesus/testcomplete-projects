//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT CR1037_AP3_AP6_NonPresence_in_ContextualMenuOfAssetClass


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Alhassane */


function CR1037_AP30_AP31_AP32_AP33_AP34_AP35_AP36_Presence_of_btnSleeves_And_Presence_in_ContextualMenuOfAssetClass()
{
    try{   

       
    
    
       var user4=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username");
       var accountWithSleeve3= GetData(filePath_Sleeves, "DataPool_WithoutModel", 7);//800054-FS
       var accountWithoutSleeve3= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800070FS", language+client); //800070-FS
       
       
       
       Login(vServerSleeves, user4 ,psw,language);
        
       Log.Message("****************Le cas AP30 avec DALTOJ*****************");
       Presence_of_btnSleeves(user4,accountWithSleeve3,accountWithoutSleeve3);
       
       
       Log.Message("****************Le cas AP31 avec DALTOJ*****************");
       Presence_in_ContextualMenuOfAssetClass(user4,accountWithSleeve3);
       
       
       Log.Message("****************Le cas AP32 AP33 AP34 avec DALTOJ*****************");
       Presence_of_btns(user4,accountWithoutSleeve3);
       
        
	   Log.Message("****************Le cas AP35 AP36 avec DALTOJ*****************");
       Presence_of_Btns(user4,accountWithSleeve3);
       
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
function Presence_of_btnSleeves(user,accountWithSleeve,accountWithoutSleeve)
{
              
//    Login(vServerSleeves, user ,psw,language);
    Get_ModulesBar_BtnAccounts().Click();
                  
    //Valider la présence du btn segments  pour le compte avec segments        
    Get_ModulesBar_BtnAccounts().Click();         
    Search_Account(accountWithSleeve);
    DragAccountToPortfolio(accountWithSleeve); 
         
    //Verification   
    if(user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username")){
      Log.Message("Jira: CROES-5809")
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "VisibleOnScreen",cmpEqual, false);
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "IsEnabled",cmpEqual, false);
    }
    else{       
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "VisibleOnScreen",cmpEqual, true);
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "IsEnabled",cmpEqual, true);
    }      
          
    //Valider la présence du btn segments  pour le compte sans segments 
    Get_ModulesBar_BtnAccounts().Click();
                         
    Get_ModulesBar_BtnAccounts().Click();         
    Search_Account(accountWithoutSleeve);
    DragAccountToPortfolio(accountWithoutSleeve); 
   
    //Verification   
    if(user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username")){
      Log.Message("Jira: CROES-5809")
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "VisibleOnScreen",cmpEqual, false);
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "IsEnabled",cmpEqual, false);
    }
    else{       
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "VisibleOnScreen",cmpEqual, true);
      aqObject.CheckProperty(Get_PortfolioBar_BtnSleeves(), "IsEnabled",cmpEqual, true);
    } 
                            
    //Fermer l'application
//    Close_Croesus_MenuBar(); 
}

//le script      
function Presence_of_btns(user,accountWithoutSleeve)
{              
//    Login(vServerSleeves, user ,psw,language);
    Get_ModulesBar_BtnAccounts().Click();
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
    //Fermer l'application
//    Close_Croesus_MenuBar(); 
} 

//Le script
function Presence_of_Btns(user,accountWithSleeve)
{            
          
//    Login(vServerSleeves, user ,psw,language);
    Get_ModulesBar_BtnAccounts().Click();
 
    Search_Account(accountWithSleeve);
          
    //Verification AP14
    aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "VisibleOnScreen",cmpEqual, true);
    
    if(user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username")){
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, false);
    }
    else{
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, true);
    }
          
    DragAccountToPortfolio(accountWithSleeve);  
          
    //Verification AP15
    aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "VisibleOnScreen",cmpEqual, true);
    if(user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username") || user==ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username")){
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, false);
    }
    else{
      aqObject.CheckProperty(Get_Toolbar_BtnRebalance(), "IsEnabled",cmpEqual, true);
    }     
                            
    //Fermer l'application
//    Close_Croesus_MenuBar(); 
}  

//Le script
function Presence_in_ContextualMenuOfAssetClass(user,account)
{
    var itemSleeves=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
          
//    Login(vServerSleeves, user ,psw,language);
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
                            
    //Fermer l'application
//    Close_Croesus_MenuBar(); 
}   