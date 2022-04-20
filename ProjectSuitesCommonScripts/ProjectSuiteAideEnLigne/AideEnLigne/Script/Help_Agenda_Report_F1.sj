//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Agenda_Report_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Get_Toolbar_BtnAgenda().Click();
  Get_WinAgenda_BtnReport().Click();
  
  Terminate_IEProcess();
  
  Get_WinReports_BtnClose().keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("Fenêtre possède une aide en ligne incorrecte (erreur CROES-7955)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 5, columnID));
  
  Get_WinReports().Close();
  Get_WinAgenda().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
