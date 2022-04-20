//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2659
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */



function CR1709_2659_Check_PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT_3(){
  
  try{  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "3", vServerModeles)
        RestartServices(vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2659","Cas de test TestLink : Croes-2659")  
            
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        Get_AccountsBar_BtnInfo().CLick();
        
        if(Get_WinAccountInfo_TabCashManagement().Exists == true && Get_WinAccountInfo_TabCashManagement().VisibleOnScreen == true ){
          Log.Error("L’onglet Gestion de l’encaisse est visible ")
        }
        else{
          Log.Checkpoint("L’onglet Gestion de l’encaisse n'est pas visible ")
        }
        
        Get_WinAccountInfo_BtnOK().Click();
                            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus 
	    Runner.Stop(true);            
    }
}