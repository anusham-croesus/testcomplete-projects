//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Annuler la consultation apres avoir fait Info sur une ligne sous-modèle
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2509
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2509_CancelConsultation_AfterInfo_On_Submodel()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var modelDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ModelNo_2509", language+client)
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CodeCP_2509", language+client);
        var percent=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Percent_2509", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        
        //Création de modèles         
        for(var i=1; i<=2;i++){
          Get_Toolbar_BtnAdd().Click();    
          Get_WinModelInfo_GrpModel_TxtFullName().Keys(modelDescription+"_"+i);
          Get_WinModelInfo_GrpModel_CmbIACode().Click();
          Aliases.CroesusApp.subMenus.Find("DataContext",codeCP,10).Click();
          Get_WinModelInfo_BtnOK().Click();
                  
          if( Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+i,10).Exists){
            Log.Checkpoint("Le modèle a été créé ")
          } else{
            Log.Error("Le modèle n'a pas été créé")
          } 
        }
        
        //Drag to Portfolio
        Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+"1",10).Click();        
        Drag(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+"1",10), Get_ModulesBar_BtnPortfolio())
        
        //Check that thee is only one model 
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1);
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "ClientFullName", cmpEqual,modelDescription+"_"+"1");
        
        Get_Toolbar_BtnAdd().Click(); 
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //Add a security Submodel
        Get_WinAddPositionSubmodel_TxtSubmodel().Keys(modelDescription+"_"+"2");
        Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Tab]");
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percent);
        Get_WinAddPositionSubmodel_BtnOK().Click();
        
        
        //Check that the submodel was added
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,2);        
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem, "SecurityDescription", cmpEqual,modelDescription+"_"+"2");
        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+"2",10).Click();
        Get_PortfolioBar_BtnInfo().Click();
        
        if(Get_WinSubModelInfo().Exists){
          aqObject.CheckProperty(Get_WinSubModelInfo(), "Title", cmpContains,modelDescription+"_"+"2"); 
          Log.Checkpoint("La fenêtre s’affiche ")
          Get_WinSubModelInfo_BtnCancel().Click();
          if(!Get_WinSubModelInfo().Exists){
            Log.Checkpoint("La fenêtre est fermée")
          }
          else{
            Log.Error("La fenêtre n'est pas fermée")
          } 
        }
        else{
          Log.Error("La fenêtre ne s’affiche pas")
        } 
        
        //Remettre les données 
        Get_ModulesBar_BtnModels().Click();
        
        //Supprimer les modèles         
        for(var i=1; i<=2;i++){                  
          if( Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+i,10).Exists){
            Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+i,10).Click();
            Get_Toolbar_BtnDelete().Click(); 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
             if( Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+i,10).Exists){
               Log.Error("Le modèle n’a pas été supprimé")
             } 
             else{
               Log.Checkpoint("Le modèle a été supprimé")
             } 
          }  
        }
        
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        //Remettre les données 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        //Supprimer les modèles         
        for(var i=1; i<=2;i++){                  
          if( Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+i,10).Exists){
            Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+i,10).Click();
            Get_Toolbar_BtnDelete().Click(); 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
             if( Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription+"_"+i,10).Exists){
               Log.Error("Le modèle n’a pas été supprimé")
             } 
             else{
               Log.Checkpoint("Le modèle a été supprimé")
             } 
          }  
        }
        Close_Croesus_MenuBar();
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }
 
