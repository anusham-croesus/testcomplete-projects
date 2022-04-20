//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Mailler un compte dans tous les modules
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1504
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1504_Acc_Drag_an_account_to_all_modules()
{
    
    var accountNo = "800075-JJ";
    
    Login(vServerAccounts, userName, psw, language);
    
    
    //Maillage vers le module Relations
    
    Log.Message("***** DRAG ACCOUNT " + accountNo + " TO RELATIONSHIPS *****");
    
    var actualRelationshipName, actualRelationshipNo;
    if(client == "CIBC"){var expectedRelationshipNo = "00000";
                         var expectedRelationshipName1 ="CLIENTS RELATION"; 
                         var expectedRelationshipName ="#1 TEST";}
    else {var expectedRelationshipNo = "00002";
          var expectedRelationshipName ="#1 TEST";}
    
    Get_ModulesBar_BtnAccounts().Click();
    Search_Account(accountNo);
    
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Relationships().Click();
    Get_MenuBar_Modules_Relationships_DragSelection().Click();
    
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    for (var  i = 0; i < count; i++){
        actualRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
        actualRelationshipNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_LinkNumber();
        Log.Message(i);       
        Log.Message(actualRelationshipName);
        Log.Message(expectedRelationshipName);
        
        Log.Message("The relationship name is " + actualRelationshipName + " ; the relationship number is " + actualRelationshipNo);
        if (client =="CIBC"){
            if (i == 0 && actualRelationshipName == expectedRelationshipName){
                Log.Checkpoint("The relationship name is the expected one");
            }
            else if (i == 1 && actualRelationshipName == expectedRelationshipName1){
               Log.Checkpoint("The relationship name is the expected one");
            } 
            else {
                Log.Error("The relationship name is not the expected one. Expected relation name = " + expectedRelationshipName) ;
            }
        }
      else{
        
        if (actualRelationshipName == expectedRelationshipName){
           Log.Checkpoint("The relationship name is the expected one");
        } 
        else {

            Log.Error("The relationship name is not the expected one. Expected relation name = " + expectedRelationshipName) ;
        }
          
        } 
    }
    
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le filtre
    
    
    //Maillage vers le module Clients
    
    Log.Message("***** DRAG ACCOUNT " + accountNo + " TO CLIENTS *****");
    
    var expectedClientName = "BORTOLUS BRITES";
    var expectedClientNo = "800075";
    var actualClientName, actualClientNo;
    
    SelectAccounts(accountNo);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Clients().Click();
    Get_MenuBar_Modules_Clients_DragSelection().Click();
    
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    for (var i = 0; i < count; i++){
        actualClientName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Name();
        actualClientNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ClientNumber();
        Log.Message("The client name is " + actualClientName + " ; the client number is " + actualClientNo);
        
        if ((actualClientName == expectedClientName) && (actualClientNo == expectedClientNo)){
            Log.Checkpoint("The client name and number are the expected ones");
        }
        else {
            Log.Error("The client name and number are not the expected ones. Expected client name = " + expectedClientName + " ; expected client number = " + expectedClientNo);
        }
    }
    
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le filtre
    
    
    //Maillage vers le module Portefeuille
    
    Log.Message("***** DRAG ACCOUNT " + accountNo + " TO PORTFOLIO *****");
    
    var actualAccountNo ;
    
    SelectAccounts(accountNo);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    var count = Get_Portfolio_PositionsGrid().Items.Count;
    for (var i = 0; i < count; i++){
        actualAccountNo = Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.get_AccountNumber();
        Log.Message("The account number is " + actualAccountNo);
        
        if (actualAccountNo == accountNo){
            Log.Checkpoint("The account number is the expected one.");
        }
        else {
            Log.Error("The account number is not the expected one. Expected account number = " + accountNo);
        }
    }
    
    
    //Maillage vers le module Titres
    
    Log.Message("***** DRAG ACCOUNT " + accountNo + " TO SECURITIES *****");
    
    var expectedSymbol = "1CAD";
    var actualSymbol ;
    
    SelectAccounts(accountNo);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Securities().Click();
    Get_MenuBar_Modules_Securities_DragSelection().Click();
    
    var count = Get_SecurityGrid().RecordListControl.Items.Count;
    for (var i = 0; i < count; i++){
        actualSymbol = Get_SecurityGrid().RecordListControl.Items.Item(i).DataItem.get_Symbol();
        Log.Message("The security symbol is " + actualSymbol);
        
        if (actualSymbol == expectedSymbol){
            Log.Checkpoint("The symbol is the expected one.");
        }
        else {
            Log.Error("The symbol is not the expected one. Expected symbol = " + expectedSymbol);
        }
    }
    
    
    //Maillage vers le module Modèles
    
    Log.Message("***** DRAG ACCOUNT " + accountNo + " TO MODELS *****");
    
    var actualModelName, actualModelNo;
    var expectedModelName = "*FALL BACK";
  /*  if(client == "US" ){
      var expectedModelName = "*FALL B*FALL ACK"
    } */
   
    
    SelectAccounts(accountNo);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Models().Click();
    Get_MenuBar_Modules_Models_DragSelection().Click();
    
    var count = Get_ModelsGrid().RecordListControl.Items.Count;
    for (var i = 0; i < count; i++){
        actualModelName = Get_ModelsGrid().RecordListControl.Items.Item(i).DataItem.get_Name();
        actualModelNo = Get_ModelsGrid().RecordListControl.Items.Item(i).DataItem.get_AccountNumber();
        Log.Message("The model name is " + actualModelName + " ; the model number is " + actualModelNo);
        
        if (actualModelName == expectedModelName){
            Log.Checkpoint("The model name is the expected one");
        }
        else {
            Log.Error("The model name is not the expected one. Expected model name = " + expectedModelName );
        }
    }
    
    
    //Maillage vers le module Transactions
    
    accountNo = "800292-JW";
    Log.Message("***** DRAG ACCOUNT " + accountNo + " TO TRANSACTIONS *****");
    
    var actualAccountNo ;
    
    Get_ModulesBar_BtnAccounts().Click();
    Search_Account(accountNo);
    //SelectAccounts(accountNo);
    Get_RelationshipsClientsAccountsGrid().Find("Text",accountNo,10).Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
    
    var count = Get_TransactionsPlugin().WPFObject("listView").Items.Count;
    for (var i = 0; i < count; i++){
        actualAccountNo = Get_TransactionsPlugin().WPFObject("listView").Items.Item(i).Item(0).Data;
        Log.Message("The account number is " + actualAccountNo);
        
        if (actualAccountNo == accountNo){
            Log.Checkpoint("The account number is the expected one.");
        }
        else {
            Log.Error("The account number is not the expected one. Expected account number = " + accountNo);
        }
    }
    
    
    //Close Croesus
    Close_Croesus_SysMenu();    
}


