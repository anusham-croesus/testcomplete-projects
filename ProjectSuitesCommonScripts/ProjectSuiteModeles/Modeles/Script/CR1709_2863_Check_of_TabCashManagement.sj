//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2863
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2867
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_2863_Check_of_TabCashManagement(){
  
  try{  
        Activate_Inactivate_Pref("GP1859", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        var Account800035JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800035JW", language+client);
        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var FrequencyAnnually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyAnnually", language+client);
        var FrequencyCount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyCount_2660", language+client);
        var Amount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Amount_2863", language+client);
            
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(Account800035JW);
        
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
        
        Log.Message(date1)
        Log.Message(date2)
        
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(date1)
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Keys(date2)
        
        //couverture du cas 2867
        //https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2867
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Clear();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys("ABC");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Text", cmpEqual,undefined);
        
        //Saisir  montant 1= 100 , montant 2=200
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys("100");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, "100"); 
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys("200");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual, "200"); 
                    
        Get_WinAccountInfo_BtnCancel().Click();
        
        //Validation
        Search_Account(Account800035JW);       
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click(); 
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, undefined);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, undefined);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Text", cmpEqual, Amount); 
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"TExt", cmpEqual, Amount); 
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1(),"Value", cmpEqual,null); 
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2(),"Value", cmpEqual,null);
        Get_WinAccountInfo_BtnCancel().Click();               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
	    Runner.Stop(true);             
    }
}

