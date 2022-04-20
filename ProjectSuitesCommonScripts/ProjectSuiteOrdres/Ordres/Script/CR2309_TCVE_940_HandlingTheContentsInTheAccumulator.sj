//USEUNIT CR2309_Common_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT CR2903_TCVE1179_ConsultationOrder_HavingMultipleREP_ID_And_ValidatePositions_InThe_Intraday

/* https://jira.croesus.com/browse/TCVE-1179

Analyste d'assurance qualité: Karima M
Analyste d'automatisation: Sana Ayaz */ 

 function CR2309_TCVE_940_HandlingTheContentsInTheAccumulator()
 {             
    try{  
      
      
    
          
           //Variables
           var userNameLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
           var passwordLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw"); 
           
         
           var orderNum10001=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "orderNum10001", language+client);
           var titleOrdreDetail10001=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "titleOrdreDetail10001", language+client);
           var account800002NA   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "account800002NA", language+client);
           var quantityStep3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityStep3", language+client);
           var orderNum10010   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "orderNum10010", language+client);   
           var quantityStep4 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityStep4", language+client);   
           var quantityStep4OrdreFusion=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityStep4OrdreFusion", language+client);
           var titleDiviserOrdre10001= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "titleDiviserOrdre10001", language+client);
           var account800001OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "account800001OB", language+client);
           var quantityStep6OrdreDivision=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantityStep6OrdreDivision", language+client);
           var orderNum10002=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "orderNum10002", language+client);
           var orderNum10003=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "orderNum10003", language+client);
           var msgInformatStep10=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "msgInformatStep10", language+client);
           var orderNum10006=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "orderNum10006", language+client);
           var msgInformatStep11=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "msgInformatStep11", language+client);
           var orderNum10007=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "orderNum10007", language+client);
           var quantity0Step3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "quantity0Step3", language+client);
          
         //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-940","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/TCVE-988","Lien du cas de test dans Jira");
           
/************************************Étape 1************************************************************************/     
           //Exécuter le script en pièce jointe; les ordres 10001 à 10011 seront ajoutés
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Exécuter le script en pièce jointe; les ordres 10001 à 10011 seront ajoutés");
           //Executer le fichier SQL
           ExecuteSQLFile(folderPath_Data + "ordres_CP_new.sql", vServerOrders)
           ExecuteSQLFile(folderPath_Data + "tcve2309.sql", vServerOrders)
           
          
/************************************Étape 2************************************************************************/     
           /* User LINCOA
              Dans le module Ordres, Accumulateur, click droit pour ajouter la colonne numéro d'ordre puis 
              sélectionner l'ordre 10001 et cliquer sur Modifier*/
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: User LINCOA.Dans le module Ordres, Accumulateur, click droit pour ajouter la colonne numéro d'ordre puis sélectionner l'ordre 10001 et cliquer sur Modifier");
          //Se connecter à croesus avec LINCOA
          Log.Message("Se connecter à croesus avec LINCOA");
          Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
          //Acceder au Module Ordres
          Log.Message("Acceder au Module Ordres");
          Get_ModulesBar_BtnOrders().Click();
          Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
          //Aller dans l'Accumulateur et click droit pour ajouter la colonne numéro d'ordre 
          addColumn_ChOrderNo();
          Log.Message("Sélectionner l'ordre 10001 et cliquer sur Modifier")
          selectOrdreAndEdit(orderNum10001)
          Log.Message("La fênetre Detail de l'ordre est affichée")
          var displayTitleDetailOrder=Get_WinOrderDetail().Title.OleValue;
          CheckEquals(displayTitleDetailOrder, titleOrdreDetail10001, "Le titre de la fenêtre détail d'ordre est");
       
            
/************************************Étape 3************************************************************************/     
  /*        
        Sélectionner le compte 800002-NA puis cliquer sur Modifier. 
        1- Mettre la quantité requise  à 0 
        2- Mettre la quantité à 200 et sauvegarder 

        et sauvegarder  */
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3:Sélectionner le compte 800002-NA puis cliquer sur Modifier. 1- Mettre la quantité requise  à 02- Mettre la quantité à 200 et sauvegarder et sauvegarder ");
//      Sélectionner le compte 800002-NA puis cliquer sur Modifier.   
        Log.Message("Sélectionner le compte 800002-NA puis cliquer sur Modifier")
        Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().FindChild("Value", account800002NA, 100).Click();
        Log.Message("cliquer sur le bouton Modifier")
        Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit().Click()
         Log.Message("cliquer sur le bouton Modifie")
//        1- Mettre la quantité requise  à 0 
        Log.Message("Mettre la quantité  à 0  ")
        Get_WinEditQuantity_TxtRequestedQuantity().Keys(quantity0Step3);
        Log.Message("Les points de vérifications le bouton OK est grisè  ")
        aqObject.CheckProperty(Get_WinEditQuantity_BtnOK(), "Enabled", cmpEqual, false);
         Log.Message("Mettre la quantité  à 200  ")
         
        Get_WinEditQuantity_TxtRequestedQuantity().set_Text(quantityStep3);
        Get_WinEditQuantity_TxtRequestedQuantity().Click();
        Log.Message("Clic sur le bouton OK")
        Get_WinEditQuantity_BtnOK().WaitProperty("Enabled", true, 15000);
        Get_WinEditQuantity_BtnOK().Click();  
        Log.Message("Clic sur le bouton sauvegarder")
        Get_WinOrderDetail_BtnSave().Click();

        /*******************************************************Étape 4************************************************************************/     
  /*        
       Sélectionner les ordres 10001 et  10010 puis cliquer sur le bouton Fusionner  */
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Sélectionner les ordres 10001 et  10010 puis cliquer sur le bouton Fusionner ");
        Log.Message("Sélectionner l'ordre 10001") 
         var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10001 ){
                  var dispalyQuantite10001=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue;
                      CheckEquals(dispalyQuantite10001, quantityStep4, "La quantité affiché de l'ordre 10001 est : "); 
                 Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           }
           

            Sys.Desktop.KeyDown(0x11);
            Log.Message("Sélectionner l'ordre 10010") 
             var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10010  ){
                 
                      
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
//                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           } 
         Sys.Desktop.KeyUp(0x11);
         
         Log.Message("Cliquer sur le bouton Fusionner")
         Get_OrderAccumulator_BtnMerge().Click();
         
         Log.Message("Les deux ordres sont fusionnés")
         
          var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10001 ){
                  var dispalyQuantite10001=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue;
                      CheckEquals(dispalyQuantite10001, quantityStep4OrdreFusion, "La quantité affiché de l'ordre 10001 est : "); 
                 
                      break;
                 }
              
           }

      /************************************Étape 5************************************************************************/     
  /*        
      Sélectionner l'ordre 10001 puis cliquer sur le bouton Diviser */
        
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Sélectionner l'ordre 10001 puis cliquer sur le bouton Diviser ");
        Log.Message("Sélectionner l'ordre 10001") 
          var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10001  ){
                 
                      
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           } 
           
        Log.Message("Cliquer sur le bouton Divsiser");
        Get_OrderAccumulatorGrid().FindChild("Value", orderNum10002, 10).Click();
        Get_OrderAccumulatorGrid().FindChild("Value", orderNum10001, 10).Click();
        Get_OrderAccumulator_BtnSplit().Click();
 

      /************************************Étape 6************************************************************************/     
  /*        
     Sélectionner le compte 800001-OB puis cliquer sur Diviser   */
      Log.PopLogFolder();
      logEtape6 = Log.AppendFolder("Étape 6:  Sélectionner le compte 800001-OB puis cliquer sur Diviser ");
      Log.Message("Sélectionner le compte 800001-OB puis cliquer sur Diviser")
      Get_WinSplitBlock_DgvAccounts().FindChild("Value", account800001OB, 100).Click();   
      Log.Message("Cliquer sur le bouton Diviser")     
      Get_WinSplitBlock_BtnCreateBlock().Click();
      Log.Message("La division est complète")
       var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10001 ){
                  var dispalyQuantite10001=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue;
                      CheckEquals(dispalyQuantite10001, quantityStep6OrdreDivision, "La quantité affiché de l'ordre 10001 est : "); 
                 
                      break;
                 }
              
           }
           
       /************************************Étape 7************************************************************************/     
  /*        
    Sélectionner l'ordre 10001 puis cliquer sur le bouton Supprimer et confirmer la suppression  
  */
      Log.PopLogFolder();
      logEtape7 = Log.AppendFolder("Étape 7:  Sélectionner l'ordre 10001 puis cliquer sur le bouton Supprimer et confirmer la suppression  ");          
           
      Log.Message("Sélectionner l'ordre 10001") 
          var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10001  ){
                 
                      
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           } 
           
        Log.Message("Cliquer sur le bouton Supprimer");
        Get_OrderAccumulator_BtnDelete().Click(); 
        Get_DlgConfirmation_BtnYes().Click(); 
        Log.Message("Vérifié que l'ordre est supprimé")   
        var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
        var existenceOrdre=false
          for (n=0 ; n< lines.length; n++){
             if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10001  ){
                 
                   
                     existenceOrdre=true
                      break;
             }
            
              
           }  
           if(existenceOrdre == true)  
            Log.Error("L'orde n'est pas supprimé")
           else
             Log.Checkpoint("L'orde est supprimé")

  

       
       /************************************Étape 8************************************************************************/     
  /*        
   1. Sélectionner l'ordre 10002 puis cliquer sur Modifier

   2. Dans la fenêtre Détail de l'ordre, sélectionner le compte sous-jascent 800002-NA puis clic sur Modifier
  */
      Log.PopLogFolder();
      logEtape8 = Log.AppendFolder("Étape 8: 1. Sélectionner l'ordre 10002 puis cliquer sur Modifier.2. Dans la fenêtre Détail de l'ordre, sélectionner le compte sous-jascent 800002-NA puis clic sur Modifier  ");          
              
      Log.Message("Sélectionner l'ordre 10002") 
          var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10002  ){
                 
                      
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
           
              
           }   
     Log.Message("Cliquer sur Modifier")         
     Get_OrderAccumulator_BtnEdit().Click();
     Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().FindChild("Value", account800002NA, 100).Click();
     Log.Message("cliquer sur le bouton Modifier")
     Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit().Click()
     Log.Message("le bouton Modifier est toujours grisé")   
     aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(), "IsEnabled", cmpEqual, false); 
     aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(), "IsEnabled", cmpEqual, false);   
     Log.Message("Les boutons Sauvegarder et Soumettre sont absents")  
     SetAutoTimeOut();   
		   
		   if (Get_WinOrderDetail_BtnSave().Exists)
    {
        if (Get_WinOrderDetail_BtnSave().VisibleOnScreen){  
          Log.Error("Le bouton sauvegarder est visible")
        
        }
  		else
  		Log.Checkpoint("Le bouton sauvegarder n'est pas visible")
      }
        if (Get_WinOrderDetail_BtnApprove().Exists)
    {
        if (Get_WinOrderDetail_BtnApprove().VisibleOnScreen){  
          Log.Error("Le bouton Soumettre est visible")
        
        }
  		else
  		Log.Checkpoint("Le bouton Soumettre n'est pas visible")
      }
      
  	 RestoreAutoTimeOut();
     Get_WinOrderDetail_BtnCancel().Click();
      
           /************************************Étape 9************************************************************************/     
  /*        
   Exécuter le script en piece jointe pour restaurer les ordres de 10001 à 10010  */
      Log.PopLogFolder();
      logEtape9 = Log.AppendFolder("Étape 9:Exécuter le script en piece jointe pour restaurer les ordres de 10001 à 10010 ");          
      //  Executer le fichier SQL pour restorer la BD
      ExecuteSQLFile(folderPath_Data + "restoredata1179.sql", vServerOrders)

      ExecuteSQLFile(folderPath_Data + "ordres_CP_new.sql", vServerOrders)
      Log.Message("Acceder au Module Ordres");
      Get_ModulesBar_BtnOrders().Click();
      Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
 

      
           /************************************Étape 10************************************************************************/     
  /*        
  Sélectionner les ordres 10003 et 10010 puis clic sur le bouton Fusionner  */
      Log.PopLogFolder();
      logEtape10 = Log.AppendFolder("Étape 10:Sélectionner les ordres 10003 et 10010 puis clic sur le bouton Fusionner ");          
        Log.Message("Sélectionner l'ordre 10001") 
         var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10003 ){
                  var dispalyQuantite10001=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue;
                            Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           }
           

            Sys.Desktop.KeyDown(0x11);
            Log.Message("Sélectionner l'ordre 10010") 
             var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10010  ){
                 
                      
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           } 
         Sys.Desktop.KeyUp(0x11);
         
       
       
         Log.Message("Vérifier que le bouton Fusionner est grisè")
     
          aqObject.CheckProperty( Get_OrderAccumulator_BtnMerge(), "Enabled", cmpEqual, false);  
        /************************************Étape 11************************************************************************/     
  /*        
//        1. Sélectionner l'ordre 10006 puis clic sur Diviser
//
//        2.Dans la fenêtre Diviser le bloc NA, sélectionner le compte sous-jascent 800002-NA puis clic sur Diviser  */
      Log.PopLogFolder();
      logEtape11 = Log.AppendFolder("Étape 11: 1. Sélectionner l'ordre 10006 puis clic sur Diviser 2.Dans la fenêtre Diviser le bloc NA, sélectionner le compte sous-jascent 800002-NA puis clic sur Diviser ");          
      Log.Message("Sélectionner l'ordre 10006")
      var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10006 ){
                 
                      
                 Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           }
      Log.Message("Clic sur le bouton Diviser")   
      Get_OrderAccumulator_BtnSplit ().Click(); 
           
        Log.Message("Dans la fenêtre Diviser le bloc NA, sélectionner le compte sous-jascent 800002-NA")
        Get_WinSplitBlock_DgvAccounts().FindChild("Value", account800002NA, 100).Click();   
        Log.Message("Cliquer sur le bouton Diviser")     
       Get_WinSplitBlock_BtnCreateBlock().Click();
       Log.Message("Affichage du message:Avertissement: L'ordre est en lecture seule.")
       aqObject.CheckProperty( Get_DlgInformation_LblMessage1(), "WPFControlText", cmpEqual, msgInformatStep11);  
       Log.Message("Click sur le bouton OK pour la fenêtre d'information") 
       Get_DlgInformation_BtnOK().Click();
  



           /************************************Étape 12************************************************************************/     
  /*        
        1.Sélectionner l'ordre 10007 puis clic sur Supprimer

        2. Confirmer la suppression */
      Log.PopLogFolder();
      logEtape12 = Log.AppendFolder("Étape 12: 1.Sélectionner l'ordre 10007 puis clic sur Supprimer 2. Confirmer la suppression ");          
      Log.Message("Sélectionner l'ordre 10007")
       var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == orderNum10007 ){
                 
                 Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           } 
      Log.Message("Click sur le bouton supprimer")   
      Get_OrderAccumulator_BtnDelete().Click(); 
      Get_DlgConfirmation_BtnYes().Click();  
       Log.Message("Vérification de l'affichage du message :Avertissement: L'ordre est en lecture seule.")      
       aqObject.CheckProperty( Get_DlgWarning_LblMessage1(), "WPFControlText", cmpEqual, msgInformatStep11);  
       Log.Message("Clic sur OK de la fenêtre d'avertissement")    
       Get_DlgWarning_BtnOK().Click();  


           /************************************Étape 13************************************************************************/     
//Executer le fichier SQL pour restorer la BD
      Log.PopLogFolder();
      logEtape13 = Log.AppendFolder("Étape 13: Executer le fichier SQL pour restorer la BD");          
      Log.Message("Sélectionner l'ordre 10007")
      ExecuteSQLFile(folderPath_Data + "restoredata1179.sql", vServerOrders)
           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
    }
    finally {  
       
      Terminate_CroesusProcess(); //Fermer Croesus
       
    }
 }

function test(){
  
// ExecuteSQLFile(folderPath_Data + "ordres_CP_new.sql", vServerOrders)
           ExecuteSQLFile(folderPath_Data + "tcve2309.sql", vServerOrders)
}