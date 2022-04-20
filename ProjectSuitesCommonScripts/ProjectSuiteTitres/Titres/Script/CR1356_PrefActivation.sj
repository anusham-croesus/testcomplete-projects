//USEUNIT DBA 


function CR_1356_PrefActivation(){
        Activate_Inactivate_PrefFirm("FIRM_1","FD_MFD_PROCESS","YES",vServerTitre); 
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_SPECIAL_DIV","YES",vServerTitre);  
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_HISTO_DATA","SYSADM,FIRMADM,FIRMMAN", vServerTitre); 
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_CALENDAR_MIN_MONTHS_LENGTH ","999",vServerTitre);
        RestartServices(vServerTitre);  
}