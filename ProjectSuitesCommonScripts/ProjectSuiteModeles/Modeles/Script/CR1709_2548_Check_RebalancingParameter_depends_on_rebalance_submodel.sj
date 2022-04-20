//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3120_Option1_Error_Message_Cas1

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2548
Analyste d'automatisation: Youlia Raisper */



function CR1709_2548_Check_RebalancingParameter_depends_on_rebalance_submodel(){
  
  try{  
        Activate_Inactivate_Pref("GP1859", "PREF_REBALANCE_SUBMODEL", "NO", vServerModeles)
        RestartServices(vServerModeles);
        var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client); 
        var modelChRevenusFixes=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client);
        var modelChBonds=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChBonds", language+client);         
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        var Client800228=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800228", language+client);  
        var grpRebalance=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GrpRebalanceHeader", language+client);
        var cmbSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CmbSelectionText", language+client);  
        var lblNumberOfModels=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "LblNumberOfModelsText", language+client); 
        var cmbSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CmbSelectionText", language+client);  
        var selectedSubModelComboBox=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SelectedSubModelComboBox", language+client);
        var target=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target_2548", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_2548", language+client);
        var property=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PropertyForDlgWarningLblMessage", language+client);
           
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        
        //Le changement de la BD dans AT
        var model="SOUS_MODELE"
        SearchModelByName(model);
        if(Get_ModelsGrid().Find("Value",model,10).Exists){
          //chainer vers le module Portefeuille
          Drag(Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio()); 
          //Supprimer le sous modèle 
          if(Get_PortfolioPlugin().Find("Value",modelChRevenusFixes,10).Exists){
              Get_PortfolioPlugin().Find("Value",modelChRevenusFixes,10).Click();
              Get_Toolbar_BtnDelete().Click(); 
              var numberOftries=0;  
              while (!Get_DlgConfirmation().Exists && numberOftries < 5){
                Get_Toolbar_BtnDelete().Click();
                numberOftries++;
              }          
              var width =Get_DlgConfirmation().Get_Width();
              Get_DlgConfirmation().Click((width*(1/3)),73);
              if(Get_DlgConfirmation().Exists) {
                Get_DlgConfirmation().Click((width*(1/3)),73);
              }
              //sauvgarder les modification 
              Get_PortfolioBar_BtnSave().Click();
              Get_WinWhatIfSave_BtnOK().Click();
          }
        }
        
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelChRevenusFixes);
        //chainer vers le module Portefeuille
        Drag(Get_ModelsGrid().Find("Value",modelChRevenusFixes,10), Get_ModulesBar_BtnPortfolio()); 
         
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        AddSubModelToModel(modelChBonds,target,"");
         
        //Valider que le sous-modele 
        CheckPresenceofPosition(modelChBonds);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
         
        Get_ModulesBar_BtnModels().Click(); 
        AssociateClientWithModel(modelChRevenusFixes,Client800228) 
        
        SearchModelByName(modelChBonds);    
        Get_Toolbar_BtnRebalance().Click(); 
        
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), property, cmpEqual, message);
        Get_DlgWarning().Close();
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
        Activate_Inactivate_Pref("GP1859", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)
        RestartServices(vServerModeles);
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
              
        SearchModelByName(modelChBonds);    
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
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance(), "Header", cmpEqual, grpRebalance);   //EM: 90-06-Be-17 datapool modifié selon le Jira croes-8576 
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(), "Text", cmpEqual, cmbSelection); 
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_LblNumberOfModels(), "Content", cmpEqual, lblNumberOfModels);        
        Get_WinRebalance_BtnClose().Click();  

      
        //*************************************************Réinitialiser les données*********************************************************  
        //RestoreData(Client800228,modelChRevenusFixes,modelChBonds)
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(Client800228,modelChRevenusFixes,modelChBonds)
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_Pref("GP1859", "PREF_REBALANCE_SUBMODEL", "NO", vServerModeles) 
        RestartServices(vServerModeles);
        Runner.Stop(true);     
    }
}

function RestoreData(Client800228,modelChRevenusFixes,modelChBonds){
  Get_ModulesBar_BtnModels().Click();   
  RemoveAccountFromModel(Client800228,modelChRevenusFixes);
  SearchModelByName(modelChRevenusFixes);
  //chainer vers le module Portefeuille
  Drag(Get_ModelsGrid().Find("Value",modelChRevenusFixes,10), Get_ModulesBar_BtnPortfolio()); 
  //Supprimer le sous modèle 
  Get_PortfolioPlugin().Find("Value",modelChBonds,10).Click();
  Get_Toolbar_BtnDelete().Click(); 
  var numberOftries=0;  
  while (!Get_DlgConfirmation().Exists && numberOftries < 5){
    Get_Toolbar_BtnDelete().Click();
    numberOftries++;
  }          
  var width =Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  if(Get_DlgConfirmation().Exists) {
    Get_DlgConfirmation().Click((width*(1/3)),73);
  }
    
  //sauvgarder les modification 
  Get_PortfolioBar_BtnSave().Click();
  Get_WinWhatIfSave_BtnOK().Click()           
}