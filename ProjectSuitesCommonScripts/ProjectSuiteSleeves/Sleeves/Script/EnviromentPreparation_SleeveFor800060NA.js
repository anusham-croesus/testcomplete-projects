//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel


 /* Description : POur le CR1452 Fichier Excel 'Cas de test du CR1452 à automatiser' 2.4.

Analyste d'automatisation: Youlia Raisper */ 

 function EnviromentPreparation_SleeveFor800060NA()
{  
      try{    
       
          var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800060NA", language+client);
          var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);
          var modelTestRestriction=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelTestRestriction", language+client);          
          var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
          var sleeveDescription=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client); 
          var targetCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetCanadianEqui", language+client);
          var unallocated = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
          var adhocSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinEditSleeveTxtSleeveDescription_For800060NA", language+client);
          var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc", language+client);
          var balance =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client); 
          var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
          var security = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNA", language+client);
          var percentageOfTotalValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageOfTotalValue", language+client);
          
          Login(vServerSleeves, user ,psw,language);
          Get_ModulesBar_BtnAccounts().Click(); 
          Search_Account(account);  
          
          //mettre une restriction non bloquante (ex: Na = 50)
          Get_RelationshipsAccountsBar_BtnRestrictions().Click();
          var count = Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items.Count                   
          Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
          Get_WinCRURestriction_GrpSecurity_CmbQuickSearchTypePicker().Click();
          Get_SubMenus().Find("Text",typePicker,10).Click();
          Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(security);
          Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click()
          Get_SubMenus().Find("Value",security,10).DblClick();
          Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMinimum().Keys(percentageOfTotalValue);
          Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMaximum().Keys(percentageOfTotalValue);
          Get_WinCRURestriction_BtnOK().Click();
          aqObject.CheckProperty(Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items, "Count",cmpEqual,count+1);
          Get_WinRestrictionsManager_BtnClose().Click();
          
          DragAccountToPortfolio(account);     
          CreateSleeveByAssetClass();
    
          //Cliquer sur le bouton segment
          Get_PortfolioBar_BtnSleeves().Click();           
          Get_WinManagerSleeves().Parent.Maximize();                
        
           //Modifier le segment 
          SelectSleeveWinSleevesManager(sleeveDescription)
          Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
          AddEditSleeveWinSleevesManager("","",targetCanadianEqui,"","",modelCanadianEqui)            
          CheckThatModelBindedToSleeve( sleeveDescription,modelCanadianEqui)
          
          /* Créer un nouvel segment Adhoc, mettre une cible 10% et lui assigner le modèle 'Test Restriction Na' (le modèle détient une position Na = 50%)
           et  lui transférer tout le solde */ 
          Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
          AddEditSleeveWinSleevesManager(adhocSleeveDescription,"",targetAdhoc,"","",modelTestRestriction)
          CheckThatModelBindedToSleeve(adhocSleeveDescription,modelTestRestriction)
                
          //transférer tout le solde
          Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();   
          //Selectioner la solde
          Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",balance,10);                
          Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();  
          Get_WinMoveSecurities_CmbToSleeve().Keys(adhocSleeveDescription);
          Get_WinMoveSecurities().Click();
          Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
          Get_WinMoveSecurities_BtnOk().Click();
         
          Get_WinManagerSleeves_BtnSave().Click();
          
          //Fermer l'application
          Close_Croesus_AltQ();
          if(Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          } 
      }
      catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
      }
      finally {
          Terminate_CroesusProcess(); //Fermer Croesus
      }
}