//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints



/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6613
    Analyste d'assurance qualité : Xian Wei (analyste d'automatisation)
    Analyste d'automatisation : Philippe Maurice
*/

function CROES_6613_Module_Trans_Partial_Assignement()
{
    try {
        
        /*Variables*/
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR1901", "CR1901_Account", language+client);
        var symbol = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR1901", "CR1901_Symbol", language+client);
        
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6613", "Lien du cas de test sur Testlink");
        Log.Link("https://jira.croesus.com/browse/TCVE-55", "Lien du cas de test sur JIRA");
        
        
        //Activer la pref et redémarrer les services
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_OPTION_ALWAYS_TRF_COST", "YES", vServerTransactions);
        RestartServices(vServerTransactions);
        
        
        //Rouler la requête SQL
        var SQLQuery = "";
        SQLQuery = "UPDATE b_trans set unassigned_qty = 2, gainloss='Y' WHERE no_compte = '300001-NA' AND security = 440704708 AND tr_type = 2"; 
        Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
        Log.Message("La commande SQL pour créer un cas d'assignation partielle a été exécutée.", SQLQuery);
           
       
        //Login
        Login(vServerTransactions, userName, psw, language);
                  
        
        //Aller dans compte
        Get_ModulesBar_BtnAccounts().Click();
    
        //Sélectionner le compte et le mailler vers portefeuille
        SearchAccount(account);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",VarToString(account),10), Get_ModulesBar_BtnPortfolio());
        
        
        //Cliquer sur le bouton TOUS
        Get_PortfolioBar_BtnAll().Click();
        
        //Rechercher le titre avec le symbole SAP.DC
        SearchAccountBySymbolInPortfolioGrid(symbol);
            
         
        //Mailler la position SAP.DC vers le module transaction
        Drag(Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(symbol),10), Get_ModulesBar_BtnTransactions());
        

        //Sélectionner le bonne transaction (Type vente) pour continuer le test 
        Get_Transactions_ListView().Find("Text", ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR1901", "CR1901_Type", language+client), 10).Click();
        
        
        //S'assurer que l'image apparaisse dans la grille de transactions et valider le message ToolTip en passant la souris au-dessus
        Sys.HighlightObject(Get_Transactions_ListView_PartialAssignation_Image());
        aqObject.CheckProperty(Get_Transactions_ListView_PartialAssignation_Image(), "ToolTip", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR1901", "CR1901_MessageToolTip", language+client));
          
        
        //Aller dans info transaction et aller dans onglet "gains / pertes"
        Get_TransactionsBar_BtnInfo().Click();
        Get_WinTransactionsInfo_TabGainsLosses().Click();
        
        
        //---Validations----//
        //Case à cocher "calculé" est cochée
        Sys.HighlightObject(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_ChkCalculated());
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_ChkCalculated(), "IsChecked", cmpEqual, true);
                    
        //"Quantité non assignée" = 2
        Sys.HighlightObject(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnassignedQty());
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnassignedQty(), "Value", cmpEqual, 2);
  
                
        
        //Fermer la fenêtre Info Transactions
        Get_WinTransactionsInfo_BtnOK().Click();
        

        //Fermer Croesus
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup) - Remettre la transaction à sa valeur originale
        var SQLQueryCleanUp = "update b_trans set unassigned_qty = null, gainloss='N' where no_compte = '300001-NA' and security = 440704708 and tr_type = 2"
        Execute_SQLQuery(SQLQueryCleanUp, vServerReportsCR1485);
        Log.Message("La commande SQL pour le cleanup a été exécutée", SQLQueryCleanUp);
        
        
        //Remettre la pref à la valeur initiale et redémarrer les services
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_OPTION_ALWAYS_TRF_COST", "NO", vServerTransactions);
        RestartServices(vServerTransactions);       
    }
}
