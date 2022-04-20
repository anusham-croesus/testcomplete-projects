//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions
//USEUNIT TCVE982_PartialRebalancing_WithSubModel_BasketAndExcessCash


/**
    Description : Valider que le Reéquilibrage partiel est possible 
      
        
    https://jira.croesus.com/browse/TCVE-935
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.15.2020.3-8
*/

function TCVE935_PartialRebalancing()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link(" https://jira.croesus.com/browse/TCVE-935","Cas de test Jira : TCVE935") 
         
         
         
          //Variables                      
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
          
          var Modele_MOD935     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "Modele935", language+client);
          var account300010NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "Account300010NA", language+client);
          var account300010OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "Account300010OB", language+client);
                    
          var modelType         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
          var typePicker        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
           
          var securityABX       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "SecurityABX", language+client);
          var securityDIS       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "SecurityDIS", language+client);
          
          var quantityABX_1     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "QuantityABX_1", language+client); 
          var quantityABX_2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "QuantityABX_2", language+client); 
            
          var targetABX         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "PourcentageABX", language+client);
          var targetDIS         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE935", "PourcentageDIS", language+client);
          
         
          
//Étape1
           Log.Message("*******************************************Étape1**********************************************************");
           
           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();  
           
           
             
           
           
//Étape2
            Log.Message("********************************************Étape2**********************************************************");
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle MOD935 
            Log.Message("Créer le modèle MOD935"); 
            Create_Model(Modele_MOD935,modelType)
            
            //Ajouter des position dans le Modèle MOD935
            Log.Message("Ajouter des position dans le Modèle MOD935"); 
            SearchModelByName(Modele_MOD935);
            Drag( Get_ModelsGrid().Find("Value",Modele_MOD935,10), Get_ModulesBar_BtnPortfolio());
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,30000);
            Get_Toolbar_BtnAdd().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/3)),73)
            Get_DlgConfirmation_NoDesactiveModel().Click();
            
            //Ajouter une position ABX
            AddPositionToModel(securityABX,targetABX,typePicker,"");
            //Ajouter une position DIS
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityDIS,targetDIS,typePicker,"");
            
            //Sauvegarder les positions ajoutées dans le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            
            //Accéder au module modèle et associer les comptes 300010-NA et 300010-OB au Modèle MOD935
            Log.Message("Accéder au module modèle et associer les comptes 300010-NA et 300010-OB au Modèle MOD935");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            AssociateAccountWithModel(Modele_MOD935, account300010NA);
            AssociateAccountWithModel(Modele_MOD935, account300010OB);
            
//Étape3

            Log.Message("********************************************Étape3**********************************************************");
            
            //Rééquilibrer Modèle MOD935 et se rendre à l'étape 3  
            Log.Message("Rééquilibrer Modèle MOD935 et se rendre à l'étape 3 ");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
                        
            // Cocher les cases valider les limites, Appliquer les frais et Répartir la liquidité.
            Log.Message("Décocher les cases valider les limites Appliquer les frais et Répartir la liquidité.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            
//Étape 4
            
            Log.Message("********************************************Étape4**********************************************************");
            
            //Cliquer sur Selectionner tout pour deselectionner les positions puis Selectionner la position ABX
            Log.Message("Cliquer sur Selectionner tout pour deselectionner les positions puis Selectionner la position ABX");
            Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Click();
            Delay(10000)
            Get_WinRebalance_RebalancePositionsGrid().WPFObject("RecordListControl", "", 1).FindChild("Value",securityABX,10).Click();
//            var grid = Get_WinRebalance_RebalancePositionsGrid().WPFObject("RecordListControl", "", 1)
// 
//            var count = grid.Items.Count;
//            for (i=0; i<count; i++){
//               if (grid.Items.Item(i).DataItem.Symbol == securityABX)
//                  {
//                        var pos = i+1; 
//                  }     
//            } 
//                 
//            
//            Get_WinRebalance_RebalancePositionsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", pos).Click();
            
            //Continuer le rééquilibrage et aller  l'étape4 du rééquilibrage
            Log.Message("Continuer le rééquilibrage et aller  l'étape4 du rééquilibrage");
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            
            //Degrouper en cliquant sur le bouton Grouper, puis valider la quantité de ABX pour les deux comptes
            Log.Message("Degrouper en cliquant sur le bouton Grouper, puis valider la quantité de ABX pour les deux comptes");
            WaitObject(Get_CroesusApp(), "Uid", "ToggleButton_c0e5");
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
            
           
            
            //Sys.HighlightObject(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator()) 
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Click();
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Keys("[Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right]");
  
            //Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Text", account300010NA, 10).Click();
            var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
              
                         for (i=0; i<count; i++){
                             if (grid.Items.Item(i).DataItem.AccountNumber == account300010NA)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityABX_1)
                                }                         
                           }
                           
            //Get_WinRebalance().Find("Uid","DataGrid_d123",10).Find("Value",account300010OB,10).Click();
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Text", account300010OB, 10).Click();
            var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
              
                         for (i=0; i<count; i++){
                             if (grid.Items.Item(i).DataItem.AccountNumber == account300010OB)
                                {
                                     aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityABX_2)
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
         RemoveAccountFromModel(account300010NA, Modele_MOD935)
         RemoveAccountFromModel(account300010OB, Modele_MOD935)
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         //Supprimer le modéele MOD935
         DeleteModelByName(Modele_MOD935)
         
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}
