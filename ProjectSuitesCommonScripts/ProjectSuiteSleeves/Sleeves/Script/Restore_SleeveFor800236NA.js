//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel


 /* Description : 

Analyste d'automatisation: Youlia Raisper */ 

 function Restore_CR1037_WithModel()
{  
    try{
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800236NA", language+client); 
        var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
        
        Login(vServerSleeves, user ,psw,language);
        Get_ModulesBar_BtnAccounts().Click();
  
        Search_Account(account); 
          
        DragAccountToPortfolio(account);   
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
    }         

}