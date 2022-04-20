//USEUNIT BillingWindowValidationTiered

function FixedTierEndQuarterExclArr()
{
  try
  {
    var scriptName = arguments.callee.toString().match(/function (\w*)/)[1];    
    GenerateAndValidateBillingWindowTiered(scriptName);
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {

  }
}