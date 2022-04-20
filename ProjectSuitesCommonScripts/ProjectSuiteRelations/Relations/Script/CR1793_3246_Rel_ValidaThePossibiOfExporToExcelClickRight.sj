//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/*
    Description :
                https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3246             
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module relation et faire un clic droit  et sélectionner Exporter vers MS Excel.:
                  Un fichier Excel est créé ou sont affiché tous les relations avec leur champs.
                  
                   
    Auteur : Sana Ayaz
*/

function CR1793_3246_Rel_ValidaThePossibiOfExporToExcelClickRight()
{
   try {
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3246", "CR1793_3246_Rel_ValidaThePossibiOfExporToExcelClickRight()");
       userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
       passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
       //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
       Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
       Get_ModulesBar_BtnRelationships().Click();
    
        //Récupérer la liste des relations
       var croesusRowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
       var arrayOfRelationshipsNames = new Array();
       for (var i = 0; i < croesusRowCount; i++){
            var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            arrayOfRelationshipsNames.push(displayedRelationshipName);
        }
    
        //Faire un clic droit et sélectionner Exporter vers MS Excel
        Get_RelationshipsClientsAccountsGrid().ClickR();
        Delay(100);
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToMSExcel().Click();
        Delay(100);
    
        //Fermer les fichiers Excel
        Delay(3000);
        while (Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
    
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
    
        //Comparer les relations de Croesus avec celles dans le fichier Excel
        for (var i = 0; i < arrayOfRelationshipsNames.length; i++){
            var croesusRelationshipName = arrayOfRelationshipsNames[i];
            var excelRelationshipName = (isJavaScript())? VarToStr(objExcel.Cells.Item(i + 2, 1)): VarToStr(objExcel.Cells(i + 2, 1)); // Le code sur la branche de RJ excelRelationshipName = VarToStr(objExcel.Cells(i + 2, 1));
            Log.Message("Line " + (i + 2) + " : the Relationship Name is " + excelRelationshipName);
       
            CheckEquals(excelRelationshipName, croesusRelationshipName, "The Relationship Name");
        }

        //Fermer Excel
        objExcelWorkbook.Close(false);
        objExcel.Quit();
    
        //Fermer Croesus
        Close_Croesus_SysMenu();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        TerminateProcess("EXCEL");
        Terminate_CroesusProcess();
    }
}
