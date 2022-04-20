//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
  Description : Jira PF-2647 

  Analyste d'automatisation : Youlia
  Version de scriptage:		ref90-21-26
*/


function TCVE_3145_PF_2647()
{
   try {
          
          //Lien de la storie dans Jira
          Log.Link("https://jira.croesus.com/browse/TCVE-3145");
          //Lien du cas de test dans Jira
          Log.Link("https://jira.croesus.com/browse/PF-2647","Anomalie PF-2647");
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");          
          var account800285RE = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "account800285RE", language+client); 
          
          var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt"); 
                       
          /************************************Étape 1************************************************************************/     
           /*Se connecter avec keynej.Mailler le compte 800285-RE vers le module portefeuille et cliquer Par Panier */
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1:Se connecter avec keynej.Mailler le compte 800285-RE vers le module portefeuille et cliquer 'Par Panier' ");
          
          Log.Message("Activer la pref PREF_POSITION_LEVEL_PERFORMANCE=1");
          Activate_Inactivate_PrefBranch("0","PREF_POSITION_LEVEL_PERFORMANCE","1",vServerPortefeuille);
          RestartServices(vServerPortefeuille);
          
          Log.Message("Se connecter à croesus avec KEYNEJ")
          Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
          
          Log.Message("Sélectionner le compte n "+account800285RE)                    
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
          Search_Account(account800285RE);         
          
          Log.Message("Mailler vers portefeuille"); 
          Log.Message("Mailler le compte n "+account800285RE+" vers portefeuille")                    
          Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800285RE, 10), Get_ModulesBar_BtnPortfolio());
                   
          /************************************Étape 2************************************************************************/     
           /*Cliquer sur le bouton performance 
             Valider que le bouton grouper par Panier est grisé */
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Valider que le bouton grouper 'par Panier' est grisé quand le btn 'performance' est activé ");
                      
          Log.Message("Cliquer sur le btn 'performace'"); 
          Get_PortfolioBar_BtnPerformance().Click();
          Get_PortfolioBar_BtnPerformance().WaitProperty("IsChecked", true, 30000);
   
          Log.Message("Valider que le bouton grouper par Panier est grisé");
          aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(),"IsEnabled", cmpEqual, false);
          
          
          /************************************Étape 3************************************************************************/     
           /*Cliquer sur le bouton performance 
             Valider que le bouton grouper par Panier n'est plus grisé */
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Valider que le bouton grouper par Panier n'est pas grisé quand le btn 'performance' est désactivé ");
          
          Log.Message("Cliquer encore une fois sur le btn 'performace' pour desactiver l'affichage de 'performance'"); 
          Get_PortfolioBar_BtnPerformance().Click();
          Get_PortfolioBar_BtnPerformance().WaitProperty("IsChecked", false, 30000);
          
          Log.Message("Valider que le bouton grouper 'par Panier' n'est plus grisé");
          aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(),"IsEnabled", cmpEqual, true);
          
          /************************************Étape 4************************************************************************/     
           /*Cliquer sur le bouton performance 
             Valider que le bouton grouper par Panier n'est plus grisé */
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Valider que le bouton'performance' est  grisé quand le btn  'par panier' est activé ");       
                        
          Log.Message("Cliquer 'par panier'");
          Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket().Click();
          Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket().WaitProperty("IsChecked", true, 10000);
          
          Log.Message("Valider que le bouton grouper 'performance' est grisé");
          aqObject.CheckProperty(Get_PortfolioBar_BtnPerformance(),"IsEnabled", cmpEqual, false);
         
    }
    catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));        
    }
    finally 
    {   
        //Fermer Croesus
        Log.Message("Fermer Croesus")
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerPortefeuille);
        RestartServices(vServerPortefeuille);         
        Runner.Stop(true)               
    }
}


