//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    Lien : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6788
    
    Résumé : Valider la capacité de filtrer par ‘État', opérateurs: ‘parmi’, ‘excluant’.
    
    Auteur : Frédéric Thériault
    
    Version de scriptage :	ref90-12-Hf-46--V9-croesus-co7x-1_8_2_653
    
    Module: Relations
**/

function CR1142_6788_Valider_capacite_de_filtrer_par_etat_operateur_parmi_excluant_est_a_blanc()
{
/**
Préconditions
Créer des Relations Client avec l'État = Fermée:

Dans SQL:
 
update b_compte set date_close='2009.12.25',status=2 where NO_CLIENT in ('800400','800401')   --  l'état de la Relation Client 80040 =Fermée
 
update b_compte set date_close='2009.12.25',status=2 where NO_CLIENT in ('800206','800208')  -- l'état de la Relation Client conjoint 0002B =Fermée
 
Dans SSH/Putty:
 
1) Lancer le plugin:   cfLoader -ClientStatusProcessor -FIRM=FIRM_1
 
2)  cd  /home/marinag/CR1142
 
3) Lancer le plugin:  cfLoader -ClientLink --cpmafile="CR1142_FULL_CPMA.txt" -FIRM=FIRM_1
**/
  try {
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6788");
    var dateFermeture = "'2009.12.25'"
    var statusBcompte = "2";
    
    // Data pool
    var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    var Status_6787 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "columnType_6788", language+client); // État, Status
    var statusClosed = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "statusValueClosed", language+client); // Fermé, Closed
    
    Log.Message("Préparation des préconditions: Création des Relations client avec l'état Fermée.");
    etatPrep = PreparerRequis(dateFermeture, statusBcompte);
    if (etatPrep != true)
      Log.Error("La préparation des préconditions ne s'est pas déroulée correctement.");
    
    // Se connecter avec Keynej 
     Login(vServerRelations, userName, password, language);
    
    // Aller au Module Relations
    Log.Message("Aller au Module Relations");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    // Ajouter la colonne ‘État’, résultats attendus : La colonne ‘État’ s’affiche dans le browser.
    Log.Message("Ajouter la colonne État");
    SetDefaultConfiguration(Get_ClientsGrid_ChName());
    statut1 = Get_RelationshipsGrid_ChStatus().Exists;
    if (statut1 == true)
        visible1 = aqObject.CheckProperty(Get_RelationshipsGrid_ChStatus(), "VisibleOnScreen", cmpEqual, true);
    else
        visible1 = false;
    if (statut1 == false && visible1 == false) {
        Add_ColumnByLabel(Get_ClientsGrid_ChName(), Status_6787);
        statut2 = Get_RelationshipsGrid_ChStatus().Exists;
        visible2 = aqObject.CheckProperty(Get_RelationshipsGrid_ChStatus(), "VisibleOnScreen", cmpEqual, true);
        if (statut2 == true && visible2 == true) {
            Log.Message("Appuyer sur le filtre (Y+)");
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            // Sélectionner le champ ‘État’ / Sélectionner l'operateur: excluant / Valeur: Fermée / Appliquer.
            Get_Toolbar_BtnQuickFilters_ContextMenu_Item(Status_6787).Click();
            Get_WinCreateFilter_CmbOperator().Click();
            Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
            Get_WinCRUFilter_GridValue_Closed().Click();
            // Appuyer sur le bouton appliquer
            Log.Message("Appuyer sur le bouton appliquer");
            Get_WinCreateFilter_BtnApply().Click();
            
            /** Les Relations Client et les Relations Client conjoint qui ont l'État= Ouverte, sont affichées dans la grille.
            Les relations  qui n'ont pas de d'information sous la colonne État  sont également affichées . **/
            //.WPFObject("CellValuePresenter", "", 11).Value
            //.WPFObject("CellValuePresenter", "Open", 11).Value
            
            var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
            for (var i = 0; i < nbOfRelationships; i++){             
                var valeurStatut = VarToStr(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_StatusDescription());

                if (aqConvert.VarToStr(valeurStatut) != statusClosed){
                    Log.Checkpoint("Le type de status correspond au filtre appliqué.")                 
                }
                else{
                    Log.Error("Malgre le filtre 'Status excluding " +statusClosed +"', dans la colonne Status il y a une relation avec la valeur '" +statusClosed +"'.")
                }            
            }
            
            
            // Cliquer sur le 'X' du filtre pour supprimer
            Log.Message("cliquer sur le 'X' du filtre pour supprimer");
            Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
            
            Log.Message("Appuyer sur le filtre (Y+)");
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            // Sélectionner le champ ‘État’ / Sélectionner l'operateur: parmi / Valeur: Fermée / Appliquer.
            Get_Toolbar_BtnQuickFilters_ContextMenu_Item(Status_6787).Click();
            Get_WinCreateFilter_CmbOperator().Click();
            Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
            Get_WinCRUFilter_GridValue_Closed().Click();
            // Appuyer sur le bouton appliquer
            Log.Message("Appuyer sur le bouton appliquer");
            Get_WinCreateFilter_BtnApply().Click();
            
            // La relation 80040 est affichée dans le browser. Mais c'est le statut doit être validé (Closed / Fermée). //YR: The changes made by the story TCVE-3672 
            var nbOfRelationships = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
            for (var i = 0; i < nbOfRelationships; i++){             
                var valeurStatut = VarToStr(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_StatusDescription());

                if (aqConvert.VarToStr(valeurStatut) == statusClosed){
                    Log.Checkpoint("Le type de status correspond au filtre appliqué.")                 
                }
                else{
                    Log.Error("Malgre le filtre 'Status item among " +statusClosed +"', dans la colonne Status il y a une relation avec la valeur différente de '" +statusClosed +"'.")
                }            
            }
            
            // Cliquer sur le 'X' du filtre pour supprimer
            Log.Message("cliquer sur le 'X' du filtre pour supprimer");
            Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);   
        }
        else
          Log.Error("Erreur : L'ajout de la colonne État n'a pas fonctionné.");
    }
    else
        Log.Error("Erreur : La colonne État est déjà présente.");
  }
  catch (e) {
    if (Sys.WaitProcess("CroesusClient", 2000).Exists == false)
        Login(vServerRelations, userName, password, language);
    
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    if (Sys.WaitProcess("CroesusClient", 2000).Exists) {
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        SetDefaultConfiguration(Get_ClientsGrid_ChName());
        Terminate_CroesusProcess();
    }
  }
}

function Get_WinCRUFilter_GridValue_Closed()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "Value"], ["XamTextEditor", "Fermée"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "Value"], ["XamTextEditor", "Closed"], 10)}
}

function PreparerRequis(strDateClose, choixDeStatut)
{
  var retourPrep = undefined;
  try {
    Log.Message("Exécution des requêtes SQL.");
    nbLignes = Execute_SQLQuery("update b_compte set date_close=" +strDateClose +",status=" +choixDeStatut +" where NO_CLIENT in ('800400','800401')", vServerRelations);
    Log.Message(nbLignes +" lignes affectés par la requête SQL.");
    //nbLignes = Execute_SQLQuery("update b_compte set date_close=" +strDateClose +",status=" +choixDeStatut +" where NO_CLIENT in ('800206','800208')", vServerRelations);
    //Log.Message(nbLignes +" lignes affectés par la requête SQL."); // The changes made by the story TCVE-3672 
    Log.Message("Exécution des commandes SSH CFLoader.");
    ExecuteSSHCommandCFLoader("CR1142", vServerRelations, "cfLoader -ClientStatusProcessor -FIRM=FIRM_1", "marinag");
    ExecuteSSHCommandCFLoader("CR1142", vServerRelations, "cfLoader -ClientLink --cpmafile=\"CR1142_FULL_CPMA.txt\" -FIRM=FIRM_1", "marinag");
    Log.Message("Redémarage du VSERVER.");
    RestartServices(vServerRelations);
    retourPrep = true;
  }
  catch (e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    retourPrep = false;
  }
  finally {
    return retourPrep;
  }
}
