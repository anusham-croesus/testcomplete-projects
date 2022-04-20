//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP10_Presence_of_btnSleeves()
{
    try{   
                              
       Log.Message("****************Le cas AP10 avec LOTHC*****************")
       var user1=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");
       var accountWithSleeve1= GetData(filePath_Sleeves, "DataPool_WithoutModel", 3); //800067-RE
       var accountWithoutSleeve1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800246GT", language+client); 
       Presence_of_btnSleeves(user1,accountWithSleeve1,accountWithoutSleeve1) 
         
       Log.Message("****************Le cas AP16 avec ADAMSJ*****************")
       var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ADAMSJ", "username");
       var accountWithSleeve2= GetData(filePath_Sleeves, "DataPool_WithoutModel", 4); //800021-GT
       var accountWithoutSleeve2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800015NA", language+client); 
       Presence_of_btnSleeves(user2,accountWithSleeve2,accountWithoutSleeve2) 
       
       Log.Message("****************Le cas AP23 avec VICTOM*****************")
       var user3=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username");
       var accountWithSleeve3= GetData(filePath_Sleeves, "DataPool_WithoutModel", 7);  //800054-FS
       var accountWithoutSleeve3= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800070FS", language+client); //800070-FS
       Presence_of_btnSleeves(user3,accountWithSleeve3,accountWithoutSleeve3)
       
       Log.Message("****************Le cas AP30 avec DALTOJ*****************")
       var user4=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username");
       Presence_of_btnSleeves(user4,accountWithSleeve3,accountWithoutSleeve3)
       
       Log.Message("****************Le cas AP37 avec GALILG*****************")
       var user5=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GALILG", "username");
       Presence_of_btnSleeves(user5,accountWithSleeve3,accountWithoutSleeve3)
       
       Log.Message("****************Le cas AP44 avec REAGAR*****************")
       var user6=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
       var accountWithSleeve6= GetData(filePath_Sleeves, "DataPool_WithoutModel", 2); //800010-JJ
       var accountWithoutSleeve6= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_800066FS", language+client); //800066-FS
       Presence_of_btnSleeves(user6,accountWithSleeve6,accountWithoutSleeve6)
       
       Log.Message("****************Le cas AP51 avec WASHIG*****************")
       var user7=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username");
       Presence_of_btnSleeves(user7,accountWithSleeve6,accountWithoutSleeve6)
       
       Log.Message("****************Le cas AP56 avec LINCOA*****************")
       var user8=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username");
       Presence_of_btnSleeves(user8,accountWithSleeve6,accountWithoutSleeve6)
       
       Log.Message("****************Le cas AP61 avec TETROA*****************")
       var user9=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username");
       Presence_of_btnSleeves(user9,accountWithSleeve1,accountWithoutSleeve1)
        
       Log.Message("****************Le cas AP66 avec PELLETM*****************")
       var user10=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username");
       Presence_of_btnSleeves(user10,accountWithSleeve1,accountWithoutSleeve1)
    
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
              
    Login(vServerSleeves, user ,psw,language);
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
    Close_Croesus_MenuBar(); 
}