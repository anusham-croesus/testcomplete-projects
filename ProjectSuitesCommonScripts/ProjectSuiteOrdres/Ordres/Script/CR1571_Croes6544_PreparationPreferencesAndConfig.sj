//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
          Au niveau global

          Aller dans Configurations

          Rechercher GDO_ORDERENTRY_CHECKBOXES et exploser les config

              MANUAL_ORDER_HANDLING = Oui

          Au niveau firme pour firme 1

          PREF_TRADE_ALLOCATION_EXTRACT = 3

          PREF_GDO_EXPIRATION_TICKET = 0

 

          Au niveau utilisateur pour KEYNEJ

          PREF_GDO_LIMIT_MKT_VALUE_CURRENCY = CAD

          PREF_GDO_LIMIT_MKT_VALUE_SINGLE = 500000
          PREF_GDO_LIMIT_MKT_VALUE_BLOCK = 5000000
 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6544
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
    
    Version de scriptage:	90.10.Fm-19_2019-05-30 (TD) :Le backup pour l'environnement de GDO TD se trouve dans BDref: Fm_TD_GDO_90.10.Fm-19_2019-05-30
*/

function CR1571_Croes6544_PreparationPreferencesAndConfig()
{
    try {
      
        //MANUAL_ORDER_HANDLING = Oui        
        ChangetheDefaultValueForAPreferenc("MANUAL_ORDER_HANDLING","YES",vServerOrders)
        
        /*Au niveau firme pour firme 1
        PREF_TRADE_ALLOCATION_EXTRACT = 3
        PREF_GDO_EXPIRATION_TICKET = 0*/
        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_TRADE_ALLOCATION_EXTRACT",3,vServerOrders)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_EXPIRATION_TICKET",0,vServerOrders)
        Activate_Inactivate_PrefFirm("FIRM_1","FD_INVESTMENT_SAVING_ACCOUNT","TDB831",vServerOrders);
       
        
        /*
        Au niveau utilisateur pour KEYNEJ
        PREF_GDO_LIMIT_MKT_VALUE_CURRENCY = CAD
        PREF_GDO_LIMIT_MKT_VALUE_SINGLE = 500000
        PREF_GDO_LIMIT_MKT_VALUE_BLOCK = 5000000
        */
          
        Activate_Inactivate_Pref('KEYNEJ', "PREF_GDO_LIMIT_MKT_VALUE_CURRENCY", "CAD", vServerOrders);
        Activate_Inactivate_Pref('KEYNEJ', "PREF_GDO_LIMIT_MKT_VALUE_SINGLE", 500000, vServerOrders);
        Activate_Inactivate_Pref('KEYNEJ', "PREF_GDO_LIMIT_MKT_VALUE_BLOCK", 5000000, vServerOrders);
        RestartServices(vServerOrders)
       
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();  
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Runner.Stop(true)
    }
}

function ChangetheDefaultValueForAPreferenc(pref, new_default_value, vServer)
{
    
    
    var updateQueryString = "update B_DEF set DEFAULT_VALUE = '" + new_default_value + "' where CLE = '" + pref + "'";
    var resultat=Execute_SQLQuery(updateQueryString, vServer);
    Log.Message(resultat);
    return Execute_SQLQuery(updateQueryString, vServer);
}
