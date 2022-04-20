//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Validation de la Recherche rapide dans Portefeuille 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2254
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2254_Port_QuickSearch()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var positionBCE = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "positionBCE", language+client);
       //var symbol = "BCE";
           
       
       //Lien Testlink du cas 
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2254","Lien testlink - Croes-2254");
       
       
        //Login
        Log.Message("******************** Login *******************")
        Login(vServerPortefeuille, userName, psw, language);
        
        
        //Sélectionner le client 300001 et mailler vers module portefeuille
        Log.Message("**************Sélectionner le client "+client300001+" et mailler vers module portefeuille*****************")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client300001);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client300001,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
       //Cliquer sur le bouton loupe 'Rechercher' et saisir 'BCE'
          Log.Message("**************Cliquer sur le bouton loupe 'Rechercher' et saisir 'BCE'*****************")
          Get_Toolbar_BtnSearch().Click();
          Get_WinQuickSearch_TxtSearch().Keys(positionBCE);
          Get_WinQuickSearch_BtnOK().Click();
          Get_PortfolioBar_BtnInfo().Click();
          aqObject.CheckProperty(Get_WinPositionInfo(), "WPFControlText", cmpContains, positionBCE);
          Get_WinPositionInfo_BtnCancel().Click();
  
          //Refaire la meme étape 2 avec le raccourci [lettre] (taper BCE directement depuis Portefeuille, sans ouvrir Recherche)
          Log.Message("**************Refaire la meme étape 2 avec le raccourci [lettre] (taper BCE directement depuis Portefeuille, sans ouvrir Recherche)*****************")
          Get_Portfolio_PositionsGrid().Keys(positionBCE.charAt(0));
          Get_WinQuickSearch_TxtSearch().keys(positionBCE.slice(1));
          Get_WinQuickSearch_BtnOK().Click();
          Get_PortfolioBar_BtnInfo().Click();
          aqObject.CheckProperty(Get_WinPositionInfo(), "WPFControlText", cmpContains, positionBCE);
          Get_WinPositionInfo_BtnCancel().Click();
  
          //Refaire la meme étape 2 avec le raccourci [lettre] (taper BCE directement depuis Portefeuille, sans ouvrir Recherche)
          Log.Message("**************Refaire la meme étape 2 avec le raccourci [lettre] (taper BCE directement depuis Portefeuille, sans ouvrir Recherche)*****************")
          Get_Toolbar_BtnSearch().Click();
          Get_WinQuickSearch_TxtSearch().Keys(positionBCE);
          Get_WinPortfolioQuickSearch_RdoSymbol().Click();
          Get_WinQuickSearch_BtnOK().Click();
          Get_PortfolioBar_BtnInfo().Click();
          aqObject.CheckProperty(Get_WinPositionInfo(), "WPFControlText", cmpContains, positionBCE);
          Get_WinPositionInfo_BtnCancel().Click();
  
          //Cliquer sur le bouton loupe 'Rechercher, cocher 'Symbole' et saisir 'BCE'
          Log.Message("**************Cliquer sur le bouton loupe 'Rechercher, cocher 'Symbole' et saisir 'BCE'*****************")
          Get_Portfolio_PositionsGrid().Keys('.');
          Get_WinQuickSearch_TxtSearch().keys(positionBCE);
          Get_WinQuickSearch_BtnOK().Click();
          Get_PortfolioBar_BtnInfo().Click();
          aqObject.CheckProperty(Get_WinPositionInfo(), "WPFControlText", cmpContains, positionBCE);
          Get_WinPositionInfo_BtnCancel().Click();
  
          //Refaire la meme étape 4 avec le raccourci "."
          Log.Message("**************Refaire la meme étape 4 avec le raccourci '.'*****************")
          Get_Toolbar_BtnSearch().Click();
          Get_WinQuickSearch_TxtSearch().Keys(client300001);
          Get_WinPortfolioQuickSearch_RdoAccountNo().Click();
          Get_WinQuickSearch_BtnOK().Click();
          Get_PortfolioBar_BtnInfo().Click();
          aqObject.CheckProperty(Get_WinPositionInfo(), "WPFControlText", cmpContains, client300001);
          Get_WinPositionInfo_BtnCancel().Click();
  
          //Cliquer sur le bouton loupe 'Rechercher, cocher 'No compte' et saisir '300001'
          Log.Message("**************Cliquer sur le bouton loupe 'Rechercher, cocher 'No compte' et saisir '300001'*****************")
          Get_Portfolio_PositionsGrid().Keys(client300001.charAt(0));
          Get_WinQuickSearch_TxtSearch().keys(client300001.slice(1));
          Get_WinQuickSearch_BtnOK().Click();
          Get_PortfolioBar_BtnInfo().Click();
          aqObject.CheckProperty(Get_WinPositionInfo(), "WPFControlText", cmpContains, client300001);
          Get_WinPositionInfo_BtnCancel().Click();
          
          
          
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


      




