//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Vérifier le fonctionnement des liens URL pour une position du Portefeuille
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2239
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2239_Port_Internet()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var noSecurityB87545 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "noSecurityB87545", language+client);      
       var URLCotesB87545 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "URLCotesB87545", language+client);
       var URLGraphiqueB87545 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "URLGraphiqueB87545", language+client);
       var URLAnalysesB87545 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "URLAnalysesB87545", language+client);
       var URLNouvellesB87545 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "URLNouvellesB87545", language+client);
       var URLCompagnieB87545 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "URLCompagnieB87545", language+client);
       
       
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2239","Lien testlink - Croes-2239");
       
        //Login
        Log.Message("******************** Login *******************");
        Login(vServerPortefeuille, userName, psw, language);
        
       
              
         //Sélectionner le client 300001 et mailler vers module portefeuille
        Log.Message("*********Sélectionner le client "+client300001+" et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client300001);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client300001,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
              
        
        //Sélectionner le titre B87545 dans le compte 300001NA
        Log.Message("*********Sélectionner le titre B87545 dans le compte 300001NA**********");
        Search_Position(noSecurityB87545);
        //Get_Portfolio_PositionsGrid().FindChild("Value", noSecurityB87545, 10).Click();
        
        
        //Cliquer l'icône de la terre pour avoir le menu des liens URL et sélectionner chacun des liens disponibles
        Log.Message("*********Cliquer l'icône de la terre pour avoir le menu des liens URL et sélectionner chacun des liens disponibles**********");
        
        Terminate_IEProcess();
        Get_Toolbar_BtnInternetAddresses().Click();
        Get_MenuBar_Tools_Internet_Quotes().Click();
        Delay(5000);
        aqObject.CheckProperty(Sys.Browser("iexplore").Page(URLCotesB87545), "exists", cmpEqual, true);
        
        Terminate_IEProcess();
        Get_Toolbar_BtnInternetAddresses().Click();
        Get_MenuBar_Tools_Internet_Graphs().Click();
        Delay(5000)
        aqObject.CheckProperty(Sys.Browser("iexplore").Page(URLGraphiqueB87545), "exists", cmpEqual, true);
        
        Terminate_IEProcess();
        Get_Toolbar_BtnInternetAddresses().Click();
        Get_MenuBar_Tools_Internet_Analysis().Click();
        Delay(5000)
        aqObject.CheckProperty(Sys.Browser("iexplore").Page(URLAnalysesB87545), "exists", cmpEqual, true);
        
        
        Terminate_IEProcess();
        Get_Toolbar_BtnInternetAddresses().Click();
        Get_MenuBar_Tools_Internet_News().Click();
        Delay(5000)
        aqObject.CheckProperty(Sys.Browser("iexplore").Page(URLNouvellesB87545), "exists", cmpEqual, true);
        
        
        Terminate_IEProcess();
        Get_Toolbar_BtnInternetAddresses().Click();
        Get_MenuBar_Tools_Internet_Company().Click();
        Delay(5000)
        aqObject.CheckProperty(Sys.Browser("iexplore").Page(URLCompagnieB87545), "exists", cmpEqual, true);
        
       
     
        
          

        
        
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



