//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 




/**
    Module               :  Orders
    Jira                 :  TCVE-2474
    Description          : Régression des story GDO-3164, GDO-2694, GDO-2698, GDO-3208, GDO-3425, GDO-3271, GDO-3473

    
    Auteur               :  Sana Ayaz
    Version de scriptage :	ref90-19-2020-09-14--V9-croesus-co7x-2_1_758
    date                 :  22-09-2020 
  
    
*/

function TCVE_2778_PF_2615()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2778","Lien de la story dans Jira");
           //Lien du cas de test dans jira
           Log.Link("https://jira.croesus.com/browse/PF-2615","Lien vers l'anomalie");
          //Declaration des Variables
           var userNameLYNCHJ     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LYNCHJ", "username");
           var passwordLYNCHJ     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LYNCHJ", "psw");
           var client800300       = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "client800300", language+client);
           var shortNamePF2615    = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "shortNamePF2615", language+client);
           var codeBD88           = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "codeBD88", language+client);
   
         
/************************************Étape 1************************************************************************/     
           /*Se connecter avec le user LYNCHJ*/        
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user LYNCHJ");
          Log.Message("Se connecter avec le user LYNCHJ")
          Login(vServerPortefeuille, userNameLYNCHJ, passwordLYNCHJ, language);
/************************************************ Étape 2 **************************************************************************/          
          
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Mailler le client 800300 vers le module portefeuille");
          Get_ModulesBar_BtnClients().Click();
          
          Get_ModulesBar_BtnClients().Click();
          Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
          Search_Client(client800300);
          Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client800300,10), Get_ModulesBar_BtnPortfolio());
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
          WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
/************************************************ Étape 3 **************************************************************************/          
           
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Cliquer sur simulation  choisir nouveau compte fictif ensuite on clique sur le bouton OK");
          Get_PortfolioBar_BtnWhatIf().Click();
          Get_PortfolioBar_BtnSave().Click();
          Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Click();
          Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(shortNamePF2615);
          Get_WinWhatIfSave_GrpAccountInformation_CmbIACode().DblClick()
          Get_WinWhatIfSave_GrpAccountInformation_CmbIACode().Keys(codeBD88);
        
          Get_WinWhatIfSave_BtnOK().Click();
          Get_DlgInformation().Close();
/************************************************ Étape 4 **************************************************************************/          
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur le bouton sauvegarder pour créé un autre compte fictif ensuite cliquer sur le bouton detailed save puis Ok");
          
          Get_PortfolioBar_BtnSave().Click();
          Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Click();
          Get_WinWhatIfSave_BtnDetailedSave().Click();
          Get_WinDetailedInfo_TabAddresses().Click();
          Get_WinDetailedInfo_TabAddresses().Click();
          Get_DlgConfirmation_BtnYes().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          Get_DlgConfirmation_BtnYes().Click();
          Get_DlgInformation().Close();
          Log.Message("L'anomalie PF-2615")
          SetAutoTimeOut();
          if(Get_DlgError().Exists) 
               Log.Error("Croesus Crash")
          else
               Log.Checkpoint("L'application ne crash pas.");
          RestoreAutoTimeOut();    
}

          
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         Terminate_CroesusProcess(); 
        
    }
    finally {   
        Terminate_CroesusProcess(); 
    
        Runner.Stop(true);   

        
           
    }
 }
