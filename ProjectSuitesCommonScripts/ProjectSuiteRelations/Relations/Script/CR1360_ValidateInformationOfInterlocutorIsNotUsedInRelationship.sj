//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    CR                  : 1360
    Cas de test         : CROES-6257
    Description         : Valider que l'info de l'interlocuteur n'est pas utilisé dans la relation
                          Valider l'Information de l'interlocuteur dans la fenêtre Info Relation (onglet Adresses) lorsqu'un interlocuteur est sélectionné 
                          mais que l'information de l'interlocuteur n'est pas utilisée. 
                      
    Auteur              : Abdel Matmat
    Version de scriptage: 90-10-7
    Date                : 06-03-2019
    
*/
function CR1360_ValidateInformationOfInterlocutorIsNotUsedInRelationship(){
       
        try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6257","Lien du Cas de test sur Testlink");
                
                var userNameDarwic = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
                var passwordDarwic = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
                
                var relationshipName_CR1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "relationshipName_CR1360", language+client);
                var AdrType_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "AdrType_1360", language+client);
                var Street1_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Street1_1360", language+client);
                var Street2_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Street2_1360", language+client);
                var City_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "City_1360", language+client);
                var PCode_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "PCode_1360", language+client);
                var Country_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Country_1360", language+client);
                var Number_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Number_1360", language+client);
                var Email_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Email_1360", language+client);
                var clientNumber1_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "clientNumber1_1360", language+client);
                var clientNumber2_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "clientNumber2_1360", language+client);
                var clientNumber3_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "clientNumber3_1360", language+client);
                var Representative_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "Representative_1360", language+client);
                var RepresentativeColumn_1360 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1360", "RepresentativeColumn_1360", language+client);
                
                //Se connecter à l'application
                Login(vServerRelations, userNameDarwic, passwordDarwic, language);
        
                //Créer une relation et l'associé un client
                CreateRelationship(relationshipName_CR1360);
                
                Get_ModulesBar_BtnRelationships().Click();
                WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                
                //Acceder à l'onglet Adresse de la relation créée
                SearchRelationshipByName(relationshipName_CR1360);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1360, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                Get_WinDetailedInfo_TabAddresses().Click();
                
                //Ajouter les informations de la section Adresses
                AddAdress_GrpAdresses(Street1_1360,Street2_1360,City_1360,PCode_1360,Country_1360);
                
                //Ajouter les informations de la section Téléphones
                AddAdress_GrpTelephones(AdrType_1360,Number_1360);
                
                //Ajouter les informations de la section Courriels
                AddEmail_GrpEmails(Email_1360);
                
                //Cliquer Ok
                Get_WinDetailedInfo_BtnApply().Click();
                Get_WinDetailedInfo_BtnApply().WaitProperty("IsFocusable", true, 10000);
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Valider que la relation est créée avec les informations dans détails/onglet info
                CheckInfoRelationship(relationshipName_CR1360,Street1_1360,Street2_1360,City_1360,PCode_1360,AdrType_1360,Number_1360,Email_1360);
                
                //Associer les Clients 800260, 800261, 800262à la relation
                SearchRelationshipByName(relationshipName_CR1360);
                var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1360, 10);
                if (searchResultRelationship.Exists == false){
                    Log.Error("The relationship " + relationshipName_CROES_4192 + " was not displayed.");
                    return;
                }
        
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1360, 10).Click();
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
        
                //Choisir les 3 clients et cliquer sur OK
                Sys.Keys(clientNumber1_1360);
                Get_WinQuickSearch_TxtSearch().SetText(clientNumber1_1360);
                Get_WinQuickSearch_BtnOK().Click();
                Get_WinPickerWindow().Find("Value",clientNumber1_1360,10).Click();
                Get_WinPickerWindow().Find("Value",clientNumber2_1360,10).Click(-1, -1, skCtrl);
                Get_WinPickerWindow().Find("Value",clientNumber3_1360,10).Click(-1, -1, skCtrl);
    
                Get_WinPickerWindow_BtnOK().Click();
        
                //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
                Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
                if (!(Get_WinAssignToARelationship().Exists)){
                    Log.Error("The 'Assign to a relationship' window was not displayed.");
                    return;
                }
                aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 11, language)); //EM : le datapool a été modifié selon le Jira CROES-8807 - avant "Associer à une nouvelle relation"
        
                Get_WinAssignToARelationship_BtnYes().Click();
                
                //Acceder à la fenetre info de la relation
                SearchRelationshipByName(relationshipName_CR1360);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1360, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                        
                //Ajouter un interlocuteur à la relation
                Log.Message("Add a representative "+clientNumber1_1360 + " to the relationship "+relationshipName_CR1360);
                Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship().Click();
                
                if (client == "CIBC"){
                    Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView().Find("Text",clientNumber1_1360, 10).Click();
                    Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView_BtnOK().Click();
                }
                else{
                    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
                    Get_WinClients().Find("Text",clientNumber1_1360, 10).Click();
                    Get_WinClients_BtnOK().Click();
                }
                
                if (language == "french" ) Get_DlgConfirmation().Find("WPFControlText","Non",10).Click();
                else Get_DlgConfirmation().Find("WPFControlText","No",10).Click();
        
                Get_WinDetailedInfo_BtnApply().Click();
                Get_WinDetailedInfo_BtnApply().WaitProperty("IsFocusable", true, 10000);
                Get_WinDetailedInfo_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Ajouter la colonne interlocuteur dans le browser
                Add_ColumnByLabel(Get_RelationshipsGrid_ChCurrency(),RepresentativeColumn_1360);
                
                //Valider la valeur de l'interlocuteur de la relation
                var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
                for (i=0;i<count;i++){
                  if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ShortName == relationshipName_CR1360 ){
                      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "Representative", cmpEqual, Representative_1360);
                      break;
                  }
                }
                
                //Valider les informations dans détails/ info
                CheckInfoRelationship(relationshipName_CR1360,Street1_1360,Street2_1360,City_1360,PCode_1360,AdrType_1360,Number_1360,Email_1360);
        }                
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();              
        }   
}

function AddAdress_GrpAdresses(Street1,Street2,City,PCode,Country){
  
        // Ajout d'une adresse a la relation
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
        Get_WinCRUAddress_CmbType().set_IsDropDownOpen(true);
        Get_WinCRUAddress_CmbType_ItemHome().Click();
        Get_WinCRUAddress_TxtStreet1().set_Text(Street1);
        Get_WinCRUAddress_TxtStreet2().set_Text(Street2);
        Get_WinCRUAddress_TxtCityProv().set_Text(City);
        Get_WinCRUAddress_TxtPostalCode().set_Text(PCode);
        Get_WinCRUAddress_TxtCountry().set_Text(Country);
        Get_WinCRUAddress_BtnOK().Click();  
}

function AddAdress_GrpTelephones(AdrType,Number){
    
        //Ajout d'un numéro de téléphone a la relation
        Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click();
        Get_WinCRUTelephone_CmbType().set_Text(AdrType);
        Get_WinCRUTelephone_TxtNumber().set_Text(Number);
        Get_WinCRUTelephone_BtnOK().Click(); 
}

function AddEmail_GrpEmails(Email){
    var EmailField = Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).WPFObject("XamTextEditor", "", 1);
    EmailField.Click();
    EmailField.Set_Text(Email);
}

function CheckInfoRelationship(relationshipName,Street1,Street2,City,PCode,AdrType,Number,Email){
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_33ab",100), "Text", cmpEqual,relationshipName );
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_2303",100), "Text", cmpEqual,Street1);
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_12b7",100), "Text", cmpEqual,Street2);
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_a890",100), "Text", cmpEqual,City);
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_af1b",100), "Text", cmpEqual,PCode); 
    //aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 100).Text, "OleValue", cmpEqual,AdrType+":" );
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 100).Text, "OleValue", cmpEqual,AdrType+":" );
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","InfoPage_f5b9",100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 2], 100), "Text", cmpEqual,Number );
    aqObject.CheckProperty(Get_CroesusApp().Find("Uid","TextBox_2002",100), "Text", cmpEqual,Email );
}

//Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.      bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("TextBlock", "Home:", 1)

//************************************* Fonctions liés à l'ajout d'adresse, téléphone dans info relation onglet Adresses ***********************
 /* function Get_WinDetailedInfo_WinAddAdress(){ 
          if (language == "french") return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Ajouter une adresse"], 10);
          else return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Add Address"], 10);
  }
  function Get_WinDetailedInfo_WinAddAdress_CmbType(){ return Get_WinDetailedInfo_WinAddAdress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)} 
  function Get_WinDetailedInfo_WinAddAdress_Txt1Street(){return Get_WinDetailedInfo_WinAddAdress().WPFObject("UniGroupBox", "", 1).WPFObject("UniTextField", "", 1)}
  function Get_WinDetailedInfo_WinAddAdress_Txt2Street(){return Get_WinDetailedInfo_WinAddAdress().WPFObject("UniGroupBox", "", 1).WPFObject("UniTextField", "", 2)}
  function Get_WinDetailedInfo_WinAddAdress_TxtCity(){return Get_WinDetailedInfo_WinAddAdress().WPFObject("UniGroupBox", "", 1).WPFObject("UniTextField", "", 4)}
  function Get_WinDetailedInfo_WinAddAdress_TxtPCode(){return Get_WinDetailedInfo_WinAddAdress().WPFObject("UniGroupBox", "", 1).WPFObject("UniTextField", "", 5)}
  function Get_WinDetailedInfo_WinAddAdress_TxtCountry(){return Get_WinDetailedInfo_WinAddAdress().WPFObject("UniGroupBox", "", 1).WPFObject("UniTextField", "", 6)}
  function Get_WinDetailedInfo_WinAddAdress_BtnOk(){return Get_WinDetailedInfo_WinAddAdress().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10);}
  function Get_WinDetailedInfo_WinAddTelephone(){
          if (language == "french") return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Ajout d'un téléphone"], 10);
          else return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Add Telephone"], 10);
  }
  function Get_WinDetailedInfo_WinAddTelephone_TxtNumber(){return Get_WinDetailedInfo_WinAddTelephone().WPFObject("UniGroupBox", "", 1).WPFObject("UniTextField", "", 1)}
  function Get_WinDetailedInfo_WinAddTelephone_BtnOk(){return Get_WinDetailedInfo_WinAddTelephone().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10);}
  
  
  */
    
  function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView(){ 
    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Root clients"], 20)
}
 function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView_BtnOK(){
    return Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
 
 
 function test(){
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin().bottomGroupBox.zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("ScrollViewer", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 100).Text, "OleValue", cmpEqual,"Home:" );  
 }