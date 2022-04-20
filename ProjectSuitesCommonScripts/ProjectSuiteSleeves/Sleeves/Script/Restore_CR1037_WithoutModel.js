//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel

 /* Description : - Se connecter avec UNI00
    -Choisir le module compte 
    -Chercher le compte : "account"
    -Mailler ce compte vers le module Portefeuille
    -Cliquer sur le bouton Par classe d'actifs
    -Cliquer sue Segment
    -Supprimer tous les segments sauf le premier.

Analyste d'automatisation: Youlia Raisper */ 

 function Restore_CR1037_WithoutModel()
{        
    
    Driver = DDT.ExcelDriver(filePath_Sleeves, "DataPool_WithoutModel", true);

    while(!Driver.EOF())
  {
      try{
          var account=Driver.Value(0)
          var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
          Login(vServerSleeves, user ,psw,language);
          Get_ModulesBar_BtnAccounts().Click();
  
          Search_Account(account); 
          
          DragAccountToPortfolio(account); //Driver.Value(n), carries the data from excel sheet. The first column of the excel sheet is read as zeroth column.    
          // grouper par classe d'actif
          Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click(); 
      
          //Supprimer des segments 
          Delete_AllSleeves_WinSleevesManager()
   
          //Fermer l'application
          Close_Croesus_MenuBar(); 
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      }
      catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
          Terminate_CroesusProcess(); //Fermer Croesus
          Driver.Next(); // Goes to the next record
      }         
  }
}