//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Comptes » , afficher la fenêtre « Print » en cliquant sur MenuBar - btnPrint. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

function Survol_Acc_MenuBar_FilePrint()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Print().Click();
  
  Check_Print_Properties(); //la fonction est dans Common_functions
  
  Get_DlgInformation().Click(93, 66);

  Close_Croesus_AltF4();
}

function test(){
  
  Get_DlgInformation().Click(93, 66);

}