//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3222            
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module client et sélectionner une racine d'un client(disponible à partir de la section détails en bas du module clients):
                  La racine est sélectionnée.
                  3.Faire un clic droit et sélectionner relation ensuite choisir Associer a  une relation Famille-Firme:Un ''picker'' pour choisir une relation 
                  de type Famille-Firme apparait.
                  4.Choisir la relation et appuyer sur ok
                   
    Auteur : Sana Ayaz
*/
function CR1793_3222_Rel_AssociateARootCustomerHasRelationshipFamilyFirm()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          
         
          
          // Les variables
          var Client800256=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Client800256", language+client); 
          var NameRelatBNC_3222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "NameRelatBNC_3222", language+client);
          var IACodeCroes_3222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "IACodeCroes_3222", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "rootsBNC_1145", language+client);
          var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Client800239", language+client);
          var TitleWinRelationCroes_3222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "TitleWinRelationCroes_3222", language+client);
          var TypRelatCroes_3245=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "TypRelatCroes_3245", language+client);
          var Account800239RE=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Account800239RE", language+client);
          var Account800239SF=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Account800239SF", language+client);
          var Account800256GT=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Account800256GT", language+client);
          var Account800256NA=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "Account800256NA", language+client);
          var AccountText= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "AccountText", language+client);
          
          TabAccountAssignRelationFirmFamil = new Array();
      
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
          Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
          /*Aller dans le module Clients et sélectionner une racine d'un client(disponible à partir de la section détails en bas du module clients):
                  La racine est sélectionnée*/
          Get_ModulesBar_BtnClients().Click();
          Search_Client(Client800256)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800256, 10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800256,10).ClickR();
          /*Faire un clic droit et sélectionner relation ensuite choisir créer une relation Famille-Firme:
          Une fenêtre pour compléter les informations de la relation apparait.
          */
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //EM: selon BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
          Get_WinAssignToARelationship_BtnYes().Click();
        
         
         // Choisir un interlocuteur pour la relation et appuyer sur ok:La relation est créé.
          Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(NameRelatBNC_3222);
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click();
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemAC42().Click();
          Get_WinDetailedInfo_BtnOK().Click();
          
          /*Aller dans le module client et sélectionner une racine d'un client(disponible à partir de la section détails en bas du module clients):
          La racine est sélectionnée
          Faire un clic droit et sélectionner relation ensuite choisir Associer a  une relation Famille-Firme:Un ''picker'' pour choisir une relation 
                  de type Famille-Firme apparait.*/
                  
          Get_ModulesBar_BtnClients().Click();
          Search_Client(Client800239)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800239, 10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).Click();
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).ClickR();
          
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).ClickR();
  
          var numberOftries=0;  
          while ( numberOftries < 5 && !Get_SubMenus().Exists){
            Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).ClickR();
            numberOftries++;
          } 
          
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //Selon BNC-2042
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToAFamilyFirmRelationship().Click();
          // scroll pour pour pouvoir voir le champ Type
               for (var i=1; i<13; i++){       
                       Get_WinPickerWindow().Click(Get_WinPickerWindow().get_ActualWidth() - 30, 526);
                                }
          //Les points de vérifications
           Get_WinPickerWindow_DgvElements().FindChild("Value", TypRelatCroes_3245, 10).Click();
          // scroll pour pour pouvoir voir le champ Type
              Get_WinPickerWindow_DgvElements().FindChild("Value", TypRelatCroes_3245, 10).Click();
          
          aqObject.CheckProperty(Get_WinPickerWindow().Parent, "WndCaption", cmpEqual, TitleWinRelationCroes_3222);
          var CellTypeRelationShip = Get_WinPickerWindow_DgvElements().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10);
          var CellTypeRelationShipFamilFirm=Get_WinPickerWindow_DgvElements().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).WPFObject("XamTextEditor", "", 1);
          Log.Message("Cette différence a été déjà envoyée à Mamoudou, on n’a pas reçue la réponse")
          Log.Message("Jira: CROES-6026")
          aqObject.CheckProperty(CellTypeRelationShipFamilFirm, "Text", cmpEqual, TypRelatCroes_3245);
          aqObject.CheckProperty(CellTypeRelationShip, "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(CellTypeRelationShip, "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPickerWindow().Parent, "WndCaption", cmpEqual, TitleWinRelationCroes_3222);
          Get_WinPickerWindow_BtnOK().Click();
           Get_WinAssignToARelationship_BtnYes().Click()
         
        
         //Vérifier que l'association a été faite
        Log.Message("Verify that the assignment was done");
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelatBNC_3222, 10);
        if (searchResultRelationship.Exists == false){
            Log.Error("The grouped relationship " + NameRelatBNC_3222 + " was not displayed.");
            return;
        }
         
        
          TabAccountAssignRelationFirmFamil.push(Account800239RE);
          TabAccountAssignRelationFirmFamil.push(Account800239SF);
          TabAccountAssignRelationFirmFamil.push(Account800256GT);
          TabAccountAssignRelationFirmFamil.push(Account800256NA);
       
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelatBNC_3222, 10).Click();
        for(var j = 0; j < 4; j++){
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", AccountText, 10).Find("OriginalValue",TabAccountAssignRelationFirmFamil[j], 10);
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account number " + TabAccountAssignRelationFirmFamil[j] + " was not found in the hierarchy panel of the relationship " + NameRelatBNC_3222 + ".");
        }
        else {
            Log.Checkpoint("The account number " + TabAccountAssignRelationFirmFamil[j] + " was found in the hierarchy panel of the relationship " + NameRelatBNC_3222 + ".");
        }
        }
          
           }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerClients, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(NameRelatBNC_3222);
        Terminate_CroesusProcess();
        
    }
}

