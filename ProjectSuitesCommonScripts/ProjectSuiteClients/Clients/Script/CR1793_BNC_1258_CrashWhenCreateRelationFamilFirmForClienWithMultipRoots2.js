//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT CR1793_BNC_1258_CrashWhenCreateRelationFamilFirmForClienWithMultipRoots1

/**
    Description :
                   Le problème arrive Lorsqu’un client possède plusieurs racines.
                          1) Créer une relation FF à partir d'une racine client.
                          2) Choisir une autre racine pour le même client et essayer de créer une autre relation Famille-Firme, l'application crash.

                          Également on a une autre situation quand l'application crash.
                          1) Créer une relation FF a  d'une racine client ne pas finaliser la création, appuyer sur NON après le pop-up de la fenêtre d'association.
                          2) Choisir une autre racine popartirur le même client et essayer de créer une relation Famille-Firme, l'application crash.
                   
    Auteur : Sana Ayaz
    Numéro de l'anomalie:BNC-1258.
    Version de scriptage:ref90-05-13--V9(BNC)
*/
function CR1793_BNC_1258_CrashWhenCreateRelationFamilFirmForClienWithMultipRoots2()
{
    try {
      
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
          /*Dans ce script je vais automatiser la partie 2:
          
              Également on a une autre situation quand l'application crash.
                          1) Créer une relation FF a  d'une racine client ne pas finaliser la création, appuyer sur NON après le pop-up de la fenêtre d'association.
                          2) Choisir une autre racine popartirur le même client et essayer de créer une relation Famille-Firme, l'application crash.
          */
    
        // Les variables
          var Client800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Client800300", language+client); 
          var Client800301=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Client800301", language+client); 
        
         
      
         Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
        
         CreateRelationshipFirmFamilyFromRootClient800300(Client800300)
         Get_WinAssignToARelationship_BtnNo().Click();
        
         /*2) Choisir une autre racine pour le même client et essayer de créer une autre relation Famille-Firme, l'application crash. */
        
          CreateRelationshipFirmFamilyFromRootClient800300(Client800301)
          // Les points de vérifications : Vérifier que l'application ne crashe pas'
          
          //Vérifier si le message d'erreur apparaît
          maxWaitTime = 10000;
          waitTime = 0;
          errorDialogBoxDisplayed = Get_DlgError().Exists;
          while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
              Delay(1000);
              waitTime += 1000;
              errorDialogBoxDisplayed = Get_DlgError().Exists;
          }
        
            Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
            if (errorDialogBoxDisplayed){
                Log.Error("Croesus crashed.")
                Log.Error("Bug BNC-1258");
                Get_DlgError().Click(Get_DlgError().get_ActualWidth()/2, Get_DlgError().get_ActualHeight()-45);
            }
            else
                Log.Checkpoint("No crash detected.")
          
          
          
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
   //initialiser la BD
        Terminate_CroesusProcess();
       
        
    }
}
