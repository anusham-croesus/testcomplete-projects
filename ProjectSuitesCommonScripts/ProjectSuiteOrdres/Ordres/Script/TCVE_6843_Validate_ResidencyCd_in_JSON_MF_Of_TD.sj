//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CROES_6794_Copy_of_configurations_simulator


/**
    Description : En tant que TCVE je veux automatiser la validation des code de residence des clients
                  dans le fichiers Json de TD pour que cette fonctionnalité sot couverte par notre suite 
                  de tests automatisés du client TD
    
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Philippe Maurice
    Date: 4 août 2021
    version: 90.26.2021.08-32
*/


function TCVE_6843_Validate_ResidencyCd_in_JSON_MF_Of_TD()
{
    try {  
        
        //Lien de la story et du cas X-Ray
        Log.Link("https://jira.croesus.com/browse/TCVE-5657","Lien du cas X-ray");   
        Log.Link("https://jira.croesus.com/browse/TCVE-6843","Lien de la story");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var account        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2568", "CR2568_Account", language+client);
        var clients        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_clientsList", language+client);
        var listOfClients  = clients.split("|");
        
        var FID1055_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID1055_Symb", language+client);
        var FID1055_Qty = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID1055_Qty", language+client);
        var FID1055_TransType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID1055_TransType", language+client);        
        var FID1055_SecDesc = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID1055_SecDesc", language+client);
        
        var FID227_Symbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID227_Symb", language+client);
        var FID227_Qty = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID227_Qty", language+client);
        var FID227_TransType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID227_TransType", language+client);        
        var FID227_SecDesc = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_FID227_SecDesc", language+client);
        
        Log.PopLogFolder();
        logEtapePrep = Log.AppendFolder("---- Étape de PRÉPARATION ----");
        Preparation();
        
        //Étape 3
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("---- Étape 3: Se loguer, sélectionner les clients et créer un ordre multiple ----");
        //Se loguer à l'application avec le user KEYNEJ, atteindre le module Clients
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Vider l'accumulateur
        Log.Message("Supprimer les ordres dans l'accumulateur au cas où avant de commencer.")
        Clear_Accumulator();
        
        Log.Message("Aller dans le module Clients.")
        Get_ModulesBar_BtnClients().Click();
	      Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        
        
        //Sélectionner les 9 clients 800257, 800259, 800260, 800261, 800262, 800263, 800264, 800265, 800270
        Log.Message("Sélectionner les clients: 800257, 800259, 800260, 800261, 800262, 800263, 800264, 800265, 800270")
        SelectClients(listOfClients);
        
        //Mailler les clients dans le module Comptes
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        
        //Sélectionner tout les comptes puis cliquer sur l'icône Ordres multiples
        Get_RelationshipsClientsAccountsGrid().Keys("^a");
        
        //Ajouter un ordre d'achat fond mutuel FID1055
        Log.Message("Créer un ordre multiple");
        Create_Multiple_Order(FID1055_Qty, FID1055_SecDesc, FID1055_Symbol, FID1055_TransType);
        
         
        //Dans l'accumulateur: Sélectionner l'ordre FID1055, vérifier puis soumettre
        Get_ModulesBar_BtnOrders().Click();
	      Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 100000);
        

        Log.Message("Sélectionner l'ordre FID1055 dans l'accumulateur, Vérifier et Soumettre");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", FID1055_Symbol, 10).Click();  //Sélectionner l'ordre dans l'accumulateur
        Get_OrderAccumulator_BtnVerify().Click();  //Vérifier 
        //soumettre
        Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
        WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);
        Delay(5000);  //Pour donner le temps au système de changer le status de l'ordre 
        
        Log.Message("Exécution du script pour mettre résultat dans fichier txt");
        
        //Valider le Residency code pour une adresse avec une date en vigueur qui est la date du jour:
        var listCodes = Create_Array_CodesList1();
        Log.Message("-- Validation des ResidencyCd pour " + listCodes);
        Validate_ResidencyCd(listCodes, "cmdGetResidencyCd");
 
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("---- Étape 4: Valider le Residency code pour une adresse avec une date en vigueur qui est la date du jour ----")
        
        //Module Clients: Double cliquer sur le client 800030, onglet Adresses
        Get_ModulesBar_BtnClients().Click();
	      Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        
        var client800030 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_Client800030", language+client);       
        SelectClients(client800030);
        
        //Ajouter une adresse
        var addType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_AddrType", language+client);
        var city = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_City", language+client);
        var country = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_Country", language+client);
        Adding_Address(addType, city, country);   
        Delay(1000);
        
        
        //Mailler le client dans le module Compte puis sélectionner le compte 800030-GT
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        
        var acc800030GT = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_Acc800030", language+client);       
        SelectAccounts(acc800030GT);
        
        //Créer un ordre de vente Fond d'investissement, symbole:FID227, quantité=10
        Create_Multiple_Order(FID227_Qty, FID227_SecDesc, FID227_Symbol, FID227_TransType);
        

        //Vérifier puis soumettre l'ordre
        Log.Message("Sélectionner l'ordre FID227 dans l'accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", FID227_Symbol, 10).Click();    //Sélectionner l'ordre dans l'accumulateur
        
        Get_OrderAccumulator_BtnVerify().Click();  //Vérifier 
        //soumettre
        Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
        Delay(5000);  //Pour donner le temps au système de changer le status de l'ordre
        
        
        //Valider le ResidencyCd dans le fichier json
        var listCodes2 = Create_Array_CodesList2();
        Log.Message("-- Validation des ResidencyCd pour " + listCodes2);
        Validate_ResidencyCd(listCodes2, "cmdGetResidencyCd2");      
        
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {        
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("---- Étape 5: Fermeture de Croesus et Mise à jour remise à état initial ----");
       
        Log.Message("-- Mise à jour des adresses --");
        Update_Addresses();
        
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}



function Preparation()
{
    var sqlString = "delete from dbo.B_CLADDR where no_client = '800270'";

    var sqlString2 = "update b_addrss set cityregion='laval QC', country='CANADA' where address_id in (select address_id from b_claddr where no_client ='800259') ";
    sqlString2 += "update b_addrss set cityregion='', country='CANADA' where address_id in (select address_id from b_claddr where no_client ='800260') ";
    sqlString2 += "update b_addrss set cityregion='test ville', country='CANADA' where address_id in (select address_id from b_claddr where no_client ='800261') ";
    sqlString2 += "update b_addrss set cityregion='WINNIPEG MB', country='' where address_id in (select address_id from b_claddr where no_client ='800257') ";
    sqlString2 += "update b_addrss set cityregion='New York NY', country='United States' where address_id in (select address_id from b_claddr where no_client ='800262') ";
    sqlString2 += "update b_addrss set cityregion='Paris 13', country='France' where address_id in (select address_id from b_claddr where no_client ='800263') ";
    sqlString2 += "update b_addrss set cityregion='', country='Australie' where address_id in (select address_id from b_claddr where no_client ='800264') ";
    sqlString2 += "update b_addrss set cityregion='Toronto ON', country='test pays' where address_id in (select address_id from b_claddr where no_client ='800265')";
    
    Log.Message("Exécuter petit script pour mode auto");    
    CROES_6794_Configurations_simulator();
    
    Log.PopLogFolder();
    logEtape1 = Log.AppendFolder("---- Étape 1: Exécuter la requete pour rendre le client 800270 sans adresses ----");
    Execute_SQLQuery(sqlString, vServerOrders);
    
    Log.PopLogFolder();
    logEtape2 = Log.AppendFolder("---- Étape 2: Exécuter le script pour modifier les adresses des 8 clients 800257, 800259, 800260, 800261, 800262, 800263, 800264, 800265 ----");
    Execute_SQLQuery(sqlString2, vServerOrders);
    
    
}


function Clear_Accumulator()
{
    Get_ModulesBar_BtnOrders().Click();
	  Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 100000);
    
    
    if (Get_OrderAccumulatorGrid().RecordListControl.Items.Count > 0) {
        Get_OrderAccumulatorGrid().RecordListControl.Keys("^a");
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    } 
}


function Create_Array_CodesList1()
{
    var resCd_MB = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_resCd_MB", language+client);
    var resCd_NY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_resCd_NY", language+client);
    var resCd_QC = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_resCd_QC", language+client);
    var resCd_FR = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_resCd_FR", language+client);
    var resCd_AUS = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_resCd_AUS", language+client);
    
    var nb_resCd_MB = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_nb_resCd_MB", language+client);
    var nb_resCd_NY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_nb_resCd_NY", language+client);
    var nb_resCd_QC = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_nb_resCd_QC", language+client);
    var nb_resCd_FR = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_nb_resCd_FR", language+client);
    var nb_resCd_AUS = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_nb_resCd_AUS", language+client); 


    var myArray = [[resCd_MB, nb_resCd_MB], [resCd_NY, nb_resCd_NY], [resCd_QC, nb_resCd_QC], [resCd_FR, nb_resCd_FR], [resCd_AUS, nb_resCd_AUS]];

    return myArray;

}

function Create_Array_CodesList2()
{
    var resCd_QC2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_resCd_QC2", language+client);
    var nb_resCd_QC2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TCVE_5657_nb_resCd_QC2", language+client);
    
    var myArray = [[resCd_QC2, nb_resCd_QC2]];
    
    return myArray;
}





function Create_Multiple_Order(quantity, securityDescription, symbol, transType)
{ 
    var qtyType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "TCVE_5771_QtyType", language + client);

    //Creation de l'ordre
    Log.Message("-- Création d'un ordre multiple: Symbole: " + symbol + " --");
    
    //Click sur ordre multiple
    Log.Message("Cliquer sur ordre multiple et choisir le type de transaction (" + transType + ")");
    Get_Toolbar_BtnSwitchBlock().Click();
    WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
    Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transType);
    
           
    //Ajout d'une transaction(s)
    Log.Message("Ajout d'une transaction de " + transType);
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled", true, 10)      
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
                    
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
    Get_WinSwitchSource_CmbSecurity().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Symbole"], 10).Click();
           
    Log.Message("Entrer les informations:  Quantité = " + quantity + " unités par compte");
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_WinSwitchSource_TxtQuantity().Keys(quantity);
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_SubMenus().Find("WPFControlText", qtyType, 10).Click();
    
    Log.Message("Entrer les informations:  Description = " + symbol);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(symbol);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
    
    if(Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value", symbol, 10).DblClick();
    }
    
    Get_WinSwitchSource_btnOK().Click();
    
    //Cliquer sur Aperçu, puis Générer    
    Log.Message("Cliquer sur Aperçu et Générer par la suite.");                
    Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
    Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled", true, 2000);
    Get_WinSwitchBlock_BtnGenerate().Click();
    
    //si il y a fenêtre pour confirmation ici
    if(Get_DlgConfirmation().Exists){
        Get_DlgConfirmation_BtnYes().Click();
    }
}


function Adding_Address(addrsType, city, country)
{
    //Extraire la date d'aujourd'hui
    var month = aqString.Format("%02d", aqDateTime.GetMonth(aqDateTime.Now()));
    var day = aqString.Format("%02d", aqDateTime.GetDay(aqDateTime.Now()));
    
    //Extraire la date 1 mois plus tard
    var month2 = aqString.Format("%02d", aqDateTime.GetMonth(aqDateTime.AddMonths(aqDateTime.Now(),1)))
    var day2 = aqString.Format("%02d", aqDateTime.GetDay(aqDateTime.AddMonths(aqDateTime.Now(),1)))
    
    //Ajouter une adresse type Adresse permanente
    Get_ClientsBar_BtnInfo().Click();    //Cliquer sur info
    Get_WinDetailedInfo_TabAddresses().Click();    //Cliquer sur onglet Adresse
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
    Get_WinAddAddress().WaitProperty("VisibleOnScreen", true, 30000);
        
    //Remplir le champs Ville/Prov=LORRAINE Quebec, Pays=CANADA
    Log.Message("Ajout d'une adresse:  Type: " + addrsType + "  Ville: " + city + " Pays: " + country);
    Get_WinAddAddress_CmbType().Keys(addrsType);
    Get_WinAddAddress_TxtCity().Keys(city);      
    Get_WinAddAddress_TxtCountry().Keys(country);
      
    //Dans le champ En vigueur: du:date du jour, Au: 1 mois après Sauvegarder les changements
    Get_WinCRUAddress_TxtRelevantFrom().Click();
    Get_WinCRUAddress_TxtRelevantFrom().Keys(month + "." + day);
      
    Get_WinCRUAddress_TxtTo().Click();
    Get_WinCRUAddress_TxtTo().Keys(month2 + "." + day2);
      
    Get_WinCRUAddress_BtnOK().Click();
    
    Get_WinDetailedInfo_BtnOK().Click();
}


function Validate_ResidencyCd(arrayCd, myScript)
{
    var localDestinationFilePath = folderPath_ProjectSuiteCommonScripts +"ProjectSuiteOrdres\\Ordres\\SSH\\"
    var vserverFilePath ="/home/crweb/Test_CR1571/"
    
    SSHExecute(myScript);
    
    
    Log.Message("Copier les fichiers résultats en local");
    for (i=0 ; i<arrayCd.length; i++){
        CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath + "Results" + arrayCd[i][0] + ".txt", localDestinationFilePath);
    }
    
    Log.Message("Validation des residencyCd");
    for (i=0 ; i<arrayCd.length; i++){
      
        var myFile = aqFile.OpenTextFile(localDestinationFilePath + "Results" + arrayCd[i][0] + ".txt", aqFile.faRead, aqFile.ctANSI);                 
    
        while(!myFile.IsEndOfFile()){    
            line = myFile.ReadLine();
    
            //Split at each space character.
            var JSONArr = line.split("\n"); 
            Log.Message(line);   
    
            for (j=0; j< JSONArr.length - 1; j++){
                if(aqObject.CompareProperty(VarToString(JSONArr[j]), cmpEqual, arrayCd[i][1] , true, lmError)){
                    Log.Checkpoint("Le texte "+ arrayCd[i][0] + " est correct!");
                } 
                else {
                    Log.Error("Le nombre d'items n'est pas le bon pour " + arrayCd[i][0]);
                }
            }
        }
        myFile.Close(); // Closes the file
    }
    
    //Delete files
    Log.Message("Supression des fichiers résultats");
    for (i=0; i<arrayCd.length; i++) {
        if (aqFileSystem.Exists(localDestinationFilePath + "Results" + arrayCd[i][0] + ".txt"))
            aqFile.Delete(localDestinationFilePath + "Results" + arrayCd[i][0] + ".txt");
    }
    
    for (i=0; i<arrayCd.length; i++) {
        if (aqFileSystem.Exists(vserverFilePath + "Results" + arrayCd[i][0] + ".txt"))
            aqFile.Delete(vserverFilePath + "Results" + arrayCd[i][0] + ".txt");
    }
}


function Update_Addresses()
{
    var sqlString1 = "update b_addrss set cityregion='', country='CANADA' where address_id in (select address_id from b_claddr where no_client in ('800259', '800260', '800261', '800257', '800262', '800263', '800264', '800265'))";
    Execute_SQLQuery(sqlString1, vServerOrders);
    
    var sqlString2 = "update b_addrss set country='CANADA', type='Maison', ADDRESS1='40 THAMES PL NW ', ADDRESS2='CALGARY AB', POSTAL_ZIP='T2K 5L2', READ_ONLY ='y', MAILING_ADDRESS ='Y', DATE_CREAT ='2009-12-01 00:00:00', DATE_MAJ ='2009-12-01 00:00:00', LOADER_TYPE=1, TRUNCATEDPOSTALZIP='T2K' WHERE address_id in (select address_id from b_claddr where no_client ='800270')"
    Execute_SQLQuery(sqlString2, vServerOrders);
    
    var sqlString3 = "update b_addrss set type='', ADDRESS1='', DATE_FROM=NULL, DATE_TO=NULL where address_id = (select max(ADDRESS_ID) from B_ADDRSS)";
    Execute_SQLQuery(sqlString3, vServerOrders);
}