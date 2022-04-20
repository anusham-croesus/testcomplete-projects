//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C1_Create_AllSleeves_Via_InvestmentObjective


 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C10_DeleteSleeve_CheckMessage()
{
      try{    
         var user= ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");  
         var sleeveDescription =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtSleeveDescription_C10", language+client);
         var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "DlgCroesusLblMessage_C10", language+client); 
         var account = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C10", language+client); 
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtTargerPercent_C10", language+client);
         var min=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMinPercent_C10", language+client);
         var max=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveTxtMaxPercent_C10", language+client);
           
         Login(vServerSleeves, user ,psw,language);
         Get_ModulesBar_BtnAccounts().Click();
                               
         Search_Account(account);
         
         DragAccountToPortfolio(account); 
         
         Get_PortfolioBar_BtnSleeves().Click();          
         Get_WinManagerSleeves().Parent.Maximize();

         //Ajouter un segment  
         Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         AddEditSleeveWinSleevesManager(sleeveDescription,"",target,min,max,"")                   
         Get_WinManagerSleeves_BtnSave().Click(); 
         Delay(1500);
                                                     
         //******************************************Vérification******************************************************************************************
         
         //a) Verifier le message
                    
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         SelectSleeveWinSleevesManager(sleeveDescription)
         
         Get_WinManagerSleeves().Click();
         Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
                
         aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, message);    
         
         Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
         
         Get_WinManagerSleeves_BtnSave().Click();                      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
    }
    finally {
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

