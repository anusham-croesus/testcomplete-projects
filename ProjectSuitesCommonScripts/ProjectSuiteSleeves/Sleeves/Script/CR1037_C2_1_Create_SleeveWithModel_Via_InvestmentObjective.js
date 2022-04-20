//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C2_1_Create_SleeveWithModel_Via_InvestmentObjective()
{
      try{
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username")
         var sleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
         var investmentObjective = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationGrowth", language+client);
         var model= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
         var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C2_1", language+client); 
            
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
         
                    
         Search_Account(account);
         
         AddInvestmentObjectiveItemFirmItemGrowth();
         
         DragAccountToPortfolio(account);   
         Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
                 
         //select une classe d'actif 'Titre de croissance', clique droit, créer des segments
         Get_Portfolio_AssetClassesGrid().Find("Value",sleeveDescription ,10).ClickR();
         Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
         
        //if(Get_DlgCroesus().Exists){//CP : Adaptation pour CO
        if (Get_DlgError().Exists){//CP : Adaptation pour CO
            Log.Checkpoint("Les segments ont été créés")
            Get_DlgError().Close();
          }
         else{          
            SelectSleeveWinSleevesManager(sleeveDescription);
            InsertModelWinEditSleeve(model);
            //Cliquer sur le bouton sauvegarder de la fenêtre de Gestionnaire des segments 
            Get_WinManagerSleeves_BtnSave().Click(); 
            Delay(1500);
          } 
                   
          //********************************************************Vérification***********************************************************************************       
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         
         //c) Le champ '% restant de la cible' sera = 100% - %cible de le segment (objectif), il sera prépopulé aussi.
         Check_RemainingTargetPercent()
         
         //d) Le champ 'Répartition d'actifs' sera grisé avec l'objectif de placement qu'on avait sélectionné.
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, investmentObjective);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);
                  
         //g)Le modéle choisit est affiché
         CheckThatModelBindedToSleeve( sleeveDescription,model)
         
         //a) La fenêtre 'gestionnaire des segments' doit s'afficher avec le segment classe d'actif (+ le segment divers). 
         if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Description)== unallocated && VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.Description)== sleeveDescription){
            Log.Checkpoint("Le deux segments sont présents dans le gestionnaire")
         }
         else{
            Log.Error("Le deux segments ne sint pas présents dans le gestionnaire")       
         }     
         Get_WinManagerSleeves().Close();   
         
         //b) Le %cible, %Min, %Max de le segment sont prépopulés selon l'objectif.
         Compare_GridSleeve_vs_ManagerSleeve(sleeveDescription)
           
         //e) le segment ajoutée contiendra automatiquement les positions de classe d'actif correspondante. 
         Check_Securities_of_AssetAllocation(sleeveDescription)
         
         Log.Picture(Sys.Desktop.ActiveWindow(), "Screenshot", "Extended Message Text", pmHighest);
         
         //f) le segment 'Divers' contiendra le reste des positions.
         var sumNbrPositionPortfolioGrid = Count_Nbr_of_Position_PortfolioGrid();
         Log.Message(sumNbrPositionPortfolioGrid)
         
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
  
         var sumNbrPositionWinSleevesManager = Count_Nbr_of_Position_WinSleevesManager();
         Log.Message(sumNbrPositionWinSleevesManager)
         Delay(1500)
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

//Ajout d'objectif:Equilibre (de firme)
function AddInvestmentObjectiveItemFirmItemGrowth()
{
   Get_AccountsBar_BtnInfo().Click();
   Get_WinAccountInfo_TabInvestmentObjective().Click();
   Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
   Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Growth().Click();  
   Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Growth().Click();  
   Get_WinSelectAnObjective_BtnOK().Click();
   Get_WinDetailedInfo_BtnOK().Click();
}


