//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT BNC_1689_CrashWhenDeletNewlyCreatSearchCriteriaInTheTitlemodule


/**
        Description : 
                  
                      1. Se connecter avec UNI00 
                      2. Aller au module titres 
                      3. Sélectionner un titre/Info/Historique de prix/Filtrer (exemple: 
                      Champ: Date, Opérateur: est parmi les derniers, valeur: n/d) puis Appliquer 

                      Résultat reçu 
                      L'application crash

    Auteur : Sana Ayaz
    Anomalie:CROES-7801
    Version de scriptage:ref90-05-14--V9-AT_1-co6x
   
*/
  function CROES_7801_CrashWhenFilteringOperatorHistoricalPriceDividendHistoryFilters()
  {
      try {
        
        
          userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
          passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
         
          Login(vServerTitre, userNameUNI00, passwordUNI00, language);
          
       
          var DescrSecurityCROES_7801=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "DescrSecurityCROES_7801", language+client);
          var ValeurFiltreCROES_7801=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "ValeurFiltreCROES_7801", language+client);
          var NumberTheBug_CROES_7801=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "NumberTheBug_CROES_7801", language+client);
         
          
          Get_ModulesBar_BtnSecurities().Click();
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); //EM : pour supprimer tous les filtres
          Search_SecurityByDescription(DescrSecurityCROES_7801)
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_7801,10).Click();
          
          Get_SecuritiesBar_BtnInfo().Click();
         
          
          Get_WinInfoSecurity_TabPriceHistory().Click();
          
          //if(client == "RJ"){ // EM : 90-07-23-RJ-CO : chercher position de QuickFilter car pas d'Uid 
           var width=(Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).Width - Get_WinInfoSecurity_TabPriceHistory_Grid().Width)/10;
           var height =(Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).Height - Get_WinInfoSecurity_TabPriceHistory_Grid().Height)/2;
           Get_WinInfoSecurity_TabPriceHistory_Grid().Click(width, height);
          /*}else 
            Get_WinInfoSecurity_TabPriceHistory_Grid().Click(Get_WinInfoSecurity_TabPriceHistory_Grid().Width - 664, Get_WinInfoSecurity_TabPriceHistory_Grid().Height - 288);*/ //EM: 90.09.Er-9 : Position a été changé suite à l'ajout des champs RQS dans la fenêtre.
           
          Get_WinInfoSecurity_TabPriceHistory_Grid_BtnQuickFilters_ContextMenu_Date().Click()
          Get_WinCreateFilter_CmbOperator().Click()
          Get_WinCRUFilter_CmbOperator_ItemIsWithinTheLast().Click()
          Get_WinCreateFilter_TxtValueDouble().Keys(ValeurFiltreCROES_7801)
          Get_WinCreateFilter_BtnApply().Click()
          //Les points de vérification 
          
          CheckPointForCrash(NumberTheBug_CROES_7801);
         Log.Message(" CROES-7801")
         Get_WinInfoSecurity_BtnCancel();
         
         
          
      }
      catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
          Terminate_CroesusProcess();
         
        
      }
  }
function Test(){
    var width=(Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).Width - Get_WinInfoSecurity_TabPriceHistory_Grid().Width)/10;
    var height =(Get_WinInfoSecurity().FindChild("Uid", "TabControl_eced", 10).Height - Get_WinInfoSecurity_TabPriceHistory_Grid().Height)/2;
    Get_WinInfoSecurity_TabPriceHistory_Grid().Click(width, height);
    //Get_WinInfoSecurity_TabPriceHistory_Grid().Click(Get_WinInfoSecurity_TabPriceHistory_Grid().Width - 664, Get_WinInfoSecurity_TabPriceHistory_Grid().Height - 288);
}