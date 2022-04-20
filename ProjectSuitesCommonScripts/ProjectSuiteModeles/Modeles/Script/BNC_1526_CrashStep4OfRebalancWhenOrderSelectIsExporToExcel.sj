//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                     L'application crash lorsqu'on fait expoter vers excel une séléction d'ordrs groupés. Se produit aussi sur Qasit
                      User =keynej
                      Modele=CH moyen terme
                      Portefeuille assigné= client 800048

                      Étapes:
                      1-Rééquilibrer le modele CH moyen terme
                      2-Next jusqu'a étape 4 onglet ordres proposé ==> les ordres sont groupés
                      3-Éclater un ordre exple achat NBC100
                      3-Click droit sur l'ordre éclaté NBC100 COMPTE 800048-NA
                      4-Exporter vers Ms Excel

                        Résultat obtenu : Crash de l'application voir log + pj
    Auteur : Sana Ayaz
    Anomalie:BNC-1526
    Version de scriptage:ref90-07-Co-15--V9-Be_1-co6x
*/
function BNC_1526_CrashStep4OfRebalancWhenOrderSelectIsExporToExcel()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
       
      
        var NameModelBNC1526=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NameModelBNC1526", language+client);
        var NumbClient800048=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumbClient800048", language+client);
        var SymOrdVentCAM100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SymOrdVentCAM100", language+client);
        var CodeCpBNC1526=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CodeCpBNC1526", language+client);
        var ExportExcelBNC1526=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ExportExcelBNC1526", language+client);
        
        /*            User =keynej
                      Modele=CH moyen terme
                      Portefeuille assigné= client 800048*/
                    
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(NameModelBNC1526);
        // Associer le client  800048 au modéle:CH moyen termes
        Get_ModelsGrid().Find("Value",NameModelBNC1526,10).Click();
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
      
        
        Get_WinPickerWindow_DgvElements().Keys(NumbClient800048.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(NumbClient800048.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
          /* 1-Rééquilibrer le Modele : CH moyen terme
                    2-Next jusqu'a étape 4 onglet ordres proposé ==> les ordres sont groupés
        */
        Get_Toolbar_BtnRebalance().Click()
        Get_WinRebalance().Parent.Maximize();
        
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
         WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
       // onglet ordres proposé ==> les ordres sont groupés
        if(!Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().IsSelected)// Si l'onglet ordres proposé n'est pas séléctionné on l'a séléctionne.
        {
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click(); }
       
        //IsChecked et IsEnabled
        if(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked & Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsEnabled)
        {
          /*
           3-Éclater un ordre exple achat NBC100
           3-Click droit sur l'ordre éclaté NBC100 COMPTE 800048-NA
           4-Exporter vers Ms Excel
          */
          
          Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders().Keys(".");
          Get_WinQuickSearch_RdoSymbol().Click();
          Get_WinQuickSearch_TxtSearch().Keys(SymOrdVentCAM100);/*SA: J'ai pris le symbole CAM100 suite a une discussion avec Christine Hechma on peut prendre n'importe quel autre symbole
                                                                     parce que le symbole NBC100 n'existe pas sur le dump de BNC */
          Get_WinQuickSearch_BtnOK().Click();
         
          //supprimer tous les fichiers . txt qui se trouve dans le dossier CroesusTemp
             var sTempFolder = Sys.OSInfo.TempDirectory;
            var FolderPath= sTempFolder+"\CroesusTemp\\"
            Log.Message(FolderPath)
            
            var x=aqFileSystem.DeleteFile(FolderPath+"\*.txt")
            Log.Message(x);
 
         //Exporter vers excel   
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", CodeCpBNC1526], 10).ClickR();
        
        Aliases.CroesusApp.subMenus.WPFObject("ContextMenu", "", 1).Find("WPFControlText",ExportExcelBNC1526,10).Click();
        
         
        //fermer les fichier excel
       while(Sys.waitProcess("EXCEL").Exists){
        Sys.Process("EXCEL").Terminate();
          }
        //Les points de vérifications
        
          var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
            Log.Message(FileNameContains)
            var NameFile= FindLastModifiedFileInFolder(FolderPath,FileNameContains)
            Log.Message(NameFile)
            if (aqFileSystem.Exists(NameFile)) 
            {
            Log.Checkpoint("L'export vers MS Excel a fonctionné ")}
           
            else
              {
            Log.Error("L'export vers MS Excel n'as pas fonctionné")}
        }
        else 
        Log.Error("Les ordres ne sont pas groupés")
      
      
       Terminate_CroesusProcess(); //Fermer Croesus
        
         
    }
    catch(e) {
       Terminate_CroesusProcess(); //Fermer Croesus
    
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles) 
        Terminate_CroesusProcess(); //Fermer Croesus
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles) 
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(NameModelBNC1526);
        
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800048,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800048,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
           /*var width = Get_DlgCroesus().Get_Width();
           Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
         }
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800048,10).Exists){
           Log.Error("Le client est toujours associé au modèle")
         }
         else{
           Log.Checkpoint("Le client n'est plus associé au modèle")}
         Terminate_CroesusProcess(); //Fermer Croesus
         Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles) 
}
}
