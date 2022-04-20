//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).  
afficher la fenêtre « Rapports portefeuille » en cliquant sur ToolBar_btnReportsAndGraphs . 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons .Fermer la fenêtre psr X*/

/*    Date: 31-12-2020
      Analyste Auto: Abdel.M
      Objectif: Combiner les différentes façons pour portfolio Reports
*/
 
 function Survol_Por_PortfolioReports_CombinedAccess()
 {
   try {
          // Les variables utilisées dans les points de vérifications 
          var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "client800276", language+client);
          var modulePortfolio = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "modulePortfolio", language+client);
          var btnReports = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "btnReports", language+client);
  
 //---------- Étape 1 : Se connecter à croesus avec COPERN -------------------------------
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
          Login(vServerPortefeuille, userName, psw, language);
          Get_ModulesBar_BtnClients().Click();
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientNumber)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          
 //----------- Étape 2 : Accès à la fenêtre Info en cliquant sur MenuBar -Edit-Functions- btnInfo ---------------------------------------
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Accès à la fenêtre Info en cliquant sur MenuBar -Edit-Functions- btnInfo");
  
          //afficher la fenêtre « Rapports portefeuille » en cliquant sur MenuBar-ReportsSecurities 
          Get_MenuBar_Reports().OpenMenu()
          Get_MenuBar_Reports_Portfolio().Click()
    
          //Les points de vérification
          Check_Properties_Reports(language,modulePortfolio,btnReports)
  
          Get_WinReports_BtnClose().Click();
          
 //----------- Étape 3 : Accès à la fenêtre Info en cliquant sur le bouton Info ---------------------------------------
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Accès à la fenêtre Info en cliquant sur le bouton Info");
  
          Get_Toolbar_BtnReportsAndGraphs().Click()
    
          //Les points de vérification
          Check_Properties_Reports(language,modulePortfolio,btnReports)
  
          Get_WinReports().Close();
          
  
     }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 4 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
      
 }