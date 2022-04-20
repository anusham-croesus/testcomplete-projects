//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList

/* Description :Copier une liste manuelle
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1968
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1968_Cli_Copy_ManualList()
 {   
   var type= GetData(filePath_Clients,"CR1352",155,language)
   var criterion= GetData(filePath_Clients,"CR1352",59,language)
   
   try{
       Login(vServerClients, userName, psw, language);
       Get_ModulesBar_BtnClients().Click();
       
       Get_MainWindow().Maximize();
    
       //Avec la barre d'espacement retirer ou ajouter les enregistrements
       for(i=0; i<=2; i++){
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
		WaitObject(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl, "IsLoaded", true); 
       }
      
       Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Keys(" ");
   
       //Ouvrir la fenêtre de Gestionnaire de critère de recherche 
       Get_Toolbar_BtnManageSearchCriteria().Click();
       Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
       Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",type,100).Click()
   
       //Valider que le bouton copier est grisée
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, false)  
       Get_WinSearchCriteriaManager_BtnClose().Click(); 
      
       //Supprimer le critère par default
       Delete_DefaultClientsList(type)
             
        Get_MainWindow().SetFocus();
        Close_Croesus_SysMenu();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(criterion,vServerClients)//Supprimer le filtre de BD   
    }

 }
 