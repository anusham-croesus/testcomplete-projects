//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**

                  
                
        
    storie:TCVE-403.
    lien  du cas de test sur jira: https://jira.croesus.com/browse/TCVE-403
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation :    sana Ayaz
    
    Version de scriptage:	90.15.2020.3-4
*/

function CR2243_PreparationCreatOrdreDifferentCategSecurByAddinExchang()
{
    try {
      
       Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
      
        var  userNameKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var  passwordKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var typeAchat                    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "typeAchat", language+client);
        var typeVente                    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "typeVente", language+client);  
        
        var Account800273RE              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "Account800273RE", language+client);  
        var Account800273OB              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "Account800273OB", language+client); 
         var arrayOfAccountsNo = new Array(Account800273RE,Account800273OB)
        //Varibales pour l'étape 2
        var  symbolBuyTCVE403Step2       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step2", language+client); 
        var  accountBuyTCVE403Step2      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "accountBuyTCVE403Step2", language+client);          
        var  statusApprovedTCVE403Step2  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusApprovedTCVE403Step2", language+client);   
        var  quantityTCVE403Step2        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantityTCVE403Step2", language+client); 
        var  securityTCVE403Step2        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step2", language+client);   
          //Varibales pour l'étape 3
        var  symbolBuyTCVE403Step3       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step3", language+client); 
        var  accountBuyTCVE403Step3      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "accountBuyTCVE403Step3", language+client);          
        var  statusApprovedTCVE403Step3  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusApprovedTCVE403Step3", language+client);   
        var  quantityTCVE403Step3        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantityTCVE403Step3", language+client); 
        var  securityTCVE403Step3        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step3", language+client);  
        
        //Varibales pour l'étape 4
        var  symbolBuyTCVE403Step4       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step4", language+client); 
        var  accountBuyTCVE403Step4      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "accountBuyTCVE403Step4", language+client);          
        var  statusApprovedTCVE403Step4  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusApprovedTCVE403Step4", language+client);   
        var  quantityTCVE403Step4        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantityTCVE403Step4", language+client); 
        var  securityTCVE403Step4        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step4", language+client);  
        
        //Varibales pour l'étape 5
        var  symbolBuyTCVE403Step5       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step5", language+client); 
        var  accountBuyTCVE403Step5      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "accountBuyTCVE403Step5", language+client);          
        var  statusApprovedTCVE403Step5  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusApprovedTCVE403Step5", language+client);   
        var  quantityTCVE403Step5        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantityTCVE403Step5", language+client); 
        var  securityTCVE403Step5        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step5", language+client);  
        
         //Varibales pour l'étape 6
        var  symbol_TCVE412Step3       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbol_TCVE412Step3", language+client); 
        var  accountBuyTCVE403Step6      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "accountBuyTCVE403Step6", language+client);          
        var  statusApprovedTCVE403Step6  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusApprovedTCVE403Step6", language+client);   
        var  quantityTCVE403Step6        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantityTCVE403Step6", language+client); 
        var  securityTCVE403Step6        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step6", language+client);
        
         //Varibales pour l'étape 7
        var  symbolBuyTCVE403Step7       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step7", language+client); 
        var  accountBuyTCVE403Step7      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "accountBuyTCVE403Step7", language+client);          
        var  statusApprovedTCVE403Step7  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusApprovedTCVE403Step7", language+client);   
        var  quantityTCVE403Step7        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantityTCVE403Step7", language+client); 
        var  securityTCVE403Step7        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step7", language+client);    
        //étape 8
        var cmbTransactionType_TCVE403       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "cmbTransactionType_TCVE403", language+client);   
        var Account800273RE              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "Account800273RE", language+client);  
        var Account800273OB              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "Account800273OB", language+client); 
        var arrayOfAccountsNo            = new Array(Account800273RE,Account800273OB)
        var quantity_TCV403              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantity_TCV403", language+client); 
        var symbol_TCVE403               = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbol_TCVE403", language+client); 
        var cmbTransactionSource_TCVE403 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "cmbTransactionSource_TCVE403", language+client); 
        var descriptionTitreTCVE403      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "descriptionTitreTCVE403", language+client); 
        var quantity_TCV403dispalyBlotter= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantity_TCV403dispalyBlotter", language+client); 

        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_INTERNAL_NUMBER_FX","YES",vServerOrders)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_FX_TAB_MF","YES",vServerOrders)
        RestartServices(vServerOrders)
//         B55444 (devise-USD) sur le compte 800300-NA (devise: CAD) / Vérifier et soumettre l'ordre.
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
//        Creation d'ordre 
//        Get_ModulesBar_BtnOrders().Click();
//        /*Créer un ordre sur un titre ayant une devise différente du compte associé,
//         par exemple, Achat de revenu fixe, titre:
//         B55444 (devise-USD) sur le compte 800300-NA (devise: CAD) / Vérifier et soumettre l'ordre.*/
         Log.Message("**************************L'étape 2 du cas de test***********************")
         //Creation d'ordre 
         AjoutOrdreAchatTCVE403EtCheckpoint(typeAchat,3,symbolBuyTCVE403Step2,accountBuyTCVE403Step2,statusApprovedTCVE403Step2,quantityTCVE403Step2,securityTCVE403Step2)
         Log.Message("**************************L'étape 3 du cas de test***********************")
         AjoutOrdreAchatTCVE403EtCheckpoint(typeAchat,1,symbolBuyTCVE403Step3,accountBuyTCVE403Step3,statusApprovedTCVE403Step3,quantityTCVE403Step3,securityTCVE403Step3)
         
         Log.Message("**************************L'étape 4 du cas de test***********************")
         AjoutOrdreAchatTCVE403EtCheckpoint(typeAchat,1,symbolBuyTCVE403Step4,accountBuyTCVE403Step4,statusApprovedTCVE403Step4,quantityTCVE403Step4,securityTCVE403Step4)
          
         Log.Message("**************************L'étape 5 du cas de test***********************")
         AjoutOrdreAchatTCVE403EtCheckpoint(typeVente,1,symbolBuyTCVE403Step5,accountBuyTCVE403Step5,statusApprovedTCVE403Step5,quantityTCVE403Step5,securityTCVE403Step5)
          
         Log.Message("**************************L'étape 6 du cas de test***********************")
         AjoutOrdreAchatTCVE403EtCheckpoint(typeAchat,4,symbol_TCVE412Step3,accountBuyTCVE403Step6,statusApprovedTCVE403Step6,quantityTCVE403Step6,securityTCVE403Step6)
          
           
         Log.Message("**************************L'étape 7 du cas de test***********************")
         AjoutOrdreAchatTCVE403EtCheckpoint(typeVente,4,symbolBuyTCVE403Step7,accountBuyTCVE403Step7,statusApprovedTCVE403Step7,quantityTCVE403Step7,securityTCVE403Step7)
         
         
          Log.Message("**************************L'étape 8 du cas de test***********************") 
        
           /*Aller dans le module Compte; Sélectionner les comptes 800273-RE et 800273-OB
            cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)*/
            Log.Message("Aller dans le module Compte; Sélectionner les comptes 800273-RE et 800273-OB");
            SelectAccounts(arrayOfAccountsNo)
            Log.Message("cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose)");
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");          
           /*Dans la fenêtre choisir;transactions = Achat + Ajouter ;Quantité = 50;Unités par compte;Symbole = BNS ( BANQUE DE NOUVELLE-ECOSSE)  
            Cliquer sur Générer*/
            Log.Message("Dans la fenêtre choisir;transactions = Achat + Ajouter ;Quantité = 100;Unités par compte;Symbole = RY (BANQUE ROYALE DU CDA)  BOURSE TSE");
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransactionType_TCVE403],10).Click();
            AddABuyBySymbol(quantity_TCV403,cmbTransactionSource_TCVE403,symbol_TCVE403); 
            Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691 
            Delay(1000);                          
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            Log.Message("Valider que l'ordre est envoyée dans l'accumulateur");
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "SecurityDesc", cmpEqual,descriptionTitreTCVE403 );
          
            Get_OrderAccumulatorGrid().Find("Value",descriptionTitreTCVE403,10).Click();
            WaitObject(Get_CroesusApp(), ["Uid", "IsEnabled"], ["Button_4407", true]);
            Get_OrderAccumulator_BtnVerify().Click();
            //Côcher la cas Inclure + Soumettre
           // Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).set_IsChecked(true)
            if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
            Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
            WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
            Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
            Get_WinAccumulator_BtnSubmit().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["BatchOrderVerificationWindow_342c", true]);
            //Les points de vérifications : L'ordre s'affiche  dans le blotter.
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,statusApprovedTCVE403Step2);
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "SecurityDesc", cmpEqual,descriptionTitreTCVE403);  
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity_TCV403dispalyBlotter);

          
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
       
        
    }
    finally {
		//Fermer le processus Croesus
    Terminate_CroesusProcess();  
      
    }
}
    
function AjoutOrdreAchatTCVE403EtCheckpoint(typeOrdeAchatOuVente,typeOrdreAchat,symbolAchatVenteTCVE403,accountAchatVenteTCVE403,statusApprovedTCVE403,quantityTCVE403,securityTCVE403)
{
        
       var typeAchat                     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "typeAchat", language+client);
       var typeVente                     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "typeVente", language+client);  
       var quantiteOrdreFondInvestiss    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "quantiteOrdreFondInvestiss", language+client);  
       var securityTCVE403TSESymAGU      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403TSESymAGU", language+client);  
       var securityTCVE403Step4          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step4", language+client);  
    
    
       
       
          Get_ModulesBar_BtnOrders().Click();
          if(typeOrdeAchatOuVente == typeAchat )
          {
          Get_Toolbar_BtnCreateABuyOrder().Click();
          }
           if(typeOrdeAchatOuVente == typeVente )
          {
          Get_Toolbar_BtnCreateASellOrder().Click();
          }
          
          if(typeOrdreAchat==3){

          Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
          }
          if(typeOrdreAchat==1){
        
          Get_WinFinancialInstrumentSelector_RdoStocks().Click();
          }
           if(typeOrdreAchat==4){
 
          Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
          }
          Get_WinFinancialInstrumentSelector_BtnOK().Click();
          //Saisir le titre 
           Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountAchatVenteTCVE403)
           Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
           if(typeOrdreAchat==3){
           Get_WinFixedIncomeOrderDetail_TxtQuantity().Keys(quantityTCVE403);
           }
           if(typeOrdreAchat==1){
           Get_WinStocksOrderDetail_TxtQuantity().Keys(quantityTCVE403);
           }
            if(typeOrdreAchat==4){  Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Click();
             Get_WinMutualFundsOrderDetail_TxtQuantity().Keys(quantityTCVE403);
           }
         
           
           
           Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
           Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(symbolAchatVenteTCVE403);
           
             Get_WinOrderDetail_GrpSecurity_BtnSearch().Click();
             Get_WinOrderDetail_GrpSecurity_BtnSearch().Click();
             
             SetAutoTimeOut();
           if(Get_SubMenus().Exists){  
                if(symbolAchatVenteTCVE403 == "AGU")
           securityTCVE403=securityTCVE403TSESymAGU
             Get_SubMenus().Find("Value",securityTCVE403,10).DblClick();
              }   
              RestoreAutoTimeOut();
   
          //Get_WinOrderDetail_GrpSecurity_BtnSearch().Click();
           Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        
              //Cliquer sur vérifier ensuite soumettre
            Get_WinOrderDetail_BtnVerify().Click();
            if (language == "french") WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Soumettre"]);
            else WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Submit"]);
            Get_WinOrderDetail_BtnVerify().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
           //Les points de vérifications :L'ordre s'ajoute dans le Blotter avec l'état : Approuvé  
       
          Get_OrderGrid().RecordListControl.Items.Item(0).set_IsActive(true);
           Get_OrderGrid().RecordListControl.Items.Item(0).set_IsSelected(true)
           //Les points de vérifications
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,statusApprovedTCVE403);
            if(symbolAchatVenteTCVE403 == "AGU")
           securityTCVE403=securityTCVE403Step4
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "SecurityDesc", cmpEqual,securityTCVE403);  
                if(typeOrdreAchat==4)
                 aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantiteOrdreFondInvestiss);
             
                 else
                  aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantityTCVE403);    
      
       

}


 function AddABuyBySymbol(quantity,cmbTransaction,symbol){
            Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            
            //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
            Get_WinSwitchSource_CmbSecurity().Click();
            Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
            
            Get_WinSwitchSource_TxtQuantity().Keys(quantity);
            //Get_WinSwitchSource_CmbQuantity().Click();
             Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
         
            
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction],10).Click();
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
            Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
            SetAutoTimeOut();
            if(Get_SubMenus().Exists){
              Get_SubMenus().FindChild("Value",symbol,10).DblClick();
            }
            RestoreAutoTimeOut();
            Get_WinSwitchSource_btnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
 }
 