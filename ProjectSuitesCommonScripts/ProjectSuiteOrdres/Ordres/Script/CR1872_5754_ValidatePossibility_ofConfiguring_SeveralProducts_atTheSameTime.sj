//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Valider la possibilité de configurer plusieurs produits en meme temps
                    
                - Modifier PREF - Niveau Firm: GDO_ETF_MARKET = "GDO_MFP_MARKET_NAS, PTF, MARKET_CODE = Q, SECURITY_TYPE = 3308001 | 3308000 ; GDO_MFP_MARKET_TSE, NAVex, MARKET_CODE = T, SECURITY_TYPE = 3308001 | 3308000"
                
                - Se connecter avec KEYNEJ, ouvrir Croesus puis exécuter ce critere de titres :
                  Liste des titres ayant type/classe(sous-catégorie) égal(e) à 3308000 ou ayant type/classe(sous-catégorie) égal(e) à 3308001.
                - la colonne Bourse affiche : 
                  NAS NAVex pour les produits(titres) NAVex
                  TSE PTF  pour les produits(titres) PTF
                  
                  Remarque: 
                  
                  À cause de problème de BD (Le titre 845510 n'a pas de bourse. Il y'a des titres dans la BD qui ne respectent pas la bonne configuration. c'est une action , normalement il devrait avoir une bourse)
                  et après une discussion avec Mamoudou, il m'a demandé de :
                  
                  - Cibler deux titres par exemple, un pour chaque catégorie :
                    1. symbole = choisir un symbole, type = 3308000, valider que Bourse = NAS NAVex
                    2. symbole = choisir un symbole, type = 3308001 , valider que Bourse = TSE PTF
                  
                
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5754
    Analyste d'assurance qualité : mamoudoud
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	Er-1
*/

function CR1872_5754_ValidatePossibility_ofConfiguring_SeveralProducts_atTheSameTime()
{
    try {
                
        Activate_Inactivate_PrefFirm("FIRM_1","GDO_ETF_MARKET","GDO_MFP_MARKET_NAS, PTF, MARKET_CODE = Q, SECURITY_TYPE = 3308001 | 3308000 ; GDO_MFP_MARKET_TSE, NAVex, MARKET_CODE = T, SECURITY_TYPE = 3308001 | 3308000",vServerOrders)
        RestartServices(vServerOrders)
               
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "CriterionName_5754", language+client);
        var securityType3308000 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "SecurityType3308000", language+client);
        var securityType3308001 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "SecurityType3308001", language+client);
        var NAVexMarket = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "NAVexMarket", language+client);
        var PTFMarket = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "PTFMarket", language+client);
        var GSVDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "GSVDotUN", language+client);
        var ELUXY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "ELUXY", language+client);
        
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5754","Cas de test TestLink : Croes-5754")
                
        //Login
        Log.Message("**************************************Login*********************************************")
        Login(vServerOrders, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks")
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
        
        //Créér un critère = Liste des titres ayant type/classe(sous-catégorie) égal(e) à 3308000 ou ayant type/classe(sous-catégorie) égal(e) à 3308001.
        Log.Message("Créer le critère "+criterionName+" = Liste des titres ayant type/classe(sous-catégorie) égal(e) à "+securityType3308000+" ou ayant type/classe(sous-catégorie) égal(e) à "+securityType3308001)
        Create_Criterion(criterionName, securityType3308000, securityType3308001);
        
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
        
        Log.Message("********************************Check Criterion Properties*******************************")
        //Valider que le bouton Get_Toolbar_BtnAddOrDisplayAnActiveCriterion est selectionné 
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked", cmpEqual,true);
        Log.Message(aqConvert.StrToInt(Get_MainWindow_StatusBar_NbOfcheckedElements().get_Text())+" titres cochés.");
        
        Log.Message("Ajouter la colonne Bourse");
        if(!Get_SecurityGrid_ChMarket().Exists){        
            Get_SecurityGrid_ChSecurity().ClickR();
            Get_SecurityGrid_ChSecurity().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
            Get_GridHeader_ContextualMenu_AddColumn_Market().Click();
            //AddColumn(Get_SecurityGrid_ChSecurity(), Get_GridHeader_ContextualMenu_AddColumn_Market());
        }
            
        
        //Log.Message("Valider que tous les titres affichés respectent le critère de recherche.");
        Log.Message("Validation des données : Cibler deux titres, un pour chaque catégorie.");
        CheckCriterionDataInSecurityGrid(GSVDotUN, securityType3308001, NAVexMarket);
        CheckCriterionDataInSecurityGrid(ELUXY, securityType3308000, PTFMarket);
        
        Log.Message("*************************************CLEANUP**********************************************")
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks")
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);        
        
        Log.Message("Enlever la colonne Bourse");
        if(Get_SecurityGrid_ChMarket().Exists)
            DeleteColumn(Get_SecurityGrid_ChMarket());
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.Message("*************************************************CLEANUP*********************************************************")
        Login(vServerOrders, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
        Log.Message("Enlever la colonne Bourse");
        if(Get_SecurityGrid_ChMarket().Exists)
            DeleteColumn(Get_SecurityGrid_ChMarket());  
        
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();  
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Log.Message("Supprimer le critère "+criterionName+" de BD ")
        Delete_FilterCriterion(criterionName,vServerOrders)//Supprimer le criterion de BD 
        Activate_Inactivate_PrefFirm("FIRM_1","GDO_ETF_MARKET","",vServerOrders)
        RestartServices(vServerOrders)
        Runner.Stop(true)
    }
}


function Create_Criterion(criterion, securityType3308000, securityType3308001){
      
      Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
      Get_WinAddSearchCriterion().Parent.Maximize();
          
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().Keys(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemTypeClassSubCategory().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(securityType3308000)
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemOr().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemTypeClassSubCategory().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(securityType3308001)
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
      Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
      
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();  
     
}


function CheckCriterionDataInSecurityGrid(securitySymbole,securityType,securityMarket)
{
    Log.Message("-- Valider symbole "+securitySymbole+" : type = "+securityType+", valider que Bourse = "+securityMarket)
    Search_SecurityBySymbol(securitySymbole);
    aqObject.CheckProperty(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbole,10).DataContext.DataItem, "Symbol", cmpEqual, securitySymbole);
    aqObject.CheckProperty(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbole,10).DataContext.DataItem,"MatchesCriterion", cmpEqual,true)
    aqObject.CheckProperty(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbole,10).DataContext.DataItem,"Type", cmpContains, securityType)
    aqObject.CheckProperty(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbole,10).DataContext.DataItem,"MarketName", cmpContains, securityMarket)
    
}

/*Parcours toute la grille et valide que tous les titres affichés respectent le critère :
  vérife pour chaque type de titre est -ce qu'il avait la bonne bourse
  *****Pas utilisé suite à des problèmes de BD remplacé par une fonction qui cible qq titres */
function CheckAllCriterionDataInSecurityGrid(securityType3308000, securityType3308001, NAVexMarket, PTFMarket)
{
    //Tri par titres
    Get_SecurityGrid_ChSecurity().Click();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]);
    //Commencer le parcours de la grille
    var isEndOfGriReached = false;
    Get_SecurityGrid().Click(Get_SecurityGrid().Width - 10, 27);
    var lastRowSecurityBeforeScroll = "";
    
    while (!isEndOfGriReached){        
        securitiesPageCount = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        Log.Message(securitiesPageCount)       
        
        var i = 0;        
        while(i < securitiesPageCount){  
            //Pour enlever les rédondances           
            var verif = aqString.Compare(VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_SecuFirm()), lastRowSecurityBeforeScroll, false) 
            verif = (verif == -1 || verif == 0) ? false : true;          
            while(!verif){
                i++; 
                verif = aqString.Compare(VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_SecuFirm()), lastRowSecurityBeforeScroll, false) 
                verif = (verif == -1 || verif == 0) ? false : true;
            }
            //pts des vérification
            aqObject.CheckProperty(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"MatchesCriterion", cmpEqual,true)
            var securityType= VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Type())
            switch (securityType)
            {
               case securityType3308000 : 
                   Log.Message("Security value : "+VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_SecuFirm()))
                   aqObject.CheckProperty(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"MarketName", cmpContains, NAVexMarket)
                   break;
               case securityType3308001 : 
                   Log.Message("Security value : "+VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_SecuFirm()))
                   aqObject.CheckProperty(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"MarketName", cmpContains, PTFMarket)                        
                   break;                       
               default  : Log.Message(securityType+" is invalid Security Type.");
            }
            i++;          
        }
        
        lastRowSecurityBeforeScroll = VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i-1).DataItem.get_SecuFirm());        
        var firstRowSecurityBeforeScroll = VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_SecuFirm());
        
        Get_SecurityGrid().Click(Get_SecurityGrid().Width - 10, Get_SecurityGrid().Height - 40);        
        var firstRowSecuritytAfterScroll = VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_SecuFirm());
        
        if (firstRowSecurityBeforeScroll == firstRowSecuritytAfterScroll){
            Get_SecurityGrid().Click(Get_SecurityGrid().Width - 10, Get_SecurityGrid().Height - 40);            
            var firstRowSecuritytAfterScroll = VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_SecuFirm());
        }
                
        isEndOfGriReached = (firstRowSecurityBeforeScroll == firstRowSecuritytAfterScroll);
    }    
}



function Test(){

}

