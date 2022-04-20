//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT Global_variables
//USEUNIT CR1352_1172_Cli_Edit_PerFiltre
//USEUNIT DBA

/* Description : Modifier un filtre appliqué
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1173
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1173_Cli_Edit_AppliedFilter()
 {
   try{
        var filterName ="123";
        var modifiedFilterName ="123Filtre";
        var value="5";
        var modifiedValue="10";
         
        Login(vServerClients, "COPERN" , psw ,language);
        
        Get_ModulesBar_BtnClients().Click();        
        Get_MainWindow().Maximize();
        
        //Enlever des filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsChecked", true, 1000);
        
         //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
        
        //CREATION D'UN FILTRE
        if (client == "BNC" ){      
          Create_RootNoFilter(filterName,value) //dans le script CR1352_1172_Cli_Edit_PerFiltre
        }
        else{//RJ
        
          //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
          Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
          
         if(client == "US" ){
          SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbField(), "Gender");  
          }
          else{
            Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
            Get_WinCRUFilter_CmbField_ItemLanguage().Click()
        } 
          if (client == "US" ){
           
             SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbOperator(), "among")
             Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",317,language),10).Click()}
           //} 
         else{
          Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
          Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
          if(client == "US" ){ Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",224,language),10).Click()}
          else {Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",223,language),10).Click()}
         
        }
         Get_WinCRUFilter_BtnOK().Click(); }
    
        //vérifier que le filtre  apparaît dans la fenêtre Gestion des filtres en tête de liste
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreated().DblClick();
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "Description", cmpEqual, filterName);              
        
        //Appliquer le filtre
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filterName,100).Click();     
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click(); 
                  
        
        //Vérifier le nombre de résultats que le filtre retourne
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filterName); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
        if (client == "BNC" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 5);
        }
        if( client == "US" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 22);
        } 
        if( client == "TD"){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 48);
        }  
        if(client != "US" && client != "BNC"  && client != "TD" ){//RJ et CIBC
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 48);
        }
        
        
        //Cliquer sur le crayon 
        var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13)
        
        //Remplacer la valeur 
        Get_WinCRUFilter_GrpDefinition_TxtName().Clear();
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(modifiedFilterName);  
       
        if (client == "BNC" ){
          Get_WinCRUFilter_GrpCondition_TxtValue().Clear();
          Get_WinCRUFilter_GrpCondition_TxtValue().Keys(modifiedValue);
        }
        if(client == "US" ){
          
          Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",318,language),10).Click()
        } 
        if(client != "US" && client != "BNC"){
          
          Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",224,language),10).Click()
        }
        Get_WinCRUFilter_BtnOK().Click(); 
        
        //Vérifier le nombre de résultats que le filtre retourne et le nom 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, modifiedFilterName); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
        
        if (client == "BNC" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 3);
        }
         if(client == "US" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 35);
        }
        if(client == "TD"  ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 12);
        }
        
        if(client == "CIBC" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 7);
        }
        if(client != "US" && client != "BNC"  &&  client!= "CIBC"&& client != "TD" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 7);//12
        }
        
        //Cliquer sur le crayon 
        var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13)
        
        //Modifier le champ Opérateur
        if( client != "US" ){  
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown(); }  
        if (client == "BNC" ){
          Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click(); 
        }
        if(client == "US" ){
         SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbOperator(), "excluding")
        }  
        if(client != "US" && client != "BNC" ){//RJ
          Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
        } 
        Get_WinCRUFilter_BtnCancel().Keys("[Enter]"); //Annuler les modifications 
        
        //Vérifier le nombre de résultats que le filtre retourne 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, modifiedFilterName); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
        if (client == "BNC" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 3);
        }
        if(client == "US" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 35);
        }
         if(client == "TD" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 12);
        }
        
        if(client != "US" && client != "BNC" && client != "TD"){ // CIBC
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 7);//12
        }
        
        //Modifier le filtre dans la fenetre Gestion des filtre 
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",modifiedFilterName,100).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit().Click();
        
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        if (client == "BNC" ){
          Get_WinCRUFilter_CmbOperator_ItemNotEndingWith().Click(); 
        }  
        else{//RJ
          Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
        }
        Get_WinCRUFilter_BtnOK().Click(); 
        
        //Un message s'affiche :Ce filtre est actif sur le module.il sera rafraichi.
        //Vérifier que le message d'erreur s'affiche  
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpMatches, GetData(filePath_Clients,"CR1352",83,language));
        Get_DlgWarning().Close();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Close()
        //Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
                 
        //Vérifier le nombre de résultats que le filtre retourne 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, modifiedFilterName); 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
        
        if (client == "BNC" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 54);
        } 
         if(client == "US" ){
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 35);
        }  
         if(client == "TD"){
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 48);
        }   
        if(client != "US" && client != "BNC"  && client != "TD" ){ //CIBC
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 49);
        }     
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
               
     }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
     finally{
     
        Delete_FilterCriterion(filterName,vServerClients)//Supprimer le filtre de BD      
        Delete_FilterCriterion(modifiedFilterName,vServerClients)//Supprimer le filtre de BD    
     }
}

