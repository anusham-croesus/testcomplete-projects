//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Por_PortfolioBar_btnCashFlowProj

/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur CashFlowProj du menu contextuel
vérifier le texte des en-têtes et vérifier les contrôles dans TOOLBARTRAY.*/

/*  Date : 24-12-2020
    Analyste auto: Abdel.M
    Objectif:  combiner les trois façons d'accées (contextual menu, functions menu Édition et portfolioBar button)*/

function Survol_Por_CashFlowProj_CombinedAccess()
{
     try {
        
        var client800300 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "client800300", language+client);
        
        
        //Étape 1 : Se connecter à croesus avec COPERN
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
       
        Login(vServerPortefeuille, userName , psw ,language);
        Get_ModulesBar_BtnClients().Click()
  
        if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(client800300)}
        else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
        //maillage vers le module portefeuille 
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().OpenMenu();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
        //Vérifier que le module portefeuille sélectionné 
        aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
     
        //Étape 2 : Cliquer le Cash Flow proj du Menu Contextuel ------------------------------------------
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Cliquer le Cash Flow proj du Menu Contextuel");
       
        //Cliquer sur CashFlowProj du menu contextuel
        Get_PortfolioPlugin().ClickR();
        Get_PortfolioGrid_ContextualMenu_Functions().Click();
        Get_PortfolioGrid_ContextualMenu_Functions_CashFlowProject().Click();
        
        //Valider que le bouton est actif
        aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsChecked", cmpEqual, true);
        
        //Désactiver le bouton pour faire la 2ème option "Menu Édition"
        Get_PortfolioBar_BtnCashFlowProject().set_IsChecked(false);
        
        //Étape 3 : Cliquer le Cash Flow proj du Menu Édition ------------------------------------------
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Cliquer le Cash Flow proj du Menu Édition");
        
        //Cliquer sur MenuBar-Edit_Functions-CashFlowProj
        Get_MenuBar_Edit().OpenMenu()
        Get_MenuBar_Edit_Functions().OpenMenu()
        Get_MenuBar_Edit_FunctionsForPortfolio_CashFlowProject().Click();
        
        //Valider que le bouton est actif
        aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsChecked", cmpEqual, true);
        
        //Désactiver le bouton pour faire la 2ème option "Menu Édition"
        Get_PortfolioBar_BtnCashFlowProject().set_IsChecked(false);
        
        //Étape 4 : Cliquer le bouton Cash Flow proj  ------------------------------------------
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Cliquer et valider le bouton Cash Flow proj ");
        
        //Cliquer sur PortfolioBar-CashFlowProj
        Get_PortfolioBar_BtnCashFlowProject().Click();
     
        //Les points de vérification en français 
        if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Por_PortfolioBar_btnCashFlowProj     
        //Les points de vérification en anglais 
        else {Check_Properties_English()} // la fonction est dans le script Survol_Por_PortfolioBar_btnCashFlowProj 
   
        Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_PortfolioBar_btnCashFlowProj 
        
     }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 5 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
}

