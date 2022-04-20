//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA



 /* Description : 

 
Analyste d'automatisation: Youlia Raisper */


function UnassignRelationship_ModelCROES984()
{
    try{       
          
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");                 
        var relationship = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Relationship_CROES984", language+client);               
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelCROES984", language+client);                 
        var modelChRevenusFixes=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client);
                                      
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        SearchModelByName(modelName);
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationship,10).Exists){
          Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationship,10).Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          /*var width = Get_DlgCroesus().Get_Width();
          Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(1/3)),73);
        }
        aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0); 
        
        //Le changement de la BD dans AT
        SearchModelByName("RECHANGE_PANIER");
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800285",10).Exists){
          Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800285",10).Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          /*var width = Get_DlgCroesus().Get_Width();
          Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(1/3)),73);
        }
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800285",10).Exists){
          Log.Error("Le client est toujours associé au modèle")
        }
        else{
          Log.Checkpoint("Le client n'est plus associé au modèle")
        }
        
        //Le changement de la BD dans AT
        var model="SOUS_MODELE"
        var client800038="800038";
        SearchModelByName(model);
        if(Get_ModelsGrid().Find("Value",model,10).Exists){
          if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client800038,10).Exists){
             Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client800038,10).Click();
             Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
              /*var width = Get_DlgCroesus().Get_Width();
              Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
              var width = Get_DlgConfirmation().Get_Width();
              Get_DlgConfirmation().Click((width*(1/3)),73);
          }           
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
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}