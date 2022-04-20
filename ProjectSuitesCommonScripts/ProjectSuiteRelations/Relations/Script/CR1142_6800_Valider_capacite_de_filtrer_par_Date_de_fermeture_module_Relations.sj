//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1142_6788_Valider_capacite_de_filtrer_par_etat_operateur_parmi_excluant_est_a_blanc


/**
    
TestLink   : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6800
    Description : Valider la capacité de filtrer les Relations client par 'Date de fermeture', operateurs: 'égale', 'n’est pas égale' et 'entre'
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Frédéric Thériault
    Module: Relations
**/

function CR1142_6800_Valider_capacite_de_filtrer_par_Date_de_fermeture_module_Relations()
{
    /**
    Préconditions
    Avoir exécuté les préconditions du cas de test Croes-6788.
    **/
    var logEtape1, logEtape2, logEtape3, logEtape4, logRetourEtatInitial;
    var maxRetry = 5;
    
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6800","Lien du Cas de test sur TestLink");
        
        var dateFermeture = "'2009.12.25'";
        var statusBcompte = "2";
        
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var dateFermeture_6800 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "columnType_6800", language+client); // Date de fermeture, Close date
        var statusOpen = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "statusValueOpen", language+client); // Ouverte, Open
        var opComboBox = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "OperatorEqualTo", language+client); // Opérateur égal(e) à
        var closeDay =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "closingDay", language+client);
        var closeMonth = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "closingMonth", language+client);
        var closeYear = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "closingYear", language+client);
        
        Log.Message("Préparation des préconditions: Création des Relations client avec l'état Fermée.");
        etatPrep = PreparerRequis(dateFermeture, statusBcompte);
        if (etatPrep != true)
          Log.Error("La préparation des préconditions ne s'est pas déroulée correctement.");
        
        // Étape 1
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec Keynej et aller au Module Relations.");
        // Se connecter avec Keynej 
         Login(vServerRelations, userName, password, language);
    
        // Aller au Module Relations
        Log.Message("Aller au Module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 10000);
        
        // Étape 2
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Ajouter la colonne Date de fermeture.");
        
        SetDefaultConfiguration(Get_ClientsGrid_ChName());
        statut1 = Get_RelationshipsGrid_ChStatus().Exists;
        if (statut1 == true)
            visible1 = aqObject.CheckProperty(Get_RelationshipsGrid_ChStatus(), "VisibleOnScreen", cmpEqual, true);
        else
            visible1 = false;
        
        if (statut1 == false && visible1 == false) {
            Add_ColumnByLabel(Get_ClientsGrid_ChName(), dateFermeture_6800);
            statut2 = Get_RelationshipsGrid_ChClosingDate().Exists;
            visible2 = aqObject.CheckProperty(Get_RelationshipsGrid_ChClosingDate(), "VisibleOnScreen", cmpEqual, true);
            if (statut2 == true && visible2 == true) {
                // Étape 3
                Log.PopLogFolder();
                logEtape3 = Log.AppendFolder("Étape 3: Appliquer un filtre par Date de fermeture.");
                Log.Message("Appuyer sur le filtre (Y+)");
                
                Log.Message("Cliquer dans les sous menus Date / Date de fermeture.");
                
                for (tti = 1; tti <= maxRetry; tti++) {
                    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
                    resultat1 = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"], 2000);
                    if (resultat1 == true) {
                        // Sous menus du bouton Filtres rapides.
                        Get_Toolbar_BtnQuickFilters_ContextMenu_Date().OpenMenu();
                        Get_Toolbar_BtnQuickFilters_ContextMenu_Date().HoverMouse(5,5);
                        resultat2 = WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["MenuItem", dateFermeture_6800], 2000);
                        if (resultat2 == true){
                            Get_Toolbar_BtnQuickFilters_ContextMenu_Date_SubMenu_ClosingDate().Click();
                            break;
                        }
                    }
                    else {
                      if (tti == maxRetry)
                        Log.Error("Menu Date non détecté " +tti +" fois sur " +maxRetry +".");
                      else
                        Log.Message("Menu Date non détecté " +tti +" fois sur " +maxRetry +".");
                    }
                    Delay(1000);
                }
                  
                // Sélectionner le champ Sélectionner l'opérateur: égal(e) à. Dans le petit calendrier choisir 2010/01/25 / Appliquer.
                Log.Message("Sélectionner l'opérateur: égal(e) à dans le menu déroulant.");
                for (tty = 1; tty <= maxRetry; tty++) {
                    Get_WinCreateFilter_CmbOperator().Click();
                    resultat3 = WaitObject(Get_CroesusApp(),["ClrClassName", "DataContext.Description"], ["ComboBoxItem", opComboBox], 2000);
                    if (resultat3 == true) {
                        // Sous menus du bouton Filtres rapides.
                        Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
                        break;
                    }
                    else {
                      if (tty == maxRetry)
                        Log.Error("Opérateur 'égal(e) à' non détecté " +tty +" fois sur " +maxRetry +" dans le menu déroulant.");
                      else
                        Log.Message("Opérateur 'égal(e) à' non détecté " +tty +" fois sur " +maxRetry +" dans le menu déroulant.");
                    }
                    Delay(1000);
                }
                
                Log.Message("Choisir la date 2010/01/25 dans le calendrier.");
                Get_WinCreateFilter_DtpValue().Click(430,10);
                resultat4 = WaitObject(Get_CroesusApp(), "Uid", "MonthCalendar_80ce", 2000);
                if (resultat4 == true) {
                    var rollCount = 0;
                    do{
                        resultat5 = WaitObject(Get_CroesusApp(), ["ClrClassName", "DataContext.OleValue"], ["ListBoxItem", closeYear], 2000);
                        Get_Calendar_LstYears().MouseWheel(15);
                        rollCount = rollCount +1;
                    }while(resultat5 != true || rollCount == maxRetry);
                    Get_Calendar_LstYears_Item(closeYear).Click();
                    Get_Calendar_LstMonths_Item(closeMonth).Click();
                    Get_Calendar_LstDays_Item(closeDay).Click();
                    Log.Message("Cliquer le bouton OK pour confirmer le choix de date.");
                    Get_Calendar_BtnOK().Click();
                }
                
                Log.Message("Cliquer le bouton Appliquer pour créer le filtre choisi.");
                Get_WinCreateFilter_BtnApply().Click();
                
                // Vérifier que seulement la Relation 80040 est affiché. // The changes made by the story TCVE-3672 
                var dateElemClosingDate = aqDateTime.SetDateElements(closeYear, closeMonth, closeDay);
                var grid = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = grid.Count;
                
                if (count == 1) {                 
                    for (i = 0; i < count; i++) {
                        var currentRelationshipClosingDateValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ClosingDate();
                        var currentRelationshipLinkNumber = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_LinkNumber();
                        if (aqDateTime.Compare(currentRelationshipClosingDateValue,dateElemClosingDate) == 0 && aqObject.CompareProperty(aqConvert.VarToStr(currentRelationshipLinkNumber),cmpEqual,"80040")==true)
                          Log.Checkpoint("La date de fermeture de la relation " + currentRelationshipLinkNumber + " est bien " +currentRelationshipClosingDateValue.Month +"/" +currentRelationshipClosingDateValue.Day +"/" +currentRelationshipClosingDateValue.Year +".");
                        else
                          Log.Error("La date " +currentRelationshipClosingDateValue +" de la relation " +currentRelationshipLinkNumber + " ne corresponds pas à " +dateElemClosingDate +".");
                    }
                }
                else
                    Log.Error("Le nombre d'éléments dans la grille n'est pas celui attendu.", "Il y a " +count +"élément(s) sur 1.");
            }
        }
        // Étape 4
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Retirer le filtre par le X.");
        
        // Verifier si le bouton du fitre est présent
        resultat6 = WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", 1, true], 3000);
        if (resultat6 == true){
            // Retirer le filtre
            Log.Message("Supprimer le filtre par le X") ;
            Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
        }
        else
            Log.Error("Le filtre par Date de fermeture n'a pas été trouvé.");
        
        //Fermer Croesus
        Close_Croesus_X();
        
    }
    catch(e) {
  //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
  
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        
        dateFermeture = "null";
        statusBcompte = "1";
        
        Log.Message("Étape 5: Modifier à l'état =Ouverte  pour les Realtions Client.");
        etatPrepRetourInitial = PreparerRequis(dateFermeture, statusBcompte);
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        //Fermer browser et .Net ClickOnce App Deployment Fulfillment Service
        CloseBrowser(browserName);
        TerminateProcess("dfsvc");
    }
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Date_SubMenu_ClosingDate()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Date de fermeture"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Closing Date"], 10)}
}
