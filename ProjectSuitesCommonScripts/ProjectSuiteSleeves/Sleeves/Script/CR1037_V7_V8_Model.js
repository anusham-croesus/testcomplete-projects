//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_V7_V8_Model()
{
      try{   
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");            
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1", language+client); 
         var name=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNumberFullName_V7", language+client);
         var sleeveDescription= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
         var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
 
         Search_Account(account);
         
         DragAccountToPortfolio(account);  
         
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(sleeveDescription,sleeveDescription,"","","",model)                  
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500)
                                     
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                 
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         CheckThatModelBindedToSleeve( sleeveDescription,model)
         Get_WinManagerSleeves().Close();
         
         //******************************************Vérification******************************************************************************************************
         Get_ModulesBar_BtnModels().Click();  
         
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
         Get_Models_Details_TabAssignedPortfolios().Click();
                          
         Get_ModelsGrid().Find("Value",model,100).Click();
         
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).DataContext.DataItem, "AccountNumber", cmpEqual, account);
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).DataContext.DataItem, "SleeveName", cmpEqual, sleeveDescription);
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).DataContext.DataItem, "FullName", cmpEqual, name);
         
         
         if(Get_Models_Details_TabAssignedPortfolios_ChSleeveDescription().Exists){
            Log.Checkpoint("la nouvelle colonne dans le module modèles est affichée")
         }
         else{
            Log.Error("la nouvelle colonne dans le module modèles n'est pas affichée")
         }
                                 
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         //Supprimer des segments 
         Get_ModulesBar_BtnPortfolio().Click();                    
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

