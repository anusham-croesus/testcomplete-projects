//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifie dans le module Comptes que lorsqu'on sélectionne plusieurs entrées avec la combinaison du SHIFT + le rollover de la souris,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
    Scripté sur la version : ref90-05-8--V9-CX_1-co6x
*/
function CR1352_CROES_6243_Acc_TestDeSelectionMultipleAvecShift_MouseWheel()
{
    CR1352_CROES_6243_Acc_TestDeSelectionMultipleAvecShift("MouseWheel");
}



/**
    Description : Vérifie dans le module Comptes que lorsqu'on sélectionne plusieurs entrées avec la touche SHIFT,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
*/
function CR1352_CROES_6243_Acc_TestDeSelectionMultipleAvecShift(selectionMethod)
{
    if (GetIndexOfItemInArray(["MouseWheel", "DownKey", "ScrollDown"], selectionMethod) == -1){
        Log.error(selectionMethod + " not expected for the selectionMethod parameter.");
        return;
    }
	
    try {
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Récupérer le nombre total de comptes
        Login(vServerAccounts, userNameGP1859, passwordGP1859, language);
        accountsTotalCount = GetAccountsTotalCount();
        Terminate_CroesusProcess();
        
        
        /************  Sélectionner toute la grille des Comptes à l'aide de la touche SHIFT  ************/
        
        Login(vServerAccounts, userNameGP1859, passwordGP1859, language);
        Get_MainWindow().Maximize(); //Pour qu'il n'y ait pas de barre de défilement horizontale.
        Get_ModulesBar_BtnAccounts().Click();
        
        //Naviguer à la première ligne
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
        
        //Cliquer sur la première ligne
        firstRowAccountNo = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_AccountNumber());
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", firstRowAccountNo, 10).Click();
        
        //Maintenir la touche SHIFT enfoncée
        Sys.Desktop.KeyDown(0x10);
        
        //Naviguer à la dernière page
        if (selectionMethod == "MouseWheel"){
            for (var i = 0; i < accountsTotalCount; i++)
                Get_RelationshipsClientsAccountsGrid().MouseWheel(-1);
        }
        else if (selectionMethod == "DownKey"){
            for (var i = 0; i < accountsTotalCount; i++)
                Get_RelationshipsClientsAccountsGrid().Keys("[Down]");
        }
        else if (selectionMethod == "ScrollDown")
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 30);
        
        //Dans le cas du MouseWheel et du ScrollDown, cliquer sur la dernière ligne 
        if (selectionMethod == "MouseWheel" || selectionMethod == "ScrollDown"){
            accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
            lastRowAccountNo = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(accountsPageCount - 1).DataItem.get_AccountNumber());
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", lastRowAccountNo, 10).Click();
        }
        
        //Relâcher la touche Shift
        Sys.Desktop.KeyUp(0x10);
        
        
        /************  Vérifier que toutes les lignes ont été sélectionnées  ************/
        
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
        arrayOfAllAccountsNumbers = new Array();
        nbOfUnselectedAccounts = 0;
        nbOfSelectedAccounts = 0;
        
        while (arrayOfAllAccountsNumbers.length < accountsTotalCount){
            accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
            
            for (var i = 0; i < accountsPageCount; i++){
                displayedAccountNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
                isFound = false;
                for (var j = 0; j < arrayOfAllAccountsNumbers.length; j++){
                    if (displayedAccountNumber == arrayOfAllAccountsNumbers[j]){ 
                        isFound = true;
                        break;
                    }
                }
			    
                if (!isFound){
                    arrayOfAllAccountsNumbers.push(displayedAccountNumber);
                    isRowSelected = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).get_IsSelected();
                    if (isRowSelected)
                        nbOfSelectedAccounts ++;
                    else
                        nbOfUnselectedAccounts ++;
    			}
            }
            
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        }
        
        Log.Message("The number of unselected accounts is : " + nbOfUnselectedAccounts);
        CheckEquals(nbOfSelectedAccounts, accountsTotalCount, "The number of selected accounts");
        
        if (nbOfSelectedAccounts < accountsTotalCount)
        {if(client == "US" || client == "TD")Log.Error("Bug CROES-6800");
          else  Log.Error("Bug CROES-6243");}
          
        Get_MainWindow().Restore();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Sys.Desktop.KeyUp(0x10); //Relâcher la touche Shift
        Terminate_CroesusProcess();
    }
}


function GetAccountsTotalCount()
{
    Get_ModulesBar_BtnAccounts().Click();
    
    //Naviguer à la dernière page et récupérer le dernier numéro de compte
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 30);
    var accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
    var lastRowAccountNo = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(accountsPageCount - 1).DataItem.get_AccountNumber());
    
    //Naviguer à la première ligne
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    var arrayOfAllAccountsNumbers = new Array();
    var isEndOfGridReached = false;
    
    while (!isEndOfGridReached){
        Get_RelationshipsClientsAccountsGrid().Refresh();
        var accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (var i = 0; i < accountsPageCount; i++){
            var displayedAccountNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
            var isFound = false;
            for (var j = 0; j < arrayOfAllAccountsNumbers.length; j++){
                if (displayedAccountNumber == arrayOfAllAccountsNumbers[j]){ 
                    isFound = true;
                    break;
                }
            }
			
            if (!isFound)
                arrayOfAllAccountsNumbers.push(displayedAccountNumber);
            
            isEndOfGridReached = (displayedAccountNumber == lastRowAccountNo);
        }
        
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
    }
    
    Log.Message("The Accounts total count is : " + arrayOfAllAccountsNumbers.length);
    return arrayOfAllAccountsNumbers.length;
}