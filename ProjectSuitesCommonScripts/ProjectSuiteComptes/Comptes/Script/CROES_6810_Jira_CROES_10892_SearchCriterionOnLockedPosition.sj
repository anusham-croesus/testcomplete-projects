//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT CROES_8311_Account_CrashAfterSearchingByCPCode



/**
        Description :  Critère de recherche sur position bloquée
                         


    Auteur : Alhasssane Diallo
    Lien vers le cas de test link:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6810
    Version de scriptage:	ref90-12-Hf-5
*/
function CROES_6810_Jira_CROES_10892_SearchCriterionOnLockedPosition()
{
    try {
        
        //Variables 
       var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
       var compte300001NA = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "compte300001NA", language+client);
       var pos_TML204 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "pos_TML204", language+client);
       var criter_6810 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "criter_6810", language+client);
       var nbr_Acounts_lockedPosition = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "nbr_Acounts_lockedPosition", language+client);
       
       //Lien Testlink
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6810","Lien testlink - Croes-6810");
        
       
       
      ///Se connecter avec Keynej
       Log.Message("******************** Login *******************");
       Login(vServerAccounts, userNameKeynej, passwordKeynej, language);
        
       
       //Mailler le compte 300001-NA dans portefeuilles et bloquer la position "TML204"  
        Bloquer_debloquer_position(compte300001NA, pos_TML204);
        
        
        
        //Revenir dans le module compte
        Log.Message("*********Revenir dans le module compte**********")
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
        
        //Ajout de critere : Liste des comptes (Compte Réél) ayant position bloquée égal(e) à Non.
        Log.Message("*********Ajout de critere : Liste des comptes (Compte Réél) ayant position bloquée égal(e) à Non.**********")
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().Keys(criter_6810);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemLockedPosition().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemNo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        
        //Point de verification : liste des compte ayant position bloquée égal à Non
        aqObject.CheckProperty(Get_StatusBar_ContentSelection(),"Text",cmpEqual, nbr_Acounts_lockedPosition);
        
       //Rafraichir le browser
       Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
       
        
        //Mailler le compte 300001-NA dans portefeuilles et bloquer la position "TML204" TML204 afin de revenir à l'état initial. 
        Log.Message("*********Remetre la position à l'etat initiale.**********")
        Bloquer_debloquer_position(compte300001NA, pos_TML204) 
        
        
       //Fermer Croesus
       Close_Croesus_X(); 
                  
   
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); //Fermer Croesus
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Delete_FilterCriterion(criter_6810, vServerAccounts); //Supprimer le critère
       
        
    }
}


function Bloquer_debloquer_position(compte300001NA, pos_TML204){
    
     //Sélectionner le compte 300001-NA et mailler vers module portefeuille
        Log.Message("*********Sélectionner le compte 300001-NA et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
                
        Search_Account(compte300001NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",compte300001NA,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
        
       //Selectionner la position TML204 et  cliquer sur le bouton info pour ouvrir la fenêter info de la position
        Log.Message("*******Selectionner la position "+pos_TML204+" et  cliquer sur le bouton info pour ouvrir la fenêter info de la position*********")
        Search_Position(pos_TML204);
        Get_PortfolioBar_BtnInfo().Click();
        
        //Cliquer sur la position info + Cocher la case Locked position 
        Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().Click();
        Get_WinPositionInfo_BtnOK().Click();

}

function Get_StatusBar_ContentSelection() {return Aliases.CroesusApp.winMain.FindChild("Uid", "StatusBarContentSelection", 100)}
