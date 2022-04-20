//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_BrancheAndAllSelection(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_BrancheAndAllSelection";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        
        var brancheName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, userNamePerformance +"_BrancheName", language+client);
        var optionAll = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "OptionAll", language+client);
        var waitTime = 3000;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue+ "_All");
        if (userNamePerformance == "REEDB"){
         var usersname= "Barbara Reed"
        }
        if (userNamePerformance == "BLEAU"){
         var usersname= "Poppy Bleau"
        } 
        
        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
          
          if (userNamePerformance != "GENECIRA"){
              Get_MenuBar_Users().OpenMenu();
              Get_MenuBar_Users_Branches(). Click();
              }
           Log.Message("Branche : "+brancheName); 
           
          // wait for loading grids 
          // wait for loading grids 
          do {Delay(waitTime);      
          } while (!Get_CroesusApp().FindChild("ClrClassName","UpperCashBalanceSummaryBoard",10).FindChild(["ClrClassName", "WPFControlName"],["VirtualizingDataRecordCellPanel","ContentItemGrid"],10).Exists)
          
          
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005",waitTime);
          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
          
          SetAutoTimeOut();
          do {
           Get_Toolbar_BtnRQS().Click();      
          } while (!Get_WinRQS().Exists)
          RestoreAutoTimeOut();
             
          // Attendre l'onglet 'Transaction' présent et actif
          WaitObject(Get_WinRQS(), "Uid", "TabItem_c461",waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)                    
          Get_WinRQS_TabTransactionBlotter().Click();
          
          WaitObject(Get_WinRQS(), "Uid", "Button_9072",waitTime);
          Get_WinRQS_BtnTreeView().Click();
          WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
          if(Get_SubMenus().Exists){
                Get_SubMenus().Find("Value",brancheName,10).Click();
          }
          
          // Mesurer la performance        
          StopWatchObj.Start();
          WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);   //Attendre la grille des Transactions
          //Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
          var timeSpotted=StopWatchObj.Split()/1000 
          StopWatchObj.Stop();
        
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue +"_Branche");
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted); */ 
          
          var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue+"_Branche");
          WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);

          Get_WinRQS_BtnTreeView().Click();
          WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
          if(Get_SubMenus().Exists){
              Get_SubMenus().Find("WPFControlText",optionAll,10).Click();
          }
          
          // Mesurer la performance        
          StopWatchObj.Start();
          WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTimeShort);   //Attendre la grille des Transactions
          //Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
          var timeSpotted=StopWatchObj.Split()/1000
          StopWatchObj.Stop();
        
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue + "_All");
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
                    
          var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue+ "_All");
          WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
          
          //fermer la fenêtre 
          Get_WinRQS().Close();
          
          Get_MenuBar_Users().OpenMenu();            
          Get_MenuBar_Users_user(usersname).OpenMenu()                        
          Get_MenuBar_Users_All().Click();
          Delay(60000);
          
          
        }        
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {        
          //Fermer Croesus
          TerminateProcess("CroesusClient"); 

        }
}

function Get_MenuBar_Users_Branches()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Succursales"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Branches"], 10)}
}


function Get_MenuBar_Users_REEDB()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Barbara Reed"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Barbara Reed"], 10)}
}

function Get_MenuBar_Users_user(username)
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", username], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", username], 10)}
}

function Get_MenuBar_Users_All()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Tous"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "All"], 10)}
}

