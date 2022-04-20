//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1360_ValidateInformationOfInterlocutorIsNotUsedInRelationship

/**
    CR                  : 1360
    Cas de test         : CROES-6258
    Description         : Valider que l'info de l'interlocuteur est utilisé dans la relation
                          Valider l'Information de l'interlocuteur dans la fenêtre Info Relation (onglet Adresses) lorsqu'un interlocuteur est sélectionné 
                          et l'information de l'interlocuteur est utilisée.
                      
    Auteur              : Abdel Matmat
    Version de scriptage: 90-10-7
    Date                : 11-03-2019
    
*/
function CR1360_ValidateInformationOfInterlocutorIsUsedInRelationship(){
       
        try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6258","Lien du Cas de test sur Testlink");
                
                var userNameDarwic = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
                var passwordDarwic = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
                
                var relationshipName_CR1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "relationshipName_CR1360", language+client);
                var AdrType_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "AdrType_1360", language+client);
                var Street1_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Street1_1360", language+client);
                var Street2_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Street2_1360", language+client);
                var City_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "City_1360", language+client);
                var PCode_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "PCode_1360", language+client);
                var Number_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Number_1360", language+client);
                var Email_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Email_1360", language+client);
                var clientNumber3_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "clientNumber3_1360", language+client);
                var Representative1_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Representative1_1360", language+client);
                var Street800262_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Street800262_1360", language+client);
                var City800262_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "City800262_1360", language+client);
                var PCode800262_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "PCode800262_1360", language+client);
                var Tel800262_1_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Tel800262_1_1360", language+client);
                var Number800262_1_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Number800262_1_1360", language+client);
                var Tel800262_2_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Tel800262_2_1360", language+client);
                var Number800262_2_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Number800262_2_1360", language+client);
                var Tel800262_3_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Tel800262_3_1360", language+client);
                var Number800262_3_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Number800262_3_1360", language+client);
                var Email_800262_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Email_800262_1360", language+client);
                
                
                //Se connecter à l'application
                Login(vServerRelations, userNameDarwic, passwordDarwic, language);                
                Get_ModulesBar_BtnRelationships().Click();
                WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                
                //Acceder à l'onglet Adresse de la relation créée
                SearchRelationshipByName(relationshipName_CR1360);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1360, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                
                //Ajouter un interlocuteur à la relation
                Log.Message("Add a representative "+clientNumber3_1360 + " to the relationship "+relationshipName_CR1360);
                Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship().Click();
                WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
                
                if (client == "CIBC"){
                    Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView().Find("Text",clientNumber3_1360, 10).Click();
                    Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView_BtnOK().Click();
                }
                else{
                    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
                    Get_WinClients().Find("Text",clientNumber3_1360, 10).Click();
                    Get_WinClients_BtnOK().Click();
                }
                                
                if (language == "french" ) 
                    Get_DlgConfirmation().Find("WPFControlText","Oui",10).Click();
                else 
                    Get_DlgConfirmation().Find("WPFControlText","Yes",10).Click();
        
                Get_WinDetailedInfo_BtnApply().Click();
                Get_WinDetailedInfo_BtnApply().WaitProperty("IsFocusable", true, 10000);
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Valider la valeur de l'interlocuteur de la relation
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0;i<count;i++){
                  if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ShortName == relationshipName_CR1360 ){
                      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "Representative", cmpEqual, Representative1_1360);
                      break;
                  }
                }
                
                //Valider que les infos de l'interlocuteur 800262 sont affichés dans Détails/info
                CheckInfoRelationship800262(relationshipName_CR1360,Street800262_1360,City800262_1360,PCode800262_1360,Tel800262_1_1360,Number800262_1_1360,Tel800262_2_1360,Number800262_2_1360,Tel800262_3_1360,Number800262_3_1360,Email_800262_1360);
                
                //Selectionner la relation et décocher la case utiliser l'information de l'interlocuteur
                SearchRelationshipByName(relationshipName_CR1360);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1360, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");               
                Get_WinDetailedInfo_TabAddresses().Click();
                Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
                if(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().IsChecked )
                    Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().Click();
                else
                    Log.Message("La case a côché Use the representative information n'est pas côchée")
                Get_WinDetailedInfo_BtnApply().Click();
                Get_WinDetailedInfo_BtnApply().WaitProperty("IsFocusable", true, 10000);
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Points de vérification
                //Valider la valeur de l'interlocuteur de la relation
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0;i<count;i++){
                  if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ShortName == relationshipName_CR1360 ){
                      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "Representative", cmpEqual, Representative1_1360);
                      break;
                  }
                }
                
                //Valider les infos de la relation sont affichées
                CheckInfoRelationship(relationshipName_CR1360,Street1_1360,Street2_1360,City_1360,PCode_1360,AdrType_1360,Number_1360,Email_1360);
               
        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                //Supprimer la relation créée
                DeleteRelationship(relationshipName_CR1360);
                
                //Mettre la configuration par défaut des colonnes
                SetDefaultConfiguration(Get_RelationshipsGrid_ChCurrency());
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();              
        }   
}

function CheckInfoRelationship800262(relationshipName,Street,City,PCode,Tel1,Number1,Tel2,Number2,Tel3,Number3,Email){
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_33ab",100), "Text", cmpEqual,relationshipName );
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_2303",100), "Text", cmpEqual,Street);
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_12b7",100), "Text", cmpEqual,City);
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_af1b",100), "Text", cmpEqual,PCode); 
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 100).Text, "OleValue", cmpEqual,Tel1 );
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 100).Text, "OleValue", cmpEqual,Tel1 );
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 2], 100), "Text", cmpEqual,Number1 );
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 2], 100).Text, "OleValue", cmpEqual,Number1 );
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 2).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 100).Text, "OleValue", cmpEqual,Tel2 );
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 3], 100).Text, "OleValue", cmpEqual,Tel2 );
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 2).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 2], 100), "Text", cmpEqual,Number2 );
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 4], 100).Text, "OleValue", cmpEqual,Number2 );
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 100).Text, "OleValue", cmpEqual,Tel3 );
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 5], 100).Text, "OleValue", cmpEqual,Tel3 );
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 2], 100), "Text", cmpEqual,Number3);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 6], 100).Text, "OleValue", cmpEqual,Number3 );
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_2002",100), "Text", cmpEqual,Email );
}

  function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView(){ 
    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Root clients"], 20)
}
 function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView_BtnOK(){
    return Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
 
