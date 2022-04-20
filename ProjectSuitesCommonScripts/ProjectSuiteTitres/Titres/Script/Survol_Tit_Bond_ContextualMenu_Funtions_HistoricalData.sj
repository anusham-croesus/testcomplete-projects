//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_Option_MenuBar_EditFunctions_HistoricalData

/* Description : A partir du module « Titre » ,chercher le titre R13021 (Obligation), afficher la fenêtre « Info » en cliquant sur HistoricalData du menu contextuel. 
 Vérifier que l’onglet « Historique de prix » est sélectionné. Vérifier la présence des contrôles et des étiquetés dans la partie « Description » 
 et l’onglet « Historique de prix ». 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1791*/
 
 function Survol_Tit_Bond_ContextualMenu_Funtions_HistoricalData()
 {
    var type="bond"; //La variable qui est utilisée dans les points de vérifications 
    
    Login(vServerTitre, userName , psw ,language);
    Get_ModulesBar_BtnSecurities().Click();
    
    if (Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 2000))
     {
       Search_Security("R13021")
     }
    else
     {
       Log.Error("The BtnSecurities didn't become Checked within 2 seconds.");
     }
    
    Get_SecurityGrid().Keys("[Apps]")
    Get_SecurityGrid_ContextualMenu_Functions().Click()
    Get_SecurityGrid_ContextualMenu_Functions_HistoricalData().Click()
    
     //Les points de vérification en français 
     if(language=="french"){ Check_Properties_French(type)}// la fonction est dans le script Survol_Tit_Option_MenuBar_EditFunctions_HistoricalData     
    //Les points de vérification en anglais 
    else{Check_Properties_English(type)}// la fonction est dans le script Survol_Tit_Option_MenuBar_EditFunctions_HistoricalData
    
    Check_Existence_Of_Controls(type)// la fonction est dans le script Survol_Tit_Option_MenuBar_EditFunctions_HistoricalData
      
    Get_WinInfoSecurity_BtnCancel().Click()
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
