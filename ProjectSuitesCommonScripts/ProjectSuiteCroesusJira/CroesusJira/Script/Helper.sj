//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

//USEUNIT Clients_Get_functions
//USEUNIT Common_MenuEdit_Get_functions


function MigrationVsever(vserverURL, referenceName, newVersionReference){
    
    try {  
            var devOpsDeploymentFilePath = folderPath_ProjectSuiteCommonScripts + "DevOps\\ReleaseFoundations\\current\\ReleaseFoundations.psm1";
            var prepareVserverFilePath   = folderPath_ProjectSuiteCommonScripts + "DevOps\\PrepareVserver\\PrepareVserver.psm1";
            
            var vserverName = GetVserverName(vserverURL)
            var migrationVserverOutputFile = Project.Path + 'MigrateVserverOutputFor_' + vserverName + '.txt';
         
            var databaseName = "qa_auto" + aqString.SubString(vserverURL, 19, 2);
  
            Log.Message("Nom du Vserveur: " + GetVserverName(vserverURL));

            var actualVserverReference = GetVServerReference(vserverName); 
            Log.Message("Reference actuelle du Vserveur: "+ actualVserverReference);
    
            if (referenceName == actualVserverReference){
                Log.Error("La nouvelle référence est identique à l'actuelle; Veuillez saisir une nouvelle et recommencer ")
                return;
            }
            else{ 
                if (!FindReferenceName(referenceName, devOpsDeploymentFilePath)){
                    Log.Error("La nouvelle référence n'existe pas dans la liste des références, veuillez choisir une nouvelle et recommencer......")
                    return
                }
                else{
                    Log.Message("La nouvelle référence est différente de l'actuelle: Mise-a-jour de la reference ");  
                    UpdateVserverReference(vserverName, referenceName, devOpsDeploymentFilePath);
                    Delay(30000);
                    var reference = GetVServerReference(vserverName); 
                    if (reference != referenceName){
                        Log.Error("La reference du vserveur n'est pas celle attendu, ")
                        return
                    }
                    else{
                        Log.Checkpoint("La reference a été modifiée avec succès");
                        
                        //Mettre à jour VERSION_LOGIN (variable globale versionReference) 
                        if (newVersionReference == versionReference)
                            Log.Message("La nouvelle valeur de la variable versionReference (VERSION_LOGIN) (" + newVersionReference + ") est identique à l'actuelle.");
                        else {
                            Log.Message("La nouvelle valeur de la variable versionReference (VERSION_LOGIN) (" + newVersionReference + ") est différente de l'actuelle (" + versionReference + ") : Mise-a-jour de VERSION_LOGIN...");
                            if (0 != aqFile.SetFileAttributes(filePath_ExecutionVServers, aqFileSystem.faNormal))
                                Log.Error("Erreur avec aqFile.SetFileAttributes(" + filePath_ExecutionVServers + ", aqFileSystem.faNormal)");
                            
                            WriteExcelSheet(filePath_ExecutionVServers, "COMMON_SCRIPTS", VERSION_LOGIN_ROW_NUM + 1, VERSION_LOGIN_COL_NUM + 1, newVersionReference);
                            var updatedVersionReference = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", VERSION_LOGIN_COL_NUM, VERSION_LOGIN_ROW_NUM);
                            CheckEquals(updatedVersionReference, newVersionReference, "versionReference new value read from: " + filePath_ExecutionVServers);
                            
                            Global_variables.versionReference = newVersionReference;
                            Log.Message("La nouvelle valeur de la variable versionReference (VERSION_LOGIN) est : " + newVersionReference);
                        }
                        
                        Log.PopLogFolder();
                        logEtape2 = Log.AppendFolder("Étape 2: mise-à-jour de l'assembleSript");
                        var isUpdateClientVserverAssembleScriptSuccessfull  = UpdateClientVserverAssembleScript(vserverURL, false);
                        Log.PopLogFolder();
                        if(!isUpdateClientVserverAssembleScriptSuccessfull){
                            Log.Error("La mise-à-jour de l'assembleSript a un problème")
                            return
                        }
                        else{  
                            Log.Message("La mise-à-jour de l'assembleSript a réussi, Migration du dump"); 
                            var MigrationReturnCode = MigrateVserver(vserverURL, referenceName, databaseName, prepareVserverFilePath, migrationVserverOutputFile);                           
                            Log.Message("La migration s'est terminée avec le code : " + Trim(aqFile.ReadWholeTextFile(migrationVserverOutputFile, aqFile.ctUTF8)) + "\r\n\r\n" + MigrationReturnCode);
                            aqFileSystem.DeleteFile(migrationVserverOutputFile);                            
                        }
                    }
                }
            }
        }
    catch(e){
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}

function GetVserverName(VServerURL){        
    
        return aqString.SubString(VServerURL, 7, 14)
}

function FindReferenceName(referenceName, devOpsDeploymentFilePath){
    
        var isfound = false;
        var PowerShell = dotNET.System_Management_Automation.PowerShell.Create();
        PowerShell.AddScript('Set-ExecutionPolicy Unrestricted -Scope Process -Force');
        PowerShell.AddScript('Import-Module "' + devOpsDeploymentFilePath + '" -Global -Force');
        PowerShell.AddScript('Get-Reference');
    
        var referencesObject = PowerShell.Invoke();
        for (i = 0; i < referencesObject.Count; i++){
            RefName = referencesObject.Item(i).ImmediateBaseObject.Name;
            if (RefName == referenceName){
                Log.Message("La reférence a été trouvée: " + RefName);
                isfound = true;
                break;
            }
        }
        PowerShell.Dispose();
        return isfound;
}

function UpdateVserverReference(VServerName, newReferenceName, devOpsDeploymentFilePath){
    
        var PowerShell = dotNET.System_Management_Automation.PowerShell.Create();
        Log.Message("Update Vserver Reference : " + VServerName)
        PowerShell.AddScript('Set-ExecutionPolicy Unrestricted -Scope Process -Force');
        PowerShell.AddScript('Import-Module "' + devOpsDeploymentFilePath + '" -Global -Force');
        PowerShell.AddScript('Edit-VServer -VServerName "'+ VServerName + '" -Reference "' + newReferenceName + '"');
        
        var UpdateVseverReturnCode  = PowerShell.Invoke();
        PowerShell.Dispose();
        return UpdateVseverReturnCode;
}

function MigrateVserver(vserverURL, referenceName, databaseName, prepareVserverFilePath, migrationVserverOutputFile){
        
        var succesCode = "MIGRATION COMPLETED.";
        var PowerShell = dotNET.System_Management_Automation.PowerShell.Create();
        Log.Message("Migrate Vserver  : " + vserverURL)
        PowerShell.AddScript('Set-ExecutionPolicy Unrestricted -Scope Process -Force');
        PowerShell.AddScript('Import-Module "' + prepareVserverFilePath + '" -Global -Force');
        PowerShell.AddScript('MigrateVserver -VServerURL "' + vserverURL + '" -ReferenceName "' + referenceName + '" -DatabaseName "' + databaseName + '" -SuccessReturnCode "' + succesCode + '" > "' +  migrationVserverOutputFile + '"');
        
        var MigrationReturnCode = PowerShell.Invoke();
        PowerShell.Dispose();
        
        //Christophe : Optimisation
        ConvertFileToUtf8WithoutBOM(migrationVserverOutputFile);
        var powershellOutput = [];
        for (var j = 0; j < MigrationReturnCode.Items.Count; j++)
            powershellOutput.push(Trim(VarToStr(MigrationReturnCode.Items.Item(j).BaseObject)));
        powershellOutput = powershellOutput.join("\r\n");
        return powershellOutput;
        
        //return MigrationReturnCode;
}


function ValidateColumns(listOfColumns, modulName){
            
          var attr = Log.CreateNewAttributes();
               attr.Bold = true;
          var arrayOfColunms = listOfColumns.split("|");
          
        switch(modulName){
        case "Relation", "Compte", "Client":
        {                 
            Log.Message("Valider les colonnes de: " + modulName);  
            for (j in arrayOfColunms){
                if (!aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ColumnHeader(arrayOfColunms[j]), "Exists", cmpEqual, true) ||
                    !aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ColumnHeader(arrayOfColunms[j]), "VisibleOnScreen", cmpEqual, true))
                    Log.Error("La colonne '" + arrayOfColunms[j] + "' n'est visible", "", pmNormal, attr)
            }                
            break;
        }
        case "Titre":
        {  
            Log.Message("Valider les colonnes de: " + modulName);  
            for (j in arrayOfColunms){
                if (!aqObject.CheckProperty(Get_SecurityGrid_ColumnHeader(arrayOfColunms[j]), "Exists", cmpEqual, true) ||
                    !aqObject.CheckProperty(Get_SecurityGrid_ColumnHeader(arrayOfColunms[j]), "VisibleOnScreen", cmpEqual, true))
                    Log.Error("La colonne '" + arrayOfColunms[j] + "' n'est visible", "", pmNormal, attr)
            }                              
            break;
        }
        case "Modèle":
        {  
            Log.Message("Valider les colonnes de: " + modulName);  
            for (j in arrayOfColunms){
                if (!aqObject.CheckProperty(Get_ModelsGrid_ColumnHeader(arrayOfColunms[j]), "Exists", cmpEqual, true) ||
                    !aqObject.CheckProperty(Get_ModelsGrid_ColumnHeader(arrayOfColunms[j]), "VisibleOnScreen", cmpEqual, true))
                    Log.Error("La colonne '" + arrayOfColunms[j] + "' n'est visible", "", pmNormal, attr)
            }                
            break;
        }
        case "Ordre":
        {  
            Log.Message("Valider les colonnes de: " + modulName);  
            for (j in arrayOfColunms){
                if (!aqObject.CheckProperty(Get_OrderGrid_ColumnHeader(arrayOfColunms[j]), "Exists", cmpEqual, true) ||
                    !aqObject.CheckProperty(Get_OrderGrid_ColumnHeader(arrayOfColunms[j]), "VisibleOnScreen", cmpEqual, true))
                    Log.Error("La colonne '" + arrayOfColunms[j] + "' n'est visible", "", pmNormal, attr)
            }                
            break;
        }                  
        case "Portefeuille":
        {  
            Log.Message("Valider les colonnes de: " + modulName);  
            for (j in arrayOfColunms){
                if (!aqObject.CheckProperty(Get_Portfolio_ColumnHeader(arrayOfColunms[j]), "Exists", cmpEqual, true) ||
                    !aqObject.CheckProperty(Get_Portfolio_ColumnHeader(arrayOfColunms[j]), "VisibleOnScreen", cmpEqual, true))
                    Log.Error("La colonne '" + arrayOfColunms[j] + "' n'est visible", "", pmNormal, attr)
            }                
            break;
        }
        }           
}

function AddProfil(profilsList, i, isSecurities){
    
        var itemProfiles = "Profiles";
        if (language == "french") itemProfiles = "Profils";
        var arrayOfProfils = profilsList.split("|");

        //Ouvrir la fenêtre Info/Profil
        if(isSecurities){
            Get_SecuritiesBar_BtnInfo().Click();
            Get_WinInfoSecurity_TabProfiles().Click();
            WaitObject(Get_WinInfoSecurity(), "Uid", "Button_06f8", 3000);
        }else {
            Get_RelationshipsClientsAccountsBar_BtnSplitDropDown(i).Click();
            Get_SubMenus_Item(itemProfiles).Click();
            WaitObject(Get_WinDetailedInfo(), "Uid", "Button_06f8", 3000);
        }
             
        Get_WinInfo_TabProfile_BtnSetup().Click();
        
        for (j in arrayOfProfils){
            var profilEmpl = Get_WinVisibleProfilesConfiguration_ChkProfile(arrayOfProfils[j]);
            Log.Message(arrayOfProfils[j] + " état est : " + profilEmpl.get_IsChecked())
            if(profilEmpl.get_IsChecked() == false){                
                profilEmpl.Click();
//                Get_WinVisibleProfilesConfiguration().Find("Value",revenuBrut,10).WaitProperty("IsChecked", true, 10000);
            }
        }
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        if(isSecurities)
            Get_WinInfoSecurity_BtnOK().Click();
        else
            Get_WinDetailedInfo_BtnOK().Click();
}

function AddListOfColumns(columnClickR, listOfColumns){
    
        var arrayOfColunms = listOfColumns.split("|");
        for (j in arrayOfColunms){
            Add_ColumnByLabel(columnClickR, arrayOfColunms[j])
        }
}

function AddListOfProfils(columnClickR, listOfProfils){
    
        var arrayOfProfils = listOfProfils.split("|");
        
        for (j in arrayOfProfils){   
            columnClickR.ClickR();
            columnClickR.ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
            Get_GridHeader_ContextualMenu_AddColumn_Profiles().Click();
            Delay(1000)
            Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlText"], ["TextBlock", arrayOfProfils[j]], 10).Click();
        }        
}

function Get_RelationshipsClientsAccountsBar_BtnSplitDropDown(i){       //Relations:1;  Clients:2;  Comptes:3
    return Get_RelationshipsClientsAccountsBar().WPFObject("SplitDropDownButton", "_Info", i).WPFObject("PART_Menu")}
        
function Get_SubMenus_Item(itemName){
    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", itemName], 10)}
    
function Get_RelationshipsClientsAccountsGrid_ColumnHeader(columnHeader){
    return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", columnHeader], 10)}
 
function Get_SecurityGrid_ColumnHeader(columnHeader){
    return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", columnHeader], 10)}
  
function Get_ModelsGrid_ColumnHeader(columnHeader){
    return Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", columnHeader], 10)}
        
function Get_OrderGrid_ColumnHeader(columnHeader){
    return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", columnHeader], 10)}
    
function Get_Portfolio_ColumnHeader(columnHeader){
    return Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", columnHeader], 10)}