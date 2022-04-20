//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints

 /* Description :Dans le du module « Clients »,afficher la fenêtre «Info» en cliquant sur MenuBar - Edit_i (DetailedInfo).(Pour le client qui est sélectionné par default 800300) 
Vérifier la présence des contrôles et des étiquetés */

function Survol_Cli_MenuBar_Edit_i()
{
  var btn="info";
  var module="clients";
  
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click(); 
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Info().Click();
  
  //Vérification du titre de la fenêtre   
  //aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Clients,"WinDetailedInfo",2,language));

  //Les points de vérification
  //Check_Properties_DetailedInfo_TabInfo(language,btn) // la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabAdresses(language,module)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabAgenda(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabProduitsServices(language,module)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabProfile(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabDocuments(language,module) // la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabClientNetwork(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_DetailedInfo_TabCampaigns(language)// la fonction est dans CommonCheckpoints
  
  Get_WinDetailedInfo().Close();  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])){
    Close_Croesus_MenuBar();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
}
