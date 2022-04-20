//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-432
    Description          :  GDO :Créer un ordre d'achat sur un fond mutuel pour valider la colonne Progression 
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.14-Lu-47 
    
*/

function GDO_TCVE432_Validate_Column_Progression() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-432");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var acc30005NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account30005NA", language+client);
            var quantity_TCVE432=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_TCVE432", language+client);
            var symFID081=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symFID081", language+client);
            var statusTCVE432=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
            var TypeColorToolTip=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2477", language+client);
            var quantityString_TCVE432=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityString_TCVE432", language+client); 
            var statusTCVE432_1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "status_TCVE432", language+client);
            var TypeColorToolTip_1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2483", language+client);
            var tooltipProgression=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "tooltipProgression", language+client);
                          
            //Se connecter à croesus
            Log.Message("Se connecter à croesus")
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            
            //Créer un ordre d'achat avec le bouton bleue et choisir Fonds d'investissement
            Log.Message("Créer un ordre d'achat avec le bouton bleue et choisir Fonds d'investissement")
            Get_Toolbar_BtnCreateABuyOrder().Click();
            Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
                       
            /*Compte= 300005-NA;Quantité = 1400;Symb.= FID081 Cliquer sur Vérifier Cliquer sur Soumettre*/
            //Creation d'ordre 
            Log.Message("Creation d'ordre:Compte= 300005-NA;Quantité = 1400;Symb.= FID081 Cliquer sur Vérifier Cliquer sur Soumettre");  
            Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(acc30005NA)              
            Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
            Get_WinMutualFundsOrderDetail_TxtQuantity().Keys(quantity_TCVE432);              
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symFID081);
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
            Log.Message("Vérifier");
            Get_WinOrderDetail_BtnVerify().Click();
            Log.Message("Soumettre");
            Get_WinOrderDetail_BtnVerify().Click();  
                                                    
            //L'ordre d'achat est créée dans le Botter et la colonne Progression est "0% exécuté"
            Log.Message("Valider que l'ordre d'achat est créée dans le Botter et la colonne Progression 0% exécuté ");
            var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
            SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "Status", cmpEqual,statusTCVE432);
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "OrderSymbol", cmpEqual,symFID081);  
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantityString_TCVE432);  
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip);       
        
            /*Dans la barre de menu cliquer sur RAPPORTS.Choisir  Rapport des ordres fonds d'invest.*/
            Log.Message("Dans la barre de menu cliquer sur RAPPORTS.Choisir  Rapport des ordres fonds d'invest");
            Get_OrderGrid().Find("Value",symFID081,10).Click();
            SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
            Get_MenuBar_Reports().Click();
            Get_MenuBar_Reports_MutualFundsOrderReport().Click();
                       
            /*L'ordre est exécutée et la colonne Progression est entièrement bleue.*/
            Log.Message("L'ordre est exécutée et la colonne Progression est entièrement bleue.");
            var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
            SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "Status", cmpEqual,statusTCVE432_1);
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "OrderSymbol", cmpEqual,symFID081);  
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantityString_TCVE432);  
                                
            /*Le libellé 100% exécutée s'affiche.*/
            Log.Message("Le libellé 100% exécutée s'affiche.");
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symFID081,10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip_1);  
                                   
            /*Tooltip:FR: Affiche la progression de l'ordre EN: Displays the progress of the order*/
            aqObject.CheckProperty(Get_OrderGrid_ChTypeColor(), "ToolTip", cmpEqual,tooltipProgression); 

            SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
            
            //fermer les fichiers excel
            while(Sys.waitProcess("EXCEL").Exists){
                Sys.Process("EXCEL").Terminate();
            }                                       
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));                              
      }
      finally {
            Terminate_CroesusProcess(); //Fermer Croesus
            Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)                 
        }
}



 /**
    Auteur : Christophe Paring
*/
function SetIsExpandedForAccumulatorAndLogExpanders(newStateAccumulatorExpander, newStateLogExpander)
{
    var executeSysRefresh = false;
    
    if (newStateAccumulatorExpander != undefined && newStateAccumulatorExpander != Get_OrderAccumulator().IsExpanded){
        Get_OrderAccumulator().set_IsExpanded(newStateAccumulatorExpander);
        executeSysRefresh = true;
    }
    
    if (newStateLogExpander != undefined && newStateLogExpander != Get_OrderLogExpander().IsExpanded){
        Get_OrderLogExpander().set_IsExpanded(newStateLogExpander);
        executeSysRefresh = true;
    }
    
    if (executeSysRefresh)
        Sys.Refresh();
}
