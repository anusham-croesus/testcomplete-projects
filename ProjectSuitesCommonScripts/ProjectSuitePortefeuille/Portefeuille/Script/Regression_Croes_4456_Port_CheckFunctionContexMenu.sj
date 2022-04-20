//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Valider le Menu contextuel du module Portefeuille
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4456
    Analyste d'assurance qualité : Isabelle 
    Analyste d'automatisation : Alhassane
    Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_4456_Port_CheckFunctionContexMenu()
{
    try {
        
       //Variables
       
       var client800300= ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "client800300", language+client);
       var pos_R76899 =  ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "pos_R76899", language+client);
       
       var cm_modif_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_modif_4456", language+client);
       var cm_detail_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_detail_4456", language+client);
       var cm_copier_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_copier_4456", language+client);
       var cm_co_avec_entete_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_co_avec_entete_4456", language+client);
       var cm_export_fichier_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_export_fichier_4456", language+client);
       var cm_eport_excel_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_eport_excel_4456", language+client);
       var cm_info_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_info_4456", language+client);
       var cm_ajout_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_ajout_4456", language+client);
       var cm_gerer_liq_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_gerer_liq_4456", language+client);
       var cm_gerer_pos_bloque = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_gerer_pos_bloque", language+client);
       var cm_trier_par_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_trier_par_4456", language+client);
       var cm_fonction_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_fonction_4456", language+client);
       var cm_grouper_par_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_grouper_par_4456", language+client);
       var cm_imprimer_4456 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_imprimer_4456", language+client);
       var cm_exclure_proj_liquidite = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_exclure_proj_liquidite", language+client);
       var cm_inclure_proj_liquidite = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_inclure_proj_liquidite", language+client);
       var cm_bloquer_position = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_bloquer_position", language+client);
       var cm_debloquer_position = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cm_debloquer_position", language+client);


 
 


       //Lien Testlink        
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4456","Lien testlink - Croes-4456");
        
        //Login
        Log.Message("******************** Login *******************")
        Login(vServerPortefeuille, userName, psw, language);
        
        
    
        
        
        
        //Sélectionner le client 800300 et mailler vers module portefeuille
        Log.Message("*********Sélectionner le client 800300 et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client800300);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client800300,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
        //Selectionner la position CDN TIRE (R76899) et faire un clique droit pour  ouvrir le menu contextuel
         Log.Message("********* Selectionner la position "+pos_R76899+" et faire un cliquer droit pour  ouvrir le menu contextuel********")
         Search_Position(pos_R76899)
         Get_Portfolio_PositionsGrid().Find("Value",pos_R76899 ,10).Click();
         Get_Portfolio_PositionsGrid().Keys("[Apps]");
         
        //Valider les different options offert par le menu contextuel
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_SubMenus().Exists){
          Get_Portfolio_PositionsGrid().Keys("[Apps]");
          numberOftries++;
           } 
        //Les points de vérification pour Edit 
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Edit(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Edit(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Edit(), "WPFControlText", cmpEqual,cm_modif_4456);
       
        //Les points de vérifications pour Detail
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Detail(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Detail(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Detail(), "WPFControlText", cmpEqual, cm_detail_4456);
        
        //Les points de vérifications pour Copier
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Copy(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Copy(), "Visible", cmpEqual, true);
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Copy(), "WPFControlText", cmpEqual, cm_copier_4456);
        
        //Les points de vérifications pour Copier avec en-tête
        
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_CopyWithHeader(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_CopyWithHeader(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_CopyWithHeader(), "WPFControlText", cmpEqual, cm_co_avec_entete_4456);
        
        
        //Les points de vérifications pour Exporter vers fichier
        
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ExportToFile(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ExportToFile(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ExportToFile(), "WPFControlText", cmpEqual, cm_export_fichier_4456);
        
        //Les points de vérifications pour Exporter vers MS Excel
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ExportToMSExcel(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ExportToMSExcel(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ExportToMSExcel(), "WPFControlText", cmpEqual, cm_eport_excel_4456);
        
        
       //Les points de vérifications pour Info... 
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Info(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Info(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Info(), "WPFControlText", cmpEqual, cm_info_4456);
       
       //Les points de vérifications pour Ajouter une note
       
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_AddANote(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_AddANote(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_AddANote(), "WPFControlText", cmpEqual, cm_ajout_4456);
       
     //Les points de vérifications pour Gérer proj. liquidités
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome(), "WPFControlText", cmpEqual, cm_gerer_liq_4456);
     
     //Les points de vérifications pour gérer les positions bloquées
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions(), "WPFControlText", cmpEqual, cm_gerer_pos_bloque);
     
     //Les points de vérifications pour Trier par
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_SortBy(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_SortBy(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_SortBy(), "WPFControlText", cmpEqual, cm_trier_par_4456);
     
     //Les points de vérifications pour Fonctions   
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Functions(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Functions(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Functions(), "WPFControlText", cmpEqual, cm_fonction_4456);
     
         //Les points de vérifications pour Grouper par
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_GroupBy(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_GroupBy(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_GroupBy(), "WPFControlText", cmpEqual, cm_grouper_par_4456);
        
     
        //Les points de vérifications pour Imprimer
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Print(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Print(), "Visible", cmpEqual, true);
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_Print(), "WPFControlText", cmpEqual, cm_imprimer_4456);
      
     
         //Cliquer sur l'option Gérer les positions bloqués du menu contextuel pour le submenu valider bloquer ou debloquer la position
         Log.Message("********* Cliquer sur l'option Gérer les positions bloqués du menu contextuel pour le submenu valider bloquer ou debloquer la position********")  
         Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click(); 
     
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition(), "WPFControlText", cmpEqual, cm_bloquer_position);
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition(), "Enabled", cmpEqual, true);
        
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition(), "WPFControlText",cmpEqual, cm_debloquer_position);
         aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition(), "Enabled", cmpEqual, true);
         
     
     
       //Cliquer sur l'option Gérer gérer proj.liquidités du menu contextuel pour valider inclure et exclure la position de la projection de liquidité
         Log.Message("********* Cliquer sur l'option Gérer gérer proj.liquidités du menu contextuel pour valider inclure et exclure la position de la projection de liquidité********")   

        Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome().Click()

       
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome_ExcludeFromProjectedIncome(), "WPFControlText", cmpEqual, cm_exclure_proj_liquidite);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome_ExcludeFromProjectedIncome(), "Enabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome_IncludeInProjectedIncome(), "WPFControlText", cmpEqual, cm_inclure_proj_liquidite);
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome_IncludeInProjectedIncome(), "Enabled", cmpEqual, true);
      
//        
        
        //Fermer Croesus
          Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
} 


 
function Get_PortfolioGrid_ContextualMenu_Edit() //uid est le même que pour ajout et ne pointe pas sur edit
{
  if (language=="french"){return Get_CroesusApp().Find("WPFControlText", "_Modifier...", 10)}
  else {return Get_CroesusApp().Find("WPFControlText", "_Edit...", 10)}
}
    
