//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT CR1037_AP3_AP6_NonPresence_in_ContextualMenuOfAssetClass
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP9_Presence_in_ContextualMenuOfAssetClass()
{
    try{                                  
         Log.Message("****************Le cas AP9 avec LOTHC*****************")
         var user1=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");
         var accountWithSleeve1= GetData(filePath_Sleeves, "DataPool_WithoutModel", 3);//800067-RE
         Presence_in_ContextualMenuOfAssetClass(user1,accountWithSleeve1)
         
         Log.Message("****************Le cas AP17 avec ADAMSJ*****************")
         var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ADAMSJ", "username");
         var accountWithSleeve2= GetData(filePath_Sleeves, "DataPool_WithoutModel", 4); //800021-GT
         Presence_in_ContextualMenuOfAssetClass(user2,accountWithSleeve2) 
         
         Log.Message("****************Le cas AP17 avec ADAMSJ*****************")
         var user3=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "VICTOM", "username");
         var accountWithSleeve3= GetData(filePath_Sleeves, "DataPool_WithoutModel", 7); //800054-FS
         Presence_in_ContextualMenuOfAssetClass(user3,accountWithSleeve3) 
         
         Log.Message("****************Le cas AP31 avec DALTOJ*****************")
         var user4=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DALTOJ", "username");
         Presence_in_ContextualMenuOfAssetClass(user4,accountWithSleeve3) 
         
         Log.Message("****************Le cas AP38 avec GALILG*****************")
         var user5=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GALILG", "username");
         Presence_in_ContextualMenuOfAssetClass(user5,accountWithSleeve3) 
         
         Log.Message("****************Le cas AP38 avec REAGAR*****************")
         var user6=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
         var accountWithSleeve6= GetData(filePath_Sleeves, "DataPool_WithoutModel", 2); //800010-JJ
         Presence_in_ContextualMenuOfAssetClass(user6,accountWithSleeve6) 
         
         Log.Message("****************Le cas AP38 avec WASHIG*****************")
         var user7=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "WASHIG", "username");
         Presence_in_ContextualMenuOfAssetClass(user7,accountWithSleeve6)
         
         Log.Message("****************Le cas AP57 avec LINCOA*****************")
         var user8=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LINCOA", "username");
         Presence_in_ContextualMenuOfAssetClass(user8,accountWithSleeve6)
         
         Log.Message("****************Le cas AP62 avec TETROA*****************")
         var user9=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "TETROA", "username");
         Presence_in_ContextualMenuOfAssetClass(user9,accountWithSleeve1)
         
         Log.Message("****************Le cas AP67 avec PELLETM*****************")
         var user10=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "PELLETM", "username");
         Presence_in_ContextualMenuOfAssetClass(user10,accountWithSleeve1)
            
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
function Presence_in_ContextualMenuOfAssetClass(user,account)
{
    var itemSleeves=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
          
    Login(vServerSleeves, user ,psw,language);
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
    Close_Croesus_MenuBar(); 
}