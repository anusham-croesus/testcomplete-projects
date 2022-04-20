//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3120_Option1_Error_Message_Cas2

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3157
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_3157_Option3_Error_Message_Cas11(){
  
  try{  
         Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)

          var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
          var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client); 
          var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
          var message1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message3152_MSG6", language+client);
          var message2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message3120_MSG13", language+client);
          var property=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PropertyForDlgWarningLblMessage", language+client);
              
          Login(vServerModeles, user, psw, language);         
          Get_ModulesBar_BtnModels().Click();
          Get_MainWindow().Maximize();
              
 
          //Modèle principal inactif, avec des assigné. Modèles parents inactifs, avec des assignés.               
          CR1709_3120_Option1(true,false,true,false);
              
              
          //Rééquilibrer le modèle 
          SearchModelByName(model1);
          //Récupérer le numéro du model Principal 
          var model1number=Get_ModelsGrid().Find("Value",model1,10).DataContext.DataItem.AccountNumber
              
           //chainer vers le module Portefeuille,
          Drag(Get_ModelsGrid().Find("Value",model1,10), Get_ModulesBar_BtnPortfolio()); 
                        
          Get_Toolbar_BtnRebalance().Click();  

          //Valider le MSG-6 message           
          aqObject.CheckProperty(Get_DlgWarning_LblMessage(),property, cmpEqual, message1+"\r\n\r\n" +model1+", "+ model1number+"\r\n\r\n"+message2);
          Get_DlgWarning().Close();     
          Get_ModulesBar_BtnModels().Click();

      
        //*************************************************Réinitialiser les données********************************************************* 
        Get_ModulesBar_BtnModels().Click(); 
        //RestoreData(true,true,true,true);
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(true,true,true,true);
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "NO", vServerModeles)
        Runner.Stop(true);      
    }
}