﻿//USEUNIT Common_functions
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



function CR1709_3157_Option3_Error_Message_Cas13(){
  
  try{  
         Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)

          var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client);
          var Account800252RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800252RE", language+client);
          var Account800207RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800207RE", language+client);
          var Account800066GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800066GT", language+client); 
          var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
          var model2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent1_3120", language+client);
          var model3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent2_3120", language+client);
          var model4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent3_3120", language+client);
          var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
          var selectedModelSubModelComboBox=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SelectedModelSubModelComboBox", language+client);
          var txtNumberOfModelsAfterSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "txtNumberOfModelsAfterSelection_3157", language+client);
          var message1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message3157_MSG6", language+client);
          var message2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message3120_MSG13", language+client);
          var property=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PropertyForDlgWarningLblMessage", language+client);
          var BMOmessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageSecuritiesBMO", language+client);
              
          Login(vServerModeles, user, psw, language);         
          Get_ModulesBar_BtnModels().Click();
          Get_MainWindow().Maximize();
              
   
          //Modèle principal actif, avec des assigné. Modèles parents inactifs,pas d'assignés.               
          CR1709_3120_Option1(true,true,false,false);

              
          SearchModelByName(model1);
          //Récupérer le numéro des models 
          var model1number=Get_ModelsGrid().Find("Value",model1,10).DataContext.DataItem.AccountNumber
              
          //Rééquilibrer le modèle 
          SearchModelByName(model1);
           //chainer vers le module Portefeuille,
          Drag(Get_ModelsGrid().Find("Value",model1,10), Get_ModulesBar_BtnPortfolio()); 
               
          Get_Toolbar_BtnRebalance().Click();         
          //Dans le cas, si le click ne fonctionne pas  
          var numberOftries=0;  
          while ( numberOftries < 5 && !Get_WinRebalance().Exists){
              Get_Toolbar_BtnRebalance().Click(); 
              numberOftries++;
          } 
          Get_WinRebalance().Parent.Maximize();
              
           //Séléctionner l'option 3 dans le combo box :Rééquilirage du:
          SelectComboBoxItem(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(),selectedModelSubModelComboBox)
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_TxtNumberOfModels(), "Text", cmpEqual, txtNumberOfModelsAfterSelection); 

          Get_WinRebalance_BtnNext().Click();
          //Valider qu’on peut passer au deuxième étape sans aucun message           
          aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",Account800049NA,10).DataContext.DataItem, "ModelAccountNo", cmpEqual, model1number);  
          Get_WinRebalance_BtnClose().Click(); 
      
        //*************************************************Réinitialiser les données********************************************************* 
        Get_ModulesBar_BtnModels().Click(); 
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

function Scroll(){
   var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().get_ActualWidth()
   var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().get_ActualHeight()
   Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Click(ControlWidth-40, ControlHeight-5)
}