//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Module               :  Orders
    Jira                 :  TCVE-3162
    Description          :  Automatisation du jira ORC-1139
    Auteur               :  A.A
    Version de scriptage :	90-21-2020-11-15  
*/

function GDO_TCVE_3162_ORC_1152_SendBackExpiredCanceledOrRejectedOrder()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-3162","Lien de la story dans Jira");
           //Lien du cas de test dans jira
           Log.Link("https://jira.croesus.com/browse/ORC-1152","Lien du cas de test dans Jira");
    
    
           //Declaration des Variables
           var userNameUNI00  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
           var passwordUNI00  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");

           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                      
           var userNameDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
           var passwordDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
           
           var userNameFERMIE = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FERMIE", "username");
           var passwordFERMIE = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FERMIE", "psw");
           
           var account800300NA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_account800300NA", language+client);
           var account800066GT = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_account800066GT", language+client);
           
           var symbolNA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_symbolNA", language+client);
           var symbolNAL       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_symbolNAL", language+client);
           var buyOrder        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_buyOrder", language+client);
           var quantityNA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_quantityNA", language+client);
           var quantityNAL     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_quantityNAL", language+client);
           
           var operatorEqual   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_operatorEqual", language+client);
           var fieldStatus     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_fieldStatus", language+client);
           
           var listOfStatus   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE_3162_listOfStatus", language+client);

            var ArrayOfValues = listOfStatus.split("|"); //["Expiré", "Annulé", "Rejeté", "En approbation", "Ouvert"]
            var ArrayOfFilterNames = ["ExpiredOrders", "CanceledOrders", "RejectedOrders", "AprovalOrders", "OpenOrders"];
            var waitTime = 25000;

//Étape 1 et 2
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape1: Se connecter avec un SysAdmin UNI00, valider que le btn 'Renvoyer' est activé");
            //Se connecter à croesus avec UNI00
            Login(vServerOrders, userNameUNI00, passwordUNI00, language);
           
            Log.Message("Clic sur le module ordres")
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, waitTime);
            //ReduceColumnsHeadersWidthToMaxValue(); //Christophe : Stabilisation
            
            for (i=0; i<5; i++){
                Create_RapideFilter(ArrayOfFilterNames[i], fieldStatus, operatorEqual, ArrayOfValues[i]);
                if(i<3){
                    //Valider que le boutton 'renvoyer' est actif
                    Get_OrderGrid().FindChild("Value", ArrayOfValues[i], 10).Click();
                    aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, true);
                }
            }
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Vider l'accumulateur
            Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
            if(Get_OrderAccumulator_BtnDelete().Enabled){
                Get_OrderAccumulator_BtnDelete().Click();
                Get_DlgConfirmation_BtnDelete().Click();
            }
            //Fermer Croesus
            Close_Croesus_MenuBar();
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
            
//----------------------------------------------------------------CONNEXION AVEC KEYNEJ----------------------------------------------------
//Étape 3 et 4            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 3: Se connecter avec un FirmAdmin KEYNEJ, valider que le btn 'Renvoyer' est activé");
            //Se connecter à croesus avec KEYNEJ
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, waitTime);
            
            //Selectionner les comptes 800300-NA et 800066-GT
            SelectAccounts([account800300NA, account800066GT]);
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Créer un ordre NA");
            //Créer un ordre d'achat pour NA
            CreateOrder(buyOrder, quantityNA, symbolNA);
        
            //Envoyer l'ordre d'achat de NA vers le blotter
            SendOrderToBlotter(symbolNA);
               
            //Appliquer le filtre état = en approbation
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[3]);
            
            //Rejeter l'ordre d'achat de NA
            Get_OrderGrid().RecordListControl.FindChild("Text",symbolNA,10).Click();    
            Get_OrdersBar_BtnView().Click();
            Get_WinOrderDetail_BtnReject().Click();
            
            Get_DlgConfirmation_TxtReason().keys("ORC_1139")
            Get_DlgConfirmation_BtnYes().Click();
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Créer un ordre NAL");
             //Créer un ordre d'achat pour NAL
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, waitTime);
            CreateOrder(buyOrder, quantityNAL, symbolNAL); 
            
            //Envoyer l'ordre d'achat de NAL vers le blotter
            SendOrderToBlotter(symbolNAL); 
            ReduceColumnsHeadersWidthToMaxValue(); //Christophe : Stabilisation
          
            //Appliquer le filtre état = en approbation
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[3]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
            
            //Approuver l'ordre d'achat de NAL
            Get_OrderGrid().RecordListControl.FindChild("Text", symbolNAL, 10).Click();    
            Get_OrdersBar_BtnView().Click();
            Get_WinOrderDetail_BtnApprove().Click();
     
            //Appliquer le filtre état = Ouvert
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[4]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
            
            Get_OrderGrid().RecordListControl.FindChild("Text",symbolNAL,10).Click();
            Get_OrdersBar_BtnCXL().Click();
            Get_DlgConfirmation_BtnYes().Click();

            //Appliquer le filtre état = Expiré
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[0]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
            Get_OrderGrid().FindChild("Value", ArrayOfValues[0], 10).Click();
            //Valider que le boutton 'renvoyer' est actif
            aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, true);
                        
            //Fermer Croesus
            Close_Croesus_MenuBar();
            if(Get_DlgConfirmation().Exists){
                Get_DlgConfirmation_BtnYes().Click();
            }
                
//-------------------------------------------------------------CONNEXION AVEC DARWIC----------------------------------------------------                
//Étape 5
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 5: Se connecter avec un Rep DARWIC, valider que le btn 'Renoyer' n'est pas activé");
            //Se connecter à croesus avec DARWIC
            Login(vServerOrders, userNameDARWIC, passwordDARWIC, language);
           
            Log.Message("Clic sur le module ordres")
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, waitTime);
            ReduceColumnsHeadersWidthToMaxValue(); //Christophe : Stabilisation
                        
            //Appliquer le filtre état = Annulé
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[1]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
            Get_OrderGrid().FindChild("Value", symbolNAL, 10).Click();
            
            //Valider que le boutton 'renvoyer' est désactivé
            aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, false);
            
            //Appliquer le filtre état = Rejeté
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[2]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
            Get_OrderGrid().FindChild("Value", symbolNA, 10).Click();
            
            //Valider que le boutton 'renvoyer' est désactivé
            aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, false);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Fermer Croesus
            Close_Croesus_MenuBar();
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
           
//-------------------------------------------------------------CONNEXION AVEC FERMIE----------------------------------------------------*/                
//Étape 6
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 6: Se connecter avec un Rep FERMIE, valider que le btn 'Renoyer' n'est pas activé");
            
            //donner a l'utilisateur l'accés au code de CP AC42, AC43,AC44 par requête SQL
            var InsertString1 = "insert into B_USEREP (User_Num, REP_ID, Is_Main) values (126,38,'Y')"
            var InsertString2 = "insert into B_USEREP (User_Num, REP_ID, Is_Main) values (126,39,'Y')"
            var InsertString3 = "insert into B_USEREP (User_Num, REP_ID, Is_Main) values (126,40,'Y')" 
            var InsertString4 = "insert into B_USEREP (User_Num, REP_ID, Is_Main) values (126,13,'Y')"
            var InsertString5 = "insert into B_USEREP (User_Num, REP_ID, Is_Main) values (126,14,'Y')"
            var InsertString6 = "insert into B_USEREP (User_Num, REP_ID, Is_Main) values (126,15,'Y')" 
            
            var attr = Log.CreateNewAttributes();
            attr.Bold = true;
 
            Log.Message("Si les 2 premieres requetes générent l'erreur: 'Attempt to insert duplicate key row in object B_USEREP' Ignorez l'erreur A.A (d'après Karima)", "", pmNormal, attr);  
//            try{        
//              Execute_SQLQuery(InsertString1, vServerOrders);
//            }
//            catch(e) {       
//              Log.Error("Exception: " + e.message, VarToStr(e.stack));       
//            }
//            finally {}
//            
//            try{        
//              Execute_SQLQuery(InsertString2, vServerOrders);
//            }
//            catch(e) {       
//              Log.Error("Exception: " + e.message, VarToStr(e.stack));       
//            }
//            finally {}

            Execute_SQLQuery(InsertString3, vServerOrders); 
            Execute_SQLQuery(InsertString4, vServerOrders); 
            Execute_SQLQuery(InsertString5, vServerOrders); 
            Execute_SQLQuery(InsertString6, vServerOrders); 
            RestartServices(vServerOrders);  
            
            //Se connecter à croesus avec FERMIE
            Login(vServerOrders, userNameFERMIE, passwordFERMIE, language);
           
            Log.Message("Clic sur le module ordres")
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, waitTime);
            ReduceColumnsHeadersWidthToMaxValue(); //Christophe : Stabilisation           
            
            //Appliquer le filtre état = Expiré
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[0]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
//            Get_OrderGrid().FindChild("Value", symbolNAL, 10).Click();
            
            //Valider que le boutton 'renvoyer' est activé
            aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, true);
            
            //Appliquer le filtre état = Annulé
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[1]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
            Get_OrderGrid().FindChild("Value", symbolNAL, 10).Click();
            
            //Valider que le boutton 'renvoyer' est activé
            aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, true);
            
            //Appliquer le filtre état = Rejeté
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_SubMenus().WPFObject("ContextMenu", "", 1).ClickItem(ArrayOfFilterNames[2]);
            WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
            Get_OrderGrid().FindChild("Value", symbolNA, 10).Click();
            
            //Valider que le boutton 'renvoyer' est activé
            aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, true);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Fermer Croesus
            Close_Croesus_MenuBar();
            
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape7: Se connecter avec un SysAdmin UNI00,pour Supprimer les filtres ");
            //Se connecter à croesus avec UNI00
            Login(vServerOrders, userNameUNI00, passwordUNI00, language);
           
            Log.Message("Clic sur le module ordres")
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, waitTime);
/*  */          
            //Supprimer les filtres
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
            for (i=0; i<5; i++){
                Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Click();
                if(Get_DlgConfirmation().Exists)
                    Get_DlgConfirmation_BtnYes().Click();
           } 
           Get_WinQuickFiltersManager_BtnClose().Click();
            //Fermer Croesus
            Close_Croesus_MenuBar();
          }         
    catch(e) {       
        Log.Error("Exception: " + e.message, VarToStr(e.stack));       
    }
    
    finally {
        //Fermer le processus Croesus
        Terminate_CroesusProcess();        
    }
}

        
function SendOrderToBlotter(symbol){

        //Passer les ordres dans le blotter
        Log.Message("Passer l'ordre dans le blotter de symbol: " + symbol);
        Get_OrderAccumulatorGrid().Find("Value", symbol, 10).Click();
        Get_OrderAccumulator_BtnVerify().Click();
        Get_WinAccumulator().FindChild("Uid","IncludedKey",10).set_IsSelected(true);
        Get_WinAccumulator().FindChild("Uid","IncludedKey",10).Click();
        Get_WinAccumulator_BtnSubmit().Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "BatchOrderVerificationWindow_342c");
}

function CreateOrder(orderType, quantity, symbol){  
    
        Log.Message("Créer un ordre d'achat avec symbol= " + symbol +" et quantité= "+ quantity);
        var unitPerAccount = "Unités par compte"
        Get_Toolbar_BtnSwitchBlock().Click();
        WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
           
        Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(orderType);
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10)      
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
           
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
        Get_SubMenus().Find("WPFControlText", unitPerAccount, 10).Click();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(symbol + "[Tab]");
        //           Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        if(Get_SubMenus().Exists)
            Get_SubMenus().Find("WPFControlText",symbol,10).DblClick();
        Get_WinSwitchSource_btnOK().Click();
           
        Get_WinSwitchBlock_BtnPreview().Click();        
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,30000);
        Get_WinSwitchBlock_BtnGenerate().Click(); 
        if (Get_WinSwitchBlock().Exists)
          Get_WinSwitchBlock_BtnGenerate().Click();      
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");      
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd"); 
}



function Create_RapideFilter(Compte, Champ, Operator, Value)
{
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
   
        //Creation filtre rapide
        Get_WinAddFilter_TxtName().Click();
        Get_WinAddFilter_TxtName().set_Text(Compte);
        
        if (Champ != undefined && Trim(VarToStr(Champ)) !== ""){
        Get_WinAddFilter_GrpCondition_CmbField().Click(); 
    
        if(Get_SubMenus().Exists){
           Get_SubMenus().Find("WPFControlText",Champ,10).Click();
        }
        else{
         Log.Message("The "+ Champ +" does not exist.");
        }
    
    
        if (Operator != undefined && Trim(VarToStr(Operator)) !== ""){
        Get_WinAddFilter_GrpCondition_CmbOperator().Click(); 
    
        if(Get_SubMenus().Exists){
           Get_SubMenus().Find("WPFControlText",Operator,10).Click();
        }
        else{
         Log.Message("The "+ Operator +" does not exist.");
        }}
    
    
        if (Value != undefined && Trim(VarToStr(Value)) !== "" && Champ != "Date de transaction" && Champ != "Transaction Date"){
        Get_WinAddFilter_GrpCondition_CmbValue().Click(); 
    
        if(Get_SubMenus().Exists){
           Get_SubMenus().Find("WPFControlText",Value,10).Click();
        }
        else{
         Log.Message("The "+ Value +" does not exist.");
        }}
        
        if (Value != undefined && Trim(VarToStr(Value)) !== "" && (Champ == "Date de transaction" || Champ == "Transaction Date")){
        Get_WinAddFilter_GrpCondition_DateValue().Click(); 
        Get_WinAddFilter_GrpCondition_DateValue().set_StringValue(Value);
        }
        }
        Get_WinAddFilter_BtnOK().Click();
              
}


/**
    Auteur : Christophe Paring
*/
function ReduceColumnsHeadersWidthToMaxValue(maxWidth)
{
    maxWidth = (maxWidth == undefined)? 60: maxWidth;
    
    maxLoops = 3;
    for (var k = 1; k <= maxLoops; k++){
        var allDisplayedHeaders = Get_OrderGrid().FindAllChildren(["ClrClassName", "WPFControlText", "VisibleOnScreen"], ["LabelPresenter", "*", true], 10).toArray();
    
        //Reorder objects from left most to right most
        var orderedDisplayedHeaders = [];
        while (orderedDisplayedHeaders.length < allDisplayedHeaders.length){
            var leftMostIndex = null;
            for (var j = 0; j < allDisplayedHeaders.length; j++){
                if (allDisplayedHeaders[j] !== null && (leftMostIndex === null || allDisplayedHeaders[j].ScreenLeft < allDisplayedHeaders[leftMostIndex].ScreenLeft))
                    leftMostIndex = j;
            }
            orderedDisplayedHeaders.push(allDisplayedHeaders[leftMostIndex]);
            allDisplayedHeaders[leftMostIndex] = null;
        }
    
        //Modify width if necessary
        var isHeaderWidthReduced = false;
        for (var i = 0; i < (orderedDisplayedHeaders.length-1); i++){
            if (Trim(orderedDisplayedHeaders[i].WPFControlText) != "" && orderedDisplayedHeaders[i].Width > maxWidth){
                var fromX = orderedDisplayedHeaders[i].ScreenLeft + orderedDisplayedHeaders[i].Width;
                var fromY = orderedDisplayedHeaders[i].ScreenTop + orderedDisplayedHeaders[i].Height/2 - 1;
                var toX = fromX - (orderedDisplayedHeaders[i].Width - maxWidth);
                var toY = fromY;
            
                LLPlayer.MouseDown(MK_LBUTTON, fromX, fromY, 200);
                LLPlayer.MouseMove(toX, toY, 500)
                LLPlayer.MouseUp(MK_LBUTTON, toX, toY, 300);
                isHeaderWidthReduced = true;
            }
        }
        
        if (isHeaderWidthReduced)
            Sys.Refresh();
        else
            break;
    }
}

