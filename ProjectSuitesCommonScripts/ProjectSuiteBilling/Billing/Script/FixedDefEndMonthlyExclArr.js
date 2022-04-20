//USEUNIT BillingWindowValidationDefined

function FixedDefEndMonthlyExclArr()
{
  try
  {
    var scriptName = arguments.callee.toString().match(/function (\w*)/)[1];    
    GenerateAndValidateBillingWindowDefined(scriptName);
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {

  }
}
   
//    BNC_1854_Validation();
  
function BNC_1854_Validation()
{
  var folderPath= Sys.OSInfo.TempDirectory + "\CroesusTemp\\";          
  var filenameContainsDetailedReport= "Detailed Report" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
  var detailedReportAnalyzed = FindLastModifiedFileInFolder(folderPath,filenameContainsDetailedReport);
  var detailedReportFile = aqFile.OpenTextFile(detailedReportAnalyzed, aqFile.faRead, aqFile.ctANSI);
  var searchString = 'Fees[0].Percentage';
  var successFlag = true;
  var currentLine;
  var textLineArray;
  var searchResult;
    
  Log.PopLogFolder()
  Log.AppendFolder("Validation of BNC-1854 code defect.");
  Log.Message("BNC-1854 validation started. Detailed report analyzed: " + detailedReportAnalyzed + ".");
  Log.AppendFolder("Generation of Excel Billing report.");   
    
  Get_WinBilling_BtnGenerate().Click();
  Get_WinOutputSelection_GrpOutput_ChkExportToExcelDetailed().Click();
  Get_WinOutputSelection_BtnOK().Click();
  Get_DlgConfirmation().WPFObject("MessageWindow", "", 1).WPFObject("PART_OK").ClickButton();

  if (aqFile.Exists(detailedReportAnalyzed))
  {
    Log.Checkpoint("Excel file: " + detailedReportAnalyzed + " successfully generated.");
  }
  else
  {
    Log.Error("Excel file: " + detailedReportAnalyzed + " was not succesfully generated.");
  }
    
  // Reads text file line by line, separate the fields within current line, search for string, log the resuls
  //
  Log.PopLogFolder();
  Log.AppendFolder("Validation of Excel Billing report.");
    
  while(!detailedReportFile.IsEndOfFile())
  {
    currentLine = detailedReportFile.ReadLine();        
    textLineArray = currentLine.split("	");
    searchResult = aqString.Find(textLineArray, searchString);

    if (searchResult != -1)
    {
      Log.Error("Substring '" + searchString + "' was found in string '" + currentLine + "' at position " + searchResult + ".");
      successFlag = false;
    }        
    else
    {
      Log.Checkpoint("There are no occurrences of '" + searchString + "' in '" + currentLine + "'.");
    }        
  }
    
  Log.PopLogFolder();
  
  if (successFlag)
  {
    Log.Checkpoint("BNC-1854 validation completed with success.");
  }
  else
  {
    Log.Error("BNC-1854 validation failed. Substring '" + searchString + "' was found in the detailed report file '" + detailedReportAnalyzed + ".")
  }
}