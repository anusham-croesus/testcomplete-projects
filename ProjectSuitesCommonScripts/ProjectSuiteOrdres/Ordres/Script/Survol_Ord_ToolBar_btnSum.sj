//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Ord_MenuBar_EditSum


/* Description : A partir du module « Orders » , afficher la fenêtre « Sommation des titres » avec AltS . 
 Vérifier la présence des contrôles et des étiquetés */ 

 function Survol_Ord_ToolBar_btnSum()
 {
    Login(vServerOrders, userName , psw ,language);
    Get_ModulesBar_BtnOrders().Click()
    
    Get_Toolbar_BtnSum().Click()
    
    //Les points de vérification en français 
     if(language=="french"){Check_Properties_French()} 
    //Les points de vérification en anglais 
    else {Check_Properties_English()} 
    
    Get_WinOrdersSum_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_AltQ();
 }