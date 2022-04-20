//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Se connecter avec GP1859 
 Sélectionner le titre 100THS-WINBURY MTG PFD A ( fond d'investissement ) 
 Modifier le Prix Acheteur 
 Résultat obtenu 
 On affiche "n/dét." dans la colonne Acheteur 
 Voir fichier joint .

    Auteur : Sana Ayaz
    Anomalie:CROES-8902
    Version de scriptage:ref90-06-06
   
*/
  function CROES_8902_ProblemInChangingTheBuyerFieldInTitleInfo()
  {
      try {
        
        
          userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
          passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
          //Se connecter avec KEYNEJ
          Activate_Inactivate_Pref("GP1859","PREF_EDIT_REAL_SECURITY","YES",vServerTitre)
          RestartServices(vServerTitre);  
          Login(vServerTitre, userNameGP1859, passwordGP1859, language);
          
       
          var DescrSecurityCROES_8902=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "DescrSecurityCROES_8902", language+client);
          var PrixAcheteurCROES_8902=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "PrixAcheteurCROES_8902", language+client);
          var PrixAcheteurCROES_8902Plus7chiffres=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "PrixAcheteurCROES_8902Plus7chiffres", language+client);
          var PrixAcheteurExcelCROES_8902=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "PrixAcheteurExcelCROES_8902", language+client);
          var PrixAcheteurInitialCROES_8902=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "PrixAcheteurInitialCROES_8902", language+client);
          
          Get_ModulesBar_BtnSecurities().Click();
          Search_SecurityByDescription(DescrSecurityCROES_8902)
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_8902,10).Click();
          
          Get_SecuritiesBar_BtnInfo().Click();
          WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
         
          Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Click();
          Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().set_Text(PrixAcheteurCROES_8902)
         
         
          Get_WinInfoSecurity_BtnOK().Click()
          Search_SecurityByDescription(DescrSecurityCROES_8902)
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_8902,10).Click();
          var PrixAchteurDisplay =Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter",8], 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
          Log.Message(PrixAchteurDisplay)
          CheckEquals(PrixAchteurDisplay,PrixAcheteurExcelCROES_8902, "Le prix acheteur est est a n/dét.")
          Log.Message(" CROES_8902")
          Search_SecurityByDescription(DescrSecurityCROES_8902)
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_8902,10).Click();
          Get_SecuritiesBar_BtnInfo().Click();
          WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid(), "Text", cmpEqual, PrixAcheteurExcelCROES_8902);
          Log.Message("CROES-8902");
          Get_WinInfoSecurity_BtnCancel().Click();
         // Mettre un nombre qui contient plus de 7 chiffres sur le prix Acheteur 
          Search_SecurityByDescription(DescrSecurityCROES_8902)
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_8902,10).Click();
          
          Get_SecuritiesBar_BtnInfo().Click();
          WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
          Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Click();
          Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Clear();
          Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Keys(PrixAcheteurCROES_8902Plus7chiffres);
          Get_WinInfoSecurity_BtnOK().Click()
          //Les points de vérifications
          
          Search_SecurityByDescription(DescrSecurityCROES_8902);
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_8902,10).Click();
          var PrixAchteurDisplay =Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter",8], 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
          Log.Message(PrixAchteurDisplay)
          CheckEquals(PrixAchteurDisplay,PrixAcheteurExcelCROES_8902, "Le prix acheteur est est a n/dét.")
          Log.Message(" CROES_8902")
          Search_SecurityByDescription(DescrSecurityCROES_8902);
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_8902,10).Click();
          Get_SecuritiesBar_BtnInfo().Click();
          WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid(), "Text", cmpEqual, PrixAcheteurExcelCROES_8902);
          Log.Message("CROES-8902")
          Get_WinInfoSecurity_BtnCancel().Click();;
          
      }
      catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
          Terminate_CroesusProcess();
          Login(vServerTitre, userNameGP1859, passwordGP1859, language);
          //Initialiser la bd PrixAcheteurInitialCROES_8902
          Get_ModulesBar_BtnSecurities().Click();
          Search_SecurityByDescription(DescrSecurityCROES_8902)
          Get_SecurityGrid().Find("Value",DescrSecurityCROES_8902,10).Click();
          
          Get_SecuritiesBar_BtnInfo().Click();
          WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
          Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Click();
          Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().set_Text(PrixAcheteurInitialCROES_8902)
          Get_WinInfoSecurity_BtnOK().Click()
          Terminate_CroesusProcess();
         
        
      }
  }
  
  
 