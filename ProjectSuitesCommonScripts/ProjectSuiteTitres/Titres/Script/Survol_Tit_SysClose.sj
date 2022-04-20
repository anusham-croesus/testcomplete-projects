//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_AltF4

//Description : Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' contenant les boutons Info, Données historiques, Total détenu, Taux de change  
//Fermêture de l’application par SysClose
// Lien cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-315
function Survol_Tit_SysClose()
{
   Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Tit_AltF4
   
   //Les points de vérification en anglais 
   else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_AltF4
   
  Close_Croesus_SysMenu()
}