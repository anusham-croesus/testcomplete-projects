//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3610

Analyste d'assurance qualité: Manel 
Analyste d'automatisation: Youlia Raisper
La version de scriptage: ref90-04-BNC-59B-11--V9-1_8-co6x */


function CR1709_3610_Check_AdditionOfSubstitution_Basket()
{
    try{  
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)                          
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var modelBond=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChBonds", language+client); 
        var modelGrowth=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelGROWTH", language+client);          
        var target10=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target10_3610", language+client);
        var SecurityCAEINC=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCAEINC", language+client);
        var Message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_3610", language+client);
        var SubModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelGROWTHBASKET", language+client);
        var SubstituteType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeAlternative", language+client);
                                    
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        
        SearchModelByName(modelBond);
        Get_ModelsGrid().Find("Value",modelBond,10).Click();
        Drag(Get_ModelsGrid().Find("Value",modelBond,10), Get_ModulesBar_BtnPortfolio()); 
          
        //Ajouter un sous-modele
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        Get_WinAddPositionSubmodel_TxtSubmodel().Click()
        Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Enter]")
        Get_SubMenus().Find("Value",modelGrowth,10).DblClick();
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(target10);

        Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_BtnEdit().Click();
        Get_WinSubstitutionSecurities_BtnAdd().Click();
        Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(SecurityCAEINC);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");

        aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(), "IsChecked", cmpEqual,true);
        aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_TxtFallbackMessage(), "Text", cmpEqual,Message);
        
        Get_WinReplacement_BtnOK().Click();
        Get_WinSubstitutionSecurities_BtnOK().Click();
        Get_WinAddPositionSubmodel_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Validation
        Get_PortfolioPlugin().Find("Value",SubModel,10).DblClick();
        aqObject.CheckProperty(Get_WinSubModelInfo_GrpSubstitutionSecurities_DgvSubstitution().WPFObject("RecordListControl", "", 1).Find("DisplayText",SecurityCAEINC,10) , "Exists", cmpEqual,true);
        Get_WinSubModelInfo_GrpSubstitutionSecurities_DgvSubstitution().WPFObject("RecordListControl", "", 1).Find("DisplayText",SecurityCAEINC,10).Click();
        aqObject.CheckProperty(Get_WinSubModelInfo_GrpSubstitutionSecurities_DgvSubstitution().WPFObject("RecordListControl", "", 1).Find("DisplayText",SecurityCAEINC,10).DataContext.DataItem , "SubstituteType", cmpEqual,SubstituteType);
        Get_WinSubModelInfo_BtnCancel().Click(); 
        
        //***************************RestoreData**********************************
        //RestoreData(SubModel)
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        
    }
    finally {   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        
        SearchModelByName(modelBond);
        Get_ModelsGrid().Find("Value",modelBond,10).Click();
        Drag(Get_ModelsGrid().Find("Value",modelBond,10), Get_ModulesBar_BtnPortfolio()); 
        RestoreData(SubModel)
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        //Close_Croesus_X();
        
        Terminate_CroesusProcess(); //Fermer Croesus 
  	    //Runner.Stop(true);      
    }
}

function RestoreData(SubModel)
{
    //Supprimer le sous modèle 
    if(Get_PortfolioPlugin().Find("Value",SubModel,10).Exists){
        Get_PortfolioPlugin().Find("Value",SubModel,10).Click();
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
function test(){
    var modelBond=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChBonds", language+client); 
  var SubModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelGROWTHBASKET", language+client);
   SearchModelByName(modelBond);
        Get_ModelsGrid().Find("Value",modelBond,10).Click();
        Drag(Get_ModelsGrid().Find("Value",modelBond,10), Get_ModulesBar_BtnPortfolio()); 
        RestoreData(SubModel)
}