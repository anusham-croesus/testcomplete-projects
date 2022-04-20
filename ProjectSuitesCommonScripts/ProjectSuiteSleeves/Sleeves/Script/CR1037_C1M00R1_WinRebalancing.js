//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective
//USEUNIT DBA

//USEUNIT Portefeuille_Get_functions


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1M00R1_WinRebalancing()
{
      try{   
      
         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");   
         var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1M00R1", language+client);   
                    
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         //Afficher la fenêtre «Méthode de rééquilibrage»
         Get_Toolbar_BtnRebalance().Click();
                                
         //******************************************Vérification******************************************************************************************************
          
        aqObject.CheckProperty(Get_WinRebalancingMethod().Title, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinRebalancingMethodTitle", language+client));
        aqObject.CheckProperty(Get_WinRebalancingMethod_GrpParameters(), "Header", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinRebalancingMethodGrpParametersHeader", language+client));
     
        aqObject.CheckProperty(Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinRebalancingMethodGrpParametersRdoRebalanceAccount", language+client));
        aqObject.CheckProperty(Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinRebalancingMethodGrpParametersRdoRebalanceAllSleeves", language+client));
        aqObject.CheckProperty(Get_WinRebalancingMethod_BtnOK(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinRebalancingMethodBtnOK", language+client));
        aqObject.CheckProperty(Get_WinRebalancingMethod_BtnCancel(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinRebalancingMethodBtnCancel", language+client));
        
        aqObject.CheckProperty(Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalancingMethod_BtnOK(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalancingMethod_BtnCancel(), "IsVisible", cmpEqual, true);

        Get_WinRebalancingMethod_BtnCancel().Click();
                            
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         //Supprimer des segments 
         Delete_AllSleeves_WinSleevesManager();  
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
        //Remettre les données a l'êtas initial dans le cas d'erreur 
        Login(vServerSleeves, user ,psw,language);
        Get_ModulesBar_BtnAccounts().Click();
 
        Search_Account(account);    
        DragAccountToPortfolio(account);  
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager(); 
    }
    finally {
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

