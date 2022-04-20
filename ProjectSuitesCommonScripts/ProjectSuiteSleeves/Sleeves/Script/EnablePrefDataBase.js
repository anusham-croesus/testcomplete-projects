//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT Common_functions

/* Description :Activation des préférences de sleeves pour différents users pour préparer l'environnement
 
Analyste d'assurance qualité: Christine Hechema
Analyste d'automatisation: Sana Ayaz */

function PrepatPrefPourBD()
{
    Activate_Pref_Sleeve("GP1859","YES","YES","YES","YES","YES");
    Activate_Pref_Sleeve("UNI00","YES","YES","YES","YES","YES");
    Activate_Pref_Sleeve("COPERN","YES","YES","YES","YES","YES");
    Activate_Pref_Sleeve("ROOSEF","YES","YES","YES","YES","YES");
    Activate_Pref_Sleeve("FERMIE","NO","NO","NO","NO","NO");
    Activate_Pref_Sleeve("JEFFET","YES","YES","YES","YES","YES");
    Activate_Pref_Sleeve("LOTHC","YES","YES","YES","YES","YES");
    Activate_Pref_Sleeve("ADAMSJ","YES","YES","YES","NO","YES");
    Activate_Pref_Sleeve("VICTOM","YES","YES","NO","YES","NO");
    Activate_Pref_Sleeve("DALTOJ","YES","YES","NO","NO","NO");
    Activate_Pref_Sleeve("GALILG","YES","NO","YES","YES","YES");
    Activate_Pref_Sleeve("REAGAR","YES","NO","YES","NO","YES");    
    Activate_Pref_Sleeve("BELLAL","YES","NO","NO","YES","NO");
    Activate_Pref_Sleeve("DESOUST","YES","NO","NO","NO","NO");
    Activate_Pref_Sleeve("WASHIG","NO","NO","NO","NO","NO");
    Activate_Pref_Sleeve("LINCOA","NO","NO","NO","YES","NO");
    Activate_Pref_Sleeve("MAYERM","NO","NO","YES","NO","YES");
    Activate_Pref_Sleeve("DARWIC","NO","NO","YES","YES","YES"); 
    Activate_Pref_Sleeve("TETROA","NO","YES","NO","NO","NO");
    Activate_Pref_Sleeve("PELLETM","NO","YES","NO","YES","NO");
    Activate_Pref_Sleeve("HALLEE","NO","YES","YES","NO","YES");
    Activate_Pref_Sleeve("KEYNEJ","NO","YES","YES","YES","YES"); 
    
    //Débloquer le rééquilibrage
    Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
     
    RestartServices(vServerSleeves);  
    
}

function Activate_Pref_Sleeve(user,create,view,syns,del,trade)
{
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_CREATE",create,vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_VIEW",view,vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_SYNC",syns,vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_DELETE",del,vServerSleeves);  
    Activate_Inactivate_Pref(user,"PREF_SLEEVE_ALLOW_TRADE",trade,vServerSleeves); 
    Activate_Inactivate_Pref(user,"PREF_ENABLE_SLEEVES","YES",vServerSleeves);
    Activate_Inactivate_Pref(user,"PREF_DISPLAY_WHATS_NEW","NO",vServerSleeves);   
}