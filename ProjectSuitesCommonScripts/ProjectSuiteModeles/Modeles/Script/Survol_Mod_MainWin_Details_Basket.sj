//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_MainWin_Details_FirmModel

/* Description : Aller au module "Modeles". Vérifier la présence des contrôles, des étiquetés et des en-têtes de colonnes  
dans la partie de détail, en cliquant sur chaque onglet  */

function Survol_Mod_MainWin_Details_Basket()
{
  if (client == "BNC" ){
     var type="basket"
     Login(vServerModeles, userName , psw ,language);
     Get_ModulesBar_BtnModels().Click()
   
     if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Model("~M-0000P-0")}
     else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
   
     //Les points de vérification en français 
     if(language=="french"){ Check_Properties_French(type)} //Survol_Mod_MainWin_Details_FirmModel
     //Les points de vérification en anglais 
     else {Check_Properties_English(type)}//Survol_Mod_MainWin_Details_FirmModel
   
     Check_Existence_Of_Controls()//Survol_Mod_MainWin_Details_FirmModel
 
     Close_Croesus_AltF4()
     Sys.Browser("iexplore").Close()
  }
}