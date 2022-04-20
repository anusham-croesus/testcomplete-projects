//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_ContextualMenu_Edit

 /* Description :Dans le du module « Modeles », rechercher un Modèle ~M-00002-0, afficher la fenêtre « Modèle Info » Par ContextualMenu - Functions-Info. 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_ContextualMenu_Functions_Info()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_TestedModel();
  
  Get_MainWindow().Keys("[Apps]")
  Get_ModelsGrid_ContextualMenu_Functions().Click()
  Get_ModelsGrid_ContextualMenu_Functions_Info().Click()
   
  //Les points de vérification en français 
   //if(language=="french"){Check_Properties_French()}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit(Info)
   //Les points de vérification en anglais 
    //else {Check_Properties_English()}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit(Info)
    
  //Check_Existence_Of_Controls();// la fonction est dans le script Survol_Mod_ContextualMenu_Edit (Info) 
  
  ClickToClose_WinModelInfo(); // la fonction est dans le script Survol_Mod_ContextualMenu_Edit (Info) 
  
  Close_Croesus_AltQ()
}