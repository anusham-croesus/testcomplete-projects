//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
/**
    Description :
                 1)	Ouvrir le module client ensuite sélectionner un client réels avec la VT>0 
                 2)	Sélectionner la racine de ce client ensuite faire un clic droit =====>Associer=====>Relation=====>Créer une Relation Famille-Firme.
                 3)	Faire un clic sur oui ensuite entrer le nom de la Relation et appuyer sur ok.
                 4)	Vérifier que la valeur totale indique pour cette relation correspond avec la valeur totale qui a été affiche dans le module client.
                 5)	Aller de nouveau dans module client et sélectionner un autre client réel avec la la VT>0 
                 6)	Sélectionner la racine de ce client ensuite faire un clic droit =====>Associer=====>Relation=====>Associer à une Relation Famille-Firme.
                 7)	Sélectionner la Relation Famille-Firme crée a l’étape 3 ensuite appuyer sur ok ensuite sur Oui.
                 8) Vérifier que la valeur totale indiquée pour cette relation correspond à la somme des valeurs totales qui sont affichées dans le module client pour les 2 clients.


                   
    Auteur : Sana Ayaz
*/
function CR1793_BNC_1178_Rel_CheckValTotalRelFamilFirm()
{
    try {
      
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
      
        //Les variables
          var Client800236=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800236", language+client);
          var Client800234=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800234", language+client);  
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client); 
          var relationshipNameBNC_1178=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameBNC_1178", language+client);
          var IACodeBNC_1178=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeBNC_1178", language+client);
          var NameRelatBNC_1178 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "NameRelatBNC_1178", language+client);
          var TotalValueBNC_1178=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TotalValueBNC_1178", language+client);
          var TotalValueWithSpaceBNC_1178=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "TotalValueWithSpaceBNC_1178", language+client);
           
         Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        // 1)	Ouvrir le module client ensuite sélectionner un client réels avec la VT>0 
         Get_ModulesBar_BtnClients().Click();
         Search_Client(Client800236)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800236, 10).Click();
         //2)	Sélectionner la racine de ce client ensuite faire un clic droit =====>Associer=====>Relation=====>Créer une Relation Famille-Firme.
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800234,10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800234,10).ClickR();
         //3.Associer----> Relation ---> Créer une relation Famille-Firme
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
         //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //selon le Jira BNC-2042
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
         // 3)	Faire un clic sur oui ensuite entrer le nom de la Relation et appuyer sur ok.
         Get_WinAssignToARelationship_BtnYes().Click();
        // Renseigner Noms et code de CP(BD88)
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameBNC_1178);
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeBNC_1178);
         Get_WinDetailedInfo_BtnOK().Click();
         
         //4)	Vérifier que la valeur totale indique pour cette relation correspond avec la valeur totale qui a été affiche dans le module client.
         //Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtTotalValue
      //    WaitUntilObjectDisappears(Get_WinDetailedInfo_TabInfo(), ["ClrClassName", "WPFControlText"], ["TabItem", "Info"]);
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          WaitObject(Get_RelationshipsDetails_TabInfo_ScrollViewer(),"Uid", "TextBox_0dab",  15000);
         
         aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtTotalValue(), "Enabled", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtTotalValue(), "Text", cmpEqual, TotalValueWithSpaceBNC_1178);
         aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtTotalValue(), "Text_2", cmpEqual, TotalValueWithSpaceBNC_1178);
         
         //
       
           croesusRowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
          arrayOfRelationshipsNames = new Array();
          for (var i = 0; i < croesusRowCount; i++){
              var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
              if(displayedRelationshipName == NameRelatBNC_1178)
              {
                var displayRelationshipTotalValue=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_TotalValue();
                break;
              }
        
          }
        //  Log.Message(displayRelationshipTotalValue)
          if(displayRelationshipTotalValue == TotalValueBNC_1178)
          {
            Log.Checkpoint("la valeur affichée correspond a la bonne valeur"+displayRelationshipTotalValue)
      
          }
          else Log.Error("la valeur affichée ne correspond pas a la bonne valeur"+displayRelationshipTotalValue)
          Log.Message(displayRelationshipTotalValue)
          Log.Message(TotalValueBNC_1178)
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //initialiser la BD
        Terminate_CroesusProcess();
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerRelations)
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(NameRelatBNC_1178);
        Terminate_CroesusProcess();
        
    }
}