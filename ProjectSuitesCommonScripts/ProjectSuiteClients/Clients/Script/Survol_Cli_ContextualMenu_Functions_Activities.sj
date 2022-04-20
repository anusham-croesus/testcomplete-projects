//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 /* Description : A partir du module "Clients",afficher la fenêtre « Client activities» 
 par ContextualMenu_Functions_Activities. Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Fermer*/

 function Survol_Cli_ContextualMenu_Functions_Activities()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  var essais = 0;
  
  do {
      essais++;
      Get_MainWindow().Keys("[Apps]");
      isFound = WaitObject(Get_CroesusApp(), "Uid", "ContextMenu_5055", 3000);
  } while (isFound != true && essais < 3 );
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
  Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Activities().Click();
  
  //Les points de vérification
  Check_Properties(language);
  
  Get_WinActivities_BtnClose().Click();
  
  Close_Croesus_AltQ();
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{
  aqObject.CheckProperty(Get_WinActivities_BtnClose(), "Content", cmpEqual,  GetData(filePath_Clients,"Activities",2,language));
  aqObject.CheckProperty(Get_WinActivities_BtnClose(), "IsVisible", cmpEqual,  true);
  aqObject.CheckProperty(Get_WinActivities_BtnClose(), "IsEnabled", cmpEqual,  true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities(), "Header", cmpEqual, GetData(filePath_Clients,"Activities",3,language));
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate(), "Header", cmpEqual,GetData(filePath_Clients,"Activities",4,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpFrom(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpFrom(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpTo(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpTo(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_CmbPeriodSelector(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_CmbPeriodSelector(), "IsVisible", cmpEqual, true);
 
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpKeywords(), "Header", cmpEqual, GetData(filePath_Clients,"Activities",5,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpKeywords_TxtKeywords(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpKeywords_TxtKeywords(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpActivityType(), "Header", cmpEqual, GetData(filePath_Clients,"Activities",6,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext(), "Header", cmpEqual, GetData(filePath_Clients,"Activities",7,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "IsChecked", cmpEqual, true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",8,language));
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_BtnClearFilters(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",9,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_BtnClearFilters(), "IsVisible", cmpEqual,  true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_BtnClearFilters(), "IsEnabled", cmpEqual,  true);
  //les en-têtes    
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChDate(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",12,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChType(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",13,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChSource(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",14,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChName(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",15,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChCreatedBy(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",16,language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChDescription(), "Content", cmpEqual, GetData(filePath_Clients,"Activities",17,language));
}