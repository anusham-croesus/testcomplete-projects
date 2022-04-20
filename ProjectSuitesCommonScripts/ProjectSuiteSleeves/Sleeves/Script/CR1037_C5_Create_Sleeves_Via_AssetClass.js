//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C5_Create_Sleeves_Via_AssetClass()
{
      try{  
       
         var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username") 
         var sleeveDescription =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
         var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C5", language+client);  
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C5", language+client);
         var assetAllocation= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationFirm", language+client);
           
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
                               
         Search_Account(account);
         
         DragAccountToPortfolio(account); 
         Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
         
         //select une classe d'actif 'Actions cannadiennes' , clique droit, créer des segments
         Get_Portfolio_AssetClassesGrid().Find("Value",sleeveDescription,10).ClickR();
         Get_Portfolio_AssetClassesGrid().Find("Value",sleeveDescription,10).ClickR();
         
         Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
         
         //if(Get_DlgCroesus().Exists){//CP : Adaptation pour CO
         if (Get_DlgError().Exists){//CP : Adaptation pour CO
            Log.Checkpoint("Les segments ont été créés")
            Get_DlgError().Close();
          }
          else{
            //Cliquer sur le bouton sauvegarder de la fenêtre de Gestionnaire des segments 
            Get_WinManagerSleeves().Parent.Maximize();
            SelectSleeveWinSleevesManager(sleeveDescription);
            Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
            AddEditSleeveWinSleevesManager(sleeveDescription,"",target,"","","")
            Get_WinManagerSleeves_BtnSave().Click(); 
            Delay(1500);
          }  
                                          
         //******************************************Vérification******************************************************************************************  
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();

         //a) La fenêtre 'gestionnaire des segments' doit s'afficher avec le segment classe d'actif  'Actions cannadiennes'(+ le segment divers).
         //Ouvrir le Gestionnaire des segments
         Check_Presence_of_Unallocated_and_OtherSleeve(sleeveDescription,unallocated)                  
         //b) Le %cible=10, %Min, %Max de le segment sont à 10 et pour le segment Divers = n/d
         Check_MinMaxTarget_of_Sleeve(target,target,target,sleeveDescription)         
         //d) Le champ 'Répartition d'actifs' sera grisé avec la répartition du compte.
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, assetAllocation);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);               
         //c) Le champ '% restant de la cible' sera =90 (100-%cible de le segment).
         Check_RemainingTargetPercent()
         
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