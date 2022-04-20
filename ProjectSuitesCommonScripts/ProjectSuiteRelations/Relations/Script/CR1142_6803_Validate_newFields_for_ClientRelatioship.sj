//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6803");  
        Résumé: Valider la création du critère de recherche par: Niveau de gestion, Date de fermeture, Type et État
             
        Analyste d'automatisation : Youlia Raisper
		    Module: Relations	 
		 
 */
function CR1142_6803_Validate_newFields_for_ClientRelatioship() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6803","Lien du Cas de test sur Testlink");
         
          var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var relationShipNo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "relationShipNo", language+client);
          var statusValue=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "statusValue", language+client);
          var typeValue=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "typeValue", language+client);
          var closingDateValue = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "closingDateValue", language+client); 
          var managementValue =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "managementValue", language+client);
          var relationShip80022 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "relationShip80022", language+client);
          var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Relationships\\"+language+"\\";
          var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Relationships\\"+language+"\\";  
          var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "CR1142_6803_80022", language+client);
           
          // Se connecter avec Keynej 
          Log.Message("Se connecter avec Keynej ")
          Login(vServerRelations, userName, psw, language);         
          Get_MainWindow().Maximize();
        
          // Aller au Module Relations
          Log.Message("Aller au Module Relations")
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          
          //Dans la grille ajouter les colonnes: Niveau de gestion, Type, État et Date de fermeture  
          Log.Message("Dans la grille ajouter les colonnes: Niveau de gestion, Type, État et Date de fermeture")       
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
          
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_Status().Click();           

          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ManagementLevel().Click();
          
          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ClosingDate().Click();          

          Get_RelationshipsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_Type().Click();
        
          //Les colonnes sont ajoutées dans la grille. 
          Log.Message("Les colonnes sont ajoutées dans la grille.") 
          aqObject.CheckProperty(Get_RelationshipsGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",39,language));
          aqObject.CheckProperty(Get_RelationshipsGrid_ChManagementLevel(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",40,language));
          aqObject.CheckProperty(Get_RelationshipsGrid_ChType(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",20,language));
          aqObject.CheckProperty(Get_RelationshipsGrid_ChClosingDate(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",41,language));
          
          //Sélectionner la relation 0001A et faire info Relation
          Log.Message("Sélectionner la relation 0001A et faire info Relation") 
          SearchRelationshipByNo(relationShipNo)
          Get_RelationshipsBar_BtnInfo().Click();
          /*État = Ouverte 
          Type =  Relation client 
          Est conjoint =  la case est cochée 
          Date de fermeture : vide 
          Niveau de gestion : Profil client*/ 
          CheckInfoWindowsproperties(typeValue,statusValue,closingDateValue,managementValue);
          aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkIsJoint(), "IsChecked", cmpEqual, true);     
          Get_WinDetailedInfo().Close();
          
          //Sélectionner la relation 80022 et faire info Relation.
          Log.Message("Sélectionner la relation 80022 et faire info Relation.")  
          SearchRelationshipByNo(relationShip80022)
          Get_RelationshipsBar_BtnInfo().Click();
          
          /*État = Ouverte
          Type =  Relation client 
          Est conjoint =  la case n'est pas cochée
          Date de fermeture : vide
          Niveau de gestion : Profil client*/
          CheckInfoWindowsproperties(typeValue,statusValue,closingDateValue,managementValue);
          aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkIsJoint(), "IsChecked", cmpEqual, false);   
          Get_WinDetailedInfo().Close();
          
          /*Sélectionner de nouveau la Relation Client (80022)
          Mailler vers le module Relations */
          Log.Message("Sélectionner de nouveau la Relation Client (80022).Mailler vers le module Relations") 
          SearchRelationshipByNo(relationShip80022)
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Relationships().OpenMenu();
          Get_MenuBar_Modules_Relationships_DragSelection().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          
          
          /* Faire un right click et  Exporter vers MS Excel...
          Valider l'affichage des colonnes avec ses valeurs dans le fichier Excel 
          Note: - Pour les Relations Client, la valeur de la colonne Est conjoint/Is Joint doit être = Non*/
          Log.Message("Faire un right click et  Exporter vers MS Excel...Valider l'affichage des colonnes avec ses valeurs dans le fichier Excel ") 
          Get_RelationshipsClientsAccountsGrid().ClickR();
          Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToMSExcel().Click();
          
          //fermer les fichiers excel
          Log.Message("fermer les fichiers excel") 
          CloseExcel();
                    
          //Comparer les deux fichiers
          Log.Message("Check data exported to excel "+ExpectedFile);
          ExcelFilesCompare(ExpectedFolder,ExpectedFile,ResultFolder);
          
          // Après la validation supprimer le critère en cliquant sur le X.
          Log.Message("Après la validation supprimer le critère en cliquant sur le X");
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
          
    } catch (e) {

          //S'il y a exception, en afficher le message
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          Login(vServerRelations, userName, psw, language); 
                 
    } finally {
          
          //fermer les fichiers excel
          CloseExcel();         
          //Delete files exported
          aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory+"\CroesusTemp\\*.txt");
           
           // Aller au Module Relations
          Get_ModulesBar_BtnRelationships().Click();          
          //Set the default configuration of columns in the grid
          SetDefaultConfiguration(Get_RelationshipsGrid_ChName());
          Terminate_CroesusProcess();
    }
}

function CheckInfoWindowsproperties(typeValue,statusValue,closingDateValue,managementValue){
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "Text", cmpEqual, typeValue); 
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbStatusForRelatioship(), "Text", cmpEqual, statusValue);   
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpClosingDate(), "StringValue", cmpEqual,closingDateValue );  
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbManagementlevel(), "Text", cmpEqual, managementValue);  
}