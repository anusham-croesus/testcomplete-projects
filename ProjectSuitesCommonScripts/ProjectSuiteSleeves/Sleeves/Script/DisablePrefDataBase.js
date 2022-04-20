//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT Common_functions

/* Description :Désactivation des préférences de sleeves pour différents users pour mettre la BD comment avant
 
Analyste d'assurance qualité: Christine Hechema
Analyste d'automatisation: Sana Ayaz */

function DisablePrefDataBase()
{

    Desactif_Pref_Sleeve("UNI00");
    Desactif_Pref_Sleeve("COPERN");
    Desactif_Pref_Sleeve("ROOSEF");
    Desactif_Pref_Sleeve("FERMIE");
    Desactif_Pref_Sleeve("JEFFET");
    Desactif_Pref_Sleeve("LOTHC");
    Desactif_Pref_Sleeve("ADAMSJ");
    Desactif_Pref_Sleeve("VICTOM");
    Desactif_Pref_Sleeve("DALTOJ");
    Desactif_Pref_Sleeve("GALILG");
    Desactif_Pref_Sleeve("REAGAR");
    Desactif_Pref_Sleeve("BELLAL");
    Desactif_Pref_Sleeve("DESOUST");
    Desactif_Pref_Sleeve("WASHIG");
    Desactif_Pref_Sleeve("LINCOA");
    Desactif_Pref_Sleeve("MAYERM");
    Desactif_Pref_Sleeve("DARWIC"); 
    Desactif_Pref_Sleeve("TETROA");
    Desactif_Pref_Sleeve("PELLETM");
    Desactif_Pref_Sleeve("HALLEE"); 
    Desactif_Pref_Sleeve("KEYNEJ"); 

    RestartServices(vServerSleeves);  
    
}

function Desactif_Pref_Sleeve(user)
{
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_CREATE","NO",vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_VIEW","NO",vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_SYNC","NO",vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_DELETE","NO",vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_TRADE","NO",vServerSleeves); 
    Activate_Inactivate_Pref(user,"PREF_ENABLE_SLEEVES","NO",vServerSleeves); 
  
}

