//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : Automatisation du jira (Croes-11680)
 
Analyste d'automatisation: Youlia Raisper 
Numéro de l'anomalie:CROES-1168.
Version de scriptage:15-2020-3-84*/
      

function TCVE_1326_CROES_11680()
{
    try{  
        
        //PREF_PKG_ACTION_EXTERN=PKG_FBN --> déjà dans l'environnement        
        Log.Message("dans /etc/finansoft ajouter l'entrée ACTION_FBN_URL (+ adresse URL) dans crco.ini ACTION_FBN_URL https://www.croesusvie.com/");                          
        //Create PLINK batch file
        var hostname = GetVserverHostName(vServerAccounts);
        var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
        var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_preparation_TCVE1326.txt > ssh_preparation_TCVE1326_output.txt";
        var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteComptes\\Comptes\\ssh_preparation_TCVE1326_plink.bat";
        CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
        //Execute PLINK batch file (The PLINK application must be present in the same folder)
        ExecuteBatchFile(plinkBatchFilePath);
        
        var userKEYNEJ =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username") 
        var Account800067OB=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "Account800067OB", language+client);
        
        Log.Message("Se loguer dans Croesus avec user KEYNEJ");
        Login(vServerAccounts, userKEYNEJ ,psw,language);
        
        Log.Message("Aller au module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Sélectionner un compte et mailler vers module Portefeuille");
        Search_Account(Account800067OB);
        //fermer IE
        Terminate_IEProcess();
        
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value",Account800067OB,10),Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,30000); 
        
        Log.Message("Clic droit sur une position --> Achat ou Vente");
        SetAutoTimeOut();
        do{
          Get_Portfolio_PositionsGrid().ClickR();
        }while(!Get_SubMenus().Exists)
        RestoreAutoTimeOut();
        Get_PortfolioGrid_ContextualMenu_Buy().Click();
        
        Log.Message("Vérifier que la page de Croesus Vie s'ouvre");
        SetAutoTimeOut();
        if(NameMapping.Sys.Browser("iexplore").Exists){
          aqObject.CheckProperty(Sys.Browser("iexplore").BrowserWindow(0),"WndCaption",cmpContains, "Croesus Vie"); 
        }else{
          Log.Error("Jira:CROES-11680; GDO-2608: On devrait être redirigé vers la page de Croesus vie  ")
        }
        RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {         
	      Terminate_CroesusProcess();    
    }
}


