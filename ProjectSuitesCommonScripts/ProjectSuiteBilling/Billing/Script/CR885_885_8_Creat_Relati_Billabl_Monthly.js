//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR0992_992_1_Print_Bill_RelationShip
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR0992_992_1_Print_Bill_RelationShip
//USEUNIT Helper
/* Description : 

- Ajouter une relation R1 puis OK;
- Selctionner R1 puis cocher 'Billable Relationship' puis 'Apply'
- Selectionner l'onglet billing.
- Remplir les valeurs d'entrées. 
-Cliquer sur le bouton 'history'.
- Apply puis OK.
- Aller a Tools/billing 
-Month-end billing: April, 2009 puis cocher Montly OK
-Generate puis cocher 'Export to PDF format' OK
-La fenêtre Rapport est affiché, Sélectionner le rapport 'Management Fees'
-OK, vérifier qu'une facture PDF est imprimée.
-Vérifier les données dans 'History'

Valeur d'entrée:
Frequency: Montly 
Period: Start of period
Fee Schedule:Standard intervalle.
Calculated Methode:Defined Intervals
Comptes:800077-SF,800238-OB et 800238-SF (Comptes US)
Billing Start Date:01 Avril 2009
ce cas de test a modifier ses points de vérifications parce que d'aprés Sofia, il sera modifié avec la prochaine version.

Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_8_Creat_Relati_Billabl_Monthly()
  {
      try {
	         var language = "english"
           var reportName = "Management Fees_Billing_KEYNEJ_885_8";
           var folderName = ("Rapport" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
           Create_Folder(Project.Path + folderName+"\\");
             
          
           var GrilTarifFixedInterval=GetData(filePath_Billing,"CR885",76,language)
            //Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","FIRMADM",vServerBilling);
          //  Activate_Inactivate_PrefBranch("0","PREF_BILLING","YES",vServerBilling);
          // Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            
           // RestartServices(vServerBilling);
            
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000)
            Cas885_3();
            Delay(1000);

            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
           //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Création d'une relation billing
            Get_Toolbar_BtnAdd().Click();
            Delay(100);
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            Delay(1000);
            
            // saisir les donnés pour la relation
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(GetData(filePath_Billing,"RelationBilling",21,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox().Keys(GetData(filePath_Billing,"RelationBilling",31,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().set_IsChecked(true);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().WaitProperty("IsChecked", true, 15000); 
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["UID", "VisibleOnScreen"], ["Button_ddd2", true], 30000);
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));

            //Assigner les trois compts suivants: 800077-SF,800238-OB et 800238-SF a la relation relationship Billing
             JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"RelationBilling",21,language));
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",4,language),GetData(filePath_Billing,"RelationBilling",21,language));
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",5,language),GetData(filePath_Billing,"RelationBilling",21,language));
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",21,language),100).DblClick();
            
            // vérifier l'existence de l'onglet billing
            aqObject.CheckProperty( Get_WinDetailedInfo_TabBillingForRelationship(), "Visible", cmpEqual, true);
            aqObject.CheckProperty( Get_WinDetailedInfo_TabBillingForRelationship(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty( Get_WinDetailedInfo_TabBillingForRelationship(), "Exists", cmpEqual, true);
            
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            WaitObject(Get_WinDetailedInfo(), ["WPFControlText", "IsSelected", "VisibleOnScreen"], [GetData(filePath_Billing,"RelationBilling",538,language),true, true]); 
            //remplir les valeurs d'entrées
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(GetData(filePath_Billing,"RelationBilling",3,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(GetData(filePath_Billing,"RelationBilling",4,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
             Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",GrilTarifFixedInterval,100).Click();
             //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
                Get_WinBillingConfiguration_BtnOK().Click();
             // remplir la partie d'en bas
             FillRelationshipBillingTab([GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"WinAssignCompte",4,language),GetData(filePath_Billing,"WinAssignCompte",5,language)], GetData(filePath_Billing,"RelationBilling",10,language))
             
            //click sur le bouton History
                Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
            //Vérifier que la grille est vide
            aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
            aqObject.CheckProperty(Get_WinBillingHistory_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
            
            // Cliquer sur close pour fermer la fenêtre de Billing History
            Get_WinBillingHistory_BtnClose().Click();
            Delay(1000);
            //Le click sur le bouton Apply 
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000);
            // Clic sur le bouton OK pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnOK().Click();
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // Décôcher sur la partie frequencies Quarterly,Semiannual et Annual
   
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois avril
             Get_Calendar_LstMonths_ItemApril().Click();
             Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             Delay(3000);
             // cliquer sur le bouton Generate
             Get_WinBilling_BtnGenerate().Click();
             // cocher Export to PDF format
             Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat().Click();
             Delay(3000);
             Get_WinOutputSelection_BtnOK().Click()
             Delay(3000);
             //Click sur OK 
             Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3,Get_DlgConfirmation().get_ActualHeight()-50);
             Delay(1000);

             // Sélectionner le rapport Management Fees
              Select_Report("Management Fees");
             // Click sur le bouton OK
             Get_WinReports_BtnOK().Click();
             Delay(3000);
             // ouvrir de nouveau la relation/onglet Billing ensuite vérifier les données dans la fen
             Sys.WaitProcess(GetAcrobatProcessName(), 100000, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
             // Vérifier si le fichier PDF s'afficher     
             aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      
             //sauvegarder le fichier
             SaveAs_AcrobatReader(Project.Path + folderName+"\\"+reportName);

             FindFileInFolder(Project.Path + folderName+"\\",reportName+".pdf")  
             //double click sur la relation pour ouvrir la fenêtre info de la relation Billing Relation
             Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",21,language),100).DblClick();
             Delay(1000);
             Get_WinDetailedInfo_TabBillingForRelationship().Click();
             //click sur le bouton History
             Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
             //Vérifier les données dans la fenêtre 'Billing History'. 
           
             aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, true);
            // Cliquer sur close pour fermer la fenêtre de Billing History
            Get_WinBillingHistory_BtnClose().Click();
            Delay(200)
            //vérifier que la date qu'on a sur la colonne Last Billing est 04/30/2009
            windowHeight = Get_WinDetailedInfo().get_Height();
            Get_WinDetailedInfo().set_Height(600);
   
           accountsCount = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (i = 0; i < accountsCount; i++){
          
        var LastBilling = Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.BillingLastDate.Date.Date.OleValue;
        var LastBillingExcel = GetData(filePath_Billing,"RelationBilling",329,language)
        var LastBillingConv = aqConvert.DateTimeToFormatStr(LastBilling, "%#m/%d/%Y");
        
        CheckEquals(VarToStr(LastBillingConv),LastBillingExcel, "Le date de last billing");
        
        } 
            Delay(200)
            //Le click sur le bouton OK
            Get_WinDetailedInfo_BtnOK().Click();
             // Fermer application        
            Delay(2000);
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar(); }
            //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Terminate_CroesusProcess();
            
            Login(vServerBilling, userNameBilling, pswBilling, language);
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",21,language));
            //suppression du schedule fee  
            Delete_FeeScheduleFixed();
            Close_Croesus_MenuBar();
            Delay(300)
           /*Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","NO",vServerBilling);
            RestartServices(vServerBilling);*/
    
            //Appel fonction de suppression d'un Fee Schedule
            Terminate_CroesusProcess();
          }

           
           
          
  }
  
 

  function DblClick_FirstLine_ShortNameRelationShip()
  {
            
                var NameRelationShip= Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ShortName.OleValue;
                Get_RelationshipsClientsAccountsGrid().Find("Value",NameRelationShip,100).DblClick();
                return NameRelationShip;
  }
  
   function Click_FirstLine_ShortNameRelationShip()
  {
            
                var NameRelationShip= Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ShortName.OleValue;
                Get_RelationshipsClientsAccountsGrid().Find("Value",NameRelationShip,100).DblClick();
                return NameRelationShip;
  }
 

function ClickRightAddJoinAccountToRelationShip(NameRelationShip)
{
            Get_RelationshipsClientsAccountsGrid().RecordListControl.Find("Value",GetData(filePath_Billing,"RelationBilling",NameRelationShip,language),100).ClickR();
            Delay(1000);
            Get_RelationshipsClientsAccountsGrid().RecordListControl.Find("Value",GetData(filePath_Billing,"RelationBilling",NameRelationShip,language),100).ClickR();
            Delay(1000)
            Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
            Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinAccountsToRelationship().Click();
}

/*
function AssignAccountToRelationShip(NumbAccou,NameRelationShip)
       {
            Delay(800)
            ClickRightAddJoinAccountToRelationShip(NameRelationShip);
            Delay(800)
            Sys.Keys(".");
            Delay(800)
            Get_WinQuickSearch_TxtSearch().Keys(GetData(filePath_Billing,"WinAssignCompte",NumbAccou,language));
            Delay(800)
            Get_WinQuickSearch_BtnOK().Click();
            Delay(800)
            Get_WinPickerWindow_BtnOK().Click();
            Delay(800)
            Get_WinAssignToARelationship_BtnYes().Click();
       }*/

function Cas885_8()
{   
            var reportName1 = "Management Fees_Billing_KEYNEJ_885_8";
            Delay(1000);
            var RelationshipName=GetData(filePath_Billing,"RelationBilling",21,language)
            var IACode=GetData(filePath_Billing,"RelationBilling",15,language)
            
            var CmbFrequency= GetData(filePath_Billing,"RelationBilling",3,language)
            var CmbPeriod=GetData(filePath_Billing,"RelationBilling",4,language)
            var DgvFeeTemplateManager= GetData(filePath_Billing,"CR885",74,language)
            
            Cas885_3();

            Get_WinBillingConfiguration_BtnOK().Click()
            Get_WinConfigurations().Close();
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            CreateRelationshipBillable(RelationshipName,IACode)
           // chercher la relation
           SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));
            Delay(3000)
            //Assigner les trois compts suivants: 800077-SF,800238-OB et 800238-SF a la relation relationship Billing
       
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"RelationBilling",21,language));
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",4,language),GetData(filePath_Billing,"RelationBilling",21,language));
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",5,language),GetData(filePath_Billing,"RelationBilling",21,language));
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",21,language),100).DblClick();
            Delay(3000)
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000)
            
            //remplir les valeurs d'entrées
            FillingFrequPeriodFeeSchedule(CmbFrequency,CmbPeriod,DgvFeeTemplateManager)
            //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
                Get_WinBillingConfiguration_BtnOK().Click();
        
             // remplir la partie d'en bas
             FillInTheBottomPartOfAccounts(440);
            //click sur le bouton History
                Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory().Click();
                Delay(3000)
            //Vérifier que la grille est vide
            aqObject.CheckProperty(Get_WinBillingHistory_GrpBilling_DgvBilling().WPFObject("RecordListControl", "", 1), "HasItems", cmpEqual, false);
            // Cliquert sur close pour fermer la fenêtre de Billing History
            Get_WinBillingHistory_BtnClose().Click();
            //Le click sur le bouton Apply et le bouton OK
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000)
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000)
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            Delay(3000)
            // Décôcher sur la partie frequencies Quarterly,Semiannual et Annual
   
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);
            Get_WinBillingParameters_DtpBillingDate().Click()
            

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            Delay(3000);
            //Choisir le mois avril
             Get_Calendar_LstMonths_ItemApril().Click();
             Delay(3000);
             Get_Calendar_BtnOK().Click();
             Delay(1000);
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             Delay(3000);
             // cliquer sur le bouton Generate
             Get_WinBilling_BtnGenerate().Click();
             Delay(3000);
             // cocher Export to PDF format
             Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat().Click();
             Delay(3000);
             Get_WinOutputSelection_BtnOK().Click()
             Delay(4000);
             
            //Click sur OK 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3,Get_DlgConfirmation().get_ActualHeight()-50);
            Delay(1000)
           //Click sur Continue 
           // Get_DlgBilling().Click(Get_DlgBilling().get_ActualWidth()/3,Get_DlgBilling().get_ActualHeight()-50);
           // Delay(1000)
             // Sélectionner le rapport Management Fees
             Select_Report("Management Fees");
             Delay(3000);
             // Click sur le bouton OK
             Get_WinReports_BtnOK().Click();
             Delay(3000);
             
}
function Delete_FeeScheduleFixed()
{ 
            var GrilTarifFixedInterval=GetData(filePath_Billing,"CR885",76,language)
            ClickWinConfigurationsManageBilling();
            Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value",GrilTarifFixedInterval,100).Click();
            Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
            Get_WinBillingConfiguration_BtnOK().Click();
            
            
            
            
          
}

function InitializeDataBase()
   {
   ClickWinConfigurationsManageValidationGrid();
    //Parcourir la grille Billing Configuration pour stocker les valeurs de la colonne valeur totale dans un tableau
    //var tabpointverif =BrowsGridConfigBilliGrid();
    //Get_WinFeeMatrixConfiguration_BtnOK().Click();
   // Get_WinConfigurations().Close();
   // ClickWinConfigurationsManageValidationGrid();
   // Vider et Remplir la grille
   EmptyGridConfigBilling();

    ClickWinConfigurationsManageValidationGrid();
    
    Click_FirstLine_TotalValue_BilliConfig();
    //Log.Message(tabl);
   // var count= tabl.length;
  //Log.Message(count);
    for(j=0;j<5; j++)
    {
        taillegrille = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsSelected(true);
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsActive(true);
        Delay(1000);
        Get_WinFeeMatrixConfiguration_BtnSplit().Click();
        Delay(1000);
        Get_WinAddRange_TxtSplitRangeAt().set_Text(GetData(filePath_Billing,"CR885",j+303,language));
        Delay(1000);
        Get_WinAddRange_BtnOK().Click();
    
     }   
      var NbrLigne = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
      Log.Message(NbrLigne);
      FillTheGridWithValues(NbrLigne)
      Get_WinFeeMatrixConfiguration_BtnOK().Click();
      Get_WinConfigurations().Close();
       ClickWinConfigurationsManageBilling();
                
                 
                 // il faut se connecter avec Uni00 pour pouvoir avoir le bouton migrate activé
      // sélectionner la premier ligne ensuite cliquer sur le bouton migrate utiliser for
     var countFeeSchedule=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
      for(i=0;i<countFeeSchedule;i++){
          var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Name.OleValue;
          Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",Name,100).Click();
          Delay(800)
          Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate().Click();
          Delay(800)
          Get_WinFeeTemplateMigration_BtnOK().Click();
          Delay(800)
          }
          Get_WinBillingConfiguration_BtnOK().Click();
     
      Delay(800)
                 
      // rechercher dans la grille voila la fonction get de la grille Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager
      Get_WinConfigurations().Close();
      Close_Croesus_MenuBar();
   }

  function EmptyGridConfigBilling(){
  
  
    count = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
    
    var valtotaldiv = new Array();
    Click_FirstLine_TotalValue_BilliConfig();
    for (var i = 0; i < count-2; i++)
    {
        TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange;
       
        Delay(1000);
        Get_WinFeeMatrixConfiguration_BtnMerge().Click();
        Delay(1000);
        // click sur le bouton OK de la fenêtre Add Range
        x=Get_DlgMergeValidationGridRange().get_ActualWidth()/3;
        y=Get_DlgMergeValidationGridRange().get_ActualHeight()-50;
        Get_DlgMergeValidationGridRange().Click(x,y);
        Delay(1000);
        /*
       //Trouver la position du "-" dans la chaine de caractére de Total value
        var rechtiret=aqString.Find(TotalValueRange, "-");
        //Récupérer la longueur de la chaine de caractére TotalValueRange
        lengtValTotal=aqString.GetLength(TotalValueRange);
        
        valTotal = aqString.SubString(TotalValueRange,rechtiret+1,lengtValTotal);
        valtotaldiv1=StrToInt(valTotal)/1000;
        valtotaldiv.push(valtotaldiv1);*/
        
    }
    Get_WinFeeMatrixConfiguration_BtnOK().Click();
    Log.Message("En attente du numéro de l'anomalie qui sera crée par Sofia");
     // Fermer la fenêtre de Configurations
    Get_WinConfigurations().Close();
    
    return valtotaldiv;
  }  

  
function FillTheGridWithValues(NbrLigne)
{
        
        var j=112;
        // boucler sur la grille selon le nombre de ligne de la grille
        var k;
        for(k=1;k<NbrLigne+1;k++)
        {
        // sélectionner la ligne de la grille
       var TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(k-1).DataItem.TotalValueRange.OleValue;
       Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value",TotalValueRange,100).Click();

        var i;
        //boucler sur les cellules de la grille selon la ligne
        for(i=3;i<31;i++)
        {

        var MinCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i], 10);
        MinCash.Click();
        var WritCelMinCash=MinCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
        WritCelMinCash.Keys(GetData(filePath_Billing,"CR885",j,language)); 

        var MaxCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i+1], 10);
        MaxCash.Click();
        var WritCelMaxCash=MaxCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
        WritCelMaxCash.Keys(GetData(filePath_Billing,"CR885",j+1,language));
        j=j+2
        i=i+2;
        }
        }
}