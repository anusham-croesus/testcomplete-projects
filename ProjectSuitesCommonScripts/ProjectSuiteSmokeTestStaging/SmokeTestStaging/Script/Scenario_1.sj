//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4307
    
   
    Description :le but de ce scénario est de pouvoir le lancer sur n'importe quel environnement (interne, staging)
           
    Auteur : Karima Mehinguene
    Analyste auto : Alhassane Diallo
    
    Version : 90.22.2020.12-19
    
    Date: 18/01/2021
*/

function Scenario_1()
{
  try{
    

    Log.Link("https://jira.croesus.com/browse/TCVE-4029", "TCVE-4029");
    
/*********************************************Variables*******************************************************************************************/
     var userName       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
     var password       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
     var userDESLAUJE   = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "username");
     var pswDESLAUJE    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJEstaging", "psw");

     var filterName        = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "FILTER_TOTAL_VALUE_1", language+client)
     var filterType        = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "FilterName", language+client)
     var filterValue       = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "FILTER_VALUE", language+client)
     var SortByTotalValue  = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "SortByTotalValue", language+client)
     var columnName        = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "columnName", language+client) 
     var reportNameEval    = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "Report_Name_Evaluation", language+client);
        
     var addNote           = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "ajoutNote", language+client);
     var addSentence       = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "ajoutPhrase", language+client);
     var phrasePredefinie  = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "phrasePredefinie", language+client);
     var phraseModifiee    = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "phraseModifiee", language+client);
     var totalValue        = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "TotalValue", language+client);
     var defaultList       = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "SmokeTestStaging", "defaultList", language+client);
     
      /******************************************************************************Étape1******************************************************************/
      //Accès au module client
      Log.PopLogFolder();
      logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec sysadmin( keynej, deslauje) Dans le module clients , appliquer un filtre rapide sauvegardé ValeurTotale est plus grande que 1000000");

      //La solution temporaire YR
      if(StrContains("nfr", vServerSmokeTest, false))
      Login(vServerSmokeTest, userDESLAUJE, password, language);//http://nfrtestqa1.croesus.local/
        else if(StrContains("staging", vServerSmokeTest, false))
      Login(vServerSmokeTest, userDESLAUJE, pswDESLAUJE, language);//https://fbnstaging.accessproxy.croesus.local/
        else
      Login(vServerSmokeTest, userName, psw, language);

      Get_ModulesBar_BtnClients().Click();    
      Get_MainWindow().Maximize();
    
       //Ajouter un fitre sur les clients dont la valeur totale est superieure a 1000 000 
       Log.Message("Ajouter un fitre sur les clients dont la valeur totale est superieure a 1000 000")
       Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
       Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
       Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
       Get_Toolbar_BtnQuickFilters_ContextMenu_Item(filterType).Click();
       Get_WinCreateFilter_CmbOperator().DropDown();
       Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
       Get_WinCreateFilter_TxtValueDouble().Keys(filterValue);
       Get_WinCreateFilter_BtnSaveAndApply().Click();
       Get_WinSaveFilter_TxtName().Keys(filterName);
       Get_WinSaveFilter_BtnOK().Click();
     
   
        /**********************************************************************Étape2**************************************************************************/
        Log.PopLogFolder();
        logEtape2= Log.AppendFolder("Étape 2:Trier la colonne valeur totale  ");
        Get_ClientsGrid_ChTotalValue().Click();
        scroll();
        //Check_columnAlphabeticalSort_old(Get_RelationshipsClientsAccountsGrid(),totalValue, SortByTotalValue)//???
        Check_columnAlphabeticalSort_old(Get_RelationshipsClientsAccountsGrid(),totalValue, "TotalValue")  
    
        /***************************************************************Étape3*************************************************************/  
        Log.PopLogFolder();
        logEtape3= Log.AppendFolder("Étape 3: Sélectionner les 5 premieres positions qui n'ont pas de notes  "); 
        var clientArray = new Array();
        var count = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count;
        var i=0;      
        while(clientArray.length < 5 && i < count){
        var clientNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber);  
            clientArray.push(clientNumber);        
        i++;
           
        }
            
          var selectedclientArray = clientArray.join(",");   
          Log.Message(selectedclientArray)   
               
          //Sélectionner les 5 clients      
          for(var i = 0; i < clientArray.length; i++){
                 var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientArray[i], 10); 
                 if (clientNumberCell.Exists)
                    clientNumberCell.Click(-1, -1, skCtrl);
                 else
                    Log.Error("Le client '" + clientNumberCell[i] + "' n est pas trouvé.");
         };
      
          //Cliquer sur espace pour ajouter ne selectionnerque les 5 clients 
          Log.Message("Cliquer sur espace pour ajouter ne selectionnerque les 5 clients ")
          Get_RelationshipsClientsAccountsGrid().Keys(" ");
          
          
    
        /**************************************************************************Étape4**************************************************************************/
          Log.PopLogFolder();
          logEtape4= Log.AppendFolder("Étape 4: Cliquer sur le critère de recherche pour l'activer  "); 
          Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().FindChild("WPFControlText",defaultList, 10).Click();
      
    
        /*********************************************************************Étape5*************************************************************************/          
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: Exporter les 5 client dans un fichier Excel  "); 
          Get_RelationshipsClientsAccountsGrid_BtnExportToMSExcel().Click();
          
          //fermer les fichier excel
          while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
          }
           
          //Vérifier que le fichier Excel généré 
          if(Sys.Process("EXCEL").Exists){
              Log.Checkpoint("Le fichier Excel est ouvert")
          } 
          else{
              Log.Error("Le fichier Excel n'est pas ouvert")
          }; 
        
                
          var sTempFolder = Sys.OSInfo.TempDirectory;
          var FolderPath= sTempFolder+"\CroesusTemp\\"
          Log.Message(FolderPath)
          var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
          Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains))
    
          var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
    
          // Reads text lines from the file and posts them to the test log 
          var countLineInMyFile=0; // les lignes dans le fichier txt 
               
          while(! myFile.IsEndOfFile()){    
            countLineInMyFile++;
            line = myFile.ReadLine();
            // Split at each space character.                              
          };
         
          Log.Message("Le nombre de ligne dans le fichier excel est "+countLineInMyFile)

          //Vérifier que le fichier ne contient  que 5 clients. 
          Log.Message("Valider quele fichier  généré ne contient  que 5 clients." );               
          if (countLineInMyFile == 6){
             Log.Checkpoint("Le fichier contient que 5 clients avec la ligne d'entête");
          } 
          else {
             Log.Error("Le fichier ne contient pas que 5 clients. avec la ligne d'entête");
          };
 
          // Closes the file
          myFile.Close();
           
          //fermer les fichier excel
          while(Sys.waitProcess("EXCEL").Exists){
              Sys.Process("EXCEL").Terminate();
          };
           
        /**************************************************************************Étape6*************************************************************************/
         Log.PopLogFolder();
         logEtap6= Log.AppendFolder("Étape 6: Sélectionner les 5 premieres positions qui n'ont pas de notes  ");   
         Get_Toolbar_BtnReportsAndGraphs().Click();
         WaitReportsWindow();
         Delay(3000);
    
          //Sélectionner le rapport et cocher la case Archiver les rapports
          SelectRepport();
          Delay(3000);
          Get_WinReports_GrpOptions_ChkArchiveReports().Click();

          //Valider le rapport
          ValidateReport()  
          WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
    
                  
        /*****************************************************************Étape7************************************************************************/
          Log.PopLogFolder();
          logEtap7= Log.AppendFolder("Étape 7 et 8: Sélectionner le premier client et ajouter une note puis Modifier puis supprimer la note  "); 
          var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientArray[0], 10).Click(); 
          add_modified_delete_Note(addNote, addSentence, phraseModifiee)
      
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
 
          DeletePredefinedSentences(addNote)
          //Desctiver le filtre par defaut
          Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove().Click(); 
     
          //Supprimer le filtre créé
          Delete_FilterCriterion(filterName)//Supprimer le filtre de BD  
    
          Terminate_CroesusProcess();
          TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits      
          Runner.Stop(true); 
      }        
} 

//fonction pour supprimer le filter ajouter   
function Delete_FilterCriterion(filterName){
    
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Parent.Maximize();
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filterName,10).Click()
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete().Click();          
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Close();
}

//fonction pour supprimer la note ajouter 
function DeletePredefinedSentences(namePredefinSentence){

      //Sélectionner la phrase prédéfinie et la supprimer
     Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
     Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",namePredefinSentence, 10).Click();
     Get_WinCRUANote_BtnDeletePredefinedSentences().Click();
           
     //Vérifier que le bouton Spprimer n'est pas grisée
     aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, true);
     //Confirmer la suppresssion
     var width = Get_DlgConfirmation().Get_Width();
     Get_DlgConfirmation().Click((width*(1/3)),73);
           
     Get_WinCRUANote_BtnClose().Click();
     Get_WinDetailedInfo_BtnOK().Click();
}

//fonction qui ajoute, modifie et supprime une note pour un client donné
function add_modified_delete_Note(addNote, addSentence, phraseModifiee){
             
    Get_ClientsBar_BtnInfo().Click();
    Get_WinInfo_Notes_TabGrid().Click();
    Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
    
    //Cliquer sur Ajouter et remplir les champs Nom et Phrase
    Get_WinCRUANote_BtnAddPredefinedSentences().Click();
    Get_WinAddNewSentence_TxtName().Keys(addNote);
    Get_WinAddNewSentence_TxtSentence().Keys(addSentence);
    Get_WinAddNewSentence_BtnSave().Click();
    
     //Valider l'affichage des deux notes dans Phrases prédéfinies
     aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", addNote, 10),"Exists", cmpEqual, true)
     aqObject.CheckProperty(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", addNote, 10),"VisibleOnScreen", cmpEqual, true)
   
     

     Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", addNote, 10).Click();
     Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
     Get_WinCRUANote_BtnSave().Click();
     
     //Valider l'affichage de la note    
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", addSentence, 10),"Exists", cmpEqual, true)
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", addSentence, 10),"VisibleOnScreen", cmpEqual, true)
     
     //Modifier la note ajouté 
     Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", addSentence, 10).Click();
     Get_WinInfo_Notes_TabGrid_BtnEdit().Click();
     Get_WinCRUANote_GrpNote_TxtNote().Keys("^a");
     Get_WinCRUANote_GrpNote_TxtNote().Keys(phraseModifiee);
     Get_WinCRUANote_BtnSave().Click();
     Get_WinDetailedInfo_BtnOK().Click();
     
     //Supprimer la note ajoutée
     Get_ClientsBar_BtnInfo().Click();
     WaitObject(Get_WinDetailedInfo(),"UID","NoteDataGrid_ddf6")
     Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", phraseModifiee, 10).Click();
     Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
     Get_DlgConfirmation_BtnDelete().WaitProperty("VisibleOnScreen", true, 20000)
     Get_DlgConfirmation_BtnDelete().Click();
     
     //Valider que la note est supprimée
     if (Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", addSentence, 10).Exists== true)
     Log.Error("La note ajotée existe encore")
      else
       Log.Checkpoint("la note ajoutée: "+addSentence+" est supprimée")             
}


//Naviguer à la première ligne
function  scroll(){
         
    var Width = Get_RelationshipsClientsAccountsGrid().Width;
    var Height = Get_RelationshipsClientsAccountsGrid().Height;        
    //Naviguer à la première ligne
    Get_RelationshipsClientsAccountsGrid().Click(Width - 10, 60);
}



//fonction qui selectionne un rapport    
function SelectRepport(){
  
    if(StrContains("nfr", vServerSmokeTest, false) || StrContains("staging", vServerSmokeTest, false) )
      Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwGlobal().WPFObject("CFTreeViewItem", "", 3).Click();
    else  
      Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", 4).Click();
            
    Get_Reports_GrpReports_BtnAddAReport().Click();           
}

