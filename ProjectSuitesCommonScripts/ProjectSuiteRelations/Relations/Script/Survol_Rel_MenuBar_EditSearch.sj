//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions

 /* Description : A partir du module « Relations » , afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Rel_MenuBar_EditSearch()
 {
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
  
  //afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Search().Click()
  
  //Les points de vérification 
  Check_Properties(language)
   
  Get_WinQuickSearch().Close();
  
  Close_Croesus_MenuBar(); 
 }
 

 //Fonctions  (les points de vérification pour les scripts qui testent Search)
function Check_Properties(language)
{  
  aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, GetData(filePath_Relations,"Search",2,language));
  aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "Content", cmpEqual, GetData(filePath_Relations,"Search",3,language));
  aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "Content", cmpEqual, GetData(filePath_Relations,"Search",5,language));
  aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty( Get_WinQuickSearch_LblSearch(), "Text", cmpEqual, GetData(filePath_Relations,"Search",6,language));
  aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinQuickSearch_LblIn(), "Text", cmpEqual, GetData(filePath_Relations,"Search",4,language));
  
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",7,language));
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoName().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",8,language));
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoName(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoIACode().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",9,language));
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoIACode(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoCurrency().DataContext, "Label", cmpEqual, GetData(filePath_Relations,"Search",10,language));
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoCurrency(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRelationshipsQuickSearch_RdoRelationshipNo(), "IsEnabled", cmpEqual, true);
     
}

