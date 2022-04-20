//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**
    Description :
                  1.avec KEYNEJ, sélectionner le client 800236
                  2.clic droit sur sa racine secondaire 800234
                  3.Associer----> Relation ---> Créer une relation Famille-Firme
                  4.Oui
                  5.Renseigner Noms et code de CP(BD88)
                  6.OK
                  7.retour au module et sélectionner le encore le client 800236
                  8.clic droit sur sa racine principale 800236
                  9.Associer----> Relation --->Associer à une relation Famille-Firme
                  10.sélectionner la relation Famille-Firme créé précedemment
                  11.OK ---> Oui

                  Résultat attendu : la relation créée à l`étape 6 est présente dans le picker et l`association de la racine principale 800236 fonctionne
                   
    Auteur : Sana Ayaz
*/
function CR1793_BNC_1145_Rel_DisponiRelationDansPicker()
{
    try {
      
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
      
        //Les variables
          var Client800236=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800236", language+client);
          var Client800234=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800234", language+client);  
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client); 
          var relationshipNameBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameBNC_1145", language+client);
          var IACodeBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeBNC_1145", language+client);
          //var NoRelatBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "NoRelatBNC_1145", language+client);
          var NameRelatBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "NameRelatBNC_1145", language+client);
          var TypRelatBNC_1145= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TypRelatBNC_1145", language+client);
          var AccountText= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "AccountText", language+client);
          var Account800236GT0=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800236GT0", language+client);
          var Account800236GT1= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800236GT1", language+client);
          var Account800236GT2= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800236GT2", language+client);
          var Account800236GT3= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800236GT3", language+client);
          TabAccount800236 = new Array();
           
         Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        //1.avec KEYNEJ, sélectionner le client 800236
         Get_ModulesBar_BtnClients().Click();
         Search_Client(Client800236)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800236, 10).Click();
         // 2.clic droit sur sa racine secondaire 800234
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800234,10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800234,10).ClickR();
         //3.Associer----> Relation ---> Créer une relation Famille-Firme
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
         //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click()
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
         //4.Oui
         Get_WinAssignToARelationship_BtnYes().Click();
        
         
         // 5.Renseigner Noms et code de CP(BD88)
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameBNC_1145);
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeBNC_1145);
         //6.OK
         Get_WinDetailedInfo_BtnOK().Click();
         
         //Recupérer le numéro de la relation
         var NoRelatBNC_1145 = Get_RelationshipNo(relationshipNameBNC_1145);         
         
         //7.retour au module et sélectionner le encore le client 800236
         Get_ModulesBar_BtnClients().Click();
         Search_Client(Client800236)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800236, 10).Click();
         // 8.clic droit sur sa racine principale 800236
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800236,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800236,10).ClickR();
         
         //9.Associer----> Relation --->Associer à une relation Famille-Firme
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
        //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() // selon le Jira BNC-2042
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToAFamilyFirmRelationship().Click();
         
         //Les points de vérificatiosn la relation existe dans le picker
         //Log.Message("il faut soit changer le data pool soit recupérer le numéro de la relation dynamiquement: 00010 VS 0000Z ")
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.LinkNumber, "OleValue", cmpEqual, NoRelatBNC_1145);
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",NoRelatBNC_1145,10), "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",NoRelatBNC_1145,10), "Exists", cmpEqual, true); 
          
          
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.FullName, "OleValue", cmpEqual, relationshipNameBNC_1145);
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",relationshipNameBNC_1145,10), "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",relationshipNameBNC_1145,10), "Exists", cmpEqual, true); 
          
          
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ShortName, "OleValue", cmpEqual, NameRelatBNC_1145);
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",NameRelatBNC_1145,10), "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",NameRelatBNC_1145,10), "Exists", cmpEqual, true); 
          // scroll pour pour pouvoir voir le champ Type
               for (var i=1; i<13; i++){       
                       Get_WinPickerWindow().Click(Get_WinPickerWindow().get_ActualWidth() - 30, 526);
                                }

          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Type3Description, "OleValue", cmpEqual, TypRelatBNC_1145);
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",TypRelatBNC_1145,10), "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(Get_WinPickerWindow_DgvElements().Find("Value",TypRelatBNC_1145,10), "Exists", cmpEqual, true); 
        
         
         
         //11.OK ---> Oui
         Get_WinPickerWindow_BtnOK().Click()
         Get_WinAssignToARelationship_BtnYes().Click()
         
         //Résultat attendu : la relation créée à l`étape 6 est présente dans le picker et l`association de la racine principale 800236 fonctionne
         
         // Les points de vérifications le client 800-236 fais partis de la liste des clients associéa la relation
            
         
         //Vérifier que l'association a été faite
        Log.Message("Verify that the assignment was done");
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelatBNC_1145, 10);
        if (searchResultRelationship.Exists == false){
            Log.Error("The grouped relationship " + NameRelatBNC_1145 + " was not displayed.");
            return;
        }
         
        
          TabAccount800236.push(Account800236GT0);
          TabAccount800236.push(Account800236GT1);
          TabAccount800236.push(Account800236GT2);
          TabAccount800236.push(Account800236GT3);
       
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelatBNC_1145, 10).Click();
        for(var j = 0; j < 4; j++){
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", AccountText, 10).Find("OriginalValue",TabAccount800236[j], 10);
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account number " + TabAccount800236[j] + " was not found in the hierarchy panel of the relationship " + NameRelatBNC_1145 + ".");
        }
        else {
            Log.Checkpoint("The account number " + TabAccount800236[j] + " was found in the hierarchy panel of the relationship " + NameRelatBNC_1145 + ".");
        }
       }    
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(NameRelatBNC_1145);
        Terminate_CroesusProcess();
        
    }
}

