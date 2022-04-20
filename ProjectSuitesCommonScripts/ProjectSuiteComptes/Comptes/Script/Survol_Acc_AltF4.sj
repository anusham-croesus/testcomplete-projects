//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. Affichage du module avec le titre "Comptes". 
Fermeture de l’application avec AltF4 */

function Survol_Acc_AltF4()
{
    Login(vServerAccounts, userName, psw, language);
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 50000);
    
    Check_Properties(language);
    
    Close_Croesus_AltF4();
}


function Check_Properties(language)
{
  //Vérification des textes
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar(), "Text", cmpEqual, GetData(filePath_Accounts, "PadHeader", 2, language));
  aqObject.CheckProperty(Get_AccountsBar_BtnInfo(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "PadHeader", 3, language));
  aqObject.CheckProperty(Get_AccountsBar_BtnAlarms(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "PadHeader", 4, language));
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnPerformance(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "PadHeader", 5, language));
  aqObject.CheckProperty(Get_RelationshipsAccountsBar_BtnRestrictions(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "PadHeader", 6, language));
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnActivities(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "PadHeader", 7, language));
  
  //Vérifier si les boutons du padheader sont visibles et actifs
  aqObject.CheckProperty(Get_AccountsBar_BtnInfo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_AccountsBar_BtnInfo(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_AccountsBar_BtnAlarms(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_AccountsBar_BtnAlarms(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnPerformance(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnPerformance(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsAccountsBar_BtnRestrictions(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsAccountsBar_BtnRestrictions(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnActivities(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsBar_BtnActivities(), "IsEnabled", cmpEqual, true);
}

