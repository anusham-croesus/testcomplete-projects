//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions

//
// Description : Valider l'ajout de colonne dans la grille Comptes
// Analyste d'assurance qualité: Reda Alfaiz
// Analyste d'automatisation: Christophe Paring
//

function CR1352_1557_Acc_Confirm_adding_column()
{   
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    boldAttribute.Bold = true;
    
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1557", "Cas de tests JIRA CROES-1557");
    Log.AppendFolder("Preparation of test envionment on " + vServerAccounts + " for client " + client + " using username " + userName + ".");   
    
    Login(vServerAccounts, userName, psw, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
    Log.PopLogFolder();
    Log.Message("Croesus Desktop on " + vServerAccounts + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
    
    // Test 1
    Log.AppendFolder("Test 1: Restore default column settings for Accounts grid and validate.");
    Log.AppendFolder("Setup.");
    Log.Message("Restore column default configuration.");       
    Get_ModulesBar_BtnAccounts().Click();
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click(); 
    SetAutoTimeOut();

    Log.PopLogFolder();    
    Log.Message("Validate 'État' column is not visible.");
 
    if (Get_AccountsGrid_ChStatus().Exists)
    {
      Log.Error("'État' column exists and is visible. This is not expected.");                
    }
    else
    {
      Log.Checkpoint("'État' column is not visible as expected.");
    }

    RestoreAutoTimeOut();    
    Log.PopLogFolder();    
    
    // Test 2
    Log.AppendFolder("Test 2: Add 'État' column in Accounts grid and validate.");
    Log.AppendFolder("Setup.");    
    Log.Message("Add 'État' column.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Status().Click();    
    SetAutoTimeOut();

    Log.PopLogFolder();    
    Log.Message("Validate 'État' column exists and is visible.");
   
    if (Get_AccountsGrid_ChStatus().Exists)
    {
      Log.Checkpoint("'État' column exists and is visible as expected.");
    }
    else
    {
      Log.Error("'État' column not visible. This is not expected.");
    }

    RestoreAutoTimeOut();    
    Log.PopLogFolder();

    // Test 3
    Log.AppendFolder("Test 3: Restore default column settings for Accounts grid and validate.");
    Log.AppendFolder("Setup.");              
    Log.Message("Restore column default configuration.");            
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    SetAutoTimeOut();

    Log.PopLogFolder();       
    Log.Message("Validate 'Valeur totale' column exists and is visible.");
   
    if (!(Get_AccountsGrid_ChTotalValue().Exists))
    {
      Log.Error("'Valeur totale' column not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Valeur totale' column exists and is visible as expected.");      
    }
         
    Log.Message("Validate 'Création' column is not visible.");
    
    if (Get_AccountsGrid_ChCreationDate().Exists)
    {
      Log.Error("'Création' column exists and is visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Création' column is not visible as expected.");
    }
    
    RestoreAutoTimeOut();
    Log.PopLogFolder();
    
    // Test 4
    Log.AppendFolder("Test 4: Replace one column with another one in Accounts grid and validate.");
    Log.AppendFolder("Setup.");               
    Log.Message("Determine position of 'Valeur totale' column.");
            
    var TotalValueIndex = Get_AccountsGrid_ChTotalValue().WPFControlOrdinalNo;
    Log.Message("The index of 'Valeur totale' column is: " + TotalValueIndex);
                       
    Log.Message("Replace 'Valeur totale' column by 'Création' column.");
    Get_AccountsGrid_ChTotalValue().ClickR();
    Get_GridHeader_ContextualMenu_ReplaceColumnWith().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_CreationDate().Click();       
    SetAutoTimeOut();
        
    Log.Message("Validate 'Valeur totale' column is not visible.");
    
    if (Get_AccountsGrid_ChTotalValue().Exists)
    {
      Log.Error("'Valeur totale' column exists and is visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Valeur totale' column is not visible as expected.");
    }
                
    Log.Message("Validate 'Création' column exists and is visible.");
    
    if (Get_AccountsGrid_ChCreationDate().Exists)
    {
      Log.Checkpoint("'Création' column exists and is visible as expected.");
    }
    else
    {
      Log.Error("'Création' column is not visible. This is not expected.")
    }
    
    RestoreAutoTimeOut();
    var CreationDateIndex = Get_AccountsGrid_ChCreationDate().WPFControlOrdinalNo;
    Log.Message("The index of 'Création' column is: " + CreationDateIndex);
    Log.PopLogFolder();
                
    Log.Message("Validate 'Création' column is located at the same position 'Valeur totale' column previously was located"); 
           
    if (CreationDateIndex == TotalValueIndex)
    {
      Log.Checkpoint("'Création' column is located at the same position 'Valeur totale' column previously occupied as expected.");
    }
    else
    {
      Log.Error("'Création' is not located at the same position 'Valeur totale' column previously occupied. This is not expected.");
    }
    
    Log.PopLogFolder();
    
    // Test 5
    Log.AppendFolder("Test 5: Restore default column settings for Accounts grid and validate.");
    Log.AppendFolder("Setup.");                       
    Log.Message("Restore column default configuration.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    SetAutoTimeOut();
    Log.PopLogFolder();
    
    Log.Message("Validate 'Solde' column exists and is visible.");
    
    if (!(Get_AccountsGrid_ChBalance().Exists))
    {
      Log.Error("'Solde' column is not visible. This is not expected");
    }
    else
    {
      Log.Checkpoint("'Solde' column exists and is visible as expected.");
    }
            
    Log.Message("Remove 'Solde' column.");
    Get_AccountsGrid_ChBalance().ClickR();
    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
    
    Log.Message("Validate 'Solde' column is not visible.");
    
    if (Get_AccountsGrid_ChBalance().Exists)
    {
      Log.Error("'Solde' column exists and is visible. This is not expected");
    }
    else {
      Log.Checkpoint("'Solde' column is not visible as expected.");
    }
    
    RestoreAutoTimeOut();
    Log.PopLogFolder();

    // Test 6
    Log.AppendFolder("Test 6: Restore default column settings for Accounts grid and validate.");
    Log.AppendFolder("Setup.");                       
    Log.Message("Restore column default configuration.");    

    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    Log.PopLogFolder();
    ValidateColumnDefaultConfiguration();
    Log.PopLogFolder();

    // Test 7
    Log.AppendFolder("Test 7: Add field under specific column in Accounts grid and validate.");
    SetAutoTimeOut();                      
    Log.Message("Validate 'Régime' column exits and is visible.");    
 
    if (!(Get_AccountsGrid_ChPlan().Exists))
    {
      Log.Error("'Régime' column is not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Régime' column exists and is visible as expected.");
    }
        
    Log.Message("Validate 'Création' column is not visible.");     
    
    if (Get_AccountsGrid_ChCreationDate().Exists)
    {
      Log.Error("'Création' column exists and is visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Création' column is not visible as expected.")
    }
               
    Log.Message("Add 'Création' field below 'Plan' column");
    Get_AccountsGrid_ChPlan().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_CreationDate().Click();

    Log.Message("Validate 'Régime' column exits and is visible.");        
       
    if (!(Get_AccountsGrid_ChPlan().Exists))
    {
      Log.Error("'Régime' column not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Régime' column exists and is visible as expected.");
    }
                    
    Log.Message("Validate 'Création' field exits and is visible.");
      
    if (!(Get_AccountsGrid_ChCreationDate().Exists))
    {
      Log.Error("'Création' field is not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Création' field exists and is visible as expected.");
    }
            
    RestoreAutoTimeOut();

    CheckColumnExistsUnderAnotherColumn(Get_AccountsGrid_ChPlan(),Get_AccountsGrid_ChCreationDate(), "Régime","Création");
    Log.PopLogFolder();
    
    // Test 8                       
    Log.AppendFolder("Test 8: Add field under specific column in Accounts grid and validate.");
    SetAutoTimeOut();                      
    Log.Message("Validate 'Valeur totale' column exits and is visible."); 

    if (!(Get_AccountsGrid_ChTotalValue().Exists))
    {
      Log.Error("'Valeur totale' column is not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Valeur totale' column exists and is visible as expected.");
    }
        
    Log.Message("Validate 'Date de fermeture' column is not visible.");     
    
    if (Get_AccountsGrid_ChClosingDate().Exists)
    {
      Log.Error("'Date de fermeture' column exists and is visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Date de fermeture' column is not visible as expected.")
    }
       
    Log.Message("Add 'Date de fermeture' field below 'Valeur totale' column");
    Get_AccountsGrid_ChTotalValue().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_ClosingDate().Click();
    
    Log.Message("Validate 'Valeur totale' column exits and is visible.");        
       
    if (!(Get_AccountsGrid_ChTotalValue().Exists))
    {
      Log.Error("'Valeur totale' column is not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Valeur totale' column exists and is visible as expected.");
    }
                    
    Log.Message("Validate 'Date de fermeture' field exits and is visible.");
      
    if (!(Get_AccountsGrid_ChClosingDate().Exists))
    {
      Log.Error("'Date de fermeture' field is not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Date de fermeture' field exists and is visible as expected.");
    }
    
    RestoreAutoTimeOut();
    CheckColumnExistsUnderAnotherColumn(Get_AccountsGrid_ChTotalValue(), Get_AccountsGrid_ChClosingDate(), "Valeur totale", "Date de fermeture");
    Log.PopLogFolder();
    
    // Test 9
    Log.AppendFolder("Test 9: Remove 'Date de fermeture' field and validate.");
    SetAutoTimeOut();                      
    Log.Message("Validate 'Date de fermeture' field is not visible.");         

    Get_AccountsGrid_ChClosingDate().ClickR();
    Get_GridHeader_ContextualMenu_RemoveThisField().Click();
    
    if (!(Get_AccountsGrid_ChClosingDate().Exists))
    {
      Log.Checkpoint("'Date de fermeture' field is not visible as expected.");
    }
    else
    {
      Log.Error("'Date de fermeture' column exists and is visible. This is not expected.");
    }
    
    RestoreAutoTimeOut();
    Log.PopLogFolder();
        
    // Test 10
    Log.AppendFolder("Test 10: Add 'Discrétionnaire' column and validate.");
    SetAutoTimeOut();                      
    Log.Message("Validate 'Discrétionnaire' column exists and is visible.");  

    Get_AccountsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Discretionary().Click();
    SetAutoTimeOut();

    if (!(Get_AccountsGrid_ChDiscretionary().Exists))
    {
      Log.Error("'Discrétionnaire' column is not visible. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Discrétionnaire' column exists and is visible as expected.");
    }     

    RestoreAutoTimeOut();
    Log.PopLogFolder();
        
    // Test 11
    Log.AppendFolder("Test 11: Add 'Mandat' column and validate.");
    SetAutoTimeOut();                      
    Log.Message("Validate 'Mandat' column exists and is visible.");                 
    
    Get_AccountsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Mandate().Click();
    
    if (!(Get_AccountsGrid_ChMandate().Exists))
    {
      Log.Error("'Mandat' column is not visible. This is not expected.");
    }
    else
    {
       Log.Checkpoint("'Mandat' column exists and is visible as expected.");
    }
           
    RestoreAutoTimeOut();
    Log.PopLogFolder();

    // Test 12
    Log.AppendFolder("Test 12: Restart Croesus Desktop and validate that added columns are still present.");
    
    Log.Message("Restarting Croesus Desktop.");
    Terminate_CroesusProcess();
    
    Log.Message("Login to Croesus Desktop on " + vServerAccounts + " for client " + client + " using username " + userName + ".");    
    Login(vServerAccounts, userName, psw, language);
       
    Get_ModulesBar_BtnAccounts().Click();
    SetAutoTimeOut();
    
    if (!(Get_AccountsGrid_ChMandate().Exists))
    {
        Log.Error("'Mandat' column is not visible following Croesus Desktop restart. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Mandat' column exists and is visible following Croesus Desktop restart as expected.");
    }
                       
    if (!(Get_AccountsGrid_ChDiscretionary().Exists))
    {
      Log.Error("'Discrétionnaire' column is not visible following Croesus Desktop restart. This is not expected.");
    }
    else
    {
      Log.Checkpoint("'Discrétionnaire' column exists and is visible following Croesus Desktop restart as expected.");
    }
            
    RestoreAutoTimeOut();
    Log.PopLogFolder();

    // Test 13
    Log.AppendFolder("Test 13: Move 'Devise' column next to 'Marge' column and validate.");
    SetAutoTimeOut();        
    var CurrencyWidth = Get_AccountsGrid_ChCurrency().get_ActualWidth();
    var CurrencyHeight = Get_AccountsGrid_ChCurrency().get_ActualHeight();
    var MarginWidth = Get_AccountsGrid_ChMargin().get_ActualWidth();

    Log.Message("Move 'Devise' column next to 'Marge' column.")    
    Get_AccountsGrid_ChCurrency().Drag(CurrencyWidth/2, CurrencyHeight/2, MarginWidth + CurrencyWidth/2, 0);

    Log.Message("Validate that 'Devise' column is to the immediate right of 'Marge' column.")    
    var MarginPosX = Get_AccountsGrid_ChMargin().Left;
    var MarginWidth = Get_AccountsGrid_ChMargin().Width;
    var expectedCurrencyNewPosX = MarginPosX + MarginWidth - 1;
    var actualCurrencyNewPosX = Get_AccountsGrid_ChCurrency().Left;
    
    Log.Message("New horizontal position for 'Devise' column header is: " + actualCurrencyNewPosX);
    
    if (actualCurrencyNewPosX == expectedCurrencyNewPosX)
    {
      Log.Checkpoint("'Devise' column was found to be to the immediate right of the 'Marge' column as expected.");
    }
    else
    {
      Log.Error("'Devise' column was not found to be to the immediate right of the 'Marge' column. This is not expected. The horizontal position of 'Currency' was expected to be: " + expectedCurrencyNewPosX);
    }
    
    RestoreAutoTimeOut();
    Log.PopLogFolder();
    
    // Test 14
    Log.AppendFolder("Test 14: Restore default column setting for Accounts grid and validate.");
    Log.Message("Restore column default configuration.");       
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ValidateColumnDefaultConfiguration();    
    Log.PopLogFolder();      

    // Test 15
    Log.AppendFolder("Test 15: Add column from 'Insérer un champ - Profils' and validate.");
    Log.Message("Add column 'Loisirs' from 'Insérer un champ - Profils'");

    Get_AccountsGrid_ChMargin().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles().Click();
    Get_AccountsGrid_ColumnHeader_ContextualMenuItem_Profiles_Hobbies().Click();
    SetAutoTimeOut();

    Log.Message("Validate 'Loisirs' column exists and is visible.");
    
    if (Get_AccountsGrid_ChHobbies().Exists)
    {
      Log.Checkpoint("'Loisirs' column exists and is visible as expected.");
    }
    else
    {
      Log.Error("'Loisirs' column is not visible. This is not expected.");
    }
    
    RestoreAutoTimeOut();
    Log.PopLogFolder();   

    // Test 16
    Log.AppendFolder("Test 16: Restore default column setting for Accounts grid and validate.");
    Log.Message("Restore column default configuration.");       
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    ValidateColumnDefaultConfiguration();    
    Log.PopLogFolder();

    // Test 17
    Log.AppendFolder("Test 17: Validate ascending order of columns.");
    Log.AppendFolder("Validate ordering of 'Valeur totale' column.");
    Get_AccountsGrid_ChTotalValue().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 106, language), "TotalValue")
    Log.PopLogFolder();
    
    Log.AppendFolder("Validate ordering of 'Solde' column.");
    Get_AccountsGrid_ChBalance().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 107, language), "Balance");
    Log.PopLogFolder();
           
    Log.AppendFolder("Validate ordering of 'Devise' column.");
    Get_AccountsGrid_ChCurrency().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 108, language), "Currency");
    Log.PopLogFolder();
        
    Log.AppendFolder("Validate ordering of 'Type' column.");
    Get_AccountsGrid_ChType().Click();    
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 109, language), "Type");
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    // Test 18
    Log.AppendFolder("Test 18: Sort Accounts grid by Account Numbers and validate.");
    Log.Message("Right-click inside Accounts grid, select sort by Account Numbers' and validate ordering of Accounts grid.");    

    Get_RelationshipsClientsAccountsGrid().ClickR();
       
    var numberAttempts=0;
      
    while (numberAttempts < 5 && !Get_SubMenus().Exists)
    {
      Get_RelationshipsClientsAccountsGrid().ClickR();
      numberAttempts++;
    } 
    
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy().Click();
    Get_AccountsGrid_ContextualMenu_SortBy_AccountNo().Click();
    Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(), GetData(filePath_Accounts, "CR1352", 113, language), "AccountNumber");
  }
    
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
    
  finally
  {
    Log.PopLogFolder();
    Log.AppendFolder("Restore environment to default configuration.");
    Log.Message("Restore column default settings for Accounts grid.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    Terminate_CroesusProcess();
    Log.PopLogFolder();

    errorCountAfterExecution = Log.ErrCount;    
    if (errorCountAfterExecution == 0)
    {
      Log.Checkpoint("***** Execution of script '" + functionName + "' completed successfully with " + errorCountAfterExecution + " errors.", "", pmNormal, boldAttribute);
    }
    else
    {
      Log.Error("***** Execution of script '" + functionName + "' completed with " + errorCountAfterExecution + " errors.", "", pmNormal, boldAttribute, Sys.Process("TestComplete"));
    } 
  }
}

function CheckColumnExistsUnderAnotherColumn(topColumn, bottomColumn, topColumnDescription, bottomColumnDescription)
{
  var leftMarginsValidationOk = false;
  var topMarginValidationOk = false;
  
  // Calculate expected Position X for bottomColumn  
  var actualBottomColumnLeftMarginPositionX = bottomColumn.Left;
  var expectedBottomColumnLeftMarginPositionX = topColumn.Left;
  
  // Calculate expected Position Y for bottomColumn
  var actualTopColumnTopMarginPositionY = topColumn.Top;
  var actualTopColumnHeight = topColumn.Height;
  var actualBottomColumnTopMarginPositionY = bottomColumn.Top;
  var expectedBottomColumnTopMarginPositionY = actualTopColumnTopMarginPositionY + actualTopColumnHeight - 1;

  Log.Message("Validating that '" + bottomColumnDescription + "' field is directly under the '" + topColumnDescription + "' column header.");
  Log.Message("Actual left margin of '" + bottomColumnDescription + "' field was: " + actualBottomColumnLeftMarginPositionX);  
  Log.Message("Actual top margin of '" + bottomColumnDescription + "' field was: " + actualBottomColumnTopMarginPositionY);
  
  // Validating horizontal positioning of the field
  if (actualBottomColumnLeftMarginPositionX == expectedBottomColumnLeftMarginPositionX)
  {
    Log.Checkpoint("The left margin of '" + bottomColumnDescription + "' lines up with the left margin of '" + topColumnDescription + "' as expected.");
    leftMarginsValidationOk = true;
  }
  else if (actualBottomColumnLeftMarginPositionX == 442)
  {
    Log.Warning("The left margin of '" + bottomColumnDescription + "' does not line up with the margin of '" + topColumnDescription + "'. However, this issue is being tracked by CROES-4942.");
    leftMarginsValidationOk = false;
  }
  else
  {
    Log.Error("The left margin of '" + bottomColumnDescription + "' does not line up with the margin of '" + topColumnDescription + ".");
    leftMarginsValidationOk = false;
  }

  // Validating vertical positioning of the field
  if (actualBottomColumnTopMarginPositionY == expectedBottomColumnTopMarginPositionY)
  {
    Log.Checkpoint("The top margin of '" + bottomColumnDescription + "' lines up with the bottom margin of '" + topColumnDescription + "' as expected.");
    topMarginValidationOk = true;  
  }
  else
  {
    Log.Error("The top margin of '" + bottomColumnDescription + "' does not line up with the bottom margin of '" + topColumnDescription + ".");
    topMarginValidationOk = false;
  } 
}

function ValidateColumnDefaultConfiguration()
{
  Log.Message("Validate the presence and the position of the column headers.");
  
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChName(), 3, "Name");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChAccountNo(), 4, "Account No.");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChIACode(), 5, "IA Code");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChType(), 6, "Type");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChPlan(), 7, "Plan");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChTelephone1(), 8, "Telephone 1");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChTelephone2(), 9, "Telephone 2");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChBalance(), 10, "Balance");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChCurrency(), 11, "Currency");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChMargin(), 12, "Margin");
  CheckExistenceAndPositionOfColumn(Get_AccountsGrid_ChTotalValue(), 13, "Total Value"); 
    
  Log.Message("Validate the presence of 11 columns and 2 spacer columns.");    
  aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.GridViewPanelAdorner.DataRecordPresenter.WPFObject("HeaderPresenter", "", 1).WPFObject("HeaderLabelArea", "", 1).WPFObject("VirtualizingDataRecordCellPanel", "", 1), "ChildCount", cmpEqual, 13);   
}

function CheckExistenceAndPositionOfColumn(columnHeaderObject, expectedColumnHeaderIndex, columnHeaderName)
{
  Log.Message("Validate that column '" + columnHeaderName + "' is visible.");
  
  if (!(columnHeaderObject.Exists))
  {
    Log.Error("'" + columnHeaderName + "' column not displayed. This is not expected.");
    return false;
  }
    
  Log.Checkpoint("'" + columnHeaderName + "' column displayed. This is expected.");
  Log.Message("Validate that column is in the proper order.");
  var actualColumnHeaderIndex = columnHeaderObject.WPFControlOrdinalNo;
  Log.Message("'" + columnHeaderName + "' column actual index is: " + actualColumnHeaderIndex);
    
  if (expectedColumnHeaderIndex == actualColumnHeaderIndex)
  {
    Log.Checkpoint("'" + columnHeaderName + "' column is at the expected index position.");
    return true;
  }
  else
  {
    Log.Error("'" + columnHeaderName + "' column is not at the expected position. Expected index: " + expectedColumnHeaderIndex + ", Actual index: " + actualColumnHeaderIndex);
    return false;
  }
}

function CheckNonExistenceOfColumn(columnHeaderObject, columnHeaderName)
{
    Log.Message("Validate that column is visible.");
    
    if (columnHeaderObject.Exists)
    {
      Log.Error("'" + columnHeaderName + "' column exists and is visible. This is not expected.");
      return false;
    }
    else
    {
      Log.Checkpoint("'" + columnHeaderName + "' column is not visible as expected.");
      return true;
    }
}

function GetCroesusBuildVersion()
{
  var croesusBuildVersion = "";
  var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
  var valuesArray = ["TextBlock", 7];

  // Ensure that Croesus MainWindow is focused
  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
  
  // Click on ? in Classic Menu of MainWindow
  Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10).Click();
    
  // Click on About to open About dialog
  Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10).Click();

  // Read version
  croesusBuildVersion = Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").WPFObject("AboutWin").FindChild(propertiesArray, valuesArray, 10).WPFControlText;
  
  // Close About dialog
  Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").Click();
  
  // Return version
  return (croesusBuildVersion);  
}