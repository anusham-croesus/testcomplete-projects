//USEUNIT Common_functions
//USEUNIT DBA

/**
    Description : Validate the client Portfolios, to exclude all clients that are part of a Client Relationship that’s managed at the Client Profile level in RQS Dashboard Generator.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6644
    
    Analyste d'assurance qualité : Carole T.
    Analyste d'automatisation : Amine A.
    Version de scriptage : ref90-12-Hf-46--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6644_Validate_RQS_DashboardGenerator()
{
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6644");
    
          try {
                var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
                var SSHUser   = "aminea";
                var SSHFolder = "CR1958.2.6644";
                
                var client800003    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_Client800003", language + client);
                var managementLevel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ManagementLevel", language + client);
                var link0002A       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_Link0002A", language + client);
                
                var actualLow       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ActualLow", language + client);
                var actualMedium    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ActualMedium", language + client);
                var actualHigh      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ActualHigh", language + client);
                var totalValue      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_TotalValue", language + client);
                
                var ValueLow       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ValueLow1", language + client);
                var ValueMedium    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ValueMedium1", language + client);
                var ValueHigh      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ValueHigh1", language + client);
                
                var ValueLow2      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ValueLow2", language + client);
                var ValueMedium2   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ValueMedium2", language + client);
                var ValueHigh2     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ValueHigh2", language + client);
                
                var nonResident    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_NonResident", language + client);
                var residency      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_Residency", language + client);

                var client800400   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_Client800400", language + client);
                var link80040      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_Link80040", language + client);
                var productType    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6644_ProductType", language + client);
                
                var cfLoaderPlugin_generateRQSPortfolio = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6667_cfLoaderPlugin_generateRQSPortfolio", language + client);
                
                var query1 = "select * from b_client join b_RQS_Client on b_RQS_Client.entity_ID=b_Client.client_ID where client_id = 210";                         
                
                //Valider que le résultat de la requête 1 est vide
                Log.Message("Executer la première requête");
                if (Execute_SQLQuery_IsRowEmpty(query1,vServerRQS))                
                    Log.Checkpoint("La requête 1 retourne un résultat vide"); 
                else
                    Log.Error("La requête 1 ne retourne pas un résultat vide"); 
                
                var query2 = "select NO_CLIENT, MANAGEMENT_LEVEL, NO_LINK, NO_LINKS,PRODUCT_TYPE, INV_RISK_LOW, INV_RISK_MEDIUM,INV_RISK_HIGH, ACTUAL_LOW, ACTUAL_MEDIUM, ACTUAL_HIGH, MARKET_VALUE, VALEUR_TOT from b_client join b_RQS_Client on b_RQS_Client.entity_ID=b_Client.client_ID where client_id = 5"    
                Log.Message("Executer la 2ème requête");
                if (Execute_SQLQuery_IsRowEmpty(query2,vServerRQS))                 
                    Log.Error("La requête 2 retourne un résultat vide ce qui n'est pas prévisible");
                else{
                    var arrayOfValue =  Execute_SQLQuery_GetRow(query2,vServerRQS);               
                
                    //Valider les résultats de la requête 2
                    CheckEquals(Trim(arrayOfValue[0]), client800003,   "The client number")
                    CheckEquals(Trim(arrayOfValue[1]), managementLevel,"The management level")
                    CheckEquals(Trim(arrayOfValue[2]), link0002A,     "The link number")
                    CheckEquals(Trim(arrayOfValue[8]), actualLow,      "The actual low")             
                    CheckEquals(Trim(arrayOfValue[9]), actualMedium,   "The actual medium")
                    CheckEquals(Trim(arrayOfValue[10]), actualHigh,    "The actual high")
                    CheckEquals(Trim(arrayOfValue[12]), totalValue,    "The total value")
                }
                //Se loguer avec KEYNEJ
                Log.Message("Login avec '" + userKEYNEJ + "'  Aller dans Client et Mailler '800003' vers Portefeuille");
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
                Get_MainWindow().Maximize();

                //go to Client module
                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
                //Mailler le client dans portefeuille
                Search_Client(client800003);          
                Get_RelationshipsClientsAccountsGrid().Find("Value",client800003,10).Click();
                Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",client800003,10),Get_ModulesBar_BtnPortfolio());
                Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
                Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ScrollViewer().Keys("[Right][Right][Right][Right]");
                
                //Validation des données affichées dans le graphe
                aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ChText(3), "WPFControlText", cmpEqual, ValueHigh);
                aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ChText(6), "WPFControlText", cmpEqual, ValueMedium);
                aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ChText(9), "WPFControlText", cmpEqual, ValueLow);
                
                //Aller au module Relations
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                
                SearchRelationshipByNo(link0002A);          
                Get_RelationshipsClientsAccountsGrid().Find("Value",link0002A,10).Click();
                
                //Cliquer sur le client 800003 puis sur l'onglet Profil
                Get_RelationshipsClientsAccountsPlugin_BottomGroupBox_Clients().WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", 1).FindChild("Value",client800003,10).Click();
                Get_ClientsDetails_TabProfile().Click();
                Get_ClientsDetails_TabProfile().WaitProperty("IsChecked", true, 3000);
                
                //Vérification des champs 'Non-resident Indicator' et 'Residency Location'  
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_BottomGroupBox_ClientSummary_KYC_ChText(2), "Text", cmpEqual, nonResident);
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_BottomGroupBox_ClientSummary_KYC_ChText(3), "Text", cmpEqual, residency);
                
                var query3 = "select NO_CLIENT, MANAGEMENT_LEVEL, NO_LINK, NO_LINKS,PRODUCT_TYPE, INV_RISK_LOW, INV_RISK_MEDIUM,INV_RISK_HIGH, ACTUAL_LOW, ACTUAL_MEDIUM, ACTUAL_HIGH, MARKET_VALUE, VALEUR_TOT from b_client join b_RQS_Client on b_RQS_Client.entity_ID=b_Client.client_ID where client_id = 8";
                Log.Message("Executer la 3ème requête");
                //Valider que le résultat de la requête 3 est vide
                if (Execute_SQLQuery_IsRowEmpty(query3,vServerRQS))                
                    Log.Checkpoint("La requête 3 retourne un résultat vide"); 
                else
                    Log.Error("La requête 3 ne retourne pas un résultat vide");
                
                Log.Message("Executer la 4ème requête");
                var query4 = "update b_config set NOTE = 'ICS' where cle = 'FD_COMPLIANCE_EXCLUDED_PRODUCT_TYPE' and FIRM_ID = 1"; 
                Execute_SQLQuery(query4,vServerRQS);
                
                //Executer la commande cfLoader:  cfLoader  -DashboardRegenerator "generateRQSPortfolio=CLIENT,LINK" -firm=FIRM_1
                Log.Message("Execution de la commande cfLoader");
                ExecuteSSHCommandCFLoader(SSHFolder, vServerRQS, cfLoaderPlugin_generateRQSPortfolio, SSHUser);
                
                //Terminate Croesus process
                Terminate_CroesusProcess();
                
                //Se loguer avec KEYNEJ
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
                Get_MainWindow().Maximize();
                
                Log.Message("Executer la 5ème requête");
                
                var query5 = "select NO_CLIENT, MANAGEMENT_LEVEL, NO_LINK, NO_LINKS,PRODUCT_TYPE, INV_RISK_LOW, INV_RISK_MEDIUM,INV_RISK_HIGH, ACTUAL_LOW, ACTUAL_MEDIUM, ACTUAL_HIGH, MARKET_VALUE, VALEUR_TOT from b_client join b_RQS_Client on b_RQS_Client.entity_ID=b_Client.client_ID where client_id = 210";
                if (Execute_SQLQuery_IsRowEmpty(query2,vServerRQS))                
                    Log.Error("La requête 5 retourne un résultat vide ce qui n'est pas prévisible");
                else{
                      var arrayOfValue =  Execute_SQLQuery_GetRow(query5,vServerRQS);               
                
                      //Valider les résultats de la requête 5
                      CheckEquals(Trim(arrayOfValue[0]), client800400,   "The client number")
                      CheckEquals(Trim(arrayOfValue[1]), managementLevel,"The management level")
                      CheckEquals(Trim(arrayOfValue[2]), link80040,      "The link number")
                      CheckEquals(Trim(arrayOfValue[4]), productType,    "The Product type")  
                }
                //Aller au module Relations
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                
                SearchRelationshipByNo(link80040);          
                Get_RelationshipsClientsAccountsGrid().Find("Value",link80040,10).Click();
                
                WaitObject(Get_RelationshipsClientsAccountsPlugin_BottomGroupBox_Clients(), "ClrClassName", "MainScrollViewer",30000 );
                
                //Mailler le client 800400 dans portefeuille
                var clientRelationship = Get_RelationshipsClientsAccountsPlugin_BottomGroupBox_Clients().WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", 1).FindChild("Value",client800400,10);
                clientRelationship.Click();
                Drag(clientRelationship,Get_ModulesBar_BtnPortfolio());
                Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
                Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ScrollViewer().Keys("[Right][Right][Right][Right]");
                                
                //Validation les données affichées dans le graphe
                aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ChText(3), "WPFControlText", cmpEqual, ValueHigh2);
                aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ChText(6), "WPFControlText", cmpEqual, ValueMedium2);
                aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ChText(9), "WPFControlText", cmpEqual, ValueLow2);
                
                //Remettre à jour la configuration
                Log.Message("Executer la 6ème requête");
                var query6 = "update b_config set NOTE = 'PP/AAA, ICS' where cle = 'FD_COMPLIANCE_EXCLUDED_PRODUCT_TYPE' and FIRM_ID = 1";         
                Execute_SQLQuery(query6,vServerRQS);
                
                //Executer la commande cfLoader:  cfLoader  -DashboardRegenerator "generateRQSPortfolio=CLIENT,LINK" -firm=FIRM_1
                Log.Message("Execution de la commande cfLoader");
                ExecuteSSHCommandCFLoader(SSHFolder, vServerRQS, cfLoaderPlugin_generateRQSPortfolio, SSHUser);              
                }
        catch(e){
                Log.Error("Exception : " + e.message, VarToStr(e.stack));}
        finally {
                //Terminate Croesus process
                Terminate_CroesusProcess();
        }                
}

function Get_PortfolioGrid_GrpSummary_PnlRQSCharts_ChText(i){
      return Get_PortfolioGrid_GrpSummary_PnlRQSCharts().WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBlock",i], 10)}

function Get_RelationshipsClientsAccountsPlugin_BottomGroupBox_Clients(){
      return Get_RelationshipsClientsAccountsDetails().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter","1"], 10)}      
      
function Get_RelationshipsClientsAccountsPlugin_BottomGroupBox_ClientSummary_KYC_ChText(i){
      return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["ContentControl",i], 10).WPFObject("TextBox", "", 1);}      


function Execute_SQLQuery_GetRow(queryString, vServer)
{
    var query = queryString;	
    var Qry   = ADO.CreateADOQuery();
    
    Qry.ConnectionString = GetDBAConnectionString(vServer);	  
    Qry.SQL=query;
    Qry.Open();
    Qry.First();
    
    var arrayOfValues = new Array();
    var i = 0
    while (i<Qry.FieldCount){
        arrayOfValues.push(Qry.Field(i).Value);
        Qry.Next();
        i++;
    }
    Qry.Close();   
    return arrayOfValues;
}

function Execute_SQLQuery_IsRowEmpty(queryString, vServer)
{
    var query       = queryString;	  
    var Qry         = ADO.CreateADOQuery();
    var returnValue = false;   
    
    Qry.ConnectionString = GetDBAConnectionString(vServer);  
    Qry.SQL = query;
    Qry.Open();

    if (Qry.IsEmpty()) returnValue = true;
    Qry.Close();
    return returnValue;
}