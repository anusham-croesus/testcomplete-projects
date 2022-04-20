//USEUNIT Common_functions
//USEUNIT DBA



/**
    Description : Valider l'exportation vers MS Excel d'une partie des relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-612
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0612_Rel_Validate_export_to_MS_Excel_of_some_relationships()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-612", "CR1352_0612_Rel_Validate_export_to_MS_Excel_of_some_relationships()");
    
    var nbOfRelationships = 5;
    var arrayOfRelationships = new Array();    
    
    try {
        Login(vServerRelations, userName, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        //Ajouter plusieurs relations
        Log.Message("Add " + nbOfRelationships + " relationships.");
        for (var i = 1; i <= nbOfRelationships; i++){
            var relationshipName = "CR1352_0612_RL" + i;
            arrayOfRelationships.push(relationshipName);
            CreateRelationship(relationshipName);
        }
        
        //Sélectionner toutes les relations ajoutées
        Log.Message("Select all the added relationships and click on the Delete button.");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            var found = false;
            for (var j = 0; j < arrayOfRelationships.length; j++){
                if (displayedRelationshipName == arrayOfRelationships[j]){ 
                    found = true;
                    break;
                }
            }
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(found);
        }
        
        //Faire CTRL + C (Copier)
        Get_RelationshipsClientsAccountsGrid().Keys("^c"); 
        Delay(300);
        
        /******************************************************************************/
        //Put the arrayOfAccountsNo content in the temporary file, close Croesus, retrieve arrayOfAccountsNo content
        var arrayOfRelationShipFilePath = ProjectSuite.Path + "CR1352_0612_arrayOfRelationShip.txt";
        CreateFileAndWriteText(arrayOfRelationShipFilePath, arrayOfRelationships);
        Close_Croesus_SysMenu();
        Terminate_CroesusProcess();
        var arrayOfRelationShipFileContent = aqFile.ReadWholeTextFile(arrayOfRelationShipFilePath, aqFile.ctANSI);
        arrayOfRelationships = arrayOfRelationShipFileContent.split(",");
        aqFileSystem.DeleteFile(arrayOfRelationShipFilePath);
        
        
        /****************************************************************************/
        //Coller dans un nouveau fichier Excel
        TerminateProcess("EXCEL");
        WshShell.Run("EXCEL");
        Sys.WaitProcess("EXCEL", 60000);
        //Sys.Process("EXCEL").Window("XLMAIN").Activate();
        var objExcel = Sys.OleObject("Excel.Application");
        objExcel.Visible = true;
        var objExcelWorkbook = objExcel.Workbooks.Add();
        Delay(2000);
        Sys.Keys("^v");
        
        //Valider le nombre de relations présentes dans le fichier Excel
        var excelRowCount = objExcel.ActiveSheet.UsedRange.Rows.Count;
        CheckEquals(excelRowCount, arrayOfRelationships.length, "The number of relationships")
        Log.Message(" CROES-7227");
        Log.Message("RJ: CROES-6215");//YR: Merge RJ
        
        //Comparer les relations sélectionnées dans Croesus avec celles dans le fichier Excel
        for (var i = 0; i < arrayOfRelationships.length; i++){
            var croesusRelationshipName = arrayOfRelationships[i];
            var excelRelationshipName = (isJavaScript())? VarToStr(objExcel.Cells.Item(i + 1, 1)): VarToStr(objExcel.Cells(i + 1, 1));
            Log.Message("Excel line " + (i + 1) + ": the Relationship Name is " + excelRelationshipName); //Le code sur la branche de RJ excelRelationshipName = VarToStr(objExcel.Cells(i + 1, 1));
            CheckEquals(excelRelationshipName, croesusRelationshipName, "The Relationship Name")
        }
        
        //Close Excel without prompt
        objExcelWorkbook.Close(false);
        objExcel.Quit();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.Message("Delete added Relationships : " + arrayOfRelationships);
        for (var i = 0; i < arrayOfRelationships.length; i++)
            Execute_SQLQuery("delete from B_LINK where SHORTNAME = '" + arrayOfRelationships[i] + "'", vServerRelations);

        TerminateProcess("EXCEL");
        Terminate_CroesusProcess();
    }
}
