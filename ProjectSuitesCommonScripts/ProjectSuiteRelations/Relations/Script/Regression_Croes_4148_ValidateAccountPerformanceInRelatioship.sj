//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/*
***** Valider la performance d'un compte dans une relation

Auteur : Jimena Bernal
Analyste Manuel : antonb
Version de scriptage: ref90-10-Fm-6

*/


function Regression_Croes_4148_ValidateAccountPerformanceInRelatioship()
{

          
  try 
    {
      var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
      var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
      var AddNewRel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AddNewRel", language+client);
      var clientName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "clientName", language+client);
      var accountName = clientName;
      var Account800208 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Account800208", language+client);  
      var CheckpointPerformance = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "CheckpointPerformance", language+client);
  
      Login(vServerRelations,userNameCOPERN,passwordCOPERN,language);

      //Sélectionner le Module Relation
      Get_ModulesBar_BtnRelationships().Click();
      Get_MainWindow().Maximize();
  

      //Créer la relation

      CreateRelationship(AddNewRel);
        
      //Associer le compte à la relation
      JoinAccountToRelationship(accountName, AddNewRel, true);
      
      Log.Message("Select '" + AddNewRel + "' relationship.");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddNewRel, 10).Click();
      
      //Dans la section de détails, sélectionner la compte Account800208 / Clic-Droit/Performance... 
      
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", Account800208, 10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", Account800208, 10).ClickR();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Performance().Click();
      
      //La fenêtre de performance s'affiche à partir du right-click
      aqObject.CheckProperty(Get_WinPerformance(), "Title", cmpEqual, CheckpointPerformance);
      
      Get_WinPerformance_BtnClose().Click();
        
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }

    finally {
      
      Terminate_CroesusProcess();
      Login(vServerRelations,userNameCOPERN,passwordCOPERN,language);
      Get_ModulesBar_BtnRelationships().Click();
      SearchRelationshipByNo(AddNewRel); 
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", Account800208, 10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", Account800208, 10).ClickR();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
      Get_DlgConfirmation_BtnRemoveReg().Click();
      DeleteRelationship(AddNewRel);
      Terminate_CroesusProcess();

    }


}


