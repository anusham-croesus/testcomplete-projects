//USEUNIT CR1485_Common_functions



/**  
    Configuration du CR2008 pour le rapport 150 suivant : CR1485_150_Rel_2005_NumVis
    Ref : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\150. Feuillets d'impôt attendus (comptes non enregistrés)\1. Relations
*/
function CR1485_PreparationBD_Relationships_Models()
{
    try {
        Log.Message("CR1485_PreparationBD_Relationships()");
        
        Login(vServerReportsCR1485, userNameReportsCR1485, pswReportsCR1485, language);
        
        //Créer les relations
        CR1485_CreateRelationships();
        
        //Ajouter l'objectif de placement pour certaines relations (pour les rapports 5, 44, 49 et 61)
        CR1485_AddInvestmentObjectiveToRelationships();
        
        //Créer les modèles
        CR1485_CreateModels();
       
        //Fermer Croesus
        CloseCroesus();

    }
    catch(exception_CR1485_PreparationBD_Relationships_Models){
        Log.Error("Exception in CR1485_PreparationBD_Relationships_Models(): " + exception_CR1485_PreparationBD_Relationships_Models.message, VarToStr(exception_CR1485_PreparationBD_Relationships_Models.stack));
        exception_CR1485_PreparationBD_Relationships_Models = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function CR1485_CreateRelationships()
{
        var Excel = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("excel", 10000);
        Excel.DisplayAlerts = false;
    
        //Créer les relations utilisées pour les rapports
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Relations").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var relationshipName = VarToStr(Excel.Cells.Item(i, 1));
            var IACode = VarToStr(Excel.Cells.Item(i, 3));
            var currency = VarToStr(Excel.Cells.Item(i, 4));
            var relationshipLanguage = (language == "french")? VarToStr(Excel.Cells.Item(i, 5)): VarToStr(Excel.Cells.Item(i, 6));
            var isBillable = (client != "CIBC" && client != "VMBL"&& client != "VMD" && client != "TD")? (aqString.ToUpper(VarToStr(Excel.Cells.Item(i, 7))) == "VRAI" || aqString.ToUpper(VarToStr(Excel.Cells.Item(i, 7))) == "TRUE"): null;
            
            var clientNumber = VarToStr(Excel.Cells.Item(i, 2));
            
            //Release client and its accounts from any model
            var SQLQuery = "update B_COMPTE set LOCK_ID = null\r\n";
            SQLQuery += "delete from B_MODEL_ASSIGNED_ACCOUNT where ACCOUNT_ID in (select ACCOUNT_ID from B_COMPTE where NO_CLIENT = '" + clientNumber + "')\r\n";
            SQLQuery += "delete from B_MODEL_ASSIGNED_CLIENT where CLIENT_ID in (select CLIENT_ID from B_COMPTE where NO_CLIENT = '" + clientNumber + "')\r\n";
            Log.Message(SQLQuery, SQLQuery);
            Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
            
            CreateRelationship(relationshipName, IACode, currency, relationshipLanguage, isBillable);
            JoinClientToRelationship(clientNumber, relationshipName);
        }
    
        //Ajouter adresse aux relations utilisées pour les rapports
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_AdressesRelations").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var relationshipName = VarToStr(Excel.Cells.Item(i, 1));
            var street1 = VarToStr(Excel.Cells.Item(i, 2));
            var street2 = VarToStr(Excel.Cells.Item(i, 3));
            var street3 = VarToStr(Excel.Cells.Item(i, 4));
            var cityProv = VarToStr(Excel.Cells.Item(i, 5));
            var postalCode = VarToStr(Excel.Cells.Item(i, 6));
            var country = VarToStr(Excel.Cells.Item(i, 7));
        
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
            SearchRelationshipByName(relationshipName);
            Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
            
            Get_RelationshipsBar_BtnInfo().Click();
            Get_WinDetailedInfo_TabAddresses().Click();
            Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 60000);
            
            DeleteAllRelationshipAddresses();
            
            Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
            
            Get_WinCRUAddress_CmbType().set_IsDropDownOpen(true);
            Get_WinCRUAddress_CmbType_ItemOffice().Click();
            Get_WinCRUAddress_TxtStreet1().set_Text(street1);
            Get_WinCRUAddress_TxtStreet2().set_Text(street2);
            Get_WinCRUAddress_TxtStreet3().set_Text(street3);
            Get_WinCRUAddress_TxtCityProv().set_Text(cityProv);
            Get_WinCRUAddress_TxtPostalCode().set_Text(postalCode);
            Get_WinCRUAddress_TxtCountry().set_Text(country);
        
            Get_WinCRUAddress_BtnOK().Click();
            Get_WinDetailedInfo_BtnOK().Click();
        }
        
        Excel.Quit();
        TerminateExcelProcess();
}


//Ajouter l'objectif de placement pour certaines relations (pour les rapports 5, 44, 49 et 61)
function CR1485_AddInvestmentObjectiveToRelationships()
{
    //Récupérer du fichier Excel le nombre de relations concernées
    var Excel = Sys.OleObject("Excel.Application");
    Sys.WaitProcess("excel", 10000);
    Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_InvObj_rel").Activate();
    var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    Excel.Quit();
    TerminateExcelProcess();
    
    var NbOfRelationships = Math.round((RowCount - 1)/4);
    Log.Message("Nombre de relations pour l'ajout d'objectif de placement : " + NbOfRelationships);
    
    //Ajouter les objectifs de placement renseignés dans le fichier Excel
    for (var i = 0; i < NbOfRelationships; i++){
        var offset = 3 + (4*i);
        var relationshipName = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_rel", offset + 1, language);
        var investmentObjective = GetData(filePath_ReportsCR1485, "PreparationBD_InvObj_rel", offset + 2, language);
        
        Log.Message("Add '" + investmentObjective + "' investment objective to relationship '" + relationshipName + "'");
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
        
        Get_RelationshipsBar_BtnInfo().Click();
        Delay(1000);
        Get_WinDetailedInfo_TabProductsAndServices().Click();
        Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
        
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
        
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_BtnInvestmentObjectiveForRelationship().Click();
        
        if (investmentObjective == "De base - Global - Croissance" || investmentObjective == "Basic - Global - Growth")
            Get_LstInvestmentObjectivesForRelationship_ItemBasic_Growth().set_IsActive(true);
        else
            Log.Error("'" + investmentObjective + "' investment objective not covered !");
        

        Get_WinDetailedInfo_BtnOK().Click();
    } 
}


function CR1485_CreateModels()
{
        var Excel = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("excel", 10000);
        
        //Créer les modèles utilisés pour les rapports
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_Models").Activate();
        var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
    
        for (var i = 2; i <= RowCount; i++){
            var modelName = VarToStr(Excel.Cells.Item(i, 1));
            var modelType = "";
            var IACode = VarToStr(Excel.Cells.Item(i, 2));
            var currencyValue = VarToStr(Excel.Cells.Item(i, 3));
            var relationshipName = VarToStr(Excel.Cells.Item(i, 4));
        
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 100000);
        
            Create_Model(modelName, modelType, IACode, currencyValue);
            AssignRelationshipToModelByName(relationshipName, modelName);
        }
    
        Excel.Quit();
        TerminateExcelProcess();
}
