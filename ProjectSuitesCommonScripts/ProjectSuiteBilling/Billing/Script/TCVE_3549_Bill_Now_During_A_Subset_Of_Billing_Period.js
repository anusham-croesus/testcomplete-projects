//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT Helper
//USEUNIT CR885_885_11_Billing_SeveralRelationships



/**
        Description : 
        Analyste d'assurance qualité : Karima Mou
        Analyste d'automatisation : Alhassane Diallo             
        https://jira.croesus.com/browse/TCVE-3549
*/
function TCVE_3549_Bill_Now_During_A_Subset_Of_Billing_Period()
{
    try {
        
        /*******************************************VARIABLES***************************************************************/
        var userNameLYNCHJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LYNCHJ", "username");
        var passwordLYNCHJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LYNCHJ", "psw");
        
        
        var relationName          = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "REL_TEST5", language+client);
        var account800022HU       = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "ACCOUNT_800022HU", language+client);
        var account800022NA       = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "ACCOUNT_800022NA", language+client);
        var maxWaitTime           = 200000;
        
        
        var frequence             = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "FREQUENCE", language+client);
        var periode               = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "PERIODE", language+client);
        var grille_tarifaire      = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "GRILLE_TARIFAIRE", language+client);
        var methode_de_calcul     = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "METHODE_DE_CALCUL", language+client);
        var start_date            = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "START_DATE", language+client);
        var aum_Value             = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "CURRENT_AUM_VALUE", language+client);
        var billing_date          = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLING_DATE", language+client);
        var aum_800022NA          = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "AUM_VALUE_800022NA", language+client);
        var aum_800022HU          = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "AUM_VALUE_800022HU", language+client);
        var total_fee             = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "TOTAL_FEES", language+client);
        var billed_on_date        = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLED_ON_DATE", language+client);
        var billed_fee_800022NA   = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLED_FEE_800022NA", language+client);
        var billed_fee_800022HU   = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLED_FEE_800022HU", language+client);
        
        var billing_date_2        = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLING_DATE_2", language+client);
        var billed_on_date_2      = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLED_ON_DATE_2", language+client);
        var billed_fee_800022NA_2 = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLED_FEE_800022NA_2", language+client);
        var billed_fee_800022HU_2 = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "BILLED_FEE_800022HU_2", language+client);
        var aum_800022NA_2        = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "AUM_VALUE_800022NA_2", language+client);
        var aum_800022HU_2        = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "AUM_VALUE_800022HU_2", language+client);
        var total_fee_2           = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "TOTAL_FEES_2", language+client);
        var colonne_Billing       = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "COLONNE_BILLING", language+client);
    

        //Se connecter à croeus avec le user LYNCHJ
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Etape 1:Se connecter à croesus avec le user LYNCHJ ");
        Login(vServerBilling, userNameLYNCHJ, passwordLYNCHJ, language);
       
        
        //Dans le module Relations, ajouter la colonne Facturable
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Etape 2:Dans le module Relations, ajouter la colonne Facturable "); 
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  

        

         if (!(Get_RelationshipsGrid_ChBillable().Exists)){
            Add_AllColumns(colonne_Billing)
        }

         //Valider la presence de la colonne facturable
         Log.Message("Valider la presence de la colonne facturable");
         aqObject.CheckProperty(Get_RelationshipsGrid_ChBillable(), "Exists", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsGrid_ChBillable(), "VisibleOnScreen", cmpEqual, true);
          
          
        //Dans le module Relations, ouvrir la relation #5 TEST et sélectionner le checkbox Billable Relationship. Fermer la fenêtre.
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Etape 3:Dans le module Relations, ouvrir la relation #5 TEST et sélectionner le checkbox Billable Relationship. Fermer la fenêtre. ");
        SearchRelationshipByName(relationName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Text", relationName, 10).DblClick();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        
        
        
        //Dans le module Relations, ouvrir la relation #5 TEST et sélectionner l'onglet Billing.
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Etape 4:Dans le module Relations, ouvrir la relation #5 TEST et sélectionner l'onglet Billing. ");
        SearchRelationshipByName(relationName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationName, 10).DblClick();
        Get_WinDetailedInfo_TabBillingForRelationship().Click();
        
        
        //Dans l'onglet Billing pour la relation #5 TEST, provisionner les paramètres. voir capture
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Etape 5:Dans l'onglet Billing pour la relation #5 TEST, provisionner les paramètres. voir capture ");
        Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(frequence);
        Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(periode);
        Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
        Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",grille_tarifaire,100).DblClick();
        Get_WinFeeTemplateEdit_BtnOK().Click();
        Get_WinBillingConfiguration_BtnOK().Click();
        
       
        
        //Dans l'onglet Billing  pour les comptes 800022-HU et 800022-NA, sélectionner les checkbox AUM et Facturable et provisionner le Billing Start Date. voir capture
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Etape 6: Dans l'onglet Billing  pour les comptes 800022-HU et 800022-NA, sélectionner les checkbox AUM et Facturable et provisionner le Billing Start Date. voir capture ");
        var Count=Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
        for(i=1;i<Count+1;i++){

                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).set_Text(start_date);
               
       }
       
       
       
        //Dans l'onglet Billing pour la relation #5 TEST, sélectionner Calculate à droite de Current AUM.
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Etape 7 : Dans l'onglet Billing pour la relation #5 TEST, sélectionner Calculate à droite de Current AUM. voir capture ");
        Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_LlbCalculate().Click();
        
        //Valider la Current AUM.calculée
        aqObject.CheckProperty(Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_LlbCalculate(), "Text", cmpEqual, aum_Value);
        
        
        //Dans l'onglet Billing, sélectionner le bouton Bill Now.Dans la fenêtre Billing Parameters, pour Select a Billing Date, entrer 09/30/2009. Sélectionner le bouton OK. Sélectionner le bouton OK.
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Etape 8 : Dans l'onglet Billing, sélectionner le bouton Bill Now.Dans la fenêtre Billing Parameters, pour Select a Billing Date, entrer 09/30/2009. Sélectionner le bouton OK. Sélectionner le bouton OK. ");
        Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Click();
        Get_WinInstantBillingParameters_DtpSelectABillingDate().set_StringValue(billing_date);
        Get_WinInstantBillingParameters_BtnOK().Click();
        WaitUntilCroesusDialogBoxClose(maxWaitTime);
        
        
        //Valider la fenêtre Billing.
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Etape 9 : Valider la fenêtre Billing.");
        Validate_WinBilling(billed_on_date, account800022HU, billed_fee_800022HU,aum_800022HU, account800022NA, billed_fee_800022NA, aum_800022NA,total_fee)
     

        //Fermer la fenêtre Billing.
        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("Etape 10 : Fermer la fenêtre Billing..");
        Get_WinBilling().Close();
        
        
        
        //Dans l'onglet Billing, sélectionner le bouton Bill Now.Dans la fenêtre Billing Parameters, pour Select a Billing Date, entrer 09/04/2009. puis OK. +  OK.
        Log.PopLogFolder();
        logEtape11 = Log.AppendFolder("Etape 11 : Dans l'onglet Billing, sélectionner le bouton Bill Now.Dans la fenêtre Billing Parameters, pour Select a Billing Date, entrer 09/04/2009. puis OK. +  OK.");
        Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Click();
        Get_WinInstantBillingParameters_DtpSelectABillingDate().set_StringValue(billing_date_2);
        Get_WinInstantBillingParameters_BtnOK().Click();
        WaitUntilCroesusDialogBoxClose(maxWaitTime);
        
        
        //Valider la fenêtre Billing.
        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("Etape 12 : Valider la fenêtre Billing.");
        Validate_WinBilling(billed_on_date_2, account800022HU, billed_fee_800022HU_2,aum_800022HU_2, account800022NA,  billed_fee_800022NA_2, aum_800022NA_2,total_fee_2)
        
        Get_WinBilling().Close();
        Get_WinDetailedInfo_BtnOK().Click();
       
            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        
    }
    finally {
       //Restaurer les données
        Log.PopLogFolder();
        logEtape13 = Log.AppendFolder("Etape 13 : Restaurer les données");
        restoreData()
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}



function restoreData(){
    

        var relationName = ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "REL_TEST5", language+client);
              
        SearchRelationshipByName(relationName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Text", relationName, 10).DblClick();
        Get_WinDetailedInfo_TabBillingForRelationship().Click();
        var Count=Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
        for(i=1;i<Count+1;i++){

                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_DlgConfirmation_BtnYes().Click();
        }
        Get_WinDetailedInfo_TabInfo().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().Click();
        Get_DlgInformation_BtnOK().Click();
        Get_WinDetailedInfo_BtnApply().Click();
        Get_WinDetailedInfo_BtnOK().Click();

}
	 
function Add_AllColumns(colum)
{
        Get_RelationshipsGrid_ChRelationshipNo().ClickR();
        Get_RelationshipsGrid_ChRelationshipNo().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Delay(1000);
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", colum], 100).Click();

}

function Get_RelationshipsGrid_ChName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}
function Validate_WinBilling(billed_on_date, account, billed_fee_1,aum_1, account2, billed_fee_2, aum_2,total_fee){
        
       
        
        aqObject.CheckProperty(Get_WinBilling_GrpRelationships_DgvRelationships().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "BillingDate", cmpEqual, billed_on_date);
        var grid = Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1)
        var Count = Get_WinBilling_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
        for(i=0;i<Count;i++){
           
            if(grid.Items.Item(i).DataItem.AccountNumber==account){ 
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem, "CustomFee", cmpEqual, billed_fee_1);
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem, "AUMForCalculation", cmpEqual, aum_1);
            }
            if(grid.Items.Item(i).DataItem.AccountNumber==account2){ 
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "CustomFee", cmpEqual, billed_fee_2);
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "AUMForCalculation", cmpEqual, aum_2);
            }
        }
        
        aqObject.CheckProperty(Get_WinBilling_GrpSummaryCAD_TxtTotalFees(), "Text", cmpEqual, total_fee);
}


function Get_RelationshipsGrid_ChBillable()
{

  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Facturable"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Billable"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship()
{
 
     {return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", 1], 10)}
}
