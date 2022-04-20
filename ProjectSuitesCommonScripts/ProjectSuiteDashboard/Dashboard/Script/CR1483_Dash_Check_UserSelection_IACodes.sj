//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Dash_Common_Functions


/**
    Module               :  Dashboard
    CR                   :  1483
    TestLink             :  Croes-3334
    Description          :  Vérifier que si on selectionne un utilisateur seulement les codes de CP de ce dernier sont affichés après ajout d'un client.
                            Valider le Jira FA-5532 (Valider le menu Utilisateur->Branch avec un  branch manager). [Auteur: Emna IHM]
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  03/12/2018
    
*/


function CR1483_Dash_Check_UserSelection_IACodes() 
{
  try{    
      var userNameDESOUST = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESOUST", "username");
      var passwordDESOUST = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESOUST", "psw");     
      
      Log.Message("** Se connercter avec DESOUST");
      Login(vServerDashboard, userNameDESOUST,passwordDESOUST,language);  
            
      //********************************** Étape 1 : FA-5532 Valider le menu Utilisateur->Branch avec un  branch manager. (Automatisé par Emna Ihm, Version: 2021.04-13 **************************************************************************/
      Log.AppendFolder("Étape 1: FA-5532 - Valider le menu Utilisateur->Branch avec un  branch manager.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/browse/TCVE-4948", "Cas de test sur Jira: TCVE-4948");
      Log.Link("https://jira.croesus.com/browse/FA-5532", "Lien de Jira: FA-5532");  
      //*************************************************************************************************************************************************************/
      var WndCaptionBranchSelection = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "CR1483", "WndCaptionBranchSelectionTCVE4948", language+client);
      var WndCaptionIsaacNewtonAllSelection = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "CR1483", "WndCaptionIsaacNewtonAllSelectionTCVE4948", language+client);
      var WndCaptionIsaacNewtonBD88Selection = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "CR1483", "WndCaptionIsaacNewtonBD88SelectionTCVE4948", language+client);
      var usernameIsaacNewton = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "CR1483", "usernameIsaacNewton", language+client);
      
      Log.Message("** Choisir le module Dashboard");
      Get_ModulesBar_BtnDashboard().Click();
      Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);  
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_b80f"); //POSITIVE CASH BALANCE SUMMARY BOARD     
      Get_MainWindow().Maximize();
      
      Log.Message("** Valider que le Dashboard s'affiche avec des données");
      aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_CalendarBoard_DgvBirthdays().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
            
      Log.Message("** Cliquer sur le menu Utilisateurs -> Succursale");
      Get_MenuBar_Users().Click();
      Get_MenuBar_Users_Branch().Click();
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_b80f"); //POSITIVE CASH BALANCE SUMMARY BOARD 
      
      Log.Message("** Module Dashboard: Valider que les données sont affichées après la sélection Utilisateurs -> Succursale");
      aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_CalendarBoard_DgvBirthdays().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
           
      Log.Message("** Module Dashboard: Valider le titre de la fenêtre Croesus avec la nouvelle selection");
      aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, WndCaptionBranchSelection);
      
      Log.Message("** Aller dans le module Comptes");
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071"); 
      
      Log.Message("** Module Comptes: Valider qu'il y a des données dans la grille comptes après la sélection Utilisateurs -> Succursale");
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      
      Log.Message("** Module Comptes: Valider le titre de la fenêtre Croesus");
      aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, WndCaptionBranchSelection);
      
      Log.Message("** Cliquer sur le menu Utilisateurs -> "+usernameIsaacNewton+" -> All");
      Get_MenuBar_Users().Click(); 
      Get_MenuBar_Users_UserName(usernameIsaacNewton).Click();
      Get_MenuBar_Users_UserName_All().Click();      
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071"); 
      
      Log.Message("** Module Comptes: Valider le titre de la fenêtre Croesus avec la nouvelle selection");
      aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, WndCaptionIsaacNewtonAllSelection);
      
      Log.Message("** Module Comptes: Valider qu'il y a des données dans la grille comptes après la sélection Utilisateurs -> Isaac Newton -> All");
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      
      Log.Message("** Module Dashboard: Valider que les données sont affichées dans module Dashboard");
      Get_ModulesBar_BtnDashboard().Click();
      Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);  
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_b80f"); //POSITIVE CASH BALANCE SUMMARY BOARD 
      aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_CalendarBoard_DgvBirthdays().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      
      Log.Message("** Module Dashboard: Valider le titre de la fenêtre Croesus");
      aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, WndCaptionIsaacNewtonAllSelection);
      
      Log.Message("** Cliquer sur le menu Utilisateurs -> "+usernameIsaacNewton+" -> BD88");
      Get_MenuBar_Users().Click(); 
      Get_MenuBar_Users_UserName(usernameIsaacNewton).Click();
      Get_MenuBar_Users_UserName_BD88().Click();      
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_b80f"); 
      
      Log.Message("** Module Dashboard: Valider le titre de la fenêtre Croesus avec la nouvelle selection");
      aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, WndCaptionIsaacNewtonBD88Selection);
      
      Log.Message("** Module Dashboard: Valider que les données sont affichées après la sélection Utilisateurs -> Isaac Newton -> BD88");
      aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      aqObject.CheckProperty(Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpGreater, 0);
      
      Log.Message("** Module Dashboard: Valider que les comptes avec code cp BD88 sont affichés dans le Dashboard");
            
      Log.Message("- Validation des codes CP pour la grille Positive Cash Balance Summary");
      CheckSelectedIACodes("BD88",Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1)); 
      Log.Message("- Validation des codes CP pour la grille Negative Cash Balance Summary");
      CheckSelectedIACodes("BD88",Get_Dashboard_NegativeCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1));
      Log.Message("- Validation des codes CP pour la grille Investment Objective Variation");
      CheckSelectedIACodes("BD88",Get_Dashboard_InvestmentObjectiveVariationBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1));
      Log.Message("- Validation des codes CP pour la grille Birthdays");
      CheckSelectedIACodes("BD88",Get_Dashboard_CalendarBoard_DgvBirthdays().WPFObject("RecordListControl", "", 1));       

      Log.Message("** Remettre le menu utilisateurs à Tous");
      Get_MenuBar_Users().Click(); 
      Get_MenuBar_Users_UserName(usernameIsaacNewton).Click();
      Get_MenuBar_Users_UserName_All().Click();      
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_b80f");      
      
      Log.PopLogFolder();
      
      //********************************** Étape 2 :  Vérifier que si on selectionne un utilisateur seulement les codes de CP de ce dernier sont affichés après ajout d'un client. **************************************************************************/
      Log.AppendFolder("Étape 2: Croes-3334 - Vérifier que si on selectionne un utilisateur seulement les codes de CP de ce dernier sont affichés après ajout d'un client.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3334","Lien du Cas de test sur Testlink Croes-3334"); 
      //*************************************************************************************************************************************************************/
      
       //Appel à la fonction Commune dans CR1483_Commun_Functions         
       CR1483_Check_UserSelection_IACodes(vServerDashboard,Get_ModulesBar_BtnDashboard(),"Copernic","BD88", "0AED");
       
       Log.PopLogFolder();
  }
  catch(e){
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally
  {
      //Fermer le processus Croesus
      Terminate_CroesusProcess();         
      Runner.Stop(true)
  }      
}