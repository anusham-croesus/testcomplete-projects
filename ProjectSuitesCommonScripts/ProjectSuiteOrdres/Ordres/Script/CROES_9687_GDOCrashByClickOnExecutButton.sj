//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 

/**
        Description : 
                  
                      Se  connecter à croesus 
                      Dans le module GDO,
                      Cliquer sur le bouton Exécutions 
                      On obtient un crash
    Auteur : Sana Ayaz
    Anomalie:CROES-9687
    Version de scriptage:	ref90-07-Co-9--V9-Be_1-co6x
   
*/
 function CROES_9687_GDOCrashByClickOnExecutButton()
 {             
    try{  
         userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
         passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
         
         

         Login(vServerOrders, userNameGP1859 , passwordGP1859 ,language);
         Get_ModulesBar_BtnOrders().Click();
         Get_OrdersBar_BtnFills().Click();
        
         //Les points de vérifications
         aqObject.CheckProperty(Get_WinOrderFills(), "IsVisible", cmpEqual, true);
         aqObject.CheckProperty(Get_WinOrderFills(), "IsEnabled", cmpEqual, true); 
         aqObject.CheckProperty(Get_WinOrderFills(), "Exists", cmpEqual, true); 
         Log.Message("Bug CROES-9687");
         Get_WinOrderFills_BtnCancel().Click();
           
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
 
 