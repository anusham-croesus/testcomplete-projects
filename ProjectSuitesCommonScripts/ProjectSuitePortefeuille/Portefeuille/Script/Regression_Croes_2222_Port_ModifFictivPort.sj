//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Modifier un portefeuille Fictif à partir d'un compte réel 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2222
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2222_Port_ModifFictivPort()
{
    try {
        
       //Variables
       var nomClient_2222 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "nomClient_2222", language+client);
       
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2222","Lien testlink - Croes-2222");
       
        //Login
        Log.Message("******************** Login *******************");
        Login(vServerPortefeuille, userName, psw, language);
        
        //Creation d'un client Fictif
        Log.Message("*********Créer un client fictif**********")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
        Get_Toolbar_BtnAdd().Click();
        Get_ClientsGrid_ContextualMenu_Add_CreateFictitiousClient().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(nomClient_2222);
        Get_WinDetailedInfo_BtnOK().Click();
        
        
        //Creation d'un compte fictif a partir d'un client fictif existant via le menu module
        Log.Message("*********Creation d'un compte fictif a partir d'un client fictif existant via le menu module**********")
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nomClient_2222, 10).Click();        
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        Get_Toolbar_BtnAdd().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        
        
        //Mailler le compte fictif crééé ver le module portefeuille
        Log.Message("*********Mailler le compte fictif crééé ver le module portefeuille**********")
        Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", nomClient_2222, 10, true, -1).Click();
        Get_MenuBar_Modules().Click();       
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
        //Selectionner la position Encaisse et Modifier la quantité pour la position encaisse 
        Log.Message("*********Selectionner la position Encaisse et Modifier la quantité pour la position encaisse **********")
        Get_PortfolioBar_BtnInfo().Click();         
        Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Click();
        Get_WinPositionInfo_GrpPositionInformation_TxtQuantity().Keys("^a123");
        Get_WinPositionInfo_BtnOK().Click();
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
              
        
        //re-sélectionner le compte pour valider les modifications apportées
        Log.Message("*********Re-sélectionner le compte pour valider les modifications apportées **********")
        Get_ModulesBar_BtnAccounts().Click();
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_PortfolioBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "Text", cmpStartsWith, "123");  
        Get_WinPositionInfo_BtnOK().Click();
        
        //Supprimer le compte fictif créé via la suppression du client fictif créé pour remettre les données comme avnt le cas 
        Get_ModulesBar_BtnClients().Click();
        DeleteClient(nomClient_2222);
       
        
       
     
        
          

        
        
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
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}


