//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions


/**
    Description : Valider que le Reéquilibrage partiel est possible avec un sous modéele Panier 
    et de l'excedent d encaisse 
      
        
    https://jira.croesus.com/browse/TCVE-941
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.15.2020.5-3
*/

function TCVE982_PartialRebalancing_WithSubModel_BasketAndExcessCash()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link(" https://jira.croesus.com/browse/TCVE-941","Cas de test Jira : TCVE941") 
         
         
         
          //Variables                      
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          var TOL_PANIER_RECHA    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "TOLPANIERRECHA", language+client);
          var clientNumber800040  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "ClientNumber800040", language+client);
          var accountNum800040FS  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "AccountNumber800040FS", language+client);
          var accountNum800040RE  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "AccountNumber800040RE", language+client);
          var securityXCB         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "SecurityXCB", language+client);
          
          var securityNBC200      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "SecurityNBC200", language+client);
          var panier844000        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "Panier844000", language+client);
          var vmNBC200_1          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "VMNBC200", language+client);
          var vmPANIER844000_1    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "VMPANIER8444000", language+client)
          
          var securityDescXCB     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "SecurityDescXCB", language+client)
          var vmNBC200_2          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "VMNBC200_2", language+client);
          var vmPANIER844000_2    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "VMPANIER8444000_2", language+client)
          var vm_XCB_FS_2          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "VMXCB_FS_2", language+client);
          var VM_XCB_RE_2         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE941", "VM_XCB_RE_2", language+client)
          
          
         // var securityDescXCB     = "ISHARES CDN DEX CP BD ETF"
//Étape1
           Log.Message("*******************************************Étape1**********************************************************");
           
           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();  
           
           
             
           
           
//Étape2
            Log.Message("********************************************Étape2**********************************************************");
                       
            
            //Accéder au module modèle et associer les comptes 300010-NA et 300010-OB au Modèle MOD935
            Log.Message("Accéder au module modèle et associer le client au Modèle MOD935");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            SearchModelByName(TOL_PANIER_RECHA);
            AssociateClientWithModel(TOL_PANIER_RECHA,clientNumber800040);
            
            
            
           
            
//Étape3

            Log.Message("********************************************Étape3**********************************************************");
            
            
            //Mailler le modéle TOL PANIER RECHA dans le module portefeuille et supprimer la position de rechange XCB
            Log.Message("Mailler le modéle TOL PANIER RECHA dans le module portefeuille et supprimer la position de rechange XCB"); 
            SearchModelByName(TOL_PANIER_RECHA);
            Drag( Get_ModelsGrid().Find("Value",TOL_PANIER_RECHA,10), Get_ModulesBar_BtnPortfolio());
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,30000);
            
            //Selectionner et ouvrir la position panier PANNIER OBLIGA CORPOR
            Log.Message("Selectionner et ouvrir la position panier PANNIER OBLIGA CORPOR ")
            Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 6).DblClick();
            Get_DlgConfirmation_NoDesactiveModel().Click();
            
            
            //Supprimer le titre de rechange XCB au PANNIER OBLIGA CORPOR 
            Log.Message("Supprimer le titre de rechange XCB au  PANNIER OBLIGA CORPOR ")
            Get_WinSubModelInfo_GrpSubstitutionSecurities_BtnEdit().Click();
            Get_WinSubstitutionSecurities_BtnRemove().Click();
            Get_DlgConfirmation_BtnOk().Click();
            Get_WinSubstitutionSecurities_BtnOK().Click();
            Get_WinSubModelInfo_BtnOK().Click();
            
            //Sauvegarder le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            
            
            
            
            
            
            
            
//Étape 4

            RebalanceAndSelectBascket844000(panier844000);

            
//Étape 7
            
            Log.Message("********************************************Étape7**********************************************************");
                
            //Aller a l'ongletPortefeuilles Projetés Valider les VMpour le panier 844000 et le le titre NBC200
            Log.Message("Aller a l'ongletPortefeuilles Projetés");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(false);
             
            var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1)
 
            var count = grid.Items.Count;
            for (i=0; i<count; i++){
               
                  if (grid.Items.Item(i).DataItem.Symbol== securityNBC200 && grid.Items.Item(i).DataItem.AccountNumber == accountNum800040FS)
                   {
                     TotalValuePercentageMarketNBC200_1 = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                     CheckEquals(TotalValuePercentageMarketNBC200_1,vmNBC200_1 ,"vm(%) ");
                  }
                  if (grid.Items.Item(i).DataItem.Symbol == panier844000 && grid.Items.Item(i).DataItem.AccountNumber == accountNum800040RE)
                  {  
                     TotalValuePercentageMarketpanier844000 = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                     CheckEquals(TotalValuePercentageMarketpanier844000,vmPANIER844000_1 ,"vm(%) "); 
                  }      
               } 
           
            
//Étape 8
            
            Log.Message("********************************************Étape8**********************************************************");
                              
            //Fermer la fenêtre de rééquilibrage
            Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
            Get_WinRebalance_BtnClose().Click();
            Get_DlgConfirmation_BtnYes().Click();
            
            
            //Mailler le modéle TOL PANIER RECHA dans le module portefeuille et supprimer la position de rechange XCB
            Log.Message("Mailler le modéle TOL PANIER RECHA dans le module portefeuille et supprimer la position de rechange XCB"); 
            SearchModelByName(TOL_PANIER_RECHA);
            Drag( Get_ModelsGrid().Find("Value",TOL_PANIER_RECHA,10), Get_ModulesBar_BtnPortfolio());
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,30000);
            
            //Selectionner et ouvrir la position panier PANNIER OBLIGA CORPOR
            Log.Message("Selectionner et ouvrir la position panier PANNIER OBLIGA CORPOR ")
            Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 6).DblClick();
            Get_DlgConfirmation_NoDesactiveModel().Click();
            Get_WinSubModelInfo_GrpSubstitutionSecurities_BtnEdit().Click();
            
            
            //Ajouter le titre de rechange XCB au PANNIER OBLIGA CORPOR 
            Log.Message("Ajouter le titre de rechange XCB au  PANNIER OBLIGA CORPOR ")
            Get_WinSubstitutionSecurities_BtnAdd().Click();
            Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
            Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
            Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityDescXCB);
            Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click();
            Get_WinReplacement_BtnOK().Click();
            Get_WinSubstitutionSecurities_BtnOK().Click();
            Get_WinSubModelInfo_BtnOK().Click();
            
            //Sauvegarder le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
//Étape 9 
              Log.Message("******************************Étape9**********************************")
              RebalanceAndSelectBascket844000(panier844000);            
 

            //Aller a l'ongletPortefeuilles Prjetés Valider les VMpour le panier 844000 et le le titre NBC200
            Log.Message("Aller a l'ongletPortefeuilles Prjetés");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(false);
             
            var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1);
 
            var count = grid.Items.Count;
            for (i=1; i<count; i++){
              
                 
               
                    if (grid.Items.Item(i).DataItem.Symbol == securityNBC200 && grid.Items.Item(i).DataItem.AccountNumber == accountNum800040FS)
                    {
                        TotalValuePercentageMarketNBC200_2 = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketNBC200_2,vmNBC200_2 ,"vm(%) ");
                     
                    }  
                    if (grid.Items.Item(i).DataItem.Symbol == securityXCB && grid.Items.Item(i).DataItem.AccountNumber == accountNum800040FS)
                    {  
                        TotalValuePercentageMarketXCB_2 = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketXCB_2,vm_XCB_FS_2 ,"vm(%) ");
                    } 
                    if (grid.Items.Item(i).DataItem.Symbol == securityXCB && grid.Items.Item(i).DataItem.AccountNumber == accountNum800040RE)
                    {
                        TotalValuePercentageMarketXCB_3 = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketXCB_3,VM_XCB_RE_2 ,"vm(%) ");
                    }  
                    if (grid.Items.Item(i).DataItem.Symbol == panier844000 && grid.Items.Item(i).DataItem.AccountNumber == accountNum800040RE)
                    {
                        TotalValuePercentageMarketPANIER844000_2_ = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketPANIER844000_2_,vmPANIER844000_2 ,"vm(%) ");
                    }         
            } 
           
            //Fermer la fenêtre de rééquilibrage
            Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
            Get_WinRebalance_BtnClose().Click();
            Get_DlgConfirmation_BtnYes().Click();
  
            
                     
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
		    
    
         //Restart Data
         RemoveClientFromModel(clientNumber800040, TOL_PANIER_RECHA)
         
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         
         
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}


function RebalanceAndSelectBascket844000(positionpanier){
   
                        
//Étape 4

            
            
            Log.Message("********************************************Étape4**********************************************************");
            
            //Rééquilibrer Modèle MOD935 et se rendre à l'étape 3  
            Log.Message("Rééquilibrer Modèle MOD935 et se rendre à l'étape 3 ");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
                        
            // Decocher les cases valider les limites, Appliquer les frais et Répartir la liquidité.
            Log.Message("Décocher les cases valider les limites Appliquer les frais et Répartir la liquidité.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 

                        
//Étape 5
            
            Log.Message("********************************************Étape5**********************************************************");
            
            //Cliquer sur Selectionner tout pour deselectionner les positions puis Selectionner la position ABX
            Log.Message("Cliquer sur Selectionner tout pour deselectionner les positions puis Selectionner la position ABX");
            WaitObject(Get_CroesusApp(), "Uid", "Button_affd");
            Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Click();
            Delay(10000)
            Get_WinRebalance_RebalancePositionsGrid().WPFObject("RecordListControl", "", 1).FindChild("Value",positionpanier,10).Click();
//            var grid = Get_WinRebalance_RebalancePositionsGrid().WPFObject("RecordListControl", "", 1)
// 
//            var count = grid.Items.Count;
//            for (i=1; i<count; i++){
//               if (grid.Items.Item(i).DataItem.Symbol == positionpanier)
//                  {
//                        var pos = i+1; 
//                  }     
//            } 
//            
//            Get_WinRebalance_RebalancePositionsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", pos).Click();

            
//Étape 6
            
            Log.Message("********************************************Étape6**********************************************************");
                
            //Continuer le rééquilibrage et aller  l'étape4 du rééquilibrage
            Log.Message("Continuer le rééquilibrage et aller  l'étape4 du rééquilibrage");
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            } 
            Get_DlgWarning_BtnOK().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");

}

function Get_DlgConfirmation_NoDesactiveModel(){return Get_DlgConfirmation().Find(["ClrClassName", "WPFControlName"], ["Button", "PART_No"], 10)} //no uid

