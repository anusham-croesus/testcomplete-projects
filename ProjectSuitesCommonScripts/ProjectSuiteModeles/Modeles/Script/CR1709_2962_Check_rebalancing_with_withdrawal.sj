//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3157_Option3_Error_Message_Cas9

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2962
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-5738 - Depuis 90.08.15 Dy
 
Analyste d'automatisation: Youlia Raisper */



function CR1709_2962_Check_rebalancing_with_withdrawal(){
  
  try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var Account300010NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account300010NA", language+client);
        var Account300010OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account300010OB", language+client);
        var Client300010=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client300010", language+client); 
       
        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", language+client);
        var FrequencyQuarterly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyQuarterly", language+client);
        var FrequencyBiannually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyBiannually", language+client);
        var FrequencyAnnually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyAnnually", language+client);
        
        var DataFrequency1_300010NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency1_300010NA", language+client);
        var DataFrequency2_300010NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency2_300010NA", language+client); 
        var DataFrequency1_300010OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency1_300010OB", language+client);
        var DataFrequency2_300010OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DataFrequency2_300010OB", language+client); 
        
        var Montant300010NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant300010NA_1", language+client);
        var Montant300010NA_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant300010NA_2", language+client);
        var Montant300010OB_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant300010OB_1", language+client);
        var Montant300010OB_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Montant300010OB_2", language+client);
        
        var ModelChBonds=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChBonds", language+client); 
        
        var DepositWithdrawalAmount200=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount200", language+client)
        //var SummarytBalanceAccount300010NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount300010NA", language+client)
        var SummarytMVAccount300010NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytMVAccount300010NA", language+client)
        //var SummarytBalanceAccount300010NA_6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount300010NA_6", language+client)
        var SummarytMVAccount300010NA_6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytMVAccount300010NA_6", language+client)
        //var SummarytBalanceAccount300010OB_6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount300010OB_6", language+client)
        var SummarytMVAccount300010OB_6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytMVAccount300010OB_6", language+client)
        var DepositWithdrawalAmount2458=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount2458", language+client)
        var DepositWithdrawalAmount1000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount1000", language+client)
        var DepositWithdrawalAmount1400=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount1400", language+client)
        var Message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message2962", language+client)
        var DepositWithdrawalAmount3293=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount3293", language+client)
        var DepositWithdrawalAmount1600=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount1600", language+client)
        var DepositWithdrawalAmount5128=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount5128", language+client)
        var DepositWithdrawalAmount2800=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount2800", language+client)
        var DepositWithdrawalAmount2200=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DepositWithdrawalAmount2200", language+client)
        //var SummarytBalanceAccount300010NA_9=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount300010NA_9", language+client)
        var SummarytMVAccount300010NA_9=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytMVAccount300010NA_9", language+client)
        //var SummarytBalanceAccount300010OB_9=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount300010OB_9", language+client)
        var SummarytMVAccount300010OB_9=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytMVAccount300010OB_9", language+client)
        //var SummarytBalanceAccount300010NA_12=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount300010NA_12", language+client)
        var SummarytMVAccount300010NA_12=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytMVAccount300010NA_12", language+client)
        //var SummarytBalanceAccount300010OB_12=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount300010OB_12", language+client)
        var SummarytMVAccount300010OB_12=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytMVAccount300010OB_12", language+client)
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-5738","Cas de test TestLink : Croes-5738")
        
        if(language=="french"){
          var format="%Y/%m/%d"
        }else{
          var format="%m/%d/%Y"
        }
        
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnClients().Click();
        Get_MainWindow().Maximize();
        
        //Fermer tous les filtres s'ils existent //EM : 90-07-22 : Modification dûe a l'existance d'un filtre qui cache les clients recherchés  
        while(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
                     
        Search_Client(Client300010);
        
        // chainer vers le module Comptes,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",Client300010,10), Get_ModulesBar_BtnAccounts());
        
        Search_Account(Account300010NA)
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        Get_WinAccountInfo_TabCashManagement().WaitProperty("IsChecked", true);
        //Saisir les montants
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys(Montant300010NA_1);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, Montant300010NA_1); 
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys(Montant300010NA_2);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value",cmpEqual, Montant300010NA_2); 
        
        /*Fréquence 1 = trimestrielle, Montant =200 , date1= 02.03.2009
        Fréquence 2 = Semestrielle, Montant =1000 , date1= 15.06.2009*/
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(), FrequencyQuarterly);
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(), FrequencyBiannually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, FrequencyQuarterly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, FrequencyBiannually);
                
        //Remplir champ date --> saisir date début 1 , date début 2            
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
        Log.Message(aqConvert.DateTimeToFormatStr(DataFrequency1_300010NA,format))
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(aqConvert.DateTimeToFormatStr(DataFrequency1_300010NA,format))
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Click();
        Log.Message(aqConvert.DateTimeToFormatStr(DataFrequency2_300010NA,format))
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Keys(aqConvert.DateTimeToFormatStr(DataFrequency2_300010NA,format))                
        Get_WinAccountInfo_BtnOK().Click();

        Search_Account(Account300010OB)
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        Get_WinAccountInfo_TabCashManagement().WaitProperty("IsChecked", true);
        //Saisir  les montants
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().Keys(Montant300010OB_1);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1(),"Value", cmpEqual, Montant300010OB_1); 
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2().Keys(Montant300010OB_2);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD2(),"Value", cmpEqual, Montant300010OB_2);  
        
        /*Fréquence 1 =Annuelle, Montant =1000 , date1= 01.05.2009
        Fréquence 2 = Mensuelle, Montant =200 , date1= 20.08.2009*/
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(), FrequencyAnnually);
        SelectComboBoxItem(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(), FrequencyMonthly);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1(),"Text", cmpEqual, FrequencyAnnually);
        aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency2(),"Text", cmpEqual, FrequencyMonthly);
               
        //Remplir champ date --> saisir date début 1 , date début 2                
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(aqConvert.DateTimeToFormatStr(DataFrequency1_300010OB,format))
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate2().Keys(aqConvert.DateTimeToFormatStr(DataFrequency2_300010OB,format))          
        Get_WinAccountInfo_BtnOK().Click();
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Search_Account(Account300010NA);
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010NA,10).Click();
              
        var FrequencyMonthly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyMonthly", "english"+client);
        var FrequencyQuarterly=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyQuarterly", "english"+client);
        var FrequencyBiannually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyBiannually", "english"+client);
        var FrequencyAnnually=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FrequencyAnnually", "english"+client);
        
        //Validation pour le compte 300010-NA              
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010NA,10).DataContext.DataItem,"SystematicWithdrawalBeginDate1", cmpEqual, DataFrequency1_300010NA);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010NA,10).DataContext.DataItem,"SystematicWithdrawalBeginDate2", cmpEqual, DataFrequency2_300010NA);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010NA,10).DataContext.DataItem,"SystematicWithdrawalFrequency1", cmpEqual, FrequencyQuarterly);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010NA,10).DataContext.DataItem,"SystematicWithdrawalFrequency2", cmpEqual,FrequencyBiannually );
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010NA,10).DataContext.DataItem,"SystematicWithdrawalAmount1", cmpEqual, Montant300010NA_1);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010NA,10).DataContext.DataItem,"SystematicWithdrawalAmount2", cmpEqual, Montant300010NA_2);
                
        //Validation pour le compte 300010-OB 
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010OB,10).Click();            
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010OB,10).DataContext.DataItem,"SystematicWithdrawalBeginDate1", cmpEqual, DataFrequency1_300010OB);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010OB,10).DataContext.DataItem,"SystematicWithdrawalBeginDate2", cmpEqual, DataFrequency2_300010OB);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010OB,10).DataContext.DataItem,"SystematicWithdrawalFrequency1", cmpEqual, FrequencyAnnually);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010OB,10).DataContext.DataItem,"SystematicWithdrawalFrequency2", cmpEqual, FrequencyMonthly);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010OB,10).DataContext.DataItem,"SystematicWithdrawalAmount1", cmpEqual, Montant300010OB_1);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300010OB,10).DataContext.DataItem,"SystematicWithdrawalAmount2", cmpEqual, Montant300010OB_2);
        
          
        Get_ModulesBar_BtnModels().Click();
        //assigné le client 300010 au CH BONDS 
        Search_Model(ModelChBonds);
        AssociateClientWithModel(ModelChBonds,Client300010);
                                                                 
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize(); 
                    
        //A etape 1 --> vérifier que le champ retrait systématique = 0 mois --> 
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_TxtSystematicWithdrawals(),"Value", cmpEqual, "0"); 
        //Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.
        Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
                        
        //**************************Insérer 3 dans le champ retrait systématique = 3 mois --> cliquez sur next et valider que la colonneGest.encaisse= -200       
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("3")
        //Avancer à l'étape suivante 
        //Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse compte 300010-NA= (200) qui correspond au 1er retrait trimestrielle .
        CheckDepositWithdrawalAmount(Client300010,Account300010NA,Account300010OB,DepositWithdrawalAmount200,DepositWithdrawalAmount200,"")
        
        GoToProjectedPortfolios();
        
        /*Dans portefeuille projeté , valider l'icone sur le compte 300010-NA : la valeur du solde  inclut les mouvement d'encaisse 
         1- Valider que la VM compte 300010-NA = 515 532.74  ------------> //EM : Modifié depuis 90.08.Dy-2 : Suite à la réponse de Karima MO. On valide plus le solde, on valide la valeur de marché
         2-Valider colonne gestion encaisse (Droite)= -200*/
         Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
         Scroll();
         Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account300010NA,10).Click();
         aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account300010NA,10).DataContext.DataItem,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount200);
         Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
         //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(),"Text",cmpEqual,SummarytBalanceAccount300010NA); //EM : Modifié depuis 90.08.Dy-2 : Suite à la réponse de Karima MO. On valide plus le solde, on valide la valeur de marché
         aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(),"Text",cmpEqual,SummarytMVAccount300010NA); 
        
        //*********************Rerourner a etape 1 ==> saisir 6 dans le champ retrait systématique. Next a etape 2
        GoToPreviousStep1();
        /*cliquez sur next pour allez a etape 2 == Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse :
        compte 300010-NA= (1400) .
        compte 300010-OB= ( 1000)
        -valider la colonne Gest.encaisse la grille Client 300010 = (-2 458.50)
        Next a étape 4*/
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("6")
        CheckDepositWithdrawalAmount(Client300010,Account300010NA,Account300010OB,DepositWithdrawalAmount2458,DepositWithdrawalAmount1400,DepositWithdrawalAmount1000)
        
        //Avancer à l'étape suivante 
        GoToProjectedPortfolios();
        
        /*Dans portefeuille projeté , Valider l'icone + Info bulle sur le compte 300010-NA et 30010-OB : la valeur du solde  inclut les mouvement d'encaisse 
        Valider que la VM : ------------> //EM : Modifié depuis 90.08.Dy-2 : Suite à la réponse de Karima MO. On valide plus le solde, on valide la valeur de marché
        compte 300010-NA = 514 333.91
        compte 300010-OB = 484 862.68 
        la colonne Gest.encaisse grielle de droite Client 300010 = (-2 458.50)*/
        CheckInProjectedPortfolios(Message,Client300010,DepositWithdrawalAmount2458,Account300010NA,Account300010OB,SummarytMVAccount300010NA_6,DepositWithdrawalAmount1400,SummarytMVAccount300010OB_6,DepositWithdrawalAmount1000)
               
        //*********************Rerourner a etape 1 ==> saisir 9 dans le champ retrait systématique
        GoToPreviousStep1();
        /*Cliquez sur next pour allez a etape 2 == Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse :
        compte 300010-NA= (1600) .
        compte 300010-OB= ( 1600)
        -valider la colonne Gest.encaisse la grille Client 300010 = (-3 293.60)*/
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("9")
        CheckDepositWithdrawalAmount(Client300010,Account300010NA,Account300010OB,DepositWithdrawalAmount3293,DepositWithdrawalAmount1600,DepositWithdrawalAmount1600)
        
        /*Dans portefeuille projeté , Valider l'icone + Info bulle sur le compte 300010-NA et 30010-OB : la valeur du solde  inclut les mouvement d'encaisse 
        Valider que la VM : ------------> //EM : Modifié depuis 90.08.Dy-2 : Suite à la réponse de Karima MO. On valide plus le solde, on valide la valeur de marché
        compte 300010-NA= 514 134.13
        compte 300010-OB= 484 262.68
        la colonne Gest.encaisse grielle de droite Client 300010 = (3293.60)*/
        GoToProjectedPortfolios();
        CheckInProjectedPortfolios(Message,Client300010,DepositWithdrawalAmount3293,Account300010NA,Account300010OB,SummarytMVAccount300010NA_9,DepositWithdrawalAmount1600,SummarytMVAccount300010OB_9,DepositWithdrawalAmount1600)
               
        //******************Rerourner a etape 1 ==> saisir 12 dans le champ retrait systématique
        GoToPreviousStep1();         
        /*cliquez sur next pour allez a etape 2 == Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse :
        compte 300010-NA= (2800) .
        compte 300010-OB= (2200)
        -valider la colonne Gest.encaisse la grille Client 300010 = (5 128.70)*/
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("12")
        CheckDepositWithdrawalAmount(Client300010,Account300010NA,Account300010OB,DepositWithdrawalAmount5128,DepositWithdrawalAmount2800,DepositWithdrawalAmount2200)
        
        /*Dans portefeuille projeté , Valider l'icone + Info bulle sur le compte 300010-NA et 30010-OB : la valeur du solde  inclut les mouvement d'encaisse 
        Valider que la VM  ------------> //EM : Modifié depuis 90.08.Dy-2 : Suite à la réponse de Karima MO. On valide plus le solde, on valide la valeur de marché
        compte 300010-NA = 512 935,07
        compte 300010-OB = 483 662.68 
        la colonne Gest.encaisse grielle de droite Client 300010 = (5128.70)*/
        GoToProjectedPortfolios();        
        CheckInProjectedPortfolios(Message,Client300010,DepositWithdrawalAmount5128,Account300010NA,Account300010OB,SummarytMVAccount300010NA_12,DepositWithdrawalAmount2800,SummarytMVAccount300010OB_12,DepositWithdrawalAmount2200)
                   
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
    
        //*************************************************Réinitialiser les données*********************************************************
        /*Get_ModulesBar_BtnModels().Click();
        SearchModelByName(ModelChBonds);
        RemoveAccountFromModel(Client300010,ModelChBonds);*/ 
             
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         
    }
    finally {  
        Login(vServerModeles, user, psw, language);            
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        SearchModelByName(ModelChBonds);
        RemoveAccountFromModel(Client300010,ModelChBonds);
        Terminate_CroesusProcess(); //Fermer Croesus  
        Runner.Stop(true);           
    }
}

function Scroll(){
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualHeight()  
  //for (i=1; i<=3; i++) 
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Click(ControlWidth-40, ControlHeight-49)
}
 
function CheckDepositWithdrawalAmount(Client300010,Account300010NA,Account300010OB,DepositWithdrawalAmountClient,DepositWithdrawalAmount300010NA,DepositWithdrawalAmount300010OB){
    Get_WinRebalance_BtnNext().Click();  
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",Client300010,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmountClient) 
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    if (DepositWithdrawalAmount300010NA != undefined && Trim(VarToStr(DepositWithdrawalAmount300010NA)) !== ""){
      aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",Account300010NA,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount300010NA)
    }
    if (DepositWithdrawalAmount300010OB != undefined && Trim(VarToStr(DepositWithdrawalAmount300010OB)) !== ""){
      aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",Account300010OB,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount300010OB)       
    }
    Get_WinCashManagement_BtnCancel().Click();
}

function GoToProjectedPortfolios(){
     Get_WinRebalance_BtnNext().Click();  
     Get_WinRebalance_BtnNext().Click();  
     WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
}
 
function GoToPreviousStep1(){
     Get_WinRebalance_BtnPrevious().Click(); 
     /*var width = Get_DlgWarning().Get_Width();
     Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
     var width = Get_DlgConfirmation().Get_Width();
     Get_DlgConfirmation().Click((width*(1/3)),73);
     Get_WinRebalance_BtnPrevious().Click(); 
     Get_WinRebalance_BtnPrevious().Click();
}

function CheckInProjectedPortfolios(Message,Client300010,DepositWithdrawalAmountClient,Account300010NA,Account300010OB,SummarytMVAccount300010NA,DepositWithdrawalAmount300010NA,SummarytMVAccount300010OB,DepositWithdrawalAmount300010OB)
{
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,Message)
    Scroll();
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Client300010,10).DataContext.DataItem,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmountClient); 
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account300010NA,10).Click();
	  Log.Message("BNC-1887")
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account300010NA,10).DataContext.DataItem,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount300010NA);
    //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(),"Text",cmpEqual,SummarytBalanceAccount300010NA); //Avant Content //EM : Modifié depuis 90.08.Dy-2 : Suite à la réponse de Karima MO. On valide plus le solde, on valide la valeur de marché    
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(),"Text",cmpEqual,SummarytMVAccount300010NA);  
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account300010OB,10).Click();
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account300010OB,10).DataContext.DataItem,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount300010OB); 
    //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(),"Text",cmpEqual,SummarytBalanceAccount300010OB);//Avant Content //EM : Modifié depuis 90.08.Dy-2 : Suite à la réponse de Karima MO. On valide plus le solde, on valide la valeur de marché 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(),"Text",cmpEqual,SummarytMVAccount300010OB); 
}