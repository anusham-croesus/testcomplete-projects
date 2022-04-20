//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                     Lorsque l'option 'Utiliser l'information de l'interlocuteur' est activée (lorsqu'un interlocuteur est choisi), 
                     les adresses courriels du client sont affichées dans la section Courriels de la relation. Ce comportement n'est pas valide.

                  Comportement attendu: Les adresses, téléphones et courriels de l'interlocuteur doivent être affichés uniquement dans la section Information de 
                  l'interlocuteur et ne doivent pas être affichés dans les sections Adresses, Téléphones et Courriels qui sont réservées à l'information de la relation.

                  Note pour tester l'anomalie: Il faut cliquer sur OK pour fermer la fenêtre Info Relation puis l'ouvrir à nouveau pour rafraîchir la section Courriels.
                   (Le bouton Appliquer ne permet pas de rafraîchir cette section.)
    Auteur : Sana Ayaz
    Anomalie:CROES-1441
    Version de scriptage:ref90-07-23
*/
function CROES_1441_UseCalInforOptionEnablCustEmailisDisplaInEmaiSect()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        var AdressStreetCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "AdressStreetCROES1441", language+client);
        var AdressCityProvCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "AdressCityProvCROES1441", language+client);
        var AdressPostalCodCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "AdressPostalCodCROES1441", language+client);
        var AdressCountryCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "AdressCountryCROES1441", language+client);
        var TelephonCmTypCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "TelephonCmTypCROES1441", language+client);
        var TelephonNumberCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "TelephonNumberCROES1441", language+client);
        var EmailCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "EmailCROES1441", language+client);
        var clientNumberCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "clientNumberCROES1441", language+client);
        var BugCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "BugCROES1441", language+client);
   
        
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        var NameRelationCROES1441=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NameRelationCROES1441", language+client);
       
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(NameRelationCROES1441);

        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelationCROES1441, 10).DblClick();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
        // Ajout d'une adresse a la relation
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
        Get_WinCRUAddress_CmbType().set_IsDropDownOpen(true);
        Get_WinCRUAddress_CmbType_ItemHome().Click();
        Get_WinCRUAddress_TxtStreet1().set_Text(AdressStreetCROES1441);
        Get_WinCRUAddress_TxtCityProv().set_Text(AdressCityProvCROES1441);
        Get_WinCRUAddress_TxtPostalCode().set_Text(AdressPostalCodCROES1441);
        Get_WinCRUAddress_TxtCountry().set_Text(AdressCountryCROES1441);
        Get_WinCRUAddress_BtnOK().Click();  
        //Ajout d'un numéro de téléphone a la relation
    
        Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click();
        Get_WinCRUTelephone_CmbType().set_Text(TelephonCmTypCROES1441);
        Get_WinCRUTelephone_TxtNumber().set_Text(TelephonNumberCROES1441);
        Get_WinCRUTelephone_BtnOK().Click();
    
        //Ajout une adresse émail a la relation
  
        Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.set_Email(EmailCROES1441);
    
        Get_WinDetailedInfo_BtnApply().Click();
    
        //Choisir l'onglet info
        Get_WinDetailedInfo_TabInfo().Click();
       //Ajouter un representative 
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship().Click();
        Sys.Keys(clientNumberCROES1441);
        Get_WinTransactionsQuickSearch_TxtSearch().SetText(clientNumberCROES1441);
        Get_WinTransactionsQuickSearch_BtnOK().Click();
        
        if (client == "CIBC")
            Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView_BtnOK().Click();
        else
            Get_WinClients_BtnOK().Click();
        
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
        
       /* Get_WinDetailedInfo_BtnOK().Click();
        
         SearchRelationshipByName(NameRelationCROES1441);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelationCROES1441, 10).DblClick();*/
         //Choisir l'onglet adresse
       Get_WinDetailedInfo_TabAddresses().Click();
       Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
       if(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().IsChecked == false)
       Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().Click();
       else
       Log.Message("La case a côché Use the representative information est déja côchée")
       Get_WinDetailedInfo_BtnOK().Click();
       
       // Ouvrir de nouveau la fenêtre info relation
       SearchRelationshipByName(NameRelationCROES1441);
       Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelationCROES1441, 10).DblClick();
       
       //Choisir l'onglet Adresse
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_9b70",15000);
       
        //Les points de vérifications        
        var adressEmailDisplay=Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Email.OleValue
     
          if(adressEmailDisplay == EmailCROES1441 )
 
         {
           Log.Checkpoint("L'adresse émail affichée est celle de la relation")
         }
           else 
         Log.Error("C'est pas la bonne adresse émail qui est affichée. L'anomalie est : "+BugCROES1441)
       
          Get_WinDetailedInfo_BtnOK().Click();
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(NameRelationCROES1441);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelationCROES1441, 10).DblClick();
        
       if(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient().IsChecked == true)
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient().Click();
        else
        Log.Message("La case a côché Representative n'est pas côchée");

        Get_WinDetailedInfo_BtnApply().Click();
        Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 3000);
        
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
       if(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().IsChecked == true)
            Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().Click();
       else
       Log.Message("La case a côché Use the representative information est déja côchée")
       //Suppression de l'adresse, téléphone et adresse courriels
       Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click()
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
       
       Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete().Click();
       
       Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.set_Email("");
       
       Get_WinDetailedInfo_BtnOK().Click();
       Terminate_CroesusProcess();
       
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(NameRelationCROES1441);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelationCROES1441, 10).DblClick();
        
       if(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient().IsChecked == true)
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient().Click();
        else
        Log.Message("La case a côché Representative n'est pas côchée");

        Get_WinDetailedInfo_BtnApply().Click();
        Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 10000);
        
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().Click();
        Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
       if(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().IsChecked == true)
            Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship().Click();
       else
       Log.Message("La case a côché Use the representative information est déja côchée")
       //Suppression de l'adresse, téléphone et adresse courriels
       Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click()
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
       
       Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete().Click();
       
       Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.set_Email("");
       
       Get_WinDetailedInfo_BtnOK().Click();
       Terminate_CroesusProcess();
       
    }
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView_BtnOK(){
    return Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
    
  
function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView(){
  
    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniDialog", "Root clients"], 20)
}