//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3120
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_3120_Option1_Error_Message_Cas2(){
  
  try{  
         Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)

          var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client); 
          var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
          var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
              
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
          Get_WinRebalance_BtnNext().Click(); 
          //Valider qu’on peut passer au deuxième étape sans aucun message           
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



//Les paramètres a renseigner selon le tableau dans l'étape 4 du cas Croes-3120
/*
AssignedPrincipalModel boolean
ActivePrincipalModel boolean
AssignedSubModels boolean
ActivesSubModels boolean
*/
function CR1709_3120_Option1(AssignedPrincipalModel,ActivePrincipalModel,AssignedSubModels,ActivesSubModels)
{
    //les variables    
    var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
    var model2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent1_3120", language+client);
    var model3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent2_3120", language+client);
    var model4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent3_3120", language+client);
    var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client);
    var Account800252RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800252RE", language+client);
    var Account800207RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800207RE", language+client);
    var Account800066GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800066GT", language+client);
        
    if(AssignedPrincipalModel==true){
        //Assoccié compte 800049-NA 
        AssociateAccountWithModel(model1,Account800049NA)
    }

    ActivateDeactivateModel(model1,ActivePrincipalModel)
    
    if(AssignedSubModels==true){
       //Assoccié compte 800252-RE 
        AssociateAccountWithModel(model2,Account800252RE)
        //Assoccié compte 800207-RE 
        AssociateAccountWithModel(model3,Account800207RE)
        //Assoccié compte 800066-GT 
        AssociateAccountWithModel(model4,Account800066GT)
    }

    ActivateDeactivateModel(model2,ActivesSubModels)
    ActivateDeactivateModel(model3,ActivesSubModels)
    ActivateDeactivateModel(model4,ActivesSubModels)
                              
}

/*Pour restaurer les données : il faut renseigner 4 paramètres pour indiquer s’il faut enlever les comptes assignés.
modelPrincipal boolean
parent1 boolean
parent2 boolean
parent3 boolean
*/
function RestoreData(modelPrincipal,parent1,parent2,parent3){
       
   //les variables  
   var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
   var model2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent1_3120", language+client);
   var model3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent2_3120", language+client);
   var model4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent3_3120", language+client);
   var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client);
   var Account800252RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800252RE", language+client);
   var Account800207RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800207RE", language+client);
   var Account800066GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800066GT", language+client);
   
   Get_ModulesBar_BtnModels().Click();
   if(modelPrincipal == true){
      RemoveAccountFromModel(Account800049NA,model1);
   }
   if(parent1==true){
      RemoveAccountFromModel(Account800252RE,model2);
   }
   if(parent2==true){
      RemoveAccountFromModel(Account800207RE,model3);
   }
   if(parent3==true){
      RemoveAccountFromModel(Account800066GT,model4);
   }
       
   ActivateDeactivateModel(model1,true);
   ActivateDeactivateModel(model2,true);
   ActivateDeactivateModel(model3,true);
   ActivateDeactivateModel(model4,true);
}
