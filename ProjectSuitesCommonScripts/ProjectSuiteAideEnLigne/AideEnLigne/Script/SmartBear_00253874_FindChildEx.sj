//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


function SmartBear_00253874_FindChildEx()
{
    for (i = 1; i <= 2; i++){
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses1().Click();
        
        Log.Message("*** FINDCHILD WITH DELAY ***");
        Delay(500);
        btnAdd = Get_WinDetailedInfo_TabAddresses_GrpAddresses1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10);
        if (btnAdd.Exists){
            Log.Checkpoint("'Add' button found.");
            Sys.HighlightObject(btnAdd, 50);
        }
        else
            Log.Error("'Add' button not found!");
        
        Get_WinDetailedInfo1().Close();
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses1().Click();
        
        Log.Message("*** FINDCHILD WITHOUT DELAY ***");
        btnAdd = Get_WinDetailedInfo_TabAddresses_GrpAddresses1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10);
        if (btnAdd.Exists){
            Log.Checkpoint("'Add' button found.");
            Sys.HighlightObject(btnAdd, 50);
        }
        else
            Log.Error("'Add' button not found!");
        
        Get_WinDetailedInfo1().Close();
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses1().Click();
        
        Log.Message("*** FINDCHILDEX WITH DELAY ***");
        Delay(500);
        btnAdd = Get_WinDetailedInfo_TabAddresses_GrpAddresses1().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10, true, 10000);
        if (btnAdd.Exists){
            Log.Checkpoint("'Add' button found.");
            Sys.HighlightObject(btnAdd, 50);
        }
        else
            Log.Error("'Add' button not found!");
        
        Get_WinDetailedInfo1().Close();
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabAddresses1().Click();
        
        Log.Message("*** FINDCHILDEX WITHOUT DELAY ***");
        btnAdd = Get_WinDetailedInfo_TabAddresses_GrpAddresses1().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10, true, 10000);
        if (btnAdd.Exists){
            Log.Checkpoint("'Add' button found.");
            Sys.HighlightObject(btnAdd, 50);
        }
        else
            Log.Error("'Add' button not found!");
  
        Get_WinDetailedInfo1().Close();
    }
}



function Test1()
{
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses1().Click();
    Delay(500);
    
    var grpAddress = Get_WinDetailedInfo_TabAddresses_GrpAddresses1();
    
    Delay(5000);
}


function Test2()
{
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses1().Click();
    
    //Delay(500);
    
    btnAdd = Get_WinDetailedInfo_TabAddresses_GrpAddresses1().WaitChild("WPFObject(\"UniButton\", \"A_dd\", 1)",10000);
    btnAdd.Click();
    
    //if (WaitObject(Get_WinDetailedInfo_TabAddresses_GrpAddresses1(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1]))
    //    Get_WinDetailedInfo_TabAddresses_GrpAddresses1().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10, true, 10000).Click();
    
    //var grpAddress = Get_WinDetailedInfo_TabAddresses_GrpAddresses1();
    
    //Delay(5000);
}



function Get_WinDetailedInfo1(){return Aliases.CroesusApp.winDetailedInfo}

function Get_WinDetailedInfo_TabAddresses1(){return Get_WinDetailedInfo1().FindChildEx(["ClrClassName", "WPFControlText"], ["TabItem", "Addresses"], 10, true, 10000)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses1(){return Get_WinDetailedInfo1().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", 1], 10, true, 10000)}