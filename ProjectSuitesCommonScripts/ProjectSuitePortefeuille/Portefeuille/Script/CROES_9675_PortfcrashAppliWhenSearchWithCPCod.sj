//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    Description :
                    Connecter à Croesus avec COPERN
                    Mailler un client vers Portefeuille
                    Cliquer sur le bouton loupe 'Rechercher'
                    -Enter BD88 et cocher Code de CP
                    Cliquer sur "OK"
                    Résultat attendu: 
                    Code de CP "BD88" est sélectionné 
                    Résultat obtenu: 
                    l'application crash
                   
    Auteur : Sana Ayaz
    Anomalie:CROES-9675
    Version de scriptage:	ref90-07-Co-9--V9-Be_1-co6x
    
*/


function CROES_9675_PortfcrashAppliWhenSearchWithCPCod()
{
    try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
      
        //Les variables
          var NumberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "NumberClient800300", language+client);
          var CodeCpBD88CROES9675=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "CodeCpBD88CROES9675", language+client);
          var NumCellulCROES9675=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "NumCellulCROES9675", language+client);
         
          //1.se connecter comme COPERN
          Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
          // 2.du module Relations, mailler toutes les relations vers portefeuille
          Get_ModulesBar_BtnClients().Click();
          Search_Client(NumberClient800300)
          
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumberClient800300, 10).Click();
           //Mailler vers le module portefeuille
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          /* Cliquer sur le bouton loupe 'Rechercher'
                    -Enter BD88 et cocher Code de CP
                    Cliquer sur "OK"*/
           Get_Toolbar_BtnSearch().Click();  
           Get_WinQuickSearch_RdoIACode().Click();
           Get_WinQuickSearch_TxtSearch().Keys(CodeCpBD88CROES9675)
           Get_WinQuickSearch_BtnOK().Click();                    
                    
           Log.Message("L'anomalie: CROES-9675"); 
           if(Get_DlgError().Exists) 
               Log.Error("Croesus Crash")
           else
                Log.Checkpoint("L'application ne crash pas.");
                               
          //Les points de vérifications : Valider que la ligne sélectionnée a un code CP = "BD88"
           var lines = Get_Grid_VisibleLines(Get_Portfolio_AssetClassesGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.IsActive){
                aqObject.CheckProperty(lines[n].dataContext.dataItem, "RepresentativeNumber", cmpEqual, CodeCpBD88CROES9675);
                aqObject.CheckProperty(lines[n].dataContext, "IsActive", cmpEqual, true);  
               }
           }
           
            /*var DisplayCoddeCPGrid=Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", NumCellulCROES9675], 10).WPFObject("XamTextEditor", "", 1)
            aqObject.CheckProperty(DisplayCoddeCPGrid, "DisplayText", cmpEqual, CodeCpBD88CROES9675);
            aqObject.CheckProperty(DisplayCoddeCPGrid, "Exists", cmpEqual, true);
            aqObject.CheckProperty(DisplayCoddeCPGrid, "IsVisible", cmpEqual, true);
          Log.Message("Anomlie : CROES-9675")*/          
          
          Terminate_CroesusProcess();
          
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
    }
    finally {
   
        Terminate_CroesusProcess();
        
    }
}
