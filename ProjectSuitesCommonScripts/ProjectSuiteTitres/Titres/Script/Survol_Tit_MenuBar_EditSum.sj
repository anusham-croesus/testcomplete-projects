//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions

/* Description : A partir du module « Titre » , afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum. 
 Vérifier la présence des contrôles et des étiquetés */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-321 
 function Survol_Tit_MenuBar_EditSum()
 {
    Login(vServerTitre,userName,psw,language);
    Get_ModulesBar_BtnSecurities().Click();
    
    Get_MenuBar_Edit().OpenMenu();
    Get_MenuBar_Edit_Sum().Click();
    
    //Les points de vérification en français 
     if(language=="french"){Check_Properties_French()} 
    //Les points de vérification en anglais 
    else {Check_Properties_English()} 
    
    Get_WinSecuritySum_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
 
  //Fonctions  (les points de vérification pour les scripts qui testent Sum)
function Check_Properties_French()
{
    aqObject.CheckProperty(Get_WinSecuritySum().Title, "OleValue", cmpEqual, "Sommation des titres");
    aqObject.CheckProperty(Get_WinSecuritySum_BtnClose(), "Content", cmpEqual, "_Fermer");
    aqObject.CheckProperty(Get_WinSecuritySum_BtnClose(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSecuritySum_GrpFinancialInstruments() .Header, "OleValue", cmpEqual, "Instruments financiers");
    aqObject.CheckProperty(Get_WinSecuritySum_chNumber().Content, "OleValue", cmpEqual, "Nombre");
    aqObject.CheckProperty(Get_WinSecuritySum_chDescription().Content, "OleValue", cmpEqual, "Description"); 
}

function Check_Properties_English()
{
    aqObject.CheckProperty(Get_WinSecuritySum().Title, "OleValue", cmpEqual, "Securities Sum");
    aqObject.CheckProperty(Get_WinSecuritySum_BtnClose(), "Content", cmpEqual, "_Close");
    aqObject.CheckProperty(Get_WinSecuritySum_BtnClose(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSecuritySum_GrpFinancialInstruments() .Header, "OleValue", cmpEqual, "Financial Instruments");
    aqObject.CheckProperty(Get_WinSecuritySum_chNumber().Content, "OleValue", cmpEqual, "Count");
    aqObject.CheckProperty(Get_WinSecuritySum_chDescription().Content, "OleValue", cmpEqual, "Description"); 
}