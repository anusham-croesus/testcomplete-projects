//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Au démarrage de croesus, le filtre temporaire n'est pas chargé
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1056
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1056_Cli_TempFilter_SavedAndLoaded_AfterStartup()
 {  
    var temporaryFiltre = "canada";
    var permanentFiltre = "Pays_Filtre";
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    //Delay(200);
    
    var criterion= GetData(filePath_Clients,"CR1352",59,language)
    Delete_FilterCriterion(criterion,vServerClients)//Supprimer le filtre de BD 
     
    Delete_DefaultClientsList_InSearchCriteriaManager();
      
    try{  
          //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFilters_ContextMenu_Address().Click();
          Get_Toolbar_BtnQuickFilters_ContextMenu_Address_Country().Click();
     
          //Création d'un filtre
          Get_WinCreateFilter_CmbOperator().DropDown();
          Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
          Get_WinCreateFilter_TxtValue().Keys(temporaryFiltre);
          Get_WinCreateFilter_BtnSaveAndApply().Click();  
              
          Get_WinSaveFilter_TxtName().Keys(permanentFiltre);
          Get_WinSaveFilter_BtnOK().Click();
          
          //Les points de vérification 
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, permanentFiltre);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
     
          //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation 
          Compare_SumGrid_clientNumber();
          
          Get_MainWindow().SetFocus();
          Close_Croesus_AltQ();
          
          Login(vServerClients, userName , psw ,language);
          Get_ModulesBar_BtnClients().Click();
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, permanentFiltre);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
          
          //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation    
          Compare_SumGrid_clientNumber();
          
          Get_MainWindow().SetFocus();
          Close_Croesus_AltF4();
          
      }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
      finally{
      
          Delete_FilterCriterion(permanentFiltre,vServerClients)     
      }      
   }  

function Delete_DefaultClientsList_InSearchCriteriaManager()
{   
     //Afficher le Gestionnaire de critères de recherche
     Get_Toolbar_BtnManageSearchCriteria().Click()
         
     var count = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count;//Compter les résultats dans le grid 
    
      for (i=0; i<= count-1; i++){
        if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description==GetData(filePath_Clients,"CR1352",59,language)){
            Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description.Click();
            Get_WinSearchCriteriaManager_BtnDelete().Click();            
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
      }    
      Get_WinSearchCriteriaManager_BtnClose().Click();
}