//USEUNIT Common_functions
//USEUNIT Common_Get_functions


function SelectOneReport(reportName, userName){
  
        Get_WinReportConfiguration_UniList().Click();          
        //Hit first character
        var reportNameFirstChar = aqString.ToLower(aqString.GetChar(reportName, 0));
        Get_WinReportConfiguration_UniList().Keys(reportNameFirstChar);
        
        var reportsCount = Get_WinReportConfiguration_UniList().Items.get_Count();
        //Get row Index
        var selectedRow = Get_WinReportConfiguration_UniList().FindChild(["ClrClassName", "IsSelected"], ["ListBoxItem", true]);
        if (selectedRow.Exists)
            var selectedRowIndex = selectedRow.WPFControlOrdinalNo;

        for (var i = selectedRowIndex; i <= reportsCount; i++){             
            var currentReportName = VarToStr(Get_WinReportConfiguration_UniList().WPFObject("ListBoxItem", "", i).WPFControlText);
                  
            if (currentReportName == reportName){
                  Get_WinReportConfiguration_UniList().WPFObject("ListBoxItem", "", i).Set_IsSelected(true);
                  if (userName == "KEYNEJ"){
                        aqObject.CheckProperty(Get_WinReportConfiguration_BtnEdit(), "Enabled", cmpEqual,false);
                        Get_WinReportConfiguration_BtnCopyTo().Click();
                  }
                  else
                        Get_WinReportConfiguration_BtnEdit().Click();
                  Log.Message("Report '" + currentReportName + "' selected.");
                  return true;
                }
            else  
                Get_WinReportConfiguration_UniList().WPFObject("ListBoxItem", "", i).Keys("[Down]");             
          }
          if(i == reportsCount+1) Log.Error("Le rapport '" + reportName + "' n'éxiste pas dans la liste des rapports");
}

//function Get_WinReportConfigurationCopy_TabDisclaimers_TextBoxReportNotes(){
//      return Get_WinReportConfigurationCopy().FindChild(["Uid",  "WPFControlOrdinalNo"], ["TextBox_990e", 1], 10)}