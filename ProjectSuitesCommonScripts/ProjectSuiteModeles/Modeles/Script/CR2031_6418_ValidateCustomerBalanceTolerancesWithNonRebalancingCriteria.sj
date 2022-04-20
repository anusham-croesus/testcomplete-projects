//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi



/**
        Description : Valider les tolérances du solde d'un client avec des Critères de rééquilibrage non respectés
    
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6418
    
     Version : 	ref90-10-Fm-11
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
       
        
*/
function CR2031_6418_ValidateCustomerBalanceTolerancesWithNonRebalancingCriteria()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        userNameUNI00  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        passwordUNI00  =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        
        
        var MODEL_TOL_RACH_CRITERE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_RACH_CRITERE", language+client);
        var numbClient800046=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbClient800046", language+client);//800046
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client); 
        var account800046FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "account800046FS", language+client); //800046-FS
        var account800046NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "account800046NA", language+client); //800046-NA
        var account800046OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "account800046OB", language+client); //800046-OB
        var account800046RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "account800046RE", language+client); //800046-RE
        //Les VM quand le client est sélectionné
        var VMAcc800046FSCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046FSCltSelectionedEtape4", language+client); //6.218
        var VMAcc800046NACltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046NACltSelectionedEtape4", language+client); //4.375
        var VMAcc800046OBCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046OBCltSelectionedEtape4", language+client); //4.169
        var VMAcc800046RECltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046RECltSelectionedEtape4", language+client); //22.315
        //Les VM quand les comptes est sélectionnés
        var VMAcc800046FSAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046FSAccSelectionedEtape4", language+client); //37.082
        var VMAcc800046NAAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046NAAccSelectionedEtape4", language+client); //37.000
        var VMAcc800046REAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046REAccSelectionedEtape4", language+client); //37,102
        var VMAcc800046OBAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046OBAccSelectionedEtape4", language+client); //37.012
        /*********** Messages de l'étape 4*********************************************************************************************************************/
        var messageCltSelectionedEtape4_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape4_P1", language+client);
        var messageCltSelectionedEtape4_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape4_P2", language+client);
        var messageCltSelectionedEtape4=messageCltSelectionedEtape4_P1 + messageCltSelectionedEtape4_P2
        var messageAccSelectionedEtape4_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape4_P1", language+client);        
        var messageAccSelectionedEtape4_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape4_P2", language+client);        
        var messageAccSelectionedEtape4=messageAccSelectionedEtape4_P1+messageAccSelectionedEtape4_P2
        
        var positionCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "positionCVE", language+client);
        var positionECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "positionECA", language+client);
    
        Login(vServerModeles, userNameUNI00, passwordUNI00, language);
        Get_ModulesBar_BtnSecurities().Click();
        Search_Position(positionCVE);
        Get_SecurityGrid().Find("Value",positionCVE,10).Click();  
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(false);
        Get_WinInfoSecurity_BtnOK().Click();
        
        Search_Position(positionECA);
        Get_SecurityGrid().Find("Value",positionECA,10).Click();  
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(false);
        Get_WinInfoSecurity_BtnOK().Click();
        
         
         
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        // 2-Associer le client 800046
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        SearchModelByName(MODEL_TOL_RACH_CRITERE);     
        Get_ModelsGrid().Find("Value",MODEL_TOL_RACH_CRITERE,10).Click();
        //assigné le client 800046 au modèle TOL RACH CRITERE 
        Log.Message("assigné le client no "+numbClient800046+" au modèle "+MODEL_TOL_RACH_CRITERE) 
        AssociateClientWithModel(MODEL_TOL_RACH_CRITERE,numbClient800046);
        Get_ModelsGrid().Find("Value",MODEL_TOL_RACH_CRITERE,10).Click();
        Get_Models_Details_TabRebalancingCriteria().Click()
        //Côcher la case a côchéée Actif des 2 critères de rééquilibrage.
        var casACocheCritere1=Get_Models_Details_TabRebalancingCriteriaDgRules().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)
        var casACocheCritere2= Get_Models_Details_TabRebalancingCriteriaDgRules().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)
        if(casACocheCritere1.IsChecked ==  false)
        {
        Get_Models_Details_TabRebalancingCriteriaDgRules().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).Click()
        }
        if(casACocheCritere2.IsChecked ==  false)
        {
        Get_Models_Details_TabRebalancingCriteriaDgRules().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).Click()
        }
         //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  

       Log.AppendFolder("+++++++++++++++++++++++++++++++++++++++++++++ Étape 5 de cas de test ++++++++++++++++++++++++++++++++++++++++++++++++")
        //Préparation des paramètres à tester
        var positionsSolde= [position1CAD,position1CAD,position1USD,position1CAD];
        var accountsPP= [account800046FS,account800046NA,account800046OB,account800046RE];
        var VMs1PP= [VMAcc800046FSCltSelectionedEtape4,VMAcc800046NACltSelectionedEtape4,VMAcc800046OBCltSelectionedEtape4,VMAcc800046RECltSelectionedEtape4];
        var VMs2PP= [VMAcc800046FSAccSelectionedEtape4,VMAcc800046NAAccSelectionedEtape4,VMAcc800046OBAccSelectionedEtape4,VMAcc800046REAccSelectionedEtape4];
        
        
        Rebalancing(false, false, true, false, numbClient800046, positionsSolde, accountsPP, VMs1PP, VMs2PP,messageCltSelectionedEtape4, messageAccSelectionedEtape4,account800046FS)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++++++++++++++++++++++++ Étape 6 de cas de test ++++++++++++++++++++++++++++++++++++++++++++++++")
        
        //Données Étape 6 de cas de test
        
        //Les VM quand le client est sélectionné
        var VMAcc800046FSCltSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046FSCltSelectionedEtape6", language+client); //6.205
        var VMAcc800046NACltSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046NACltSelectionedEtape6", language+client); //4.375
        var VMAcc800046OBCltSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046OBCltSelectionedEtape6", language+client); //4.169
        var VMAcc800046RECltSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046RECltSelectionedEtape6", language+client); //22.862
        //Les VM quand les comptes est sélectionnés
        var VMAcc800046FSAccSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046FSAccSelectionedEtape6", language+client); //37.003
        var VMAcc800046NAAccSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046NAAccSelectionedEtape6", language+client); //37.000
        var VMAcc800046REAccSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046REAccSelectionedEtape6", language+client); //38.012
        var VMAcc800046OBAccSelectionedEtape6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800046OBAccSelectionedEtape6", language+client); //37.012
        /*********** Messages de l'étape 4*********************************************************************************************************************/
        var messageCltSelectionedEtape6_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape6_P1", language+client);
        var messageCltSelectionedEtape6_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape6_P2", language+client);
        var messageCltSelectionedEtape6=messageCltSelectionedEtape6_P1 + messageCltSelectionedEtape6_P2
        var messageAccSelectionedEtape6_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape6_P1", language+client);        
        var messageAccSelectionedEtape6_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape6_P2", language+client);        
        var messageAccSelectionedEtape6=messageAccSelectionedEtape6_P1+messageAccSelectionedEtape6_P2
        
        //Préparation des paramètres à tester
        var accountsPP= [account800046FS,account800046NA,account800046OB,account800046RE];
        var VMs1PP= [VMAcc800046FSCltSelectionedEtape6,VMAcc800046NACltSelectionedEtape6,VMAcc800046OBCltSelectionedEtape6,VMAcc800046RECltSelectionedEtape6];
        var VMs2PP= [VMAcc800046FSAccSelectionedEtape6,VMAcc800046NAAccSelectionedEtape6,VMAcc800046OBAccSelectionedEtape6,VMAcc800046REAccSelectionedEtape6];
        
        
        Rebalancing(false, true, true, false, numbClient800046, positionsSolde, accountsPP, VMs1PP, VMs2PP,messageCltSelectionedEtape6, messageAccSelectionedEtape6,account800046FS)
        
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));		   
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
		    Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, userNameUNI00, passwordUNI00, language);
        Get_ModulesBar_BtnSecurities().Click();
        Search_Position(positionCVE);
        Get_SecurityGrid().Find("Value",positionCVE,10).Click();  
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(true);
        Get_WinInfoSecurity_BtnOK().Click();
        
        Search_Position(positionECA);
        Get_SecurityGrid().Find("Value",positionECA,10).Click();  
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(true);
        Get_WinInfoSecurity_BtnOK().Click();
        RemoveClientFromModel(numbClient800046,MODEL_TOL_RACH_CRITERE)
        aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
        
        Terminate_CroesusProcess(); //Fermer Croesus*/
        Runner.Stop(true);
    }
}
