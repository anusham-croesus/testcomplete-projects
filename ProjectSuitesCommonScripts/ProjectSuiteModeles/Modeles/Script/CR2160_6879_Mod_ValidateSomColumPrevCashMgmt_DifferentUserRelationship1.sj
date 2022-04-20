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

    La somme au niveau de la colonne Gest. encaisse préc.  étape 2 du rééquilibrage Portefeuille à rééquilibrer 
    La somme au niveau de la colonne Gest. encaisse préc. fenêtre Gestion de l'encaisse
    La somme au niveau de la colonne Gest. encaisse préc. étape 4 du rééquilibrage onglet Portefeuille projetés
    Valider que si un rééquilibrage n'est pas complété (les ordres ne sont pas générés) la gestion d'encaisse faite lors de ce rééquilibrage  n'est pas pris en compte  
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6879
    Analyste d'assurance qualité : CaroleT
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.15.2020.3-8
*/

function CR2160_6879_Mod_ValidateSomColumPrevCashMgmt_DifferentUserRelationship1()
{
    try {
           
           //Afficher le lien du cas de test
           Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6879","Cas de test TestLink : Croes-6879") 
                               
            
            
            
           //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
           Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
           Activate_Inactivate_Pref("COPERN", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
           
           //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
           Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
           Activate_Inactivate_Pref("COPERN", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
            
           //Redemarrer les service
           RestartServices(vServerModeles);
         
         
         
           /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           var userNameCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
           var passwordCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
            
           var modelRJ4             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "ModelNameRJ4", language+client);
           var relationshipRJ3      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "RelationshipNameRJ3", language+client);
           var account300012NA      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Acount300012NA", language+client);
           var account600003NA      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account600003NA", language+client);
           
           //Variable 1er Rééquilibrage
           var amount600003NA_R1       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228FS", language+client);
           var amount300012NA_R1       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228FS_R2", language+client);
           var amountRelRJ3_R1         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228JW", language+client);
           var marketValue6879_R1      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "MarketValue6879_R1", language+client);
           
           //Variable 2eme Rééquilibrage
           var amount600003NA_R2       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount600003NA_R2", language+client);
           var amount300012NA_R2       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228FS_R2", language+client);
           var amountRelRJ3_R2         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "AmountRelationRJ3_R2", language+client);
           var marketValue6879_R2      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "MarketValue6879_R2", language+client);
           
           //Variable 3eme Rééquilibrage 
           var marketValue6879_R3      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "MarketValue6879_R3", language+client);
           
           
//Étape 1        
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            AssociateRelationshipWithModel(modelRJ4, relationshipRJ3);
 
            
             /******************1 er rééquilibrage******************************/           
            
//Étape 2  
          
            //Rééquilibrer le modèle RJ4 et aller à l'étape 2 
            RebalanceStape2(modelRJ4);
            
            //Faire une gestion d'encaisse comme suit : 300012-NA = -50 000, 600003-NA = 100 000 
            Log.Message("Faire une gestion d'encaisse comme suit : 300012-NA = -50 000, 600003-NA = 100 000");
            DepositWithdrawalAmount2160(account300012NA, amount300012NA_R1);
            DepositWithdrawalAmount2160(account600003NA, amount600003NA_R1);
            
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
            ValidatePrevCashMgmtStape2(amountRelRJ3_R1, null)
            
            
            //Continuer le rééquilibrage jusqu a l'étape4
            RebalanceStape4();  
            
//Étape3            
            
             //Validation de la colonne gestion d'encaisse et  de colonne la gestion d'encaisse précédente à l'étape4
             Log.Message("------------ Validation de la colonne gestion d'encaisse et  de la  colonne  gestion d'encaisse précédente à l'étape4--------------------");      
             aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountRelRJ3_R1)
             aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
                  
             
             //Dans la section de gauche Exploser pour  les valider la colonne gestion d'encaisse et de la  colonne gestion d'encaisse précédente au niveau des comptes
             Log.Message("-----------------Dans la section de gauche Exploser pour  les valider la colonne gestion d'encaisse et de la  colonne gestion d'encaisse précédente au niveau des comptes---------");
             
             var gridAccount = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 1)
             gridAccount.set_IsExpanded(true); 
             aqObject.CheckProperty(gridAccount.WPFObject("RecordListControl", "", 1).Find("Value",account300012NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount300012NA_R1)
             aqObject.CheckProperty(gridAccount.WPFObject("RecordListControl", "", 1).Find("Value",account300012NA,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
             aqObject.CheckProperty(gridAccount.WPFObject("RecordListControl", "", 1).Find("Value",account600003NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount600003NA_R1)
             aqObject.CheckProperty(gridAccount.WPFObject("RecordListControl", "", 1).Find("Value",account600003NA,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)  
             
             

             //Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché
             Log.Message("Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché");
             Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
             aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(),"Text", cmpEqual, marketValue6879_R1);
             Log.Message("Valeur de marché est: " + marketValue6879_R1); 
             
             
             //Fermer la fenêtre de rééquilibrage
             Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
             Get_WinRebalance_BtnClose().Click();
             Get_DlgConfirmation_BtnYes().Click();

                                                /******************2 éme rééquilibrage******************************/
                                      
//Étape4

             //Se connecter à croesus avec Copern
             Log.Message("Se connecter à croesus avec Copern");
             Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
             Get_MainWindow().Maximize(); 
             
             
             //Rééquilibrer le modèle RJ4 et aller à l'étape 2 
             RebalanceStape2(modelRJ4);
             
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
             ValidatePrevCashMgmtStape2(null, null)
             
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente dans la fenêtre Cash Management
             Log.Message("-----------Valider la gestion d'encaisse et la gestion d'encaisse précédente dans la fenêtre Cash Management-----------")
             
             Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
              
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account300012NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account300012NA,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account600003NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account600003NA,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)


             
             Get_WinCashManagement_BtnOk().click();
             
             
//Étape 5             
             //Faire une gestion d'encaisse comme suit : 300012-NA = -50 000, 600003-NA =10 000 
             Log.Message("Faire une gestion d'encaisse comme suit : 300012-NA = -50 000, 600003-NA =10 000 ");
              
             DepositWithdrawalAmount2160(account300012NA, amount300012NA_R2)
             DepositWithdrawalAmount2160(account600003NA, amount600003NA_R2)  
             
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
             ValidatePrevCashMgmtStape2(amountRelRJ3_R2, null)

              
//Étape 6
             //Continuer le rééquilibrage jusqu a l'étape4
             RebalanceStape4();     
             
             //Validation de la colonne gestion d'encaisse, de la colonne gestion d'encaisse précédente et lde la valeur de marché à l'etape4
             ValidatePrevCashMgmtStape4(amountRelRJ3_R2, null, marketValue6879_R2); 
 
             
//Étape 7            
             //Fermer la fenêtre de rééquilibrage
             Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
             Get_WinRebalance_BtnClose().Click();
             Get_DlgConfirmation_BtnYes().Click();
             
  
              /******************3 éme rééquilibrage******************************/           
             
//Étape 8 
        
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
            
            
            //Rééquilibrer le modèle RJ4 et aller à l'étape 2 
            RebalanceStape2(modelRJ4);
            
             
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
             ValidatePrevCashMgmtStape2(null, null)
             
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente dans la fenêtre Cash Management
             Log.Message("-----------Valider la gestion d'encaisse et la gestion d'encaisse précédente dans la fenêtre Cash Management-----------")
             Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
             
             
             aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account300012NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
             aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account300012NA,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
             aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account600003NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
             aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account600003NA,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)


             
             Get_WinCashManagement_BtnOk().click();
            
            
             //Continuer le rééquilibrage jusqu a l'étape4
             RebalanceStape4();  
             
             //Validation de la colonne gestion d'encaisse, de la colonne gestion d'encaisse précédente et lde la valeur de marché à l'etape4
             ValidatePrevCashMgmtStape4(null, null, marketValue6879_R3); 
             
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
          RemoveRelationshipFromModel(modelRJ4,relationshipRJ3)
          DeleteModelByName(modelRJ4)
          //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
          Activate_Inactivate_Pref("COPERN", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);           
          //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_PREVENT_DELTA", "YES", vServerModeles);
          Activate_Inactivate_Pref("COPERN", "PREF_REBALANCE_PREVENT_DELTA", "YES", vServerModeles);
		    
  		    //Fermer le processus Croesus
          Terminate_CroesusProcess();         
        
    }
}



