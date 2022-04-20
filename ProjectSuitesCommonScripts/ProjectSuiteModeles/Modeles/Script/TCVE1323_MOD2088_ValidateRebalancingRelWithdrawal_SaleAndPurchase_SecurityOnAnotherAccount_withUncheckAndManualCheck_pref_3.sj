//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions


/**
    Description : 
    Le but de ce cas est de valider avec différent users:

            Valider le rééquilibrage d'une relation avec retrait lorsqu’on permet 
            la vente et l'achat d'un titre sur un autre compte, mais avec décochage  puis cochage manuel
            (avec pref=3)
    
   Nota Bena : Ce cas de test initial contienait 13 étapes avec trop de validation  Avec Cristine P 
              nous avons estimé qu'il n'est pas necessaire d'automatiser toutes les étapes car nous avons 
              des repetitions. Donc nous avons éstimé qu il est suffisant d'automatiser seulement les étapes 1 a 8 
              qui donneront  une couverture élévée.
              
    https://jira.croesus.com/browse/MOD-2088
    Analyste d'assurance qualité : Chrine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.15.2020.5-22
*/

function TCVE1323_MOD2088_ValidateRebalancingRelWithdrawal_SaleAndPurchase_SecurityOnAnotherAccount_withUncheckAndManualCheck_pref_3()
{
    try {
           var logEtape2, logEtape3,logEtape4, logEtape5, logRetourEtatInitial;
           //Afficher le lien du cas de test
           Log.Link("https://jira.croesus.com/browse/MOD-2088","Cas de test JIRA : MOD-1193") 
           
           //Mettre la pref PREF_MODEL_FREECASH_MODE = 3                    
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_FREECASH_MODE", 3, vServerModeles);
          
           //Redemarrer les service
           RestartServices(vServerModeles);
         

         
         
           /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           
           var mod_Freecash         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "MODFREECASH", language+client);
           var link_Frecash         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "LINKFREECASH", language+client);  
           var account800081LY      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "Acount800081LY", language+client);
           var account800246GT      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "Account800246GT", language+client);
           var amount800246GT       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "AMOUNT800246GT", language+client);
           
           
           var securityBMO          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityBMO", language+client);
           var securityBCE          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityBCE", language+client);
           var securityCM           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityCM", language+client);
           var securityNA           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityNA", language+client);
           var securityRY           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityRY", language+client);
           var securityTD           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityTD", language+client);
           var positionSolde        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "POSITIONSOLDE", language+client);
           
           
           var quantityBMO_LY       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITY_BMO_800081LY_1193", language+client);
           var quantityRY_LY        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITY_RY_800081LY_1193", language+client);
           var quantityCM_LY        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITY_CM_800081LY_1193", language+client);
           var quantityBMO_GT       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITY_BMO_800246GT_1193", language+client);
           var quantityRY_GT        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITY_RY_800081GT_1193", language+client)
           var quantityCM_GT        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITY_CM_800246GT_1193", language+client);
           
           
           var msgRebalance_2088_1  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "MESSAGEREBALANCE2088_1", language+client); 
           var msgRebalance_2088_2  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "MESSAGEREBALANCE2088_2", language+client); 
           var msgRebalance_2088_3  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "MESSAGEREBALANCE2088_3", language+client);
         
           
           var msgRebalance_2088 ="Certains comptes sous-jacents font état de divers mouvements de liquidité.\nLe rééquilibrage a donné lieu à la fois à des ordres d\'achat et de vente sur les titres suivants : BMO, CM, RY.  Tous les ordres de l\'élément associé au modèle ont donc été décochés.\nLe résultat du rééquilibrage indique une encaisse négative: (800246-GT = (118 638,45))."           
           var msgRebalance_2088_800081LY    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "REBALANCE_MESSAGE_800081LY_2088", language+client);           
           var msgRebalance_2088_800246GT    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "REBALANCE_MESSAGE_800081LY_2088", language+client);           

           
           var soldeLY_2088   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITESOLDE_LY_2088", language+client);
           var soldeGT_2088   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "QUANTITESOLDE_GT_2088", language+client);
           
           var vmSoldeLY_2088_NiveauCompte  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "VMPERCENTSOLDE_LY_ACCOUNT_2088", language+client);
           var vmSoldeGT_2088_NiveauCompte  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "VMPERCENTSOLDE_GT_ACCOUNT_2088", language+client);
           var vmSoldeLY_2088_NiveauRel     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "VMPERCENTSOLDE_LY_RELATION_2088", language+client);
           var vmSoldeGT_2088_NiveauRel     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "VMPERCENTSOLDE_GT_RELATION_2088", language+client);
           
//Étape 2  
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Se connecter à croesus avec Keynej, Accéder au module Modele pui associer la relation mod_Freecash au  modele mod_Freecash ");      
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modele pui associer la relation mod_Freecash au  modele mod_Freecash ");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            AssociateRelationshipWithModel(mod_Freecash, link_Frecash);
 
                        
//Étape 3 
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Rééquilibrer le modèle et se rendre à l'étape 2  "); 
            //Rééquilibrer le modèle et se rendre à l'étape 2
            Log.Message("Rééquilibrer le modèle et se rendre à l'étape 2  ");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            
            //Cocher la case valider les tolerances puis decocher les cases  Répartir la liquidité et  Appliquer les frais.
            Log.Message("Cocher la case valider les tolerances puis decocher les cases  Répartir la liquidité et  Appliquer les frais.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            Get_WinRebalance_BtnNext().Click();
            
//Étape4 
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Faire une gestion d'encaisse comme suit : account800246-GT= -120 000, account800081-LY = Aucune ");
            //Faire une gestion d'encaisse comme suit : account800246-GT= -120 000, account800081-LY = Aucune
            Log.Message("Faire une gestion d'encaisse comme suit : account800246-GT= -120 000, account800081-LY = Aucune");
            DepositWithdrawalAmount2160(account800246GT, amount800246GT);

            
//Étape5    
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Continuer le rééquilibrage jusqu a l'étape4, Validation des messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés");                   
            //Continuer le rééquilibrage jusqu a l'étape4
            Get_WinRebalance_BtnNext().Click();  
            Get_WinRebalance_BtnNext().Click(); 
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
            
            
            //Validation qu 'aucun ordre dela grille est coché 
             var grid = Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1)
             var count = grid.Items.Count;
             for (i=0; i<count; i++){
 
             if (grid.Items.Item(i).DataItem.IsOk == false)
             
                 Log.Checkpoint("tous les ordres de l'onglet ordres proposés  sont decochés")
             else 
                Log.Error("Au moins un ordes de l'onglet ordres proposés est cochés");
                
             }
            
             //Validation des messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés 
             Log.Message("Validation au niveau du compte 800081LY les messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés");           
             aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(),"Text", cmpEqual,msgRebalance_2088_1+"\n"+msgRebalance_2088_2+"\n"+msgRebalance_2088_3);
//Étape6
             Log.PopLogFolder();
             logEtape6 = Log.AppendFolder("Vérifier les ordres dans l'onglet Ordres proposés. ");
             //Vérifier les ordres dans l'onglet Ordres proposés.
             Log.Message("Vérifier les ordres dans l'onglet Ordres proposés."); 
             Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click(); 
             Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().WaitProperty("IsChecked", false, 10000);    
             var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1);
             var count = grid.Items.Count;
                         for (i=0; i<count; i++){  
                               
                               if (grid.Items.Item(i).DataItem.AccountNumber == account800081LY && grid.Items.Item(i).DataItem.SecuritySymbol == securityBMO)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityBMO_LY)
                                } 
                               if (grid.Items.Item(i).DataItem.AccountNumber == account800081LY && grid.Items.Item(i).DataItem.SecuritySymbol == securityRY)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityRY_LY)
                                }   
                               if (grid.Items.Item(i).DataItem.AccountNumber == account800081LY && grid.Items.Item(i).DataItem.SecuritySymbol == securityCM)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityCM_LY)
                                }   
                                 
                               if (grid.Items.Item(i).DataItem.AccountNumber == account800246GT && grid.Items.Item(i).DataItem.SecuritySymbol == securityBMO)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityBMO_GT)
                                }  
                               if (grid.Items.Item(i).DataItem.AccountNumber == account800246GT && grid.Items.Item(i).DataItem.SecuritySymbol == securityCM)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityCM_GT)
                                }  
                                  
                               if (grid.Items.Item(i).DataItem.AccountNumber == account800246GT && grid.Items.Item(i).DataItem.SecuritySymbol == securityRY)
                                {
                                    aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityRY_GT)
                                }   
                                 
                              
                                                      
                           } 

//Étape7                          
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Validation au niveau des comptes  des messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés. ");                               
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true); 
            
           
            //Validation au niveau du compte 800081LY les  messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés 
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Find("Value",account800081LY,10).Click();
            Log.Message("Validation au niveau du compte 800081LY les messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés");      
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10),"WPFControlText", cmpEqual, msgRebalance_2088_800081LY) ;   
  
            //Validation au niveau du compte 800246-GT les  messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés 
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Find("Value",account800246GT,10).Click();
            Log.Message("Validation au niveau du compte 800246-GT les messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés");      
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10),"WPFControlText", cmpEqual, msgRebalance_2088_800246GT) ;   
                          
//Étape8     
             Log.PopLogFolder();
             logEtape8 = Log.AppendFolder("Vérifier les informations  dans l'onglet portefeuilles projetés.");
             //Vérifier les informations  dans l'onglet portefeuilles projetés.
             Log.Message("Vérifier les informations  dans l'onglet portefeuilles projetés."); 
             Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
             Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
             Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(false);
             Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 1).Click(); 
             var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1)
             var count = grid.Items.Count;
           
             for (i=0; i<count; i++){
                  if (grid.Items.Item(i).DataItem.AccountNumber == account800081LY && grid.Items.Item(i).DataItem.Symbol == positionSolde)
                     {
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"DisplayQuantityStr",cmpEqual,soldeLY_2088)
                        TotalValuePercentageMarketSoldeLY = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketSoldeLY,vmSoldeLY_2088_NiveauRel ,"vm(%) "); 
                        
                     }   
                  if (grid.Items.Item(i).DataItem.AccountNumber == account800246GT && grid.Items.Item(i).DataItem.Symbol == positionSolde)
                     {
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"DisplayQuantityStr",cmpEqual,soldeGT_2088)
                        TotalValuePercentageMarketSoldeGT = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketSoldeGT,vmSoldeGT_2088_NiveauRel ,"vm(%) ");
                     }    
             } 
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true); 
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Find("Value",account800081LY,10).Click();


             var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1)
             var count = grid.Items.Count;
             for (i=0; i<count; i++){
                  if (grid.Items.Item(i).DataItem.AccountNumber == account800081LY && grid.Items.Item(i).DataItem.Symbol == positionSolde)
                     {
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"DisplayQuantityStr",cmpEqual,soldeLY_2088)
                        TotalValuePercentageMarketSoldeLY = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketSoldeLY,vmSoldeLY_2088_NiveauCompte ,"vm(%) "); 
                     }  
                     
                     } 
              
             Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Find("Value",account800246GT,10).Click();
             var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1)
             var count = grid.Items.Count;
             for (i=0; i<count; i++){              
                 if (grid.Items.Item(i).DataItem.AccountNumber == account800246GT && grid.Items.Item(i).DataItem.Symbol == positionSolde)
                    {
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"DisplayQuantityStr",cmpEqual,soldeGT_2088)
                        TotalValuePercentageMarketSoldeGT = roundDecimal(grid.Items.Item(i).DataItem.TotalValuePercentageMarket,3)
                        CheckEquals(TotalValuePercentageMarketSoldeGT,vmSoldeGT_2088_NiveauCompte ,"vm(%) "); 
                 
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
          RemoveRelationshipFromModel(mod_Freecash,link_Frecash)
          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_FREECASH_MODE", 1, vServerModeles);
         //DeleteModelByName(modelRJ4)  
         
         
  		  //Fermer le processus Croesus
          Terminate_CroesusProcess();         
        
    }
}



