//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT Common_functions

/* Description :Activation des préférences de GDO

Analyste d'automatisation: Youlia Raisper */

function Pref_Activation_For_GDO()
{	
	Execute_SQLQuery("update b_def set default_Value = '0:00|0:00' where cle = 'PREF_FIDESSA_SESSION_TIME'", vServerTCVE2)
	Execute_SQLQuery("update b_def set default_value = 'STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0' where cle='PREF_GDO_MARKET_OPEN_TIME'", vServerTCVE2)
	Execute_SQLQuery("update b_def set default_value = 'STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59' where cle='PREF_GDO_MARKET_CLOSE_TIME'", vServerTCVE2)
	Execute_SQLQuery("update b_def set default_Value = 'YES' where cle = 'PREF_GDO_SKIP_HOLIDAY_CHECK'", vServerTCVE2)	
    
  Activate_Inactivate_PrefFirm("FIRM_1","PREF_FIDESSA_SESSION_TIME","0:00|0:00",vServerTCVE2);
  Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_MARKET_OPEN_TIME","STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0",vServerTCVE2);
  Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59",vServerTCVE2);
  Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_SKIP_HOLIDAY_CHECK","YES",vServerTCVE2); //EM : 90.10.Fm-2 : Pour couvrir tous les users.
  
  Activate_Inactivate_Pref("UNI00","PREF_FIDESSA_SESSION_TIME","0:00|0:00",vServerTCVE2);
  Activate_Inactivate_Pref("UNI00","PREF_GDO_MARKET_OPEN_TIME","STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0",vServerTCVE2);
  Activate_Inactivate_Pref("UNI00","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59",vServerTCVE2);
  Activate_Inactivate_Pref("UNI00","PREF_GDO_SKIP_HOLIDAY_CHECK","YES",vServerTCVE2);
  
  Activate_Inactivate_Pref("REAGAR","PREF_FIDESSA_SESSION_TIME","0:00|0:00",vServerTCVE2);
  Activate_Inactivate_Pref("REAGAR","PREF_GDO_MARKET_OPEN_TIME","STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0",vServerTCVE2);
  Activate_Inactivate_Pref("REAGAR","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59",vServerTCVE2);
  Activate_Inactivate_Pref("REAGAR","PREF_GDO_SKIP_HOLIDAY_CHECK","YES",vServerTCVE2);
  
  Activate_Inactivate_Pref("KEYNEJ","PREF_FIDESSA_SESSION_TIME","0:00|0:00",vServerTCVE2);
  Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_OPEN_TIME","STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0",vServerTCVE2);
  Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59",vServerTCVE2);
  Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_SKIP_HOLIDAY_CHECK","YES",vServerTCVE2);
   
  RestartVserver(vServerTCVE2);   
}

