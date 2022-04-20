//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2865
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_2865_Check_Amount_Field_Obligatory(){
  
  try{  
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-2865","Cas de test TestLink : Croes-2865")
        
        Activate_Inactivate_Pref("GP1859", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        var Account800035HU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800035HU", language+client);
        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var FrequencyAnnually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyAnnually", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_2865", language+client);
            
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
        
        Log.Message(date1)
        Log.Message(date2)
        
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(date1);
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Keys(date2);
        
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Clear();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Clear();
        Get_WinAccountInfo_BtnOK().Click();
        
        //Validation du message
       /*aqObject.CheckProperty(Get_DlgCroesus_LblMessage(),"Text", cmpEqual, message);
        Get_DlgCroesus().Close();*/ //EM : Modifié depuis CO: 90-07-22
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(),"Message", cmpEqual, message);
        Get_DlgWarning().Close(); //EM : A partir de 90.10.Fm-18 : Avant c'était DlgError
        if(!Get_WinAccountInfo().Exists) //EM : Depuis 90.10.Fm-2
            Log.Error("Jira CROES-11668 : lorsqu'on clique sur OK pour fermer la fenêtre du message d’avertissement, la fenêtre Info Compte devrait rester ouverte pour entrer les données supplémentaires requises");                
                          
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