//USEUNIT Common_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


function PrefActivation(){
    
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BULK_VALIDATION_REMINDER", "", vServerRQS); 
        RestartServices(vServerRQS);
}