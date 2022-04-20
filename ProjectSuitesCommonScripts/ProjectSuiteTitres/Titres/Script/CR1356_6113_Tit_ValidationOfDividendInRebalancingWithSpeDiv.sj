//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/**
    
    Description : Régression: Validation de dividende dans le réequilibrage avec dividendes exceptionnels
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6113   
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_6113_Tit_ValidationOfDividendInRebalancingWithSpeDiv(){
    

        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security354846", language+client);       
        var account800084 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Account800084", language+client); 
        var date24_12_2009 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date24_12_2009", language+client); 
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "ModelName", language+client); 
        var modelCurrency = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "ModelCurrency", language+client);
        var modelCode = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "ModelCode", language+client);
        var SpecialDiv017 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "SpecialDiv017", language+client);
        var description354846 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Description354846", language+client); 
        var percentage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Percentage", language+client); 
        var typePicker = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "TypePicker", language+client); 
        
    try{            
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6113","Lien du Cas de test sur Testlink");
              
         
        Log.Message("**********************Login********************");                 
        Login(vServerTitre, userNameGP1859, passwordGP1859, language);
         
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 8], 15000);               
        Get_ModulesBar_BtnSecurities().Click(); 
        Get_ModulesBar_BtnSecurities().WaitProperty("IsSelected",true, 15000);      
        Search_Security(security);
        
        //Click sur le titre recherché puis sur info   
        Get_SecurityGrid().Find("Value",security,10).Click(); 
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/24
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date24_12_2009,10).DataContext.DataItem.set_SpecialDividend(true);
        Get_WinInfoSecurity_BtnOK().Click();
        
        //Click sur le boutton 'Modèles'  créer un modèle, désactiver le modèle et associer un compte
        Get_ModulesBar_BtnModels().Click();       
        Create_Model(modelName, "", modelCode, modelCurrency);
        ActivateDeactivateModel(modelName,false);
        AssociateAccountWithModel(modelName,account800084);
        
        //Mailler vers Portefeuille
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter un Titre avec pourcentage et sauvegarder
        Get_Toolbar_BtnAdd().Click();    
        AddPosition(security,percentage,typePicker,"securityDescription");
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Mailler le modèle dans Modèles et l'activer
        Get_ModulesBar_BtnModels().Click();
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnModels());
        ActivateDeactivateModel(modelName,true);
        
        //Rééquilibrage
        Get_Toolbar_BtnRebalance().Click(); //Rééquilibrage étape 1
        WaitObject(Get_CroesusApp(),"Uid","ResynchronizeParameterWindow_678f");
        Get_WinRebalance().Parent.Maximize();
        Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 2
        Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 3  
        
        // Si la colonne 'Dividende' n'est pas affichée
        if (!Get_WinRebalance_TabPositionsToRebalance_ChDividend().Exists){ 
            //Ajouter la colnne 'Dividende'
            Get_WinRebalance_TabPositionsToRebalance_ChDescription().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();              
            Get_GridHeader_ContextualMenu_AddColumn_Dividend().Click();             
            }
        //Vérifier la valeur affichée dans la colonne Dividende
        aqObject.CheckProperty(Get_WinRebalance_RebalancePositionsGrid().Find("Value",description354846,10).DataContext.DataItem,"Dividend",cmpEqual,SpecialDiv017);                                                  
        
        Get_WinRebalance_BtnNext().Click(); //Rééquilibrage étape 4
        //Click sur l'onglet Ordres proposés
        WaitObject(Get_CroesusApp(),"Uid","TabItem_9881");
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
        
        // Désactiver le button GroupedByTransaction si il est activé
        if (Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().DataContext.get_IsGroupedByTransaction())
                Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().DataContext.set_IsGroupedByTransaction(false);
                
       // Si la colonne 'Dividende' n'est pas affichée
       if (!Get_WinRebalance_TabPositionsToRebalance_ChDividend().Exists){            
            //Ajouter la colnne 'Dividende'
            Get_WinRebalance_TabPositionsToRebalance_ChSecurity().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();             
            Get_GridHeader_ContextualMenu_AddColumn_SecurityDividend().Click();         
            }
       //Vérifier la valeur affichée dans la colonne Dividende
       aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().Find("Value",description354846,10).DataContext.DataItem,"SecurityDividend",cmpEqual,SpecialDiv017);
                   
       //Click sur l'onglet: Portefeuille projeté 
       Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();

       // Si la colonne 'Dividende' n'est pas affichée      
       if (!Get_WinRebalance_TabPositionsToRebalance_ChDividend().Exists){ 
            //Ajouter la colnne 'Dividende'
           Get_WinRebalance_TabPositionsToRebalance_ChSymbol().ClickR();
           Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();              
           Get_GridHeader_ContextualMenu_AddColumn_Dividend().Click();         
           }
           //Vérifier la valeur affichée dans la colonne Dividende
       aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",description354846,10).DataContext.DataItem,"Dividend",cmpEqual,SpecialDiv017);
       
       //Retour à l'état initial
        Log.Message("****Supprimer le modèle*****");
        Get_WinRebalance_BtnClose().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); 
        RemoveAccountFromModel(account800084,modelName);
        DeleteModelByName(modelName);
        
        Get_ModulesBar_BtnSecurities().Click();  
        Get_ModulesBar_BtnSecurities().WaitProperty("IsSelected",true, 15000);           
        Search_Security(security);
        
        //Click sur le titre recherché puis sur info   
        Get_SecurityGrid().Find("Value",security,10).Click(); 
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Décocher la case Dividende exceptionnel pour le dividende du 2009/12/24
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date24_12_2009,10).DataContext.DataItem.set_SpecialDividend(false);
        Get_WinInfoSecurity_BtnOK().Click(); 
      }
    catch (e) {
            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {              
        Terminate_CroesusProcess();
    }                    
} 