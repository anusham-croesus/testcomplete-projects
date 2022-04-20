//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/*
Création + Ajout d'une relation groupée à partir menu contextuelle 

Auteur : Jimena Bernal
Analyste Manuel : antonb
Version de scriptage: ref90-10-Fm-6

*/

function Regression_Croes_4216_RelJoinGrouRelaFromRightClick() {
  
try 
    {

      var userNameROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username");
      var passwordROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw");
      var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","relationshipName", language+client);
      var groupedRelationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","groupedRelationshipName", language+client);
      var WinNameAssig = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "WinNameAssig", language+client);
      var NameRelGroDetC = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "NameRelGroDetC", language+client);
        
      Login(vServerRelations, userNameROOSEF, passwordROOSEF, language); 
        

      CreateRelationship(relationshipName);
      CreateGroupedRelationship(groupedRelationshipName);


      //Selectionner la relation relationshipName dans la grille du module relations
      Log.Message("Select '" + relationshipName + "' relationship.");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();


      Get_RelationshipsClientsAccountsBar().ClickR();
      Delay (1000);
      Get_RelationshipsClientsGrid_ContextualMenu_Add().Click(); 
      Get_RelationshipsGrid_ContextualMenu_Add_JoinToAGroupedRelationship().Click();
        
      Get_WinPickerWindow_BtnOK().Click();


      Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
      if (!(Get_WinAssignToARelationship().Exists)){
          Log.Error("The 'Assign to a relationship' window was not displayed.");
          return;
      }
      
              
      Get_WinAssignToARelationship_BtnYes().Click();
        
        
      //Validé sur la zone de détails la relation associée
      Delay(1000);
      SearchRelationshipByNo(relationshipName)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NameRelGroDetC,10), "Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NameRelGroDetC,10), "VisibleOnScreen", cmpEqual, true);
      
   }


      catch (e) {
  
      Log.Error("Exception: " + e.message, VarToStr(e.stack));

      }
    
      finally {
      
      DeleteRelationship(relationshipName);
      DeleteRelationship(groupedRelationshipName);
      Terminate_CroesusProcess();
          
      }

}

