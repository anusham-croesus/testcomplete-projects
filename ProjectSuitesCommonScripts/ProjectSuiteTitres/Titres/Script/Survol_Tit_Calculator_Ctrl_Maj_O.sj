//USEUNIT CommonCheckpoints
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions

/* Description : A partir du module « Titre » ,Rechercher le titre 101750 et afficher la fenêtre « Calculatrice d'obligations » avec Ctrl+Maj+O. 
 Vérifier la présence des contrôles et des étiquetés  */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-335
 function Survol_Tit_Calculator_Ctrl_Maj_O()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click();
  
  Search_Security("101750");
  
  Get_SecurityGrid().Keys("^O");
    
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans CommonCheckpoints
     
   //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans CommonCheckpoints
   
   Check_BondCalculator_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
     
  Get_WinBondCalculator_BtnClose().Click(); 
        
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();  
 }
 
 
 