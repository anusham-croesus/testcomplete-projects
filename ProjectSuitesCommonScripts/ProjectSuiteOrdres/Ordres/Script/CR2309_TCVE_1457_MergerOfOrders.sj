//USEUNIT CR2309_Common_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT CR2903_TCVE1179_ConsultationOrder_HavingMultipleREP_ID_And_ValidatePositions_InThe_Intraday
//USEUNIT CR2309_TCVE_940_HandlingTheContentsInTheAccumulator
//USEUNIT GDO_2464_Split_Of_BlockTrade

/* https://jira.croesus.com/browse/TCVE-1179

Analyste d'assurance qualité: Karima M
Analyste d'automatisation: Sana Ayaz */ 

 function CR2309_TCVE_1457_MergerOfOrders()
 {             
    try{  
      
    
          
//           Variables
           var userNameLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
           var passwordLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw"); 
           
           
           var quantityStep1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityStep1", language+client);
           var symbolStep1 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "symbolStep1", language+client);
           var financialInstrumentDescripStep1 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "financialInstrumentDescripStep1", language+client);
           var typOrderStep1 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "typOrderStep1", language+client);
           var orderNum10167=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "orderNum10167", language+client);
           var titleOrdreStep3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "titleOrdreStep3", language+client);
           var message1WarningStep4=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "message1WarningStep4", language+client);
           var message2WarningStep4=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "message2WarningStep4", language+client);
           var msg1ConfirmatStep2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "msg1ConfirmatStep2", language+client);
           var msg2ConfirmatStep2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "msg2ConfirmatStep2", language+client);
           var msg3ConfirmatStep2 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "msg3ConfirmatStep2", language+client);
           var levelWarningStep4=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "levelWarningStep4", language+client);
           var statusOrderStep5=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "statusOrderStep5", language+client);
           var quantityStep5=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityStep5", language+client);
       
       
         //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-940","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/TCVE-1457","Lien du cas de test dans Jira");
           

/************************************Étape 1************************************************************************/     
           /* User LINCOA
            Se connecter avec Lincoa 
            aller dans le module ordre et sélectionner l'ordre de vente et cliquer sur Renvoyer  */
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec Lincoa ,aller dans le module ordre et sélectionner l'ordre de vente et cliquer sur Renvoyerr");
//          Se connecter à croesus avec LINCOA
          Log.Message("Se connecter à croesus avec LINCOA");
          Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
          //Acceder au Module Ordres
          Log.Message("Acceder au Module Ordres");
          Get_ModulesBar_BtnOrders().Click();
          Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
          
          var lines = Get_Grid_VisibleLines(Get_OrderGrid());
          for (n=0 ; n< lines.length; n++){
    		   var displayQuantit=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue 
    		   var displaySymbol=lines[n].dataContext.dataItem.OrderSymbol.OleValue
    		   var displayFinanInstrumnt=lines[n].dataContext.dataItem.FinancialInstrumentDescription.OleValue
    		   var displayTypOrdre=lines[n].dataContext.dataItem.Type.OleValue
			  
                   if(displayQuantit == quantityStep1 && displaySymbol==symbolStep1  && displayTypOrdre==typOrderStep1 && displayFinanInstrumnt==financialInstrumentDescripStep1   ){
                 
                     Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                          Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                          Get_OrderGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                          break;
                     }
              
               } 
		   
         Log.Message("Clic sur le bouton Renvoyer")
    		 Get_OrdersBar_BtnReplace().Click();
         
         Log.Message("Clic sur le bouton Renvoyer")
    		 Get_OrdersBar_BtnReplace().Click();
         Log.Message("Deux ordres de vente vont S'afficher dans l'acumulateur ")
      
         var countNbreOrder=0;
         var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
         for (n=0 ; n< lines.length; n++){
    		   var displayQuantit=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue 
    		   var displaySymbol=lines[n].dataContext.dataItem.OrderSymbol.OleValue
    		   var displayFinanInstrumnt=lines[n].dataContext.dataItem.FinancialInstrumentDescription.OleValue
    		   var displayTypOrdre=lines[n].dataContext.dataItem.Type.OleValue
			  
                   if(displayQuantit == quantityStep1 && displaySymbol==symbolStep1  && displayTypOrdre==typOrderStep1 && displayFinanInstrumnt==financialInstrumentDescripStep1   ){
                 
                    countNbreOrder++
                     }
              
               } 
      		   if(countNbreOrder == 2)
               Log.Checkpoint("Deux ordres de vente se sont affichés dans l'acumulateur ")
            else
               Log.Error("C'est pas deux ordres de vente qui se sont affichés dans l'acumulateur ")
 /************************************Étape 2************************************************************************/     
           /* 
           Sélectionner les deux ordres et cliquer sur Fusionner   */
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Sélectionner les deux ordres et cliquer sur Fusionner ");
          var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
          var countNumberOrder=0
          var arrayOfNumberOfOrder = [];
          for (n=0 ; n< lines.length; n++){
    		   var displayQuantit=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue 
    		   var displaySymbol=lines[n].dataContext.dataItem.OrderSymbol.OleValue
    		   var displayFinanInstrumnt=lines[n].dataContext.dataItem.FinancialInstrumentDescription.OleValue
    		   var displayTypOrdre=lines[n].dataContext.dataItem.Type.OleValue
          
	
                   if(displayQuantit == quantityStep1 && displaySymbol==symbolStep1  && displayTypOrdre==typOrderStep1 && displayFinanInstrumnt==financialInstrumentDescripStep1  ){
                 
                  
                          countNumberOrder++
                          arrayOfNumberOfOrder.push(lines[n].dataContext.dataItem.OrderId.OleValue);
                          Log.Message(arrayOfNumberOfOrder[countNumberOrder-1])
			}

                     }

       SelectTwoOrderInAccumulat(arrayOfNumberOfOrder[0],arrayOfNumberOfOrder[1])           
                
         Log.Message("Cliquer sur le bouton Fusionner")
         Get_OrderAccumulator_BtnMerge().Click();
         Log.Message("Vérification du message de confirmation affiché ")
         Log.Message("Le message s'affiche sur la version:90.17-66. Voir fix version pour l'anomalie : GDO-2594 ")
         var displayMessageConfiStep2=Get_DlgConfirmation_LblMessage1().DataContext.OleValue;
         var msgConfirmatStep2=msg1ConfirmatStep2+"\r\n"+msg2ConfirmatStep2+"\r\n\r\n"+msg3ConfirmatStep2+"\r\n"
         CheckEquals(displayMessageConfiStep2, msgConfirmatStep2, "Le message de confirmation est");
           Log.Message("Clic sur le bouton ok du message de confirmation")
           Get_DlgConfirmation_BtnOk().Click();
      /************************************Étape 3************************************************************************/     
           /* 
           Dans l'accumulateur sélectionner le nouveau ordre fusionné et cliquer sur Modifier   */      
    
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Dans l'accumulateur sélectionner le nouveau ordre fusionné et cliquer sur Modifier ");
          Log.Message("Sélectionner le nouveau ordre fusionné") 
          var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
              var displaySymbol=lines[n].dataContext.dataItem.OrderSymbol.OleValue
    		      var displayFinanInstrumnt=lines[n].dataContext.dataItem.FinancialInstrumentDescription.OleValue
    		      var displayTypOrdre=lines[n].dataContext.dataItem.Type.OleValue
          
                  if(displaySymbol==symbolStep1  && displayTypOrdre==typOrderStep1 && displayFinanInstrumnt==financialInstrumentDescripStep1  ){
                 
                      
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      var numberOrderStep3= lines[n].dataContext.dataItem.OrderId.OleValue;
                      break;
                 }
           
                 
              
           }   
           
           
           Log.Message("Cliquer sur Modifier")
           Get_OrderAccumulator_BtnEdit().Click();
           Log.Message("La fenêtre de modification s'ouvre")
           var displayTitleDetailOrder=Get_WinOrderDetail().Title.OleValue;
           CheckEquals(displayTitleDetailOrder, titleOrdreStep3+"("+numberOrderStep3+")", "Le titre de la fenêtre détail d'ordre est");
        /************************************Étape 4************************************************************************/     
           /* 
           Cliquer sur vérifier   */      
    
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur vérifier ");
          Log.Message("Cliquer sur vérifier ") 
          Get_WinOrderDetail_BtnVerify().Click();
          Log.Message("Deux messages d'avertissement vont S'afficher")
          Log.Message("Clic sur l'onglet Avertissements de la fenêtre détail d'ordre")
          Get_WinOrderDetail_TabWarnings().Click();
//          Les points de vérifications :L'ordre s'ajoute dans le Blotter avec l'état : Exécuté  
          Get_WinOrderDetail_TabWarnings().Click();
          var dispalyMessag1Step4=Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Message
          CheckEquals(dispalyMessag1Step4, message1WarningStep4, "Le premier message Non bloquant de l'onglet d'avertissement");
          var dispalyMessag2Step4=Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.Message
          CheckEquals(dispalyMessag2Step4, message2WarningStep4, "Le deuxième message Non bloquant de l'onglet d'avertissement");
          
          var dispalyLevel1Step4=Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Level
          CheckEquals(dispalyLevel1Step4, levelWarningStep4, "Le niveau du premier message est :");

          var dispalyLevel2Step4=Get_WinOrderDetail_TabWarnings_Grid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.Level
          CheckEquals(dispalyLevel2Step4, levelWarningStep4, "Le niveau du deuxième message est :");

       /************************************Étape 5************************************************************************/     
           /* 
           Cliquer sur le bouton soumettre  */      
    
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: Cliquer sur soumettre ");
           
//          Cliquer sur le bouton soumettre
          Get_WinOrderDetail_BtnVerify().Click();
          
           
          var lines = Get_Grid_VisibleLines(Get_OrderGrid());
          for (n=0 ; n< lines.length; n++){
    		   var displayQuantit=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue 
    		   var displaySymbol=lines[n].dataContext.dataItem.OrderSymbol.OleValue
    		   var displayFinanInstrumnt=lines[n].dataContext.dataItem.FinancialInstrumentDescription.OleValue
    		   var displayTypOrdre=lines[n].dataContext.dataItem.Type.OleValue
			     var displayStatus=lines[n].dataContext.dataItem.Status.OleValue
                   if(displayQuantit == quantityStep5 && displaySymbol==symbolStep1  && displayTypOrdre==typOrderStep1 && displayFinanInstrumnt==financialInstrumentDescripStep1   ){
                     CheckEquals(displayStatus, statusOrderStep5, "Le status de l'order est");
        
                       break;
                     }
              
               } 
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        DeleteAllOrdersInAccumulator() 
        Terminate_CroesusProcess();
    }
    finally { 
      Terminate_CroesusProcess
      Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
      Get_ModulesBar_BtnOrders().Click(); 
      DeleteAllOrdersInAccumulator();
      Terminate_CroesusProcess(); //Fermer Croesus
      
    }
 }
  
   
