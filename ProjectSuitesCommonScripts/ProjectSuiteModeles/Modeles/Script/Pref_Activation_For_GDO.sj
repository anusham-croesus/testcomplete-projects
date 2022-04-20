//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT Common_functions

/* Description :Activation des préférences de GDO

Analyste d'automatisation: Youlia Raisper */

function Pref_Activation_For_GDO()
{	
	Execute_SQLQuery("update b_def set default_Value = '0:00|0:00' where cle = 'PREF_FIDESSA_SESSION_TIME'", vServerModeles)
	Execute_SQLQuery("update b_def set default_value = 'STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0' where cle='PREF_GDO_MARKET_OPEN_TIME'", vServerModeles)
	Execute_SQLQuery("update b_def set default_value = 'STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59' where cle='PREF_GDO_MARKET_CLOSE_TIME'", vServerModeles)
	Execute_SQLQuery("update b_def set default_Value = 'YES' where cle = 'PREF_GDO_SKIP_HOLIDAY_CHECK'", vServerModeles)	
  
  Activate_Inactivate_Pref("KEYNEJ","PREF_FIDESSA_SESSION_TIME","0:00|0:00",vServerModeles);
  Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_OPEN_TIME","STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0",vServerModeles);
  Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59",vServerModeles);
  Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_SKIP_HOLIDAY_CHECK","YES",vServerModeles);
   
  RestartVserver(vServerModeles);   
}