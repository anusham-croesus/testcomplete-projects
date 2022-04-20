//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2660
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_2660_Check_Controls_of_TabCashManagement(){
  
  try{  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var Account800049RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049RE", language+client);
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
        
        Search_Account(Account800049RE);
        
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        
        //Valider le champ Fréquence1 :les valeurs possibles sont : Mensuelle;Trimestriell;Semestrielle;Annuelle
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1().Items,"Count", cmpEqual, FrequencyCount);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1().Items.Item(0),"Value", cmpEqual, FrequencyMonthly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1().Items.Item(1),"Value", cmpEqual, FrequencyQuarterly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1().Items.Item(2),"Value", cmpEqual, FrequencyBiannually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1().Items.Item(3),"Value", cmpEqual, FrequencyAnnually);
        
        //Valider le champ Fréquence2 :les valeurs possibles sont : Mensuelle;Trimestriell;Semestrielle;Annuelle
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2().Items,"Count", cmpEqual, FrequencyCount);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2().Items.Item(0),"Value", cmpEqual, FrequencyMonthly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2().Items.Item(1),"Value", cmpEqual, FrequencyQuarterly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2().Items.Item(2),"Value", cmpEqual, FrequencyBiannually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2().Items.Item(3),"Value", cmpEqual, FrequencyAnnually);
        
        
        //Séléctionner un fréquence  et valider qu'on ne peux pas choisir vide
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(), FrequencyMonthly);
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1().Click();
        aqObject.CheckProperty(Get_SubMenus(),"ChildCount", cmpEqual, FrequencyCount);
        
        
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(), FrequencyMonthly);
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2().Click();//set_IsDropDownOpen(true);
        aqObject.CheckProperty(Get_SubMenus(),"ChildCount", cmpEqual, FrequencyCount);
        
        /*Valider le champ Montant : la Valeur doit etre  alignée à droite  */
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"HorizontalContentAlignment", cmpEqual, "Right");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"HorizontalContentAlignment", cmpEqual, "Right");
        /*;L'entête doit afficher la devise du compte;*/               
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_LblAmountCAD(),"Text", cmpContains, Get_WinAccountInfo_GrpAccount_TxtCurrency().Text);
        //Valider que le champ Permet seulement  les valeurs positives seulement
        var positiveNumber=50;
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys(positiveNumber);
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys(positiveNumber);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, positiveNumber);           
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual,positiveNumber);
        
        var negativeNumber=-50
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Clear();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys(negativeNumber);
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys("[Enter]");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Text", cmpEqual, undefined); 
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Clear(); 
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys(negativeNumber);
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys("[Enter]");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Text", cmpEqual,undefined);
        
        /*Valider le champ Déscription = date de début
        Date minimum = today
        Date maximum = today + 1 an*/
                   
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1(),"CalendarMinDate", cmpEqual, aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%#d/%Y"));
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1(),"get_CalendarMaxDate", cmpEqual, aqDateTime.AddMonths(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%d/%Y"), 12));
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear1(),"IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear2(),"IsEnabled", cmpEqual, true);
                     
        //*************************************************Couverture du cas Croes-3203*********************************************************
        
        /*Valider que Le champ de saisie Frais Permet :
        1- Uniquement Des valeurs entre 0 et 100 : Saisir  110 
        2- Jusqu'a  3 décimales
        3- Uniquement  valeurs positives : saisir -50 */
        
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Keys(negativeNumber);
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Keys("[Enter]");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage(),"Text", cmpEqual,AccountTotalValuePercentage);
        
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Keys("101");
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Keys("[Enter]");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage(),"Text", cmpEqual,AccountTotalValuePercentage);
        
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Keys("1");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage(),"Value", cmpEqual, "1");  
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Clear();
        
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Keys("100");
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage(),"Value", cmpEqual, "100");  
        Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().Clear();
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage(),"NumberOfDecimals", cmpEqual, "3");
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees(),"Header", cmpEqual, GrpFees);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpFees_LblAccountTotalValuePercentage(),"Text", cmpEqual, LblAccountTotalValuePercentage);
                      
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

