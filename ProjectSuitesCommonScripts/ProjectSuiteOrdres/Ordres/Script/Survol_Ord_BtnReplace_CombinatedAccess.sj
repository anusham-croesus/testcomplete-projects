//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions


/**
    Description : 
        Aller au module "Orders" Rechercher un ordre ayant le statut:
            1- Cancelled 
            2- Executed
            3- Expired
            4- Modified
            5- Open
            6- Partial Fill
            7- Rejected
            8- Trader Approval

        et cliquer sur le bouton "Replace" de la barre des Ordres.
        Vérifier que la boîte de dialogue Croesus ne s'affiche pas.
    @author : christophe.paring@croesus.com
    
    Regroupé par : A.A Version ref90-19-2020-09-6
*/

function Survol_Ord_BtnReplace_CombinatedAccess(){
    
        var waitTime = 3000;
        if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" ){
            
            try{
                Login(vServerOrders, userNameOrders, pswOrders, language);
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262", true, waitTime);
        
                //Status Cancelled 
                Log.Message("Ordre status = Cancelled");    
                Get_OrderGrid().Click();
                Search_Order_Symbol("FID224");
//                Get_OrderGrid().Find("Value", "FID224", 1000).Click();  
                Log.Message("JIRA: GDO-2262");
                Get_OrdersBar_BtnReplace().Click(); 
                Check_NonExistence_DlgMessage();
        
                //Status Executed
                Log.Message("Ordre status = Executed");
                Get_OrderGrid().Click();
                Search_Order_Symbol("Q01560");      
                Get_OrderGrid().Find("Value","Q01560",1000).Click();  
                Get_OrdersBar_BtnReplace().Click();
                Check_Existence_DlgMessage();
        
                //Status Expired
                Log.Message("Ordre status = Expired");
                Get_OrderGrid().Click();
                Search_Order_Symbol("FID227");
                Get_OrderGrid().Find("Value", "FID227", 1000).Click();  
        	      Log.Message("JIRA: GDO-2262");
                Get_OrdersBar_BtnReplace().Click();
                Check_NonExistence_DlgMessage();

                //Status Modified  
                Log.Message("Ordre status = Modified");      
                Get_OrderGrid().Click();
                Search_Order_Symbol("LLL");      
                Get_OrderGrid().Find("Value","LLL",1000).Click();  
        	      Log.Message("JIRA: GDO-2262");
                Get_OrdersBar_BtnReplace().Click(); 
                Check_Existence_DlgMessage();
        
                //Status Open
                Log.Message("Ordre status = Open");
                Get_OrderGrid().Click();
                Search_Order_Symbol("RY");   
                Get_OrderGrid().Find("Value","RY",1000).Click();       
                Get_OrdersBar_BtnReplace().Click();
                Check_Existence_DlgMessage();

                //Status Partial Fill
                Log.Message("Ordre status = Partial Fill");
                Get_OrderGrid().Click();
                Search_Order_Symbol("B03774");        
                Get_OrderGrid().Find("Value","B03774",1000).Click();    
                Get_OrdersBar_BtnReplace().Click();  
                Check_Existence_DlgMessage();        

                //Status Rejected
                Log.Message("Ordre status = Rejected");
                Get_OrderGrid().Click();
                Search_Order_Symbol("M84833");
                Get_OrderGrid().Find("Value", "M84833", 1000).Click();   
                Get_OrdersBar_BtnReplace().Click(); 
                Check_NonExistence_DlgMessage();

                //Status Trader Approval
                Log.Message("Ordre status = Trader Approval");
                Get_OrderGrid().Click();
                Search_Order_Symbol("MSFT");        
                Get_OrderGrid().Find("Value","MSFT",1000).Click();  
                Get_OrdersBar_BtnReplace().Click();
                Check_Existence_DlgMessage();
                
                //Fermer Croesus
                Get_MainWindow().SetFocus();
                Close_Croesus_MenuBar();
                SetAutoTimeOut();
                if (Get_DlgConfirmation().Exists)
                    Get_DlgConfirmation_BtnYes().Click();
            }
  
            catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));     
            }
            finally {     
                Terminate_CroesusProcess();
            }
    }
}


function Check_Existence_DlgMessage(){
    
        Delay(200);

        if (Get_DlgInformation().Exists) {
            Log.Checkpoint("Croesus dialogbox has appeared.");
            aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Orders, "Order_replace", 2, language));
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Orders, "Order_replace", 3, language));
            var width=Get_DlgInformation().get_ActualWidth()
            var height=Get_DlgInformation().get_ActualHeight()
            Get_DlgInformation().Click(width/2,height-47);
        } else {
            Log.Error("Croesus dialogbox didn't appear.");
        }
}

function Check_NonExistence_DlgMessage(){
    
        Delay(200);

        if (Get_DlgInformation().Exists) {
            Log.Error("Croesus dialogbox has appeared ; this is not normal. According to the status of the order, the replacement operation should succeed.");
            var width=Get_DlgInformation().get_ActualWidth()
            var height=Get_DlgInformation().get_ActualHeight()
            Get_DlgInformation().Click(width/2,height-40);
        } else {
            Log.Checkpoint("Croesus dialogbox didn't appear.");
        }
}