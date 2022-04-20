//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Rel_MenuBar_EditSum

/* Description : A partir du module « Relations » , afficher la fenêtre « Sommation des titres » avec AltS . 
 Vérifier la présence des contrôles et des étiquetés */ 

function Survol_Rel_MenuBar_EditSum()
{
  Login(vServerRelations,userName,psw,language);
  Get_ModulesBar_BtnRelationships().Click();
  Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
  Get_MainWindow().Keys("~s")
    
  //Les points de vérification 
  //Check_Properties(language) //la fonction est dans Survol_Rel_MenuBar_EditSum
    
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_AltF4();
}