//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_Bond_MenuBar_EditFunctions_Info
//USEUNIT DBA

/* Description : A partir du module « Titre » ,chercher le titre 995534 (Mutual Fund) qui n'a pas l'onglet Asset Allocation, afficher la fenêtre « Info » avec Ctrl+E. 
 Vérifier la présence des contrôles et des étiquetés 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1797*/
 
function Survol_Tit_MutualFund_Ctrl_E()
{
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1797","Cas de test TestLink : Croes-1797")
    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_INTEGRATIONS_TAB", "YES", vServerTitre);
    Activate_Inactivate_PrefFirm("FIRM_1", "FD_MFD_PROCESS", "YES", vServerTitre); //Avec FD_MFD_PROCESS=YES  La fenêtre info Titre affiche l'onglet Historique des distributions (remplace l'onglet historique des dividendes)
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_RISK_RATING", "1", vServerTitre);
    RestartServices(vServerTitre);
    
    
    var type = "InvestmentFunds";
    
    Login(vServerTitre, userName, psw, language);
    Get_ModulesBar_BtnSecurities().Click();
   
    Search_Security("995534");
    
    Get_SecurityGrid().Keys("^e");
    
    //Les points de vérification en français 
    if (language == "french"){Check_Properties_French(type)}// la fonction est dans le script Survol_Tit_Bond_MenuBar_EditFunctions_Info
    //Les points de vérification en anglais 
    else {Check_Properties_English(type)} // la fonction est dans le script Survol_Tit_Bond_MenuBar_EditFunctions_Info
    
    Check_Existence_Of_Controls_Description(type);// la fonction est dans le script Survol_Tit_Bond_MenuBar_EditFunctions_Info
     
    Get_WinInfoSecurity_BtnCancel().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_INTEGRATIONS_TAB", null, vServerTitre);    
    Activate_Inactivate_PrefFirm("FIRM_1", "FD_MFD_PROCESS", null, vServerTitre);
    RestartServices(vServerTitre);
    
}

