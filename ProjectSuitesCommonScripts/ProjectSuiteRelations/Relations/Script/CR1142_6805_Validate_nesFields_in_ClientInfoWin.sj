//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6803");  
        Résumé: Valider les nouveaux champs dans la fenêtre Info client pour les Relations Client et pour les Relations client conjoint, module Clients
             
        Analyste d'automatisation : Youlia Raisper
		    Module: Relations	 
		 
 */
function CR1142_6805_Validate_nesFields_in_ClientInfoWin() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6805","Lien du Cas de test sur Testlink");
         
          var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var relationShip80022 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "relationShip80022", language+client);
          var rootRelationship =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "rootRelationship", language+client);
          var relationShip0001A = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "relationShip0001A", language+client)          
          var statusValue=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "statusValue1", language+client);
          var typeValue=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "typeValue", language+client);
          var managementValue =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "managementValue", language+client);
          var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Relationships\\"+language+"\\";
          var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Relationships\\"+language+"\\";  
          var ExpectedFile = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "CR1142_6805_0001A", language+client)
           
          // Se connecter avec Keynej 
          Log.Message("Se connecter avec Keynej ")
          Login(vServerRelations, userName, psw, language);         
          Get_MainWindow().Maximize();
        
          // Aller au Module Relations
          Log.Message("Aller au Module Relations")
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          
          //Sélectionner une Relation Client  80022
          Log.Message("Sélectionner une Relation Client  80022")
          SearchRelationshipByNo(relationShip80022);
          
          //Mailler vers le module Clients
          Log.Message("Mailler vers le module Clients")
          Drag(Get_RelationshipsClientsAccountsPlugin().Find("Value",relationShip80022,10), Get_ModulesBar_BtnClients());
          
          //Ajouter les colonnes: Niveau de gestion   /  No relation Client   et État
          Log.Message("Ajouter les colonnes: Niveau de gestion   /  No relation Client   et État")   
          SetDefaultConfiguration(Get_ClientsGrid_ChName()); 
          
          Get_ClientsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ClientRelationshipNo().Click();           

          Get_ClientsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_ManagementLevel().Click();
          
          Get_ClientsGrid_ChName().ClickR();
          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
          Get_GridHeader_ContextualMenu_AddColumn_StatusForClients().Click();           
          
          //Les colonnes sont ajoutées dans la grille. 
          Log.Message("Les colonnes sont ajoutées dans la grille.") 
          aqObject.CheckProperty(Get_ClientsGrid_ChStatus(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",39,language));
          aqObject.CheckProperty(Get_ClientsGrid_ChManagementLevel(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",40,language));
          aqObject.CheckProperty(Get_ClientsGrid_ChClientRelationshipNo(), "Content", cmpEqual, GetData(filePath_Relations,"Grid_column_header",42,language));
          
          /*Dans la section Détails.Dans la hiérarchie se postionner sur la relation 80022.Section de droite / onglet Info*/
          Log.Message("Dans la section Détails.Dans la hiérarchie se postionner sur la relation 80022.Section de droite / onglet Info*/")
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Value",relationShip80022,10).Click();
          Get_RelationshipsDetails_TabInfo().Click();
          
         
          /*L'image  est affichée de côté gauche du nom d'Interlocuteur dans l'onglet Info */
          Log.Message("Valider que L'image existe et visible")
          var image = Get_RelationshipsClientsAccountsDetails().zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("Image", "", 1) 
          var name =Get_RelationshipsClientsAccountsDetails().zsummary.SummaryPanel.ContentControl.WPFObject("LinkSummary", "", 1).WPFObject("_tabCtrl").WPFObject("InfoPage", "", 1).WPFObject("CFTextBlock", "", 1)
          aqObject.CheckProperty(image, "Exists", cmpEqual, true);  
          aqObject.CheckProperty(image, "VisibleOnScreen", cmpEqual, true);  
          
          Log.Message("Valider que L'image  est affichée de côté gauche du nom d'Interlocuteur dans l'onglet Info")          
          var positionImageScreenLeft = image.ScreenLeft
          var positionImageScreenTop = image.Screentop         
          var positionNameScreenLeft = name.ScreenLeft
          var positionNameScreenTop = name.Screentop
                   
          if(positionImageScreenLeft < positionNameScreenLeft && positionImageScreenTop == positionNameScreenTop){
            Log.Checkpoint("L'image  est affichée de côté gauche du nom d'Interlocuteur");
          }else{
            Log.Error("L'image n'est pas affichée de côté gauche du nom d'Interlocuteur");
          }
         
          /*Retrouner dans le module relation et sélectionner la relation 0001A*/
          Log.Message("Retrouner dans le module relation et sélectionner la relation 0001A")
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
                   
         /*Mailler vers client*/
          Log.Message("Mailler vers le module Clients")
          SearchRelationshipByNo(relationShip0001A);
          Drag(Get_RelationshipsClientsAccountsPlugin().Find("Value",relationShip0001A,10), Get_ModulesBar_BtnClients());
          
          /*faire Info client sur le premier client de la liste  */
          Log.Message("faire Info client sur le premier client de la liste")
          Get_ClientsBar_BtnInfo().Click();
         
          /*État = Ouvert
          Est conjoint = case cochée
          Niveau de gestion = Profil client
          No relation client = 0001A*/
          aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatus(), "Text", cmpEqual, statusValue);   
          aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkIsJoint(), "IsChecked", cmpEqual, true);           
          aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtManagementlevel(), "Text", cmpEqual, managementValue); 
          aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtClientRelationshipNo(), "Text", cmpEqual, relationShip0001A); 
          Get_WinDetailedInfo().Close(); 
          
          /*Appuyer sur l'icône Export vers MS Excel... */   
          Log.Message("Appuyer sur l'icône Export vers MS Excel...  ") 
          Get_RelationshipsClientsAccountsGrid().Find(["ClrClassName","WPFControlOrdinalNo"],["Button","3"],10).Click();
          
          //Valider le fichier Excel.la validation de fichier Excel est faite par rapport à la référence sauvegardée dans le projet  
          Log.Message("Valider le fichier Excel.la validation de fichier Excel est faite par rapport à la référence sauvegardée dans le projet ")
          
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
