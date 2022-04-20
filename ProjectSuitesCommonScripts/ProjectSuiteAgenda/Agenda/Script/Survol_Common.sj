//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


function Check_btnReports_Properties(language)
{
    aqObject.CheckProperty(Get_WinReports().Title, "OleValue", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnReport", 2, language));
    
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnReport", 3, language));
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "WPFControlText", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnReport", 4, language));
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "IsEnabled", cmpEqual, true);
    
    Check_Properties_GrpReports(language, "reports")   
}

function Check_btnDetailedInfoMessage_Properties(language)
{
    aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 2, language));
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 4, language));
    aqObject.CheckProperty(Get_DlgInformation_LblMessage().OkButtonLabel, "OleValue", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 3, language));
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "IsEnabled", cmpEqual, true);  
}

function Check_btnConfigure_Properties(language)
{
  aqObject.CheckProperty(Get_WinUserSelection(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",2,language));
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnOK(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",3,language));
  aqObject.CheckProperty(Get_WinUserSelection_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnCancel(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",4,language));
  aqObject.CheckProperty(Get_WinUserSelection_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinUserSelection_DgvAvailableUsers(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_DgvSelectedUsers(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnAddCurrentAvailableUserToSelectionList(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnAddCurrentAvailableUserToSelectionList(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnRemoveTheSelectedUserFromTheSelectionList(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnRemoveTheSelectedUserFromTheSelectionList(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinUserSelection_LblAvailableUsers(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",6,language));
  Log.Message("Anomalie  CROES-6460 ");
  aqObject.CheckProperty(Get_WinUserSelection_DgvAvailableUsers_ChLastName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",7,language));
  aqObject.CheckProperty(Get_WinUserSelection_DgvAvailableUsers_ChFirstName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",8,language));
  
  aqObject.CheckProperty(Get_WinUserSelection_LblSelectedUsers(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",10,language));
  Log.Message("Anomalie  CROES-6460 ");
  aqObject.CheckProperty(Get_WinUserSelection_DgvSelectedUsers_ChLastName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",11,language));
  aqObject.CheckProperty(Get_WinUserSelection_DgvSelectedUsers_ChFirstName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",12,language));
  
}

function Check_WinAgendaCommon_Properties(language) //La partie commune pour tous les onglets dans la fenêtre Agenda  
{
  aqObject.CheckProperty(Get_WinAgenda().Title, "OleValue", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",2,language));
  
  //les btns de la fenêtre       
  aqObject.CheckProperty(Get_WinAgenda_BtnOk().Content, "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",3,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnCancel().Content, "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",4,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnApply().Content, "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",5,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsEnabled", cmpEqual, true);
  
  //Vérifier le texte de chaque onglet   
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",7,language));  
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",8,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",9,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",10,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",11,language)); 
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",12,language));
  
  
  aqObject.CheckProperty(Get_WinAgenda_LblUser(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",14,language));
  aqObject.CheckProperty(Get_WinAgenda_CmbUser(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_CmbUser(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnConfigure_LblConfigure(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",15,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnConfigure(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnConfigure(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_BtnReport_LblReport(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",16,language));
  aqObject.CheckProperty(Get_WinAgenda_BtnReport(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_BtnReport(), "IsEnabled", cmpEqual, true);
  
  //D'après les commentaires de Mamoudou lafonctionnalité de Synchro Outlook a été décomissionnée, voir FA-872 , c`est la raison de la disparition du bouton Synchroniser.
  /*if (client == "BNC" ){
    aqObject.CheckProperty(Get_WinAgenda_BtnSynchronize_LblSynchronize(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",17,language));
    aqObject.CheckProperty(Get_WinAgenda_BtnSynchronize(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_BtnSynchronize(), "IsEnabled", cmpEqual, true);
  }*/
}

//-------------------------------------------------Alarms----------------------------------------------------------------
function Check_Alarms_Properties(language){
  
      //Vérifier quel onglet est sélectionné  
      aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
      aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
      aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
      aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
      aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, true);
      aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
    
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Alarms",3,language));
    
      //Les boutons 
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnMark().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",4,language));
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnMark(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnMark(), "IsEnabled", cmpEqual, true);
    
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
    
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
    
      //Afficher les entêtes de colonnes par défaut et Vérifier le texte 
      Get_WinAgenda_TabAlarms_ChName().ClickR()
      Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration().Click()
    
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",6,language));
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",7,language));
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",8,language));
    
      //Afficher tous les entêtes de colonnes et Vérifier le texte     
      TabAlarms_Add_AllColumns();//(Get_WinAgenda_TabAlarms_ChName());
      Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Maximize(); //Agrandir la fenêtre pour ne pas scroller 
    
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",6,language));
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",10,language));
      if( client == "US" ){
        Log.Message("USDEV-341");
      } 
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",11,language));
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChExpirationDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",12,language));
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChAccountNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",13,language));
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",7,language));
      aqObject.CheckProperty(Get_WinAgenda_TabAlarms_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Alarms",8,language));
    
      Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Restore();
}

function TabAlarms_Add_AllColumns(){
  
        Get_WinAgenda_TabAlarms_ChName().ClickR();
        Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
        var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
        //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
        aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 4); 
        for(i=1; i<=count; i++) {
            Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
            Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
            Get_WinAgenda_TabAlarms_ChName().ClickR();
        }
}

//-------------------------------------------------Birthdays----------------------------------------------------------------

function TabBirthdays_Add_AllColumns()
{
    Get_WinAgenda_TabBirthdays_ChName().ClickR();
    Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 4); 
    for(i=1; i<=count; i++)
    {
      Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
      Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      Get_WinAgenda_TabBirthdays_ChName().ClickR();
    }  
}


function Check_BtnBirthdays_Properties(language)
{

    //Vérifier quel onglet est sélectionné  
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Birthdays",3,language));
    
    //Les boutons
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
    //Afficher les entêtes de colonnes par défaut et Vérifier le texte 
    Get_WinAgenda_TabBirthdays_ChName().ClickR()
    Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration().Click()
    
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",5,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChDateOfBirth().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",6,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChAge().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",7,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChLastContact().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",8,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone1().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",9,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone2().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone3().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone4().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",12,language));
     
    //Afficher tous les entêtes de colonnes et Vérifier le texte    
    TabBirthdays_Add_AllColumns();
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Maximize();//Agrandir la fenêtre pour ne pas scroller 
    
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",5,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTotalValue().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",14,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChLanguage().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",15,language));
    if( client == "US" ){
    Log.Message("USDEV-341")
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",16,language));}
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChClientNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",17,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChDateOfBirth().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",6,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChAge().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",7,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChLastContact().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",8,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone1().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",9,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone2().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone3().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabBirthdays_ChTelephone4().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Birthdays",12,language));
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Restore();
  
}

//-------------------------------------------------FilesProcessing----------------------------------------------------------------

function Check_FilesProcessing_Properties(language)
{

    //Vérifier quel onglet est sélectionné  
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_FilesProcessing",3,language));
    
     //Les boutons  
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
    //Afficher les entêtes de colonnes par défaut et Vérifier le texte 
    Get_WinAgenda_TabFilesProcessing_ChUpdate().ClickR()
    Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration().Click()
    
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",5,language));
    if(client == "US" ){
    Log.Message("USDEV-341")}
//    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",6,language));
    Log.Message("Karima a dit que c'est une ancienne anomalie, on la laisse comme ca en attendant une réponse de l'équipe produit/Dev");
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",7,language));
    
    //Afficher tous les entêtes de colonnes et Vérifier le texte       
    FileProcessing_Add_AllColumns();//(Get_WinAgenda_TabFilesProcessing_ChUpdate());
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Maximize();//Agrandir la fenêtre pour ne pas scroller 
    
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChUpdate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",5,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChUserNum().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",9,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChName().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChExpirationDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",12,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChAccountNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",13,language));
    if( client== "US"){
    Log.Message("Pour le code de CP d'aprés Sofia c'est une anomalie en cours d'analyse");}
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChIACode().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",6,language));
    aqObject.CheckProperty(Get_WinAgenda_TabFilesProcessing_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_FilesProcessing",7,language));
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Restore();
  
}

function FileProcessing_Add_AllColumns()
{
    Get_WinAgenda_TabFilesProcessing_ChUpdate().ClickR();
    Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 6); 
    for(i=1; i<=count; i++)
    {
      Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
      Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      Get_WinAgenda_TabFilesProcessing_ChUpdate().ClickR();
    }  
}
//--------------------------------------------------Overdue----------------------------------------------------------------

function Check_Overdue_Properties(language)
{

    //Vérifier quel onglet est sélectionné  
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Overdue",3,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_LblOverdueEvents(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",4,language));
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_CmbOverdueEvents(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_CmbOverdueEvents(), "IsEnabled", cmpEqual, true);
    
    //Les boutons
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnComplete().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",5,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnComplete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnComplete(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnReschedule().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",6,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnReschedule(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnReschedule(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnCancel().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",7,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnCancel(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDelete().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",8,language));
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
    //Afficher les entêtes de colonnes par défaut et Vérifier le texte 
    Get_WinAgenda_TabOverdue_ChDate().ClickR()
    Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration().Click()
    
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDuration().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",12,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChType().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",13,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClient().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",14,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClientNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",15,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",16,language));
    
    
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
    //Get_WinAgenda_TabOverdue_ChDate().ClickR()
    //Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    //aqObject.CheckProperty(Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("ContextMenu", "", 1), "ChildCount", cmpEqual, 10); //En réalité il a y en 6 seulement   
    
    //Afficher tous les entêtes de colonnes et Vérifier le texte 
    Overdue_Add_AllColumns();
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Maximize();
    
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",10,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChUpdateDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",18,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChStatus().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",19,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChPriority().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",20,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChFrequency().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",21,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChCreationDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",22,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChCompletionDate().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",23,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChTime().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",11,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDuration().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",12,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChType().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",13,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClient().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",14,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChClientNo().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",15,language));
    aqObject.CheckProperty(Get_WinAgenda_TabOverdue_ChDescription().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Overdue",16,language));
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: UniFrame").Restore();
  
}

function Overdue_Add_AllColumns()
{
    Get_WinAgenda_TabOverdue_ChDate().ClickR();
    Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
    for(i=1; i<=6; i++)
    {
      Get_WinAgendaGridHeader_ContextualMenu_AddColumn().OpenMenu();
      Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      Get_WinAgenda_TabOverdue_ChDate().ClickR();
    }  
}

function Check_Overdue_BtnReschedule_Properties(language)
{
  aqObject.CheckProperty(Get_WinRescheduled(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",2,language));
  
  aqObject.CheckProperty(Get_WinRescheduled_BtnOK().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",3,language));
  aqObject.CheckProperty(Get_WinRescheduled_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRescheduled_BtnCancel().Content, "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",4,language));
  aqObject.CheckProperty(Get_WinRescheduled_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRescheduled_LblOldDate(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",6,language));
  aqObject.CheckProperty(Get_WinRescheduled_TxtOldDate(), "IsVIsible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_TxtOldDate(), "IsReadOnly", cmpEqual, true);
  
//  if (client == "BNC"){//Les modifications dues aux changements dans la BD 
//    aqObject.CheckProperty(Get_WinRescheduled_LblOldTime(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",7,language));
//    aqObject.CheckProperty(Get_WinRescheduled_TxtOldTime(), "IsVIsible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinRescheduled_TxtOldTime(), "IsReadOnly", cmpEqual, true);
//  }
  
  aqObject.CheckProperty(Get_WinRescheduled_LblNewDate(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",8,language));
  aqObject.CheckProperty(Get_WinRescheduled_DtpNewDate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRescheduled_DtpNewDate(), "IsReadOnly", cmpEqual, false);
  
//  if (client == "BNC" ){//Les modifications dues aux changements dans la BD 
//    aqObject.CheckProperty(Get_WinRescheduled_LblNewTime(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",9,language));
//    aqObject.CheckProperty(Get_WinRescheduled_CmbNewTime(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinRescheduled_CmbNewTime(), "IsReadOnly", cmpEqual, false);
//  }
}
//--------------------------------------------------Schedule----------------------------------------------------------------

function Check_Schedule_btnAdd_Properties(language)
{
   aqObject.CheckProperty(Get_WinAddEditAnEvent(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",2,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",3,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",4,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForSchedule(), "IsEnabled", cmpEqual, true);
     
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule(), "Header", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",6,language));
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTypeForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",7,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDateForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",8,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblPriorityForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",9,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblClientForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",10,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDescriptionForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",11,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblStatusForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",12,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTimeForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",13,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTimeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTimeForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblReminderForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",14,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbReminderForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbReminderForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAccountNoForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",15,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblFrequencyForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",16,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDurationForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",17,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForSchedule(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblLastUpdateForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",18,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAssigneeForSchedule(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule_btnAdd",19,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForSchedule(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForSchedule(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForSchedule(), "IsEnabled", cmpEqual, true);  
}

function Check_Schedule_Properties(language)
{
  //Vérifier quel onglet est sélectionné  
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",19,language));
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_LblSearchDescription(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",20,language));
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForScheduleTab(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForScheduleTab(), "IsVisible", cmpEqual, true);
  
  //les boutons 
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrevious(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrevious(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnNext(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnNext(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpCalendar(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",22,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpCalendar_MonthCalendar(), "IsVisible", cmpEqual, true);
  
  //Les entête des colonnes      
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChTime(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",23,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChDuration(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",24,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",25,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChClient(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",26,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_ChDescription(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",27,language));
  
  //Le regroupement  Information
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",30,language)); 
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",31,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtType(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtType(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblDate(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",32,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblPriority(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",33,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtPriority(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtPriority(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblClient(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",34,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtClient(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtClient(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblDescription(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",35,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDescription(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDescription(), "IsVisible", cmpEqual, true);

  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblStatus(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",36,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtStatus(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtStatus(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblTime(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",37,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtTime(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtTime(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblReminder(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",38,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtReminder(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtReminder(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblAccountNo(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",39,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAccountNo(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAccountNo(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblFrequency(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",40,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtFrequency(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtFrequency(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblDuration(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",41,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDuration(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtDuration(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblLastUpdate(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",42,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtLastUpdate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtLastUpdate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_LblAssignee(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Schedule",43,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAssignee(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_TxtAssignee(), "IsVisible", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",45,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnEdit(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",46,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnEdit(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnDelete(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",47,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnDelete(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnCompleted(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Schedule",48,language));
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnCompleted(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabSchedule_GrpInformation_BtnCompleted(), "IsEnabled", cmpEqual, false);
}

//--------------------------------------------------Tasks----------------------------------------------------------------

function Check_Tasks_Properties(language)
{
  //Vérifier quel onglet est sélectionné  
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",3,language));
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_LblSearchDescription(), "Text", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",4,language));
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForTasksTab(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForTasksTab(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrevious(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrevious(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnNext(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnNext(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnPrint(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpCalendar(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",6,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpCalendar_MonthCalendar(), "IsVisible", cmpEqual, true);
  
  //Les entête des colonnes      
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_ChType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",7,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_ChClient(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",8,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_ChDescription(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",9,language));
  
  //Information
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation(), "Header", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",12,language)); 
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblType(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",13,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtType(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtType(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblDate(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",14,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblPriority(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",15,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtPriority(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtPriority(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblClient(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",16,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtClient(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtClient(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblDescription(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",17,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDescription(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDescription(), "IsVisible", cmpEqual, true);

  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblStatus(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",18,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtStatus(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtStatus(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblDuration(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",19,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDuration(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtDuration(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblLastUpdate(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",20,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtLastUpdate(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtLastUpdate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblAccountNo(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",21,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAccountNo(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAccountNo(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblFrequency(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",22,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtFrequency(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtFrequency(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_LblAssignee(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks",23,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAssignee(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_TxtAssignee(), "IsVisible", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnAdd(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",25,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnEdit(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",26,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnEdit(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnDelete(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",27,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnDelete(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnCompleted(), "Content", cmpEqual,  GetData(filePath_Agenda,"Survol_Age_Tasks",28,language));
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnCompleted(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAgenda_TabTasks_GrpInformation_BtnCompleted(), "IsEnabled", cmpEqual, false);
}

function Check_Tasks_btnAdd_Properties(language)
{
   aqObject.CheckProperty(Get_WinAddEditAnEvent(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",2,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",3,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",4,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForTasks(), "IsEnabled", cmpEqual, true);
     
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks(), "Header", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",6,language));
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTypeForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",7,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDateForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",8,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblPriorityForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",9,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblClientForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",10,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForTasks(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDescriptionForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",11,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblStatusForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",12,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDurationForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",13,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblLastUpdateForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",14,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForTasks(), "IsEnabled", cmpEqual, true);
  
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAccountNoForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",15,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForTasks(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblFrequencyForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",16,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAssigneeForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",17,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForTasks(), "IsReadOnly", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForTasks(), "IsEnabled", cmpEqual, true);
   
}



//Fonctions  (les points de vérification pour les scripts qui testent Print)
function CheckPrintProperties(language)
{
    aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, GetData(filePath_Common, "Print", 5, GetWindowsDisplayLanguage()));
    aqObject.CheckProperty(Get_DlgPrint(), "Visible", cmpEqual, true);
    Get_DlgPrint_BtnCancel().Click();
    
    aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual,GetData(filePath_Common, "Print", 3, language));
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Common, "Print", 4, language));
    Get_DlgInformation_BtnOK().Click();
}



/*
    openMethod: "shortkeys" or "toolbar" or "menubar"
*/
function OpenWindowAgenda(openMethod)
{
    Log.Message("Open window 'Agenda' through " + openMethod + "...");
    
    var arrayOfAcceptedOpenMethods = ["toolbar", "menubar", "shortkeys"];
    if (GetIndexOfItemInArray(arrayOfAcceptedOpenMethods, Trim(aqString.ToLower(openMethod))) == -1){
        Log.Error("openMethod '" + openMethod + "' not supported, accepted openMethods are: " + arrayOfAcceptedOpenMethods.join(", "));
    }
    
    var isPerformance = ((aqString.Find(projet, "Performance") == 0) || (aqString.Find(aqFileSystem.GetFileName(Project.FileName), "Performance") == 0));
    if (!isPerformance){
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
    }
    
    var nbTries = 0;
    do {
        switch(Trim(aqString.ToLower(openMethod))){
            case "shortkeys":
                Get_MainWindow().Keys("^L");
                break;
            
            case "menubar":
                Get_MenuBar_Tools().OpenMenu();
                WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true], 5000);
                Get_MenuBar_Tools_Agenda().Click();
                break;
                
            default:
                Get_Toolbar_BtnAgenda().Click();
        }
        
    } while((++nbTries) <= 3 && !Get_WinAgenda().Exists)
    
    WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language), true]);
    
    if (!isPerformance){
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
    }
}


function WaitUntilObjectIsEnabled(varObject, waitTime)
{
    if (waitTime == undefined){
        waitTime = 15000;
    }
    
    varObject.WaitProperty("IsEnabled", true, waitTime);
    Delay(3000);
}



function CloseCroesus()
{
    WaitUntilObjectDisappears(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language), true]);
    Close_Croesus_MenuBar();
    var previousAutoTimeout = Options.Run.Timeout;
    SetAutoTimeOut();
    if (Get_DlgConfirmation().Exists)
        Get_DlgConfirmation_BtnYes().Click();
    RestoreAutoTimeOut(previousAutoTimeout);
}