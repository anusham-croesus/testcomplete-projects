//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions



/**
    Description : 
    
      Le but de ce cas est de valider avec different users :
      La somme au niveau de la colonne Gest. encaisse préc.  étape 2 du rééquilibrage Portefeuille à rééquilibrer 
      La somme au niveau de la colonne Gest. encaisse préc. fenêtre Gestion de l'encaisse
      La somme au niveau de la colonne Gest. encaisse préc. étape 4 du rééquilibrage onglet Portefeuille projetés
      Valider que si un rééquilibrage n'est pas complété (les ordres ne sont pas générés) la gestion d'encaisse faite lors de ce rééquilibrage  n'est pas pris en compte   
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6877
    Analyste d'assurance qualité : CaroleT
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.15.2020.3-8
*/

function CR2160_6877_Mod_ValidateSomColumPrevCashMgmt_DifferentAccount1()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6877","Cas de test TestLink : Croes-6877") 
         
         
         
          //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
          Activate_Inactivate_Pref("COPERN", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
          
          //Mettre la pref PREF_REBALANCE_PREVENT_DELTA = NO Pour les user  COPERN ET KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
          Activate_Inactivate_Pref("COPERN", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
            
         
         
          //Redemarrer les service
          RestartServices(vServerModeles);
         
         
         
          /***************************************************Variables ***************************************************/                     
          var userNameKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          var userNameCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
          var passwordCOPERN       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          
          
          var chMOYENTERME          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "CH_MOYEN_TERME", language+client);
          var account800077SF       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account800077SF", language+client);
          
          //Variable Rééquilibrage 1
          var amount6877_1          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount6877_1", language+client);
          var accountName800077SF   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account_Name_800077SF", language+client);
          var markertValue6877      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "MarkertValue6877", language+client); 
          var cashMgmt_Message_1    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "CashMgmt_Message_1", language+client);
          
          
          //Variable Rééquilibrage 2
          var amount6877_2          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount6877_2", language+client);
          var markertValue6877_2    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "MarkertValue6877_2", language+client); 
          var cashMgmt_Message_2    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "CashMgmt_Message_2", language+client);
                   
          //Variable Rééquilibrage 3
          var markertValue6877_3    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "MarkertValue6877_3", language+client);
          
           
//Étape1

           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();  
           
           
           //Accéder au module modèle et associer au modèle CH MOYEN TERME le compte 800077-SF 
           Log.Message("Accéder au module modèle et associer au modèle CH MOYEN TERME le compte 800077-SF");
           Get_ModulesBar_BtnModels().Click();
           Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
           AssociateAccountWithModel(chMOYENTERME, account800077SF);
 
           
/*****************************************************************************1 er Rééquilibrage************************************************************************/           
//Étape 2 
          
           //Rééquilibrer le modèle CH MOYEN TERME et aller à l'étape2  
           Log.Message("Rééquilibrer le modèle  et aller à l'étape2 ");
           RebalanceStape2(chMOYENTERME)
           
           
           //faire un gestion d'encaisse 800077-SF = 100 000
           Log.Message("puis faire un gestion d'encaisse 800077-SF = 100 000");
           DepositWithdrawalAmount2160(account800077SF, amount6877_1)

           
           //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer 
           Log.Message("Valider la gestion d'encaisse a l'étape 2 du rééquilibrage ");  
           ValidatePrevCashMgmtStape2(amount6877_1, null);
           
           
//Étape 3           
           //Valider la colonne gestion d'encaisse et la colonne gestion d.encaisse précécdente dans la fenêtre Cash Management
           Log.Message("Valider la gestion d 'encaisse et de la gestion précédente au niveau de la fenêtre gestion de l'encaisse ");
           Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
           aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account800077SF,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount6877_1)
           aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account800077SF,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
           Get_WinCashManagement_BtnOk().click(); 

           
//Étape 4           
           //Continuer le rééquilibrage jusqu a l'étape4
           RebalanceStape4();
           
           //Validation de la colonne gestion d'encaisse, de la colonne gestion d'encaisse précédente et  du message liés à la gestion d'encaisse etape4
           Log.Message("------------ Vérification de la gestion d'encaisse et  du message liés à la gestion d'encaisse etape4--------------------");
           //Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Text", name, 10).Click(); 
           aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amount6877_1)
           aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
           aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10), "WPFControlText", cmpEqual, cashMgmt_Message_1);  
     
           //Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché
           Log.Message("Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché");
           Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
           aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(),"Text", cmpEqual, markertValue6877);
           Log.Message("Valeur de marché est: " + markertValue6877); 
     
     
           //Fermer la fenêtre de rééquilibrage
           Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
           Get_WinRebalance_BtnClose().Click();
           Get_DlgConfirmation_BtnYes().Click();
           
           
/**********************************************************************2 éme Rééquilibrage************************************************************/           
           
//Étape 5 



           //Se connecter à croesus avec Copern
           Log.Message("Se connecter à croesus avec Copern");
           Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
           Get_MainWindow().Maximize(); 
           
           
           
           //Rééquilibrer le modèle CH MOYEN TERME et aller à l'étape2  
           Log.Message("Rééquilibrer le modèle  et aller à l'étape2 ");
           RebalanceStape2(chMOYENTERME)
          
           
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente  a l'étape 2 du rééquilibrage 
            Log.Message("Valider la gestion d'encaisse a l'étape 2 du rééquilibrage   ");  
            ValidatePrevCashMgmtStape2(null, null)
            
           
            //Valider la gestion d 'encaisse et de la gestion précédente au niveau de la fenêtre gestion de l'encaisse 
            Log.Message("Valider la gestion d 'encaisse et de la gestion précédente au niveau de la fenêtre gestion de l'encaisse ");
            Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account800077SF,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account800077SF,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
            Get_WinCashManagement_BtnOk().click(); 

            
//Étape 6           
            //Faire un gestion d'encaisse 800077-SF = 50 000
            Log.Message("Faire un gestion d'encaisse 800077-SF = 50 000");
            DepositWithdrawalAmount2160(account800077SF, amount6877_2)
           
             //Valider a nouveau la colonne gestion d'encaisse et la colonne gestion d'encaisse précédente  a l'étape 2 du rééquilibrage 
            Log.Message("Valider a nouveau  la gestion d'encaisse a l'étape 2 du rééquilibrage   ");  
            ValidatePrevCashMgmtStape2(amount6877_2, null)

            
//Étape 7           
            //Continuer le rééquilibrage jusqu a l'étape4
            RebalanceStape4();
           
            //Vérification de la gestion d'encaisse et  du message liés à la gestion d'encaisse etape4
            Log.Message("------------ Vérification de la gestion d'encaisse et  du message liés à la gestion d'encaisse etape4--------------------");
            //Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Text", name, 10).Click(); 
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amount6877_2)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,null)
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10), "WPFControlText", cmpEqual, cashMgmt_Message_2);  
     
            //Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché
            Log.Message("Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(),"Text", cmpEqual, markertValue6877_2);
            Log.Message("Valeur de marché est: " + markertValue6877_2); 

            
//Étape 8     
            //Fermer la fenêtre de rééquilibrage
            Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
            Get_WinRebalance_BtnClose().Click();
            Get_DlgConfirmation_BtnYes().Click();
           

/*****************************************************************************3 éme Rééquilibrage************************************************************************/           
           
//Étape 9

           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize(); 
           
           
           //Rééquilibrer le modèle  et aller à l'étape2 sans faire de gestion d'encaisse puis valider les colonnes Cash Mgmt et Prev Cash Mgmt
           Log.Message("Rééquilibrer le modèle  et aller à l'étape2 sans faire de gestion d'encaisse puis valider les colonnes Cash Mgmt et Prev Cash Mgmt");
           
           //Rééquilibrer le modèle CH MOYEN TERME et aller à l'étape2  
           Log.Message("Rééquilibrer le modèle  et aller à l'étape2 ");
           RebalanceStape2(chMOYENTERME)
           
           
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente  a l'étape 2 du rééquilibrage 
            Log.Message("Valider la gestion d'encaisse a l'étape 2 du rééquilibrage   ");  
            ValidatePrevCashMgmtStape2(null, null);

            
//Étape 10            
            //Continuer le rééquilibrage jusqu a l'étape4
            RebalanceStape4();
                      
            //Validation de la colonne gestion d'encaisse, de la colonne gestion d'encaisse précédente et lde la valeur de marché à l'etape4  
            ValidatePrevCashMgmtStape4(null, null, markertValue6877_3);
     
//Étape 11            

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
         RemoveAccountFromModel(account800077SF, chMOYENTERME)
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         //Reinitialiser les valeurs des pref
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         //Reinitialiser les valeurs des pref
         Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
         Activate_Inactivate_Pref("COPERN", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
         Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_PREVENT_DELTA", "YES", vServerModeles);
         Activate_Inactivate_Pref("COPERN", "PREF_REBALANCE_PREVENT_DELTA", "YES", vServerModeles);
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}

