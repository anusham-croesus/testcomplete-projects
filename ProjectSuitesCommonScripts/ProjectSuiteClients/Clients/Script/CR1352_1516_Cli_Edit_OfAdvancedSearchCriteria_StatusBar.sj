//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :Modification du critère a partir de la barre d'état en bas a droite
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1516
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1516_Cli_Edit_OfAdvancedSearchCriteria_StatusBar()
 {     
  if (client == "BNC" ){
      var criterion="same adress";
  }
  else{
      var criterion="CR1352_1516_Cli_Edit";
  }
   
  try{
       Login(vServerClients, userName, psw, language);
       Get_ModulesBar_BtnClients().Click();
       
       Get_MainWindow().Maximize();
     
       Get_Toolbar_BtnManageSearchCriteria().Click(); 
       Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
   
       if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC"   ){   
        //Ajouter un critère de recherche en cliquant sur Ajouter       
          Get_WinSearchCriteriaManager_BtnAdd().Click()      
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSave().Click();
          WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CRITERIA_WINDOW");
       }
 
       //Choisir un filtre 
       Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).Click();
       Get_WinSearchCriteriaManager_BtnRefresh().Click()
       WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CriteriaManagerWindow");
       var NbOfcheckedElementsBefore =Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
       
       //Modifier le critère à partir de StatusBar 
       Get_MainWindow_StatusBar_NbOfcheckedElements().DblClick(); 
         
        //Modifier le critère             
       if(Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClient().Exists==true){        
        Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClient().Click();
        if (client == "BNC" ){
          Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentativeItem().Click();  
        } 
        else{//RJ
          Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFictitiousClientItem().Click();
        }
       }
       else{
         Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentative().Click();
         Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClientItem().Click();

       }
       Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
       WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CRITERIA_WINDOW");
    
       //Vérifier que le critère a été modifié.     
       var NbOfcheckedElementsAfter =Get_MainWindow_StatusBar_NbOfcheckedElements().Text
       aqObject.CompareProperty(NbOfcheckedElementsBefore,cmpNotEqual,NbOfcheckedElementsAfter)
   
       //Fermer le critère appliqué
       var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
       Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
        
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();
   }
     catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
      finally{
        if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC" ){
            Delete_FilterCriterion(criterion,vServerClients) 
        }    
    }       
 }
 
 function Edit_Criterion(description,vServer) //La fonction n’est pas utilisée 
 {       
      //SELECT     
      var querySelect="SELECT * FROM  B_MSG  where DESCRIPTION='"+description+"'";
      Log.Message(querySelect)
      
      var Qry =ADO.CreateADOQuery()
      Qry.ConnectionString = GetDBAConnectionString(vServer);
      
      Qry.SQL =querySelect; 
      Qry.Open();      
      Qry.First();     
      var id = Qry.FieldByName("MSG_ID").Value;
           
      //Update
      var queryUpdateFromB_Criteria="UPDATE b_CRITERIA SET SENTENCE='{PrefixListOf} {1;2;3} {VerbBeingPartOfAFamily} {FieldFamilyTotalValue} {OperOverOrEqual} {NumValue:100000} {UnitDollars} {EndOfCriteria}' where MSG_ID="+id+""
      Qry.SQL=queryUpdateFromB_Criteria;
      Qry.ExecSQL();
      Qry.Close();
 }
 
