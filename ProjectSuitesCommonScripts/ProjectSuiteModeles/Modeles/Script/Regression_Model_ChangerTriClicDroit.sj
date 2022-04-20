//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2326

function Regression_Model_ChangerTriClicDroit()
{
    

  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().ClickR();
  Get_ModelsGrid_ContextualMenu_SortBy().HoverMouse();
  Get_ModelsGrid_ContextualMenu_SortBy_ModelNo().Click();
  
  var colonne = Get_ColumnFromGrid(Get_ModelsGrid_ChModelNo(), Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  var detected = "" + colonne;
  var expected = colonne.sort();
  if(Get_ModelsGrid_ChModelNo().SortStatus == "Ascending" && aqString.Compare(detected, expected, true) == 0)
    Log.Checkpoint("Le tableau est trié par numéro de modèle.");
  else
    Log.Error("Le tableau n'est pas trié par numéro de modèle.", "detected order: " + detected + "\r\nexpected order: " + expected);
  
  Get_ModelsGrid().ClickR();
  Get_ModelsGrid_ContextualMenu_SortBy().HoverMouse();
  Get_ModelsGrid_ContextualMenu_SortBy_Name().Click();
  
  
  
  colonne = Get_ColumnFromGrid(Get_ModelsGrid_ChName(), Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  detected = "" + colonne;
  expected = colonne.sort();
  Log.Message("la colonne detected" +detected)
  Log.Message("la colonne expected" +expected)

  if(Get_ModelsGrid_ChName().SortStatus == "Ascending" && aqString.Compare(detected, expected, true) == 0)
    Log.Checkpoint("Le tableau est trié par nom.");
  else
    Log.Error("Le tableau n'est pas trié par nom.", "detected order: " + detected + "\r\nexpected order: " + expected);
    Log.Message("detected: "+detected);
    Log.Message("expected: "+expected);
  
  Log.Message("Croesus tri les caractères spéciaux différemment; pas encore connu si c'est une erreur.");
  
  Close_Croesus_MenuBar();
}


//retourne la liste de valeurs de la colonne
//Column: la colonne dont on veut les valeurs
//grid: le composant de la grille, obtenu par une fonction Get
//IDColumn: la colonne toujours unique dans la grille
function Get_ColumnFromGrid(Column, grid, IDColumn, canUseHomeKey){return Get_ColumnFromGridArray(Column, Get_Grid_ContentArray(grid, IDColumn, canUseHomeKey));}

//retourne la liste de valeurs de la colonne (avec la grille déjà dans un array) sans les noms comportant des carractere speciaux du type "_" 
//Column: la colonne dont on veut les valeurs
//gridArray: la grille contenu dans un array obtenu avec Get_Grid_ContentArray
function Get_ColumnFromGridArray(Column, gridArray)
{
  var index = Get_ColumnIndex(Column);
  var colArray = [];
  for(n = 0; n < gridArray.length; n++)
     if(aqString.contains(gridArray[n][index],"_")==-1 ){
         colArray.push(gridArray[n][index]);
     }
   
  return colArray;
}