//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP14_AP15_Presence_of_Btns()
{
   try{   
                      
       Log.Message("****************Le cas AP14 AP15 avec LOTHC*****************")
       var user1=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");
       var accountWithSleeve1= GetData(filePath_Sleeves, "DataPool_WithoutModel", 3); 
       Presence_of_Btns(user1,accountWithSleeve1)
         
       Log.Message("****************Le cas AP21 AP22 avec ADAMSJ*****************")
       var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ADAMSJ", "username");
       var accountWithSleeve2= GetData(filePath_Sleeves, "DataPool_WithoutModel", 4); 
       Presence_of_Btns(user2,accountWithSleeve2) 
       
       Log.Message("****************Le cas AP28 AP29 avec VICTOM*****************")
       var user3=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username");
       var accountWithSleeve3= GetData(filePath_Sleeves, "DataPool_WithoutModel", 7);//800054-FS  
       Presence_of_Btns(user3,accountWithSleeve3) 
       
       Log.Message("****************Le cas AP35 AP36 avec DALTOJ*****************")
       var user4=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username");
       Presence_of_Btns(user4,accountWithSleeve3) 
       
       Log.Message("****************Le cas AP42 AP43 avec GALILG*****************")
       var user5=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GALILG", "username");
       Presence_of_Btns(user5,accountWithSleeve3) 
        
       Log.Message("****************Le cas AP49 AP50 avec REAGAR*****************")
       var user6=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
       var accountWithSleeve6= GetData(filePath_Sleeves, "DataPool_WithoutModel", 2); //800010-JJ
       Presence_of_Btns(user6,accountWithSleeve6) 
       
       Log.Message("****************Le cas AP49 AP50 avec WASHIG*****************")
       var user7=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username");
       Presence_of_Btns(user7,accountWithSleeve6)
       
       Log.Message("****************Le cas AP59 AP60 avec LINCOA*****************")
       var user8=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username");
       Presence_of_Btns(user8,accountWithSleeve6)
       
       Log.Message("****************Le cas AP64 AP65 avec TETROA*****************")
       var user9=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username");
       Presence_of_Btns(user9,accountWithSleeve1)
       
       Log.Message("****************Le cas AP69 AP70 avec PELLETM*****************")
       var user10=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username");
       Presence_of_Btns(user10,accountWithSleeve1)
     
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
          
    Login(vServerSleeves, user ,psw,language);
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
    Close_Croesus_MenuBar(); 
}