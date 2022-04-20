//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description :Appliquer un filtre qui ne retourne aucun résultat
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1174
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1174_Cli_Apply_FilterWithoutResults()
 {
    try{
    
        var filter="test1"
    
        Login(vServerClients, "COPERN" , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant l'icone (Y) en haut a gauche   
        Get_RelationshipsClientsAccountsGrid().Click(10,10)
        Get_RelationshipsClientsAccountsGrid().Click(10,10)
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click(); 
    
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Create_LanguageFilter(filter);
   
        //Vérifier qu'un message s'affiche : Le filtre que vous avez appliqué ne contient aucune donnée
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpMatches, GetData(filePath_Clients,"CR1352",33,language));
        Get_DlgWarning().Close();
    
        //Les points de vérification: le texte de filtre
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 0);
              
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
     }
     catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
     finally{
        Delete_FilterCriterion(filter,vServerClients)//Supprimer le filtre de BD         
     }                  
 }
 
 function Create_LanguageFilter(filterName)
{
    Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
    
     if(client == "US" ){
          SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbField(), "Gender");  
          }
     else{
     Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                       
     Get_WinCRUFilter_CmbField_ItemLanguage().Click()} 
     if (client == "US" ){
            
             SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbOperator(), "among")
            Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",319,language),10).Click()} 
     else{
      Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
      Get_WinCRUFilter_GrpCondition_DgvValue().Click()
      Get_WinCRUFilter_GrpCondition_DgvValue().Keys("^a");}
      Get_WinCRUFilter_BtnOK().Click(); 
}


function Test1()
{
  var dataRecordCellArea;
  dataRecordCellArea = Aliases.CroesusApp.winAddFilter.WPFObject("GroupBox", "Condition", 2).WPFObject("FilterControl", "", 1).WPFObject("QuickFilterListValueDataGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1);
  dataRecordCellArea.WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "Anglais", 1).WPFObject("XamTextEditor", "", 1).Click(53, 13);
  dataRecordCellArea.Keys("^a");
}