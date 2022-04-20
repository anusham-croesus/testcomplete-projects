//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : À partir du module « Tableau de bord », afficher la boîte de dialogue 
 « Ajouter un tableau » en cliquant sur le bouton « Ajouter » de la barre d'outils. 
 Vérifier la présence des contrôles et des étiquettes */
function Survol_Dash_ToolBar_btnAdd()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Clear_Dashboard(); //D'abord vider le dashboard
  
  Get_Toolbar_BtnAdd().Click(); //Ouvrir la boîte de dialogue "Ajouter un tableau"
  
//  Check_Existence_Of_Controls(); //La présence des contrôles
//  
//  if (language=="french"){Check_Properties_French()} //Les points de vérification en français 
//  else {Check_Properties_English()} //Les points de vérification en anglais 
  
  Check_Properties(language);
  
  Get_DlgAddBoard_BtnCancel().Click(); //Fermer la boîte de dialogue "Ajouter un tableau"
  
  Close_Croesus_MenuBar();
}


function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_DlgAddBoard_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_BtnCancel(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard(), "IsVisible", cmpEqual, true);
}


function Check_Properties_French()
{
  aqObject.CheckProperty(Get_DlgAddBoard(), "Title", cmpEqual, "Ajouter un tableau");
  aqObject.CheckProperty(Get_DlgAddBoard_BtnDelete(), "Content", cmpEqual, "S_upprimer");
  aqObject.CheckProperty(Get_DlgAddBoard_BtnOK(), "Content", cmpEqual, "OK");
  aqObject.CheckProperty(Get_DlgAddBoard_BtnCancel(), "Content", cmpEqual, "Annuler");
  aqObject.CheckProperty(Get_DlgAddBoard_LblSelectABoard(), "Content", cmpEqual, "Choisir un tableau:");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_GrpAvailableBoards(), "Header", cmpEqual, "Tableaux disponibles");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_GrpNewBoards(), "Header", cmpEqual, "Nouveaux tableaux");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_PositiveCashBalanceSummary(), "Header", cmpEqual, "Sommaire de l'encaisse positive");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariation(), "Header", cmpEqual, "Objectifs de placement - écarts");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_Calendar(), "Header", cmpEqual, "Calendrier");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_TriggeredRestrictions(), "Header", cmpEqual, "Restrictions déclenchées");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_NegativeCashBalanceSummary(), "Header", cmpEqual, "Sommaire de l'encaisse négative");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_CampaignManagement(), "Header", cmpEqual, "Gestion des campagnes");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_ExpiredOrders(), "Header", cmpEqual, "Ordres expirés");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InternetAddress(), "Header", cmpEqual, "Adresse Internet");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_BasedOnACriterion(), "Header", cmpEqual, "Basé sur un critère");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariationModels(), "Header", cmpEqual, "Objectifs de placement - écarts - Modèles");
}


function Check_Properties_English()
{
  aqObject.CheckProperty(Get_DlgAddBoard(), "Title", cmpEqual, "Add Board");
  aqObject.CheckProperty(Get_DlgAddBoard_BtnDelete(), "Content", cmpEqual, "De_lete");
  aqObject.CheckProperty(Get_DlgAddBoard_BtnOK(), "Content", cmpEqual, "OK");
  aqObject.CheckProperty(Get_DlgAddBoard_BtnCancel(), "Content", cmpEqual, "Cancel");
  aqObject.CheckProperty(Get_DlgAddBoard_LblSelectABoard(), "Content", cmpEqual, "Select a board:");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_GrpAvailableBoards(), "Header", cmpEqual, "Available Boards");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_GrpNewBoards(), "Header", cmpEqual, "New Boards");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_PositiveCashBalanceSummary(), "Header", cmpEqual, "Positive Cash Balance Summary");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariation(), "Header", cmpEqual, "Investment Objective Variation");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_Calendar(), "Header", cmpEqual, "Calendar");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_TriggeredRestrictions(), "Header", cmpEqual, "Triggered Restrictions");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_NegativeCashBalanceSummary(), "Header", cmpEqual, "Negative Cash Balance Summary");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_CampaignManagement(), "Header", cmpEqual, "Campaign Management");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_ExpiredOrders(), "Header", cmpEqual, "Expired Orders");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InternetAddress(), "Header", cmpEqual, "Internet Address");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_BasedOnACriterion(), "Header", cmpEqual, "Based on a criterion");
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariationModels(), "Header", cmpEqual, "Investment Objective Variation - Models");
}



function Check_Properties(language)
{
  //Vérification des contrôles
  aqObject.CheckProperty(Get_DlgAddBoard_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_BtnCancel(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard(), "IsVisible", cmpEqual, true);

  //Vérification des textes
  aqObject.CheckProperty(Get_DlgAddBoard(), "Title", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 2, language));
  aqObject.CheckProperty(Get_DlgAddBoard_BtnDelete(), "Content", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 3, language));
  aqObject.CheckProperty(Get_DlgAddBoard_BtnOK(), "Content", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 4, language));
  aqObject.CheckProperty(Get_DlgAddBoard_BtnCancel(), "Content", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 5, language)); 
  if (client != "CIBC" && client != "BNC")
    aqObject.CheckProperty(Get_DlgAddBoard_LblSelectABoard(), "Content", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 6, language));
  else
    aqObject.CheckProperty(Get_DlgAddBoard_LblSelectABoard(), "Content", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 19, language));
    
  if (client != "CIBC" && client != "BNC"){
      aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_GrpAvailableBoards(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 7, language));   //CR2176
      aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_GrpNewBoards(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 8, language));
  }
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_PositiveCashBalanceSummary(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 9, language));
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariation(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 10, language));  //Le board est renomé  
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_Calendar(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 11, language));
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_TriggeredRestrictions(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 12, language));
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_NegativeCashBalanceSummary(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 13, language));
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_CampaignManagement(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 14, language));
  if(client !== "US" && client !== "TD" && client !== "CIBC"){
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_ExpiredOrders(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 15, language));}
  
  if (client == "BNC" ){
    aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InternetAddress(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 16, language));
  }
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_BasedOnACriterion(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 17, language));
  aqObject.CheckProperty(Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariationModels(), "Header", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 18, language));  //Le board est renomée
  
}



