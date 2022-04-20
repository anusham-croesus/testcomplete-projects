//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA



/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2902
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper */

 function CR1709_2902_Create_SearchCriteria_BasedOnWithdrawals()
 {     
    try{
      
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-2902","Cas de test TestLink : Croes-2902")
        
      Activate_Inactivate_Pref("GP1859","PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT ","1",vServerModeles)
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
      var criterion="criterion_2902";
      var account800241GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800241GT", language+client);
      var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
      var FrequencyQuarterly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyQuarterly", language+client);
      var DataFrequency1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency1_2902", language+client);
      var DataFrequency2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency2_2902", language+client);
      var Montant1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant1_2902", language+client);
      var Montant2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant2_2902", language+client);
          
      Login(vServerModeles, user , psw ,language);
      Get_ModulesBar_BtnAccounts().Click();      
      Get_MainWindow().Maximize();
      
      Search_Account(account800241GT);
      Get_AccountsBar_BtnInfo().Click();
      Get_WinAccountInfo_TabCashManagement().Click();
      Get_WinAccountInfo_TabCashManagement().WaitProperty("IsSelected", true, 3000); 
        
      /*dans compte -->sléctionner compte account800241GT--> double clickez
      onglet retrait systématique renseigner les champs */
      SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(), FrequencyMonthly);
      SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(), FrequencyQuarterly);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, FrequencyMonthly);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, FrequencyQuarterly);
        
        
      if(language=="french"){
        var format="%Y/%m/%d"
      }else{
        var format="%m/%d/%Y"
      }
        
      //Remplir champ date --> saisir date début 1 , date début 2
                
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(aqConvert.DateTimeToFormatStr(DataFrequency1,format))
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Click();
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Keys(aqConvert.DateTimeToFormatStr(DataFrequency2,format))
        
      //Saisir  montant 1= 100 , montant 2=200
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys(Montant1);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, Montant1); 
      Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys(Montant2);
      aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual, Montant2);  
      Get_WinAccountInfo_BtnOK().Click();
      
      //Ajouter un critere de recherche simple : liste des comptes(compte réel) ayant date du prochain retrait égale ou antérieur au 01.02.2010.
      Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
      Get_WinAddSearchCriterion().Parent.Maximize();
          
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_ItemNextWithdrawalDate().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemOnOrPriorTo().Click();
      Get_WinAddSearchCriterion_LvwDefinition_DateValue().Click();
      Get_WinAddSearchCriterion_LvwDefinition_DateValue().Keys(aqConvert.DateTimeToFormatStr(DataFrequency1,format));
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
      
      //Compte 800241-GT a qui on a configuré les champs retrait systématique est affiché
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, criterion);  
	  
      //Log.Message("Erreur due au changement de la BD.Manel doit régler la BD")      
      //aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 1); //EM: 90-06-Be-26 : Modification dûe au changement de la BD
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Find("Value",account800241GT,10), "VisibleOnScreen", cmpEqual, true);
      
      //Vérifier tous les comptes présentes dans la grille s'ils répondent au critere de recherche --- //EM: 90-06-Be-26 : Modification dûe au changement de la BD
      var lines = Get_Grid_VisibleLines(Get_RelationshipsClientsAccountsGrid());
      for(n = 0; n < lines.length; n++)
      {
            var CompareDate = aqDateTime.Compare(aqConvert.DateTimeToFormatStr(lines[n].DataContext.DataItem.SystematicWithdrawalBeginDate1.OleValue,format), aqConvert.DateTimeToFormatStr(DataFrequency1,format));
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
 
 function Test(){
      if(language=="french"){
        var format="%Y/%m/%d"
      }else{
        var format="%m/%d/%Y"
      }
    var DataFrequency1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency1_2902", language+client);
    var lines = Get_Grid_VisibleLines(Get_RelationshipsClientsAccountsGrid());
    var test=true;
    for(n = 0; n < lines.length; n++)
    {
        var CompareDate = aqDateTime.Compare(aqConvert.DateTimeToFormatStr(lines[n].DataContext.DataItem.SystematicWithdrawalBeginDate1.OleValue,format), aqConvert.DateTimeToFormatStr(DataFrequency1,format));
        Log.Message(CompareDate)
        if(CompareDate ==-1 || CompareDate ==0)
            Log.Checkpoint("Le compte "+lines[n].DataContext.DataItem.AccountNumber.OleValue+" répond au critere de recherche désigné." );
        else
            Log.Error("Le compte "+lines[n].DataContext.DataItem.AccountNumber.OleValue+" ne répond pas au critere de recherche désigné!" );
            
    }
 }

 