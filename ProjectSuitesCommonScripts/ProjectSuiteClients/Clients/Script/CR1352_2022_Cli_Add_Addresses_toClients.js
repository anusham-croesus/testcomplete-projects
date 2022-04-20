//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

/* Description : Ajouter des adresses a des clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2022
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_2022_Cli_Add_Addresses_toClients()
{
    try {
        var street1="CR1352_2022_1"
        var street2="CR1352_2022_2"
        var street3="CR1352_2022_3"
        var cityProv="qc"
        var postalCode="postalCode"
        var country="canada"
        var clientNum="800205"
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "COPERN", "username");
        Activate_Inactivate_PrefBranch('0',"PREF_EDIT_ADDRESS","REP",vServerClients);
        RestartVserver(vServerClients);
        
        Login(vServerClients, user, psw, language);      
        Get_ModulesBar_BtnClients().Click();      
        Get_MainWindow().Maximize();
        
        Search_Client(clientNum);
        
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
      
        //Modifier une adresse
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit().Click();
      
        var typeBefore=Get_WinCRUAddress_CmbType().Text;
        var textStreet1Before= Get_WinCRUAddress_TxtStreet1().Text;
        var textStreet2Before=Get_WinCRUAddress_TxtStreet2().Text;
        var postalCodeBefore=Get_WinCRUAddress_TxtPostalCode().Text;
        var countryBefore=Get_WinCRUAddress_TxtCountry().Text;
        var mailingAddressBefore= Get_WinCRUAddress_ChkMailingAddress().IsChecked;
          
        Get_WinCRUAddress_CmbType().set_SelectedIndex(2);//Bureau
        Get_WinCRUAddress_TxtStreet1().Keys(street1);
        Get_WinCRUAddress_TxtStreet2().Keys(street2);
        Get_WinCRUAddress_TxtStreet3().Keys(street3);
        Get_WinCRUAddress_TxtCityProv().Keys(cityProv);
        Get_WinCRUAddress_TxtPostalCode().Keys(postalCode);
        Get_WinCRUAddress_TxtCountry().Keys(country);
        Get_WinCRUAddress_ChkMailingAddress().set_IsChecked(true);
        Get_WinCRUAddress_BtnOK().Click();
          
        Get_WinDetailedInfo_BtnApply().Click();
        //Get_WinDetailedInfo_BtnOK().Click();
        Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000); 
        Get_WinDetailedInfo_BtnOK().Keys("[Enter]");

          
        //Valider les modifications     
        Search_Client(clientNum);       
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
        
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType(),"Text", cmpEqual,GetData(filePath_Clients,"CR1352",199,language))
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(),"Text", cmpEqual,street1)
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(),"Text", cmpEqual,street2)
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet3(),"Text", cmpEqual,street3)
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv(),"Text", cmpEqual,cityProv)
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode(),"Text", cmpEqual,postalCode)
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(),"Text", cmpEqual,country)
        Get_WinDetailedInfo_BtnOK().Click();
          
        //Remettre l’adresse 
        Search_Client(clientNum);
        
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
        //modifier une adresse
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit().Click();
      
        Get_WinCRUAddress_CmbType().Keys(typeBefore);//Maison
        Get_WinCRUAddress_TxtStreet1().Keys(textStreet1Before);
        Get_WinCRUAddress_TxtStreet2().Keys(textStreet2Before);
        Get_WinCRUAddress_TxtStreet3().Keys(" ");
        Get_WinCRUAddress_TxtCityProv().Keys(" ");
        Get_WinCRUAddress_TxtPostalCode().Keys(postalCodeBefore);
        Get_WinCRUAddress_TxtCountry().Keys(countryBefore);
        Get_WinCRUAddress_ChkMailingAddress().set_IsChecked(mailingAddressBefore);          
        Get_WinCRUAddress_BtnOK().Click();
        
        Get_WinDetailedInfo_BtnApply().Click();
        // Get_WinDetailedInfo_BtnOK().Click();
        Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000); 
        Get_WinDetailedInfo_BtnOK().Keys("[Enter]");
        
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();   
    }  
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } 
    finally {
        Activate_Inactivate_PrefBranch('0',"PREF_EDIT_ADDRESS","Sysadm",vServerClients)
        RestartVserver(vServerClients);
        Terminate_CroesusProcess();
    }
}
 