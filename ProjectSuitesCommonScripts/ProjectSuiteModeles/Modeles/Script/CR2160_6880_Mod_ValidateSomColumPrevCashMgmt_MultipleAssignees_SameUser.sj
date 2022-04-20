//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions


/**
    Description : Valider sommation au niveau de la colonne Gest. encaisse préc. Même_User_1
    Le but de ce cas est de :

      Valider la somme au niveau de la colonne Gest. encaisse préc.  étape 2 du rééquilibrage Portefeuille à rééquilibrer 
      Valider la somme au niveau de la colonne Gest. encaisse préc. fenêtre Gestion de l'encaisse
      Valider la somme au niveau de la colonne Gest. encaisse préc. étape 4 du rééquilibrage onglet Portefeuille projeté   
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6880
    Analyste d'assurance qualité : CaroleT
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.16-17
*/

function CR2160_6880_Mod_ValidateSomColumPrevCashMgmt_MultipleAssignees_SameUser()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6880","Cas de test TestLink : Croes-6880") 
         
         
         
          //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
          
          
           //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
      
         
          //Redemarrer les service
          RestartServices(vServerModeles);
         
         
         
          //Variables                      
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
          
          var chCANADIANEQUI    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "CHCANADIANEQUI", language+client);
          var account800041OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account800041OB", language+client);
          var client800215      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Client800215", language+client);
          var account800215NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account800215NA", language+client);
          var account800215OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account800215OB", language+client);
         
          //Variables 1 er Rééquilibrgae
          var amount800041OB_R1      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228FS", language+client);
          var amount800215NA_R1      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228JW", language+client);
          var amount800215OB_R1      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228RE_R2", language+client);
          var amountClient800215_R1  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "AmountClient800215_R1", language+client);
          
          
          //Variables 2 éme Rééquilibrgae  
          var prevCashMgmt800041OB_R2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228FS", language+client);
          var prevCashMgmt800215NA_R2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228JW", language+client);
          var prevCashMgmt800215OB_R2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228RE_R2", language+client);
          var prevCashMgmtClient800215_R2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "AmountClient800215_R1", language+client);
           
         
          var amount800041OB_R2      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800041OB_R2", language+client);
          var amount800215NA_R2      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800041OB_R2", language+client);
          var amount800215OB_R2      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228RE", language+client);
          var amountClient800215_R2  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "AmountClient800215_R2", language+client);
          
          //Variable 3éme Rééquilibrage 
          var prevCashMgmt800041OB_R3     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228FS_R4", language+client);
          var prevCashMgmt800215NA_R3     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Amount800228RE", language+client);
          var prevCashMgmt800215OB_R3     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "AmountClient_R2", language+client);
          var prevCashMgmtClient800215_R3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "AmountClient800215_R3", language+client);
           
         
//Étape1

           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();  
           
           
            //Accéder au module modèle et associer au modèle CH CANADIAN EQUITIES le compte 300007-NA et le client 800208 
           Log.Message("Accéder au module modèle et associer au modèle CH CANADIAN EQUITIES le compte 300007-NA et le client 800208");
           Get_ModulesBar_BtnModels().Click();
           Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
           AssociateAccountWithModel(chCANADIANEQUI, account800041OB);
           AssociateClientWithModel(chCANADIANEQUI, client800215);
           
/*****************************************************************************1 er Rééquilibrage************************************************************************/                     
           
//Étape2 
           
            //Selectionner  le modèle CH CANADIAN EQUITIES et rééquilibrer le j,esqu'à l'étape2
            RebalanceStape2(chCANADIANEQUI)


            //Faire une gestion d'encaisse comme suit : 800041-NA = 100 000, 800215-NA = 50 000 et 8002015-OB = 25 000
            Log.Message("Faire une gestion d'encaisse comme suit : 800041-NA = 100 000, 800215-NA = 50 000 et 8002015-OB = 25 000");
            DepositWithdrawalAmount2160(account800041OB, amount800041OB_R1);
            DepositWithdrawalAmount2160(account800215NA, amount800215NA_R1);
            DepositWithdrawalAmount2160(account800215OB, amount800215OB_R1);
            
            
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
            ValidatePrevCashMgmtStape2_6880(amount800041OB_R1, null, amountClient800215_R1, null)
            
// Étape 3         
            //Continuer le rééquilibrage jusqu a l'étape4
            RebalanceStape4();
            
            //Validation de la gestion d'encaisse et de la  gestion d'encaisse précédente etape4
            ValidatePrevCashMgmtStape4_6880(amount800041OB_R1, null, amountClient800215_R1, null)
//Étape4             
            
             //Aller à l'étpae5 et générer les ordres
             RebalanceStape5GenerateOrdres();
             Delay(10000)
             
/*****************************************************************************2 éme Rééquilibrage************************************************************************/   
//Étape 5

            //Selectionner  le modèle CH CANADIAN EQUITIES et rééquilibrer le j'usqu'à l'étape2
            RebalanceStape2(chCANADIANEQUI)
            
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
            ValidatePrevCashMgmtStape2_6880(null, prevCashMgmt800041OB_R2, null, prevCashMgmtClient800215_R2)
            
            
            //Valider les colonnes Gest. encaisse. et Gest. encaisse précédente dans la fenêtre Gestion d'encaisse
            ValidatePrevCashMgmtWinCashMgmt(account800041OB, account800215NA, account800215OB, null, prevCashMgmt800041OB_R2, null, prevCashMgmt800215NA_R2, null, prevCashMgmt800215OB_R2)
            Get_WinCashManagement_BtnOk().click();

//Étape 6            
             //Faire une gestion d'encaisse comme suit : 800041-NA = -100 000, 800215-NA = -100 000 et 8002015-OB = -50 000
            Log.Message("Faire une gestion d'encaisse comme suit : 800041-NA = -100 000, 800215-NA = -100 000 et 8002015-OB = -50 000");
            DepositWithdrawalAmount2160(account800041OB, amount800041OB_R2);
            DepositWithdrawalAmount2160(account800215NA, amount800215NA_R2);
            DepositWithdrawalAmount2160(account800215OB, amount800215OB_R2);
            
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
            ValidatePrevCashMgmtStape2_6880(amount800041OB_R2, prevCashMgmt800041OB_R2, amountClient800215_R2, prevCashMgmtClient800215_R2);
            
            //Continuer le rééquilibrage jusqu a l'étape4
            RebalanceStape4();

//Étape 7
            
            //Validation de la gestion d'encaisse et de la  gestion d'encaisse précédente etape4
            ValidatePrevCashMgmtStape4_6880(amount800041OB_R2, prevCashMgmt800041OB_R2, amountClient800215_R2, prevCashMgmtClient800215_R2)
           
//Étape 8      

             //Aller à l'étpae5 et générer les ordres
             RebalanceStape5GenerateOrdres();   
          

/*****************************************************************************3 éme Rééquilibrage************************************************************************/                              
//Étape 9            
            //Selectionner  le modèle CH CANADIAN EQUITIES et rééquilibrer le j'usqu'à l'étape2
            RebalanceStape2(chCANADIANEQUI);
            
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
            ValidatePrevCashMgmtStape2_6880(null, prevCashMgmt800041OB_R3, null, prevCashMgmtClient800215_R3)
            
            //Valider les colonnes Gest. encaisse. et Gest. encaisse précédente dans la fenêtre Gestion d'encaisse
            ValidatePrevCashMgmtWinCashMgmt(account800041OB, account800215NA, account800215OB, null, prevCashMgmt800041OB_R3, null, prevCashMgmt800215NA_R3, null, prevCashMgmt800215OB_R3);
            Get_WinCashManagement_BtnOk().click();
//Étape 10             
             //Continuer le rééquilibrage jusqu a l'étape4
            RebalanceStape4();
            
             //Fermer la fenêtre d'information
              Get_DlgInformation_BtnOK().Click() 
            
            
            //Validation de la gestion d'encaisse et de la  gestion d'encaisse précédente etape4
            ValidatePrevCashMgmtStape4_6880(null, prevCashMgmt800041OB_R3, null, prevCashMgmtClient800215_R3);
            
            
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
         RemoveAccountFromModel(account800041OB, chCANADIANEQUI)
         RemoveClientFromModel(client800215,chCANADIANEQUI)
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         
         //Reinitialiser les valeurs des pref
         Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
         Activate_Inactivate_Pref("COPERN", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
         
         //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_PREVENT_DELTA", "YES", vServerModeles);
         
         
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}
