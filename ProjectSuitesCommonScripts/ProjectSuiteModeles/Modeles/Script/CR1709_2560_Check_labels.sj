//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3120_Option1_Error_Message_Cas1

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2560
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2667 
Analyste d'automatisation: Youlia Raisper */



function CR1709_2560_Check_labels(){
  
  try{  
         Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)

         var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client); 
         var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
         var assignedModelColumn=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnAssignedModel", language+client);   
         var grpRebalance=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GrpRebalanceHeader", language+client);
         var cmbSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CmbSelectionText", language+client);  
         var lblNumberOfModels=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "LblNumberOfModelsText", language+client); 
         var cmbSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CmbSelectionText", language+client);  
         var selectedSubModelComboBox=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SelectedSubModelComboBox", language+client);
         var selectedSubModelAndSubModelComboBox=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SelectedSubModelAndSubModelComboBox", language+client); 
         var CmbSelectionCount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CmbSelectionCount", language+client);
          
         Login(vServerModeles, user, psw, language);         
         Get_ModulesBar_BtnModels().Click();
         Get_MainWindow().Maximize();
              
         //Modèle principal actif, avec un assigné. Modèles parents actifs, avec des assignés.               
         CR1709_3120_Option1(true,true,true,true);
              
          //Rééquilibrer le modèle 
          SearchModelByName(model1);
          //Récupérer le numéro du model Principal 
          var model1number=Get_ModelsGrid().Find("Value",model1,10).DataContext.DataItem.AccountNumber
          
          Get_Toolbar_BtnRebalance().Click(); 
          //Dans le cas, si le click ne fonctionne pas  
          var numberOftries=0;  
          while ( numberOftries < 5 && !Get_WinRebalance().Exists){
              Get_Toolbar_BtnRebalance().Click(); 
              numberOftries++;
          } 
          Get_WinRebalance().Parent.Maximize();
                    
          /*Valider 1- Le combo Libellé = rééquilibrage du : 
                    2- le combo est positionné sur l'option 1 : Modele séléctionné
                    3- Libellé =NBRE*/
          Log.Message("croes-8576")
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance(), "Header", cmpEqual, grpRebalance);  //EM: 90-06-Be-17 datapool modifié selon le Jira croes-8576
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(), "Text", cmpEqual, cmbSelection); 
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_LblNumberOfModels(), "Content", cmpEqual, lblNumberOfModels);
          
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection().Items,"Count", cmpEqual, CmbSelectionCount);
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection().Items.Item(0),"Value", cmpEqual, cmbSelection);
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection().Items.Item(1),"Value", cmpEqual, selectedSubModelComboBox);
          aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection().Items.Item(2),"Value", cmpEqual, selectedSubModelAndSubModelComboBox);
                   
          Get_WinRebalance_BtnNext().Click(); 
          //Valider qu’on peut passer au deuxième étape sans aucun message 
          Log.Message("CROES-8824") 
          aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChAssignedModel().Content, "OleValue", cmpEqual, assignedModelColumn); //EM : 90-06-Be-13 datapool modifié selon  le Jira CROES-8824 - avant "Modèle assigné"        
          aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",Account800049NA,10).DataContext.DataItem, "ModelAccountNo", cmpEqual, model1number);         
          Get_WinRebalance_BtnClose().Click();  

      
        //*************************************************Réinitialiser les données*********************************************************  
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
