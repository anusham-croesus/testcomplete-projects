//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Création du filtre temporaire a partir de l'icone (Y) en haut a gauche de la grille
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1460
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1460_Cli_Create_TempCPFilter_Icon_Y()
 {
   var filtre = "BD88";
   
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre « Ajouter un filter » en cliquant l'icone (Y) en haut a gauche
   Get_RelationshipsClientsAccountsGrid().Click(10,10);
   Get_RelationshipsClientsAccountsGrid().Click(10,10);
   Get_Toolbar_BtnQuickFilters_ContextMenu_IACode().Click();     
   
   Create_TemporaryCPFilter(filtre);//la fonction est dans CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
   
   Get_MainWindow().SetFocus();
   Close_Croesus_SysMenu();
 }
 
