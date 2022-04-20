//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module: Titres
    Security_module_Info_Additional tab Rating appears for MF securities, although it was not displayed in V9 Core application
    Description: Onglet "ratings" apparait pour tous les titres même si la pref_enable_risk_rating = NO
                 Ici il faut noter qu'actuellement la pref_enable_risk_rating n'as pas les valeurs YES/NO
                 mais elle a les valeurs:
                 0 :  l'onglet s'affiche uniquement pour les titres qui ont un instrument financier = Obligation
                 1 :  l'onglet s'affiche pour tous les titres
                 2 :  l'onglet s'affiche uniquement pour les titres qui ont un instrument financier = Obligation

    Auteur :                Abdel Matmat
    Anomalie:               CROES-5760
    Version de scriptage:	90-08-Dy-8
    
*/


function CROES_5760_RatingsTabAppearsForAllSecuritiesEvenIfPref_enable_risk_ratingIsNO() {
          
          try {
                    //Lien Jira
                    Log.Link("https://jira.croesus.com/browse/CROES-5760", "Cas de tests JIRA CROES-5760");
                    
                    //Mettre la pref_enable_risk_rating à 1 
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_RISK_RATING","1",vServerTitre);
                    RestartServices(vServerTitre);
                    
                    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
                    var Column = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "CROES_5760_ColumnAdd", language+client);
                    var Obligation = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "CROES_5760_Obligation", language+client);
                    var NotObligation = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "CROES_5760_NotObligation", language+client);
                    
                    Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Ajouter la colonne Instrument financier
                    AddColumn(Get_SecurityGrid_ChAsk(),Column);
                    
                    //Selectionner un titre qui a Instrument financier = Obligation, Accéder à la fenetre Info et vérifier l'onglet Rating ou Cotations
                    CheckObligationRatingTab(Obligation);                   
                    
                    //Selectionner un titre qui a Instrument financier différent de Obligation, Accéder à la fenetre Info et vérifier l'onglet Rating ou Cotations 
                    
                    CheckNotObligationRatingTabPref1(NotObligation);
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
                    //Mettre la pref_enable_risk_rating à 2 
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_RISK_RATING","2",vServerTitre);
                    RestartServices(vServerTitre);
                    
                    Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Ajouter la colonne Instrument financier
                    AddColumn(Get_SecurityGrid_ChAsk(),Column);
                    
                    //Selectionner un titre qui a Instrument financier = Obligation, Accéder à la fenetre Info et vérifier l'onglet Rating ou Cotations
                    CheckObligationRatingTab(Obligation);                   
                    
                    //Selectionner un titre qui a Instrument financier différent de Obligation, Accéder à la fenetre Info et vérifier l'onglet Rating ou Cotations 
                    
                    CheckNotObligationRatingTabPref2(NotObligation);
                    
         
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    
                   
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
          }
}


  function AddColumn(columClickR,Column){
      columClickR.ClickR();
      columClickR.ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
  
      var SubMenu = Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1);
      var count = SubMenu.DataContext.Items.Item(0).Items.Count;
      Log.Message(count);
      for (i=0; i<count; i++)
      {
          var item = SubMenu.DataContext.Items.Item(0).Items.Item(i);
          if (item.Label == Column)
          {
              SubMenu.Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", i+1], 100).Click();
              break;
          }
      } 
  }

function CheckObligationRatingTab(FinInstr)
{
    Get_SecurityGrid().Find(["ClrClassName","Value"],["XamTextEditor",FinInstr],10).Click();
    Get_SecurityGrid().Find(["ClrClassName","Value"],["XamTextEditor",FinInstr],10).DblClick();
    WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
    if (Get_WinInfoSecurity_TabRatings().VisibleOnScreen){
            Log.Checkpoint("L'onglet Rating existe dans la fenêtre Info");
            Get_WinInfoSecurity_TabRatings().Click();
            }
    else
            Log.Error("L'onglet Rating n'existe pas dans la fenêtre Info");
    
    Get_WinInfoSecurity_BtnCancel().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
}

function CheckNotObligationRatingTabPref1(FinInstr)
{
    Get_SecurityGrid().Find(["ClrClassName","Value"],["XamTextEditor",FinInstr],10).DblClick();
    WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
    if (Get_WinInfoSecurity_TabRatings().VisibleOnScreen){
            Log.Checkpoint("L'onglet Rating existe dans la fenêtre Info");
            Get_WinInfoSecurity_TabRatings().Click();
            }
    else
            Log.Error("L'onglet Rating doit apparaitre dans la fenêtre Info");
    
    Get_WinInfoSecurity_BtnCancel().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
}

function CheckNotObligationRatingTabPref2(FinInstr)
{
    Get_SecurityGrid().Find(["ClrClassName","Value"],["XamTextEditor",FinInstr],10).DblClick();
    WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
    if (Get_WinInfoSecurity_TabRatings().VisibleOnScreen){
            Log.Error("L'onglet Rating ne doit pas apparaitre dans la fenêtre Info");
            }
    else
            Log.Checkpoint("L'onglet Rating n'existe pas dans la fenêtre Info");
    
    Get_WinInfoSecurity_BtnCancel().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
}
