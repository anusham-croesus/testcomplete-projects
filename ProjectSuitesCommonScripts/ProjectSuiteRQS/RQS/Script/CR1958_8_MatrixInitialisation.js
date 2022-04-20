//USEUNIT CR1958_2_Helper



function CR1958_8_MatrixInitialisation()
{
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
              
        var productionPassword    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_Password", language + client);
        
        var lowInvestment_Risk    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_lowInvestment_Risk", language + client);
        var mediumInvestment_Risk = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_mediumInvestment_Risk", language + client);
        var highInvestment_Risk   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_highInvestment_Risk", language + client);

//        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SECURITY_RATING_PASSWORD", productionPassword, vServerRQS);
//        RestartServices(vServerRQS);
        
            
    try {

        //Se loguer avec KEYNEJ pour peupler la matrice
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        
        Log.Message("Peupler la matrice");
        
        var numTry = 0;
        do {
            Get_MenuBar_Tools().OpenMenu();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations_TvwTreeview_LlbRiskComplianceManager().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
            
        Get_WinConfigurations_LvwListView_LlbRiskRatingAllocation().DblClick();
        WaitObject(Get_CroesusApp(),"Uid", "Window_2efc");
        
        //Risk allocation levels for all Security risk ratings      
        var dataSeparatorChar = "|";
        var allSecurityRiskRatings = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_SecurityRiskRatings", language + client);
        var arrayOfSecuritiesRiskRatings  = (Trim(allSecurityRiskRatings) == "")? []: allSecurityRiskRatings.split(dataSeparatorChar);
        Log.Message("The risk ratings are: " + arrayOfSecuritiesRiskRatings);
        
        for (j in arrayOfSecuritiesRiskRatings){
            var riskRating = arrayOfSecuritiesRiskRatings[j];
            //Remplir les lignes
            SecurityRiskRatingsSetting(riskRating);
        }       
        
        //Risk Rating Profiles Mnemonic codes
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Keys(lowInvestment_Risk);
        
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Keys(mediumInvestment_Risk);
        
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
        Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Keys(highInvestment_Risk);
        
       
        //Save with password
        Get_WinRiskAllocationConfigurationTool_BtnSave().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["BaseWindow",1]);
        Get_DlgConfirmation_TxtRiskIndexPasswordBox().Keys(productionPassword);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 80);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "Window_2efc");
        
        Get_WinConfigurations().Close();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
        

        
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
                //Fermer Croesus
                Close_Croesus_X();
                SetAutoTimeOut();
                if (Get_DlgConfirmation().Exists)
                    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
                RestoreAutoTimeOut();
            }
}


function SecurityRiskRatingsSetting(riskRating){
  
    var dataSeparatorChar       = "|";
    var all_Low_RiskAllocationLevels    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "RISK_1822_RiskAllocationLevels_" + riskRating, language + client);
    var arrayOfAllRiskAllocationLevels  = (Trim(all_Low_RiskAllocationLevels) == "")? []: all_Low_RiskAllocationLevels.split(dataSeparatorChar);
    Log.Message( arrayOfAllRiskAllocationLevels);
    
        switch(riskRating){
        case "Low":
        {                 
            Log.Message("The security risk ratings: low");  
            var rating = 1;                
            break;
        }
        case "Low-Medium":
        {  
            Log.Message("The security risk ratings: low-Medium");  
            var rating = 2;               
            break;
        }
        case "Medium":
        {  
            Log.Message("The security risk ratings: Medium");  
            var rating = 3;                    
            break;
        }
        case "Medium-High":
        {  
            Log.Message("The security risk ratings: Medium-High");  
            var rating = 4;                  
            break;
        }                  
        case "High":
        {  
            Log.Message("The security risk ratings: High");  
            var rating = 5;                   
            break;
        }
        }
    
        for (j=0; j< arrayOfAllRiskAllocationLevels.length; j++){
            var value = arrayOfAllRiskAllocationLevels[j];
            Log.Message("The value: " + value +"---" +j);
            Get_WinRiskAllocationConfigurationTool().WPFObject("dgMatrix").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", rating).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", j+3).WPFObject("XamNumericEditor", "", 1).Click()
            Get_WinRiskAllocationConfigurationTool().WPFObject("dgMatrix").WPFObject("RecordListControl", "", 1).WPFObject("MainScrollViewer").WPFObject("DataRecordPresenter", "", rating).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", j+3).WPFObject("XamNumericEditor", "", 1).Keys(value + "[Tab]")
            Delay(500);
//            Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", j+3], 10).WPFObject("XamNumericEditor", "", 1).Click();
//            Get_WinRiskAllocationConfigurationTool().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", j+3], 10).WPFObject("XamNumericEditor", "", 1).Keys(value + "[Tab]");
//            Delay(500);
        }
}