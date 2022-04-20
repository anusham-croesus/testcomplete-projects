//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/*
Création + Ajout d'une relation groupée à partir du menu edition

Auteur : Jimena Bernal
Analyste Manuel : antonb
Version de scriptage: ref90-10-Fm-6

*/

function Regression_Croes_4216_RelJoinGrouRelaFromMenuEdit() {
  
 try {
   
      var userNameROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username");
      var passwordROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw");
      var relaName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","relaName", language+client);
      var groupedRelaName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","groupedRelaName", language+client);
      var WinNameAssigResul = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "WinNameAssigResul", language+client);
      var NameRelGroDetM = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "NameRelGroDetM", language+client); 
        
      Login(vServerRelations, userNameROOSEF, passwordROOSEF, language); 
        

      CreateRelationship(relaName);
      CreateGroupedRelationship(groupedRelaName);


      //Selectionner la relation relationshipName dans la grille du module relations
      Log.Message("Select '" + relaName + "' relationship.");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", relaName, 10).Click();
      
      //Aller au menu Edition/Relation/Associer à un relation groupée
      Get_MenuBar_Edit().Click();
      Get_MenuBar_Edit_Relationship().Click();
      Get_MenuBar_Edit_Relationship_JoinToAGroupedRelationship().Click();
      
      Get_WinPickerWindow_BtnOK().Click();
      
      Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
      if (!(Get_WinAssignToARelationship().Exists)){
          Log.Error("The 'Assign to a relationship' window was not displayed.");
          return;
      }
      
             
      Get_WinAssignToARelationship_BtnYes().Click();
      
      //Validé sur la zone de détails la relation associée
      Delay(1000);
      SearchRelationshipByNo(relaName)
      
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NameRelGroDetM,10), "Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NameRelGroDetM,10), "VisibleOnScreen", cmpEqual, true);
 
 
 }
 
     catch (e){
   
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
 
     }
 
 
      finally {
      DeleteRelationship(relaName);
      DeleteRelationship(groupedRelaName);
      Terminate_CroesusProcess();
 
     }

}



