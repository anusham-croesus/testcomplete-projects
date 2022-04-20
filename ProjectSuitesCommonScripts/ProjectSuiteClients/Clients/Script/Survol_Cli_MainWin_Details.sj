//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Transactions_Get_functions


/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Vérifier les composants et les étiquetés dans la partie de détails . */

function Survol_Cli_MainWin_Details()
{
   Login(vServerClients, userName , psw ,language);
   Get_ModulesBar_BtnClients().Click();
   Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);

//   Delay(3000);
   
  //Les points de vérification en français 
  Check_Properties(language)
     
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent la partie de détails)
function Check_Properties(language)
{
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails(), "Header", cmpEqual, GetData(filePath_Clients,"MainWin_Details",2,language));
  
  Get_ClientsDetails_TabInfo().Click();
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo(), "IsSelected", cmpEqual, true);
  
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo(), "Header", cmpEqual, GetData(filePath_Clients,"MainWin_Details",3,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblFollowUp(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",4,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblSegmentation(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",5,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblContactPerson(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",6,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblAccountManager(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",7,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblCommunication(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",8,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblAmounts(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",9,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblBalance(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",10,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblTotalValue(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",11,language));
  aqObject.CheckProperty(Get_ClientsDetails_TabInfo_ScrollViewer_LblMargin(), "Text", cmpEqual, GetData(filePath_Clients,"MainWin_Details",12,language));
  
  Get_ClientsDetails_TabAgenda().Click();
  aqObject.CheckProperty(Get_ClientsDetails_TabAgenda(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_ClientsDetails_TabAgenda(), "Header", cmpEqual, GetData(filePath_Clients,"MainWin_Details",13,language));
  
  Get_ClientsDetails_TabProductsAndServices().Click();
  aqObject.CheckProperty(Get_ClientsDetails_TabProductsAndServices(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_ClientsDetails_TabProductsAndServices(), "Header", cmpEqual, GetData(filePath_Clients,"MainWin_Details",14,language));
  
  Get_ClientsDetails_TabProfile().Click();
  aqObject.CheckProperty(Get_ClientsDetails_TabProfile(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_ClientsDetails_TabProfile(), "Header", cmpEqual, GetData(filePath_Clients,"MainWin_Details",15,language));
  
  Get_ClientsDetails_TabDocuments().Click();
  aqObject.CheckProperty(Get_ClientsDetails_TabDocuments(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_ClientsDetails_TabDocuments(), "Header", cmpEqual, GetData(filePath_Clients,"MainWin_Details",16,language));
}