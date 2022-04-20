//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 /* Description :Dans le du module « Clients »,afficher la fenêtre «Add External Client» en cliquant sur ToolBar_btnAdd_External. 
Vérifier la présence des contrôles et des étiquetés et Cliquer sur chaque onglet pour vérifier le message qui apparaît */

function Survol_Cli_ToolBar_btnAdd_External()
{
  var btn="addExternal";
  
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click(); 
  
  Get_Toolbar_BtnAdd().Click();
  Get_ClientsGrid_ContextualMenu_Add_CreateExternalClient().Click();
     
  //Les points de vérification
  Check_Properties_DetailedInfo_TabInfo(language,btn) // la fonction est dans CommonCheckpoints
  
  Get_WinDetailedInfo_TabAddresses().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",8,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"WinAddClient",7,language));
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  Get_WinDetailedInfo_TabAgendaForClient().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",8,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"WinAddClient",7,language));
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  Get_WinDetailedInfo_TabProductsAndServices().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",8,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"WinAddClient",7,language));
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  Get_WinDetailedInfo_TabProfile().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",8,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"WinAddClient",7,language));
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  Get_WinDetailedInfo_TabDocuments().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",8,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"WinAddClient",7,language));
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  Get_WinDetailedInfo_TabClientNetworkForClient().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",8,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"WinAddClient",7,language));
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  Get_WinDetailedInfo_TabCampaignsForClient().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",8,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"WinAddClient",7,language));
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  Get_WinDetailedInfo().Close();
  
   if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", GetData(filePath_Clients,"WinAddClient",6,language)])){
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
    else {
        Log.Error("La fenêtre Info n'était pas fermée.");
        Terminate_CroesusProcess();
    }
 }
 