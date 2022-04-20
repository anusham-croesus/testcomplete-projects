//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1MO2_Edit_Sleeve()
{
      try{   
         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");  
         var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1", language+client);     
         var sleeveDescription= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
         var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C1MO2", language+client);
         var min=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C1MO2", language+client);
         var max=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C1MO2", language+client);
                    
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }        
         
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize(); 
         //Modifier le segment 
         SelectSleeveWinSleevesManager(sleeveDescription)
         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
         AddEditSleeveWinSleevesManager("","",target,min,max,model)                  
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500)
   
         //******************************************Vérification******************************************************************************************************
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();  
          
         //a-Les valeurs sont :% Cible=15 , Min =10 , Max=30 - branche long terme
         Check_MinMaxTarget_of_Sleeve(min,max,target,sleeveDescription)         
         //b-Le champ '% restant de la cible = 05% de le segment. (5,00)
         Check_RemainingTargetPercent();        
         //c- Mobéle CH CANADIAN EQUITIES est relié à la sleeve Actions Canadiennes.
         CheckThatModelBindedToSleeve( sleeveDescription,model)
         
         Get_WinManagerSleeves().Close();                                        
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