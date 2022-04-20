//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_4_Creat_FeeSchedul_AssetClass
//USEUNIT CR885_885_5_Creat_FeeSchedul_Standard
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Helper
/* Description : 
-Aller a Tools/billing 
-Month-end billing: Septembre, 2009 puis cocher Monthly, Quarterly, Semiannual et annual puis OK
-Generate puis cocher 'Export to PDF format' OK
-La fenêtre Rapport est affiché, Sélectionner le rapport 'Management Fees'
-OK, vérifier que les factures PDFsont imprimées.

Prérequis:
- Pref billing = Yes
- Relation bilable R1.(885_8)
- Relation bilable R2.(885_9)
- Relation bilable R3.(885_10)
- Relation bilable R4.(885_12)
- Relation bilable R5(1006_1)
- Relation bilable R6(1006_2)
- Relation bilable R7(1006_3)
- Relation bilable R8(1006_4)

Anomalie:USDEV-77

Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_11_Billing_SeveralRelationships()
  {
       try {
           var reportName = "Management Fees_Billing_KEYNEJ885_11";
           var folderName = ("Rapport" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
           Create_Folder(Project.Path + folderName+"\\");
             
           var NamExcel1=GetData(filePath_Billing,"CR885",74,language);
           var NamExcel2=GetData(filePath_Billing,"CR885",80,language);
           var NamExcel3=GetData(filePath_Billing,"CR885",78,language);

          // activer la préférence PREF_BILLING_PROCESS pour l'user Darwic
   
           /* Activ_Desact_Pref_Billing("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
            Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","YES",vServerBilling);
            Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);*/
            Delay(2000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            Cas885_3();
            Delay(1000);
            Get_WinBillingConfiguration_BtnOK().Click();
            Get_WinConfigurations().Close();
            Delay(1000);
            //Création d'une relation R1. On lui assigne les comptes suivants: 800077-SF,800238-OB et 800238-SF et Billing Start Date:01 Avril 2009
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //ajout de la relation R1
            AddRelationship(21);
            SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));
            Delay(800)
            //Assigner les trois compts suivants: 800077-SF,800238-OB et 800238-SF a la relation  R1 et Billing Start Date:01 Avril 2009
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"RelationBilling",21,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",4,language),GetData(filePath_Billing,"RelationBilling",21,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",5,language),GetData(filePath_Billing,"RelationBilling",21,language))

            Delay(800);
            
            //remplir les valeurs d'entrées pour la relation R1
            FillingInputValueRelationShip(21,3,4,74);


            

            FillingGridBilligRelationShip(440);
            // Création de la relation R2. On lui assigne les comptes suivants: :800049-OB et 800002-OB (Comptes US)et Billing Start Date : 01 Février 2009
            
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //ajout de la relation R2
            AddRelationship(22);
            //Assigner les trois compts suivants: 800049-OB et 800002-OB a la relation  R2 et Billing Start Date:01 Février 2009
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",6,language),GetData(filePath_Billing,"RelationBilling",22,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",7,language),GetData(filePath_Billing,"RelationBilling",22,language))
            
            Delay(800);
            //Remplir les valeurs d'entrées pour la relation R2
            FillingInputValueRelationShip(22,8,9,74);
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(GetData(filePath_Billing,"RelationBilling",32,language));
            Delay(4000);
           
            FillingGridBilligRelationShip(441);
            Delay(1000);
            Cas885_5();
            Delay(1000)
            Get_WinBillingConfiguration_BtnOK().Click();
            Get_WinConfigurations().Close();
            
            // Création de la relation R3. On lui assigne les comptes suivants: 800302-OB et 800217-SF (Comptes US) (Comptes US)et Billing Start Date : 01 Février 2009
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Ajout de la relation R3
            AddRelationship(23);
            //Assigner les trois compts suivants: 800302-OB et 800217-SF a la relation  R3 et Billing Start Date:01 Février 2009
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",8,language),GetData(filePath_Billing,"RelationBilling",23,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",9,language),GetData(filePath_Billing,"RelationBilling",23,language))
            

            Delay(1000);
            //Remplir les valeurs d'entrées pour la relation R3
            FillingInputValueRelationShip(23,12,13,80);
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(GetData(filePath_Billing,"RelationBilling",33,language));
            Delay(4000);
            
            FillingGridBilligRelationShip(441);
            
            
            /*Ajout de la relation R4 et on lui assigne les comptes 800063-OB et 800272-SF  et Billing Start Date : 01 Février 2009*/
           // Création de la relation R4. On lui assigne les comptes suivants: 800063-OB et 800272-SF et Billing Start Date : 01 Février 2009
            Delay(1000);
            Cas885_4();
            Delay(100);
            Get_WinBillingConfiguration_BtnOK().Click();
            Get_WinConfigurations().Close();
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Ajout de la relation R4
             AddRelationship(24);
            //Assigner les trois compts suivants: 800063-OB et 800273-SF a la relation  R4 et Billing Start Date:01 Février 2009
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",10,language),GetData(filePath_Billing,"RelationBilling",24,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",23,language),GetData(filePath_Billing,"RelationBilling",24,language))
            
            
            
         
            Delay(800);
            //Remplir les valeurs d'entrées pour la relation R4
            FillingInputValueRelationShip(24,14,13,78);
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(GetData(filePath_Billing,"RelationBilling",34,language));
            Delay(4000);
            
            FillingGridBilligRelationShip(441)
            
            /*Ajout de la relation R5*/
            //Ajout de la relation R5 et on lui assigne les comptes 800225-SF, 800028-SF, 300010-OB ET 300006-OB  et Billing Start Date : 01 Avril 2009
           // Création de la relation R5. on lui assigne les comptes 800225-SF, 800028-SF, 300010-OB ET 300006-OB  et Billing Start Date : 01 Avril 2009
            Delay(1000);
          
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Ajout de la relation R5
            AddRelationship(25);
            //Assigner les trois compts suivants: 800225-SF, 800028-SF, 300010-OB ET 300006-OB a la relation  R5 et Billing Start Date:01 Avril 2009*/
             JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",14,language),GetData(filePath_Billing,"RelationBilling",25,language))
             JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",52,language),GetData(filePath_Billing,"RelationBilling",25,language))
             JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",16,language),GetData(filePath_Billing,"RelationBilling",25,language))
            
            Delay(800);
            //Remplir les valeurs d'entrées pour la relation R5
            FillingInputValueRelationShip(25,3,17,84);
            Delay(400)
            FillingGridBilligRelationShip(440)
            
            /*Ajout de la relation R6*/
            
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Ajout de la relation R6
            AddRelationship(26);
            //Assigner les trois compts suivants: :80059-SF, 800284-OB et 800072-SF  a la relation relationship Billing
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",13,language),GetData(filePath_Billing,"RelationBilling",26,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",17,language),GetData(filePath_Billing,"RelationBilling",26,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",11,language),GetData(filePath_Billing,"RelationBilling",26,language))
            
            Delay(8000);
            //Remplir les valeurs d'entrées pour la relation R6
            FillingInputValueRelationShip(26,8,4,85);
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(GetData(filePath_Billing,"RelationBilling",32,language));
            Delay(4000);
            
            FillingGridBilligRelationShip(442)

             /*Ajout de la relation R7*/
            
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            //Ajout de la relation R7
            AddRelationship(27);
            //Assigner les trois compts suivants: 800008-OB, 800051-BO et 800289-OB a la relation relationship Billing
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",18,language),GetData(filePath_Billing,"RelationBilling",27,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",19,language),GetData(filePath_Billing,"RelationBilling",27,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",20,language),GetData(filePath_Billing,"RelationBilling",27,language))
            
            
            Delay(1000);
            //Remplir les valeurs d'entrées pour la relation R7
            FillingInputValueRelationShip(27,12,13,84);
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(GetData(filePath_Billing,"RelationBilling",35,language));
            Delay(4000);
            
            FillingGridBilligRelationShip(441);
      
            /*Ajout de la relation R8*/
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Delay(1000);
            //Ajout de la relation R8
            AddRelationship(28);
            //Assigner les trois compts suivants:800047-SF, 800039-OB et 800063-OB a la relation relationship Billing
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",21,language),GetData(filePath_Billing,"RelationBilling",28,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",22,language),GetData(filePath_Billing,"RelationBilling",28,language))
            JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",24,language),GetData(filePath_Billing,"RelationBilling",28,language))
            

            Delay(1000);
            //Remplir les valeurs d'entrées pour la relation R8
            FillingInputValueRelationShip(28,14,9,85);
            Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month().Keys(GetData(filePath_Billing,"RelationBilling",34,language));
            Delay(4000);
            
            FillingGridBilligRelationShip(441)
            // Aller a Tools/Billing 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            
            //-Month-end billing: Septembre, 2009 puis cocher Monthly, Quarterly, Semiannual et annual puis OK
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(true);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(true);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(true);

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois Septembre
             Get_Calendar_LstMonths_ItemSeptember().Click();
             Get_Calendar_LstYears_Item(2009);
             Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             Delay(1000);
             // cliquer sur le bouton Generate
             Get_WinBilling_BtnGenerate().Click();
             // cocher Export to PDF format
             Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat().Click();
             Get_WinOutputSelection_BtnOK().Click();
             Delay(3000)
            //Click sur OK 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3,Get_DlgConfirmation().get_ActualHeight()-50);
            Delay(500);

             
            // Sélectionner le rapport Management Fees
            Select_Report("Management Fees");
            Delay(40000)
             // Click sur le bouton OK
             Get_WinReports_BtnOK().Click();
             
             WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlText"],["UniButton", "OK"]);
            
           
            Sys.WaitProcess(GetAcrobatProcessName(), 100000, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
            // Vérifier si le fichier PDF s'afficher     
            aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      
            //sauvegarder le fichier
            SaveAs_AcrobatReader(Project.Path + folderName+"\\"+reportName);

            FindFileInFolder(Project.Path + folderName+"\\",reportName+".pdf") 
            Delay(1000);
            ClickWinConfigurationsManageBilling();
            var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
            Delay(1000);
            Get_WinBillingConfiguration_BtnOK().Click();
            Get_WinConfigurations().Close();


             // Fermer application        
            Delay(2000);
            Get_MainWindow().SetFocus();
            Close_Croesus_MenuBar(); }
           
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
             Terminate_CroesusProcess();
            
            Login(vServerBilling, userNameBilling, pswBilling, language);
            var j=21;
            for(j=21;j<29; j++)
            {
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",j,language));
            }
            Delay(3000)
            //suppression des schedule fee 
            DeleteFeeSchedule(NamExcel1,count);
            count=count-1;
            Delay(1000);
            DeleteFeeSchedule(NamExcel2,count);
            count=count-1;
            Delay(1000);
            DeleteFeeSchedule(NamExcel3,count)
            Delay(1000);
            Close_Croesus_MenuBar();
            /*Activ_Desact_Pref_Billing("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","NO",vServerBilling);*/
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();

            Terminate_CroesusProcess();
          }

           
           
          
  }
  
  
function Select_Report(reportName)
{
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();

    var reportsCount = Get_Reports_GrpReports_TabReports_LvwReports().Items.get_Count();
    Get_Reports_GrpReports_TabReports_LvwReports().Keys("[Home]");
    for (var i = 1; i < reportsCount; i++){
        var currentReportName = VarToStr(Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).WPFControlText);
        if (currentReportName == reportName){
            Get_Reports_GrpReports_BtnAddAReport().Click();
            break;
        }

        Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
    }
} 



function FillingGridBilligRelationShip(index)
{

             // remplir la partie d'en bas
             Get_WinDetailedInfo().set_Height(700);
             var Count=Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.count;
             for(i=1;i<Count+1;i++){

                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 6], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 7], 10).WPFObject("XamCheckEditor", "", 1).Click();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).DblClick();
                Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 8], 10).WPFObject("XamDateTimeEditor", "", 1).Keys(GetData(filePath_Billing,"RelationBilling",index,language));
                }
 
            
            //Le click sur le bouton Apply et le bouton OK
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000)
            Get_WinDetailedInfo_BtnOK().Click();
}

function AddRelationship(indexRel)
{
           //Création d'une relation billing
            Get_Toolbar_BtnAdd().Click();
            Get_Toolbar_BtnAdd().Click();
            Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click()
            // saisir les donnés pour la relation
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(GetData(filePath_Billing,"RelationBilling",indexRel,language));
            
            //Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(GetData(filePath_Billing,"RelationBilling",15,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox().Keys(GetData(filePath_Billing,"RelationBilling",31,language));
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Delay(1000)
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(1000);

}


function FillingInputValueRelationShip(indexRel,indexFrequenc,indexPeriod,indexFeeSchedule)
{
            // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",indexRel,language),100).DblClick();
            Delay(3000);

            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000);
            //remplir les valeurs d'entrées
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency().Keys(GetData(filePath_Billing,"RelationBilling", indexFrequenc,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod().Keys(GetData(filePath_Billing,"RelationBilling", indexPeriod,language));
             Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule().Click();
             Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Find("Value", GetData(filePath_Billing,"CR885", indexFeeSchedule,language),100).Click();
             //il faut cliquer sur le bouton OK de la fenêtre Bilking Configuration
             Get_WinBillingConfiguration_BtnOK().Click();
             Delay(1000);
             



}
function test()
{
var reportName = "Management Fees_Billing_KEYNEJ885_11";
           var folderName = ("Rapport" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
           
           var NamExcel1=GetData(filePath_Billing,"CR885",74,language);
           var NamExcel2=GetData(filePath_Billing,"CR885",80,language);
           var NamExcel3=GetData(filePath_Billing,"CR885",78,language);


             Terminate_CroesusProcess();
            
            Login(vServerBilling, userNameBilling, pswBilling, language);
            var j=21;
            for(j=21;j<29; j++)
            {
            DeleteRelationship(GetData(filePath_Billing,"RelationBilling",j,language));
            }
            Delay(3000)
            //suppression des schedule fee 
            DeleteFeeSchedule(NamExcel1,count);
            count=count-1;
            Delay(1000);
            DeleteFeeSchedule(NamExcel2,count);
            count=count-1;
            Delay(1000);
            DeleteFeeSchedule(NamExcel3,count)
            Delay(1000);
            Close_Croesus_MenuBar();
            /*Activ_Desact_Pref_Billing("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
            Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","NO",vServerBilling);*/
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();

            Terminate_CroesusProcess();
}



function DeleteFeeSchedule(NamExcel,count)
         {
         ClickWinConfigurationsManageBilling();
         
          for (var i=1;i<count+1;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
                      // click sur le bouton Delete de la fenêtre Billing
                      x=Get_DlgConfirmation().get_ActualWidth()/3;
                      y=Get_DlgConfirmation().get_ActualHeight()-50;
                      Get_DlgConfirmation().Click(x, y);
                      break;                                                                                     
                      }
      
      
          }
          
 
         
         
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
          
 
         }
         
