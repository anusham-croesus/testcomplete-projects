//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP11_AP12_AP13_Presence_of_btns()
{
   try{   
                      
       Log.Message("****************Le cas AP11 AP12 AP13 avec LOTHC*****************")
       var user1=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");
       var accountWithoutSleeve1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800246GT", language+client); ; 
       Presence_of_btns(user1,accountWithoutSleeve1)
         
       Log.Message("****************Le cas AP18 AP19 AP20 avec ADAMSJ*****************")
       var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ADAMSJ", "username");
       var accountWithoutSleeve2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800015NA", language+client);
       Presence_of_btns(user2,accountWithoutSleeve2)   
       
       Log.Message("****************Le cas AP25 AP26 AP27 avec VICTOM*****************")
       var user3=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username");
       var accountWithoutSleeve3= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800070FS", language+client);//800070-FS
       Presence_of_btns(user3,accountWithoutSleeve3)
       
       Log.Message("****************Le cas AP32 AP33 AP34 avec DALTOJ*****************")
       var user4=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username");
       Presence_of_btns(user4,accountWithoutSleeve3)
       
       Log.Message("****************Le cas AP39 AP40 AP41 avec GALILG*****************")
       var user5=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GALILG", "username");
       Presence_of_btns(user5,accountWithoutSleeve3)
       
       Log.Message("****************Le cas AP46 AP47 AP48 avec REAGAR*****************")
       var user6=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
       var accountWithoutSleeve6= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800066FS", language+client); //800066-FS
       Presence_of_btns(user6,accountWithoutSleeve6)
       
       Log.Message("****************Le cas AP53 avec WASHIG*****************")
       var user7=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username");
       Presence_of_btns(user7,accountWithoutSleeve6)
       
       Log.Message("****************Le cas AP58 avec LINCOA*****************")
       var user8=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username");
       Presence_of_btns(user8,accountWithoutSleeve6)
       
       Log.Message("****************Le cas AP63 avec TETROA*****************")
       var user9=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username");
       Presence_of_btns(user9,accountWithoutSleeve1)
       
       Log.Message("****************Le cas AP68 avec PELLETM*****************")
       var user10=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username");
       Presence_of_btns(user10,accountWithoutSleeve1)
                       
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
 
//le script      
function Presence_of_btns(user,accountWithoutSleeve)
{              
    Login(vServerSleeves, user ,psw,language);
    Get_ModulesBar_BtnAccounts().Click();
 
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
    Close_Croesus_MenuBar(); 
}      
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       