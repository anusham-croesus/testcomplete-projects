//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2562
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */


function CR1709_2562_Option3Added_to_rebalancing_Assigned_Model()
{
    try{ 
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2562","Cas de test TestLink : Croes-2562")
         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "0", vServerModeles)            
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "NO", vServerModeles)  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)
        RestartServices(vServerModeles);  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client); 
        var modelsubsProrata=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "modelsubsProrata", language+client);
        var modelMoyenTerme=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);
        var modelRevenusFixes=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelRevenusFixes", language+client);
        var Account800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049OB", language+client);
        var Account800245GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800245GT", language+client);
        var Account800285RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800285RE", language+client);
        var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800239", language+client);
        var Account800239SF=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800239SF", language+client);
        var target20=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target20", language+client);
        var target10=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target10", language+client);
        var target5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target5", language+client);
        var txtNumberOfModelsAfterSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "txtNumberOfModels_2562", language+client);
        var selectedModelSubModelComboBox=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SelectedModelSubModelComboBox", language+client);
        var lblNumberOfModels=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "LblNumberOfModelsText", language+client); 
        var positionAGF420=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionAGF420", language+client); 
        var positionMTG411=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionMTG411", language+client); 
        var txtNumberOfPositions=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "txtNumberOfPositions", language+client); 
                            
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                                 
        //Rééquilibrer le modèle 
        SearchModelByName(modelRevenusFixes);
          
        Get_Toolbar_BtnRebalance().Click(); 
        //Dans le cas, si le click ne fonctionne pas  
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){
            Get_Toolbar_BtnRebalance().Click(); 
            numberOftries++;
        } 
          
        Get_WinRebalance().Parent.Maximize();
        //Séléctionner l'option 3 dans le combo box :Rééquilirage du:
        SelectComboBoxItem(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(),selectedModelSubModelComboBox)
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_TxtNumberOfModels(), "Text", cmpEqual, txtNumberOfModelsAfterSelection);
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_LblNumberOfModels(), "Content", cmpEqual, lblNumberOfModels);        
          
        //avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click(); 
        //Valider que tous les portefeuilles assignés aux modèles qui sont parent du modèle sont affichés 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", Account800049OB,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", Client800239,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", Account800245GT,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", Account800285RE,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, txtNumberOfModelsAfterSelection);
        
        //avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();
        //Valider les positions affichés sont uniquement celles du modele ch revenu fixe = AGF420 + MTG411
        aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().Find("Value", positionAGF420,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().Find("Value", positionMTG411,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().Items, "Count", cmpEqual, "3"); //EM : 90.10.Fm-2 : mnt 3 car la Position solde 1CAD s'affiche aussi depuis Fm - Avant c'était 2.
        
        //avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        if(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked==true){
          Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click()
        }
       
        var quantity800049OB_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800049OB_1", language+client);
        var quantity800049OB_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800049OB_2", language+client);
        var quantity800239SF_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800239SF_1", language+client);
        var quantity800239SF_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800239SF_2", language+client);
        var quantity800245GT_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800245GT_1", language+client);
        var quantity800245GT_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800245GT_2", language+client);
        var quantity800245GT_3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800245GT_3", language+client);
        var quantity800245GT_4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800245GT_4", language+client);
        var quantity800245GT_5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800245GT_5", language+client);
        var quantity800245GT_6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity800245GT_6", language+client);
        var quantity8000285RE_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity8000285RE_1", language+client);
        var quantity8000285RE_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity8000285RE_2", language+client);

        //80049-OB quantité 1481.615 et 882.939    
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800049OB_1,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800049OB);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800049OB_2,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800049OB);
        
        //800239-SF quantité 2188,936;1304,453   
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800239SF_1,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800239SF);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800239SF_2,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800239SF);
        
        //800245-GT quantité 6 297,586;(2 940,117);2 399,204;(15 000);(9 000);(47 000)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800245GT_1,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800245GT);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800245GT_2,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800245GT);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800245GT_3,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800245GT);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800245GT_4,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800245GT);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800245GT_5,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800245GT);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity800245GT_6,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800245GT);
        
        //8000285RE 1095,491 ;652,836
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity8000285RE_1,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800285RE);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",quantity8000285RE_2,10).DataContext.DataItem, "AccountNumber", cmpEqual, Account800285RE);
        
        Get_WinRebalance_BtnClose().Click(); 
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
                       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus 
      Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
      Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "1", vServerModeles)            
      Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "YES", vServerModeles)
      Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_SUBMODEL", "NO", vServerModeles)
      Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles) 
      RestartServices(vServerModeles); 
	    Runner.Stop(true);      
    }
}