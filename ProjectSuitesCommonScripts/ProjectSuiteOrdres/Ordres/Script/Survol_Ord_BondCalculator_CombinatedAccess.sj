//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Calculatrice d'obligations » avec 
                 Ctrl+Maj+O
                 Menu Tools
                 Boutton BondCalculator
    Vérifier la présence des contrôles et des étiquetés  
    
    Regroupé par : A.A Version ref90-19-2020-09-6  
*/


function Survol_Ord_BondCalculator_CombinatedAccess(){
     
            var winTitle = (language == "french")?"Calculatrice d'obligations" : "Bond Calculator";
            var waitTime = 3000;
     
             try{ 
  
                //Login et ouvrir le module Ordre   
                Login(vServerOrders, userName , psw ,language);
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262", true, waitTime);
        
                //Ouvrir la fenêtre "Calculatrice d'obligations" par CTL O
                Get_OrderGrid().Keys("^O");
                Get_WinBondCalculator().WaitProperty("VisibleOnScreen", true, waitTime);
                aqObject.CheckProperty(Get_WinBondCalculator().Title, "OleValue", cmpEqual, winTitle);      
                Get_WinBondCalculator().Close();
        
                //Ouvrir la fenêtre "Calculatrice d'obligations" par le menu Tools
                Get_MenuBar_Tools().OpenMenu()
                Get_MenuBar_Tools_BondCalculator().Click();
                Get_WinBondCalculator().WaitProperty("VisibleOnScreen", true, waitTime);
                aqObject.CheckProperty(Get_WinBondCalculator().Title, "OleValue", cmpEqual, winTitle);
                Get_WinBondCalculator().Close();
        
                //Ouvrir la fenêtre "Calculatrice d'obligations" par le bouttom BondCalculator
                Get_Toolbar_BtnBondCalculator().Click();
                Get_WinBondCalculator().WaitProperty("VisibleOnScreen", true, waitTime);
        
                //Les points de vérification en français/anglais, les fonctions sont dans Common_functions
                Log.PopLogFolder();
                logEtape2 = Log.AppendFolder("Les points de vérification");  
                if(language == "french")
                        Check_BondCalculator_Properties_French();     
                else 
                        Check_BondCalculator_Properties_English();      
                Check_BondCalculator_Existence_Of_Controls();
        
                Get_WinBondCalculator().Close();
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