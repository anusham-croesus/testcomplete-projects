//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
  Description : recherche avec les filtres
  
  Regrouper les scripts suivants:
  Regression_Croes_6271_Cli_ValidateSearchClientsModule
  Regression_Croes_4261_Cli_AddEditDeleteClientsAdresses
  Regression_Croes_4271_Cli_AddEditDeleteClientsPhoneNumber
  Regression_Croes_4272_Cli_EsitEmailAdresses
  Regression_Croes_4283_Cli_DeleteSelectedClients
  Regression_Croes_4278_Cli_CreateRellationshipByRightClickAndEdit   
  + Validation du Jira FEDS-875 - Crash dans la fenêtre info client lors de la suppression ou l'ajout d'une adresse courriel.
  
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-19-2020-09-45
*/

// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> Application du workaround (fermer et réouvrir la fenêtre Info Clients) pour que l'indexation interne des addresses courriels soit réétablie.
//

function Regression_OptiCroes_6271_4261_4271_4272_4283_4278()
{

  try{        

    Log.Message("se connercter avec Copern");
    Login(vServerClients, userName,psw,language);
    
    /********************************** Étape 1 : Valider la recherche dans le module Clients. **********************************/
    Log.AppendFolder("Étape 1: Croes-6271 - Valider la recherche dans le module Clients.");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6271", "Cas de test TestLink: Croes-6271");  
    /**********************************************************************************************************************************************************************/
    
    var nomClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameClient", language+client);
    var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "IACode", language+client);
    var numTel=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "TelNumber", language+client);
    var nomClientTel=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientPhone", language+client);
    var NoClientTel=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNo_4399", language+client);//800249
      
    Log.Message("Choisir le module client"); 
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);    
    Get_MainWindow().Maximize();      
        
    Log.Message("Lancer la recheche par le nom du client "+nomClient)
    Get_RelationshipsClientsAccountsGrid().Keys("J");
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(nomClient); 
      
    Log.Message("Valider l'affichage de la fenêtre recherche et le radio Nom coché");
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "Text", cmpEqual,nomClient);
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoName(),"IsChecked", cmpEqual,true);
    Get_WinQuickSearch_BtnOK().Click();
    
    Log.Message("Valider l'affichage du curseur devant le client "+nomClient);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",nomClient, 10 ).DataContext, "IsActive", cmpEqual, true);  
    
    Log.Message("Lancer la recherche pour le code de CP "+codeCP);
    Get_RelationshipsClientsAccountsGrid().Keys("B");
    Get_WinQuickSearch_TxtSearch().SetText(codeCP);    
    Get_WinQuickSearch_RdoIACode().Click();
    
    Log.Message("Valider que le critère Code de CP est coché et "+codeCP+" dans le champ rechercher");
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "Text", cmpEqual,codeCP);
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoIACode(),"IsChecked", cmpEqual,true);
    Get_WinQuickSearch_BtnOK().Click();
    
    Log.Message("Valider que le curseur se place sur le code de CP "+codeCP);
    var CpBD88= Get_RelationshipsClientsAccountsGrid().Find("IsActive", true, 10).DataContext.DataItem.RepresentativeNumber.OleValue
    CheckEquals(CpBD88, codeCP, "IACode");
    
    Log.Message("Lancer la recherche pour le Téléphone 1");    
    Get_RelationshipsClientsAccountsGrid().Keys("A");
    Get_WinQuickSearch_TxtSearch().SetText(numTel);    
    Get_WinClientsQuickSearch_RdoTelephone1().Click();
    
    Log.Message("Valider que le critère Téléphone 1 est coché et le numéro de tél "+numTel+" est dans le champ rechercher");
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "Text", cmpEqual, numTel);
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone1(),"IsChecked", cmpEqual,true);
    Get_WinQuickSearch_BtnOK().Click();
    
    Log.Message("Valider que le curseur se place sur "+nomClientTel+" ("+NoClientTel+")");//800249
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find(["Value", "IsVisible"], [nomClientTel, true], 10).DataContext, "IsActive", cmpEqual, true); //Christophe : Ajout de la propriété "IsVisible" pour la détection
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find(["Value", "IsVisible"], [NoClientTel, true], 10).DataContext, "IsActive", cmpEqual, true);  //Christophe : Ajout de la propriété "IsVisible" pour la détection
    
    Log.PopLogFolder();
    
    /********************************** Étape 2 : Valider qu'il est possible d'ajouter, modifier et de supprimer des adresses de clients. **********************************/
    Log.AppendFolder("Étape 2: Croes-4261 - Valider qu'il est possible d'ajouter, modifier et de supprimer des adresses de clients.");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4261", "Cas de test TestLink: Croes-4261");  
    /**********************************************************************************************************************************************************************/
    
    var clientNum = NoClientTel;
    var street1 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "street1", language+client);
    var street2 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "street2", language+client);
    var country = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "country", language+client);
    var AdrType = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "typeAdress", language+client);
        
    Log.Message("Aller sur Info et sélectionner l'onglet Adresse")
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);

    Log.Message("Ajouter une adresse type Bureau")
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while (numberOftries < 5 && !Get_WinCRUAddress().Exists){
        Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click(); 
        numberOftries++;
    }
    Get_WinCRUAddress_CmbType().set_SelectedIndex(2);//Bureau
    Get_WinCRUAddress_TxtStreet1().Keys(street1);
    Get_WinCRUAddress_TxtStreet2().Keys(street2);
    Get_WinCRUAddress_BtnOK().Click();
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses(),["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"])
    
    Log.Message("Valider l'affichage de la nouvlle adresse");
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(),"Text", cmpEqual, street1)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(),"Text", cmpEqual, street2)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(),"VisibleOnScreen", cmpEqual, true)

    Log.Message("modifier l'adresse: ajouter le pays Canada")
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit().Click();
    Get_WinCRUAddress_CmbType().set_SelectedIndex(2);
    Get_WinCRUAddress_TxtCountry().Keys(country);
    Get_WinCRUAddress_BtnOK().Click();
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses(),["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"])
    
    Log.Message("valider la modification")
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(),"Text", cmpEqual, country)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(),"VisibleOnScreen", cmpEqual, true)
    
    Log.Message("Supprimer l'adresse")
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click();
    Get_SubMenus().FindChild("WPFControlText", AdrType, 10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click();
    Get_DlgConfirmation_BtnRemove().Click();
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses(),["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"])
    
    Log.Message("Valider la suppression")
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click();
    if ( Get_SubMenus().FindChild("WPFControlText", AdrType, 10).Exists && Get_SubMenus().FindChild("WPFControlText", AdrType, 10).VisibleOnScreen)
     Log.Error("L'adresse " +AdrType+" n'est pas supprimé")
    else 
     Log.Checkpoint("L'adresse "+AdrType+" est supprimé")
    
     Log.PopLogFolder();
    
    /********************************** Étape 3 : Valider qu'il est possible d'ajouter, modifier et de supprimer des numéros de téléphones des clients. 90.25-8 **********************************/
    Log.AppendFolder("Étape 3: Croes-4271 - Valider qu'il est possible d'ajouter, modifier et de supprimer des numéros de téléphones des clients.");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4271", "Cas de test TestLink : Croes-4271");  
    /**********************************************************************************************************************************************************************/
    
    var phoneNumber = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "phoneNumber", language+client);
    var PhoneType = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "typeCell", language+client);
    
    Get_WinDetailedInfo_TabAddresses_GrpTelephones().Click();    
    Log.Message("Valider l'affichage de la séction Téléphones")
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones(),"VisibleOnScreen", cmpEqual, true)
    
    Log.Message("Ajouter un numéro de téléphone")
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click();
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while (numberOftries < 5 && !Get_WinCRUTelephone().Exists){
        Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click(); 
        numberOftries++;
    }
    Get_WinCRUTelephone_CmbType().Click();
    Get_WinCRUTelephone_CmbType().set_SelectedIndex(2);//Bureau
    Get_WinCRUTelephone_TxtNumber().Keys(phoneNumber);
    Get_WinCRUTelephone_BtnOK().Click();
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpTelephones(),"Uid", "FixedColumnListView_1b3e")
    
    Log.Message("Valider l'ajout du numéro de téléphone")
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10), "Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10), "VisibleOnScreen", cmpEqual, true)

    Log.Message("Modifier le type de n de tél ajouté")
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit().Click();
    aqObject.CheckProperty(Get_WinCRUTelephone(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinCRUTelephone(),"VisibleOnScreen", cmpEqual, true)
    Get_WinCRUTelephone_CmbType().Click();
    Get_WinCRUTelephone_CmbType().set_SelectedIndex(3);//Cellulaire
    Get_WinCRUTelephone_BtnOK().Click();
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_BtnOK().Click();
    
    Log.Message("Valider la modification")
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
    var DisplayPhoneType= Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).DataContext.Item(0).Data.OleValue
    if (DisplayPhoneType == PhoneType)
      Log.Checkpoint("La modification est appliquée")
    else
      Log.Error("L'affichage est différent de "+PhoneType+" la modification n'est pas appliquée")
      
    Log.Message("Supprimer le n de tél ajouté")
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete().Click();
    Get_DlgConfirmation_BtnRemove().WaitProperty("IsEnabled", true, 15000);  
    Get_DlgConfirmation_BtnRemove().Click();
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpTelephones(),"Uid", "FixedColumnListView_1b3e")
    
    Log.Message("Valider que le numéro de tél n'est plus affiché")
    if ( Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).Exists && Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild("Text",phoneNumber , 10).VisibleOnScreen)
     Log.Error("Le numéro ajouté " +phoneNumber+" n'est pas supprimé")
    else 
     Log.Checkpoint("Le numéro ajouté "+phoneNumber+" est supprimé")
    
    Log.PopLogFolder(); 
    
    /********************************** Étape 4 : Valider qu'il est possible d'ajouter, modifier et de supprimer des adresses courriels d'un client. **********************************/
    Log.AppendFolder("Étape 4: Croes-4272 - Valider qu'il est possible d'ajouter, modifier et de supprimer des adresses courriels d'un client.");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4272", "Cas de test TestLink : Croes-4272");  
    /**********************************************************************************************************************************************************************/
    
    var Email1 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Email1", language+client)
    var Email2 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Email2", language+client)
    
    Log.Message("Valider que la section courriel est affiché");
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails(),"VisibleOnScreen", cmpEqual, true)

    Log.Message("Ajouter des adresses courriels");    
    var cellEmail1 = Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10);
    cellEmail1.Click();
    cellEmail1.WPFObject("XamTextEditor", "", 1).Keys(Email1);  
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    
    var cellEmail2 = Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10);
    cellEmail2.Click();
    cellEmail2.WPFObject("XamTextEditor", "", 1).Keys(Email2);
    Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_BtnApply().Click();
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    
    Log.Message("Validation de l'affichage des courriels, du consentement et de la date en vigeur");
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10), "Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10), "VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10), "Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10), "VisibleOnScreen", cmpEqual, true)
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10).DataContext.DataItem, "Consent", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10).DataContext.DataItem, "Consent", cmpEqual, true)
    
    if(language == "french")
      var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")
    if(language == "english")
      var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y")    
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10).DataContext.DataItem, "StartDate", cmpEqual, ToDay)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10).DataContext.DataItem, "StartDate", cmpEqual, ToDay)

    /*******
    N.B: Dans La Grille des adresses courriels, il y a un problème d'index des lignes. À chaque fois lorsqu'on click sur BtnApply, les lignes changent d'index. 
    La fermeture et la reouverture de la fenetre InfoClient résout ce problème.
    *****/
    Log.Message("Fermer la fenetre Info Client"); 
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);  
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while (numberOftries < 5 && !Get_RelationshipsClientsAccountsGrid().Exists){
        Get_WinDetailedInfo_BtnOK().Click(); 
        numberOftries++;
    }
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071"); 
    
    Log.Message("Aller sur Info et sélectionner l'onglet Adresse")
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);    
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    
    Log.Message("Supprimer la 3eme adresse courriel "+Email2+" et valider")
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).WPFObject("XamTextEditor", "", 1).Keys("[Del]");
    Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_BtnApply().Click();
    CheckErrorWindow();
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70")    
    
    if (Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10).Exists)
      Log.Error("L'adresse émail "+Email2+" est encore affichée.")
    else         
      Log.Checkpoint("La troixième adresse courriel "+Email2+" est supprimée.")
     
    Log.Message("Fermer la fenetre Info Client"); 
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);  
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while (numberOftries < 5 && !Get_RelationshipsClientsAccountsGrid().Exists){
        Get_WinDetailedInfo_BtnOK().Click(); 
        numberOftries++;
    }
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071"); 
       
    //--- Réinitialiser
    Log.Message("************ CLEANUP **************")        
    Log.Message("Aller sur Info et sélectionner l'onglet Adresse")
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);    
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    
    Log.Message("Supprimer l'adresse courriel ajoutée "+Email1+" et valider")
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).WPFObject("XamTextEditor", "", 1).Keys("[Del]");
    Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_BtnApply().Click();
    CheckErrorWindow();
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70")    
    
    if (Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10).Exists)
      Log.Error("L'adresse e-mail "+Email1+" est encore affichée.")
    else         
      Log.Checkpoint("L'adresse courriel "+Email1+" est supprimée.")
      
      Log.Message("Fermer la fenetre Info Client"); 
      
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);  
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while (numberOftries < 5 && !Get_RelationshipsClientsAccountsGrid().Exists){
        Get_WinDetailedInfo_BtnOK().Click(); 
        numberOftries++;
    }
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    Log.PopLogFolder();
    
    /************************************************************ Validation du Jira FEDS-875 ******************************************************************/
    Log.AppendFolder("Validation du Jira FEDS-875 - Crash dans la fenêtre info client lors de la suppression ou l'ajout d'une adresse courriel.");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/browse/FEDS-875", "Cas de Jira: FEDS-875"); 
    /**********************************************************************************************************************************************************************/1
    Log.Message("Aller sur Info et sélectionner l'onglet Adresse");
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    //Récupérer l'adresse email du client qui existe dans la BD avant de la supprimer
    var displayAdressEmail0 = Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Email.OleValue
    
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).WPFObject("XamTextEditor", "", 1).Keys("[Del]");
    Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 15000);        
    Get_WinDetailedInfo_BtnApply().Click();
    CheckErrorWindow();
    
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);  
    Get_WinDetailedInfo_BtnOK().Click();    
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",displayAdressEmail0,10), "Exists", cmpEqual, false)
    //aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",displayAdressEmail0,10), "VisibleOnScreen", cmpEqual, false)
    
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);  
    Get_WinDetailedInfo_BtnOK().Click();
    
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    Log.Message("************ RESET DATA **************")        
    Log.Message("Aller sur Info et sélectionner l'onglet Adresse")
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);    
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    
    Log.Message("Remettre l'adresse courriel supprimée "+displayAdressEmail0+" au client "+clientNum+" et valider")
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "2"],10).WPFObject("XamTextEditor", "", 1).Keys(displayAdressEmail0);
    Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_BtnApply().Click();
    CheckErrorWindow();
    
    //Ajouter une pause
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70")    
    
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);  
    Get_WinDetailedInfo_BtnOK().Click();    
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
    WaitObject(Get_WinDetailedInfo_TabAddresses_GrpEmails(),"Uid", "DataGrid_9b70");
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",displayAdressEmail0,10), "Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",displayAdressEmail0,10), "VisibleOnScreen", cmpEqual, true)
    
    Log.Message("Fermer la fenetre Info Client"); 
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);  
    Get_WinDetailedInfo_BtnOK().Click();
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
    Log.PopLogFolder();
    
    //********************************** Étape 5 : Suppression d’une sélection de clients á la fois. **********************************/
    Log.AppendFolder("Étape 5: Croes-4283 - Suppression d’une sélection de clients á la fois.");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4283", "Cas de test TestLink : Croes-4283");  
    /**********************************************************************************************************************************************************************/
    
    var fictifClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "clientFictif", language+client);
    var externClient = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "clientExterne", language+client);
    var RealClient = NoClientTel; //800249
    
    Log.Message("Créer un client fictif");
    CreateFictitiousClient(fictifClient);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      
    Log.Message("Créer un client externe");
    CreateExternalClient(externClient, codeCP);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      
    Log.Message("Sélectioner ces clients");
    var ClientFicNo=Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictifClient, 10).DataContext.DataItem.ClientNumber.OleValue
    var ClientExternNo=Get_RelationshipsClientsAccountsGrid().FindChild("Value", externClient, 10).DataContext.DataItem.ClientNumber.OleValue
      
    var clients= new Array(ClientExternNo, ClientFicNo);
    SelectClients(clients)
      
    Log.Message("Supprimer les clients sélectionnés");      
    Get_Toolbar_BtnDelete().Click();
    Get_DlgConfirmation_BtnRemove().Click();
    WaitObject(Get_CroesusApp(),["Uid", "VisibleOnScreen"],["CRMDataGrid_3071", true]);
    
    Log.Message("valider la suppression des clients créés");
    Get_Toolbar_BtnSearch().WaitProperty("IsEnabled", true, 15000); 
    Search_Client(fictifClient);
    WaitObject(Get_CroesusApp(),["Uid", "VisibleOnScreen"],["CRMDataGrid_3071", true]);
    var fictifClientExist=Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictifClient, 10).Exists;
    
    Get_Toolbar_BtnSearch().WaitProperty("IsEnabled", true, 15000);
    Search_Client(externClient);
    WaitObject(Get_CroesusApp(),["Uid", "VisibleOnScreen"],["CRMDataGrid_3071", true]);
    var externClientExist=Get_RelationshipsClientsAccountsGrid().FindChild("Value", externClient, 10).Exists;
    
    if (!fictifClientExist  && !externClientExist)
      Log.Checkpoint("les clients sélectionnés sont supprimés")      
    else
      if (fictifClientExist && externClientExist)
        Log.Error("Les clients sélectionnés ne sont pas supprimé")
      else if (fictifClientExist)
        Log.Error("Le client "+fictifClient+" no "+ClientFicNo+" n'est pas supprimé")
      else if (externClientExist)
        Log.Error("Le client "+externClient+" no "+ClientExternNo+" n'est pas supprimé")
    
    Log.Message("Suppression d'un client réel"+RealClient)//800249
    Search_Client(RealClient);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", RealClient, 10).Click();
    
    Log.Message("Valider que le bouton supprimer est grisé est inaccessible");
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"Enabled", cmpEqual, false);    
    aqObject.CheckProperty(Get_Toolbar_BtnDelete(),"IsEnabled", cmpEqual, false);
    
    Log.PopLogFolder();
    
   // ********************************** Étape 6 : Création d'une relation á partir du module clients par un Click droit / Edition. **********************************/
    Log.AppendFolder("Étape 6: Croes-4278 - Création d'une relation á partir du module clients par un Click droit / Edition.");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4278", "Cas de test TestLink : Croes-4278");  
   // **********************************************************************************************************************************************************************/
    
    var accounts= GetData(filePath_Clients,"CR1352",206,language); 
    var relationshipName=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "relationshipName", language+client);
    var NoRelation=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NoRelation", language+client);
    var account800249NA=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Account800249NA", language+client);
    var account800249OB=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Account800249OB", language+client);
    var clientName=nomClientTel;
    
    Log.Message("Créer une relation à partir du clic droit sur le client "+clientNum);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).ClickR();  
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
    Get_WinAssignToARelationship_BtnYes().Click();
  
    Log.Message("Remplir les information dans la fenêtre Créer une relation");
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click();
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 15000);
  
    Log.Message("Valider que la relation "+relationshipName+"a été ajoutée");
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10), "Exists", cmpEqual, true);   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10), "VisibleOnScreen", cmpEqual, true);
  
    Log.Message("Mailler la relation "+relationshipName+" vers le module Clients");
    SearchRelationshipByName(relationshipName)
    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName ,10), Get_ModulesBar_BtnClients());
  
    Log.Message("Valider que seulement le client "+clientNum+" existe");
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items,"Count",cmpEqual,1);//un seul client qui s'affiche pour cette relation
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "Exists", cmpEqual, true);   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "VisibleOnScreen", cmpEqual, true);
    var clientNumDisplay =Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).DataContext.DataItem.ClientNumber.OleValue;
    if (clientNumDisplay == clientNum )
    Log.Checkpoint("Le client "+clientNum+" est affiché")
    else 
    Log.Error("Un autre numéro de client est affiché")
  
    Log.Message("Retirer le filtre courant");
    var descriptionFilter=Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10).DataContext.FilterDescription.OleValue
    Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription_BtnRemove(descriptionFilter).Click();
  
    Log.Message("Valider la suppression de filtre");          
    var existenceFiltre= Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", descriptionFilter], 10);
    if(existenceFiltre.Exists && existenceFiltre.VisibleOnScreen)
      Log.Error("Le filtre n'est pas supprimé");
    else
      Log.Checkpoint("Le filtre est  supprimé");    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items,"Count",cmpGreater,1);//il y a plus qu'un seul client (tous les clients s'affichent)
  
    Log.Message("**Associer la relation "+NoRelation+" au client "+clientNum)
    Log.Message("Sélectionner le client "+clientNum+" dans la liste des clients");
    Search_Client(clientNum);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).Click();
      
    Log.Message("Associer une relation à partir du menu EDITION");
    Get_MenuBar_Edit().Click();
    Get_MenuBar_Edit_Relationship().Click();
    Get_MenuBar_Edit_Relationship_JoinToAnExistingRelationship().Click();
  
    Log.Message("Sélectionner la relation "+NoRelation); //"00000"
    Get_WinPickerWindow_DgvElements().Keys("0"); 
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(NoRelation);
    Get_WinQuickSearch_BtnOK().Click();     
    Get_WinPickerWindow_DgvElements().Find("Value",NoRelation,10).Click();
    Get_WinPickerWindow_BtnOK().Click();
    Get_WinAssignToARelationship_BtnYes().Click();
  
    Log.Message("Valider l'affichage de la relation "+NoRelation);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", NoRelation, 10), "Exists", cmpEqual, true);   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", NoRelation, 10), "VisibleOnScreen", cmpEqual, true);
  
    Log.Message("Mailler la relation vers le module Clients");
    SearchRelationshipByNo(NoRelation)
    Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText",NoRelation ,10).Click();
    Drag(Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText",NoRelation ,10), Get_ModulesBar_BtnClients());
  
    Log.Message("Vérifier que le client "+clientNum+" existe pour cette relation");
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "Exists", cmpEqual, true);   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10), "VisibleOnScreen", cmpEqual, true);
    var clientNumDisplay =Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum, 10).DataContext.DataItem.ClientNumber.OleValue;
    if (clientNumDisplay == clientNum )
      Log.Checkpoint("Le client "+clientNum+" est affiché")
    else 
      Log.Error("Le client "+clientNum+" n'existe pas")
       
    //*********Rétablir la configuration initiale    
    Log.Message("************ CLEANUP **************") 
    //**Retirer la relation 0000 du client 800249                                        
    Log.Message("**Retirer la relation "+NoRelation+" du client "+clientNum);
    Get_ModulesBar_BtnRelationships().Click();    
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
    SearchRelationshipByNo(NoRelation);
    Get_RelationshipsClientsAccountsGrid().FindChild("WPFControlText",NoRelation ,10).Click();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().WaitProperty("VisibleOnScreen", true, 500);    
    
    
    //Supprimer le compte account800249NA
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Click(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().get_ActualWidth()-7, Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().get_ActualHeight()-32);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Value",account800249NA,10).ClickR();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().WaitProperty("VisibleOnScreen", true, 10000);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click(); 
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 500);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    //Supprimer le compte account800249OB
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Click(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().get_ActualWidth()-7, Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().get_ActualHeight()-32);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Value",account800249OB,10).ClickR();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().WaitProperty("VisibleOnScreen", true, 10000);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click(); 
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    Get_RelationshipsClientsAccountsGrid().WaitProperty("VisibleOnScreen", true, 500);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); //Pour enlever le filtre    
    
    //**Supprimer la relation créé        
    Log.Message("** Supprimer la relation" + relationshipName);
    SearchRelationshipByName(relationshipName);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).ClickR();
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete().Click();
        
    //Vérifier que la fenêtre de confirmation de suppression est affichée
    Log.Message("Verify that The 'Confirm Action' dialog box is displayed.");
    if (!(Get_DlgConfirmation().Exists)){
      Log.Error("The 'Confirmation' dialog box not displayed. This is not expected.");    
    }
    else        
      Log.Checkpoint("The 'Confirmation' dialog box displayed.");
        
    //Confirmer avec OK
    Log.Message("Confirm the deletion action by clicking on OK button.");
    Log.Message("La fenêtre de confirmation de suppression de relation est différente entre BNC et US CROES-7871 ");
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    
    //Vérifier si la suppression a été effectuée
    Log.Message("Verify that '" + relationshipName + "' relationship was actually deleted.");
    var relationshipSearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    Log.Message("CROES-7871")
    if (relationshipSearchResult.Exists)
      Log.Error("'" + relationshipName + "' relationship not deleted. This is not expected.");
    else
      Log.Checkpoint("'" + relationshipName + "' relationship deleted.");
    
    Log.PopLogFolder();
    
    //Fermer Croesus
    Log.Message("Fermer Croesus")
    Close_Croesus_X();
  }  
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    //Fermer le processus Croesus
    Terminate_CroesusProcess();         
    Runner.Stop(true);
  }   
}     
function CheckErrorWindow(){
  Log.Message("Valider que l'application ne crash pas.");
  var errorDialogBoxDisplayed = Get_DlgError().Exists;
  if (errorDialogBoxDisplayed){
      Log.Error("Un message d'erreur s'affiche: "+Get_DlgError_LblMessage1().Text);
      Log.Error("Bug FEDS-875");
      Get_DlgError().Click(Get_DlgError().get_ActualWidth()/2, Get_DlgError().get_ActualHeight()-45);
      return;
  }
  else
      Log.Checkpoint("Aucun message d'erreur ne s'affiche.");
}

