//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Valider l'exportation vers MS Excel
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-611
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0611_Rel_Validate_export_to_MS_Excel()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-611", "CR1352_0611_Rel_Validate_export_to_MS_Excel()");
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
    
        //Récupérer la liste des relations
        var croesusRowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
        var arrayOfRelationshipsNames = new Array();
        for (var i = 0; i < croesusRowCount; i++){
            var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            arrayOfRelationshipsNames.push(displayedRelationshipName);
        }
        
        //Cliquer sur le menu "edition" puis "Exporter vers MS Excel"
        Get_MenuBar_Edit().Click();
        Get_MenuBar_Edit_ExportToMsExcel().Click();
        SetAutoTimeOut();
        //Fermer les fichiers Excel
        Delay(3000);
        while (Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
        RestoreAutoTimeOut(); 
        //Récupérer le chemin d'accès du dernier fichier se trouvant dans : C:\Users\"+user+"\AppData\Local\Temp\CroesusTemp\
        var folderPath= Sys.OSInfo.TempDirectory + "\CroesusTemp\\";
        Log.Message("The CroesusTemp folder path is : " + folderPath);
        var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        var filePath = FindLastModifiedFileInFolder(folderPath, fileNameContains);
        Log.Message("The output file path is : " + filePath);
        
        //Ouvrir avec Excel le fichier généré
        var objExcel = Sys.OleObject("Excel.Application");
        var objExcelWorkbook = objExcel.Workbooks.Open(filePath);
        objExcel.Visible = true;
        Log.Message(" CROES-7227");
        Log.Message("RJ: CROES-6215"); //YR: Merge RJ
        //Comparer les relations de Croesus avec celles dans le fichier Excel
        var colonne = 1;
        if (client == "CIBC")
            colonne = 2;
        for (var i = 0; i < arrayOfRelationshipsNames.length; i++){
            var croesusRelationshipName = arrayOfRelationshipsNames[i];
            var excelRelationshipName = (isJavaScript())? VarToStr(objExcel.Cells.Item(i + 2, colonne)): VarToStr(objExcel.Cells(i + 2, colonne)); // Le code sur la branche de RJ excelRelationshipName = VarToStr(objExcel.Cells(i + 2, 1));
            Log.Message("Excel Line " + (i + 2) + ": the Relationship Name is " + excelRelationshipName);
            CheckEquals(excelRelationshipName, croesusRelationshipName, "The Relationship Name");
        }
        
        //Fermer Excel
        objExcelWorkbook.Close(false);
        objExcel.Quit();
        
        //Fermer Croesus
        Close_Croesus_SysMenu();
    }
    catch(e){
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        TerminateProcess("EXCEL");
        Terminate_CroesusProcess();
    } 
}