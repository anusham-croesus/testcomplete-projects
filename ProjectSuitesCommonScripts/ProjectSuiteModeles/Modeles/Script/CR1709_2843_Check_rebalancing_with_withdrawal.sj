//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3157_Option3_Error_Message_Cas9

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2843
 
Analyste d'automatisation: Youlia Raisper */



function CR1709_2843_Check_rebalancing_with_withdrawal(){
  
  try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var Account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client);
        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var FrequencyQuarterly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyQuarterly", language+client);
        var DataFrequency1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency1", language+client);
        var DataFrequency2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency2", language+client);
        var modelModelMoyenTerme=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);   
        
        var DepositWithdrawalAmount100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount100", language+client);
        var DepositWithdrawalAmount500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount500", language+client);
        var DepositWithdrawalAmount1500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount1500", language+client);
        var DepositWithdrawalAmount2000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount2000", language+client);
        
        var MessageWithdrawalAmount100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount100", language+client);
        var MessageWithdrawalAmount500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount500", language+client);
        var MessageWithdrawalAmount1500=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount1500", language+client);        
        var MessageWithdrawalAmount2000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MessageWithdrawalAmount2000", language+client);
         
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(Account800049NA);
        
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        
        /*onglet retrait systématique renseigner le champ frequence :mensuel
          montant =100, date début = 02/02/2009
          -frequence 2 : Trimestrielle
          -montant =200, date début = 05/03/2009*/
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
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys("100");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, "100"); 
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys("200");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual, "200");           
        Get_WinAccountInfo_BtnOK().Click();
        
        Get_ModulesBar_BtnModels().Click();
        //assigné le compte 800049NA au modèle 
        AssociateAccountWithModel(modelModelMoyenTerme,Account800049NA)
                                                                 
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
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,null)
        
        Get_WinRebalance_BtnPrevious().Click(); 
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 1 dans le champ retrait systématique = 1 mois --> cliquez sur next et valider que la colonneGest.encaisse= -100
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("1")
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount100)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -100 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800049-NA 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount100)       
        
        
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 3 dans le champ retrait systématique = 3 mois --> cliquez sur next et valider que la colonneGest.encaisse= -500
        Get_WinRebalance_BtnPrevious().Click();
       /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Get_WinRebalance_BtnPrevious().Click();
        Get_WinRebalance_BtnPrevious().Click();
        
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("3")
        //Avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount500)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -500 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800049-NA 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount500)       
        
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 9 dans le champ retrait systématique = 9 mois --> cliquez sur next et valider que la colonneGest.encaisse= -1500
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
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount1500)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -1500 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800049-NA 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount1500)       
        
        //Cliquez sur precedent pour retourner a A etape 1 --> Insérer 12 dans le champ retrait systématique = 12 mois --> cliquez sur next et valider que la colonneGest.encaisse= -2000
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
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount2000)       
        //allez etape 4 du rééquilibrage et valider :Onglet ordre proposé : le message " le compte fait état d'un retrait de -2000 $ est affiché 
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Scroll();
        //800049-NA 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800049NA,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,MessageWithdrawalAmount2000)       
        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73); 
    
        //*************************************************Réinitialiser les données*********************************************************
        /*Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelModelMoyenTerme);
        RemoveAccountFromModel(Account800049NA,modelModelMoyenTerme);*/ 
             
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));         
    }
    finally { 
        Login(vServerModeles, user, psw, language);              
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        SearchModelByName(modelModelMoyenTerme);
        RemoveAccountFromModel(Account800049NA,modelModelMoyenTerme);
        Terminate_CroesusProcess(); //Fermer Croesus  
        Runner.Stop(true);           
    }
}



function Scroll()
{
    var dgvComponent = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator();
    dgvComponent.Click(dgvComponent.Width - 70, dgvComponent.Height - 10);
}
function test(){
  Sys.HighlightObject(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator());
}