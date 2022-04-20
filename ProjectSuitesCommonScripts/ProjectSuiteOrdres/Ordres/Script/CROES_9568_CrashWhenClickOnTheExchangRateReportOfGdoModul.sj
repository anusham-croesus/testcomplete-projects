//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT GDO_2510_Checkbox_AllOrNon_CAD
//USEUNIT GDO_2464_Split_Of_BlockTrade
/**
        Description :
         
                  Activer la pref PREF_GDO_FX_REPORT_FILTER = 1 au niveau global
                  Se connecter avec keynej
                  Module Ordres 
                  Menu Rapports/Rapport de taux de change
                  On obtient un crash
                  
    Auteur : Sana Ayaz
    Anomalie: CROES-9568
    Version de scriptage:	ref90-07-Co-15--V9-Be_1-co6x
   
*/
 function CROES_9568_CrashWhenClickOnTheExchangRateReportOfGdoModul()
 {             
    try{  
         userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
         passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         Activate_Inactivate_PrefBranch("0","PREF_GDO_FX_REPORT_FILTER ","1",vServerOrders)
         RestartServices(vServerOrders)
       
         Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
         Get_ModulesBar_BtnOrders().Click();
         //Générer le rapport
         Get_MenuBar_Reports().Click();
         Get_MenuBar_Reports_ExchangeRateReport().Click();  
         
        //Vérifier si le message d'erreur apparaît
          //Les points de vérifications
         if (!Get_DlgError().Exists)
        Log.Checkpoint("No Crash detected");
        else 
        Log.Error("there is a crash")
          Terminate_CroesusProcess();       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Terminate_CroesusProcess();
        
    }
    finally {   
       Terminate_CroesusProcess(); //Fermer Croesus
      
        
    }
 }
 
 