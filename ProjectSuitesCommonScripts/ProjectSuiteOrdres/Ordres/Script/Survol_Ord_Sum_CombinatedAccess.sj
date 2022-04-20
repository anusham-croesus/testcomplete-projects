//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum. 
                Vérifier la présence des contrôles et des étiquetés 
                
  Regroupé par : A.A Version ref90-19-2020-09-6 
*/

function Survol_Ord_Sum_CombinatedAccess(){
    
        try{
                var waitTime = 3000;
                var winTitle = (language == "french")?"Sommation (ordres)" : "Sum (Orders)";
        
                Login(vServerOrders, userName , psw ,language);
                Get_ModulesBar_BtnOrders().Click()
    
                Get_MenuBar_Edit().OpenMenu();
                Get_MenuBar_Edit_Sum().Click();
                Get_WinOrdersSum().WaitProperty("VisibleOnScreen", true, waitTime);
                aqObject.CheckProperty(Get_WinOrdersSum(), "WPFControlText", cmpEqual, winTitle);
                Get_WinOrdersSum().Close();
    
                Get_OrderGrid().Keys("~s");
                Get_WinOrdersSum().WaitProperty("VisibleOnScreen", true, waitTime);
                aqObject.CheckProperty(Get_WinOrdersSum(), "WPFControlText", cmpEqual, winTitle);
                Get_WinOrdersSum().Close();
    
                Get_Toolbar_BtnSum().Click();
                Get_WinOrdersSum().WaitProperty("VisibleOnScreen", true, waitTime);
        
                //Les points de vérification en français/anglais 
                 if(language == "french")
                        Check_Properties_French();
                else
                        Check_Properties_English();
    
                Get_WinOrdersSum().Close();
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
 
  //Fonctions  (les points de vérification pour les scripts qui testent Sum)
function Check_Properties_French()
{
            aqObject.CheckProperty(Get_WinOrdersSum(), "WPFControlText", cmpEqual, "Sommation (ordres)");
  
            aqObject.CheckProperty(Get_WinOrdersSum_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
            aqObject.CheckProperty(Get_WinOrdersSum_BtnClose(), "IsEnabled", cmpEqual, true); 
  
            aqObject.CheckProperty(Get_WinOrdersSum_ChNumberOfTransactions(), "Content", cmpEqual, "Nombre de transactions");
            aqObject.CheckProperty(Get_WinOrdersSum_ChFinancialInstrument(), "IsVisible", cmpEqual, true);
    
}

function Check_Properties_English()
{
 
            aqObject.CheckProperty(Get_WinOrdersSum(), "WPFControlText", cmpEqual, "Sum (Orders)");
  
            aqObject.CheckProperty(Get_WinOrdersSum_BtnClose().Content, "OleValue", cmpEqual, "_Close");
            aqObject.CheckProperty(Get_WinOrdersSum_BtnClose(), "IsEnabled", cmpEqual, true); 
  
            aqObject.CheckProperty(Get_WinOrdersSum_ChNumberOfTransactions(), "Content", cmpEqual, "Number of Transactions");
            aqObject.CheckProperty(Get_WinOrdersSum_ChFinancialInstrument(), "IsVisible", cmpEqual, true);
}