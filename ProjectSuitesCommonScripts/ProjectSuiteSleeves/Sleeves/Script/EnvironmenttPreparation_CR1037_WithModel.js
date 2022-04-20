//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel


 /* Description : - Se connecter avec UNI00
    -Choisir le module compte 
    -Chercher le compte : "account"
    -Mailler ce compte vers le module Portefeuille
    -Cliquer sur le bouton Par classe d'actifs
    -Sélectionner tous les regroupements par classe d'actifs
    -Faire un right-click ensuite choisir créer des segments ensuite cliquer sur sauvegarder (fenêtre Gestionnaire des segments -comptes) pour valider la saisie du segment.
    -Sélectionner le segment "description" ensuite il faut cliquer sur le bouton Modifier
    -Sur le champ Nom Modèle il faut mettre le nom du modèle suivant :"modele" nsuite il faut cliquer sur tabulation ensuite il faut cliquer sur le bouton OK de la fenêtre modifier un segment
    -Ensuite il faut cliquer sur le bouton sauvegarder de la fenêtre Gestionnaire de segments - comptes "account"

Analyste d'automatisation: Youlia Raisper */ 

 function EnvironmentPreparation_CR1037_WithModel()
{  
    Driver = DDT.ExcelDriver(filePath_Sleeves, "DataPool_WithModel", true);
    //Filename: is the name of excel file being used.
   //Sheet: is the excel sheet which has the data, that will be used for test.
   //UseAceDriver: a Boolean value. If True, TestComplete makes use of ACE driver to connect an excel sheet. 
   //If it is False, TestComplete connects to the excel sheet via the Microsoft Excel ODBC driver.
   // ACE driver lets us to connect Excel 2007 sheets together with earlier version of Microsoft Excel.
   
     while(!Driver.EOF())
  {
      try{    
       
          var account=Driver.Value(0) //Driver.Value(n), carries the data from excel sheet. The first column of the excel sheet is read as zeroth column.
          var model=Driver.Value(1);
        
          if(language=="french"){
            var description= Driver.Value(2)
          }
          else{//english
            var description= Driver.Value(3)
          }
           
          Log.Message("***************************************************************")
          Log.Message("Création des segmentes avec un modèle pour le compte " + account)
          var  user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
          Login(vServerSleeves, user ,psw ,language);
          Get_ModulesBar_BtnAccounts().Click();
  
          Search_Account(account);  
          DragAccountToPortfolio(account);     
          CreateSleeveByAssetClass();
    
          //Cliquer sur le bouton segment
          Get_PortfolioBar_BtnSleeves().Click(); 
           
          SelectSleeveWinSleevesManager(description);
          InsertModelWinEditSleeve(model);
    
          CheckThatModelBindedToSleeve( description,model)
          Get_WinManagerSleeves_BtnSave().Click(); 
  
          //Fermer l'application
          Close_Croesus_AltQ();
          if(Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          } 
          
      }
       catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          //Débloquer le rééquilibrage
          Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
      }
      finally {
          Terminate_CroesusProcess(); //Fermer Croesus
          Driver.Next(); // Goes to the next record
      }
  }
}