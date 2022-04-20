//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions

 /* Description : A partir du module « Titre » , afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
Vérifier la présence de boutons radio : Description, Symbole ,Titre
Vérifier la présence de champs de texte et les boutons OK, Annuler */
//  Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-326

 function Survol_Tit_MenuBar_btnSearch()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
 
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Search().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  else {Check_Properties_English()}
  
  Check_Existence_Of_Controls()
  
  Get_WinQuickSearch_BtnCancel().Click()
  
  Close_Croesus_MenuBar()
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Search)
function Check_Properties_French()
{
    aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Rechercher");
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoDescription().DataContext.Label, "OleValue", cmpEqual, "Description"); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoCurPrice().DataContext.Label, "OleValue", cmpEqual, "Devise prix"); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSymbol().DataContext.Label, "OleValue", cmpEqual, "Symbole");
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSecurity().DataContext.Label, "OleValue", cmpEqual, "Titre"); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoType().DataContext.Label, "OleValue", cmpEqual, "Type"); 
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
    
    //La présence des étiquettes
    aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Rechercher:");
    aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "Dans:");
}

function Check_Properties_English()
{
    aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Search");
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoDescription().DataContext.Label, "OleValue", cmpEqual, "Description"); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoCurPrice().DataContext.Label, "OleValue", cmpEqual, "Cur. Price"); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSymbol().DataContext.Label, "OleValue", cmpEqual, "Symbol");
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSecurity().DataContext.Label, "OleValue", cmpEqual, "Security"); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoType().DataContext.Label, "OleValue", cmpEqual, "Type"); 
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
    
    //La présence des étiquettes
    aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Search for:");
    aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "In:");     
}

function Check_Existence_Of_Controls()
{
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoDescription(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoCurPrice(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSymbol(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoSecurity(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSecuritiesQuickSearch_RdoType(), "IsEnabled", cmpEqual, true); 
   
}