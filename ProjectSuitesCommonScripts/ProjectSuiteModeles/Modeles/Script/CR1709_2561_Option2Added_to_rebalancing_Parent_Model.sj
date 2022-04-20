//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT CR1709_3157_Option3_Error_Message_Cas9

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2561
Le script devrait être exécuté en anglais et en français  
Analyste d'automatisation: Youlia Raisper */


function CR1709_2561_Option2Added_to_rebalancing_Parent_Model()
{
    try{  
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2561","Cas de test TestLink : Croes-2561")
         
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
        var txtNumberOfModelsAfterSelection=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "txtNumberOfModelsAfterSelection_2561", language+client);
        var selectedSubModelComboBox=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SelectedSubModelComboBox", language+client);
        var lblNumberOfModels=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "LblNumberOfModelsText", language+client); 
        var positionAGF420=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionAGF420", language+client); 
        var positionMTG411=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionMTG411", language+client); 
        var txtNumberOfPositions=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "txtNumberOfPositions", language+client); 
                            
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //Le changement de la BD dans AT
        Get_ModulesBar_BtnModels().Click(); 
         var model="SOUS_MODELE"
        SearchModelByName(model);
        if(Get_ModelsGrid().Find("Value",model,10).Exists){
          //chainer vers le module Portefeuille
          Drag(Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio()); 
          //Supprimer le sous modèle 
          if(Get_PortfolioPlugin().Find("Value",modelRevenusFixes,10).Exists){
              Get_PortfolioPlugin().Find("Value",modelRevenusFixes,10).Click();
              Get_Toolbar_BtnDelete().Click(); 
              var numberOftries=0;  
              while (!Get_DlgConfirmation().Exists && numberOftries < 5){
                Get_Toolbar_BtnDelete().Click();
                numberOftries++;
              }          
              var width =Get_DlgConfirmation().Get_Width();
              Get_DlgConfirmation().Click((width*(1/3)),73);
              if(Get_DlgConfirmation().Exists) {
                Get_DlgConfirmation().Click((width*(1/3)),73);
              }
              //sauvgarder les modification 
              Get_PortfolioBar_BtnSave().Click();
              Get_WinWhatIfSave_BtnOK().Click();
          }
        }
        
        Get_ModulesBar_BtnModels().Click();                                   
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
        //Séléctionner l'option 2 dans le combo box :Rééquilirage du:
        SelectComboBoxItem(Get_WinRebalance_TabParameters_GrpRebalance_CmbSelection(),selectedSubModelComboBox)
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_TxtNumberOfModels(), "Text", cmpEqual, txtNumberOfModelsAfterSelection);
        aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRebalance_LblNumberOfModels(), "Content", cmpEqual, lblNumberOfModels);//avant content        
          
        //avancer à l'étape suivante 
        Get_WinRebalance_BtnNext().Click(); 
        //Valider que tous les portefeuilles assignés aux modèles qui sont parent du modèle sont affichés 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", Account800049OB,10), "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", Client800239,10), "VisibleOnScreen", cmpEqual, true); 
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
        var quantity8000285RE_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity8000285RE_1", language+client);
        var quantity8000285RE_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "quantity8000285RE_2", language+client);

        Scroll();
        //80049-OB 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800049OB,10).Click(); 
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity800049OB_1,10).Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity800049OB_1,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, positionAGF420);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity800049OB_2,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, positionMTG411);
        
        //800239-SF 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Client800239,10).Click();  
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity800239SF_1,10).Click() 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity800239SF_1,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, positionAGF420);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity800239SF_2,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, positionMTG411);
                
        //8000285RE 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Account800285RE,10).Click(); 
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity8000285RE_1,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity8000285RE_1,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, positionAGF420);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",quantity8000285RE_2,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, positionMTG411);
        
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