//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2659
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_2659_Check_PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT_2(){
  
  try{  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "2", vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
              
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        Get_AccountsBar_BtnInfo().CLick();
        Get_WinAccountInfo_TabCashManagement().Click();
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1(),"IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2(),"IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear1(),"IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear2(),"IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage(),"IsReadOnly", cmpEqual, true);
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