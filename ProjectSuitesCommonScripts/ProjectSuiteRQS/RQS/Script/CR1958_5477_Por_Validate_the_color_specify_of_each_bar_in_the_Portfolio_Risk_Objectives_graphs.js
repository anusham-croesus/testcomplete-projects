//USEUNIT CR1958_Helper




/**
    Description : Validate the color specify of each bar in the Portfolio Risk Objectives graphs
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5477
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5477_Por_Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5477", "CR1958_5477_Por_Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs()");
    Log.Message("Bug JIRA CROES-11305 : L'application Croesus ferme lorsqu'on click sur l'onglet sommaire dans le module modèles.");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    
    var clientIACode = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5477_IACode", language + client);
    var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5477_ClientNumber", language + client);
    var expectedClientPortfolioName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5477_PortFolio_DisplayedName", language + client);
    var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
    var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5477_CheckTrianglesDisplayInGraph", language + client));
    
    Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs(clientIACode, clientNumber, expectedClientPortfolioName, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay, true);
}



function Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs(clientIACode, clientNumber, expectedClientPortfolioName, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay, isGeneric)
{
    if (isGeneric == undefined)
        isGeneric = false;
    
    try {
        var clientPreviousIACode = null;
        
        var arrayOfArrayOfSecurityRiskRatingsWeights = CR1958_SECURITY_RISK_RATINGS_WEIGHTS;
        var arrayOfExpectedColors = CR1958_Get_ArrayOfAllocationColors(client);
        //var arrayOfExpectedColors = (isGeneric === true)? CR1958_Get_ArrayOfAllocationColors("BNC"): CR1958_RISK_ALLOCATION_LEVELS_COLORS;
        var arrayOfRiskAllocationLevels = CR1958_RISK_ALLOCATION_LEVELS;
        var arrayOfRiskAllocationClientProfileNames = CR1958_RISK_ALLOCATION_CLIENT_PROFILE_NAMES
        
        //User DARWIC
        var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        //Change the client IACode in order to make it available for the user
        clientPreviousIACode = Execute_SQLQuery_GetField("select NO_REP from B_CLIENT where NO_CLIENT = '" + clientNumber + "'", vServerRQS, "NO_REP");
        UpdateIACodeForClient(clientNumber, clientIACode, vServerRQS)
        
        //Prealables
        var firm_code = GetUserFirmCode(userDARWIC, vServerRQS);
        var arrayOfPrefsValues = CR1958_GetArrayOfPrefsValues();
        
        var arrayOfPrefsPreviousValues = new Array();
        for (var prefKey in arrayOfPrefsValues)
            arrayOfPrefsPreviousValues[prefKey] = GetFirmPrefValue(vServerRQS, prefKey, firm_code);
        
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsValues, arrayOfPrefsPreviousValues);
        
        SetRiskAllocationLevelsWeightsAndClientProfileNames(arrayOfArrayOfSecurityRiskRatingsWeights, arrayOfRiskAllocationClientProfileNames, false);
        
        //Login
        Login(vServerRQS, userDARWIC, pswdDARWIC, language);
        
        //Go to the Client module and Drag the Client to the Portfolio
        Log.Message("1.1. Open the client module and then drag and drop the client '" + clientNumber + "' to Portfolio module.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        Search_Client(clientNumber);
        var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "ClientNumber", clientNumber], 10);
        if (!clientNumberCell.Exists){
            Log.Error("Client Number '" + clientNumber + "' not found.");
            return CloseCroesus();
        }
        
        Drag(clientNumberCell, Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName(), "WPFControlText", cmpEqual, expectedClientPortfolioName);
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
        Get_PortfolioGrid_GrpSummary().Click(Get_PortfolioGrid_GrpSummary().Width - 40, Get_PortfolioGrid_GrpSummary().Height - 8);
        
        CheckIfRiskAllocationGraphIsDisplayedAtTheBottomRightSideOfTheScreen();
        CheckRiskObjectivesGraphDisplayInPortfolio(CR1958_RISK_ALLOCATION_LEVELS, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
        
        Log.Message("1.2. Validate the color specified for each bar in the risk objective graph.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        for (var k in arrayOfRiskAllocationLevels){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[k];
            var rectangleObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
            if (!rectangleObject.Exists){
                Log.Error("Risk allocation level '" + riskAllocationLevel + "' Rectangle component not found.");
                continue;
            }
            var actualColor = rectangleObject.Fill.Color;
            var actualColorHexValue = aqString.Format("%02x%02x%02x", actualColor.R, actualColor.G, actualColor.B);
            var expectedColor = arrayOfExpectedColors[riskAllocationLevel];
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color # is : " + expectedColor.Hex);
            if (!CheckEquals(actualColorHexValue, expectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #")){
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component is : " + expectedColor.R);
                CheckEquals(actualColor.R, expectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component is : " + expectedColor.G);
                CheckEquals(actualColor.G, expectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component is : " + expectedColor.B);
                CheckEquals(actualColor.B, expectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component");
            }
        }
        
        
        //Take the Screenshot of the Portfolio Risk Objectives graph in the models and portfolio and past in the Paint and click 3D ; Validate whith the color table
        Log.Message("2. Take the Screenshot of the Portfolio Risk Objectives graph in the portfolio and paste in the Paint and click 3D ; Validate whith the color table.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        for (var k in arrayOfRiskAllocationLevels){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[k];
            Log.Message("Validations for Risk allocation level '" + riskAllocationLevel + "'.");
            var rectangleObject = Get_PortfolioGrid_GrpSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
            if (!rectangleObject.Exists){
                Log.Error("Risk allocation level '" + riskAllocationLevel + "' Rectangle component not found.");
                continue;
            }
            if (rectangleObject.Width < 2){
                Log.Warning("Risk allocation level '" + riskAllocationLevel + "' Rectangle bar Width, " + rectangleObject.Width + " pixel < 2 pixels.", "", pmHigher, null, Sys.Desktop.Picture());
                continue;
            }
            
            var actualColor = GetRGBColorThroughMsPaint(rectangleObject.Picture(1, 1, rectangleObject.Width-1, rectangleObject.Height-2, false));
            var expectedColor = arrayOfExpectedColors[riskAllocationLevel];
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color # is : " + expectedColor.Hex);
            if (!CheckEquals(actualColor.Hex, expectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #")){
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component is : " + expectedColor.R);
                CheckEquals(actualColor.R, expectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component is : " + expectedColor.G);
                CheckEquals(actualColor.G, expectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component is : " + expectedColor.B);
                CheckEquals(actualColor.B, expectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component");
            }
        }
        
        //Take the Screenshot of the Portfolio Risk Objectives graph in the models and portfolio and past in the Paint and click 3D ; Validate whith the color table
        Log.Message("2. Take the Screenshot of the Portfolio Risk Objectives graph in the models and paste in the Paint and click 3D ; Validate whith the color table.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Models_Details_TabSummary().Click();
        Log.Message("Bug JIRA CROES-11305 : L'application Croesus ferme lorsqu'on click sur l'onglet sommaire dans le module modèles.");
        Get_Models_Details_TabSummary().WaitProperty("IsSelected", true, 100000);
        Get_Models_Details().set_IsExpanded(true);
        Get_Models_Details().Click(Get_Models_Details().Width - 40, Get_Models_Details().Height - 8);
        
        for (var k in arrayOfRiskAllocationLevels){
            var riskAllocationLevel = arrayOfRiskAllocationLevels[k];
            Log.Message("Validations for Risk allocation level '" + riskAllocationLevel + "'.");
            var rectangleObject = Get_Models_Details_TabSummary_PnlRQSCharts_GraphRiskObjectives_RectangleForLevel(riskAllocationLevel);
            if (!rectangleObject.Exists){
                Log.Error("Risk allocation level '" + riskAllocationLevel + "' Rectangle component not found.");
                continue;
            }
            if (rectangleObject.Width < 2){
                Log.Warning("Risk allocation level '" + riskAllocationLevel + "' Rectangle bar Width, " + rectangleObject.Width + " pixel < 2 pixels.", "", pmHigher, null, Sys.Desktop.Picture());
                continue;
            }
            
            var actualColor = GetRGBColorThroughMsPaint(rectangleObject.Picture(1, 1, rectangleObject.Width-1, rectangleObject.Height-2, false));
            var expectedColor = arrayOfExpectedColors[riskAllocationLevel];
            Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color # is : " + expectedColor.Hex);
            if (!CheckEquals(actualColor.Hex, expectedColor.Hex, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color #")){
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component is : " + expectedColor.R);
                CheckEquals(actualColor.R, expectedColor.R, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color R component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component is : " + expectedColor.G);
                CheckEquals(actualColor.G, expectedColor.G, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color G component");
                Log.Message("Check if Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component is : " + expectedColor.B);
                CheckEquals(actualColor.B, expectedColor.B, "Risk allocation level '" + riskAllocationLevel + "' Rectangle bar color B component");
            }
        }
        
        //Close Croesus
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        //Restore Client IA Code
        UpdateIACodeForClient(clientNumber, clientPreviousIACode, vServerRQS);
        
        //Restore prefs
        UpdateFirmArrayOfPrefs(vServerRQS, firm_code, arrayOfPrefsPreviousValues, arrayOfPrefsValues);
        
        Terminate_CroesusProcess();
        TerminateProcess("mspaint");
        TerminateProcess("Microsoft.MSPaint");
    }
}





function GetRGBColorThroughMsPaint(pictureObject)
{
    //try catch, 2X 
    
    var pictureColorRGBHex = {R: '', G: '', B: '', Hex: '' };
    var isSuccessfull = false;
    var maxTries = 3;
    
    //Launch Ms Paint
    TerminateProcess("mspaint");
    TerminateProcess("Microsoft.MSPaint");
    var tryNum = 0;
    do {
        WshShell.Run("mspaint");
        var processMsPaint = Sys.WaitProcess("mspaint", PROJECT_AUTO_WAIT_TIMEOUT);
    } while (!processMsPaint.Exists && ++tryNum < maxTries)
    
    if (!processMsPaint.Exists){
        Log.Error("Not able to launch MsPaint. Thus, GetRGBColorThroughMsPaint() was not successfull.");
        return pictureColorRGBHex;
    }
    
    processMsPaint.WaitProperty("CPUUsage", 10, 5000);
    processMsPaint.WaitProperty("CPUUsage", 0, PROJECT_AUTO_WAIT_TIMEOUT);
    var winMsPaint = processMsPaint.FindChildEx(["WndClass", "Visible", "Enabled"], ["MSPaintApp", true, true], 10, true, -1);
    winMsPaint.Maximize();
    winMsPaint.Keys("^e");
    if (winMsPaint.WndCaption == "Untitled - Paint")
        processMsPaint.FindChildEx(["WndClass", "WndCaption"], ["#32770", "Image Properties"], 10, true, -1).Keys("~p~l~w1~h1[Enter]");
    else
        processMsPaint.FindChildEx(["WndClass", "WndCaption"], ["#32770", "Propriétés de l'image"], 10, true, -1).Keys("~x~o~l1~h1[Enter]");
    
    //Paste picture in Ms Paint
    Sys.Clipboard = pictureObject;
    Delay(1000);
    winMsPaint.Keys("^v");
    Delay(300);
    winMsPaint.Keys("[Esc]^w");
    if (winMsPaint.WndCaption == "Untitled - Paint")
        processMsPaint.FindChildEx(["WndClass", "WndCaption"], ["#32770", "Resize and Skew"], 10, true, -1).Keys("[Tab]500[Enter]");
    else
        processMsPaint.FindChildEx(["WndClass", "WndCaption"], ["#32770", "Redimensionner et incliner"], 10, true, -1).Keys("[Tab]500[Enter]");
    
    //Edit with Paint 3D
    var tryNum = 0;
    do {
        TerminateProcess("Microsoft.MSPaint");
        /*Delay(500);
        winMsPaint.Keys("^a^c");*/
        Delay(1000);
        winMsPaint.Keys("~hp3");
        
        var dlgMsPaintSave = processMsPaint.FindChildEx(["WndClass", "WndCaption"], ["#32770", "Paint"], 10, true, 10000);
        if (dlgMsPaintSave.Exists)
            dlgMsPaintSave.Keys("n");
        
        var processMsPaint3D = Sys.FindChildEx("ProcessName", "Microsoft.MSPaint", 0, true, -1);
        if (processMsPaint3D.Exists){
            processMsPaint3D.WaitProperty("CPUUsage", 10, 5000);
            processMsPaint3D.WaitProperty("CPUUsage", 0, PROJECT_AUTO_WAIT_TIMEOUT);
            
            var numTry = 0;
            do {
                numTry++;
                Sys.Refresh();
                Delay(numTry * 3000);
                var winMsPaint3D = processMsPaint3D.FindChildEx(["ClassName", "ObjectIdentifier"], ["Windows.UI.Core.CoreWindow", "Paint_3D"], 10, true, -1);
                Delay(numTry * 3000);
            } while (!winMsPaint3D.Exists && numTry < 5)
            
            Sys.Refresh();
            winMsPaint3D.Keys("[Esc]");
            
            //Log.Message("Maintenance probablement requise, advenant qu'un composant ne soit pas trouvé.", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
            Log.Message("Si un composant n'arrive pas à être trouvé, Essayer d'activer \"Windows Store Applications\" dans les options de TestExecute, en cochant la case à cocher \"Enable support for testing Windows Store applications (require restart)\".", "", pmHighest, CR1958_LOG_ATTRIBUTES_BOLD);
            
            Delay(500);
            winMsPaint3D.Maximize();
            /*Delay(500);
            winMsPaint3D.Keys("^a");
            Delay(500);
            winMsPaint3D.Keys("[Del]");
            Delay(500);
            winMsPaint3D.Keys("^v");
            Delay(500);
            winMsPaint3D.Keys("[Esc]");*/
            
            Delay(1000);
            winMsPaint3D.Keys("i");;
            Delay(1000);
            var imageCenterX = (winMsPaint3D.Width - 265)/2;
            var imageCenterY = 125 + (winMsPaint3D.Height - 125)/2;
            winMsPaint3D.HoverMouse(imageCenterX, imageCenterY);
            winMsPaint3D.Click(imageCenterX, imageCenterY);
            Delay(1000);
            var addAColorButtonX = winMsPaint3D.Width - 132;
            var addAColorButtonY = winMsPaint3D.Height - 45;
            winMsPaint3D.HoverMouse(addAColorButtonX, addAColorButtonY);
            winMsPaint3D.Click(addAColorButtonX, addAColorButtonY);
            Delay(2000);
            
            //Red component value
            var redValueGetTries = 0;
            do {
                winMsPaint3D.Keys("^c");
                Delay(500); 
                pictureColorRGBHex.R = GetClipboardContent();
                winMsPaint3D.Keys("[Tab]");
            } while(++redValueGetTries < 4 && !(GetVarType(pictureColorRGBHex.R) == varOleStr && Trim(pictureColorRGBHex.R) != ""))
        
             //Green component value
            winMsPaint3D.Keys("^c");
            Delay(500);
            pictureColorRGBHex.G = GetClipboardContent();
            winMsPaint3D.Keys("[Tab]");
        
            //Blue component value
            winMsPaint3D.Keys("^c");
            Delay(500);
            pictureColorRGBHex.B = GetClipboardContent();
            winMsPaint3D.Keys("[Tab]");
            
            //RGB Hexadecimal value
            winMsPaint3D.Keys("^c");
            Delay(500);
            pictureColorRGBHex.Hex = GetClipboardContent();
        }
        
        isSuccessfull = ((GetVarType(pictureColorRGBHex.R) == varOleStr && Trim(pictureColorRGBHex.R) != "") &&
                         (GetVarType(pictureColorRGBHex.G) == varOleStr && Trim(pictureColorRGBHex.G) != "") &&
                         (GetVarType(pictureColorRGBHex.B) == varOleStr && Trim(pictureColorRGBHex.B) != "") &&
                         (GetVarType(pictureColorRGBHex.Hex) == varOleStr && Trim(pictureColorRGBHex.Hex) != ""));
        
        if (!isSuccessfull){
            winMsPaint3D.Keys("m");
            winMsPaint3D.Close();
        }
        
    } while (!isSuccessfull && ++tryNum < maxTries)
    
    if (!isSuccessfull){
        Log.Error("GetRGBColorThroughMsPaint() was not successfull.");
        pictureColorRGBHex.R = VarToStr(pictureColorRGBHex.R);
        pictureColorRGBHex.G = VarToStr(pictureColorRGBHex.G);
        pictureColorRGBHex.B = VarToStr(pictureColorRGBHex.B);
        pictureColorRGBHex.Hex = VarToStr(pictureColorRGBHex.Hex);
    }
    
    return pictureColorRGBHex;
}


function GetClipboardContent()
{
    //Attendre que le presse-papier soit mis à jour et en récupérer le contenu
    var nbOfTries = 0;
	var isTextFoundInClipboard = false;
    while (nbOfTries < 20){
		var retrievedText = Sys.Clipboard;
		isTextFoundInClipboard = (GetVarType(retrievedText) == varOleStr && Trim(retrievedText) != "");
		if (isTextFoundInClipboard) break;
        Delay(200);
        nbOfTries++;
    }
    
    Sys.Clipboard = null;
    return retrievedText;
}
