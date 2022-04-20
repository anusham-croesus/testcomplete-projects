//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : En tant que TCVE

                Je veux automatiser le Jira RPT-2060  pour le client SH 

                pour que ce Jira soit couvert par les tests de non regression du client steadyhand.
    Analyste d'assurance qualité :  Karima Mouzaoui
    Analyste d'automatisation : Ayaz Sana
    version de scriptage: 2020.07-63
    Date: 11/08/2020
    le dump utilisé est : SH_90.16.2020.7-63_2020-08-11_REF
*/

function RPT_2060_TCVE_2032_AutomatSavingPDFReportInTheDocumentTab()
{
   
    Log.Link("https://jira.croesus.com/browse/TCVE-2032", "Lien vers la story");
    Log.Link("https://jira.croesus.com/browse/TCVE-1982", "Lien vers le cas de test");

       
    try {
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var nameCritereStep2     = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "AnomalieRPT2060", "nameCritereStep2", language+client);
        var valueCritereTCVE2032 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "AnomalieRPT2060", "valueCritereTCVE2032", language+client);
        var reportName           = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "AnomalieRPT2060", "reportName", language+client);
        var destination          = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "AnomalieRPT2060", "destination", language+client);
        var checkArchiveRepport  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "AnomalieRPT2060", "checkArchiveRepport", language+client);
        var waitTimeLong         = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "AnomalieRPT2060", "waitTimeLong", language+client);

        Log.Message("Les préconditions")
        Log.Message("Pour désativer le naming convention il faut laisser à vide la PREF_PDF_NAMING_CONVENTION")
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_PDF_NAMING_CONVENTION", "", vServerReportsCR1485);
       
         
        Log.Message("delete from contentdata")
        var SQLQuery = "delete from CONTENTDATA";
        Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
        
         
        Log.Message("delete from .CONTENT_RELATIONSHIP_REFERENCE")
        var SQLQuery = "delete from .CONTENT_RELATIONSHIP_REFERENCE";
        Execute_SQLQuery(SQLQuery, vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
        /************************************Étape 1************************************************************************/     
        //Se connecter à croesus avec Keynej
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à l'application avec KEYNEJ");
        Login(vServerReportsCR1485, userNameKEYNEJ ,passwordKEYNEJ,language);
        /************************************Étape 2************************************************************************/     
       
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2:Atteindre le module Relation * Ajouter un critère de recherche liste des relations ayant une valeur totale supérieure à 0* Sélectionner plusieurs Relations (environ 100) puis cliquer sur Rapports et graphiques dans la bare de menu* Cliquer sur l'Onglet Rapport sauvegardés puis sélectionner le package Steadyhand Statement et le déplacer au côté droite de la fenêtre avec la petite flèche");
        //Choisir le module relation
        Log.Message("Choisir le module relation")
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
        Log.Message("Ajouter un critère de recherche liste des relations ayant une valeur totale supérieure à 1200 000")
        Log.Message("Pour que le script fonctionne il faut utiliser le dump :SH_90.16.2020.7-63_2020-08-11_REF qui se trouve dans BDRef")
        Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove().Click(); 
        //Création du critère de recherche 
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().Keys(nameCritereStep2);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(valueCritereTCVE2032);
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
        Log.Message("sélectionner toutes les relations générés par le critère de recherche: 61 relations")
        SelectAllMenuEdition()
         
        Log.Message("cliquer sur Rapports et graphiques dans la bare de menu")
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        Log.Message("Cliquer sur l'Onglet Rapport sauvegardés ")
        Get_Reports_GrpReports_TabSavedReports().Click();
        Get_Reports_GrpReports_TabSavedReports().WaitProperty("IsSelected", true, 20000);
        Log.Message("sélectionner le package Steadyhand Statement et le déplacer au côté droite de la fenêtre avec la petite flèche")
        SelectFirmSavedReport(reportName, true);
       /************************************Étape 3************************************************************************/    
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Dans Paramètres, établir les paramètres suivants:Destination: PDF fileCocher: Archiver les rapport.Cliquer sur OK pour produire les rapports et attendre la fin (100% dans la petite fenêtre de progression en bas à droite de la fenêtre)");

        SetReportsOptionsNew(destination, checkArchiveRepport, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null);

        Get_WinReports_BtnOK().WaitProperty("IsEnabled", true, 15000);
        Get_WinReports_BtnOK().Click();
      
        
          WaitObject(Get_MainWindow_StatusBar(), ["ClrClassName", "Text","VisibleOnScreen"], ["ClassicStatusBarContent", "100 %", true],waitTimeLong);
         
//      Pour fermer la fenêtre de progression  
        Log.Message("Fermeture de la fenêtre d'impression")
       Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10).Click();
       var arraytabGridClients =Get_Grid_ContentArray(Get_RelationshipsClientsAccountsGrid(), Get_RelationshipsGrid_ChRelationshipNo()); //Récuperer la grille dans un array
       var coloumnumrel=Get_ColumnFromGridArray(Get_RelationshipsGrid_ChName(), arraytabGridClients)
       for(n = 0; n < coloumnumrel.length; n++)
       {
         Log.Message("Le numéro de la ligne est "+n)
         Log.Message("Le nom de la relation est "+coloumnumrel[n])
         SearchRelationshipByName(coloumnumrel[n]);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", coloumnumrel[n], 10).DblClick();
         WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
         Get_WinDetailedInfo_TabDocuments().Click();  
         var contienDocum=Get_WinDetailInfo_TabDocu_LvwtDocu().HasItems  
         if(contienDocum ==  false)   
         {
           Log.Error("La partie Document est vide de la relation dont le nom est "+coloumnumrel[n])
           Log.Error("L'anomalie est : RPT2060")
		   Log.Message("Clic sur le bouton OK")
           Get_WinDetailedInfo_BtnOK().Click();
           return;
         }
         else
         Log.Checkpoint("La partie Document n'est vide de la relation dont le nom est "+coloumnumrel[n])
 
         Log.Message("Clic sur le bouton OK")
         Get_WinDetailedInfo_BtnOK().Click();
       }





        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
       // Initialiser la BD 
	     
          Delete_FilterCriterion(nameCritereStep2,vServerReportsCR1485) 
          
          Terminate_CroesusProcess();
    }
    
}

 

function SelectAllMenuEdition()
{
      SetAutoTimeOut(500);
        
        
          var  maxNbOfTries = 5;
            
        var nbOfTries = 0;
        do {
            Sys.Refresh();
            
            if (aqString.ToUpper("Click") == "CLICKR" || aqString.ToUpper("Click") == "CLICKR()")
                Get_MenuBar_Edit().ClickR();
            else if (aqString.ToUpper("Click") == "CLICK" || aqString.ToUpper("Click") == "CLICK()")
                Get_MenuBar_Edit().Click();
            else
                Get_MenuBar_Edit().Keys("Click");
        
        } while (++nbOfTries < maxNbOfTries && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
   
         Get_MenuBar_Edit_SelectAll().Click();
        
}
