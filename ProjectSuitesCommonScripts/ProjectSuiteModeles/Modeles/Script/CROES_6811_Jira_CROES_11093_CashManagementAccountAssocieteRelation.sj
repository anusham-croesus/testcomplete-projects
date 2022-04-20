//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  Anomalie
    TestLink             :  Croes-6811 
    Description          : Croes-6811:Jira CROES-11093 Montant de gestion d'encaisse compte associé à une relation
                               
    Auteur               :  Alhassane Diallo
    Version de scriptage :	92.10.HF-5
    Date                 :  18/09/2016
    
*/


function CROES_6811_Jira_CROES_11093_CashManagementAccountAssocieteRelation() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6811","Lien du Cas de test sur Testlink");
            
            
            //Variables
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var CH_CANADIAN_EQUI = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CH_CANADIAN_EQUI", language+client);
            var PALIER_ANUEL_END = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "PALIER_ANUEL_END", language+client);
            var account800074SF = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "account800074SF", language+client);
            var Montant__Gestion_Encaisse = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Montant__Gestion_Encaisse", language+client);
                     
            
            //Se connecter à croesusavec Keynej
            Log.Message("Se connecter avec le User Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module Relation
            Log.Message("Acceder au module Relation");
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
            
            //Trouver la relation PALIER_ANUEL_END, Faire le right click et  l'associer au  modèle CH CANADIAN EQUI
            Log.Message("Trouver la relation " +PALIER_ANUEL_END+ "Faire le right click et  l'associer au  modèle CH CANADIAN EQUI");
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", PALIER_ANUEL_END, 10).ClickR();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();       
            Get_WinPickerWindow().FindChild("Value", CH_CANADIAN_EQUI, 10).Click();
            Get_WinPickerWindow_BtnOK().Click();
            Get_WinAssignToModel_BtnYes().Click();
            
            //Rééquilibrer le modèle CH CANADIAN EQUI
            Log.Message("Rééquilibrer le modèle CH CANADIAN EQUI");
            Get_Toolbar_BtnRebalance().Click();
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click();
            
            //Cliquer sur le bouton Gestion d'encaisse et faire un depot de 2000 sur le  compte  800074-SF
            Log.Message("Cliquer sur le bouton Gestion d'encaisse et faire un depot de 2000 sur le  compte  800074-SF");
            DepositWithdrawalAmount(account800074SF, Montant__Gestion_Encaisse);
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists) {
                Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
            } 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            

           //Valider la gestion d'encaisse au niveau du compte 800074-SF
            Log.Message("Valider la gestion d'encaisse au niveau du compte 800074-SF");
            var width = Get_WinRebalance().Get_Width();
            Get_WinRebalance().Click(14,190);
            aqObject.CheckProperty(Amount().Items.Item(0).ChildRecords.Item(0).DataItem, "DepositWithdrawalAmount", cmpEqual, Montant__Gestion_Encaisse); 
            
            
           
           
            
           
           // fermer la fenêtre de rééquilibrage 
            Log.Message("Fermer la fenêtre de rééquilibrage")
            Get_WinRebalance_BtnClose().Click();  
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73);

            
            
            
            
          
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
      Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(CH_CANADIAN_EQUI);
        
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",PALIER_ANUEL_END,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",PALIER_ANUEL_END,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
           /*var width = Get_DlgCroesus().Get_Width();
           Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
         }
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",PALIER_ANUEL_END,10).Exists){
           Log.Error("Le client est toujours associé au modèle")
         }
         else{
           Log.Checkpoint("Le client n'est plus associé au modèle")}
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

function DepositWithdrawalAmount(account, amount){
    
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    //var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10)
    //Modification suite au CR1990
    var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)
    cellCashMgmt.Click();
    var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);    
    cashMgmtTxt.Keys(StrToFloat(amount));    
    Get_WinCashManagement_BtnOk().click();
    
}


function Amount(){
    return Aliases.CroesusApp.winRebalance.WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_navigatorExpander").WPFObject("_navigatorGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1);
//Get_WinRebalance().Find(Get_CroesusApp(),"Uid","DataGrid_d123").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1);
}
