//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Validation du menu Edition à partir de la fenêtre Comparaison (copier valider que ce qui a été copier correspond à la grille) 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4226
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
    Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_4226_1_Port_CompareMenuEdit_Copy()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);


       var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4226","Lien testlink - Croes-4226");
        
       
       //Mettre la pref  PREF_PORTFOLIO_COMPARE à YES
       Log.Message("*************Mettre la pref  PREF_PORTFOLIO_COMPARE à YES************************");
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","YES",vServerPortefeuille);
       RestartServices(vServerPortefeuille);
       
       
       //Se connecter avec Keynej
       Log.Message("******************** Login *******************");
       Login(vServerPortefeuille, userNameKeynej, passwordKeynej, language);
        
        
        
        //Sélectionner le client 300001 et mailler vers module portefeuille
        Log.Message("*****************Sélectionner le client "+client300001+" et mailler vers module portefeuille*******************")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client300001);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client300001,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
                
        
        
        // Cliquer sur le bouton comparaison + ok
        Log.Message("*********Cliquer sur le bouton comparaison pour ouvrir la fenêtre**********")
        Get_PortfolioBar_BtnCompare().Click(); 
        Get_WinComparisonContextChooser_BtnOK().Click()
        
             
       // Cliquer sur le menu "Edition" et sélectionner Copier 
        Log.Message("*********Cliquer sur le menu Edition et sélectionner Copier  **********")
        Sys.Clipboard = "Copie non effectuée";
        Get_MenuBar_Edit().Click();
        WaitObject(Get_SubMenus(), "Uid", "CFMenuItem_0367");
        Get_MenuBar_Edit_Copy().Click();        
        
       //Comparer a ce qu'on a copié
        Log.Message("*********Comparer a ce qu'on a copié**********")
        var copyText = Sys.Clipboard;
        copyText = copyText.split("\n");
          
        var grid = Get_Grid_ContentArray(Get_Portfolio_ComparisonGrid(), Get_Portfolio_ComparisonGrid_ChDescription(), false);
          
        Log.Message("la taille de la copie "+copyText.length)
        Log.Message("la taille de la grille "+grid.length)
        if(copyText.length != grid.length)
            Log.Error("Tailles différentes entre la copie et la grille", "Application: " + grid.length + 
                                                                           "\r\nFCopie: " + copyText.length);
  
        for(n = 0; n < copyText.length; n++)
        {
            var copyTextLine = copyText[n];
            if(n < copyText.length-1)
                copyTextLine = aqString.SubString(copyText[n], 0, copyText[n].length-1)
                
            copyTextLine = copyTextLine.split("\t");               
            for(i = 0; i < copyTextLine.length; i++)
                if(aqString.Compare(copyTextLine[i], grid[n][i], true) == 0 || ((copyTextLine[i] == "Oui" || copyTextLine[i] == "Yes") && grid[n][i] == "True") ||
                                                                           ((copyTextLine[n] == "Non" || copyTextLine[i] == "No") && grid[n][i] == "False"))
                  Log.Checkpoint("identique - " + copyTextLine[i]);
                else
                  Log.Error("non identique - " + copyTextLine[i], "Application: " + grid[n][i] + "\r\nTexte Copié: " + copyTextLine[i]);
        
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
    Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","NO",vServerPortefeuille);
    RestartServices(vServerPortefeuille);
    }
}

