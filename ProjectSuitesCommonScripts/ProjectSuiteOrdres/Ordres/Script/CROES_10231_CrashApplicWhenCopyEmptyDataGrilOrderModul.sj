//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 

/**
        Description : 
                  
                      1. Se connecter avec COPERN
                      2. Aller au module Ordres 
                      3. Sur la zone "Accumulateur" faire clic droit copier

                      Résultat obtenu 
                      L'application crash 
                      Voir le log attachée

                      Résultat attendu
                      N'existe pas de crash
    Auteur : Sana Ayaz
    Anomalie:CROES-10231
    Version de scriptage:	ref90-07-Co-15--V9-Be_1-co6x
   
*/
 function CROES_10231_CrashApplicWhenCopyEmptyDataGrilOrderModul()
 {             
    try{  
         userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
         passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         

         Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);/*L'anomalie on la reproduis quand la grille ordre est vide.
                                                                          La grille d'ordre est vide pour l'user KEYNEJ*/
         Get_ModulesBar_BtnOrders().Click();
         Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
         Get_MainWindow().Maximize();
         
         
         Get_OrderAccumulatorGrid().ClickR();
         while (! Get_OrderAccumulator_ContextualMenu_Copy().Exists )
                Get_OrderAccumulatorGrid().ClickR();
         Get_OrderAccumulator_ContextualMenu_Copy().Click();
        
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
 