//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables

 /* Description : A partir du module « Clients » , afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Cli_MenuBar_EditSearch()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  //afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Search().Click()
  
  //Les points de vérification 
  Check_Properties(language)
   
  Get_WinQuickSearch().Close();
  
  Close_Croesus_MenuBar(); 
 }
 

 //Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{  
  aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, GetData(filePath_Clients,"Search",4,language));
  aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "Content", cmpEqual, GetData(filePath_Clients,"Search",2,language));
  aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "Content", cmpEqual, GetData(filePath_Clients,"Search",3,language));
  aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty( Get_WinQuickSearch_LblSearch(), "Text", cmpEqual, GetData(filePath_Clients,"Search",5,language));
  aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty( Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinQuickSearch_LblIn(), "Text", cmpEqual, GetData(filePath_Clients,"Search",6,language));
  
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoClientNo().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",7,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoClientNo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoClientNo(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoName().DataContext, "Label", cmpEqual,GetData(filePath_Clients,"Search",8,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoName(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoIACode().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",9,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoIACode(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoCurrency().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",10,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoCurrency(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoCurrency(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone1().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",11,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone1(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone1(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone2().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",12,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone2(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone2(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone3().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",13,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone3(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone3(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone4().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",14,language));
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone4(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone4(), "IsEnabled", cmpEqual, true);
  
  if (client == "BNC" ){
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoRootNo().DataContext, "Label", cmpEqual, GetData(filePath_Clients,"Search",15,language));
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoRootNo(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoRootNo(), "IsEnabled", cmpEqual, true);
  }
  
}


