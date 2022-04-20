//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2662
Analyste d'automatisation: Youlia Raisper */



function CR1709_2662_Check_New_Columns(){
  
  try{  
        Activate_Inactivate_Pref("GP1859", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");

        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var ColumnWithdrawalFrequency1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalFrequency1", language+client);
        var ColumnWithdrawalFrequency2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalFrequency2", language+client);
        var ColumnWithdrawalAmount1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalAmount1", language+client);
        var ColumnWithdrawalAmount2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrawalAmount2", language+client);
        var ColumnWithdrFreqStartDate1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrFreqStartDate1", language+client);
        var ColumnWithdrFreqStartDate2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnWithdrFreqStartDate2", language+client);
                   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
         //Vérification des entêtes de colonnes par défaut     
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
       
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalFrequency1(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalFrequency2(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalAmount1(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalAmount2(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrFreqStartDate1(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrFreqStartDate2(),"Exists", cmpEqual,false);
        
        
        //Ajouter des colonnes 
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        AddColumn(ColumnWithdrawalFrequency1);
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        AddColumn(ColumnWithdrawalFrequency2);
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        AddColumn(ColumnWithdrawalAmount1);
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        AddColumn(ColumnWithdrawalAmount2);
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        AddColumn(ColumnWithdrFreqStartDate1);
        
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        AddColumn(ColumnWithdrFreqStartDate2);
        
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalFrequency1(),"VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalFrequency2(),"VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalAmount1(),"VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalAmount2(),"VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrFreqStartDate1(),"VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrFreqStartDate2(),"VisibleOnScreen", cmpEqual,true);
        
         //Vérification des entêtes de colonnes par défaut     
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
       
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalFrequency1(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalFrequency2(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalAmount1(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrawalAmount2(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrFreqStartDate1(),"Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_AccountsGrid_ChWithdrFreqStartDate2(),"Exists", cmpEqual,false);
                              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
	    Runner.Stop(true);             
    }
}


function FindColumnIn(columName){

  var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
  Log.Message("Number of items in a menu " + count)
  var found=false;
  for(i=0;i<count-1;i++){
      if(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).DataContext.Label==columName){      
        found=true;
      } 
  }
  return found; 
} 

function AddColumn(columName){
  var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
  Log.Message("Number of items in a menu " + count)
  var found=false;
  for(i=0;i<count-1;i++){
    Log.Message(i);
    Log.Message(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).DataContext.Label);
      if(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).DataContext.Label==columName){      
        Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).Click();
        break;
      } 
  }
} 