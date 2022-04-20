//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Appliquer un critère de recherche et un filtre actif
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1595
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1595_Acc_Apply_a_search_criterion_and_an_active_filter()
{

    try {
        
        //le script a été révisé et remplace les scripts suivants: Croes-1595, Croes-1618, Croes-1619
        Log.Message("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6890");
        var criterionName = "TestCriterion";
        var criterionGreaterThanValue = 1000000;
        var filterGreaterThanValue = 2000000;
        var accBeauch="BEAUCH";
        var NameBEAUCHRAYMOND="BEAUCH RAYMOND"; 
        var IACode="BD88";
              
        Login(vServerAccounts, userName, psw, language);
        
        Log.Message("Accéder le module comptes");
        Get_ModulesBar_BtnAccounts().Click();
       
        
        //****************************************** Étape 2*********************************************************** 
        Log.Message("Étape 2");
        //Créer et appliquer le critère : Liste des comptes (Compte réel) ayant valeur totale supérieur à 1 0000 00,00
        Log.message("Créer et appliquer le critère : Liste des comptes (Compte réel) ayant valeur totale supérieur à 1 0000 00,00");
                   
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(criterionGreaterThanValue);    
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
        //****************************************** Étape 3*********************************************************** 
        Log.Message("Étape 3");
        //Cliquer sur Filtres et appliquer le filtre : Valeur totale est plus grand que 2 000 000,00
        Log.Message("Cliquer sur Filtres et appliquer le filtre : Valeur totale est plus grand que 2 000 000,00");
           
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue().Click();    
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
        Get_WinCreateFilter_TxtValueDouble().Keys(filterGreaterThanValue);
        Get_WinCreateFilter_BtnApply().Click();  
    
        //****************************************** Étape 4*********************************************************** 
        Log.Message("Étape 4");
        //Vérifier que le résultat est correct (2 comptes affichés)
        Log.Message("Vérifier que le résultat est correct (2 comptes affichés)");
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    
        Log.Message(count + " accounts displayed as the result of the criterion and filter.");
        if (count == 2){
            Log.Checkpoint("The number of the displayed accounts is the expected.");
        }
        else {
            Log.Error("The number of the displayed accounts is not the expected. Expecting 2 accounts.");
        }
    
    
        for (var i = 0; i < count; i++){
            displayedName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Name();
            displayedTotalValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_TotalValue();
            Log.Message("Row " + (i + 1) + " : the account name is " + displayedName + " ; the account total value is " + displayedTotalValue);
        
            if ((displayedTotalValue > criterionGreaterThanValue) && (displayedTotalValue > filterGreaterThanValue)){
                Log.Checkpoint("The account was expected to be displayed.");
            }
            else {
                Log.Error("The account was not expected to be displayed.");
            }
        }
    
        //****************************************** Étape 5*********************************************************** 
        Log.Message("Étape 5");   
        //Désactiver les filtres ajoutés dans les étapes 2 et 3 puis aisir "Beauch" au clavier
        Log.Message("Désactiver les filtres ajoutés dans les étapes 2 et 3 puis aisir 'Beauch' au clavier");
        if(language=="french"){
            Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText","Valeur totale > 2000000",10).Click();
        }else{
            Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText","Total Value > 2000000",10).Click();
        }
        
        Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText","TestCriterion",10).Click();
        Delay(1000);
         
        Get_RelationshipsClientsAccountsGrid().Keys("B");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(accBeauch);
        aqObject.CheckProperty(Get_WinQuickSearch(), "VisibleOnScreen", cmpEqual, true); 
        if (!(Get_WinAccountsQuickSearch_RdoName().IsChecked)){
            Log.Error("The 'Name' option was not selected.");
           
        }else{
            Log.Checkpoint("The 'Name' option was selected.");
        }
                
        //****************************************** Étape 6*********************************************************** 
        Log.Message("Étape 6");   
        Get_WinQuickSearch_BtnOK().Click();       
        //Valider avec OK et vérifier le résultat de recherche. Flèche positionnée sur le compte "Beauch Raymond"
        Log.Message("Valider avec OK et vérifier le résultat de recherche. Flèche positionnée sur le compte 'Beauch Raymond'");
        //var rowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 1; i <= 15; i++){
          var displayedAccountNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").DataContext.DataItem.Name;
          var isDisplayedAccountActive = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).WPFObject("RecordSelector", "", 1).IsActive;
          var found=false;
          if (displayedAccountNo == NameBEAUCHRAYMOND && isDisplayedAccountActive){
              Log.Checkpoint("Arrow was positioned on account  " + NameBEAUCHRAYMOND); 
              Log.Picture(Sys.Desktop.ActiveWindow(), "");
              found=true;
              break;             
          }
        }
        if(found==false){Log.Error("Arrow was not positioned on Name" + NameBEAUCHRAYMOND);}
        
        //****************************************** Étape 7*********************************************************** 
        Log.Message("Étape 7");  
        //Saisir BD88 au clavier et cocher 'Code de CP'
        Log.Message("Saisir BD88 au clavier et cocher 'Code de CP'");
        Log.Message("Saisir le premier caractère et vérifier que la fenêtre Rechercher est affichée");        
        Get_RelationshipsClientsAccountsGrid().Keys("B");
        aqObject.CheckProperty(Get_WinQuickSearch(), "VisibleOnScreen", cmpEqual, true); 
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(IACode);
        Get_WinAccountsQuickSearch_RdoIACode().set_IsChecked(true);
        
        
        //****************************************** Étape 8*********************************************************** 
        Log.Message("Étape 8"); 
        Get_WinQuickSearch_BtnOK().Click();
        Log.Message("Valider avec OK et vérifier le résultat de recherche");
        Log.Message("Flèche positionnée sur un compte dont le code de CP est BD88");        
        Log.Message("Crash lors de la recherche de compte par Code CP. L'anomalie ouverte par Karima- CROES-8311")
        //var rowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        
        for (var i = 0; i < 15; i++){
            var displayedIACode = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_RepresentativeNumber(); // Avant RepresentativeId
            var isActiveValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", (i + 1)).WPFObject("RecordSelector", "", 1).IsActive;
            var found=false;
            if ((displayedIACode == IACode) && (isActiveValue == true)){
                Log.Checkpoint("Arrow was positioned on an account of IA Code : " + displayedIACode);
                Log.Picture(Sys.Desktop.ActiveWindow(), "");
                found=true;
                break;
            }
        }
        if(found==false){Log.Error("Arrow was not positioned on an account of IA Code : " + IACode);}
        
        //Fermer le critère et le filtre    
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le critère
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le filtre
    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_FilterCriterion(criterionName, vServerAccounts); //Supprimer le critère
    }
    
}

