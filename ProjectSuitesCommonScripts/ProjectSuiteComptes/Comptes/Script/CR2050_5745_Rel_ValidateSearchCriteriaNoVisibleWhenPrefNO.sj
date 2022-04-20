//USEUNIT Common_functions
//USEUNIT CR2050_5744_Rel_ValidateAddSearchCriteriaWhenPrefNO
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider que le critère ne s’affiche pas automatiquement si la pref =NON, module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5745
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Asma Alaoui
    
    Complété par Amine A.
*/


function CR2050_5745_Rel_ValidateSearchCriteriaNoVisibleWhenPrefNO()
{
   try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5745","CR2050");
        
        var criterion     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "CodeCP", language+client);
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "NomCritère_5745", language+client);  
        
        var typeFilterField = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "5745_FilterFieldType", language+client);
        var filterValue     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "5745_Menage", language+client);
        var filterName      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "5745_NameType", language+client);
      
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
        RestartServices(vServerAccounts);
                 
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Accès au module Relations 
        Get_ModulesBar_BtnRelationships().Click(); 
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 50000);
        
        //Cliquer sur le bouton "Gérer les critères de recherche"
        Get_Toolbar_BtnManageSearchCriteria().Click();     
        AddCriteria(criterionName, criterion)
        
        //Valider bouton "Réafficher tout et conserver les crochets" et le nom du criètre de recherche s'affiche dans un carré bleu
         aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked",cmpEqual, true);
         aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"Exists",cmpEqual, true);
         aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"VisibleOnScreen",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"Exists",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"VisibleOnScreen",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsVisible",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsChecked",cmpEqual, true);
         
         //Valider les relations avec le critère de recherche défini
        ValidateMatchesCriteriaRelationsNoCoch(criterion) 
        
        //--------------------------------Ajouté par A.A-----------------------------------
        //Ajouter un filtre rapide Type = Ménage
        Log.Message("Ajouter un filtre rapide Type = Ménage")
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Item(typeFilterField).Click();
        
        Get_WinCreateFilter_CmbOperator().Click();
        Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
  
        Get_WinCreateFilter_Value(filterValue).Click();
        Get_WinCreateFilter_BtnSaveAndApply().Click();
        
        Get_WinSaveFilter_TxtName().Keys(filterName);
        Get_WinSaveFilter_BtnOK().Click();
        
        //Si le résultat du filtre est vide
        if (Get_DlgWarning().Exists)
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);

        //Valider que le filtre est affiché et actif 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"Exists",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"VisibleOnScreen",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"IsVisible",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"wState",cmpEqual, 1);
        
        //Désactiver le fitre
        Log.Message("Désactiver le fitre")
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", filterName], 10).Click();    
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10).WaitProperty("IsChecked", false, 5000); 
           
        //Fermer l'application  
        Terminate_CroesusProcess();
        
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Accès au module Relations 
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 50000);
        
        //Valider l'affichage du critère
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"Exists",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"VisibleOnScreen",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsVisible",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"Enabled",cmpEqual, true);
         
        //Verifier que les relations BD88 ne sont pas cochées
        ValidateMatchesCriteriaRelationsNoCoch(criterion);
        
        //cliquer sur "Réafficher tout et conserver les crochets"
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
        
        //Valider l'affichage du bouton 
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked",cmpEqual, true);
        
        //valider que les relations assoociés au critère sont affichées avec un crochet rouge
        ValidateMatchesCriteriaRelationsNoCoch(criterion);
        
        //Activer le filtre
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", filterName], 10).Click(); 
        //Si le résultat du filtre est vide
        if (Get_DlgWarning().Exists)
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);   
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10).WaitProperty("IsChecked", false, 5000); 
        //Valider que le filtre est affiché et actif 
        Log.Message("Valider que le filtre est affiché")
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"Exists",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"VisibleOnScreen",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"IsVisible",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"wState",cmpEqual, 1);
         
        //Fermer l'application  
        Terminate_CroesusProcess();
        
        //changer la pref user à Non
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "NO", vServerAccounts)
        RestartServices(vServerAccounts);
    
        //Se connecter à l'application        
        Login(vServerAccounts, userNameKEYNEJ, psw, language);
        
        //Accès au module Relations 
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 50000);
        
        //Aucun critère n'est appliqué
        ValidateNoMatchesCriteriaRelations();
                
        //Valider que le filtre est affiché 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"Exists",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"VisibleOnScreen",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"IsVisible",cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], 10),"wState",cmpEqual, 1);        
        
        //Supprimer le filtre
        DeleteFilter(filterName)
}
    catch(e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
       Terminate_CroesusProcess();
       Delete_FilterCriterion(criterionName,vServerAccounts)
       Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
       RestartServices(vServerAccounts); 
       Terminate_CroesusProcess();  
    }
    
    finally {           
        //Supprimer le critère
        Delete_FilterCriterion(criterionName, vServerAccounts); 
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
        RestartServices(vServerAccounts); 
    }
} 

function DeleteFilter(filterName){
  
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"], 5000);
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild("Value", filterName,10).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete().Click();
        Get_DlgConfirmation_BtnDelete().Click();
        Delay(1500);
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
}

//ajouter un critère de recherche
function AddCriteria(criterionName, criterion){
          
    //sur la fenêtre Critères de recheche cliquer sur Ajouter
    Get_WinSearchCriteriaManager_BtnAdd().Click(); 
      
    //Saisir le nom 
    Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
    
    //Sur "Definition" modifier <Verbe> à "n'ayant pas"
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemNotHaving().Click();
    
    //Sur <Champ> choisir "Informatif" ensuite " code de CP"
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemIACode().Click();
    
    //Sur <Opérateur> choisir "égal(e) à
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    
    // Entrer la valeur "BD88" 
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(criterion);
    
    
    //Sur <Suivant> choisir le point " . "
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
    // Cliquer sur "Sauvgarder et actualiser
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
}    
   
function ValidateMatchesCriteriaRelationsNoCoch(criterion)
    {      
        
      var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
      {  
       var valueMatchesCriterion=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
       var code = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber.OleValue;
           
        if((valueMatchesCriterion == true && code!=criterion) || (code == criterion && valueMatchesCriterion == false))
        
            Log.Checkpoint("Le code de CP dans la ligne "+i+" respecte le critère de recherche n'ayant pas BD88 c'est le "+code+" qui est récupéré" );
          else 
            Log.Error("la ligne d'indice "+i+" ne respecte le critère de recherche. Le code de CP récuperé est bien : "+code);                 
    }  
}
   
function Get_WinCreateFilter_Value(value){
    return Get_WinCreateFilter().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", value], 10)} 