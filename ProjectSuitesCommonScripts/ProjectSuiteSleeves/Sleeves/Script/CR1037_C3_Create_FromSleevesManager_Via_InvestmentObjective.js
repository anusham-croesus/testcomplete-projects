//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C3_Create_FromSleevesManager_Via_InvestmentObjective()
{
      try{
         
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username")
         var sleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
         var investmentObjective=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationGrowth", language+client);
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C3", language+client);
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
                                  
         CreateSleeveForAccount(account,sleeveDescription)
         
         //a) Dès qu'on sélectionne une classe: Les champs %Min, %Max et %Cible sont prépopulés selon l'objectif sélectionné.%Cibe=50, Min=30 et Max=50.         
         Compare_GridSleeve_vs_ManagerSleeve(sleeveDescription)
        
         //b) Le champ '% restant de la cible sera = 100-50=50 de le segment (objectif), il sera prépopulé aussi.
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         Check_RemainingTargetPercent()
        
         //c) Le champ 'Répartition d'actifs' sera grisé avec l'objectif de placement qu'on avait sélectionné 'Croissance'.
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, investmentObjective);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);
         Get_WinManagerSleeves().Close();
         
         //d)Tous les titres de classe d'actifs 'Actions cannadiennes' sont affichés dans la sleeve correspondante ( 'Actions cannadiennes').          
         Check_Securities_of_AssetAllocation(sleeveDescription)
          
        //e) le segment 'Divers' contiendra le reste des positions.*/
         var sumNbrPositionPortfolioGrid = Count_Nbr_of_Position_PortfolioGrid();
  
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
  
         var sumNbrPositionWinSleevesManager = Count_Nbr_of_Position_WinSleevesManager();
  
         Check_of_Rest_Positions_in_Unallocated(sumNbrPositionPortfolioGrid,sumNbrPositionWinSleevesManager) 
    
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
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function AddInvestmentObjectiveItemFirmItemGlobalGrowth()
{
   Get_AccountsBar_BtnInfo().Click();
   Get_WinAccountInfo_TabInvestmentObjective().Click();
   Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
   Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Growth().Click();  
   Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Growth().Click();   
   Get_WinSelectAnObjective_BtnOK().Click();
   Get_WinDetailedInfo_BtnOK().Click();
}


function CreateSleeveForAccount(account,sleeveDescription)
{
   Search_Account(account);
   AddInvestmentObjectiveItemFirmItemGlobalGrowth();
         
   DragAccountToPortfolio(account);   
   Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
         
   //Ajouter le 'segments' 
   Get_PortfolioBar_BtnSleeves().Click();
   Get_WinManagerSleeves().Parent.Maximize();
         
   Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
   AddEditSleeveWinSleevesManager(sleeveDescription,sleeveDescription,null,null,null)
   Get_WinManagerSleeves_BtnSave().Click();
}

