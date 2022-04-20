//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0()
//USEUNIT Ordres_Get_functions 


/**
    Gestion de la quantité des ordres en bloc issue d'un rééquilibrage 
    Pour plus de details voir (ORC-2219)
      
        
    https://jira.croesus.com/browse/TCVE-5326
    https://jira.croesus.com/browse/TCVE-5562
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.15.2021.04-46
*/

function TCVE_5562_ORC_2219_BulkOrdersQuantityManagement_ResultingFromRebalancing()
{
    try {
      
          //Afficher le lien du cas de test
          Log.Link(" https://jira.croesus.com/browse/TCVE-5326","Cas de test Jira : TCVE-5326") 
          Log.Link(" https://jira.croesus.com/browse/TCVE-5562","Cas de test Jira : TCVE-5562") 
         
    
         
          //Variables                      
          var userNameKEYNEJ      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          var CH_FOREIGN_EQUIT    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CH_FOREIGN_EQUIT", language+client);
          var test1Relationship   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TEST1_RELATIONSHIP", language+client);
          var SUBS_PRORATA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SUBS_PRORATA", language+client);
          var FALL_BACK           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "FALL_BACK", language+client);
          
          
          
          var account800254_FS    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800254_FS", language+client);
          var account800254_JJ    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800254_JJ", language+client);
          var account800254_JW    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800254_JW", language+client);
          var account800254_RE    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800254_RE", language+client);
          
          var account800075_RE    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800075_RE", language+client);
          var account800075_SF    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800075_SF", language+client);
          var account800075_JJ    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800075_JJ", language+client);
          
          var account800076_FS    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800076_FS", language+client);
          var account800076_GT    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800076_GT", language+client);
          var account800076_NA    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800076_NA", language+client);
          
          var account800077_SF    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800077_SF", language+client);
          var account800077_RE    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800077_RE", language+client);
          var account800077_NA    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800077_NA", language+client);
          
          var account800223_GT    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800223_GT", language+client);
          var account800223_RE    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800223_RE", language+client);
          
          var account800232_FS    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800232_FS", language+client);
          var account800232_JW    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800232_JW", language+client);
          var account800232_NA    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800232_NA", language+client);
          
          var account800238_FS    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800238_FS", language+client);
          var account800238_GT    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800238_GT", language+client);
          var account800238_NA    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800238_NA", language+client);
          var account800238_DQ    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800238_DQ", language+client);
          var account800238_OB    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800238_OB", language+client);
          var account800238_RE    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800238_RE", language+client);
          var account800238_SF    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800238_SF", language+client);
          
          var account800283_HU    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800283_HU", language+client);
          var account800283_RE    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT_800283_RE", language+client);
          
          var securityALU         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SECURITY_ALU", language+client);
          var value               = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "VALUE_TCVE5562", language+client);
          
          var ecartValue1         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE1", language+client);
          var ecartValue2         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE2", language+client);
          var ecartValue3         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE3", language+client);
          var ecartValue4         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE4", language+client);
          var ecartValue5         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE5", language+client);
          var ecartValue6         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE6", language+client);
          var ecartValue7         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE7", language+client);
          var ecartValue8         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE8", language+client);
          var ecartValue9         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE9", language+client);
          var ecartValue10        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE10", language+client);
          var ecartValue11        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE11", language+client);

          var ecartValue12        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE12", language+client);
          var ecartValue13        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE13", language+client);
          var ecartValue14        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE14", language+client);
          var ecartValue15        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ECART_VALUE15", language+client);
                    
          var projectedValue             =  ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "PROJECTED_VALUE", language+client);
          var quantity_TCVE5562          =  ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "QUANTITY_TCVE5562", language+client);         
          var merged_quantity_TCVE5562   =  ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "MERGED_QUANTITY_TCVE5562", language+client);         
                   
                    
//Étape1
           Log.Message("*******************************************Étape1**********************************************************");
           
           //Se connecter à croesus avec Keynej
           Log.PopLogFolder();
           logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user KEYNEJ");
           Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize(); 
           
           //Enlever les clients 800075-JJ et 800223-RE des modeles
           RemoveAccountFromModel(account800075_JJ, FALL_BACK)
           RemoveAccountFromModel(account800223_RE, SUBS_PRORATA)
           
           //Supprimer les ordres dans l'accumilateur 
           Log.Message("Supprimer les ordres dans l'accumilateur");
           DeleteAllOrdersInAccumulator()          
//Étape2
            Log.Message("********************************************Étape2**********************************************************");
                       
            
            //Dans le module Modèle, sélectionner le modèle CH FOREIGN EQUIT puis Associer la relation #1TEST au modèle
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Dans le module Modèle, sélectionner le modèle CH FOREIGN EQUIT puis Associer la relation #1TEST au modèle");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
//            SearchModelByName(CH_FOREIGN_EQUIT);
            AssociateRelationshipWithModel(CH_FOREIGN_EQUIT,test1Relationship);
                       
            
//Étape3

            Log.Message("********************************************Étape3**********************************************************");
            //Rééquilibrer le modèle, Décocher les 3 check box s'ils sont affichés et Sélectionner seulement  la position ALU puis poursuivre à l'étape 4 du rééquilibrage
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Rééquilibrer le modèle, Décocher les 3 check box s'ils sont affichés et Sélectionner seulement  la position ALU puis poursuivre à l'étape 4 du rééquilibrage");
            
            RebalacingStep4(securityALU)
                        
            
//Étape 4
            Log.Message("********************************************Étape4**********************************************************");
            
            //Étape 4 du rééquilibrage, Portefeuille projeté, Trier la colonne Symbole puis Double cliquer sur l'ordre d'achat avec symbole pour tous les comptes et Mettre la quantité projetée à 999999
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: du rééquilibrage, Portefeuille projeté, Trier la colonne Symbole puis Double cliquer sur l'ordre d'achat avec symbole pour tous les comptes et Mettre la quantité projetée à 999999");
           
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(false);
                         
            
            Log.Message("Selectionner toutes les positions ALU puis mettre la quantité projetée à 999999") 
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol().Click();
            scrollerTosecurityALU(ecartValue15)
            
            
            
            editProjectedQuantity(ecartValue1, projectedValue) 
            editProjectedQuantity(ecartValue2, projectedValue)
            editProjectedQuantity(ecartValue3, projectedValue)
            editProjectedQuantity(ecartValue4, projectedValue)
            editProjectedQuantity(ecartValue5, projectedValue)
            editProjectedQuantity(ecartValue6, projectedValue)
      
            editProjectedQuantity(ecartValue7, projectedValue) 
            editProjectedQuantity(ecartValue8, projectedValue)
            editProjectedQuantity(ecartValue9, projectedValue)
            editProjectedQuantity(ecartValue10, projectedValue)
            editProjectedQuantity(ecartValue11, projectedValue)
      
            editProjectedQuantity(account800238_GT, projectedValue) 
            editProjectedQuantity(ecartValue13, projectedValue)
            editProjectedQuantity(ecartValue14, projectedValue)
            editProjectedQuantity(ecartValue15, projectedValue)
           

//Étape 5
            
            Log.Message("********************************************Étape5**********************************************************");
                
            //Étape 4 du rééquilibrage Ordres proposés: Cliquer sur le bouton Réévaluer en bas à droite puis Poursuivre et Envoyer l'ordre dans l'accumulateur
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder(" Étape 4 du rééquilibrage Ordres proposés: Cliquer sur le bouton Réévaluer en bas à droite puis Poursuivre et Envoyer l'ordre dans l'accumulateur");
            
            ValidateOrderAndFinalyseRebalancing(quantity_TCVE5562)
                      
//Étape 6
            Log.Message("********************************************Étape6**********************************************************");
                       
            //Valider la quantité de l'ordre ALU dans l'accumulateur
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Valider la quantité de l'ordre ALU dans l'accumulateur");
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
            
            var grid = Get_OrderAccumulatorGrid().RecordListControl     
            var count = grid.Items.Count;
            for (i=0; i<count; i++){
            
                 aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "Quantity", cmpEqual,quantity_TCVE5562 );
             }

//Étape 7
            Log.Message("********************************************Étape7**********************************************************");
     

            //Refaire le rééquilibrage avec les mêmes étapes: Étape 3, 4 et5
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7: Refaire le rééquilibrage avec les mêmes étapes: Étape 3, 4 et5");
            
            Log.Message("Rééquilibrer le modèle, Décocher les 3 check box s'ils sont affichés et Sélectionner seulement  la position ALU puis poursuivre à l'étape 4 du rééquilibrage");
           
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            RebalacingStep4(securityALU)
            
            
             //Étape 4 du rééquilibrage, Portefeuille projeté, Trier la colonne Symbole puis Double cliquer sur l'ordre d'achat avec symbole pour tous les comptes et Mettre la quantité projetée à 999999
            Log.Message("Étape 4 du rééquilibrage, Portefeuille projeté, Trier la colonne Symbole puis Double cliquer sur l'ordre d'achat avec symbole pour tous les comptes et Mettre la quantité projetée à 999999");
           
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(false);
                         
            
            Log.Message("Selectionner toutes les positions ALU puis mettre la quantité projetée à 999999") 
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol().Click();
            scrollerTosecurityALU(ecartValue15)
            
            
            
            editProjectedQuantity(ecartValue1, projectedValue) 
            editProjectedQuantity(ecartValue2, projectedValue)
            editProjectedQuantity(ecartValue3, projectedValue)
            editProjectedQuantity(ecartValue4, projectedValue)
            editProjectedQuantity(ecartValue5, projectedValue)
            editProjectedQuantity(ecartValue6, projectedValue)
      
            editProjectedQuantity(ecartValue7, projectedValue) 
            editProjectedQuantity(ecartValue8, projectedValue)
            editProjectedQuantity(ecartValue9, projectedValue)
            editProjectedQuantity(ecartValue10, projectedValue)
            editProjectedQuantity(ecartValue11, projectedValue)
      
            editProjectedQuantity(account800238_GT, projectedValue) 
            editProjectedQuantity(ecartValue13, projectedValue)
            editProjectedQuantity(ecartValue14, projectedValue)
            editProjectedQuantity(ecartValue15, projectedValue)
           
            //Étape 4 du rééquilibrage Ordres proposés: Cliquer sur le bouton Réévaluer en bas à droite puis Poursuivre et Envoyer l'ordre dans l'accumulateur
            Log.Message("Étape 4 du rééquilibrage Ordres proposés: Cliquer sur le bouton Réévaluer en bas à droite puis Poursuivre et Envoyer l'ordre dans l'accumulateur");
            ValidateOrderAndFinalyseRebalancing(quantity_TCVE5562)
            
            Log.Message(" Valider la quantité de l'ordre ALU dans l'accumulateur");
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
            var grid = Get_OrderAccumulatorGrid().RecordListControl     
            var count = grid.Items.Count;
            for (i=0; i<count; i++){
            
                 aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "Quantity", cmpEqual,quantity_TCVE5562 );
             }

             
//Étape 8
            Log.Message("********************************************Étape8**********************************************************");
                       
            //Sélectionner les 2 ordres dans l'accumulateur puis verifier les, valider leur quantité et les messages affichés 
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Sélectionner les 2 ordres dans l'accumulateur puis verifier les, valider leur quantité et les messages affichés");          
            VerifyValidateAndSubmit_Orders(merged_quantity_TCVE5562)
                     
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
		    
    
         //Restart Data
         RemoveRelationshipFromModel(CH_FOREIGN_EQUIT,test1Relationship)
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         
         
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}

//Fonction qui permets de verifier, valider la quantité fusionnée et soumettre les ordres
function VerifyValidateAndSubmit_Orders(merged_quantity){

             Get_ModulesBar_BtnOrders().Click();
             Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
             
             Get_OrderAccumulatorGrid().RecordListControl.Keys("^a");
             Get_OrderAccumulator_BtnVerify().Click();
             
             Get_WinAccumulator().Parent.Maximize();
             var grid = Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1)
             aqObject.CheckProperty(grid.Items.Item(0).DataItem, "Quantity", cmpEqual, merged_quantity );
             
             
             
             Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
             Get_WinAccumulator_BtnSubmit().Click(); 
             WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);   


}

//function pour reequilibrage jusqu'a l'etape4
function RebalacingStep4(security){
            
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
                        
            // Decocher les cases valider les limites, Appliquer les frais et Répartir la liquidité.
            Log.Message("Décocher les cases valider les limites Appliquer les frais et Répartir la liquidité.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            
            
            WaitObject(Get_CroesusApp(), "Uid", "Button_affd");
            Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Click();
            Delay(10000)
            Get_WinRebalance_RebalancePositionsGrid().WPFObject("RecordListControl", "", 1).FindChild("Value",security,10).Click();
            
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");

            

}

//fonction qui valide l'ordre dans le Tab portefeuilles et finalise le reequilibrage
function ValidateOrderAndFinalyseRebalancing(quantity){
 

            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_BtnReassess().Click();
            
            var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1)
            aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"Quantity",cmpEqual,quantity);
            
            //Aller à l'étape 5 et envoyer les ordres dans l'accumulateur 
              Log.Message("Aller à l'étape 5 et envoyer les ordres dans l'accumulateur");
              Get_WinRebalance_BtnNext().Click(); 
              Get_WinRebalance_BtnGenerate().Click(); 
              WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
              Get_WinGenerateOrders_BtnGenerate().Click();
              if (Get_DlgConfirmation().Exists){  
                   var width = Get_DlgConfirmation().Get_Width();
                   Get_DlgConfirmation().Click((width*(2/3)),73);
               }     
}


//fonction pour scroller vers le bas
function scrollerTosecurityALU(valeurRecherche){    

            while (!Get_WinRebalance_PositionsGrid().FindChild("Value",valeurRecherche,10).Exists){//Dans le cas, si le click ne fonctionne pas 
                Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("[Down][Down][Down][Down][Down][Down][Down]");
            }
            Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("[Down]");   
}

//fonction pour modifier la valeurde la quantité projetée 
function editProjectedQuantity(ecartValue, projectedValue){
    
      Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",ecartValue,10).Click();
      Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();        
      Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity().Keys(projectedValue);       
      Get_WinModifyPosition_BtnOK().Click();
}

    
function Get_DlgConfirmation_NoDesactiveModel(){return Get_DlgConfirmation().Find(["ClrClassName", "WPFControlName"], ["Button", "PART_No"], 10)} //no uid

//Fonction pour enlever une relation  d'un modèle
 function RemoveRelationshipFromModel(modelName,relationName){
            Get_ModulesBar_BtnModels().Click();
            SearchModelByName(modelName);
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Models_Details_DgvDetails().Find("Value",relationName,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().WaitProperty("IsEnabled", true, 30000)
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
 }


 //fonction qui permets de supprimer les ordres dans l'accumulateur   
function DeleteAllOrdersInAccumulator()
{   
    
    Get_ModulesBar_BtnOrders().Click();
    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
    var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
    if(count>0){
    
       
      Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
      Get_OrderAccumulator_BtnDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }   
}
