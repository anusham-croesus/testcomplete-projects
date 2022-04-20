//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT GDO_2464_Split_Of_BlockTrade

/* Description :Ajout d`un ordre d'achat
Regrouper les scripts suivants:

GDO_2470_Report_Of_NegotiatedRates_Case1
GDO_2470_Report_Of_NegotiatedRates_Case2
GDO_2473_Report_Of_FidessRates_Case1
GDO_2474_Report_Of_FidessRates_Case2_NO
GDO_2474_Report_Of_FidessRates_Case2_YES
GDO_2475_Report_Of_FidessRates_Case3_NO
GDO_2475_Report_Of_FidessRates_Case3_YES
GDO_2456_FundReport
 
Analyste d'automatisation: Youlia Raisper
La version du scriptage: 	ref90-19-2020-09-141*/ 
 
function OPTI_GDO_Reports()
{   
    //Lien de la story dans Jira
    Log.Link("https://jira.croesus.com/browse/TCVE-4314","Lien de la story dans Jira");
    //Lien du cas de test dans jira
    Log.Link("https://jira.croesus.com/browse/TCVE-4306","Lien du cas de test dans Jira");
    
    var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logRetourEtatInitial;
    try{
        var user                  =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");   
        var account               =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800279RE", language+client);
        var cmbTypesymbol         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client); 
        var buy                   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var stock                 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentStocks_2453", language+client);
        var item                  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
        var quantity2470           =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2470", language+client);
        var securityDescription   =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2471", language+client);
        var securityPEP           =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2471", language+client);
        var SecuritiesPEPRAC      =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritiesPEPRAC", language+client);
        var securityRAC           =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_RAC", language+client);
        var securityAAT123        =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolAAT123", language+client);//"AAT123";
        var securitySymbolPEP     =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "securitySymbolPEP", language+client);//"PEP.US";
        var statusOpen            =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
        var statusPendingApproval =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        var quantityFillOrder     =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityFillOrder_2471", language+client);
        var price                 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Price_2471", language+client);
        var market                =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Market_2471", language+client);
        var rateOrigin            =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "RateOrigin_2471", language+client);
        var exchangeRate          =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ExchangeRate_2471", language+client);
        var statusPartialFill     =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusPartialFill_2482", language+client);
        var checkExchangeRate     =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CheckExchangeRate", language+client);
        var sTempFolder           =Sys.OSInfo.TempDirectory;
        var FolderPath            =sTempFolder+"\CroesusTemp\\";
        var message               =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Message_2471", language+client);
        var item2456              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
        var statusExecuted        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusExecuted_2483", language+client);
        var arrayOfSecuritiesPEPRAC = SecuritiesPEPRAC.split("|");
        
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
        
        // ********************************************************Étape 1*******************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1:Création d'un ordre d'achat");
        /*
         **********  Step 1:       
        1.1 Dans le module Comptes, sélectionnez un compte CAD (ex : 800279-RE)
        Cliquer sur créer un ordre d'achat d'Achat
        Cocher Actions, puis OK
        Quantité 400, symbole = PEP (2 fois RAC)
        Cliquez sur créer un ordre d'achat d'Achat cocher fond , puis OK
        25 unités par compte et symbole FID224 et valider avec OK.
        Vérifier puis soumettre

        1.2 Répéter la création 2 fois

        1.3 au lieu d'action cocher "MutualFunds" titre -> AAT CPG G/R S23/FR/N
        Après cette étape, on va avoir 3 ordres créés dans blotteur : 2 actions et 1 fonds d'investissement*/
        
               
        Log.Message("se connercter avec Keynej");
        Login(vServerOrders, user, psw, language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("Delete all the orders in the accumulator for easy finding newly created orders");
        DeleteAllOrdersInAccumulator(); 
        
        //Get names of orders from Excel 
        var listOfSecurities  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "listOfSecuritiesOptiReports", language+client);//"RADAR ACQUISITIONS CORP|PEPSICO INC|AAT CPG G/R S23/FR/N";//"RADAR ACQUISITIONS CORP|PEPSICO INC|AAT R/G GIC S23/LL/N"
        var arrayOfSecurities = listOfSecurities.split("|");
        
             
        for (i=0; i<3; i++){
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            Log.Message("Dans le module Comptes, sélectionner un compte CAD (ex : 800279-RE)");
            Search_Account(account);  
            Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
             
            Log.Message("Cliquer sur créer un ordre d`Achat");
            Get_Toolbar_BtnCreateABuyOrder().Click();
            if(i<2){
              Get_WinFinancialInstrumentSelector_RdoStocks().Click();
            }else{
               Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click(); //creation of mutual Funds 
            }            
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            if(i>1){ // creation of mutual Funds 
               Log.Message("Creation of mutual Funds");
               Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
               Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
               Get_WinMutualFundsOrderDetail_CmbQuantityType().Click();
               Get_WinMutualFundsOrderDetail_TxtQuantity().Keys(quantity2470);  
               Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(arrayOfSecurities[i]);
               Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
               
               SetAutoTimeOut();
               if(Get_SubMenus().Exists)  
                 Aliases.CroesusApp.subMenus.Find("Value",arrayOfSecurities[i],10).DblClick();               
               RestoreAutoTimeOut();
               
               Get_WinOrderDetail_BtnSave().Click();
            }else{
              Log.Message("Creation of stoks");
              CreateEditStocksOrder("", quantity2470, arrayOfSecurities[i]);
            };
            
            //********** Step 2: Sélectionner les trois ordres de l'accumulateur et cliquer sur verifier puis soumettre les 3 ordres
            Log.message("Sélectionner les trois ordres de l'accumulateur et cliquer sur verifier puis soumettre les 3 ordres"); 
            Get_OrderAccumulatorGrid().RecordListControl.Find("Value",arrayOfSecurities[i],10).Click();
            Get_OrderAccumulator_BtnVerify().Click();
            if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
            Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
            Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
            Get_WinAccumulator_BtnSubmit().Click();
            
            Log.Message("Validation :Les 3 ordres s'affichent dans la grille ordres avec le statut : approbation"); 
            if(ValidateCreationOfOrderInOrderGrid(arrayOfSecurities[i],statusPendingApproval)){
              Log.Message("The order " + arrayOfSecurities[i]+ "was submitted");
            }else{
              Log.Error("The order " + arrayOfSecurities[i]+ "was not submitted");
              return;
            };
        }
        
                                             
        // ********************************************************Étape 3*******************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 2: Validation du rapport taux de change");
        //********** Step 3: Sélectionner les 3 ordres et générer le rapport taux de change
        
        Log.Message("sélectionner l`ordre crée dand step 1 dans le Blotter"); //Choisir les order créés aujourd’hui          
        for (i=0; i<3; i++){          
          Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).Click(-1, -1, skCtrl); ;
        };
       
        Log.Message("Cliquer sur le menu Rapports puis Rapport de taux de change");//Générer le rapport       
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_ExchangeRateReport().Click();  
        
        Log.Message(" ***************** Validation du fichier Excel*****************");
        //Validation:un rapport vide est généré
        Log.Message("Validation:un rapport vide est généré.Valider qu'À part les entetes, le rapport généré ne contient  aucun ordre.");
        var RowCount=ExcelRowCount(FolderPath);               
        if (RowCount == 1)
           Log.Checkpoint("Le fichier contient une seule ligne");        
        else 
           Log.Error("Le fichier ne contient pas une seule ligne");
        Log.Message(" *****************Fin de validation du fichier Excel************"); 
       
        // ********************************************************Étape 4*******************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4:Validation du rapport  fidessa");
        /********** Step 4: 1- Sélectionner les ordres crées et générer le rapport fidessa
          -Un fichier excel est généré contenant deux lignes dont la colonne instrument contient :PEP ET RAC
          -valider que les deux ordres ont le statut ouvert*/
          
        //Générer le rapport   
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_FidessaOrderReport().Click();
        
        Log.Message("Vérifier le changement du statut de deux ordres PEP et RAC"); 
        for (i=0; i<3; i++){
          if(i<2){ 
            Log.Message("The oder is:" + arrayOfSecurities[i]); 
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).DataContext.DataItem, "Status", cmpEqual,statusOpen);
          } else{
            Log.Message("The oder is:" + arrayOfSecurities[i]); 
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).DataContext.DataItem, "Status", cmpEqual,statusPendingApproval);
          };
        };
        
        Log.Message(" ***************** Validation du fichier Excel*****************");
        Log.Message("Valider que dans le fichier Excel il y a 3 lignes.");        
        var folderPath=SubFoldersFinder(sTempFolder+"\CroesusTemp\\Executions\\")
//        var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d")
        var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d%H%M")          //Modifié par A.A
        var RowCount=ExcelRowCount(folderPath,fileNameContains);             
        if(RowCount==3) //Valider que dans le fichier Excel il y a 3 lignes
         Log.Checkpoint("Le fichier contient 3 lignes. Les entêtes et 1 titres");      
        else
         Log.Error("Le fichier ne contient pas 3 lignes.Les entêtes et 1 titres");
         
        Log.Message("Valider que les symbols PEP et RAC sont dans le fichier Excel")          
        checkFidessaStep4(quantity2470,arrayOfSecuritiesPEPRAC,folderPath,fileNameContains);        
        Log.Message(" *****************Fin de validation du fichier Excel************");
        
         //********************************************************Étape 5*******************************************
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5:validation du rapport des ordres fond d'invest ");
        //********** Step 5: Sélectionner les 3 ordres ( 2 ouverts et en approbation ) et générer le rapport : rapports des ordres fond d'invest
        
        Log.Message("Sélectionner les 3 ordres");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
        
        for (i=0; i<3; i++){          
            Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).Click(-1, -1, skCtrl);          
        };
        
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_MutualFundsOrderReport().Click(); 
        
        /*UN rapport excel est généré contenant une seule ligne dont la colonne Fund company égale AAT
        Validé que l'ordre a le statut Executé*/
        
        //Vérifier que le fichier Excel généré 
        var folderPath=SubFoldersFinder(sTempFolder+"\CroesusTemp\\Executions\\");
        var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d");           
        var RowCount=ExcelRowCount(folderPath,fileNameContains); 
        
        Log.Message(" ***************** Validation du fichier Excel*****************");        
        if(RowCount==2) //Valider que dans le fichier Excel il y a 2 lignes
         Log.Checkpoint("Le fichier contient 2 lignes. Les entêtes et 1 titre");        
        else
         Log.Error("Le fichier ne contient pas 2 lignes.Les entêtes et 1 titre");
        
        Log.Message("Valider que le symbol AAP dans le fichier Excel")  
        checkReportStep5(folderPath);
        Log.Message(" *****************Fin de validation du fichier Excel************");
                        
        Log.Message("Valider le changement du statut");
        for(i=0; i<3; i++){
          if(i<2)
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).DataContext.DataItem, "Status", cmpEqual,statusOpen);
          else
           aqObject.CheckProperty(Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).DataContext.DataItem, "Status", cmpEqual,statusExecuted);            
        };
          
                       
        // ********************************************************Étape 6*******************************************
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6:Générer le rapport --> rapports des fonds d'invest la 2em fois.");
        //********** Step 6: Sélectionner l'ordre dont le statut exécuté de l'étape 4 et générer le rapport : rapports des fonds d'invest
        
        Log.Message("Sélectionner l'ordre dont le statut exécuté de l'étape 4: L'ordre :AAT");
        Get_OrderGrid().Find("Value",arrayOfSecurities[2],10).Click();
              
         //Vérifier que le fichier Excel généré 
        var folderPath=SubFoldersFinder(sTempFolder+"\CroesusTemp\\Executions\\");
        var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d");
        
        
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_MutualFundsOrderReport().Click();
        /*Un message s'affiche : Les ordres exécutes sélectionnes seront générés. Cliquer OK*/
        Get_DlgConfirmation_BtnOk().Click();
        
        Log.Message(" ***************** Validation du fichier Excel*****************");
        Log.Message("Valider que le meme rapport (step5) s'affiche");            
        var RowCount=ExcelRowCount(folderPath,fileNameContains);         
        if(RowCount==2) //Valider que dans le fichier Excel il y a 2 lignes
         Log.Checkpoint("Le fichier contient 2 lignes. Les entêtes et 1 titre");        
        else
         Log.Error("Le fichier ne contient pas 2 lignes.Les entêtes et 1 titre");
         
        Log.Message("Valider que le symbol AAP dans le fichier Excel")       
        checkReportStep5(folderPath);
        Log.Message(" *****************Fin de validation du fichier Excel************");
        
        Log.Message("Valider le changement du statut");
        for(i=0; i<3; i++){
          if(i<2)
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).DataContext.DataItem, "Status", cmpEqual,statusOpen);
          else
           aqObject.CheckProperty(Get_OrderGrid().Find("Value",arrayOfSecurities[i],10).DataContext.DataItem, "Status", cmpEqual,statusExecuted);            
        };
        
        
         // ********************************************************Étape 7*******************************************
         Log.PopLogFolder();
         logEtape7 = Log.AppendFolder("Étape 7:Couverture de Jira: ORC-1940 ");
        /********** Step 7: Sélectionner l'ordre qui contient L,instrument PEP et puis cliquer sur Exécutions...
        Ajouter(quantité 100, prix=65, Bourse = CF) puis OK
        Origine du taux = Taux négocié
        Taux de change = 1,02598 puis OK
        Statut passe a exécuté partiellement*/
        
        Log.Message("Sélectionner l'ordre qui contient L,instrument PEP et puis cliquer sur Exécutions..");
        Get_OrderGrid().Find("Value",arrayOfSecurities[1],10).Click();           
        Get_OrdersBar_BtnFills().Click(); 
        
        Log.Message("Ajouter :quantité 100, prix=65, Bourse = CF) puis OK.Origine du taux = Taux négocié. Taux de change = 1,02598  puis OK");
        Get_WinOrderFills_GrpFills_BtnAdd().Click();                 
        Get_WinAddOrderFill_TxtQuantity().set_Value(quantityFillOrder);
        Get_WinAddOrderFill_TxtClientPrice().Keys(price);
        Get_WinAddOrderFill_CmbMarket().set_Text(market);      
        Get_WinAddOrderFill_BtnOK().Click();            
        Get_WinOrderFills_GrpFills_CmbRateOriginForBond().Keys(rateOrigin);
        Get_WinOrderFills_GrpFills_TxtExchangeRateForBond().Keys(exchangeRate);        
        if(client!="RJ"){
          Get_WinOrderFills_GrpFills_LblInternalNumberForBond().Keys("qwerty");
        }
        Get_WinOrderFills_BtnSave().Click();
               
        Log.Message("Vérifier le changement du statut,il passe a exécuté partiellement"); 
        Get_OrderGrid().Find("Value",arrayOfSecurities[1],10).Click();
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",arrayOfSecurities[1],10).DataContext.DataItem, "Status", cmpEqual,statusPartialFill); 
                
        Log.Message("Cliquer sur le menu 'Rapports', puis 'Rapport de taux de change' --> Rapport généré.");       
        Get_OrderGrid().Find("Value",securityDescription,10).Click();
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_ExchangeRateReport().Click();  
        
        Log.Message(" ***************** Validation du fichier Excel*****************");
        Log.Message("Couverture de Jira: ORC-1940: Lorsqu’on génère le rapport des ordres de fonds d’investissement sur des ordres dont le statut est exécuté, le rapport est vide.");
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        var RowCount=ExcelRowCount(FolderPath,FileNameContains);
                
        if (RowCount == 2) //Valider que dans le fichier Excel il y a 2 lignes 
         Log.Checkpoint("Le fichier contient 2 lignes. Les entêtes et 1 titres");        
        else 
         Log.Error("Le fichier ne contient pas 2 lignes. Les entêtes et 1 titres");
        
        Log.Message("Valider que la colonne Taux de change contient 1,02598"); 
        checkReportStep7(FolderPath,FileNameContains,checkExchangeRate); 
        Log.Message(" *****************Fin de validation du fichier Excel************");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
      TerminateExcelProcess(); //fermer les fichiers excel
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
      Runner.Stop(true); 
    }
}




function checkFidessaStep4(quantity2470,arrayOfSecuritiesPEPRAC,folderPath,fileNameContains){
    var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(VarToStr(folderPath),fileNameContains), aqFile.faRead, aqFile.ctANSI);                         
    var countLineInMyFile=0; // les lignes dans le fichier // Reads text lines from the file and posts them to the test log 
    arrayItem=0;
    while(! myFile.IsEndOfFile()){            
        countLineInMyFile++;
        line = myFile.ReadLine();          
        var textArr = line.split("	"); // Split at each space character.
        Log.Message(line)  
        if(countLineInMyFile==2 || countLineInMyFile==3){ 
                
            var textArrUnquote4=aqString.Unquote(VarToString(textArr[4]));  
            var textArrUnquote5=aqString.Unquote(VarToString(textArr[5]));        
            if(aqObject.CompareProperty(VarToString(textArrUnquote4),cmpContains, quantity2470,true,lmError) && aqObject.CompareProperty(VarToString(textArrUnquote5),cmpContains, arrayOfSecuritiesPEPRAC[arrayItem],true,lmError)){
              Log.Checkpoint("Le titre" +arrayOfSecuritiesPEPRAC[arrayItem]+" est dans le fichier Excel");
              arrayItem++; 
            } 
            else{
              Log.Error("Le titre"+arrayOfSecuritiesPEPRAC[arrayItem]+" n'est pas dans le fichier Excel")
              arrayItem++; 
            };                
        };                 
    } ;        
    myFile.Close();// Closes the file 
}


function checkReportStep5(folderPath,fileNameContains){
    var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(VarToStr(folderPath),fileNameContains), aqFile.faRead, aqFile.ctANSI);                         
    var countLineInMyFile=0; // les lignes dans le fichier // Reads text lines from the file and posts them to the test log 
    while(! myFile.IsEndOfFile()){    
      countLineInMyFile++;
      line = myFile.ReadLine();          
      var textArr = line.split("	"); // Split at each space character.
      Log.Message(line)      
      if(countLineInMyFile==2){ 
          var textArrUnquote1=aqString.Unquote(VarToString(textArr[0]));         
          if(aqObject.CompareProperty(VarToString(textArrUnquote1),cmpContains, "AAT",true,lmError)){
            Log.Checkpoint("l'ordre est AAT dans le fichier Excel")
          } 
          else{
            Log.Error("l'ordre AAT n'est pas dans le fichier Excel")
          };           
      };
    };        
    myFile.Close();// Closes the file 
}


function checkReportStep7(FolderPath,FileNameContains,checkExchangeRate){
    var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);              
    var countLineInMyFile=0; // les lignes dans le fichier  // Reads text lines from the file and posts them to the test log 
    while (! myFile.IsEndOfFile()){    
      countLineInMyFile++;
      line = myFile.ReadLine();
      // Split at each space character.
      var textArr = line.split("	");       
      if (countLineInMyFile == 2){//vérification des entètes
          var textArrUnquote4=aqString.Unquote(VarToString(textArr[4]));
          var textArrUnquote9=aqString.Unquote(VarToString(textArr[9]));
          Log.Message("CROES-8572")
          aqObject.CompareProperty(VarToString(checkExchangeRate),cmpEqual, textArrUnquote4,true,lmError);
          aqObject.CompareProperty(VarToString(checkExchangeRate),cmpEqual, textArrUnquote9,true,lmError);
      }
    }  
    // Closes the file
    myFile.Close();  
}


function ExcelRowCount(FolderPath,FileNameContains){
    
    TerminateExcelProcess(); //fermer les fichiers Excel           
    Log.Message(FolderPath);//Validation du fichier Excel 
    Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));                
    var app, rowNum;
    app = Sys.OleObject("Excel.Application");
    app.Workbooks.Open(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
    var rowNum = app.ActiveSheet.UsedRange.Rows.Count;
    app.Quit();
    return rowNum;
}

function SubFoldersFinder(sPath)//sPath-Specifies the path to the desired folder
{ 
  var FolInfo = aqFileSystem.GetFolderInfo(sPath);// Obtains information about the folder  
  var colSubFolders = FolInfo.SubFolders;// Obtains the collection of subfolders
  var subFolders=new Array();

  // Checks whether the collection is empty
  if (colSubFolders != null){      
      Log.AppendFolder("The " + sPath + " folder contains the following subfolders:");// Posts the names of the folder's subfolders to the test log
      while (colSubFolders.HasNext()){          
          var FolItem = colSubFolders.Next();// Obtains the current subfolder          
          Log.Message(FolItem.Name);// Posts the subfolder's name to the test log
          subFolders.push(FolItem.Path)
      }
        Log.PopLogFolder();
      
  }else
    Log.Message("The specified folder does not contain any subfolders.");   
  return subFolders
}
 

function ValidateCreationOfOrderInOrderGrid(security,statusPendingApproval){
  var orderExist = false; 
  if(Get_OrderGrid().Find("Value",security,10).Exists){
     aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "Status", cmpEqual,statusPendingApproval);
     orderExist = true;                    
  }
  else{
    Log.Error("L’ordre n’a pas été créé");
  };
  return orderExist;
}

