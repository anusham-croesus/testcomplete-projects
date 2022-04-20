//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions


/**
    Description : Valider que le reéquilibrage multiple est possible 
    avec des users differents quand pour les tous les users  la PREF_MULTIPLE_USER_REBALANCE= Oui   
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6876
    Analyste d'assurance qualité : CaroleT
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.15.2020.3-8
*/

function CR2160_6876_Mod_ValidateMultipleRebalancing_DifferentUserYes()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6876","Cas de test TestLink : Croes-6876") 
         
         
         
          //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
          Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
          Activate_Inactivate_Pref("COPERN", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
          
           //Mettre la pref PREF_MULTIPLE_USER_REBALANCE = Yes Pour les user  COPERN ET KEYNEJ
           Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
           Activate_Inactivate_Pref("COPERN", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
            
         
         
          //Redemarrer les service
          RestartServices(vServerModeles);
         
         
         
          //Variables                      
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
          var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          
          
          var chCANADIANEQUI    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "CHCANADIANEQUI", language+client);
          var account300007NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account300007NA", language+client);
          var client800208      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Client800208", language+client);
          var account800208NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account800208NA", language+client);
          var securityRona      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "SecurityRona", language+client);
          var quantity6876      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Quantity6876", language+client);
          var clientName800208  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "ClientName800208", language+client);
         
//Étape1

           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();  
           
           
            //Accéder au module modèle et associer au modèle CH CANADIAN EQUITIES le compte 300007-NA et le client 800208 
           Log.Message("Accéder au module modèle et associer au modèle CH CANADIAN EQUITIES le compte 300007-NA et le client 800208");
           Get_ModulesBar_BtnModels().Click();
           Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
           AssociateClientWithModel(chCANADIANEQUI, client800208);
           AssociateAccountWithModel(chCANADIANEQUI, account300007NA);
           
           
           //Rééquilibrer le modèle et se rendre jusqu'à l'étape 5 et envoyer les ordres à l'acumulateur
           Log.Message("Rééquilibrer le modèle et se rendre jusqu'à l'étape 5 et envoyer les ordres à l'acumulateur");
           RebalanceModel(chCANADIANEQUI);
           
           
           
//Étape2

           //Se connecter à croesus avec Copern
           Log.Message("Se connecter à croesus avec Copern");
           Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
           Get_MainWindow().Maximize();  
           
            //Selectionner  le modèle CH CANADIAN EQUITIES et rééquilibrer le j,esqu'à l'étape2
            RebalanceStape2(chCANADIANEQUI)


            //Faire une gestion d'encaisse comme suit : 800208-NA = 100
            Log.Message("Faire une gestion d'encaisse comme suit : 800208-NA = 100");
            DepositWithdrawalAmount2160(account800208NA, 100)//Cette étape à été ajoutée pour forcer l'achat d'un titre de  Rona afin de pouvoir executer l'étape 5

            //Continuer le rééquilibrage jusqu a l'étape4
            RebalanceStape4()
           
            
//Étape3
            //Dans la fenêtre de l'étape 4, cliquer sur le bouton Grouper
            Log.Message("Dans la fenêtre de l'étape 4, cliquer sur le bouton Grouper"); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().FindChild("Text", clientName800208, 10).Click();           
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();   
            
            
            
//Étape4         
             //Sélectionner le premier ordre modifiable (RONA INC)et cliquer sur Modifier
             Log.Message("Sélectionner le premier ordre modifiable (RONA INC)et cliquer sur Modifier");
             var grid1 = Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1);
 
             var count = grid1.Items.Count;
             for (i=1; i<count; i++){
                  if (grid1.Items.Item(i).DataItem.SecurityDescription == securityRona && grid1.Items.Item(i).DataItem.AllowEdit == true)
                      {
                        Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).Click();
                        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
                       break;
                      }     
              } 
           
             
              //Modifier la quantité de Rona pour 500 puis Réévaluer le rééquilibrage
              Log.Message("Modifier la quantité de Rona pour 500 puis Réévaluer le rééquilibrage");
              Get_WinRebalance_TabProjectedPortfolios_WinEditOrders_TxtQuantity().keys(quantity6876);
              Get_WinRebalance_TabProjectedPortfolios_WinEditOrders_BtnOK().Click();              
              Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_BtnReassess().Click();
               
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
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
		    
    
         //Restart Data
         RemoveAccountFromModel(account300007NA, chCANADIANEQUI)
         RemoveClientFromModel(client800208,chCANADIANEQUI)
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
