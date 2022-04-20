//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Description :Valider les infos des colonnes: Acheteur, Cloture et Vendeur dans le module Titre.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6253
    Version de scriptage : 	ref90-10-12--V9-croesus-co7x-1_5_565
    Analyste d'assurance qualité :carolet
    Analyste d'automatisation : Asma Alaoui
*/

function CR1446_6253_Tit_ValidateInformationInBidAskCloseColumns()
{
  try { 
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6253", "CR1446_6253_Tit_ValidateInformationInBidAskCloseColumns()");
   
      var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
      var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      
      var SecuFirme=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "SecuFirme", language+client);
      var valeur=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "valeur", language+client);
      var date=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "date", language+client);
           
      // Se connecter avec KEYNEJ
      Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
      //Aller dans le module titre
      Get_ModulesBar_BtnSecurities().Click();
      Get_MainWindow().Maximize();
      //Retablir la configuration initila des colonnes
       Log.Message("Restore columns default configuration.");
      Get_SecurityGrid_ChDescription().ClickR();
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
       //sélectionner le titre 075235 
      Search_Security(SecuFirme);
      //valider pour les valeurs dans Acheteur, Vendeur et  Clôture sont non déterminés pour le titre 075235
      PrixAchteurDisplay =Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild("Uid","BidPrice", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
      Log.Message(PrixAchteurDisplay);
      CheckEquals(PrixAchteurDisplay,valeur, "La valeur Acheteur est a :" +valeur);
      
      VendeurDisplay =Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild("Uid","AskPrice", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;   
      Log.Message(VendeurDisplay);
      CheckEquals(VendeurDisplay ,valeur, "La valeur Vendeur est a :" +valeur);
      
      ClotureDisplay=Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild("Uid","ClosePrice", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
      Log.Message(ClotureDisplay);
      CheckEquals(ClotureDisplay ,valeur, "La valeur Clôture est a :" +valeur);
      //cliquer sur Info
      Get_SecuritiesBar_BtnInfo().Click();
      
      
      //valider dans la section Prix de l'onglet Info les valeurs pour Acheteur, Vendeur et  Clôture les valeurs sont non déterminés
      Get_WinInfoSecurity_TabInfo().Click();
      aqObject.CompareProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Text,cmpEqual, valeur, true)
      aqObject.CompareProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Text,cmpEqual, valeur, true)
      aqObject.CompareProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Text,cmpEqual, valeur, true)
      
      //dans l'onglet historique des prix  valider pour la date 2010/01/25 les prix pour Acheteur, Vendeur et  Clôture les valeurs sont non déterminés
      Get_WinInfoSecurity_TabPriceHistory().Click();
      HistoAchteurDisplay =Get_WinInfoSecurity_TabPriceHistory_Grid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild("Uid","BidPrice", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
      Log.Message(HistoAchteurDisplay);
      CheckEquals(HistoAchteurDisplay, valeur, "La valeur Acheteur est a :" +valeur);
      
      HistoVendeurDisplay =Get_WinInfoSecurity_TabPriceHistory_Grid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild("Uid","AskPrice", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;   
      Log.Message(HistoVendeurDisplay);
      CheckEquals(HistoVendeurDisplay ,valeur, "La valeur Vendeur est a :" +valeur);
      
      HistoClotureDisplay=Get_WinInfoSecurity_TabPriceHistory_Grid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild("Uid","ClosePrice", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
      Log.Message(HistoClotureDisplay);
      CheckEquals(HistoClotureDisplay ,valeur, "La valeur Clôture est a :" +valeur);
      
      //Cliquer sur le bouton modifier
      if (client != "CIBC"){      //LE BOUTTON MODIFIER N'EXISTE PAS POUR CIBC 
          Get_WinInfoSecurity_TabPriceHistory_BtnEdit().Click()
           
          //valider les valeurs les pour Acheteur, Vendeur et  Clôture les valeurs sont non déterminés    
          aqObject.CompareProperty(GetWinEditHistoricalDataTxtBid().Text,cmpEqual, valeur, true)
          aqObject.CompareProperty(GetWinEditHistoricalData_TxtAsk().Text,cmpEqual, valeur, true)
          aqObject.CompareProperty(GetWinEditHistoricalData_TxtClose().Text,cmpEqual, valeur, true)
  
      //fermer la fenêtre
      GetWinEditHistoricalData_BtnCancel().Click();
      }
      Get_WinInfoSecurity_BtnCancel().Click();
      
      //Ajouter un critère actif
      Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();   
      //Sur "Definition" modifier <Verbe> à "ayant"
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
      //Sur <Champ> choisir "Informatif" ensuite " prix non déterminé"
      Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_nonDeterminablePrice().HoverMouse();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_nonDeterminablePrice().Click();
      //Sur <Opérateur> choisir "égal(e) à
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
      //choisir "OUI" dans valeur
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();
      //Sur <Suivant> Choisir "."
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click()
      //Sauvgarder les changements
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
      //valider le titre 075235
      Delay(15000)
      Search_Security(SecuFirme);
      var SecuFirmeCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild(["Uid", "Value"], ["SecuFirm", SecuFirme], 10);
      if (!SecuFirmeCell.Exists)
      Log.Error("Le Titre No '" + SecuFirme + "' n'a pas été trouvé.");
      else
      Log.Checkpoint("le titre NO '"+ SecuFirme+ "' est affiché")
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      
      
  }
  catch(e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
       Terminate_CroesusProcess();
       Delete_FilterCriterion(SecuFirme,vServerTitre)
       RestartServices(vServerTitre);      
  }
    
    finally {   
     
     Delete_FilterCriterion(SecuFirme,vServerTitre)//Supprimer le criterion de BD      
     Terminate_CroesusProcess(); //Fermer Croesus
     RestartServices(vServerTitre);
  }

}
 
      