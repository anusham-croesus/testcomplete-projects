//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4278
    
   
    Description :Création d'une relation á partir du module clients par un Click droit / Edition.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-6--V9-croesus-co7x-1_5_565
    
    Date: 04/04/2019
*/

function Regression_Croes_4278_Cli_CreateRellationshipByRightClickAndEdit()
{
  try{ 
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4278", "Croes-4278");
        var clientNum=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4278", language+client);
        var relationshipName=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "relationshipName", language+client);
        var NoRelation=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NoRelation", language+client);
        var clientName=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "clientName", language+client);
  
        //Accès au module client
        Login(vServerClients, userName,psw,language);
        Get_ModulesBar_BtnClients().Click();    
        Get_MainWindow().Maximize();
    
        //Sélectionner le client 300005   
        Search_Client(clientNum);
    
        //Créer une relation à partir du clic droit sur le client
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).ClickR();  
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
  
        //remplir les information dans la fenêtre "Créer une relation"
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88().Click();
        Get_WinDetailedInfo_BtnOK().Click();
  
        //valider que la relation a été ajouté
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 15000);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10), "Exists", cmpEqual, true);   
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10), "VisibleOnScreen", cmpEqual, true);
  
        //mailler la relation vers le module Clients
        SearchRelationshipByName(relationshipName)
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName ,10), Get_ModulesBar_BtnClients());
  
        //valider que seulement le client 300005 existe
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "Exists", cmpEqual, true);   
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "VisibleOnScreen", cmpEqual, true);
        var clientNumDisplay =Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).DataContext.DataItem.ClientNumber.OleValue;
        if (clientNumDisplay ==clientNum )
        Log.Checkpoint("Le client "+clientNum+" est affiché")
        else 
        Log.Error("Un autre numéro de client est affiché")
  
        //retirer le filtre courant 
        var descriptionFilter=Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10).DataContext.FilterDescription.OleValue
        Log.Message(descriptionFilter)
        Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription_BtnRemove(descriptionFilter).Click();
  
        //Les poins de vérifications          
        var existenceFiltre= Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", descriptionFilter], 10);
        if(existenceFiltre.Exists && existenceFiltre.VisibleOnScreen)
        Log.Error("Le filtre n'est pas supprimé");
        else
        Log.Checkpoint("Le filtre est  supprimé")
  
        //Sélectionner le client 300005 dans la liste des clients 
        Search_Client(clientNum);

      
        //Associer une relation à partir du menu EDITION
        Get_ModulesBar_BtnClients().Click();
        Search_Client(clientNum);;
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).Click();
        
        Get_MenuBar_Edit().Click();
        Get_MenuBar_Edit_Relationship().Click();
        Get_MenuBar_Edit_Relationship_JoinToAnExistingRelationship().Click();
  
        //Sélectionner la relation "00000"
        Get_WinPickerWindow_DgvElements().Keys("0"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(NoRelation);
        Get_WinQuickSearch_BtnOK().Click();     
        Get_WinPickerWindow_DgvElements().Find("Value",NoRelation,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
  
        //Vlaider l'affichage de la relation "00000"
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", NoRelation, 10), "Exists", cmpEqual, true);   
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", NoRelation, 10), "VisibleOnScreen", cmpEqual, true);
  
        //mailler la relation vers le module Clients
        SearchRelationshipByNo(NoRelation)
        Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText",NoRelation ,10).Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText",NoRelation ,10), Get_ModulesBar_BtnClients());
  
        //Vérifier que le client 800214 existe pour cette relation
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "Exists", cmpEqual, true);   
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "VisibleOnScreen", cmpEqual, true);
        var clientNumDisplay =Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).DataContext.DataItem.ClientNumber.OleValue;
        if (clientNumDisplay ==clientNum )
        Log.Checkpoint("Le client "+clientNum+" est affiché")
        else 
        Log.Error("Le client "+clientNum+" n'existe pas")
       
        //Rétablir la configuration initiale           
        //Supprimer la relation crééé   
      
        Log.Message("Select a random relationship : '" + relationshipName + "' and click on the Delete button.");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        
        
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete().Click();
        
        //Vérifier que la fenêtre de confirmation de suppression est affichée
        Log.Message("Verify that The 'Confirm Action' dialog box is displayed.");
        if (!(Get_DlgConfirmation().Exists)){
        Log.Error("The 'Confirmation' dialog box not displayed. This is not expected.");
        return;
        }
        
        Log.Checkpoint("The 'Confirmation' dialog box displayed.");
        
        //Confirmer avec OK
        Log.Message("Confirm the deletion action by clicking on OK button.");
        Log.Message("La fenêtre de confirmation de suppression de relation est différente entre BNC et US CROES-7871 ");
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //Vérifier si la suppression a été effectuée
        Log.Message("Verify that '" + relationshipName + "' relationship was actually deleted.");
        var relationshipSearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        Log.Message("CROES-7871")
        if (relationshipSearchResult.Exists){
        Log.Error("'" + relationshipName + "' relationship not deleted. This is not expected.");
        }
        else {
        Log.Checkpoint("'" + relationshipName + "' relationship deleted.");
        }  
                  
        //Retirer la relation du client
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByNo(NoRelation);
        Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText",NoRelation ,10).Click();
        Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 500);
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Value",clientName,10).ClickR();
        //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Value",clientName,10).ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().WaitProperty("VisibleOnScreen", true, 10000);
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click(); 
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 500);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
       
        
  }
   catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
  
}

