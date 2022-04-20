//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_V3_ColumnSleeve()
{
      try{   
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");   
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1", language+client);              
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                  
         //Valider la présence des segments         
         Get_ModulesBar_BtnAccounts().Click();
         
         Search_Account(account);
         
         //Add Column
         Get_AccountsGrid_ChName().ClickR();
         Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
         Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: HasSleeve"], 100).Click();
         
         //Verification
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",account,100).Parent.DataContext.DataItem, "HasSleeve", cmpEqual, true);
          
         //Remove Column          
         Get_AccountsGrid_ChSleeves().ClickR();
         Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();        
                                                
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         Get_ModulesBar_BtnPortfolio().Click();
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

