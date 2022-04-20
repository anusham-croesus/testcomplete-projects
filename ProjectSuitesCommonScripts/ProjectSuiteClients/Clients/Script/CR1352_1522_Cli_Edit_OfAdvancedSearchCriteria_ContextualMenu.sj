//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1516_Cli_Edit_OfAdvancedSearchCriteria_StatusBar
//USEUNIT Global_variables

/* Description :Modification du critère a partir de menu contextuel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1522
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1522_Cli_Edit_OfAdvancedSearchCriteria_ContextualMenu()
 {   
   if (client == "BNC" ){
      var criterion="same adress";
   }
   else{
      var criterion="CR1352_1522_Cli_Edit";
   }
   
   try{
       Login(vServerClients, userName, psw, language);
       Get_ModulesBar_BtnClients().Click();
       
       Get_MainWindow().Maximize();
   
       if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC" ){  
          Get_Toolbar_BtnManageSearchCriteria().Click(); 
          Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize(); 
          //Ajouter un critère de recherche en cliquant sur Ajouter       
          Get_WinSearchCriteriaManager_BtnAdd().Click();      
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
          WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CRITERIA_WINDOW");
       }
  
       if (client == "BNC" ){
         //Vérifier Combien des résultants le critère génère 
         Get_Toolbar_BtnManageSearchCriteria().Click(); 
         Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
         Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).Click();
         Get_WinSearchCriteriaManager_BtnLoad().Click();
       }
       
        var NbOfcheckedElementsBefore =Get_MainWindow_StatusBar_NbOfcheckedElements().Text
    
        //Fermer le critère appliqué
        var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
   
        Get_Toolbar_BtnManageSearchCriteria().Click(); 
 
        //Choisir un filtre  
        Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).Click();
        Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).ClickR();
        Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Edit().Click();
       
          //Modifier le critère             
        if(Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClient().Exists==true){        
              Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClient().Click();
              if (client == "BNC" ){
                  Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentativeItem().Click();  
              } 
              else{//RJ
                  Get_WinAddSearchCriterion_LvwDefinition_LlbClientsExternalClientItem().Click();                                           
              }
        }          
        else{
          Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentative().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClientItem().Click();
        }
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        
//        if (client == "CIBC" ){     //Dans le cas de CIBC ce filtre ne retourne pas de resultats 
//            Get_DlgWarning().Close(); 
//            Get_WinSearchCriteriaManager_BtnClose().Click();
//        } 
//        else{
            WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CRITERIA_WINDOW"); 
       
            //Vérifier que le critère a été modifié. 
            var NbOfcheckedElementsAfter =Get_MainWindow_StatusBar_NbOfcheckedElements().Text
            aqObject.CompareProperty(NbOfcheckedElementsBefore,cmpNotEqual,NbOfcheckedElementsAfter,true,3)
   
            //Fermer le critère appliqué
            var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
            Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
//        }
        Get_MainWindow().SetFocus();
        Close_Croesus_SysMenu();
    } 
    
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
      finally{
        if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC"){
          Delete_FilterCriterion(criterion,vServerClients)    
        } 
    }      
 }
 

