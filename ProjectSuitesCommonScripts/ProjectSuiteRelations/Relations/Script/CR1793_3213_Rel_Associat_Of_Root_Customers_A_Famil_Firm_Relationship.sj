//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3213
    Description :
                  1.Ouvrir une session avec l'utilisateur REAGAR:La connexion est établie
                  2.Aller dans le module relation choisir une relation Famille-Firme  dans la liste et appuyer sur l'icône '+'
                   et sélectionner ''Associer des clients racine a la relation'':Une nouvelle fenêtre inutile ''Créer une relation'' s'ouvre 
                   avec l'option ''Associer des clients racine a la relation'' apparait. 
                  3.Appuyer sur OK:Une nouvelle fenêtre pour  choisir un client racines apparait. 
                  4.Dans la fenêtre des clients choisir un client racine(S'assurer que dans la liste n'apparait pas des 
                  clients fictif et externes) et appuyer sur ok:Un nouveau client racine est rajouté dans la section sommaire en bas de l'écran.
    Auteur : Sana Ayaz
*/
function CR1793_BNC_1145_Rel_DisponiRelationDansPicker()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
         
      
        //Les variables
          var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800239", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client); 
          var relationshipNameCroes_3213=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_3213", language+client);
          var IACodeCroes_3213=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_3213", language+client);
          var NameWindRootClient=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "NameWindRootClient", language+client);
          var DetailAccountCROES_3213=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "DetailAccountCROES_3213", language+client);
          var Client800042=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800042", language+client);
          var Account800042FS=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800042FS", language+client);
          var Account800042NA=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800042NA", language+client);
          var Account800042OB=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800042OB", language+client);
         Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        //Sélectionner le client 800239
         Get_ModulesBar_BtnClients().Click();
         Search_Client(Client800239)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", Client800239, 10).Click();
         //clic droit sur sa racine secondaire 800239
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_1145,10).Find("OriginalValue",Client800239,10).ClickR();
         //Associer----> Relation ---> Créer une relation Famille-Firme
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
         //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship().Click() //selon le Jira BNC-2042
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship().Click();
         //Oui
         Get_WinAssignToARelationship_BtnYes().Click();
        
         
         // Renseigner Noms et code de CP(BD88)
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_3213);
           Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_3213);
         //OK
         Get_WinDetailedInfo_BtnOK().Click();
         /* ller dans le module relation choisir une relation Famille-Firme  dans la liste et appuyer sur l'icône '+'
                   et sélectionner ''Associer des clients racine a la relation'':Une nouvelle fenêtre inutile ''Créer une relation'' s'ouvre 
                   avec l'option ''Associer des clients racine a la relation'' apparait. */
         
          Get_ModulesBar_BtnRelationships().Click();
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_3213, 10).Click();
          Get_Toolbar_BtnAdd().Click();
          Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRootClientsToRelationship().Click();
 
         //Vérifier que la fenêtre Clients racines est ouverte
         Log.Message("Verify that he picker window is displayed.");
         if (!(Get_WinPickerWindow().Exists)){
            Log.Error("The picker window was not displayed.");
            return;
         }
        
         aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, NameWindRootClient);
         // Vérifier que sur cette fenêtre il y a pas de clients fictifs ou externes
          // Les Points de vérifications pour vérifier qu'aucun client fictif n'existe sur la liste
          Sys.Keys(".");
         Get_WinQuickSearch_TxtSearch().SetText("~F");
         Get_WinQuickSearch_BtnOK().Click();
         var StringClientFictif="~F"
         var NoRacinClient=Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ClientNumber.OleValue;
         
         
         var Res = aqString.Find(NoRacinClient, StringClientFictif);
  if ( Res != -1 ) 
    Log.Error("Substring '" + StringClientFictif + "' was found in string '" + NoRacinClient + "' at position " + Res)
  else
   Log.Checkpoint("There are no occurrences of '" + StringClientFictif + "' in '" + NoRacinClient + "'")

   // Les Points de vérifications pour vérifier qu'aucun client externe n'existe sur la liste
   
    Sys.Keys(".");
         Get_WinQuickSearch_TxtSearch().SetText("~E");
         Get_WinQuickSearch_BtnOK().Click();
         var StringClientFictif="~E"
         var NoRacinClient=Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ClientNumber.OleValue;
         
         
         var Res = aqString.Find(NoRacinClient, StringClientFictif);
  if ( Res != -1 ) 
    Log.Error("Substring '" + StringClientFictif + "' was found in string '" + NoRacinClient + "' at position " + Res)
   
  else
   Log.Checkpoint("There are no occurrences of '" + StringClientFictif + "' in '" + NoRacinClient + "'")

         //var statSelectIsactive=Get_WinPickerWindow_DgvElements().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordSelector", 1], 10).IsActive;
    /*     if(statSelectIsactive == true)
         {
           Log.Error("")
         }
         else Log.Checkpoint("");*/
         //Choisir un client et cliquer sur OK
         Sys.Keys(Client800042);
         Get_WinQuickSearch_TxtSearch().SetText(Client800042);
         Get_WinQuickSearch_BtnOK().Click();
    
         Get_WinPickerWindow_BtnOK().Click();
         
         //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
        Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
        if (!(Get_WinAssignToARelationship().Exists)){
            Log.Error("The 'Assign to a relationship' window was not displayed.");
            return;
        }
        
       
        
         Get_WinAssignToARelationship_BtnYes().Click()
        
         TabAccount800042 = new Array();
         TabAccount800042.push(Account800042FS);
         TabAccount800042.push(Account800042NA);
         TabAccount800042.push(Account800042OB);
        
         
         
         //Vérifier qu'un nouveau client racine est rajouté dans la section sommaire en bas de l'écran.
         
         for(var j = 0; j < 3; j++){
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_3213, 10).Click();
        
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", DetailAccountCROES_3213, 10).Find("OriginalValue", TabAccount800042[j], 10);
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account number " + TabAccount800042[j] + " was not found in the hierarchy panel of the relationship " + relationshipNameCroes_3213 + ".");
        }
        else {
            Log.Checkpoint("The account number " + TabAccount800042[j] + " was found in the hierarchy panel of the relationship " + relationshipNameCroes_3213 + ".");
        }
        
        } 
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(relationshipNameCroes_3213);
        Terminate_CroesusProcess();
        
      
        
    }
}

function test()
{
          var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800239", language+client);
          var rootsBNC_1145=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "rootsBNC_1145", language+client); 
          var relationshipNameCroes_3213=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "relationshipNameCroes_3213", language+client);
          var IACodeCroes_3213=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "IACodeCroes_3213", language+client);
          var NameWindRootClient=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "NameWindRootClient", language+client);
          var DetailAccountCROES_3213=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "DetailAccountCROES_3213", language+client);
          var Client800042=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Client800042", language+client);
          var Account800042FS=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800042FS", language+client);
          var Account800042NA=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800042NA", language+client);
          var Account800042OB=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "Account800042OB", language+client);

          Sys.Keys(".");
         Get_WinQuickSearch_TxtSearch().SetText("~F");
         Get_WinQuickSearch_BtnOK().Click();
         var StringClientFictif="~F"
         var NoRacinClient=Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ClientNumber.OleValue;
         
         
         var Res = aqString.Find(NoRacinClient, StringClientFictif);
  if ( Res != -1 ) 
    Log.Error("Substring '" + StringClientFictif + "' was found in string '" + NoRacinClient + "' at position " + Res)
   
  else
   Log.Checkpoint("There are no occurrences of '" + StringClientFictif + "' in '" + NoRacinClient + "'")

}
