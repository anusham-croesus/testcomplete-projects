//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Désactiver des filtres appliqués simultanément
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1054

Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1054_Cli_ApplySimultaneously_SeveralTempFilter()
{
    var filtre = "20000";
    var filtre1 = "Maria Mayer";
    var filtre2 = "A"
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //CRÉATION D’UN FILTRE TOTAL VALUE
    //Afficher la fenêtre « Ajouter un filtre » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
    if (client == "BNC" ){
      //Scroll
      //var height = Get_Toolbar_BtnQuickFilters_ContextMenu().get_ActualHeight();
      //for (i=0; i<= 3; i++){      
      //    Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5);                 
      //} 
    } 
     
    Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue().Click();
        
    //Création d'un filtre
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
    Get_WinCreateFilter_TxtValueDouble().Keys(filtre);
    Get_WinCreateFilter_BtnApply().Click(); 
            
    //CRÉATION DU FILTRE PERSONNE RESSOURCE
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ContactPerson().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
    Scroll()
    Get_WinCreateFilter_DgvValue().Find("Value", filtre1, 1000).Click();
    Get_WinCreateFilter_BtnApply().Click();           
    Get_DlgWarning().Close();
    
    //CRÉATION DU FILTRE NAME
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Name().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(filtre2);
    Get_WinCreateFilter_BtnApply().Click();
    
    Get_DlgWarning().Close();
    Log.Message("Jira CROES-8034, en statut open.");

    //Désactiver le filtre RERSONNE RESOURCE
    Get_RelationshipsClientsAccountsGrid_BtnFilter(2).Click();
    
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 0); // 0 - Le filtre n'est pas actif ; 1- Le filtre est actif
    
     //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation
    Compare_SumGrid_clientNumber();
       
    //Désactiver le filtre Total value
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
    
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0 - Le filtre n'est pas actif ; 1- Le filtre est actif
    
    //Désactiver le filtre Name
    Get_RelationshipsClientsAccountsGrid_BtnFilter(3).Click();
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(3), "wState", cmpEqual, 0); // 0 - Le filtre n'est pas actif ; 1- Le filtre est actif
    
    if (client == "BNC" ){
      //Vérifier le nombre de clients dans la grille et le comparer avec le nombre de clients dans la fenêtre sommation
      Compare_SumGrid_clientNumber();
    }
    else{//RJ
      Compare_SumGrid_clientNumber_WithExternalClient()
    }
   
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
}

function Scroll()
{
  var ControlWidth= Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).get_ActualWidth()
  var ControlHeight= Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).get_ActualHeight()
  Log.Message(ControlWidth)
  Log.Message(ControlHeight)
  for (i=1; i<=1; i++) {Get_WinCreateFilter_DgvValue().Click(ControlWidth-5, ControlHeight-25)}
}


