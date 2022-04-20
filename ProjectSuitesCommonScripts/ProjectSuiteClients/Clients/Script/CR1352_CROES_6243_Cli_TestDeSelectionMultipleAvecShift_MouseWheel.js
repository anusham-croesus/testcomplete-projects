//USEUNIT Common_functions



/**
    Description : Vérifie dans le module Clients que lorsqu'on sélectionne plusieurs entrées avec la combinaison du SHIFT + le rollover de la souris,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
    Scripté sur la version : ref90-05-8--V9-CX_1-co6x
*/
function CR1352_CROES_6243_Cli_TestDeSelectionMultipleAvecShift_MouseWheel()
{
    CR1352_CROES_6243_Cli_TestDeSelectionMultipleAvecShift("MouseWheel");
}



/**
    Description : Vérifie dans le module Clients que lorsqu'on sélectionne plusieurs entrées avec la touche SHIFT,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
*/
function CR1352_CROES_6243_Cli_TestDeSelectionMultipleAvecShift(selectionMethod)
{
    Log.Message("CR1352_CROES_6243_Cli_TestDeSelectionMultipleAvecShift('" + selectionMethod + "')");
    
    if (GetIndexOfItemInArray(["MouseWheel", "DownKey", "ScrollDown"], selectionMethod) == -1){
        Log.Error(selectionMethod + " not expected for the selectionMethod parameter.");
        return;
    }
    
    try {
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Récupérer le nombre total de clients
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
        var clientsTotalCount = GetClientsTotalCount();
        Close_Croesus_MenuBar();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();
        RestoreAutoTimeOut();
        
        /************  Sélectionner toute la grille des Clients à l'aide de la touche SHIFT  ************/
        
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
        Get_MainWindow().Maximize(); //Pour qu'il n'y ait pas de barre de défilement horizontale.
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        SetAutoTimeOut();
        
        var RecordListControl = Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
        var Width = Get_RelationshipsClientsAccountsGrid().Width;
        var Height = Get_RelationshipsClientsAccountsGrid().Height;
        
        //Naviguer à la première ligne
        Get_RelationshipsClientsAccountsGrid().Click(Width - 10, 50);
        
        //Cliquer sur la première ligne
        var firstRowClientNo = VarToStr(RecordListControl.Items.Item(0).DataItem.get_ClientNumber());
        RecordListControl.FindChild("Value", firstRowClientNo, 10).Click();
        
        //Maintenir la touche SHIFT enfoncée
        Sys.Desktop.KeyDown(0x10);
        
        //Naviguer à la dernière page
        if (selectionMethod == "MouseWheel"){
            for (var i = 0; i < clientsTotalCount; i++)
                if (Get_RelationshipsClientsAccountsGrid().Exists && Get_MainWindow().WaitProperty("Focused", true, 15000)){
                    Get_RelationshipsClientsAccountsGrid().MouseWheel(-1);
                    Delay(100);
                }
                else
                    throw new Error("There was an issue with the Get_RelationshipsClientsAccountsGrid() or Get_MainWindow() component.");
        }
        else if (selectionMethod == "DownKey"){
            for (var i = 0; i < clientsTotalCount; i++)
                if (Get_RelationshipsClientsAccountsGrid().Exists && Get_MainWindow().WaitProperty("Focused", true, 15000)){
                    Get_RelationshipsClientsAccountsGrid().Keys("[Down]");
                    Delay(100);
                }
                else
                    throw new Error("There was an issue with the Get_RelationshipsClientsAccountsGrid() or Get_MainWindow() component.");
        }
        else if (selectionMethod == "ScrollDown")
            Get_RelationshipsClientsAccountsGrid().Click(Width - 10, Height - 30);
        
        //Dans le cas du MouseWheel et du ScrollDown, cliquer sur la dernière ligne
        if (selectionMethod == "MouseWheel" || selectionMethod == "ScrollDown"){
            var lastRowClientNo = GetMostBottomDisplayedClientNumber();
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", lastRowClientNo, 10).Click();
        }
        
        //Relâcher la touche Shift
        Sys.Desktop.KeyUp(0x10);
        
        
        /************  Vérifier que toutes les lignes ont été sélectionnées  ************/
        Get_RelationshipsClientsAccountsGrid().Click(Width - 10, 50);
        var previousArrayOfAllClientsNumbers = new Array();
        var arrayOfAllClientsNumbers = new Array();
        var nbOfUnselectedClients = 0;
        var nbOfSelectedClients = 0;
        var watchDogMaxCount = 50;
        var watchDogCount = 0;
        
        while (arrayOfAllClientsNumbers.length < clientsTotalCount){
            var RecordListControl = Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
            var clientsPageCount = RecordListControl.Items.get_Count();
            
            var Width = Get_RelationshipsClientsAccountsGrid().Width;
            var Height = Get_RelationshipsClientsAccountsGrid().Height;
            
            for (var i = 0; i < clientsPageCount; i++){
                var displayedClientNumber = VarToStr(RecordListControl.Items.Item(i).DataItem.get_ClientNumber());
                var isFound = false;
                for (var j = 0; j < arrayOfAllClientsNumbers.length; j++){
                    if (displayedClientNumber == arrayOfAllClientsNumbers[j]){ 
                        isFound = true;
                        break;
                    }
                }
			    
                if (!isFound){
                    arrayOfAllClientsNumbers.push(displayedClientNumber);
                    if (true == RecordListControl.Items.Item(i).get_IsSelected())
                        nbOfSelectedClients ++;
                    else
                        nbOfUnselectedClients ++;
    			}
            }
            
            watchDogCount = ArrayWatchDog(arrayOfAllClientsNumbers, previousArrayOfAllClientsNumbers, watchDogMaxCount, watchDogCount);
            previousArrayOfAllClientsNumbers = arrayOfAllClientsNumbers;
            
            if (arrayOfAllClientsNumbers.length < clientsTotalCount){
                if (Get_RelationshipsClientsAccountsGrid().Exists)
                    Get_RelationshipsClientsAccountsGrid().Click(Width - 10, Height - 40);
                else
                    throw new Error("Get_RelationshipsClientsAccountsGrid() does not exist, this is unexpected.");
            }
        }
        
        Log.Message("The number of unselected clients is : " + nbOfUnselectedClients);
        CheckEquals(nbOfSelectedClients, clientsTotalCount, "The number of selected clients");
        
        if (nbOfSelectedClients < clientsTotalCount){
            if (client == "US")
                Log.Error("Bug CROES-6243");
            else
                Log.Error("Bug CROES-6243");
        }
        
        Close_Croesus_MenuBar();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();
        RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Sys.Desktop.KeyUp(0x10); //Relâcher la touche Shift
        Terminate_CroesusProcess();
    }
}



function GetMostBottomDisplayedClientNumber()
{
    var allDisplayedClientNumberCells = GetAllDisplayedClientNumberCells();
    if (allDisplayedClientNumberCells.length == 0){
        Log.Error("No visible Client Number cell found.");
        return "";
    }
    
    var mostBottomDisplayedClientNumberCell = allDisplayedClientNumberCells[0];
    for (var k = 1; k < allDisplayedClientNumberCells.length; k++)
        if (allDisplayedClientNumberCells[k].Top > mostBottomDisplayedClientNumberCell.Top)
            mostBottomDisplayedClientNumberCell = allDisplayedClientNumberCells[k];
    
    return VarToStr(mostBottomDisplayedClientNumberCell.WPFControlText);
}


function GetAllDisplayedClientNumbers()
{
    var allDisplayedClientNumbers = new Array();
    var allDisplayedClientNumberCells = GetAllDisplayedClientNumberCells();
    for (var k = 0; k < allDisplayedClientNumberCells.length; k++)
        allDisplayedClientNumbers.push(VarToStr(allDisplayedClientNumberCells[k].WPFControlText));
    return allDisplayedClientNumbers;
}


function GetAllDisplayedClientNumberCells()
{
    var allDisplayedClientNumberCells = new Array();
    
    var RecordListControl = Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    if (!RecordListControl.Exists)
        Log.Error("RecordListControl component not found.");
    else {
        allDisplayedClientNumberCells = RecordListControl.FindAllChildren(["ClrClassName", "Uid", "VisibleOnScreen"], ["CellValuePresenter", "ClientNumber", true], 10).toArray();
        if (allDisplayedClientNumberCells.length == 0)
            Log.Message("No visible Client Number cell found.");
    }
    
    return allDisplayedClientNumberCells;
}



function GetClientsTotalCount()
{
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    SetAutoTimeOut();
    
    //Récupérer le numéro Client de la dernière ligne
    Get_RelationshipsClientsAccountsGrid().Keys("^[End]");
    Get_RelationshipsClientsAccountsGrid().Refresh();
    var lastRowClientNo = GetMostBottomDisplayedClientNumber();
    
    //Naviguer à la première ligne
    Get_RelationshipsClientsAccountsGrid().Keys("^[Home]");
    Get_RelationshipsClientsAccountsGrid().Refresh();
    var arrayOfAllClientsNumbers = GetAllDisplayedClientNumbers();
    var previousArrayOfAllClientsNumbers = new Array();
    var watchDogMaxCount = 50;
    var watchDogCount = 0;
    
    while (GetMostBottomDisplayedClientNumber() != lastRowClientNo){
        if (Get_RelationshipsClientsAccountsGrid().Exists)
            Get_RelationshipsClientsAccountsGrid().Keys("[PageDown]");
        else
            throw new Error("Get_RelationshipsClientsAccountsGrid() does not exist, this is unexpected.");
        
        Get_RelationshipsClientsAccountsGrid().Refresh();
        var arrayOfAllDisplayedClientNumbers = GetAllDisplayedClientNumbers();
        for (var k = 0; k < arrayOfAllDisplayedClientNumbers.length; k++)
            if (GetIndexOfItemInArray(arrayOfAllClientsNumbers, arrayOfAllDisplayedClientNumbers[k]) == -1)
                arrayOfAllClientsNumbers.push(arrayOfAllDisplayedClientNumbers[k]);
        
        watchDogCount = ArrayWatchDog(arrayOfAllClientsNumbers, previousArrayOfAllClientsNumbers, watchDogMaxCount, watchDogCount);
        previousArrayOfAllClientsNumbers = arrayOfAllClientsNumbers;
    }
    
    Log.Message("The Clients total count is : " + arrayOfAllClientsNumbers.length);
    RestoreAutoTimeOut();
    return arrayOfAllClientsNumbers.length;
}



function ArrayWatchDog(currentArray, previousArray, watchDogMaxCount, watchDogCount)
{
    if (watchDogCount == undefined)
        watchDogCount = 0;
    
    for (var k = 0; k < currentArray.length; k++)
        if (GetIndexOfItemInArray(previousArray, currentArray[k]) == -1)
            return 0;
    
    watchDogCount++;
    
    if (watchDogCount >= watchDogMaxCount)
        throw new Error("The Array did not evolve by " + watchDogMaxCount + " loops ; this is unexpected.");
    
    return watchDogCount;
}
