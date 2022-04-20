//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints


 /* Description : Dans le du module « Clients », afficher la fenêtre «Info » en cliquant sur MenuBar_EditFunctions.(Pour le client qui est sélectionné par default 800300). 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Cli_MenuBar_EditFunctions_Info()
{
  var btn="info";
  var module="clients";
  
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click(); 
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Info().Click(); //Il a y une anomalie dans automation 10 , le menu est vide 
  
   //Vérification du titre de la fenêtre   
  aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Clients,"WinDetailedInfo",2,language));

 //Les points de vérification
  //Check_Properties_DetailedInfo_TabInfo(language,btn) // la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabAdresses(language,module)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabAgenda(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabProduitsServices(language,module)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabProfile(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabDocuments(language,module) // la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabClientNetwork(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabCampaigns(language)// la fonction est dans CommonCheckpoints
  
  Get_WinDetailedInfo_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_X();
}