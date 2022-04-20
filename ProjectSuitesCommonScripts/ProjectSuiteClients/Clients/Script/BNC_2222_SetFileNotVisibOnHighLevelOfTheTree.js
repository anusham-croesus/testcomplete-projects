//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                    1. sélectionner un client et aller dans l’onglet Documents 
                    2. Créer 2 dossiers dans son arborescence 
                        Faire un right click sur le Dossier Documents + cliquer sur Nouveau dossier en créer 2. 
                    3. Ajouter des documents dans chacun des dossiers par le + 
                    4. Constater que lorsqu’ on se place sur le nom du client on ne voit pas l'ensemble des documents ajoutés. 



    Auteur : Sana Ayaz
    Anomalie:BNC-2222
    Version de scriptage:ref90-07-23--V9-Be_1-co6x
*/
function BNC_2222_SetFileNotVisibOnHighLevelOfTheTree()
{
    try {
        
        
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
       
        var NumCLIENT800067=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NumCLIENT800067", language+client);
        var NamCLIENT800067=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NamCLIENT800067", language+client);
        var NameDossier1BNC2222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameDossier1BNC2222", language+client);
        var NameDossier2BNC2222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameDossier2BNC2222", language+client);
        var NameDocumBNC2222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameDocumBNC2222", language+client);
        var NameFile1BNC2222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameFile1BNC2222", language+client);
        var NameFile2BNC2222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameFile2BNC2222", language+client);
        var NameFile3BNC2222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameFile3BNC2222", language+client);
        var NameFile4BNC2222=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NameFile4BNC2222", language+client);
       
        
        /* 1. sélectionner un client et aller dans l’onglet Documents 
        */
        var FilePath1BNC2222=folderPath_Data + NameFile1BNC2222;
        var FilePath2BNC2222=folderPath_Data + NameFile2BNC2222;
        var FilePath3BNC2222=folderPath_Data + NameFile3BNC2222;
        var FilePath4BNC2222=folderPath_Data + NameFile4BNC2222;
       
        

         
         Get_ModulesBar_BtnClients().Click();
         Search_Client(NumCLIENT800067);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumCLIENT800067, 10).Click();
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumCLIENT800067, 10).DblClick();
         
         // Choisir l'onglet Documents
         Get_WinDetailedInfo_TabDocuments().Click();
         
         // Créer le premier dossier
         Get_WinDetailedInfo_TabDocuments().Click();
         Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild("WPFControlText", NameDocumBNC2222, 10).ClickR();
         Get_PersonalDocuments_LstDocuments_ContextMenu_NewFolder().Click();
         
         // Créer le deuxiéme dossier
         Get_WinDetailedInfo_TabDocuments().Click();
         Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild("WPFControlText", NameDocumBNC2222, 10).ClickR();
         Get_PersonalDocuments_LstDocuments_ContextMenu_NewFolder().Click();
         // ajout des fichiers au premier dossier
         AddingFilesTofolersDocuments(NameDossier1BNC2222,FilePath1BNC2222,FilePath2BNC2222)
         
          // ajout des fichiers au deuxième dossier
         AddingFilesTofolersDocuments(NameDossier2BNC2222,FilePath3BNC2222,FilePath4BNC2222)

      // Les points de vérifications :  Lorsqu’ on se place sur le nom du client on voit l'ensemble des documents ajoutés.
      
      //Sélèctionner le client
         Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild("WPFControlText", NamCLIENT800067, 10).ClickR();
         
         CheckVisibFilDocuments(NameFile1BNC2222)
         CheckVisibFilDocuments(NameFile2BNC2222)
         CheckVisibFilDocuments(NameFile3BNC2222)
         CheckVisibFilDocuments(NameFile4BNC2222)
      
      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnClients().Click();
        Search_Client(NumCLIENT800067);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumCLIENT800067, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumCLIENT800067, 10).DblClick();
         
        // suppressin des fichiers
        DeleteFileDocument(NameDossier1BNC2222,NameFile1BNC2222)
        DeleteFileDocument(NameDossier1BNC2222,NameFile2BNC2222)
        DeleteFileDocument(NameDossier2BNC2222,NameFile3BNC2222)
        DeleteFileDocument(NameDossier2BNC2222,NameFile4BNC2222)
        Terminate_CroesusProcess();
        
         
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnClients().Click();
        Search_Client(NumCLIENT800067);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumCLIENT800067, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumCLIENT800067, 10).DblClick();
         
       // suppressin des fichiers
        DeleteFileDocument(NameDossier1BNC2222)
        DeleteFileDocument(NameDossier1BNC2222)
        DeleteFileDocument(NameDossier2BNC2222)
        DeleteFileDocument(NameDossier2BNC2222)
        Terminate_CroesusProcess();
        
    }
}




function DeleteFileDocument(NameDossier)
{
 Get_WinDetailedInfo_TabDocuments().Click();
         
         Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild("WPFControlText", NameDossier, 10).Click();
         Get_PersonalDocuments_Toolbar_BtnRemove().Click();
         var width = Get_DlgConfirmation().Get_Width();
         Get_DlgConfirmation().Click((width*(1/3)),73);
       

}
function AddingFilesTofolersDocuments(NameDossier,NameFile1BNC2222,NameFile2BNC2222)
{
         
         
         TabFilePathBNC2222 = new Array();
         
         TabFilePathBNC2222.push(NameFile1BNC2222);
         TabFilePathBNC2222.push(NameFile2BNC2222);
         
         
       
         
  
  for (i=0; i<= 1; i++)
          {
         Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild("WPFControlText", NameDossier, 10).Click();
         Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
         Get_WinAddAFile_GrpFile_BtnBrowse().Click();
         Get_DlgOpen_CmbFileName_TxtFileName().Keys(TabFilePathBNC2222[i]);
         Get_DlgOpen_BtnOpen().Click();
         Get_WinAddAFile_BtnOK().Click();
         }

}



function CheckVisibFilDocuments(NameFile)
{
    var existfilePdf=Get_PersonalDocuments_LstDocuments().Find("Text",NameFile,100).Exists 
    Log.Message(existfilePdf)      
    if(existfilePdf == true){
     var visiblefilePdf=Get_PersonalDocuments_LstDocuments().Find("Text",NameFile,100).VisibleOnScreen
      Log.Message(visiblefilePdf) 
   if(visiblefilePdf == true)
    {
       Log.Checkpoint("Le fichier existe et il est visible a l'écran "+NameFile)}
    }
    else{
      Log.Message("CROES-12273");
       Log.Error("Le fichier n'existe pas et il est pas visible a l'écran "+NameFile)
    } 

}