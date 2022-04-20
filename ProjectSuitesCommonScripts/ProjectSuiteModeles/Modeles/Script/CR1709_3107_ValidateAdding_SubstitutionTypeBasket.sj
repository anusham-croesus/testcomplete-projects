//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3107
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3107_ValidateAdding_SubstitutionTypeBasket()
 {             
    try{  
    
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var ModelChRevenusFixes=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client);
        var AGF420=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionAGF420", language+client);
        var Basket844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Basket844000", language+client);
        var PanierObligCorpor=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PanierObligCorpor", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);

        
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        
        SearchModelByName(ModelChRevenusFixes);
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",ModelChRevenusFixes,10), Get_ModulesBar_BtnPortfolio());
        Get_Portfolio_PositionsGrid().Find("Value",AGF420,10).Click();
        Get_PortfolioBar_BtnInfo().Click();
        if(Get_DlgConfirmation().Exists){
          var width =Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(3/5)),73); 
        }
        
       Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
       Get_WinSubstitutionSecurities_BtnAdd().Click();
       Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation  
       Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(PanierObligCorpor);
       Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
       
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoComplementSecurity(),"IsEnabled",cmpEqual, true)
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity(),"IsEnabled",cmpEqual, true)
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(),"IsEnabled",cmpEqual, false)     
       Get_WinReplacement_BtnCancel().Click();
       Get_WinSubstitutionSecurities_BtnOK().Click();     
       Get_WinPositionInfo_BtnOK().Click();                  
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true)
    }
 }