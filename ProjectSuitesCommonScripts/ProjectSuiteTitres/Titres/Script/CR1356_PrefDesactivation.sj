//USEUNIT DBA 

function CR_1356_PrefDesactivation(){

        Activate_Inactivate_PrefFirm("FIRM_1","FD_MFD_PROCESS","NO",vServerTitre); 
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_SPECIAL_DIV","NO",vServerTitre);
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_HISTO_DATA","SYSADM",vServerTitre); 
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_CALENDAR_MIN_MONTHS_LENGTH ",null,vServerTitre);           
        RestartServices(vServerTitre);        
}