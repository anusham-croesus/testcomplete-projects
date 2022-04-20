//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Tableau de bord », ajouter le tableau "Objectifs de placement - écarts" et vérifier les entêtes de colonne. */

function Survol_Dash_InvestmentObjectiveVariation()
{
var client ="BNC"
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click(); 
 
 
  WaitObject(Get_CroesusApp(), ["Uid", "Text", "VisibleOnScreen"], ["PadHeader_a99a", GetData(filePath_Dashboard, "Padheader", 2, language), true]);

  //Vider le tableau de bord et ajouter le tableau "Objectifs de placement - écarts"
  Clear_Dashboard();
  Get_Toolbar_BtnAdd().Click();
  Get_DlgAddBoard_TvwSelectABoard_InvestmentObjectiveVariation().Click(); //Le board est renomé
  Get_DlgAddBoard_BtnOK().Click();
  WaitObject(Get_CroesusApp(), ["BoardTitle","VisibleOnScreen"], [GetData(filePath_Dashboard, "Add_Board", 10, language), true]);
  
//  Delay(2000); 
  //Les points de vérification
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard(), "BoardTitle", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 2, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChCheckBoxOnOff(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 3, language)); //Checkbox (entête vide)
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 4, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChName(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 5, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChIACode(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 6, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChInvestmentObjective(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 7, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChVariation(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 8, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 9, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChCurrency(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 10, language));
  aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_ChAssignedTo(), "Content", cmpEqual, GetData(filePath_Dashboard, "InvestObjectiveVariationBoard", 11, language));
  
  //Fermer Croesus
  Close_Croesus_X();
}

