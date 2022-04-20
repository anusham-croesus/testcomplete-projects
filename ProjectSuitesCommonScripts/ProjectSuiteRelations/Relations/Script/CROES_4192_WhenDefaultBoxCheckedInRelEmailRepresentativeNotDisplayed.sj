//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CROES_1441_UseCalInforOptionEnablCustEmailisDisplaInEmaiSect

/**
    Description :
                    La case "Défaut" peut être cochée dans l'adresse courriel de la relation et ce, même si elle est aussi cochée dans l'addresse
                     de l'Interlocuteur (voir fichier Excel attaché avec les screenshots) 
                     Le résultat est que le courriel n'apparaît pas dans la colonne Courriel 1 dans le module Relations.

                    Le workaround est de décocher "Utiliser l'information de l'Interlocuteur", décocher la case Défaut de la relation, et recocher la case "Utiliser..."
                   
                    Auteur : Abdel Matmat
                    Version de scriptage:ref90-07-23
                    Numéro de l'anomalie sur JIRA : CROES-4192
                    Mise à jour du script: 03/05/2019 sur la version 90.10.Fm-11
    
*/
function CROES_4192_WhenDefaultBoxCheckedInRelEmailRepresentativeNotDisplayed(){
        try {   
                Log.Link("https://jira.croesus.com/browse/CROES-4192", "Cas de tests JIRA CROES-4192");
                 
                var relationshipName_CROES_4192 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipName_CROES_4192", language+client);
                var clientNumber_CROES_4192 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "clientNumber_CROES_4192", language+client);
                var IACode_CROES_4192 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "IACode_CROES_4192", language+client);
                var EmailOriginal_CROES_4192 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "EmailOriginal_CROES_4192", language+client);
                var EmailModif_CROES_4192 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "EmailModif_CROES_4192", language+client);
                var emailLabel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "emailLabel", language+client);
        
        
                Login(vServerRelations, userName, psw, language);
        
                //Créer une relation et l'associé un client
                CreateRelationship(relationshipName_CROES_4192,IACode_CROES_4192);
                
                Get_ModulesBar_BtnRelationships().Click();
                WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                /*
                //Verifier que la case a cocher Email est cochee 
                Log.Message("-------- Check that the checkbox of first Email is checked -------------");
                //Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient.WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Courriels", 3).WPFObject("_currentControl").WPFObject("_emailsEditorGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1) 
                var checkBox = Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1) 
                aqObject.CheckProperty(checkBox, "IsChecked", cmpEqual,true);
                */
                //Changer l'email dans la section courriel
                Log.Message("Modify the Email for relationship");
                SearchRelationshipByName(relationshipName_CROES_4192);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CROES_4192, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                Get_WinDetailedInfo_TabAddresses().Click();
                Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
                
                Log.Message("-------- Check that the checkbox of first Email is checked -------------");
                //Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient.WPFObject("ClassicTabControl", "", 1).WPFObject("UniGroupBox", "Courriels", 3).WPFObject("_currentControl").WPFObject("_emailsEditorGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1) 
                var checkBox = Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1) 
                aqObject.CheckProperty(checkBox, "IsChecked", cmpEqual,true);
                
                Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.set_Email(EmailModif_CROES_4192);
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Ajouter la colonne Courriel1
                Add_ColumnByLabel(Get_RelationshipsGrid_ChTotalValue(),emailLabel);
                //Vérifier que le nouveau courriel s'affiche dans la grille relation
                Log.Message("-------- Check new Email in relationship grid -------------");
                CheckEmailInRelationshipsGrid(relationshipName_CROES_4192,EmailModif_CROES_4192);
                
                Log.Message("Join the client " + clientNumber_CROES_4192 + " to the relationship " + relationshipName_CROES_4192 + ".");
                SearchRelationshipByName(relationshipName_CROES_4192);
                var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CROES_4192, 10);
                if (searchResultRelationship.Exists == false){
                    Log.Error("The relationship " + relationshipName_CROES_4192 + " was not displayed.");
                    return;
                }
        
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CROES_4192, 10).Click();
                Get_Toolbar_BtnAdd().Click();
                WaitObject(Get_CroesusApp(),"Uid","ContextMenu_8804");
                Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
                WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf");
        
                //Vérifier que la fenêtre Clients est ouverte
                Log.Message("Verify that he picker window is displayed.");
                if (!(Get_WinPickerWindow().Exists)){
                    Log.Error("The picker window was not displayed.");
                    return;
                }
        
                aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 10, language));
        
                //Choisir un client et cliquer sur OK
                Sys.Keys(clientNumber_CROES_4192);
                Get_WinQuickSearch_TxtSearch().SetText(clientNumber_CROES_4192);
                Get_WinQuickSearch_BtnOK().Click();
    
                Get_WinPickerWindow_BtnOK().Click();
        
                //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
                Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
                if (!(Get_WinAssignToARelationship().Exists)){
                    Log.Error("The 'Assign to a relationship' window was not displayed.");
                    return;
                }
                Log.Message("CROES-8807")
                aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 11, language)); //EM : le datapool a été modifié selon le Jira CROES-8807 - avant "Associer à une nouvelle relation"
        
                Get_WinAssignToARelationship_BtnYes().Click()
                
                SearchRelationshipByName(relationshipName_CROES_4192);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CROES_4192, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
        
                //Ajouter un interlocuteur à la relation
                Log.Message("Add a representative "+clientNumber_CROES_4192 + " to the relationship "+relationshipName_CROES_4192);
                Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship().Click();
                WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
                
                if (client == "CIBC")
                    Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView_BtnOK().Click();
                else
                    Get_WinClients_BtnOK().Click();
                
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
                //Get_WinDetailedInfo_BtnApply().Click();
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Vérifier que la relation a pris l'@ courriel de l'interlocuteur dans la grille
                Log.Message("------ Check Email Address in Relationship grid --------------");
                CheckEmailInRelationshipsGrid(relationshipName_CROES_4192,EmailOriginal_CROES_4192);
                
                //Décocher la case à cocher 'Utiliser les infos de l'interlocuteur'
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CROES_4192, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                Get_WinDetailedInfo_TabAddresses().Click();
                Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
                if(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().IsChecked )
                    Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().Click();
                //Get_WinDetailedInfo_BtnApply().Click();
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Vérifier que le nouveau courriel s'affiche dans la grille relation
                Log.Message("-------- Check new Email in relationship grid -------------");
                CheckEmailInRelationshipsGrid(relationshipName_CROES_4192,EmailModif_CROES_4192);
               
        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
                        
        }
        finally {
                //Set the default configuration
                Log.Message("----- Set the default configuration of columns --------");
                SetDefaultConfiguration(Get_RelationshipsGrid_ChTotalValue());
                
                //Supprimer la relation créée
                DeleteRelationship(relationshipName_CROES_4192);
                
                //Fermer l'application                
                Terminate_CroesusProcess();
        }
        
}

function CheckEmailInRelationshipsGrid(relationshipName,email)
{
    SearchRelationshipByName(relationshipName);
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    for (i=0;i<count;i++){
         if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ShortName == relationshipName){
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "Email1", cmpEqual,email);
              break;
         }
    }
}


