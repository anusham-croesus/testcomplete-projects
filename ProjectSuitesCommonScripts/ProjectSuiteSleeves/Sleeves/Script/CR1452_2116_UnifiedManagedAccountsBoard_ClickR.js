//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Fonctionnalitées du tableau de bord (clique-droit):
Les fonctionnalités standards offertes par Croesus pour les tableaux de bords sont attendues. Par exemple :
o Assigner une tâche / annuler l’assignation d’une tâche
o Consulter portefeuille / transactions
o Envoyer un courriel
o Aide
o Imprimer
Analyste d'automatisation: Youlia Raisper */


function CR1452_2116_UnifiedManagedAccountsBoard_ClickR()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");       
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnDashboard().Click();
        
        if(Get_Dashboard_UnallocatedPositionSleevesBoard().Exists){
           Get_Dashboard_UnallocatedPositionSleevesBoard().ClickR();
           CheckUnifiedManagedAccountsBoardClickR();          
        }else{
           Get_Toolbar_BtnAdd().Click();
           Get_DlgAddBoard_TvwSelectABoard_UnifiedManagedAccounts().Click();
           Get_DlgAddBoard_BtnOK().Click();
           Get_Dashboard_UnallocatedPositionSleevesBoard().ClickR();
           CheckUnifiedManagedAccountsBoardClickR();
        }                            
                
    }
    catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      //Débloquer le rééquilibrage
      Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function CheckUnifiedManagedAccountsBoardClickR(){
  aqObject.CheckProperty(Get_SubMenus().Find("WPFControlText",ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SubItemMenu_AssignTaskToMyself", language+client),10), "VisibleOnScreen", cmpEqual, true);  
  aqObject.CheckProperty(Get_SubMenus().Find("WPFControlText",ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SubItemMenu_CancelTaskAssignment", language+client),10), "VisibleOnScreen", cmpEqual, true);  
  aqObject.CheckProperty(Get_SubMenus().Find("WPFControlText",ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SubItemMenu_View", language+client),10), "VisibleOnScreen", cmpEqual, true);  
  aqObject.CheckProperty(Get_SubMenus().Find("WPFControlText",ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SubItemMenu_SendEmail", language+client),10), "VisibleOnScreen", cmpEqual, true);  
  //aqObject.CheckProperty(Get_SubMenus().Find("WPFControlText",ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SubItemMenu_Help", language+client),10), "VisibleOnScreen", cmpEqual, true);  //EM: 90-07-CO-15 : Enlevé suite au Jira CROES-9172
  //aqObject.CheckProperty(Get_SubMenus().Find("WPFControlText",ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SubItemMenu_Print", language+client),10), "VisibleOnScreen", cmpEqual, true); // Le fichier Excel n’a pas fonctionné dans ce cas.  
  if (language == "french"){aqObject.CheckProperty(Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10),"VisibleOnScreen",cmpEqual, true)}
  else {aqObject.CheckProperty(Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10),"VisibleOnScreen",cmpEqual, true)}  
} 

