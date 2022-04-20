//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C2_Create_Sleeves_Via_InvestmentObjective()
{
      try{
         var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");
         var investmentObjective =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveGrowthSecurities", language+client)
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
         var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C2", language+client);  
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
         
         if(client=="RJ"){
           Search_Account(account);
           Get_AccountsBar_BtnInfo().Click();
           Get_WinAccountInfo_TabInvestmentObjective().Click();
           Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
           Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Growth().Click();  
           Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Growth().Click();  
           Get_WinSelectAnObjective_BtnOK().Click();
           Get_WinDetailedInfo_BtnOK().Click();
         }
                     
         CreateSleeveForAccount(account,investmentObjective)
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                           
         //********************************************************Vérification***********************************************************************************
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         //d) Le champ '% restant de la cible' sera = 100% - %cible de le segment (objectif), il sera prépopulé aussi.
         Check_RemainingTargetPercent()                         
         //a) La fenêtre 'gestionnaire des segments' doit s'afficher avec le segment classe d'actif ('Titre de croissance' + le segment divers).          
         //Ouvrir le Gestionnaire des segments
         Check_Presence_of_Unallocated_and_OtherSleeve(investmentObjective,unallocated)                 
         Get_WinManagerSleeves().Close();   
                               
         //c)Tous les titres de chaque classe d'actifs sont affichés dans la sleeve correspondante.
         Check_Securities_of_AssetAllocation(investmentObjective)       
         //b) Le %cible, %Min, %Max de le segment sont prépopulés selon l'objectif.
         Compare_GridSleeve_vs_ManagerSleeve(investmentObjective)              
                 
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         //Supprimer des segments 
         Delete_AllSleeves_WinSleevesManager();  
         if(client=="RJ"){
           Get_ModulesBar_BtnAccounts().Click();
           Get_AccountsBar_BtnInfo().Click();
           Get_WinAccountInfo_TabInvestmentObjective().Click();
           Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().Click();
           Get_WinDetailedInfo_BtnOK().Click();
         }
                        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user ,psw,language);
        Get_ModulesBar_BtnAccounts().Click();
        if(client=="RJ"){
           Get_ModulesBar_BtnAccounts().Click();
           Get_AccountsBar_BtnInfo().Click();
           Get_WinAccountInfo_TabInvestmentObjective().Click();
           Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().Click();
           Get_WinDetailedInfo_BtnOK().Click();
         }
        Search_Account(account);    
        DragAccountToPortfolio(account);  
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager();  
         
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function CreateSleeveForAccount(account,investmentObjective)
{                     
     Search_Account(account);
         
     DragAccountToPortfolio(account);   
     Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
                  
     //select une classe d'actif 'Titre de croissance' , clique droit, créer des segments
     Get_Portfolio_AssetClassesGrid().Find("Value",investmentObjective,10).ClickR();
     Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
         
     //if(Get_DlgCroesus().Exists){//CP : Adaptation pour CO
     if (Get_DlgError().Exists){//CP : Adaptation pour CO
        Log.Checkpoint("Les segments ont été créés")
        Get_DlgError().Close();
      }
      else{
        //Cliquer sur le bouton sauvegarder de la fenêtre de Gestionnaire des segments 
        Get_WinManagerSleeves_BtnSave().Click(); 
        Delay(1500);
      }
} 



