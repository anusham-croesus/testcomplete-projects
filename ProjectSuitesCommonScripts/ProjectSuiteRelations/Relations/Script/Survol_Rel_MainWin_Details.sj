//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Relations_Get_functions


/* Description : Aller au module "Relationships" en cliquant sur BarModules-btnRelations. Vérifier les composants et les étiquetés dans la partie de détails.*/

function Survol_Rel_MainWin_Details()
{
   Login(vServerRelations, userName , psw ,language);
   Get_ModulesBar_BtnRelationships().Click();
   WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
       
  //Les points de vérification en français 
  Check_Properties(language)
     
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent la partie de détails)
function Check_Properties(language)
{
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails(), "Header", cmpEqual, GetData(filePath_Relations,"MainWin_Details",2,language));
  
  Get_RelationshipsDetails_TabInfo().Click();
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo(), "IsSelected", cmpEqual, true);
  
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo(), "Header", cmpEqual, GetData(filePath_Relations,"MainWin_Details",3,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblInvestmentObjective(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",4,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblFollowUp(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",5,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblSegmentation(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",6,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblContactPerson(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",7,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblAccountManager(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",8,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblCommunication(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",9,language));
  //if( client == "US" ){
 // aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblAmounts(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",20,language));} 
 // else{
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblAmounts(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",10,language));//}
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblBalance(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",11,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblTotalValue(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",12,language));
  aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_LblMargin(), "Text", cmpEqual, GetData(filePath_Relations,"MainWin_Details",13,language));
   
  Get_RelationshipsDetails_TabProductsAndServices().Click();
  aqObject.CheckProperty(Get_RelationshipsDetails_TabProductsAndServices(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsDetails_TabProductsAndServices(), "Header", cmpEqual, GetData(filePath_Relations,"MainWin_Details",17,language));
  
  Get_RelationshipsDetails_TabProfile().Click();
  aqObject.CheckProperty(Get_RelationshipsDetails_TabProfile(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsDetails_TabProfile(), "Header", cmpEqual, GetData(filePath_Relations,"MainWin_Details",18,language));
  
  Get_RelationshipsDetails_TabDocuments().Click();
  aqObject.CheckProperty(Get_RelationshipsDetails_TabDocuments(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsDetails_TabDocuments(), "Header", cmpEqual, GetData(filePath_Relations,"MainWin_Details",19,language));
}