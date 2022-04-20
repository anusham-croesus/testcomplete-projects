//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3120_Option1_Error_Message_Cas1

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3120
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_3120_Option1_Error_Message_Cas5(){
  
  try{  
        Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)
             
        var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client); 
        var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
              
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
              
        //Modèle principal actif, avec un assigné. Modèles parents actifs, pas d'assignés.                   
        CR1709_3120_Option1(true,true,false,true);
              
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