//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions


/**
    Description : Recherche rapide par No Compte
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1617
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1617_Acc_Quick_Search_by_Account_Number()
{
    try {
        var accountNo = "300001-NA";
        var searchNo = "300001";
        var searchNoFirstChar = aqString.GetChar(searchNo, 0);
        
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        
        //Saisir le premier caractère et vérifier que la fenêtre Rechercher est affichée avec l'option No Compte sélectionné
        
        Log.Message("Hit the first character of the number " + searchNo);
        Get_RelationshipsClientsAccountsGrid().Keys(searchNoFirstChar);
        
        if (!(Get_WinQuickSearch().Exists)){
            Log.Error("The Quick Search window was not displayed.");
            return;
        }
        
        Log.Checkpoint("The Quick Search window was displayed.");
        
        if (!(Get_WinAccountsQuickSearch_RdoAccountNo().IsChecked)){
            Log.Error("The 'Account No.' option was not selected.");
            return;
        }
        
        Log.Checkpoint("The 'Account No.' option was selected.");
        
        var displayedSearchText = Get_WinQuickSearch_TxtSearch().Text;
        if (displayedSearchText != searchNoFirstChar){
            Log.Error("The search textbox content was not " + searchNoFirstChar + ", got " + displayedSearchText);
            return;
        }
        
        Log.Checkpoint("The search textbox content was " + searchNoFirstChar);
        
        
        //Saisir le reste des caractères
        
        Log.Message("Hit the remaining characters of the number " + searchNo);
        Get_WinQuickSearch_TxtSearch().Keys(aqString.SubString(searchNo, 1, (aqString.GetLength(searchNo) - 1)));
        
        var displayedSearchText = Get_WinQuickSearch_TxtSearch().Text;
        if (displayedSearchText != searchNo){
            Log.Error("The search textbox content was not " + searchNo + ", got " + displayedSearchText);
            return;
        }
        
        Log.Checkpoint("The search textbox content was " + searchNo);
        
        
        //Valider avec OK et vérifier le résultat de la recherche
        
        Get_WinQuickSearch_BtnOK().Click();
        
        var rowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 1; i <= rowCount; i++){
          var displayedAccountNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").DataContext.DataItem.AccountNumber;
          var isDisplayedAccountActive = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).WPFObject("RecordSelector", "", 1).IsActive;
          if (displayedAccountNo == accountNo && isDisplayedAccountActive){
              Log.Checkpoint("Arrow was positioned on account No " + accountNo);
              return;
          }
        }
        
        Log.Error("Arrow was not positioned on account No " + accountNo);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}