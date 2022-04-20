//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :Modification de l'ordre de tri pour un critère avancé
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1508
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1508_Cli_ChangingSortOrder_forAdvancedCriteria()
 {  
   var criterion="CR1352_1508"
   var columnName=GetData(filePath_Clients,"CR1352",130,language)
   
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
   
   try{
       //Ajout de critère de recherche 
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Clear();
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Keys(criterion);
       Get_WinCRUSearchCriterionAdvanced_BtnSave().Click(); 
       Delay(1000);  
       Get_WinSearchCriteriaManager_BtnRefresh().Click();
       
       //Vérifier que le critère de recherche il est appliqué dans la grille Clients
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif 
       
       //Cliquer sur le crayon de filtre appliqué
       var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
       Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-45, 13);
       
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_BtnProperties().Click();       
       Get_WinSearchCriterionProperties_GrpOrder_ChkKeepSortOrder().set_IsChecked(false);      
       Get_WinSearchCriterionProperties_GrpOrder_CmbField().Click();       
       Get_WinSearchCriterionProperties_GrpOrder_CmbField_ItemClientNumber().set_IsSelected(true);
       Get_WinSearchCriterionProperties_GrpOrder_CmbField().Click(); 
       Get_WinSearchCriterionProperties_GrpOrder_RdoAscending().set_IsChecked(true)
       Get_WinSearchCriterionProperties_BtnOK().Click()  
       Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh().Click(); 
       
       //Vérifier que le critère de recherche il est appliqué dans la grille Clients
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif 
       var columnName=GetData(filePath_Clients,"CR1352",130,language)
       var text=Check_columnAlphabeticalSort_CR1483(Get_RelationshipsClientsAccountsGrid(),columnName,"ClientNumber")
       Log.Message(text+" ----- "+columnName);
       Log.Message("Jira CROES-10389: le tri ne fonctionne plus avec les critères avancés")
       //aqObject.CompareProperty(text,cmpEqual,"Le grid  est trié par l’ordre alphabétique ascendant", true, lmError);
       aqObject.CompareProperty(text,cmpNotEqual,"Le grid  est trié par l’ordre alphabétique ascendant", true, lmError); // Jira CROES-10389
       
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();
   }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
    finally{
        Delete_FilterCriterion(criterion,vServerClients)//Supprimer le criterion de BD   
    }
 }

 
function Check_columnAlphabeticalSort(grid,columnName,itemColumnName )//columnName - Le nom visible, c.-à-d. il est différant en français en en anglais ; itemColumnName- Les colonnes définis dans le code, ils sont même pour deux langues  
{
    var textAsendant="Le grid  est trié par l’ordre alphabétique ascendant";
    var textDescendant="Le grid  est trié par l’ordre alphabétique descendant";
    
    var count = grid.WPFObject("RecordListControl", "", 1).Items.Count
    var arr = []; 
    var arrNotSupportedProperty = [];
    for(var i = 0; i < count; i++){
        var DataItem = grid.WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem;
        if (aqObject.IsSupported(DataItem, itemColumnName))
            arr.push(aqObject.GetPropertyValue(DataItem, itemColumnName));
        else
            arrNotSupportedProperty.push(i);
    }
   
    if (arrNotSupportedProperty.length > 0){
        Log.Warning("Les éléments dont l'index est listé dans la partie Details ne supportent pas la propriété '" + itemColumnName + "'.", arrNotSupportedProperty);
    }

    if (grid.Find("WPFControlText", columnName, 100).get_SortStatus() == "Ascending"){
        for (var i = 1; i < arr.length; i++){
            if (arr[i] < arr[i-1]){
                Log.Message("Il se pourrait que l'objet utilisé 'grid.WPFObject(\"RecordListControl\", \"\", 1).Items' ne réflète pas l'ordre visuel réel des items dans le grid.");
                return  Log.Error("Le grid n'est pas trié par l’ordre alphabétique ascendant");
            }
        }
        //return Log.Message("Le grid  est trié par l’ordre alphabétique ascendant");  
        return textAsendant;
     }
 
    if (grid.Find("WPFControlText", columnName, 100).get_SortStatus() == "Descending"){
        for (var i = 1; i < arr.length; i++){
            if (arr[i-1] < arr[i]){
                Log.Message("Il se pourrait que l'objet utilisé 'grid.WPFObject(\"RecordListControl\", \"\", 1).Items' ne réflète pas l'ordre visuel réel des items dans le grid.");
                return  Log.Error("Le grid n'est pas trié par l’ordre alphabétique descendant");
            }
        }
        //return Log.Message("Le grid  est trié par l’ordre alphabétique descendant"); 
        return textDescendant;
     }
 }
 