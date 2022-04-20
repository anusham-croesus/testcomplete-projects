//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
    Description : Vérifie dans le module Relations que lorsqu'on sélectionne plusieurs entrées avec la combinaison du SHIFT + le rollover de la souris,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
    Scripté sur la version : ref90-05-8--V9-CX_1-co6x
*/
function CR1352_CROES_6243_Rel_TestDeSelectionMultipleAvecShift_MouseWheel()
{
    CR1352_CROES_6243_Rel_TestDeSelectionMultipleAvecShift("MouseWheel");
}



/**
    Description : Vérifie dans le module Relations que lorsqu'on sélectionne plusieurs entrées avec la touche SHIFT,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
*/
function CR1352_CROES_6243_Rel_TestDeSelectionMultipleAvecShift(selectionMethod)
{
    if (GetIndexOfItemInArray(["MouseWheel", "DownKey", "ScrollDown"], selectionMethod) == -1){
        Log.error(selectionMethod + " not expected for the selectionMethod parameter.");
        return;
    }
    
    try {
        /*********** Ajouter beaucoup de relations pour avoir plusieurs pages *********/
        
        AddRelationships();
        
        /************  Se connecter et aller au module Relations  ************/
        
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        Login(vServerRelations, userNameGP1859, passwordGP1859, language);
        Get_MainWindow().Maximize(); //Pour qu'il n'y ait pas de barre de défilement horizontale.
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        /************  Sélectionner toute la grille des Comptes à l'aide de la touche SHIFT  ************/
        
        //Naviguer à la première ligne
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        //Cliquer sur la première ligne
        firstRowRelationshipName = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ShortName());
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", firstRowRelationshipName, 10).Click();
        
        //Récupérer le nombre total de relations
        Get_Toolbar_BtnSum().Click();
        relationshipsTotalCount = Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Value.get_CountLink();
        Log.Message("The Relationships total count is : " + relationshipsTotalCount);
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        //Maintenir la touche SHIFT enfoncée
        Sys.Desktop.KeyDown(0x10);
        
        //Naviguer à la dernière page
        if (selectionMethod == "MouseWheel"){
            for (var i = 0; i < relationshipsTotalCount; i++)
                Get_RelationshipsClientsAccountsGrid().MouseWheel(-1);
        }
        else if (selectionMethod == "DownKey"){
            for (var i = 0; i < relationshipsTotalCount; i++)
                Get_RelationshipsClientsAccountsGrid().Keys("[Down]");
        }
        else if (selectionMethod == "ScrollDown")
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 30);
        
        //Dans le cas du MouseWheel et du ScrollDown, cliquer sur la dernière ligne 
        if (selectionMethod == "MouseWheel" || selectionMethod == "ScrollDown"){
            relationshipsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
            lastRowRelationshipName = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(relationshipsPageCount - 1).DataItem.get_ShortName());
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", lastRowRelationshipName, 10).Click();
        }
            
        //Relâcher la touche Shift
        Sys.Desktop.KeyUp(0x10);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        /************  Vérifier que toutes les lignes ont été sélectionnées  ************/
        
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
        arrayOfAllRelationshipsNames = new Array();
        nbOfUnselectedRelationships = 0;
        nbOfSelectedRelationships = 0;
        
        while (arrayOfAllRelationshipsNames.length < relationshipsTotalCount){
            relationshipsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
            
            for (var i = 0; i < relationshipsPageCount; i++){
                displayedRelationshipName = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_ShortName());
                isFound = false;
                for (var j = 0; j < arrayOfAllRelationshipsNames.length; j++){
                    if (displayedRelationshipName == arrayOfAllRelationshipsNames[j]){ 
                        isFound = true;
                        break;
                    }
                }
			    
                if (!isFound){
                    arrayOfAllRelationshipsNames.push(displayedRelationshipName);
                    isRowSelected = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).get_IsSelected();
                    if (isRowSelected)
                        nbOfSelectedRelationships ++;
                    else
                        nbOfUnselectedRelationships ++;
    			}
            }
            
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        }
        
        Log.Message("The number of unselected relationships is : " + nbOfUnselectedRelationships);
        CheckEquals(nbOfSelectedRelationships, relationshipsTotalCount, "The number of selected relationships");
        
        if (nbOfSelectedRelationships < relationshipsTotalCount){
        if(client == "US" ){ Log.Error("Bug CROES-6800");}
           else {Log.Error("Bug CROES-6243");}
        } 
           
            
        Get_MainWindow().Restore();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Sys.Desktop.KeyUp(0x10); //Relâcher la touche Shift
        Terminate_CroesusProcess(); //Fermer Croesus
        DeleteRelationships(); //Supprimer les relations ajoutées
    }
}



function AddRelationships()
{
    var relationshipsNamesPrefix = "CROES-6243";
    var nbOfRelationships = 200;
    
    var rep_id = Execute_SQLQuery_GetField("select rep_id from b_rep where no_rep = 'BD66'", vServerRelations, "REP_ID");
    var firm_id = 1;
    
    for (var i = 1; i <= nbOfRelationships; i++){
        var relationshipName = relationshipsNamesPrefix + "-" + IntToStr(i);
        var lineSQL = "insert into b_link (shortname, fullname, currency, no_rep, firm_id, rep_id) values ('" + relationshipName + "', '" + relationshipName + "', 'CAD', 'BD66', " + firm_id + "," + rep_id + ")";
        Log.Message("SQL query : " + lineSQL);
        Execute_SQLQuery(lineSQL, vServerRelations);
    }    
}



function DeleteRelationships()
{
    var relationshipsNamesPrefix = "CROES-6243";
    var lineSQL = "delete from b_link where shortname like '%" + relationshipsNamesPrefix + "%'";
    Log.Message("SQL query : " + lineSQL);
    Execute_SQLQuery(lineSQL, vServerRelations);
}