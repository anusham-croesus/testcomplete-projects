//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-308; TCVE-325
    Description          :  GDO Ajouter des ordres pour permettre la vérification de la case Pro dans l'accumulateur 
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.14-Lu-47
  
    
*/


function GDO_TCVE308_Validate_Checkbox_Pro() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-308");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
            var columnPro=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "columnPro", language+client); 
            var acc800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800300NA", language+client);
            var acc800287NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800287NA", language+client);            
            var quantityTCVE308=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTCVE308", language+client);
            var symbolNATCVE308=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolNA_TCVE308", language+client);
            var acc800217RE=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800217RE", language+client);
            var quantityTCVE308_1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTCVE308_1", language+client);
            var quantityTCVE308_2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTCVE308_2", language+client);
            var cmbTransactionType_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionType_TCVE312", language+client);
            var cmbTransaction_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransaction_TCVE312", language+client);
            var CAD_ACCOUNT=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CAD_ACCOUNT", language+client);
            var proYes=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ProYes", language+client);  
            var proNon=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ProNon", language+client);  
            var accountNo314=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "accountNo314", language+client);  
            var columnPro=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "columnProtext", language+client); 
             
             //fermer les fichiers excel
            while(Sys.waitProcess("EXCEL").Exists){Sys.Process("EXCEL").Terminate();}
            
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            DeleteAllOrdersInAccumulator();  
            
            //les étapes 1 et 2
            ValidateChkPro(acc800300NA,true,quantityTCVE308,symbolNATCVE308);
            
            //les étapes 3 et 4
            ValidateChkPro(acc800217RE,false,quantityTCVE308_1,symbolNATCVE308);
                                                      
            Log.Message(" - Aller dans le module comptes.Sélectionner le compte 800287-NA");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            SearchAccount(acc800287NA);  
                        
            //cliquer sur Ordres multiples en bloc et d'échanges d'achat (icone bleue et rose $)
            Log.Message("cliquer sur Ordres multiples en bloc et d'échanges d'achat (icone bleue et rose $)");  
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Choisir type transaction Achat  - Transaction(s) = Achat - cliquer sur Ajouter- Quantité = 102- combo choisir 'Unité par compte' - symbole = NA
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransactionType_TCVE312],10).Click();
            AddABuyBySymbol(quantityTCVE308_2,cmbTransaction_TCVE312,symbolNATCVE308);   
                           
            //Valider que l'ordre d'achat du titre NA est ajouté
            CheckABuyInGrid(quantityTCVE308_2,symbolNATCVE308);  
            
            //cliquer sur Générer
            Log.message("cliquer sur Générer");
            Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true, maxWaitTime);
            Get_WinSwitchBlock_BtnGenerate().Click();
            if (Get_WinSwitchBlock().Exists)
              Get_WinSwitchBlock_BtnGenerate().Click();      
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");      
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd");
          
            //L'ordre est envoyé dans l'accumulateur
            Log.Message("L'ordre est envoyé dans l'accumulateur");
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("Value",CAD_ACCOUNT,10), "Exists", cmpEqual, true); 
 
 
            /* Aller dans le module des ordres section Accumulateur ;Sélectionner le compte inventaire (CAD_ACCOUNT);
            Faire un double click pour ouvrir la fenêtre Détail de l'ordre 
            Après validation fermer la fenêtre par Annuler*/
            Log.Message("Aller dans le module des ordres section Accumulateur ;Sélectionner le compte inventaire (CAD_ACCOUNT)");
            Get_OrderAccumulatorGrid().FindChild("Value",CAD_ACCOUNT,10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
          
            /*Sous la section Compte (CAD_ACCOUNT) la case Pro n'est pas visible*/
            Log.Message("Sous la section Compte (CAD_ACCOUNT) la case Pro n'est pas visible");
            aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_ChkPro(), "VisibleOnScreen", cmpEqual, false);
            aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_ChkPro(), "IsVisible", cmpEqual, false);
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
                        
            /*Dans la section de l'accumulateur Ajouter la colonne 'Pro' */
            Log.Message("Dans la section de l'accumulateur Ajouter la colonne 'Pro'");
            SetAutoTimeOut();
            if(!Get_OrderAccumulatorGrid_ChPro().Exists){
                 Get_OrderAccumulatorGrid_ChAccountNo().ClickR(); 
                 Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();            
                 Get_GridHeader_ContextualMenu_AddColumn_Pro().Click(); 
            }
            RestoreAutoTimeOut();
                      
            /*Sous la colonne Pro:compte CAD_ACCOUNT -> Coché;compte 800217-RE   -> vide ;Compte 800300-NA   -> Coché*/ 
            Log.Message("Valider que Sous la colonne Pro:compte CAD_ACCOUNT -> Coché;compte 800217-RE   -> vide ;Compte 800300-NA   -> Coché");
            aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChPro(), "Content", cmpEqual, columnPro);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("WPFControlText",CAD_ACCOUNT,10).DataContext.DataItem, "IsProAccount", cmpEqual, true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("WPFControlText",acc800217RE,10).DataContext.DataItem, "IsProAccount", cmpEqual, false);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("WPFControlText",(acc800300NA),10).DataContext.DataItem, "IsProAccount", cmpEqual, true);

            /*Trier la colonne Pro. Valider que la colonne est triable*/
            Log.Message("Trier la colonne Pro. Valider que la colonne est triable");
            Get_OrderAccumulatorGrid_ChPro().Click();
            if(Get_OrderAccumulatorGrid_ChPro().SortStatus!="Descending"){
              Get_OrderAccumulatorGrid_ChPro().Click();
            }            
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem,"IsProAccount",cmpEqual,true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem,"IsProAccount",cmpEqual,true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem,"IsProAccount",cmpEqual,false);
              
            Get_OrderAccumulatorGrid_ChPro().Click();
             if(Get_OrderAccumulatorGrid_ChPro().SortStatus!="Ascending"){
              Get_OrderAccumulatorGrid_ChPro().Click();
            }
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem,"IsProAccount",cmpEqual,false);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem,"IsProAccount",cmpEqual,true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem,"IsProAccount",cmpEqual,true);              
            
            /*Dans la section Accumulateur;Faire un right Click Exporter vers Ms Excel...*/
            var sTempFolder = Sys.OSInfo.TempDirectory;
            var FolderPath = sTempFolder+"\CroesusTemp\\";
            Log.Message(FolderPath);
      
            Log.Message("Dans la section Accumulateur;Faire un right Click Exporter vers Ms Excel...");
            ClickOnExportToExcel(Get_OrderAccumulatorGrid());
          
            //fermer les fichiers excel
            while(Sys.waitProcess("EXCEL").Exists){Sys.Process("EXCEL").Terminate();}

            /*L'excel est créé avec la colonne Pro;no compte CAD_ACCOUNT -> Oui;no compte 800300-NA -> Oui;no Compte 800217-RE -> Non*/
            Log.Message("valider que l'excel est créé avec la colonne Pro;no compte CAD_ACCOUNT -> Oui;no compte 800300-NA -> Oui;no Compte 800217-RE -> Non");
            CheckExcel(CAD_ACCOUNT,acc800300NA,acc800217RE,proYes,proNon,accountNo314,columnPro,FolderPath);
                   
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
            
      }
      finally {
	        //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language); 
            Get_ModulesBar_BtnOrders().Click();
            //Supprimer l'ordre généré
            DeleteAllOrdersInAccumulator();  
            //Supprimer les fichiers 
            aqFileSystem.DeleteFile(FolderPath + "*.*");           
            //Fermer l'application
            Terminate_CroesusProcess();              
        }
}

function CheckExcel(CAD_ACCOUNT,acc800300NA,acc800217RE,proYes,proNon,accountNo314,columnPro,FolderPath){

      var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
      var ExportedFilePath = FindLastModifiedFileInFolder(FolderPath,FileNameContains); 
                  
      var myFile = aqFile.OpenTextFile(ExportedFilePath, aqFile.faRead, aqFile.ctANSI);                 
      // Reads text lines from the file and posts them to the test log 
      var countLineInMyFile=0; // les lignes dans le fichier 
      while(! myFile.IsEndOfFile()){    
        countLineInMyFile++;
        line = myFile.ReadLine();
        // Split at each space character.
        var textArr = line.split("	"); 
        var lengthOfArr=textArr.length
        //Log.Message(line)      
        if(countLineInMyFile==1){  
            for(var i=0; i<lengthOfArr;i++){
                if(aqString.Unquote(VarToString(textArr[i]))==accountNo314){
                  var positionAcc=i;
                  Log.Message("La colonne [No de compte] est dans la " +positionAcc+ " -em position dans le fichier Excel");
                }
                if(aqString.Unquote(VarToString(textArr[i]))==columnPro){
                  Log.Checkpoint("La colonne [Pro] est présente");
                  var positionPro=i;
                  Log.Message("La colonne [Pro] est dans la " +positionPro+ " -em position dans le fichier Excel");
                }
            }
        }
        else{
            if(aqString.Unquote(VarToString(textArr[positionAcc]))==CAD_ACCOUNT){
              Log.Message("Valider que le compte "+ CAD_ACCOUNT + " est Pro/ est à Oui");
              if(aqObject.CompareProperty(aqString.Unquote(VarToString(textArr[positionPro])),cmpEqual,proYes,lmError)){
                Log.Checkpoint("le compte "+ CAD_ACCOUNT +" est Pro/ est à Oui");
              }
              else{
                Log.Error("le compte "+ CAD_ACCOUNT +" n'est pas Pro/ n'est pas à Oui");
              }
            }
            if(aqString.Unquote(VarToString(textArr[positionAcc]))==acc800217RE){
              Log.Message("Valider que le compte "+ acc800217RE + " n'est pas Pro/ est à Non");
              if(aqObject.CompareProperty(aqString.Unquote(VarToString(textArr[positionPro])),cmpEqual,proNon,lmError)){
                Log.Checkpoint("le compte "+ acc800217RE +" n'est pas Pro. Il est à Non");
              }
              else{
                Log.Error("le compte "+ acc800217RE +" est Pro.Il n'est pas à Non");
              } 
            }
            if(VarToString(textArr[positionAcc])==acc800300NA){
              Log.Message("Valider que le compte "+ acc800300NA + " est Pro/ est à Oui");
              if(aqObject.CompareProperty(aqString.Unquote(VarToString(textArr[positionPro])),cmpEqual,proYes,lmError)){
                Log.Checkpoint("le compte "+ acc800300NA +" est Pro. Il est à Oui");
              }
              else{
                Log.Error("le compte "+ acc800300NA +" n'est pas Pro. Il n'est pas à Oui");
              }
            }
        }                
      }
}



function ValidateChkPro(acc,chkPro,quantity,symb){
      /* Aller dans le module comptes - Sélectionner le compte*/+ acc +/* cliquer sur Créer un Ordres d'achat (icone bleue $)- Cocher Actions + OK*/
      Log.Message("Aller dans le module comptes - Sélectionner le compte 800300-NA- cliquer sur Créer un Ordres d'achat (icone bleue $)- Cocher Actions + OK")
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
      SearchAccount(acc);            
      Get_Toolbar_BtnCreateABuyOrder().Click();     
      Get_WinFinancialInstrumentSelector_RdoStocks().Click();
      Get_WinFinancialInstrumentSelector_BtnOK().Click();
                                 
      /*La fenêtre détail de l'ordre apparait.- Sous la section Compte le champ Pro checkbox */+ chkPro 
      Log.Message("La fenêtre détail de l'ordre apparait.- Sous la section Compte le champ Pro checkbox est "+ chkPro);
      aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey(), "Text", cmpEqual, acc);
      aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_ChkPro().DataContext, "IsProAccount", cmpEqual, chkPro);
                      
            
      /*Dans la fenêtre détail de ordre Quantité = */+ symb +/* (recherche le symbole et sélectionner banque nationnel du Canada).Cliquer sur Vérifier +  Sauvegarder*/ 
      Log.Message("Dans la fenêtre détail de ordre Quantité ="+ quantity + "Symbole = "+symb+" (recherche le symbole et sélectionner banque nationnel du Canada).Cliquer sur Vérifier +  Sauvegarder");
      Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symb)
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
      SetAutoTimeOut(); 
      if(Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value",symb,10).DblClick();
      }   
      RestoreAutoTimeOut();        
      //Vérifier et sauvgarder
      Get_WinOrderDetail_BtnVerify().Click();
      Get_WinOrderDetail_BtnSave().Click();
                     
      /*l'ordre est envoyé dans l'accumulateur.*/ 
      Log.Message("valider que l'ordre est envoyé dans l'accumulateur.");  
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("Value",acc,10), "Exists", cmpEqual, true);  
}

