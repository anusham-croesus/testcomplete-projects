//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2661
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_2661_Check_BD_of_TabCashManagement(){
  
  try{  
        Activate_Inactivate_Pref("GP1859", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)
        RestartServices(vServerModeles);
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        var Account800035HU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800035HU", language+client);
        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var FrequencyQuarterly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyQuarterly", language+client);
        var FrequencyBiannually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyBiannually", language+client);
        var FrequencyAnnually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyAnnually", language+client);
        var FrequencyCount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyCount_2660", language+client);
        var AccountTotalValuePercentage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "AccountTotalValuePercentage", language+client);
        var GrpFees=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GrpFees", language+client);
        var LblAccountTotalValuePercentage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "LblAccountTotalValuePercentage", language+client);
            
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(Account800035HU);
        
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        
        /*Choisir fréquence1 : Mensuelle et valider que :Le second champ fréquence2  --> séléctionner annuel*/
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(), FrequencyMonthly);
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(), FrequencyAnnually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, FrequencyMonthly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, FrequencyAnnually);
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear1(),"IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear2(),"IsEnabled", cmpEqual, true);
        
        if(language=="french"){
          var today="%Y/%m/%d"
        }else{
          var today="%m/%d/%Y"
        }
        
        //Remplir champ date --> saisir date début 1 , date début 2
        var date1= aqConvert.DateTimeToFormatStr(aqDateTime.AddMonths(aqDateTime.Now(), 2),today)
        var date2= aqConvert.DateTimeToFormatStr(aqDateTime.AddMonths(aqDateTime.Now(), 4),today)
                
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(date1)
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Keys(date2)
        
        //Saisir  montant 1= 100 , montant 2=200
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys("100");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, "100"); 
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys("200");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual, "200");           
        Get_WinAccountInfo_BtnOK().Click();
        
        //Validation
        Search_Account(Account800035HU);
        
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, FrequencyMonthly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, FrequencyAnnually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, "100"); 
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual, "200"); 
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1(),"StringValue", cmpEqual, date1); 
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2(),"StringValue", cmpEqual, date2);
        Get_WinAccountInfo_BtnOK().Click();               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus  
	    Runner.Stop(true);           
    }
}