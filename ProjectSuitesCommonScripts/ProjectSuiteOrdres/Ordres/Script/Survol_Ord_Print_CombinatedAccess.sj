//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Ordes » , afficher la fenêtre « Print » en cliquant sur MenuBar - btnPrint 
                En cliquant sur le btnCancel, Vérifier le message «Impression annulée» 

  Regroupé par : A.A Version ref90-19-2020-09-6 
*/

function Survol_Ord_Print_CombinatedAccess(){
    
    var winTitle = GetData(filePath_Common, "Print", 2, language);
    var waitTime = 3000;
    
    try{ 
        
        Login(vServerOrders, userName , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
        WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true, waitTime);
  
        Log.Message("Croesus crash lors de l'impression lorsqu'on n'a plus d'ordres ==> Un Jira a rentrer par Karima.");
        
        //Ouvrir la fenêtre Print par le menu File
        Get_MenuBar_File().OpenMenu();
        Get_MenuBar_File_Print().Click();
        Get_DlgPrint().WaitProperty("VisibleOnScreen", true, waitTime);
        aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, winTitle);
        Get_DlgPrint_BtnCancel().Click()
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
        //Ouvrir la fenêtre Print par Alt P
        Get_MainWindow().Keys("~p");
        Get_DlgPrint().WaitProperty("VisibleOnScreen", true, waitTime);
        aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, winTitle);
        Get_DlgPrint_BtnCancel().Click()
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45); 
   
        //Ouvrir la fenêtre Print par le menu contextuel
        Get_OrderGrid().ClickR();
        Get_OrderGrid_ContextualMenu_Print().Click();
        Get_DlgPrint().WaitProperty("VisibleOnScreen", true, waitTime);
        aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, winTitle);
        Get_DlgPrint_BtnCancel().Click()
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  
  
        Get_Toolbar_BtnPrint().Click()
    
        //Les points de vérification en français/anglais les fonctions sont dans le script Common_functions
        if(language == "french")
            Check_Print_Properties_French()
        else
            Check_Print_Properties_English()
  
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));     
    }
    finally {     
        //Fermer Croesus
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar(); 
    }   
}    