//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT CR2160_Common_functions


/**
    Description : Valider la possibilité de changer le compte destinataire d'un l'ordre d'achat
    Le but de ce cas est de :

    Portefeuille projeté, Vue standart et vue par compte: Il est possible de changer le compte destinataire de l'ordre d'achat  
        
    https://jira.croesus.com/browse/TCVE-917
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.15.2020.3-37
*/

function TCVE_1039_Validate_Modification_RecipientAccount_BuyOrder_Relationship()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/browse/TCVE-917,") 
         
         
         
          //Mettre la pref PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT = YES
          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT", "YES", vServerModeles);
          Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "3", vServerModeles);
          
          
         
          //Redemarrer les service
          RestartServices(vServerModeles);
         
         
         
          //Variables                      
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
          
          var chMOYENTERME      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "CHMOYENTERME", language+client);
          var relationTest6     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "RelationTest6", language+client);
          var account300010NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "Account300010NA", language+client);
          var account300010OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "Account300010OB", language+client);
          var securityQ49599    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "TitreQ49599", language+client); 
          var quantityQ49599    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "QuantityQ49599", language+client); 
                  
          
//Étape1
             Log.Message("**************************************Étape1*******************************************************************");

           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();  
           
           
           //Accéder au module modèle et associer a la relation Test6
           Log.Message("Accéder au module modèle et associer a la relation Test6");
           Get_ModulesBar_BtnModels().Click();
           Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
           AssociateRelationshipWithModel(chMOYENTERME, relationTest6);            
             
//Étape2
            
            Log.Message("**************************************Étape2*******************************************************************");           
            //Rééquilibrer le Modéle CH MOYEN TERME et se rendre à l'étape4  
            Log.Message("Rééquilibrer le Modéle CH MOYEN TERME et se rendre à l'étape4 ");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
                        
            // Cocher les cases valider les limites, Appliquer les frais et Répartir la liquidité.
            Log.Message("Cocher la case valider les limites et Décocher les cases Appliquer les frais et Répartir la liquidité.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(true);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(true);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(true);
            
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
//Étape3

            Log.Message("**************************************Étape3*******************************************************************");
            //Dans l'onglet Portefeuilles prejetés, cliquer sur le bouton Grouper pour degroupe les ordres
            Log.Message("Dans l'onglet Portefeuilles prejetés, cliquer sur le bouton Grouper pour degroupe les ordres"); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");           
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();  
            
            //Sélectionner la position Q49599 et valider sa quantité 
            Log.Message("Sélectionner la position Q49599 et valider sa quantité");
            var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1);
 
            var count = grid.Items.Count;
            for (i=0; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecuritySecuFirm == securityQ49599)
                    {
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityQ49599)
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AccountNumber",cmpEqual,account300010NA)
                        
                    }    
                      
            }
            
//Étape4 

            Log.Message("**************************************Étape4*******************************************************************"); 
            //Aller a l'ongletPortefeuilles Prjetés
            Log.Message("Aller a l'ongletPortefeuilles Prjetés");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
            
              
            //Sélectionner la position Q49599 puis modifier le compte destinatreur de l'ordre d'acha 300010-NA en Selectionant le compte 300010-OB
            Log.Message("Sélectionner la position Q49599 puis modifier le compte destinatreur de l'ordre d'acha 300010-NA en Selectionant le compte 300010-OB");
            var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1)//.WPFObject("DataRecordPresenter", "", pos)
 
            var count = grid.Items.Count;
            Log.Message(count)
            for (i=0; i<count; i++){
               if (grid.Items.Item(i).DataItem.Symbol == securityQ49599 && grid.Items.Item(i).DataItem.AccountNumber == account300010NA)
                  {
                        var pos = i+1; 
                       }     
                 } 
                 
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(false);
            Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", pos).Click();
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();            
            WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
              
            //Selectionner le compte 300010-OB puis cliquer sur le bouton OK
            Log.Message("Selectionner le compte 300010-OB  puis cliquer sur le bouton OK");
            Get_WinModifyPosition_CmbCompte().Click();
            if(Get_SubMenus().Exists){  
               Aliases.CroesusApp.subMenus.Find("Text",account300010OB,10).Click();
            }                 
               
            Get_WinModifyPosition_BtnOK().Click();
              
//Étape5              
              
            Log.Message("**************************************Étape5*******************************************************************");
            //Retourner dans l'onglet Ordres proposés Sélectionner la position Q49599 et valider sa quantité Pour les deux comptes
            Log.Message("Retourner dans l'onglet Ordres proposés Sélectionner la position Q49599 et valider sa quantité Pour les deux comptes");
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
            var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
              
                for (i=0; i<count; i++){
                     if (grid.Items.Item(i).DataItem.SecuritySecuFirm == securityQ49599  && grid.Items.Item(i).DataItem.AccountNumber == account300010NA)
                        {
                          aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,0)
                       }
                    if (grid.Items.Item(i).DataItem.SecuritySecuFirm == securityQ49599  && grid.Items.Item(i).DataItem.AccountNumber == account300010OB)
                      {
                         aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityQ49599)
                      }                         
                 }
               

//Étape6
                
           Log.Message("**************************************Étape6*******************************************************************");
           //Revenir à l'étape3 puis aller à l'étape 4     
           Log.Message("Revenir à l'étape3 puis aller à l'étape 4 ");
           Get_WinRebalance_BtnPrevious().Click();   
           Get_DlgConfirmation_BtnYes().Click();        
           Get_WinRebalance_BtnNext().Click();
           if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
               
           //Aller a l'onglet Portefeuilles Prjetés
           Log.Message("Aller a l'onglet Portefeuilles Prjetés");
           Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
           Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
           WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
               
//Étape7       

          Log.Message("**************************************Étape7*******************************************************************");
          //Aller a l'ongletPortefeuilles Prjetés et cliquer sur le bouton Par compte
          Log.Message("Aller a l'ongletPortefeuilles Prjetés et cliquer sur le bouton Par compte");        
          Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
               
//Étape8 

         //Selection le niveau par position
         Log.Message("Selection le niveau par position");
         Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy().Click();
         Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortByPosition().Click(); 

            
//Étape9  

               Log.Message("**************************************Étape8*******************************************************************");
               //Refaire les étapes 4 et 5
               Log.Message("Refaire les étapes 4 et 5");      
               Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(false);
               
              
               SelectAndOpenBuyorder();
               WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
              
               //Selectionner le compte 300010-OB puis cliquer sur le bouton OK
               Log.Message("Selectionner le compte 300010-OB  puis cliquer sur le bouton OK");
               Get_WinModifyPosition_CmbCompte().Click();
               if(Get_SubMenus().Exists){  
               Aliases.CroesusApp.subMenus.Find("Text",account300010OB,10).Click();
               }                 
               
               Get_WinModifyPosition_BtnOK().Click();
              
               //Aller dans l'onglet Ordres proposéset valider que la modification du compte destinaire est fait : le compte 300010OB a 286 200 
               Log.Message("Aller dans l'onglet Ordres proposéset valider que la modification du compte destinaire est fait : le compte 300010OB a 286 200 ");
               Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
               Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
               Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_BtnReassess().Click(); 
               
               var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1);
               var count = grid.Items.Count;
              
                   for (i=0; i<count; i++){
                           if (grid.Items.Item(i).DataItem.SecuritySecuFirm == securityQ49599  && grid.Items.Item(i).DataItem.AccountNumber == account300010NA)
                             {
                             aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,0)
                             }
                          if (grid.Items.Item(i).DataItem.SecuritySecuFirm == securityQ49599  && grid.Items.Item(i).DataItem.AccountNumber == account300010OB)
                            {
                               aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityQ49599)
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
         RemoveRelationshipFromModel(chMOYENTERME,relationTest6)
         
         //aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
    
         
          //Remettre la pref PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT = NO
          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT", "NO", vServerModeles);
         
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}

function SelectAndOpenBuyorder(){
  
   Aliases.CroesusApp.winRebalance.WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl")
  .WPFObject("gridSection").WPFObject("ProjectedPortfolioByAccountGrid").WPFObject("ProjectedPortfolioByAccountGrid")
  .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 9).WPFObject("DataRecordCellArea", "", 1)
  .WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 15).DblClick();

}
 

