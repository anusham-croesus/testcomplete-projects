//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Recherche rapide par Code de CP
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1619
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1619_Acc_Quick_Search_by_IA_Code()
{
    try {
        var searchText = "BD88";
        var searchTextFirstChar = aqString.GetChar(searchText, 0);
    
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Saisir le premier caractère et vérifier que la fenêtre Rechercher est affichée
    
        Log.Message("Hit the first character of the text " + searchText);
        Get_RelationshipsClientsAccountsGrid().Keys(searchTextFirstChar);
        
        if (!(Get_WinQuickSearch().Exists)){
            Log.Error("The Quick Search window was not displayed.");
            return;
        }
        
        Log.Checkpoint("The Quick Search window was displayed.");
        
        var displayedSearchText = Get_WinQuickSearch_TxtSearch().Text;
        if (displayedSearchText != searchTextFirstChar){
            Log.Error("The search textbox content was not " + searchTextFirstChar + ", got " + displayedSearchText);
            return;
        }
        
        Log.Checkpoint("The search textbox content was " + searchTextFirstChar);
        
        
        //Saisir le reste des caractères et sélectionner l'option 'Code de CP'
        
        Log.Message("Hit the remaining characters of the text " + searchText);
        Get_WinQuickSearch_TxtSearch().Keys(aqString.SubString(searchText, 1, (aqString.GetLength(searchText) - 1)));
        
        var displayedSearchText = Get_WinQuickSearch_TxtSearch().Text;
        if (displayedSearchText != searchText){
            Log.Error("The search textbox content was not " + searchText + ", got " + displayedSearchText);
            return;
        }
        
        Log.Checkpoint("The search textbox content was " + searchText);
        
        Get_WinAccountsQuickSearch_RdoIACode().set_IsChecked(true);
        
        
        //Valider avec OK et vérifier le résultat de la recherche
        
        Get_WinQuickSearch_BtnOK().Click();
        Log.Message("Crash lors de la recherche de compte par Code CP. L'anomalie ouverte par Karima- CROES-8311")
        var rowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        
        for (var i = 0; i < rowCount; i++){
            var displayedIACode = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_RepresentativeNumber(); // Avant RepresentativeId
            var isActiveValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", (i + 1)).WPFObject("RecordSelector", "", 1).IsActive;
            if ((displayedIACode == searchText) && (isActiveValue == true)){
                Log.Checkpoint("Arrow was positioned on an account of IA Code : " + displayedIACode);
                return
            }
        }
        
        Log.Error("Arrow was not positioned on an account of IA Code : " + searchText);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}