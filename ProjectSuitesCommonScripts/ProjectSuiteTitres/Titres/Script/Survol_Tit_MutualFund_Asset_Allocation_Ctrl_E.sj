//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_Bond_MenuBar_EditFunctions_Info
//USEUNIT DBA

/* Description : A partir du module « Titre » ,chercher le titre 970521 (Mutual Fund) qui a l'onglet Asset Allocation, afficher la fenêtre « Info » avec Ctrl+E. 
 Vérifier la présence des contrôles et des étiquetés */
 
function Survol_Tit_MutualFund_Asset_Allocation_Ctrl_E()
{
    Login(vServerTitre, userName, psw, language);
    Get_ModulesBar_BtnSecurities().Click();
    
    Search_Security("970521");
    
    Get_SecurityGrid().Keys("^e");
    
    //Les points de vérification en français 
    if (language == "french"){       
      //****************************L'ONGLET RÉPARTITION DE L'ACTIF************************
      if (client == "CIBC" || client == "BNC" || client == "US" || client == "TD"){
        Delay(3000)
          Get_WinInfoSecurity_TabAssetAllocation().Click();
          aqObject.CheckProperty(Get_WinInfoSecurity_TabAssetAllocation(), "WPFControlText", cmpEqual, "Répartition d'actifs");
          aqObject.CheckProperty(Get_WinInfoSecurity_TabAssetAllocation(), "IsSelected", cmpEqual, true);
      }   
    }
    //Les points de vérification en anglais 
    else {
      if (client == "CIBC" || client == "BNC" || client == "US" || client == "TD"){
          //****************************L'ONGLET RÉPARTITION DE L'ACTIF***********************
          Delay(3000)
          Get_WinInfoSecurity_TabAssetAllocation().Click();
          aqObject.CheckProperty(Get_WinInfoSecurity_TabAssetAllocation(), "WPFControlText", cmpEqual, "Asset Allocation", false);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabAssetAllocation(), "IsSelected", cmpEqual, true);
      }  
    } 
    
    Get_WinInfoSecurity_BtnCancel().Click()
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
}