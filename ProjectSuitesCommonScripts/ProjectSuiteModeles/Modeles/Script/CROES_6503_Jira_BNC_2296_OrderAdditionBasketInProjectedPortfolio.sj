//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  Anomalie
    TestLink             :  Croes-6503 
    Description          : Croes-6503:Jira BNC-2296 AJout d'ordre Panier dans portefeuille projeté
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-19
    Date                 :  07/06/2019
    
*/


function CROES_6503_Jira_BNC_2296_OrderAdditionBasketInProjectedPortfolio() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6503","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo1_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo1_6503", language+client);
            var accountNo2_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo2_6503", language+client);
            var relationName_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "relationName_6503", language+client);
            var IACode_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "IACode_6503", language+client);
            var modeleName_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modeleName_6503", language+client);
            var panier_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "panier_6503", language+client);
            var securityDescription_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securityDescription_6503", language+client);
            var quantite_6503 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "quantite_6503", language+client);
            var quantity = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "quantity", language+client);
            var VM = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM", language+client);
            var subQuantity0 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subQuantity0", language+client);
            var subQuantity1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subQuantity1", language+client);
            var subQuantity2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subQuantity2", language+client);
            var subQuantity3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subQuantity3", language+client);
            var subQuantity4 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subQuantity4", language+client);
            var subVM0 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subVM0", language+client);
            var subVM1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subVM1", language+client);
            var subVM2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subVM2", language+client);
            var subVM3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subVM3", language+client);
            var subVM4 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "subVM4", language+client);
            var MVdescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MVdescription", language+client);
            var quantityDescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "quantityDescription", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
            
            //Aller dans le module comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Selectionner les comptes 800034-FS et 800034-JW
            Log.Message("------- Sélectionner les comptes "+accountNo1_6503+" et "+accountNo2_6503+" ---------");
            Search_Account(accountNo1_6503);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo1_6503,10).Click(-1, -1, skCtrl);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo2_6503,10).Click(-1, -1, skCtrl);
            
            //Créer la relation BNC-2296 avec les 2 comptes
            Log.Message("-------- Créer la relation "+relationName_6503+" avec les comptes associés "+accountNo1_6503+" et "+accountNo2_6503+" ---------");
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo2_6503,10).ClickR();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
            Get_WinAssignToARelationship_BtnYes().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(relationName_6503);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relationName_6503);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(IACode_6503);
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
            
            //Sélectionner la relation créée et l'associer au modèle CH BONDS
            Get_RelationshipsClientsAccountsGrid().Find("Value",relationName_6503,10).Click();
            Get_RelationshipsClientsAccountsGrid().Find("Value",relationName_6503,10).ClickR();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
            Get_WinPickerWindow_DgvElements().Keys("F"); 
            WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
            Get_WinQuickSearch_TxtSearch().Clear();
            Get_WinQuickSearch_TxtSearch().Keys(modeleName_6503);
            Get_WinQuickSearch_BtnOK().Click()  
    
            Get_WinPickerWindow_DgvElements().Find("Value",modeleName_6503,10).Click();
            Get_WinPickerWindow_BtnOK().Click();
            Get_WinAssignToModel_BtnYes().Click();
                
            //Rééquilibrer le modèle CROES-6479
            Log.Message("--------- Rééquilibrer le modèle "+modeleName_6503+" -------------");
            SearchModelByName(modeleName_6503);
            Get_ModelsGrid().Find("Value",modeleName_6503,10).Click();
            Get_Toolbar_BtnRebalance().Click();
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_TabParameters_RdoBasedOnTargetValue().set_IsChecked(true);
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); //Etape4
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
            
            //Aller sur l'onglet Portefeuille projeté
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().WaitProperty("IsEnabled", true, 30000);
            
            //Cliquer sur le bouton "Ajouter"
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","AddPosition_0910");
            
            Get_WinAddPosition().Find("Uid", "ListPicker_4627", 10).Find("Uid", "TextBox_f1d5", 10).Keys(panier_6503);
            Get_WinAddPosition().Find("Uid", "ListPicker_4627", 10).Find("Uid", "ListPickerExec_9344", 10).Click();
            Get_WinAddPosition_GrpPositionInformation_TxtQuantity().set_Text(quantite_6503);
            Get_WinAddPosition_GrpPositionInformation_TxtQuantity().Click();
            Get_WinAddPosition_BtnOK().WaitProperty("IsEnabled", true, 30000);
            Get_WinAddPosition_BtnOK().Click();
            
            //Cliquer sur le petit +
            //Get_WinRebalance().Click(Get_WinRebalance().Width/4-102,Get_WinRebalance().Height/3-13 ) //MAJ par Christophe
            Sys.Refresh();
            var gridRowWPFControlOrdinalNo = Get_WinRebalance().WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "IsActive"], ["DataRecordPresenter", true]).WPFControlOrdinalNo;
            var gridRow = Get_WinRebalance().WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", gridRowWPFControlOrdinalNo);
            gridRow.Click(5, gridRow.Height/2);
            
            //Points de vérification
            var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
              if (grid.Items.Item(i).DataItem.securityDescription == securityDescription_6503){
                  CheckEquals(grid.Items.Item(i).DataItem.DisplayQuantityStr, quantity, quantityDescription);
                  var valueMarket =  Utilities.FloatToStrF(grid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 5,6);
                  valueMarket = aqString.Replace(valueMarket,".",",");
                  CheckEquals(valueMarket, VM, MVdescription);
              }
            }
            
            var subGrid = gridRow.WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1);
            var count = subGrid.Items.Count;
            for (i=0;i<count; i++){
              if (i == 0){
                  CheckEquals(subGrid.Items.Item(i).DataItem.DisplayQuantityStr, subQuantity0, quantityDescription);
                  var valueMarket0 =  Utilities.FloatToStrF(subGrid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 4,6);
                  valueMarket0 = aqString.Replace(valueMarket0,".",",");
                  CheckEquals(valueMarket0, subVM0, MVdescription);
              }
              if (i == 1){
                  CheckEquals(subGrid.Items.Item(i).DataItem.DisplayQuantityStr, subQuantity1, quantityDescription);
                  var valueMarket1 =  Utilities.FloatToStrF(subGrid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 4,6);
                  valueMarket1 = aqString.Replace(valueMarket1,".",",");
                  CheckEquals(valueMarket1, subVM1, MVdescription);
              }
              if (i == 2){
                  CheckEquals(subGrid.Items.Item(i).DataItem.DisplayQuantityStr, subQuantity2, quantityDescription);
                  var valueMarket2 =  Utilities.FloatToStrF(subGrid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 4,6);
                  valueMarket2 = aqString.Replace(valueMarket2,".",",");
                  CheckEquals(valueMarket2, subVM2, MVdescription);
              }
              if (i == 3){
                  CheckEquals(subGrid.Items.Item(i).DataItem.DisplayQuantityStr, subQuantity3, quantityDescription);
                  var valueMarket3 =  Utilities.FloatToStrF(subGrid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 4,6);
                  valueMarket3 = aqString.Replace(valueMarket3,".",",");
                  CheckEquals(valueMarket3, subVM3, MVdescription);
              }
              if (i == 4){
                  CheckEquals(subGrid.Items.Item(i).DataItem.DisplayQuantityStr, subQuantity4, quantityDescription);
                  var valueMarket4 =  Utilities.FloatToStrF(subGrid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 4,6);
                  valueMarket4 = aqString.Replace(valueMarket4,".",",");
                  CheckEquals(valueMarket4, subVM4, MVdescription);
              }
            }
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Retirer la relation du modèle
            RemoveRelationshipClientAccountFromModel(modeleName_6503,relationName_6503);
            
            //Supprimer la relation créée
            DeleteRelationship(relationName_6503);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

