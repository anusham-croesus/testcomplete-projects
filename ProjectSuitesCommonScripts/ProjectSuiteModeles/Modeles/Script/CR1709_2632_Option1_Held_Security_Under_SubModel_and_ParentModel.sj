//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2632
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */


function CR1709_2632_Option1_Held_Security_Under_SubModel_and_ParentModel()
{
    try{  
        Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)            
    
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client); 
        var subModel=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);
        var modelsubsProrata=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "modelsubsProrata", language+client);
        var percent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Percent_modelsubsProrata", language+client);
        var Account800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049OB", language+client);
        var Account800049RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049RE", language+client);
        var grpRebalance=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GrpRebalanceHeader", language+client);
        var cmbSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CmbSelectionText", language+client);  
        var lblNumberOfModels=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "LblNumberOfModelsText", language+client); 
        var txtNumberOfModels=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TxtNumberOfModelsText", language+client);                       
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                            
        SearchModelByName(modelsubsProrata);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelsubsProrata,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelsubsProrata,10), Get_ModulesBar_BtnPortfolio());
          
        //Ajouter un sous-modele
        Get_Toolbar_BtnAdd().Click()
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73)
        } 
        AddSubModelToModel(modelCanadianEqui,percent,percent);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
          
        //Assoccié compte 800049-OB au Subs prorata
        Get_ModulesBar_BtnModels().Click();
        AssociateAccountWithModel(modelsubsProrata,Account800049OB)
          
        //Associé 800049-RE au Ch canadien equities
        AssociateAccountWithModel(modelCanadianEqui,Account800049RE)
                                    
        //Rééquilibrer le modèle 
        SearchModelByName(modelCanadianEqui);
          
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
                  3- Libellé =NBRE de modeles inclus = 1*/
                  Log.Message("croes-8576")
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance(), "Header", cmpEqual, grpRebalance);    //EM: 90-06-Be-17 datapool modifié selon le Jira croes-8576
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(), "Text", cmpEqual, cmbSelection); 
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_LblNumberOfModels(), "Content", cmpEqual, lblNumberOfModels); 
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_TxtNumberOfModels(), "Text", cmpEqual, txtNumberOfModels); 
          
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChNumber(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChNumber(), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", Account800049RE,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800049RE); 
        Get_WinRebalance_BtnClose().Click(); 
         
      
        //*************************************************Réinitialiser les données*********************************************************  
       //RestoreData(Account800049OB,modelsubsProrata,Account800049RE,modelCanadianEqui,subModel)
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
       
    }
    finally {  
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(Account800049OB,modelsubsProrata,Account800049RE,modelCanadianEqui,subModel)
        Terminate_CroesusProcess(); //Fermer Croesus 
        Activate_Inactivate_Pref("REAGAR", "PREF_REBALANCE_SUBMODEL", "NO", vServerModeles)
        Runner.Stop(true);      
    }
}

function RestoreData(Account800049OB,modelsubsProrata,Account800049RE,modelCanadianEqui,subModel){
       Get_ModulesBar_BtnModels().Click();
       RemoveAccount(Account800049OB,modelsubsProrata);
       RemoveAccount(Account800049RE,modelCanadianEqui);
       ActivateDeactivateModel(modelsubsProrata,false);
       //supprimer le sous-modele
       
       Get_ModelsGrid().Find("Value",modelsubsProrata,10).Click();
       //chainer vers le module Portefeuille,
       Drag( Get_ModelsGrid().Find("Value",modelsubsProrata,10), Get_ModulesBar_BtnPortfolio());
         if(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",subModel,10).Exists){
         Get_PortfolioPlugin().Find("Value",subModel,10).Click();
         Get_Toolbar_BtnDelete().Click()
         var width =Get_DlgConfirmation().Get_Width();
         Get_DlgConfirmation().Click((width*(1/3)),73); 
         Get_PortfolioBar_BtnSave().Click();
         Get_WinWhatIfSave_BtnOK().Click();
       }
}

function RemoveAccount(account,modelName){        
    SearchModelByName(modelName);
    if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Exists){
      Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
      Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
     /*var width = Get_DlgCroesus().Get_Width();
     Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
     var width = Get_DlgConfirmation().Get_Width();
     Get_DlgConfirmation().Click((width*(1/3)),73);
    }
}


