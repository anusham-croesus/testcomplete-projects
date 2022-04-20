//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR885_Survol_Win_Gril_Billing




  
 function CR885_Grid_Manag_Billing_Valid_Btns()
    {
        Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,BRMAN",vServerBilling);
        Login(vServerBilling, userNameBilling, pswBilling, language);
        // Choisir Tools/Configurations/Billing/Manage Validation Grid
        ClickWinConfigurationsManageValidationGrid();
    
    
 
    }