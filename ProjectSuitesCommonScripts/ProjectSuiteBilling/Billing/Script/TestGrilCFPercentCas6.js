//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT TestGrilCFPercentCas1
//USEUNIT Helper
/* Description : 

-Création de la relation Test_Grille
-Assigner a la relation les deux comptes suivants :800053-OB et 800060-OB.
-Choisir sur frequency :Monthly, Periode : Start of Period, Fee Schedule : Prod Asset class
-Cash Flow Adjustement: percentage/Inflow : 2, percentage/Outflow:1, Amount/Inflow:99,999,999.99 et Amount/OutFlow=99,999,999.99.
-Cliquer sur Tools/Billing, cĉoher Monthly sur la partie de Frequencies
-Mettre sur Period ending in Decembre 2009 ensuite click sur le bouton OK
-Il faut vérifier qu'il y a deux messages qui sont affichés
 
Nom du fichier excel:Tests auto grille .xlsx
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function TestGrilCFPercentCas6()
  {
      try {
      
            var RelationshipName=GetData(filePath_Billing,"RelationBilling",36,language)
            
	          var TxtPercentageInflow=GetData(filePath_Billing,"RelationBilling",46,language)
            var TxtPercentageOutflow=GetData(filePath_Billing,"RelationBilling",49,language)
            var TxtAmountInflow=GetData(filePath_Billing,"RelationBilling",41,language)
            var TxtAmountOutflow=GetData(filePath_Billing,"RelationBilling",41,language)
			
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","FIRMADM",vServerBilling);
            RestartServices(vServerBilling);*/
            Delay(2000);
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            
            //ouvrir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Delay(1000);
            SearchRelationshipByName(RelationshipName);
            Delay(800)
            
           // double click sur la relation Billing Relation
            Get_RelationshipsClientsAccountsGrid().Find("Value",GetData(filePath_Billing,"RelationBilling",36,language),100).DblClick();
           Delay(2000);
           Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            
            //Le click sur le bouton Apply pour pouvoir voir la partie de Cash Flow Adjustement
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(3000);
             // remplir la partie Cash Flow Adjustment
             FillTheCashFlowAdjustmen (TxtPercentageInflow,TxtPercentageOutflow,TxtAmountInflow,TxtAmountOutflow)

                // remplir la partie d'en bas
             FillInTheBottomPartOfAccounts(16);


            //Click sur le bouton OK de la fenêtre info
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000)
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            Delay(3000)
            // Décôcher sur la partie frequencies Monsuelle,Semiannual et Annual
            Get_WinBillingParameters_RdoInArrears().Click();
   
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);
            Delay(3000)

            
            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois Septembre
             Get_Calendar_LstMonths_ItemDecember().Click();
             Get_Calendar_BtnOK().Click();
             Delay(3000)
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             WaitUntilCroesusDialogBoxClose();
             
             
             // Les points de vérifications de la partie des messages 
             
             var count = Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Count;
             if(client == "US"){
             if(count==2)
             {
                    var j=0;
                    for(i=0;i<count;i++)
                    {
                   
                           var messages=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ErrorMessage.OleValue;
                           var relationShipName=Get_WinBilling_MessagesDgv().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RelationshipName.OleValue;
                           var relationShipExcel=GetData(filePath_Billing,"RelationBilling",36,language)
                           
                           var messagesExcel=GetData(filePath_Billing,"RelationBilling",58+i+j,language)

                           CheckEquals(messages,messagesExcel, "Valeur des messages de la grille");
                           CheckEquals(relationShipName,relationShipExcel, "Valeur du nom de la relation");
                           j=j+1;
    
                    }  
               }
               else {Log.Error("Il y a une erreur dans le nombre des éléments de la grille RelationShip"); } }
                              

 
             // Fermer application  
             Get_WinBilling_BtnCancel().Click();
             Delay(2000);
             Get_MainWindow().SetFocus();
             Close_Croesus_MenuBar(); }
             //initialiser la bd
            catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
            finally {
            Terminate_CroesusProcess();
            EmptyBillingHistory();
            UncheckedAUMBillable();
            UncheckedBillableRelastionShip();
           /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
            RestartServices(vServerBilling);*/
            Terminate_CroesusProcess();
          }

           
           
          
  }
  
  
          