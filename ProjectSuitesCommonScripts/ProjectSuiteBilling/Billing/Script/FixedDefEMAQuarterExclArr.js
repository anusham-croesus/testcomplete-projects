//USEUNIT BillingWindowValidationDefined

function FixedDefEMAQuarterExclArr()
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