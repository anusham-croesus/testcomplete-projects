//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Recherche rapide par Nom
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1618
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1618_Acc_Quick_Search_by_Name()
{
    
    try {
        var accountName = "BEAUCH RAYMOND";
        var searchText = "BEAUCH";
        var searchTextFirstChar = aqString.GetChar(searchText, 0);
    
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Saisir le premier caractère et vérifier que la fenêtre Rechercher est affichée avec l'option Nom sélectionné
    
        Log.Message("Hit the first character of the text " + searchText);
        Get_RelationshipsClientsAccountsGrid().Keys(searchTextFirstChar);
        
        if (!(Get_WinQuickSearch().Exists)){
            Log.Error("The Quick Search window was not displayed.");
            return;
        }
        
        Log.Checkpoint("The Quick Search window was displayed.");
    
        if (!(Get_WinAccountsQuickSearch_RdoName().IsChecked)){
            Log.Error("The 'Name' option was not selected.");
            return;
        }
        
        Log.Checkpoint("The 'Name' option was selected.");
        
        var displayedSearchText = Get_WinQuickSearch_TxtSearch().Text;
        if (displayedSearchText != searchTextFirstChar){
            Log.Error("The search textbox content was not " + searchTextFirstChar + ", got " + displayedSearchText);
            return;
        }
        
        Log.Checkpoint("The search textbox content was " + searchTextFirstChar);
        
        
        //Saisir le reste des caractères
        
        Log.Message("Hit the remaining characters of the text " + searchText);
        Get_WinQuickSearch_TxtSearch().Keys(aqString.SubString(searchText, 1, (aqString.GetLength(searchText) - 1)));
        
        var displayedSearchText = Get_WinQuickSearch_TxtSearch().Text;
        if (displayedSearchText != searchText){
            Log.Error("The search textbox content was not " + searchText + ", got " + displayedSearchText);
            return;
        }
        
        Log.Checkpoint("The search textbox content was " + searchText);
        
        
        //Valider avec OK et vérifier le résultat de la recherche
        
        Get_WinQuickSearch_BtnOK().Click();
        
        var rowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 1; i <= rowCount; i++){
          var displayedAccountName = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.get_Name();
          var isActiveValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).get_IsActive();
          if ((displayedAccountName == accountName) && (isActiveValue == true)){
              Log.Checkpoint("Arrow was positioned on an account of " + accountName);
              return
          }
        }
        
        Log.Error("Arrow was not positioned on an account of " + accountName);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}