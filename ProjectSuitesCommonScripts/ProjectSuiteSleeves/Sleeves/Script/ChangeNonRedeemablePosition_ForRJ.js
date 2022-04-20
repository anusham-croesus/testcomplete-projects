//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition

 /* Description : Dans la BD de BNC la position FTS est NonRedeemable  
Analyste d'automatisation: Youlia Raisper */


function ChangeNonRedeemablePosition_ForRJ()
{
 if(client=="RJ"){
   try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");           
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 8); //800040-RE
        var positionFTS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_FTS", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();        
        Search_Account(account)      
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        ChangeNonRedeemable(positionFTS,true)
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account)      
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        Search_Position(positionFTS)  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionFTS,10).DataContext.DataItem, "IsSecurityLegacy", cmpEqual,true);              
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
 }    
}

