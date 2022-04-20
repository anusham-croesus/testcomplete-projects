﻿//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3120_Option1_Error_Message_Cas1
//USEUNIT CR1709_3152_Option2_Error_Message_Cas9_2

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3152
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_3152_Option2_Error_Message_Cas13_1(){
  
  try{   
  
          Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)

          var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client); 
          var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
          var model2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent1_3120", language+client);
          var model3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent2_3120", language+client);
          var model4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent3_3120", language+client);
          var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
          var selectedSubModelComboBox=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SelectedSubModelComboBox", language+client);
          var txtNumberOfModelsAfterSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "txtNumberOfModelsAfterSelection_3152", language+client);
          var messageSecurityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageSecuritiesBMO", language+client);
          var message1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message3152_MSG6", language+client);
          var message2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message3120_MSG13", language+client);
          var property=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PropertyForDlgWarningLblMessage", language+client);
          var message3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message3152_MSG11", language+client);
                          
          Login(vServerModeles, user, psw, language);         
          Get_ModulesBar_BtnModels().Click();
          Get_MainWindow().Maximize();
              

          //Modèle principal actif, avec des assigné.Deux modèles parents actifs, les trois modèles parents n'ont pas assignés.              
          CR1709_3152_Option2(true,true,false,true,true,false)

              
          //Rééquilibrer le modèle 
          SearchModelByName(model1);
          //Récupérer le numéro du model Principal 
          var model1number=Get_ModelsGrid().Find("Value",model1,10).DataContext.DataItem.AccountNumber
          SearchModelByName(model2);
          var model2number=Get_ModelsGrid().Find("Value",model2,10).DataContext.DataItem.AccountNumber
          SearchModelByName(model3);
          var model3number=Get_ModelsGrid().Find("Value",model3,10).DataContext.DataItem.AccountNumber
          SearchModelByName(model4);
          var model4number=Get_ModelsGrid().Find("Value",model4,10).DataContext.DataItem.AccountNumber
              
          //Rééquilibrer le modèle 
          SearchModelByName(model1);
          Get_Toolbar_BtnRebalance().Click(); 
          //Dans le cas, si le click ne fonctionne pas  
          var numberOftries=0;  
          while ( numberOftries < 5 && !Get_WinRebalance().Exists){
              Get_Toolbar_BtnRebalance().Click(); 
              numberOftries++;
          } 
          Get_WinRebalance().Parent.Maximize();
          //Séléctionner l'option 2 dans le combo box :Rééquilirage du:
          SelectComboBoxItem(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(),selectedSubModelComboBox)
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_TxtNumberOfModels(), "Text", cmpEqual, txtNumberOfModelsAfterSelection);
              
          Get_WinRebalance_BtnNext().Click(); 
          //Valider le MSG-11.2 message (Le message a été validé avec Manel
          /* One or more models involved in this operation have no assigned portfolio to rebalance:
                MPARENT1_3120, ~M-00015-0
                MPARENT2_3120, ~M-00016-0
                MPARENT3_3120, ~M-00017-0

                One or more models involved in this operation are inactive:

                MPARENT3_3120, ~M-00017-0

                The securities BMO are held in the model and in the sub-model.

                MPARENT3_3120, ~M-00017-0

                It is therefore impossible to rebalance.
          */           
          aqObject.CheckProperty(Get_DlgWarning_LblMessage(),property, cmpContains, message3 +"\n\n"+model2+", "+model2number+"\n"+model3+", "+model3number+"\n"+model4+", "+model4number+"\n\n"+message1+"\n\n"+model4+", "+model4number+"\n\n"+messageSecurityBMO+"\n\n"+model4+", "+model4number+"\n\n"+message2) 
          Get_DlgWarning().Close(); 
          Get_WinRebalance_BtnClose().Click(); 
  
        //*************************************************Réinitialiser les données*********************************************************  
        //RestoreData(true,false,false,false);
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(true,false,false,false);
        Terminate_CroesusProcess(); //Fermer Croesus 
        Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "NO", vServerModeles)    
        Runner.Stop(true);  
    }
}
