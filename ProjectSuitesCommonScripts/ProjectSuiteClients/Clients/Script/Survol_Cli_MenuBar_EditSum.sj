//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/* Description : A partir du module « Clients » , afficher la fenêtre « Sommation de clients » en cliquant sur MenuBar - btnSum. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Cli_MenuBar_EditSum()
{
  Login(vServerClients,userName,psw,language);
  Get_ModulesBar_BtnClients().Click();
    
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Sum().Click();
  Log.Message("L'anomalie ouverte par Karima- CROES-8310")
  //Les points de vérification 
  Check_Properties(language)
        
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties(language)
{
  if (client == "BNC" ){
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum(), "Title", cmpEqual, GetData(filePath_Clients,"Sum",2,language));
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "Content", cmpEqual, GetData(filePath_Clients,"Sum",3,language));
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsEnabled", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinClientsSum_LblAssetUnderManagement(), "Text", cmpEqual, GetData(filePath_Clients,"Sum",4,language));
    aqObject.CheckProperty(Get_WinClientsSum_LblTotalCAD(), "Text", cmpEqual, "Total(CAD)");
    aqObject.CheckProperty(Get_WinClientsSum_LblClientsTotalValue(), "Text", cmpEqual, GetData(filePath_Clients,"Sum",5,language));
    aqObject.CheckProperty(Get_WinClientsSum_TxtClientsTotalValue(), "IsVisible", cmpEqual,true);
  
    aqObject.CheckProperty(Get_WinClientsSum_LblNumberOfClients(), "Text", cmpEqual, GetData(filePath_Clients,"Sum",6,language));
    aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "IsVisible", cmpEqual, true);
  
  
    aqObject.CheckProperty(Get_WinClientsSum_LblNumberOfClientRoots(), "Text", cmpEqual, GetData(filePath_Clients,"Sum",7,language));
    aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "IsVisible", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinClientsSum_LblAccountTotalValue(), "Text", cmpEqual, GetData(filePath_Clients,"Sum",8,language));
    Log.Message("Le libellé à utiliser devrait être << Total account value >> selon le fichier Excel : Modification_Documentation")
    aqObject.CheckProperty(Get_WinClientsSum_TxtAccountTotalValue(), "IsVisible", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinClientsSum_LblNumberOfAccounts(), "Text", cmpEqual, GetData(filePath_Clients,"Sum",9,language)); 
    aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfAccounts(), "IsVisible", cmpEqual, true);
  }
  else{ //RJ 
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum(), "Title", cmpEqual, GetData(filePath_Clients,"Sum",2,language));
   /* if(client == "US" ){
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblTotalCAD(), "WPFControlText", cmpEqual, "CAD");
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblCAD(), "WPFControlText", cmpEqual, "Total(USD)");
    }*/
  //  else{
    if(client == "US" ){aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblTotalCAD(), "WPFControlText", cmpEqual, "Total(USD)");}
    else {aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblCAD(), "WPFControlText", cmpEqual, "Total(CAD)");}//SA: modifié depuis l'Exécution de RJ CO-18:utilisé Get_WinClientsSumNoClientGrouping_LblTotalCAD 
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblTotalCAD(), "WPFControlText", cmpEqual, "CAD");//}//SA: modifié depuis l'Exécution de RJ CO-18*/
    
   /* else {aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblTotalCAD(), "WPFControlText", cmpEqual, "Total(CAD)");}//SA: modifié depuis l'Exécution de RJ CO-18:utilisé Get_WinClientsSumNoClientGrouping_LblTotalCAD 
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblCAD(), "WPFControlText", cmpEqual, "CAD");//} //SA: modifié depuis l'Exécution de RJ CO-18*/
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblUSD(), "WPFControlText", cmpEqual, "USD");
    
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "Content", cmpEqual, GetData(filePath_Clients,"Sum",3,language));
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsEnabled", cmpEqual, true);
  
   
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblClientsTotalValue(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"Sum",11,language));
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "IsVisible", cmpEqual,true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "IsVisible", cmpEqual,true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "IsVisible", cmpEqual,true);
  
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblNumberOfClients(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"Sum",6,language));
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "IsVisible", cmpEqual, true);
  

  
  }
}
 function test()
 {
     
     aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum(), "Title", cmpEqual, GetData(filePath_Clients,"Sum",2,language));
    
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblTotalCAD(), "WPFControlText", cmpEqual, "Total(CAD)");
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblCAD(), "WPFControlText", cmpEqual, "CAD");
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblUSD(), "WPFControlText", cmpEqual, "USD");
    
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "Content", cmpEqual, GetData(filePath_Clients,"Sum",3,language));
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum_BtnClose(), "IsEnabled", cmpEqual, true);
  
   
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblClientsTotalValue(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"Sum",11,language));
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "IsVisible", cmpEqual,true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "IsVisible", cmpEqual,true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "IsVisible", cmpEqual,true);
  
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_LblNumberOfClients(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"Sum",6,language));
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "IsVisible", cmpEqual, true);
 
 } 

