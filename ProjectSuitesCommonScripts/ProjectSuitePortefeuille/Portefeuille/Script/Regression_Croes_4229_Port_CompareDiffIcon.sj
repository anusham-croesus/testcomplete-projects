//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Validation de l'indicateur de variation dans la fenêtre Comparaison du portefeuille
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4229
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
    Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_4229_Port_CompareDiffIcon()
{
    try {
        
       //Variables
       var compte300001NA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "compte300001NA", language+client);
       var id_nd = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "id_nd", language+client);
       var id_same = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "id_same", language+client);
       var id_ajout = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "id_ajout", language+client);
       var id_more = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "id_more", language+client);
       var id_less = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "id_less", language+client);
       var id_suppression = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "id_suppression", language+client);



       var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4229","Lien testlink - Croes-4229");
        
       
       //Mettre la pref  PREF_PORTFOLIO_COMPARE à YES
       Log.Message("*************Mettre la pref  PREF_PORTFOLIO_COMPARE à YES************************");
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","YES",vServerPortefeuille);
       RestartServices(vServerPortefeuille);
       
       
       //Se connecter avec Keynej
       Log.Message("******************** Login *******************");
       Login(vServerPortefeuille, userNameKeynej, passwordKeynej, language);
        
        
        
        //Sélectionner le compte 300001-NA et mailler vers module portefeuille
        Log.Message("*********Sélectionner le compte 300001-NA et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
                
        Search_Account(compte300001NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",compte300001NA,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
       // Cliquer sur le bouton comparaison + ok
       Log.Message("*********Cliquer sur le bouton comparaison pour ouvrir la fenêtre**********")
       Get_PortfolioBar_BtnCompare().Click(); 
       Get_WinComparisonContextChooser_BtnOK().Click()
       
      /////////////////////////////////////////////////////////////////
      var grid = Get_Grid_ContentArray(Get_Portfolio_ComparisonGrid(), Get_Portfolio_ComparisonGrid_ChDescription(), false);
      var colonneSymbol = Get_ColumnFromGridArray(Get_Portfolio_ComparisonGrid_ChDiff(), grid);
      var colonneInit = Get_ColumnFromGridArray(Get_Portfolio_ComparisonGrid_ChInitQty(), grid);
      var colonneFinal = Get_ColumnFromGridArray(Get_Portfolio_ComparisonGrid_ChFinalQty(), grid);
      var colonneDiff = Get_ColumnFromGridArray(Get_Portfolio_ComparisonGrid_ChQtyDiff(), grid);
  
      for(n = 0; n < colonneSymbol.length; n++)
      {
        var expectedSymbol = "";
        var detectedSymbol = colonneSymbol[n];
        var init = convertTextToNumber(colonneInit[n]);
        var final = convertTextToNumber(colonneFinal[n]);
        var diff = convertTextToNumber(colonneDiff[n]);
        
        
        if(aqString.Compare(init,id_nd, true) == 0)
          expectedSymbol =  id_ajout;
        else if(diff > 0)
          expectedSymbol =  id_more;
        else if(final == "n/d"|| final == "n/a"||final ==0)
          expectedSymbol =  id_suppression
        else if(diff < 0  )
          expectedSymbol =  id_less
          
        else
          expectedSymbol =  id_same
        if(aqString.Compare(expectedSymbol, detectedSymbol, true) == 0)
          Log.Checkpoint("Symbole affiché: " + detectedSymbol);
    else
      Log.Error("Symbole affiché: " + detectedSymbol + ", symbole attendu: " + expectedSymbol);
  }
        

         

        
        
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
          
       //Remettre la pref  PREF_PORTFOLIO_COMPARE à No
       Log.Message("*************Remettre la pref  PREF_PORTFOLIO_COMPARE à No************************");
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","YES",vServerPortefeuille);
       RestartServices(vServerPortefeuille);
    }
}


