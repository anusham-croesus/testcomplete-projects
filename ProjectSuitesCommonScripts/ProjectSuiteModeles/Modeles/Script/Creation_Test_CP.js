//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description :
Analyste d'automatisation: Youlia Raisper */


function Creation_Test_CP()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");          
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_TestCP", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800214GT", language+client);        
        var securityQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityQ69694", language+client);        
        var targetQ70791=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityQ70791", language+client);
        var securityGGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityGGF593", language+client);
        var targetBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBBDB", language+client);
        var percent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Percent_TESTCP", language+client);         
        
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Créer un Modèle
        Get_PortfolioBar_BtnWhatIf().Click();    
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);    
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Click();
        Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modelName);
        Get_WinWhatIfSave_BtnOK().Click();
        
        Log.Message("YR:La réponse de Karima 12/02/2018 : voir avec Mélanie  ")
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/2)),73); */ //EM : Modifié depuis CO: 90-07-22-Be-1
         if(Get_DlgInformation().Exists) {    
                Get_DlgInformation().Close();
        }
        
        ChangeTarget(securityQ69694,percent);
        ChangeTarget(targetQ70791,percent);
        ChangeTarget(securityGGF593,percent);
        ChangeTarget(targetBBDB,percent);
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, percent);
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",targetQ70791,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, percent);
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityGGF593,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, percent);
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",targetBBDB,10).DataContext.DataItem, "ModelTargetPercent", cmpEqual, percent);
        
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelName);
        ActivateDeactivateModel(modelName,true);      
                         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
	    Runner.Stop(true);
    }
}

function ChangeTarget(position,target)
{
   Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DblClick();
   if(Get_DlgConfirmation().Exists){
       var width = Get_DlgConfirmation().Get_Width();
       Get_DlgConfirmation().Click((width*(2/3)),73)
   } 
   Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue().Keys(target);
   Get_WinPositionInfo_BtnOK().Click();
}


