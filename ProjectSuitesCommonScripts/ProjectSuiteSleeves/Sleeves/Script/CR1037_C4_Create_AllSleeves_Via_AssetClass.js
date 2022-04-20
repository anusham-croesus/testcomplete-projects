//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C4_Create_AllSleeves_Via_AssetClass()
{
      try{         
         var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username")
         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C4", language+client);  
         var remainingTargetPercent =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleevesGrpSleevesTxtRemainingTargetPercent_C4", language+client);
         var assetAllocation=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationFirm", language+client);
         
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
         
                    
         Search_Account(account);
          
         DragAccountToPortfolio(account);   
         CreateSleeveByAssetClass();  
      
         //Vérifier que des segments ont été créés
         //faire un right-click ensuite choisir créer des segements
         Get_PortfolioPlugin().ClickR();
         Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click(); 
        
        //if(Get_DlgCroesus().Exists){//CP : Adaptation pour CO
        if (Get_DlgError().Exists){//CP : Adaptation pour CO
           Log.Checkpoint("Les segments pour le compte "+ account +" ont été créés")
           Get_DlgError().Close();
         }
         else{
           Log.Error("Les segments  pour le compte "+ account +"n'ont pas été créés")
         }
               
         //******************************************Vérification******************************************************************************************  
         
         //a) La fenêtre 'gestionnaire des segments' doit s'afficher avec les segments (chaque segment correspond à une classe d'actif + le segment divers).
         //b) Les cibles de chaque segment sont à 0 
         //f) La fenêtre 'gestionnaire des segments' doit s'afficher avec les segments identique au point a)
         var sleeveDescription=GetAssetClassDescription();
         var targetObj=GetAssetClassObjTarget();
         CheckAssertClassVsSleeves(sleeveDescription,targetObj);
  
         //c)Tous les titres de chaque classe d'actifs sont affichés dans la sleeve correspondante.
         ExpandAllAssetClassItems();
         
         var assetClassItemsCashAndCashEquivalents =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvCashAndCashEquivalents())// suavgarde les positions de chaque segment de la grille
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassItemsCashAndCashEquivalents,sleeveDescription[0])//La fonction vérifie les items de Encaisse et les compare avec les items dans la fenêtre de Gestionnaire de segments 
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(false) // Fermer + 
         
         var assetClassMediumTerm =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvMediumTerm())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassMediumTerm,sleeveDescription[1])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).set_IsExpanded(false)  
         
         var assetClassLongTerm =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvLongTerm())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassLongTerm,sleeveDescription[2])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).set_IsExpanded(false) 
                  
         var assetClassCanadianEquity =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvCanadianEquity())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassCanadianEquity,sleeveDescription[4])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",5).set_IsExpanded(false)
                                 
         //c) Le champ '% restant de la cible' sera = 100
         //Ouvrir le Gestionnaire des segments
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();  
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_TxtRemainingTargetPercent(), "Text", cmpEqual,  remainingTargetPercent);
         
         //e) Le champ 'Répartition d'actifs' sera grisé avec la répartition du compte.
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, assetAllocation);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);
         Get_WinManagerSleeves().Close();
         
         //d) le segment divers ne contient aucune position sauf le solde
         CheckPositionOfUnallocated()         
                     
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