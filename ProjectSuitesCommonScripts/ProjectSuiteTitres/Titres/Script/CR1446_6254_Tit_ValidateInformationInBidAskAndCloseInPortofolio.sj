//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Description :Valider les infos Acheteur, vendeur et Clôture dans le module portefeuille.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6254
    Version de scriptage : 	ref90-10-12--V9-croesus-co7x-1_5_565
    Analyste d'assurance qualité :carolet
    Analyste d'automatisation : Asma Alaoui
*/

function CR1446_6254_Tit_ValidateInformationInBidAskAndCloseInPortofolio()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6254", "CR1446_6254_Tit_ValidateInformationInBidAskAndCloseInPortofolio()");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "accountN", language+client);
        var SecuFirme = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "SecuFirme", language+client);
        var symbole = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "Symbole", language+client);
        var valeur = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "valeur", language+client);
        var marketValue = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "marketValue", language+client);
        var jour = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "jour", language+client);
        var description = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "description", language+client);
        var valeurMarche = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "valeurMarche", language+client); 
        var prixMarche = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "prixMarche", language+client); 
        var compteHeaderPortfolio = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "compteHeaderPortfolio", language+client); 
        var annee = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "annee", language+client);
        var mois = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "mois", language+client);
        var BIE = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "BIE", language+client);  
        
        // Se connecter avec KEYNEJ et Accès au module Comptes
        Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        //chercher le compte "800057-RE" et Mailler vers le module portefeuille
        SelectAccounts(accountNo);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click(); 
        
        //Vérifier que le compte a été maillé
        var compt = Get_Portfolio_Tab(1).Header.OleValue;
        if (compt == compteHeaderPortfolio)
            Log.Checkpoint("Le compte 800057-RE est maillé vers le module portefeuille");
        else
            Log.Error("le compte n'est pas maillé vers portefeuille.");
        
        //chercher le titre 075235 et faire validation pour le symbole BIE et le titre 075235
        Delay(5000);
        Search_Position(symbole);
        Get_Portfolio_AssetClassesGrid().Find("Value", symbole, 10).Click();
        
        //validation pour le symbole BIE et le titre 075235
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().FindChild("Value", symbole, 10), "Exists", cmpEqual, true);           
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().FindChild("Value", symbole, 10).DataContext.DataItem, "SecuFirm", cmpEqual, SecuFirme);
        
        //Valider pour les valeurs de "Prix au marché" et "Valeur de marché"  sont non déterminés
        var gridRowObject = GetGridCellRowDataRecordPresenterObject(Get_Portfolio_PositionsGrid().FindChild("Value", BIE, 10));
        
        var prix_Marche = gridRowObject.FindChild("Uid", "MarketPrice", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", 1]).DisplayText;
        CheckEquals(prix_Marche, valeur, "Market Price");
        
        valeur_Marche = gridRowObject.FindChild("Uid", "MarketValue", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
        CheckEquals(valeur_Marche, valeur, "Market Value");
        
        //aller sur info
        Get_PortfolioBar_BtnInfo().Click();
      
        //valider dans la section "Information sur la position" les valeurs de "Coût" et "Valeur" sont non déterminés
        aqObject.CompareProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost().Text,cmpEqual, valeur, true)
        aqObject.CompareProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue().Text,cmpEqual, valeur, true)
        Get_WinPositionInfo_BtnCancel().Click();
      
        //Cliquer sur le bouton Sommation
        Get_Toolbar_BtnSum().Click();
      
        //Valider la valeur au marché égale à 0.00 
        aqObject.CompareProperty(Get_WinPortfolioSum_GrpCurrency_TxtMarketValue().Text, cmpEqual, marketValue, true)
        Get_WinPortfolioSum_BtnClose().Click();
        
        //Enlever la sélection
        Get_PortfolioPlugin().Find("Value",symbole,10).Click(-1, -1, skCtrl);
        
        //Cliquer sur "Par classe d'actifs"
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
        
        //exploser la classe Actions candadiennes avec le +
        var gridRowObject = GetGridCellRowDataRecordPresenterObject(Get_Portfolio_AssetClassesGrid().Find("Value", description , 10));
        gridRowObject.set_IsExpanded(true);
        
        //sur le titre BIE valider les valeurs "Prix au marché" et "Valeur au marché " à non déterminés
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid_DgvCanadianEquity().FindChild("Value", symbole, 10),"Exists", cmpEqual, true);
        
        var gridRowObject = GetGridCellRowDataRecordPresenterObject(Get_Portfolio_AssetClassesGrid_DgvCanadianEquity().FindChild("Value", symbole, 10));
        
        market_Price = gridRowObject.FindChild("Uid", "MarketPrice", 10).WPFObject("XamTextEditor", "", 1).DisplayText;
        CheckEquals(market_Price, valeur, "Market Price");
        
        market_Value = gridRowObject.FindChild("Uid", "MarketValue", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
        CheckEquals(market_Value, valeur, "Market Value");
        
        //Cliquer sur "Par classe d'actifs"
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click(); 
      
        //changer la date sur le calendrier à 2010/01/22
        var width = Get_PortfolioGrid_BarToolBarTray_dtpDate().Width;
        var height = Get_PortfolioGrid_BarToolBarTray_dtpDate().Height;
        Get_PortfolioGrid_BarToolBarTray_dtpDate().Click(width-15, height/2);

        Get_Calendar_LstDays_Item(jour).Click();
        Get_Calendar_LstYears_Item(annee).Click();
        Get_Calendar_LstMonths_Item(mois).Click();
        Get_Calendar_BtnOK().Click();
      
        //chercher le symbole BIE et valider les valeur 0.000 prix du marché et valeur de marché 1.06
        Delay(5000);
        Search_Position(symbole);
        if (Get_Portfolio_AssetClassesGrid().FindChild("Value", symbole, 10).Exists && Get_Portfolio_AssetClassesGrid().FindChild("Value", symbole, 10).VisibleOnScreen){
            var gridRowObject = GetGridCellRowDataRecordPresenterObject(Get_Portfolio_AssetClassesGrid().FindChild("Value", BIE, 10));
            
            mP = gridRowObject.FindChild("Uid", "MarketPrice", 10).WPFObject("XamTextEditor", "", 1).DisplayText;
            CheckEquals(mP, prixMarche, "Market Price");  
     
            mV = gridRowObject.FindChild("Uid", "MarketValue", 10).WPFObject("XamNumericEditor", "", 1).DisplayText;
            CheckEquals(mV, valeurMarche, "Market Value");
        }
        else {
            Log.Error( "Le symbole " + BIE + " n'existe pas");
        }
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}



function GetGridCellRowDataRecordPresenterObject(gridCellComponentObject)
{
    if (!gridCellComponentObject.Exists)
        Log.Error("Le composant gridCellComponentObject n'existe pas.");
    else {
        var maxNbOfParents = 10;
        var componentParentObject = gridCellComponentObject;
        for (var j = 1 ; j <= maxNbOfParents; j++){
            var componentParentObject = componentParentObject.Parent;
            if (componentParentObject.ClrClassName == "DataRecordPresenter")
                return componentParentObject;
        }
        
        Log.Error("Aucun objet parent DataRecordPresenter du composant n'a été trouvé, nombre maximal de parents = " + maxNbOfParents);
    }
    
    return Utils.CreateStubObject();
}
