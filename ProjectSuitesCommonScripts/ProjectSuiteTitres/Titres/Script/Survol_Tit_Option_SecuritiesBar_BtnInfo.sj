//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_Bond_MenuBar_EditFunctions_Info
//USEUNIT DBA

/* Description : A partir du module « Titre » ,chercher le titre 78757N (Option), afficher la fenêtre « Info » en cliquant sur SecuritiesBar - btnInfo. 
 Vérifier la présence des contrôles et des étiquetés 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1798*/
 
function Survol_Tit_Option_SecuritiesBar_BtnInfo()
{
    if (client == "CIBC" || client == "BNC" || client == "TD" || client == "US"){
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_INTEGRATIONS_TAB", "YES", vServerTitre);
    }
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_RISK_RATING", "1", vServerTitre);
    RestartServices(vServerTitre);
    
    var type = "options";
    
    Login(vServerTitre, userName, psw, language);
    Get_ModulesBar_BtnSecurities().Click();
   
    Search_Security("78757N");
    
    Get_SecuritiesBar_BtnInfo().Click();
    
    //Les points de vérification en français 
    if (language == "french"){Check_Properties_French(type)}// la fonction est dans le script Survol_Tit_Bond_MenuBar_EditFunctions_Info
    //Les points de vérification en anglais 
    else {Check_Properties_English(type)} // la fonction est dans le script Survol_Tit_Bond_MenuBar_EditFunctions_Info
    
    Check_Existence_Of_Controls_Description(type);// la fonction est dans le script Survol_Tit_Bond_MenuBar_EditFunctions_Info
      
    Get_WinInfoSecurity_BtnCancel().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
    
    if (client == "CIBC" || client == "BNC" || client == "TD" || client == "US"){
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_INTEGRATIONS_TAB", null, vServerTitre);
        RestartServices(vServerTitre);
    }
}