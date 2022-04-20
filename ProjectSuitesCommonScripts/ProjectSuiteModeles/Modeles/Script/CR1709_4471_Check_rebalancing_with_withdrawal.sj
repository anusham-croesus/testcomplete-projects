//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3157_Option3_Error_Message_Cas9

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4471
 
Analyste d'automatisation: Youlia Raisper */



function CR1709_4471_Check_rebalancing_with_withdrawal(){
  
  try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var Account800053FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800053FS", language+client);
        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var FrequencyQuarterly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyQuarterly", language+client);
        var Montant1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant1", language+client);
        var Montant2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant2", language+client);
        var FrequencyBiannually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyBiannually", language+client);
        var FrequencyAnnually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyAnnually", language+client);
        var DataFrequency1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency1_4471", language+client);
        var DataFrequency2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency2_4471", language+client); 
        var modelLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client); 
         
        var DepositWithdrawalAmount100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount100", language+client);
        var DepositWithdrawalAmount500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount500", language+client);
        var DepositWithdrawalAmount1500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount1500", language+client);
        var DepositWithdrawalAmount2000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount2000", language+client);
        var DepositWithdrawalAmount2200=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount2200", language+client);
        var MessageWithdrawalAmount100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount100", language+client);
        var MessageWithdrawalAmount500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount500", language+client);
        var MessageWithdrawalAmount1500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount1500", language+client);        
        var MessageWithdrawalAmount2000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount2000", language+client);
        var MessageWithdrawalAmount2200=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount2200", language+client);
        
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(Account800053FS);
        
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        
        /*dans compte -->sléctionner compte 800053-FS--> double clickez
        onglet retrait systématique renseigner le champ frequence : Semestrielle
        montant =100, date début = 01/04/2009
        -frequence 2 : Annuelle
        -montant =2000, date début = 01/10/2009*/
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(), FrequencyBiannually);
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(), FrequencyAnnually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, FrequencyBiannually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, FrequencyAnnually);
        
        
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
        
        Get_ModulesBar_BtnModels().Click();
        //assigné le compte 800053FS au modèle 
        AssociateAccountWithModel(modelLongTerm,Account800053FS)
                                                                 
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();  
                    
        //A etape 1 --> vérifier que le champ retrait systématique = 0 mois --> cliquez sur next et valider que la colonne Gest.encaisse= n/d
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_TxtSystematicWithdrawals(),"Value", cmpEqual, "0");         
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
        
        Get_WinRebalance_BtnPrevious().Click(); 
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 2 dans le champ retrait systématique = 2 mois -->cliquez sur next et valider que la colonneGest.encaisse= N/D
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("2")
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
           
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 3 dans le champ retrait systématique = 3 mois --> cliquez sur next et valider que la colonneGest.encaisse= -100
        Get_WinRebalance_BtnPrevious().Click();       
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("3")
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount100)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -100 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800053-FS
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount100)       
        
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 7 dans le champ retrait systématique = 7 mois --> cliquez sur next et valider que la colonneGest.encaisse= -100
        Get_WinRebalance_BtnPrevious().Click();
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        Get_WinRebalance_BtnPrevious().Click();
        Get_WinRebalance_BtnPrevious().Click();
        
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("7")
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount100)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -100 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800053-FS
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount100)       
        
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 9 dans le champ retrait systématique = 9 mois --> cliquez sur next et valider que la colonneGest.encaisse= -2200
        Get_WinRebalance_BtnPrevious().Click();
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Get_WinRebalance_BtnPrevious().Click();
        Get_WinRebalance_BtnPrevious().Click();
        
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("9")
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount2200)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -2200 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800053-FS
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount2200)       
        
        
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 12 dans le champ retrait systématique = 12 mois --> cliquez sur next et valider que la colonneGest.encaisse= -2200 
        Get_WinRebalance_BtnPrevious().Click();
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Get_WinRebalance_BtnPrevious().Click();
        Get_WinRebalance_BtnPrevious().Click();
        
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("12")
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount2200)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -2200 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800053-FS
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800053FS,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount2200)
        
        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73); 
    
        //*************************************************Réinitialiser les données*********************************************************
        /*Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelLongTerm);
        RemoveAccountFromModel(Account800053FS,modelLongTerm);*/ 
             
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
        Login(vServerModeles, user, psw, language); 
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        SearchModelByName(modelLongTerm);
        RemoveAccountFromModel(Account800053FS,modelLongTerm); 
        Terminate_CroesusProcess(); //Fermer Croesus  
        Runner.Stop(true);           
    }
}
