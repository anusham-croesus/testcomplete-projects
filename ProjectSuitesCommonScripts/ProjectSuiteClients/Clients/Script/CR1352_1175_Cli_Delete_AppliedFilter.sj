//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA
//USEUNIT CR1352_1169_Cli_Create_UserAccessFilter

/* Description :Création de filtres dont le niveau d’accès est utilisateur
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1169
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

// MAJ: Pierre Lefebvre (June 15, 2021)
//      --> Le message contenu dans la confirmation a changé entre 90.24.2024.04 et 90.26. Ceci est addressé en validant avec le premier message puis le deuxième.
//          In order to keep this script straighforward, it validates the displayed message to the first expected message. If the match is confirmed, a Pass is
//          associated to the Checkpoint. If the match is not confirmed, the displayed message is validate against the second expected message.
//          If the match is then confirmed, a Pass is associated to the Checkpoint otherwise, a Fail is associated to the Checkpoint.
 
function CR1352_1175_Cli_Delete_AppliedFilter()
{
  try
  { 
    var filtre="Filtre_Utilisateur";
    var expectedConfirmationMessagePreviousVersion = GetData(filePath_Clients, "CR1352", 89, language); // Message prior to 90.26
    var expectedConfirmationMessageCurrentVersion = GetData(filePath_Clients, "CR1352", 90, language);  // Message since 90.26
    var actualConfirmationMessage = "";
             
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
             
    // Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 

    Create_UserAccessFilter(filtre);   
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filtre,10).Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
        
    // Vérification 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filtre);   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif 1- Le filtre est actif
        
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value", filtre, 10).Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete().Click();
             
    // Validate the confirmation message when attempting to delete an active filter.
    // There are 2 versions of the confirmation message for the same action as the text has been updated during 90.26.
    // In order to keep this script straighforward, it validates the displayed message to the first expected message.
    // If the match is confirmed, a Pass is associated to the Checkpoint.
    // If the match is not confirmed, the displayed message is validate against the second expected message.
    // If the match is confirmed, a Pass is associated to the Checkpoint otherwise, a Fail is associated to the Checkpoint.
    actualConfirmationMessage = Get_DlgConfirmation_LblMessage().Message.OleValue;

    if (actualConfirmationMessage == expectedConfirmationMessagePreviousVersion)
    {
      Log.Checkpoint("Validating confirmation dialog text with: '" + expectedConfirmationMessagePreviousVersion + "'. The dialog text is the expected string.");
    }
    else if (actualConfirmationMessage == expectedConfirmationMessageCurrentVersion)
    {
      Log.Checkpoint("Validating confirmation dialog text with: '" + expectedConfirmationMessageCurrentVersion + "'. The dialog text is the expected string.");           
    }
    else
    {
      Log.Error("The confirmation dialog text is neither '" + expectedConfirmationMessagePreviousVersion + "' or '" + expectedConfirmationMessageCurrentVersion + "'.");
    }
  
    //aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpMatches, GetData(filePath_Clients,"CR1352",89,language));   

    //Cliquer sur NO dans le message
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth() * (2/3), Get_DlgConfirmation().get_ActualHeight() - 45);
        
    // Vérifier que le filtre n’a pas été supprimé 
    Check_IfFilterSavedInManageFilters(filtre);
        
    // Cliquer sur Supprimer dans le message 
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value", filtre, 10).Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete().Click();
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth() / 3, Get_DlgConfirmation().get_ActualHeight() - 45);
        
    // Vérifier que le filtre a été supprimé 
    var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
    var findFilter=false;
    
    for (i=0; i<= count-1; i++)
    { 
      if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description() == filtre)
      {
        findFilter=true;             
        break;             
      }             
    }
     
    if (findFilter==true)
    {
      Log.Error("Le filtre est sur la liste ");
    }
    else
    {
      Log.Checkpoint("Le filtre n'est pas sur la liste ");  
    }
                      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();  
        
    // Vérifier le nombre filtres affichés  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 0);
               
    Get_MainWindow().SetFocus();
    Close_Croesus_X();                  
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Delete_FilterCriterion(filtre,  vServerClients) // Supprimer le filtre de BD   
  }
}