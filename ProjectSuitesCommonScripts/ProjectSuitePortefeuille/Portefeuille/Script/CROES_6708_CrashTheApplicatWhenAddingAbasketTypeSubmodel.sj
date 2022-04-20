//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    Description :
                 Lors d'ajouter un sous- modèle de type panier, l'application crash.

                  Étapes
                  1. Se connecter avec REAGAR
                  2. Aller au module modèles et sélectionner un modèle avec un compte assigne
                  3. Mailler vs portefeuille
                  4. Click sur le bouton  Ajouter un titre / Remplir le sous-modèle, par exemple:

                  Sous-modèle: GROWTH
                  Valeur cible: 5
                  5. Click sur le bouton OK

                  Résultat reçu
                  L'application crash
    Auteur : Sana Ayaz
    Anomalie:CROES-6708
    Version de scriptage:ref90-05-14--V9-AT_1-co6x
*/
function CROES_6708_CrashTheApplicatWhenAddingAbasketTypeSubmodel()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");

      
        //Les variables
          var ModelNumberCROESS_6708=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "ModelNumberCROESS_6708", language+client);
          var NumberTheBugCROES_6708=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "NumberTheBugCROES_6708", language+client);
          var subModelGROWTHCROES_6708=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "subModelGROWTHCROES_6708", language+client);
          var valuePercentCROES_6708=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "valuePercentCROES_6708", language+client);
        
          //1.se connecter comme REAGAR
          Login(vServerPortefeuille, userNameREAGAR, passwordREAGAR, language);
         /*
          1. Se connecter avec REAGAR
          2. Aller au module modèles et sélectionner un modèle avec un compte assigne
          3. Mailler vs portefeuille
         */
         Get_ModulesBar_BtnModels().Click();
         
         if (client == "CIBC")
                Create_Model(subModelGROWTHCROES_6708,"","AC42");
          
          Search_Model(ModelNumberCROESS_6708);
           Get_ModelsGrid().Find("Value",ModelNumberCROESS_6708,10).Click();
          // Mailler vers portefuille:
           Get_MenuBar_Modules().OpenMenu();
           Get_MenuBar_Modules_Portfolio().OpenMenu();
           Get_MenuBar_Modules_Portfolio_DragSelection().Click();
           /*4. Click sur le bouton  Ajouter un titre / Remplir le sous-modèle, par exemple:
           
                  Sous-modèle: GROWTH
                  Valeur cible: 5
                  5. Click sur le bouton OK

                  Résultat reçu
                  L'application crash*/  
                  //Ajouter un sous-modele
               //Ajouter un sous-modele
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
       Get_WinAddPositionSubmodel_TxtSubmodel().Click();
       Get_WinAddPositionSubmodel_TxtSubmodel().Keys(subModelGROWTHCROES_6708);
       Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Enter]");
       Get_WinAddPositionSubmodel_TxtValuePercent().Keys(valuePercentCROES_6708);
       Get_WinAddPositionSubmodel_BtnOK().Click();
         
       Get_PortfolioBar_BtnSave().Click();      
       Get_WinWhatIfSave_BtnOK().Click();       
         
       // les points de vérifications qu'il y a pas de crash   
       CheckPointForCrash(NumberTheBugCROES_6708);
          
       
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
   
        Terminate_CroesusProcess();
        Login(vServerPortefeuille, userNameREAGAR, passwordREAGAR, language);
         Get_ModulesBar_BtnModels().Click();
          Search_Model(ModelNumberCROESS_6708);
           Get_ModelsGrid().Find("Value",ModelNumberCROESS_6708,10).Click();
          // Mailler vers portefuille:
           Get_MenuBar_Modules().OpenMenu();
           Get_MenuBar_Modules_Portfolio().OpenMenu();
           Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            if(Get_PortfolioPlugin().Find("Value",subModelGROWTHCROES_6708,10).Exists){
              Get_PortfolioPlugin().Find("Value",subModelGROWTHCROES_6708,10).Click();
              Get_Toolbar_BtnDelete().Click(); 
              var numberOftries=0;  
              while (!Get_DlgConfirmation().Exists && numberOftries < 5){
                Get_Toolbar_BtnDelete().Click();
                numberOftries++;
              }          
              var width =Get_DlgConfirmation().Get_Width();
              Get_DlgConfirmation().Click((width*(1/3)),73);
              if(Get_DlgConfirmation().Exists) {
                Get_DlgConfirmation().Click((width*(1/3)),73);
              }
              //sauvgarder les modification 
              Get_PortfolioBar_BtnSave().Click();
              Get_WinWhatIfSave_BtnOK().Click();
          }
          if (client == "CIBC"){
              Get_ModulesBar_BtnModels().Click();
              DeleteModelByName(subModelGROWTHCROES_6708);
          }          
         Terminate_CroesusProcess();
    }
}


function CheckPointForCrash(NumberTheBug)
{
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
            Log.Error(NumberTheBug);
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
}


function test()
{
  
 //Supprimer le sous modèle 
          if(Get_PortfolioPlugin().Find("Value",modelRevenusFixes,10).Exists){
              Get_PortfolioPlugin().Find("Value",modelRevenusFixes,10).Click();
              Get_Toolbar_BtnDelete().Click(); 
              var numberOftries=0;  
              while (!Get_DlgConfirmation().Exists && numberOftries < 5){
                Get_Toolbar_BtnDelete().Click();
                numberOftries++;
              }          
              var width =Get_DlgConfirmation().Get_Width();
              Get_DlgConfirmation().Click((width*(1/3)),73);
              if(Get_DlgConfirmation().Exists) {
                Get_DlgConfirmation().Click((width*(1/3)),73);
              }
              //sauvgarder les modification 
              Get_PortfolioBar_BtnSave().Click();
              Get_WinWhatIfSave_BtnOK().Click();
          }
}

