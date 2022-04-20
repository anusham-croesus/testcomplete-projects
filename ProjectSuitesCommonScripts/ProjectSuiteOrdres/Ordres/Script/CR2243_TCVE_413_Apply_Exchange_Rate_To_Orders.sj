//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Appliquer Taux de change à plusieurs sélections d'ordres. Cas_2 (suite au cas de test TCVE-412)
    https://jira.croesus.com/browse/TCVE-412
    https://jira.croesus.com/browse/TCVE-413
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Philippe Maurice
*/

function CR2243_TCVE413_Apply_Exchange_Rate_To_Orders()
{
    try {
        
        /*VARIABLES*/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var scenario5_arrayOfOrders = ["B01610", "MMM"]; //ordre expiré (CAD-USD) + POT (CAD-CAD)
        var scenario6_arrayOfOrders = ["POT", "MMM"];    //ordre expiré (CAD-USD) + POT (CAD-USD)
                
        Log.Link("https://jira.croesus.com/browse/TCVE-413");
       
        //LOGIN
        Login(vServerOrders, userName, password, language);
        
        //SCÉNARIO 4:  Appliquer un taux de change sur 2 ordres qui sont CAD-USD et USD-CAD et valider le message d'erreur:Symbole: AGU (CAD-USD)
//       Symbole: B55444 (USD-CAD)
        Log.Message("**** Scénario 4 ****");
//        var scenario4_arrayOfOrders = [];
//        Log.Message("Population du tableau de données pour scenario4");
//        for(i=0; i<=1; i++) {
//             scenario4_arrayOfOrders[i] = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc4_order"+(i+1), language+client);
//        }

        Log.Message("Exécution du scénario 4");
        Scenario_4_Validate_Error_Message();

        
        //SCENARIO 5
        Log.Message("**** Scénario 5 ****");
        //Scenario_5_ExchangeRateDisabled(scenario5_arrayOfOrders);  //Ne sera pas utilisé pour le moment, car le cas est pour une BD de RJ
        
               
        //SCENARIO 6
        Log.Message("**** Scénario 6 ****");
        //Scenario_6_Validate_Information_Message(scenario6_arrayOfOrders);   //Ne sera pas utilisé pour le moment, car le cas est pour une BD de RJ
        
               
        //SCENARIO 7:  Appliquer un taux de change sur un ordre en bloc et valider le nouveau taux de change appliqué dans la colonne Taux
        Log.Message("**** Scénario 7 ****");
        var scenario7_order         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc7_order", language+client);
        var scenario7_internalNo    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc7_internalNumber", language+client);
        var scenario7_exchangeRate  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc7_exchangeRate", language+client);
        Log.Message("Exécution du scénario 7");
        Scenario_7(scenario7_order, scenario7_exchangeRate, scenario7_internalNo);
                
        //Fermer Croesus
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}


function Scenario_4_Validate_Error_Message(arrayOfOrders)
{
    //Sélectionner le module Ordres
    Get_ModulesBar_BtnOrders().Click();  
    var sc4_order1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc4_order1", language+client);
    var sc4_order2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc4_order2", language+client);   
    //Sélectionner 2 ordres
//    Log.Message("Sélection des ordres");
//    SelectOrders(arrayOfOrders);
//    
//    //Cliquer-droit sur les ordres
//    var orderSelected = arrayOfOrders[arrayOfOrders.length - 1];
//    Get_OrderGrid().FindChildEx("Value", orderSelected, 10, true, 30000).ClickR();
//    
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Get_OrderGrid().Find("Value",sc4_order1,10).Click();
    // la touche CTRL enfoncée
    Sys.Desktop.KeyDown(0x11);
    // Clic-droit / Fonctions / Taux de change /Appliquer un nouveau taux de change et numéro interne; Confirmer
         
    Get_OrderGrid().Find("Value",sc4_order2,10).Click();
    //Relâcher la touche CTRL enfoncée
    Sys.Desktop.KeyUp(0x11);
    Get_OrderGrid().Find("Value",sc4_order2,10).ClickR()
    //Choisir "Fonctions" et Choisir "Taux de change..."
    Log.Message("Choisir Fonctions et Taux de change dans menu et sub menu");
    Get_OrderGrid_ContextualMenu_Functions().Click();
    Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();
        
    //Valider le message d'erreur
    aqObject.CheckProperty(Get_DlgError_LblMessage(), "Message", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc4_errorMessage", language+client));
              
    //Cliquer sur OK pour fermer la fenêtre
    Log.Message("Fermer la fenêtre");
    Get_DlgError_Btn_OK().Click();
}


function Scenario_5_ExchangeRateDisabled(arrayOfOrders)
{
    Get_ModulesBar_BtnOrders().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //sélectionner un ordre expiré
    SelectOrders(arrayOfOrders);
    
    
    //Cliquer-droit sur les ordres
    var orderSelected = arrayOfOrders[arrayOfOrders.length - 1];
    Get_OrderGrid().FindChildEx("Value", orderSelected, 10, true, 30000).ClickR();   

    //choisir "Fonctions"
    Get_OrderGrid_ContextualMenu_Functions().Click();
    
    //Valider que le  "Taux de change..." est grisé 
    aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, false);
}



function Scenario_6_Validate_Information_Message(arrayOfOrders)
{
    Get_ModulesBar_BtnOrders().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //sélectionner un ordre expiré
    SelectOrders(arrayOfOrders);
    
    //Cliquer-droit sur les ordres
    var orderSelected = arrayOfOrders[arrayOfOrders.length - 1];
    Get_OrderGrid().FindChildEx("Value", orderSelected, 10, true, 30000).ClickR();

    //choisir "Fonctions"
    Get_OrderGrid_ContextualMenu_Functions().Click();
    aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, true);
    Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();

    //valider le message d’Information qui s’affiche
    aqObject.CheckProperty(Get_DlgError_LblMessage(), "Message", cmpEqual, "Vous avez sélectionné des ordres qui sont dans la même devise que les comptes auxquels ils se rapportent. Le taux saisi ne sera appliqué qu'aux ordres qui ne sont pas dans la même devise.");
    
    //cliquer sur OK
    Get_DlgInformation_BtnOK().Click();
    
    //Remplir les champs obligatoires //cliquer sur Ok
    //Cocher la case à cocher
    //Continuer => Le Taux de change doit être appliqué uniquement à l’ordre qui n'est pas expiré dans la colonne Taux
}


function Scenario_7(order, exchangeRate, internalNo)
{ 
    var sc7_exchangeRateValidation= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc7_exchangeRateValidation", language+client);
    Get_ModulesBar_BtnOrders().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    //Sélectionner un seul ordre en bloc, contenant des comptes CAD et des comptes USD (800273-RE et 800273-OB), pour un titre CAD (Symbole: BNS - BANQUE DE NOUVELLE-ECOSSE).
    Log.Message("Sélectionner l'ordre: " + order);
    Search_Order_Symbol(order);
    
    //Clic-droit/ Fonctions/le champ Taux de change est disponible
    Log.Message("Choisir Fonctions et Taux de change dans le menu et sous-menu");
    Get_OrderGrid().FindChildEx("Value", order, 10, true, 30000).ClickR();
    Get_OrderGrid_ContextualMenu_Functions().Click();
    Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();
    
    //remplir les champs obligatoires et cliquer sur Ok
    Log.Message("Remplir les champs obligatoires de la fenêtre Taux de change et cliquer sur OK pour confirmer");
    //Taux de change
    //WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATE"); //YR
    Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().Keys(exchangeRate);
    //No Interne
    Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber().Keys(internalNo);
    
    //Cliquer sur OK pour sauvegarder le tout
    Get_WinExchangeRate_BtnOK().Click();
    Delay(1000);
    //cliquer sur le bouton "Annuler" et par la suite valider la valeur du taux dans la colonne Taux
    Log.Message("Cliquer sur Annuler et ensuite validation de la valeur de taux dans la colonne");
     //WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATECONFIRMATION",60000); //YR
//     if(Get_WinFXRateConfirmation().Exists){
//       Get_WinFXRateConfirmation_BtnCancel().Click();
//     }
        
    //Vérifier si la colonne existe, sinon il faut l'ajouter
    Log.Message("Valider la valeur dans la colonne Taux (ou Rate). Si la colonne n'est pas visible il faut l'ajouter");
    if(!Get_OrderGrid_ChRate().Exists){
        Get_OrderGrid_ChDescription().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Get_GridHeader_ContextualMenu_AddColumn_Rate().Click();
    }
    
    //Valider le Taux appliqué
    aqObject.CheckProperty(Get_OrderGrid().Find("Value",order, 100).DataContext.DataItem,"Rate", cmpEqual,sc7_exchangeRateValidation );
}