//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA


/* Description :Création d'un filtre rapide temporaire dont la valeur est un string
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1042
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1042_Cli_Create_TempAddressFilter_ToolBar_btnQuickFilters()
 {

    if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC" ){
      Activate_Inactivate_PrefBranch('0',"PREF_EDIT_ADDRESS","REP",vServerClients)
    }
    
    try{    
        var filtre ="test";
   
        Login(vServerClients, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
        
        Log.Message("Étape 1: Sélectionner le client et modifier son adresse.");
        if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800077")}
        else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
        Get_RelationshipsClientsAccountsGrid().Find("Value","KING MCKENZIE",1000).Click();
    
        //Modifier l’adresse dans la fenêtre info
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", "True", 30000);
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit().Click();
        Get_WinCRUAddress_TxtCityProv().Keys(filtre);
        Get_WinCRUAddress_BtnOK().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
        //Delay(1000);
        
        Log.Message("Étapes 2 et 3: Icone (Y) Menu Champs filtre: Adresse. Sous menu: Ville et Province");
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Address().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Address_CityAndProvince().Click();
        
        Log.Message("Étape 4: Remplir les champs obligatoires.");
        //Création d'un filtre
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemContaining().Click();
        Get_WinCreateFilter_TxtValue().Keys(filtre);
        Get_WinCreateFilter_BtnApply().Click();  
   
        //Les points de vérification
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients,"CR1352",3,language));
   
        //Les points de vérification : Vérifier que le nombre de résultats dans le grid et 1
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 1)
        
        Log.Message("Étape 5: Supprimer le contenu du champ Ville/Prov de l'adresse principale.");
        //Modifier l’adresse dans la fenêtre info 
        Get_RelationshipsClientsAccountsGrid().Find("Value","KING MCKENZIE",1000).Click();
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", "True", 30000);
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit().Click(); 
        Get_WinCRUAddress_TxtCityProv().Clear();
        Get_WinCRUAddress_BtnOK().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
   
        //Les points de vérification : Vérifier que le nombre de résultats dans le grid et 0
        Log.Message("anomalie : CROES-6676")
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 0)
          
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
   }  
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } 
    finally{
      if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC"){
        Activate_Inactivate_PrefBranch('0',"PREF_EDIT_ADDRESS","Sysadm",vServerClients)
      }
    }
 }
 

