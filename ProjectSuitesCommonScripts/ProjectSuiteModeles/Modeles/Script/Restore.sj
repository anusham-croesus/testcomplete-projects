//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
 
Analyste d'automatisation: Youlia Raisper */


function Restore()
{
    try{  
                    
       Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "NO", vServerModeles)  
       Execute_SQLQuery("update b_config set  NOTE ='2009.01.25' where cle ='FD_LASTTRA'", vServerModeles) 
           
       RestartVserver(vServerModeles);
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {         
	    Runner.Stop(true);      
    }
}