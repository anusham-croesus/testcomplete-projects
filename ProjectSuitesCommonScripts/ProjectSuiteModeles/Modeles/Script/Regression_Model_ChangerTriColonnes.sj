//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2347

function Regression_Model_ChangerTriColonnes()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid_ChName().Click();
  var colonne = Get_ColumnFromGrid(Get_ModelsGrid_ChName(), Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  var detected = "" + colonne;
  var expected = colonne.sort().reverse();
  if(Get_ModelsGrid_ChName().SortStatus == "Descending" && aqString.Compare(detected, expected, true) == 0)
    Log.Checkpoint("Le tableau est trié par nom.");
  else
    Log.Error("Le tableau n'est pas trié par nom.", "detected order: " + detected + "\r\nexpected order: " + expected);
  Log.Message("Croesus tri les caractères spéciaux différemment; pas encore connu si c'est une erreur.");
  
  Get_ModelsGrid_ChUnderlyingTotalValue().Click();
  colonne = Get_ColumnFromGrid(Get_ModelsGrid_ChUnderlyingTotalValue(), Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  for(n = 0; n < colonne.length; n++)
    colonne[n] = convertToNumber(colonne[n]);
  detected = "" + colonne;
  expected = colonne.sort(sortingNumbers);
  if(Get_ModelsGrid_ChUnderlyingTotalValue().SortStatus == "Ascending" && aqString.Compare(detected, expected, true) == 0)
    Log.Checkpoint("Le tableau est trié par valeur totale.");
  else
    Log.Error("Le tableau n'est pas trié par valeur totale.", "detected order: " + detected + "\r\nexpected order: " + expected);
  
  Get_ModelsGrid_ChCurrency().Click();
  colonne = Get_ColumnFromGrid(Get_ModelsGrid_ChCurrency(), Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  detected = "" + colonne;
  expected = colonne.sort();
  if(Get_ModelsGrid_ChCurrency().SortStatus == "Ascending" && aqString.Compare(detected, expected, true) == 0)
    Log.Checkpoint("Le tableau est trié par devise.");
  else
    Log.Error("Le tableau n'est pas trié par devise.", "detected order: " + detected + "\r\nexpected order: " + expected);
  
  Close_Croesus_MenuBar();
}

function sortingNumbers(a, b)
{
	if(a == b) return 0;
    if(a < b) return -1;
    if(a > b) return 1;
    return 0;
}

function convertToNumber(textValue)
{
  if(aqString.StrMatches("^\\(\\d?\\d?\\d( |\\,\\d\\d\\d)*\\,|\\.\\d\\d+\\)$", textValue))
    textValue = "-" + aqString.Replace(aqString.Replace(textValue, "(", "", true), ")", "", true);
  var regex;
  if(language == "french")
    regex = "^\\d?\\d?\\d( \\d\\d\\d)*\\,\\d\\d+$";
  else
    regex = "^\\d?\\d?\\d(\\,\\d\\d\\d)*\\.\\d\\d+$";
  
  if(aqString.StrMatches(regex, textValue))
    if(language == "french")
      return aqConvert.StrToFloat(aqString.Replace(aqString.Replace(textValue, " ", ""), ",", "."));
    else
      return aqConvert.StrToFloat(aqString.Replace(textValue, ",", ""));
  return textValue;
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