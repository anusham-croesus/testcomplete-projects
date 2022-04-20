//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3306
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper */

 function CR1709_3306_AdvancedCriterion_OnWithdrawal()
 {     
    try{
    
      Activate_Inactivate_Pref("GP1859","PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT ","1",vServerModeles)
      RestartServices(vServerModeles)
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
      var criterion="criterion_3306";
      var account800241GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800241GT", language+client);
      var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
      var DataFrequency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency_3306", language+client);
      var Montant=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant_3306", language+client);
      var ItemAccounts=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemAccounts", language+client);
      var ItemDate=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemDate", language+client);
      var ItemNextWithdrawalDate=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemNextWithdrawalDate", language+client);
      var CreatedCriteriaText=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CreatedCriteriaText", language+client);
      var ItemOperator=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ItemOperatorIsPriorOrEqualTo", language+client);
      var Date_3306=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Date_3306", language+client);
      
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3306","Cas de test TestLink : Croes-3306")  
      
      Login(vServerModeles, user , psw ,language);
      Get_ModulesBar_BtnAccounts().Click();      
      Get_MainWindow().Maximize();
      
      Search_Account(account800241GT);
      Get_AccountsBar_BtnInfo().Click();
      Get_WinAccountInfo_TabCashManagement().Click();
        
      /*dans compte -->sléctionner compte account800241GT--> double clickez
      onglet retrait systématique renseigner les champs */
      SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(), FrequencyMonthly);
      SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(), FrequencyMonthly);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, FrequencyMonthly);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, FrequencyMonthly);
        
        
      if(language=="french"){
        var format="%Y/%m/%d"
      }else{
        var format="%m/%d/%Y"
      }
        
      //Remplir champ date --> saisir date début 1 , date début 2
                
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(aqConvert.DateTimeToFormatStr(DataFrequency,format))
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Click();
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Keys(aqConvert.DateTimeToFormatStr(DataFrequency,format))
        
      //Saisir  montant 1= 100 , montant 2=200
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys(Montant);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, Montant); 
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys(Montant);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual, Montant);  
      Get_WinAccountInfo_BtnOK().Click();
      
      if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName","Title"], ["UniDialog",GetData(filePath_Accounts,"AccountInfo",2,language)])){
          Get_MenuBar_Search().OpenMenu();
          Get_MenuBar_Search_SearchCriteria().Click()
          Get_MenuBar_Search_SearchCriteria_Manage().Click();
          Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
      }
      else {
          Log.Error("La fenêtre Info n'était pas fermée.");
      }
      
      /*PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT = 1 
      Ajouter critere avancé ==> Recherche ==> Criteres de recherche == > Gérer ==> ajouter (avancé) 
      Condition = Classe du compte = Comptes ==> date du prochain retrait égale ou antérieur au 10.03.2010
      et valider que date de prochain retrait figure  dans la liste des parametres
      */
            
      Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Keys(criterion);
      Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField().Click();
      Get_SubMenus().Find("Header",ItemAccounts,10).Click();
      Get_CroesusApp().Find("Header",ItemDate,20).Click();
      Get_CroesusApp().Find("Header",ItemNextWithdrawalDate,10).Click();
      
      SelectComboBoxItem(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator(),ItemOperator);
      //Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_DtpValue().Click();
      Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_DtpValue().Keys(Date_3306)
      Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnAddACondition().Click();
      aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView().Find("Text",CreatedCriteriaText,10), "Exists", cmpEqual, true);
      Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView().Find("Text",CreatedCriteriaText,10).Click();      
      Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh().Click()
      
      //Compte 800241-GT a qui on a configuré les champs retrait systématique est affiché
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, criterion);  
	  
      //Log.Message("Erreur due au changement de la BD.Manel doit régler la BD")      
      //aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 1); //90-06-Be-26 : Modification dûe au changement de la BD
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Find("Value",account800241GT,10), "VisibleOnScreen", cmpEqual, true);
      
      //Vérifier tous les comptes présentes dans la grille s'ils répondent au critere de recherche --- //90-06-Be-26 : Modification dûe au changement de la BD
      var lines = Get_Grid_VisibleLines(Get_RelationshipsClientsAccountsGrid());
      for(n = 0; n < lines.length; n++)
      {
            var CompareDate = aqDateTime.Compare(aqConvert.DateTimeToFormatStr(lines[n].DataContext.DataItem.SystematicWithdrawalBeginDate1.OleValue,format), aqConvert.DateTimeToFormatStr(DataFrequency,format));
            if(CompareDate ==-1 || CompareDate ==0)
                Log.Checkpoint("Le compte "+lines[n].DataContext.DataItem.AccountNumber.OleValue+" répond au critere de recherche désigné." );
            else
                Log.Error("Le compte "+lines[n].DataContext.DataItem.AccountNumber.OleValue+" ne répond pas au critere de recherche désigné!" );            
      }    
      
      //fermer le filtre
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
      
      Close_Croesus_AltF4();
             
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
      //Remettre les données a l’état initial           
      Delete_FilterCriterion(criterion,vServerModeles)//Supprimer le filtre de BD  
    }   
 }
 
