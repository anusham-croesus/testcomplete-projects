//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : À partir du module « Modeles », afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Quitter et vérifier que l’application a été fermée. */

function Survol_Mod_MenuBar_FileLock_BtnQuit()
{
  Login(vServerModeles, userName, psw, language);
  Get_ModulesBar_BtnModels().Click();
  Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Lock().Click();
  
  //Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
   
  //cliquer sur le btn Quitter
  Get_WinLockTheApplication_BtnQuit().Click();
  WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","WPFWindowContainer_7458")
  // Vérifier que l’application a été fermée
  //if(Get_MainWindow().Exists){
  //  Log.Error("The application was not closed");
  //} else {
  //  Log.Checkpoint("The application was closed");
  //}
}
