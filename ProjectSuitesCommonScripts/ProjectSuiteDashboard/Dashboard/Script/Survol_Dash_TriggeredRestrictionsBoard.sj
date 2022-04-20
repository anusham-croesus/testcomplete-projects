//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Tableau de bord », ajouter le tableau "Restrictions déclenchées" et vérifier les entêtes de colonne. */

function Survol_Dash_TriggeredRestrictionsBoard()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  //Vider le tableau de bord et ajouter le tableau "Restrictions déclenchées"
  Clear_Dashboard();
  Get_Toolbar_BtnAdd().Click();
  Get_DlgAddBoard_TvwSelectABoard_TriggeredRestrictions().Click();
  Get_DlgAddBoard_BtnOK().Click();
  
  //Les points de vérification
  aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard(), "BoardTitle", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 2, language));
  //aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChCheckBoxOnOff(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 3, language));// Checkbox (entête vide)
  //aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChAccountTypeIcon(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 4, language)); Image (entête vide)
  if (Get_Dashboard_TriggeredRestrictionsBoard().DataGrid.DataSource.Count != 0){
      if (client == "BNC" ){
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChNumber(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 5, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChName(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 6, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChRestriction(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 7, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChParameters(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 8, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChCurrentlyHeld(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 9, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChCurrency(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 10, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 11, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChIACode(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 12, language));
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_ChAssignedTo(), "Content", cmpEqual, GetData(filePath_Dashboard, "TriggeredRestrictionsBoard", 13, language));
      }
  }
  else{
        if (Get_Dashboard_TriggeredRestrictionsBoard_ChNumber().Exists)
            Log.Error("Les entêtes de colonne ne devraient pas être visibles lorsque la grille est vide!")
         else
            Log.Checkpoint("La grille est vide (Aucune donnée a afficher) : On peut pas alors valider les entêtes car ils ne s'affichent pas.")
  }
  //Fermer Croesus
  Close_Croesus_X();
}
