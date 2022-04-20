//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Le bouton « Restrictions » dans l’onglet « Portefeuille Assignés » du module Modèles devrait être grisé si le focus est sur un segment
Analyste d'automatisation: Youlia Raisper */


function CR1452_261_BtnRestriction()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 8); //800040-RE
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",model,10).Click();
        
        Get_Models_Details_TabAssignedPortfolios().Click();           
        Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter().DropDown();
        Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter_ItemSleeves().Click();
        
        //Le bouton « Restrictions » est grisé si le focus est sur un segment
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Find("Value",account,10).Click();
        aqObject.CheckProperty( Get_Models_Details_TabAssignedPortfolios_BtnRestrictions(), "IsEnabled", cmpEqual, false); 
             
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}