//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_2962_Check_rebalancing_with_withdrawal

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3164
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3013
Analyste d'automatisation: Youlia Raisper */



function CR1709_3164_Realancing_CriterionOnBusinessAccount(){
  
  try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var Client800252=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800252", language+client); 
        var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);
        var SecurityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client); 
        var SecurityRON=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Security306470", language+client);
        var quantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBMO_3164", language+client);
        var quantityRON=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityRON_3164", language+client);
        var Account800252RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800252RE", language+client);
        var Account800252FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800252FS", language+client);
        var Buy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Buy", language+client);
        var creteria=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Criteria_3164", language+client);
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-3164","Cas de test TestLink : Croes-3164")
        
        Login(vServerModeles, user, psw, language); 
        //S’assurer que le compte entrepris est décochée 
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(Account800252RE);
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account800252RE,10).DblClick();        
        Get_WinAccountInfo_GrpAccount_ChkBusinessAccount().set_IsChecked(false);
        Get_WinAccountInfo_BtnOK().Click();
                
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();

        SearchModelByName(modelCanadianEqui); 
        AssociateClientWithModel(modelCanadianEqui,Client800252)
        /*1- Achat Qte=26061 RON, COMPTE 800252-RE  2- Achat Qte=13 909 BMO, COMPTE 800252-FS */ 
        Rebalancing(SecurityRON,Account800252RE,quantityRON,Buy,SecurityBMO,Account800252FS,quantityBMO)
        
        //Dans compte ==> 800252-RE ==> Info ==> Cocher compte entrepris
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(Account800252RE);
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account800252RE,10).DblClick();        
        Get_WinAccountInfo_GrpAccount_ChkBusinessAccount().set_IsChecked(true);
        Get_WinAccountInfo_BtnOK().Click();
        
        /*Crééer un critere de rééquiulibrage pour valider le rééquilibragee sur compte d'entreprise:
        dans module Modele séléctionner CH canadien equi ==> onglet critere de rééquilibrage ==> associer/gérer ==> 
        ajouter le critere suivant : pour chaque titre ayant symbole =BMO, acheter position dans un compte ayant compte d'entreprise= oui
        Assigner le critere au modele et rééquilibrer*/
        
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelCanadianEqui);
        Get_ModelsGrid().Find("Value",modelCanadianEqui,10).Click();
        
        Get_Models_Details_TabRebalancingCriteria().Click();
        Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
        
        Get_WinRebalancingCriteriaManager_PadHeader_BtnAdd().Click();
        Get_WinAccountRebalancingCriteria_TxtName().Keys(creteria);
        Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb_ItemHaving().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbField().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbField_ItemSymbol().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbOperator().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_ItemEqualTo().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbValue().Click();
               
        Get_WinSelectionSymbol_DgAvailable().WPFObject("RecordListControl", "", 1).Keys("F");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(SecurityBMO);
        Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        
        Get_WinSelectionSymbol_DgAvailable().WPFObject("RecordListControl", "", 1).Find("DisplayText",SecurityBMO,10).Click();
        Get_WinSelectionSymbol_BtnToRight().Click();
        Get_WinSelectionSymbol_BtnOk().Click();
        
        Get_WinAccountRebalancingCriteria_LstCondition_LlbNext().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbNext_ItemDot().Click();
        
        Get_WinAccountRebalancingCriteria_LstAction_LlbVerb().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbVerb_ItemHaving().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbField().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemInformative().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemInformative_ItemBusinessAccount().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbOperator().Click();
        Get_WinAccountRebalancingCriteria_LstAction_ItemEqualTo().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbValue().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbValue_ItemYes().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbNext().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbNext_ItemDot().Click();
        
        Get_WinAccountRebalancingCriteria_BtnSave().Click();

        Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",creteria,10).Click();
        Get_WinRebalancingCriteriaManager_BtnAssign().Click();
        Get_Models_Details_DgvDetails().Find("Value",creteria,10).DataContext.DataItem.set_Active(true);
        /*a etape 1 du rééquilibrage décocher les cases : valiser les limites , repartir la liquidité et appliquer les frais
        valider que ordre achat se fait en respectant le critere de rééquilibrage , les ordres achat se font sur le compte de compagnie 800252-RE
        1- Achat Qte=26061 RON, COMPTE 800252-FS
        2- Achat Qte=13 909 BMO, COMPTE 800252-RE*/
        
        SearchModelByName(modelCanadianEqui); 
        Get_ModelsGrid().Find("Value",modelCanadianEqui,10).Click();
        Rebalancing(SecurityBMO,Account800252RE,quantityBMO,Buy,SecurityRON,Account800252FS,quantityRON)
        
        /*VALIDER LE CRITERE DE RECHERCHE EST INACTIF:
        modele ch canadien equi ==> onglet criteres de rééquilibrage==> décocher la case Actif et rééquilibrer
        Valider que le résultat attendu = résulata etape2 */
        Get_Models_Details_DgvDetails().Find("Value",creteria,10).DataContext.DataItem.set_Active(false)
        SearchModelByName(modelCanadianEqui); 
        Get_ModelsGrid().Find("Value",modelCanadianEqui,10).Click();
        Rebalancing(SecurityRON,Account800252RE,quantityRON,Buy,SecurityBMO,Account800252FS,quantityBMO)
        //*************************************************Réinitialiser les données*********************************************************  
         //RestoreData(Client800252,modelCanadianEqui,creteria);
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {  
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);         
        Get_MainWindow().Maximize();
        RestoreData(Client800252,modelCanadianEqui,creteria);
        Terminate_CroesusProcess(); //Fermer Croesus 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Runner.Stop(true);     
    }
}

function GoToProjectedPortfolios(){
     Get_WinRebalance_BtnNext().Click();  
     Get_WinRebalance_BtnNext().Click();  
     Get_WinRebalance_BtnNext().Click();     
     if(Get_WinWarningDeleteGeneratedOrders().Exists) {
        Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
     }
     WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
}

function RestoreData(Client800252,modelCanadianEqui,creteria){
                
      Get_ModulesBar_BtnModels().Click();
      SearchModelByName(modelCanadianEqui); 
      Get_Models_Details_TabRebalancingCriteria().Click();
      Get_ModelsGrid().Find("Value",modelCanadianEqui,10).Click();
      if(Get_Models_Details_DgvDetails().FindChild("Value", creteria, 10).Exists){
         Get_Models_Details_DgvDetails().FindChild("Value", creteria, 10).Click();
         Get_Models_Details_TabRebalancingCriteria_BtnRemove().Click(); 
      }
     
      Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
      if(Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",creteria,10).Exists){
        Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",creteria,10).Click();
        Get_WinRebalancingCriteriaManager_PadHeader_BtnDelete().Click();
        if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73) 
        }
      }
      Get_WinRebalancingCriteriaManager_BtnClose().Click();
      
      Get_Models_Details_TabAssignedPortfolios().Click();
      if(Get_Models_Details_DgvDetails().FindChild("Value", Client800252, 10).Exists){      
        Get_Models_Details_DgvDetails().FindChild("Value", Client800252, 10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        //Get_DlgCroesus().Click(150, 70); //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
      }     
}


function Rebalancing(Security1,Account800252RE,quantity1,Buy,Security2,Account800252FS,quantity2){
    //Rééquilibrer le modele   
    Get_Toolbar_BtnRebalance().Click();
    //Dans le cas, si le click ne fonctionne pas  
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_WinRebalance().Exists){
      Get_Toolbar_BtnRebalance().Click(); 
      numberOftries++;
    } 
    Get_WinRebalance().Parent.Maximize();
    //Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.
    Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
    Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
    Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
        
    GoToProjectedPortfolios();            
        
    //Valider que les odres suivant sont générés :1- Achat Qte=26061 RON, COMPTE 800252-RE ; 2- Achat Qte=13 909 BMO, COMPTE 800252-FS 
    var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("DisplayText",Security1,10).DataContext.Index
    Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
    aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Account800252RE,10).DataContext.DataItem , "DisplayExpectedQuantity", cmpEqual, quantity1);        
    aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Account800252RE,10).DataContext.DataItem , "OrderTypeDescription", cmpEqual, Buy); 
    Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false)
      
    var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("DisplayText",Security2,10).DataContext.Index
    Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
    aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Account800252FS,10).DataContext.DataItem , "DisplayExpectedQuantity", cmpEqual, quantity2);        
    aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",Account800252FS,10).DataContext.DataItem , "OrderTypeDescription", cmpEqual, Buy); 
    Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false)
        
    Get_WinRebalance_BtnClose().Click();  
    /*var width = Get_DlgWarning().Get_Width();
    Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73); 
  
}

