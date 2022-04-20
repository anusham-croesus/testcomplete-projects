//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4534
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper */

 function CR1709_4534_OperatorsOfSearchCriteria_BasedOnWithdrawals()
 {     
    try{
    
      Activate_Inactivate_Pref("GP1859","PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT ","1",vServerModeles)
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
      var ItemAccounts=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemAccounts", language+client);
      var ItemDate=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemDate", language+client);
      var ItemNextWithdrawalDate=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemNextWithdrawalDate", language+client);
      var ItemOperatorIsPriorOrEqualTo=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemOperatorIsPriorOrEqualTo", language+client);
      var ItemOperatorIsPrior=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemOperatorIsPrior", language+client);  
    
      Login(vServerModeles, user , psw ,language);
      Get_ModulesBar_BtnAccounts().Click();      
      Get_MainWindow().Maximize();
      
      //liste des comptes(compte réel) ayant date du prochain retrait : et valider que seulement 2 opréateurs 1- antérieur au 2- égale ou antérieur au 

      Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
      Get_WinAddSearchCriterion().Parent.Maximize();
          
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_ItemNextWithdrawalDate().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
      aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemOnOrPriorTo(), "VisibleOnScreen", cmpEqual, true);
      aqObject.CheckProperty(Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItempriorTo(), "VisibleOnScreen", cmpEqual, true);
      aqObject.CheckProperty(Get_SubMenus().WPFObject("ContextMenu", "", 1), "ChildCount", cmpEqual, 2);
      Get_WinAddSearchCriterion_BtnCancel().Click();

      
      /*Dans comptes  : Ajouter un critere de recherche AVANCÉ : 
      Cliquez sur Gérer les criteres de recharche == > Ajouter avancé ==> Classe du compte = compte réél ==>
      cHAMP = Date du prochain retrait :
      Opérateur Date et valider que seulement 2 opréateurs 
      1- antérieur au
      2- égale ou antérieur au */
      Get_Toolbar_BtnManageSearchCriteria().Click();
      Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
      Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField().Click();
      Get_SubMenus().Find("Header",ItemAccounts,10).Click();
      Get_CroesusApp().Find("Header",ItemDate,20).Click();
      Get_CroesusApp().Find("Header",ItemNextWithdrawalDate,10).Click();
      aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator().Items.Item(0), "WPFControlText", cmpEqual, ItemOperatorIsPrior);
      aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator().Items.Item(1), "WPFControlText", cmpEqual, ItemOperatorIsPriorOrEqualTo);
      aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator().Items, "Count", cmpEqual, 2);
      Get_WinCRUSearchCriterionAdvanced_BtnCancel().Click();
      Get_WinSearchCriteriaManager_BtnClose().Click();
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
        Terminate_CroesusProcess(); //Fermer Croesus  
  	    Runner.Stop(true);  
    }   
 }
 