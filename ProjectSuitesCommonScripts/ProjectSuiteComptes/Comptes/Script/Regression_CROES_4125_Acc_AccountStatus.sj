//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/*
    Description : Valider les changements des status dans le module compte.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4125
    La partie export excel est couvert par le CR1483
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/

function Regression_CROES_4125_Acc_AccountStatus()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4125", "Croes-4125");
    
    var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo_Croes4125", language+client);
    var account= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "account_Croes4125", language+client);
    var Open= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "status1", language+client);
    var Closed= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "status2", language+client);
    var Deleted= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "status3", language+client);
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
        
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //Rétablir la configuration par défaut des colonnes
        
    Log.Message("Restore columns default configuration.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
   //Ajouter la colonne 'Statut'        
    Log.Message("Add the 'Status' column.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Status().Click();
        
        
    //Vérifier que la colonne 'Statut' est affichée
        
    if (!(Get_AccountsGrid_ChStatus().Exists)){
        Log.Error("'Status' column not displayed. This is not expected.");
        return;
    }
        
    Log.Checkpoint("'Status' column displayed.");
    
    //Sélectionner le compte 800227-JW
    SelectAccounts(accountNo);
    
    ////Vérifier que le satut est à "Ouvert"
    var nLigneAccount= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Record.index;
    var stat= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(nLigneAccount).DataItem.StatusDescription.OleValue;

    Log.Message(stat);
        if (stat == Open){
        Log.Checkpoint("The status " + Open+ " was expected to be displayed")
            
        }
        else{
            Log.Error("The status " +Open+ " was not found")
        }
        
    //Changer le statut du compte "800227-JW" à "Fermé" avec la requête suivante
    Execute_SQLQuery_GetFieldAllValues("select * from b_compte update b_compte set status =2 where no_compte ='800227-jw'",vServerAccounts, "STATUS" )
    
    
    //Vérifier que le satut a changé sur le module Compte
    SelectAccounts(accountNo);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    var nLigneAccount= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Record.index;
    var stat= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(nLigneAccount).DataItem.StatusDescription.OleValue;

    Log.Message(stat);
        if (stat == Closed){
        Log.Checkpoint("The status " + Closed+ " was expected to be displayed")
            
        }
        else{
            Log.Error("The status " +Closed+ " was not found")
        }
    
    //Changer le statut du compte "800227-JJ" à "Supprimé" avec la requête suivante :
    Execute_SQLQuery_GetFieldAllValues("select * from b_compte update b_compte set status =3 where no_compte ='800227-jj'",vServerAccounts, "STATUS" )
    
    //Vérifier que le satut a changé sur le module Compte
    SelectAccounts(account);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    var Ligne= Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10).Record.index;
    var stat= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(Ligne).DataItem.StatusDescription.OleValue;

    Log.Message(stat);
        if (stat == Deleted){
        Log.Checkpoint("The status " + Deleted+ " was expected to be displayed")
            
        }
        else{
            Log.Error("The status " +Deleted+ " was not found")
        }
        
    //Rétablir la configuration par défaut des colonnes
        
      Log.Message("Restore columns default configuration.");
      Get_AccountsGrid_ChStatus().ClickR();
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
   
    //Rénitialiser l'état des status
     Execute_SQLQuery_GetFieldAllValues("select * from b_compte update b_compte set status =1 where no_compte ='800227-jw'",vServerAccounts, "STATUS" )
     Execute_SQLQuery_GetFieldAllValues("select * from b_compte update b_compte set status =1 where no_compte ='800227-jj'",vServerAccounts, "STATUS" )
    
     }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
   finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}
