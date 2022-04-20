//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Survol_Mod_Details_Assign_Accounts

/* Description : Aller au module "Modeles". Afficher la fenêtre "Relations" en cliquant sur Assigner -Relation dans la partie « détail»
 Vérifier la présence des contrôles et des étiquetés  */
 
 function Survol_Mod_Details_Assign_Relationships()
 {
  var type="relationship";
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
  
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click()
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click()

   
   //Les points de vérification en français 
  if(language=="french"){Check_Properties_French(type)}  // la fonction est dans Survol_Mod_Details_Assign_Accounts
  //Les points de vérification en anglais 
  else {Check_Properties_English(type)}   // la fonction est dans Survol_Mod_Details_Assign_Accounts
  
  Check_Existence_Of_Controls() // la fonction est dans Survol_Mod_Details_Assign_Accounts
     
  Get_WinPickerWindow_BtnCancel().Click()
        
  Get_MainWindow().SetFocus();
  Close_Croesus_X()  
 }