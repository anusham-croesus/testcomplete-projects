//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Résumé : Correspond au Jira Croes-9028 :Montant d'investissement net dans le module portefeuille ne peut pas être réconcilié avec les transactions
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6568
    Lien sur Jira : https://jira.croesus.com/browse/CROES-9028
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Sana Ayaz
    
    Version de scriptage:	90.12.12
*/

function CROES_6568_JiraCroes9028AmountOfNetInvestmentInThePortfolio()
{
    try {
       
        
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var Account800055FS = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "Account800055FS", language+client);        
        var Account800055NA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "Account800055NA", language+client);
        var relationshipNameCROES6568 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "relationshipNameCROES6568", language+client);////Croes9028 
        var TitleWinAddRelatioShipCROES6568=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "TitleWinAddRelatioShipCROES6568", language+client);
        var CodeCpCROES6568=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "CodeCpCROES6568", language+client);//BD88
        var datePortefeuilleCROES6568=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "datePortefeuilleCROES6568", language+client);//03/11/2009
        var valeurInvestissementNetCROES6568=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "valeurInvestissementNetCROES6568", language+client);
        
           
           
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6568")
        Log.Link("https://jira.croesus.com/browse/CROES-9028")
               
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerPortefeuille, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        
        //Aller dans le module Compte et sélectionner les comptes 800055-FS et 800055-NA.
        var Account800055FS = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "Account800055FS", language+client);        
        var Account800055NA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "Account800055NA", language+client);   
        var TabAccounASelection= new Array(Account800055FS, Account800055NA);
        SelectAccounts(TabAccounASelection)
        //Faire un right click --> relation --> Créer une nouvelle relation..--> Associer  
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", Account800055NA, 10).ClickR()
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", Account800055NA, 10).ClickR()
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShipCROES6568, true, true]);         
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCROES6568);//Croes9028
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(CodeCpCROES6568);//BD88
   
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWinAddRelatioShipCROES6568]);
        //Mailler la realion Croes9028 vers le module portefeuille.
        SearchRelationshipByName(relationshipNameCROES6568)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES6568, 10).Click()
        //Mailler la relation vers portfeuille
        Get_MenuBar_Modules().OpenMenu();
        Get_MenuBar_Modules_Portfolio().OpenMenu();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        //Placer le portefeuille en date du  03/11/2009 (3 nov).
        Get_PortfolioGrid_BarToolBarTray_dtpDate().Click();
        Get_PortfolioGrid_BarToolBarTray_dtpDate().keys("^a");
        if(language == "french")
         Get_PortfolioGrid_BarToolBarTray_dtpDate().keys(datePortefeuilleCROES6568);
        else
         Get_PortfolioGrid_BarToolBarTray_dtpDate().keys(datePortefeuilleCROES6568);
         //Dans  la section Sommaire cliquer sur un champ  Calculer  (peu importe lequel)
         Get_PortfolioGrid_GrpSummary_LlbNetInvestment().Click();
         //Les points de vérifications
         Log.Message("Anomalie dont le numéro est : CROES-9028")
         aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtNetInvestment(), "Text", cmpEqual, valeurInvestissementNetCROES6568);// en anglais la valeur n'est pas correct : "176,194.41" mais le script il s'attend a "(698 981.90)"
         

    }
    catch(e) {
      
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
         Login(vServerPortefeuille, user, psw, language);
        DeleteRelationship(relationshipNameCROES6568);
        Terminate_CroesusProcess();
       
        
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
    finally {
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();  
        Login(vServerPortefeuille, user, psw, language);
        DeleteRelationship(relationshipNameCROES6568);
        Terminate_CroesusProcess();
        
    }
}

