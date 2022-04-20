//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' 
contenant les boutons Info, Perfomance, Activities , . Fermêture de l’application avec AltF4 */

function Survol_Cli_AltF4()
{
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  //Les points de vérification en français 
  Check_Properties(language);
   
  Close_Croesus_AltF4();
}
function test()
{
  Get_ClientsBar_BtnInfo().OpenMenu();
}

//Fonctions  (les points de vérification pour les scripts qui testent Close_Application)
function Check_Properties(language)
{
    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo(), "Header", cmpEqual, GetData(filePath_Clients,"Close_Application",2,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo(), "IsVisible", cmpEqual,true);
    //Vérifier le texte de boutons dans la liste 
    Get_ClientsBar_BtnInfo().Click(63, 17);
    
   
    if(!(Get_SubMenus().VisibleOnScreen)){
    Get_ClientsBar_BtnInfo().Click(63, 17);}
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemInfo(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",3,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemInfo(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemNotes(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",4,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemNotes(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemAddresses(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",5,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemAddresses(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemTelephons(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",6,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemTelephons(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemEmail(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",7,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemEmail(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemAgenda(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",8,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemAgenda(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemProductsAndServices(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",9,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemProductsAndServices(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemInvestmentObjective(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",10,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemInvestmentObjective(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemDefaultReports(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",11,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemDefaultReports(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemDefaultIndices(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",12,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemDefaultIndices(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemProfiles(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",13,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemProfiles(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemDocuments(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",14,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemDocuments(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemCostumerNetwork(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",15,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemCostumerNetwork(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemCampaigns(), "Header", cmpEqual,  GetData(filePath_Clients,"Close_Application",16,language));
    aqObject.CheckProperty(Get_ClientsBar_BtnInfo_ItemCampaigns(), "IsVisible", cmpEqual, true);
    Get_ClientsBar_BtnInfo().Click(63, 17);
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnPerformance().Content, "OleValue", cmpEqual,GetData(filePath_Clients,"Close_Application",17,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnPerformance(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnPerformance(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnActivities().Content, "OleValue", cmpEqual, GetData(filePath_Clients,"Close_Application",18,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnActivities(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnActivities(), "IsEnabled", cmpEqual, true);
   
}

