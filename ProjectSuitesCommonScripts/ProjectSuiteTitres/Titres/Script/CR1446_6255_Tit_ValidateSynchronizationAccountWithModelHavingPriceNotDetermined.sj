//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/**
    Description :Valider la synchronisation d'un compte avec un modèle qui a un titre prix n/dét..
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6255
    Version de scriptage : 	ref90-10-12--V9-croesus-co7x-1_5_565
    Analyste d'assurance qualité :carolet
    Analyste d'automatisation : Asma Alaoui
*/

function CR1446_6255_Tit_ValidateSynchronizationAccountWithModelHavingPriceNotDetermined()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6255", "CR1446_6255_Tit_ValidateSynchronizationAccountWithModelHavingPriceNotDetermined()");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var nameUsed=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "nameUsed", language+client);
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "codeCP", language+client);
        var modelHeaderPortfolio=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "modelHeaderPortfolio", language+client);
        var symbole=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "symbole", language+client);
        var valeurCible=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "valeurCible", language+client);
        var symboleNA=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "symbole1", language+client);
        var valeurCibleNA=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "valeurCible1", language+client);
        var bank=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "bank", language+client);
        var accountN=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "accountN", language+client);   
        var messageConfirmation1=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "messageConfirmation1", language+client); 
        var messageConfirmation2=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "messageConfirmation2", language+client);  
        var messageReequib=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "messageReequib", language+client); 
        var valeur=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "valeur", language+client);
        var messageReequib2Step5=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1446", "messageReequib2Step5", language+client);
        
        // Se connecter avec KEYNEJ
        Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language); 
        
        // I)Accès au module Modèles 
        Get_ModulesBar_BtnModels().Click();
        
        //Ajouter un modèle et décocher la case "Actif"
        Get_Toolbar_BtnAdd().Click();
        Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameUsed);
        Get_WinModelInfo_GrpModel_CmbIACode().Click();
        Get_WinModelInfo_GrpModel_CmbIACode().Keys(codeCP);
        Get_WinModelInfo_GrpModel_ChkActive().Click();
        Get_WinModelInfo_BtnOK().Click();
        if (Get_ModelsGrid().FindChild("Value", nameUsed, 10).Exists){
            Log.Checkpoint("Le Modèle " + nameUsed + " est créé.");
        }
        else
            Log.Error("Le modèle n'a pas été créé.");
       
        //II) Mailler vers le module portefeuille
        var Nmodel = Get_ModelsGrid().FindChild("Value", nameUsed, 10).DataContext.DataItem.AccountNumber.OleValue    
        Search_Model(Nmodel)
        Drag(Get_ModelsGrid().Find("Value",nameUsed ,10), Get_ModulesBar_BtnPortfolio());
    
        //Vérifier que le compte a été maillé      
        var model = Get_Portfolio_Tab(1).Header.OleValue;
        Log.Message(model);
        if (modelHeaderPortfolio + " " + Nmodel + " " + nameUsed == model)
            Log.Checkpoint("Le modèle " + nameUsed + " est maillé vers le module portefeuille");
        else
            Log.Error("le modèle n'est pas maillé vers portefeuille.")  
      
        //Ajouter une position
        Get_Toolbar_BtnAdd().Click();
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(".")
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().SetText(symbole);
        Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
        if (client == "CIBC")
        Aliases.CroesusApp.subMenus.FindChild("Value", symbole,10).DblClick();
        Get_WinAddPositionSubmodel_TxtValuePercent().set_Text(valeurCible);
        Get_WinAddPositionSubmodel_TxtValuePercent().Click();
        aqObject.CheckProperty(Get_WinAddPositionSubmodel_BtnOK(), "IsEnabled", cmpEqual, true);
        Get_WinAddPositionSubmodel_BtnOK().Click();
      
        //Ajouter une autre position
        Get_Toolbar_BtnAdd().Click();
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(".")
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().SetText(symboleNA);
        Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
        Get_SubMenus().Find("Text", bank, 10).DblClick();      
        Get_WinAddPositionSubmodel_TxtValuePercent().set_Text(valeurCibleNA);
        Get_WinAddPositionSubmodel_TxtValuePercent().Click();
        aqObject.CheckProperty(Get_WinAddPositionSubmodel_BtnOK(), "IsEnabled", cmpEqual, true);
        Get_WinAddPositionSubmodel_BtnOK().Click();
      
        //Sauvgarder
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        //III)valider la valeur Prix au marche n/dét pour le symbole BIE 
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().FindChild("Value", symbole, 10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().FindChild("Value", symbole, 10),"VisibleOnScreen", cmpEqual, true);
     
        var indexSymbol= Get_Portfolio_AssetClassesGrid().FindChild("Value", symbole, 10).Record.Index;
        Log.Message(indexSymbol);      
        var indexMp = Get_Portfolio_AssetClassesGrid().FindChild("DisplayText", valeur, 10).DataContext.Cells.Record.DataItemIndex;
        Log.Message(indexMp);
        if (indexSymbol == indexMp){
            mP = Get_Portfolio_AssetClassesGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indexMp + 1], 10).FindChild("Uid", "MarketPrice", 10).WPFObject("XamTextEditor", "", 1).DisplayText;
            CheckEquals(mP, valeur, "Market Price");
        }
        else
            Log.Error("la valeur du prix marché ou le symbole sont erronés")
     
        //IV) mailler une position vers modèle
        Search_Position(symbole);
        Drag(Get_Portfolio_PositionsGrid().Find("Value",symbole ,10), Get_ModulesBar_BtnModels());
     
        //sélectionner le modèle CROES6255
        aqObject.CheckProperty(Get_ModelsGrid().Find("Value","CROES6255" ,10),"Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_ModelsGrid().Find("Value","CROES6255" ,10),"VisibleOnScreen", cmpEqual, true);
        SearchModelByName(nameUsed);
    
        //aller sur Portfeuille associés et associer le compte 800057-RE 
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
        Get_WinPickerWindow_DgvElements().Keys("0");
        Get_WinQuickSearch_TxtSearch().SetText(accountN);
        Get_WinQuickSearch_RdoAccountNo().Click();
        aqObject.CheckProperty(Get_WinQuickSearch_RdoAccountNo(), "IsChecked", cmpEqual, true);
        Get_WinQuickSearch_BtnOK().Click(); 
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        //valider que le compte 800057-RE est associé au modèle
        resultAccountSearch =  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", accountN, 10).DataContext.DataItem.AccountNumber.OleValue;
        if (resultAccountSearch.Exists == false){
            Log.Error("le compte " + accountN + "  n'est pas associé au modèle "+nameUsed);
            return;
        }
     
        //V) sélectionner le modèle CROES6255
        SearchModelByName(nameUsed);
        //Cliquer sur le bouton Info et cocher "Actif" dans la fenêtre Info modèle
        Get_ModelsBar_BtnInfo().Click()
        Get_WinModelInfo_GrpModel_ChkActive().Click();
        aqObject.CheckProperty(Get_WinModelInfo_GrpModel_ChkActive(), "IsChecked", cmpEqual, true);
        Get_WinModelInfo_BtnOK().Click();
        //Cliquer sur Réequélibrer et aller sur l'étape 4
        Get_Toolbar_BtnRebalance().Click();  
        Get_WinRebalance().Parent.Maximize();
        Get_WinRebalance_BtnNext().Click(); //Rebalancing step 2
        Get_WinRebalance_BtnNext().Click(); //Rebalancing step 3
        Get_WinRebalance_BtnNext().Click(); //Rebalancing step 4
      
        aqObject.CheckProperty(Get_WinRebalance_LblStep4Number().Text, "OleValue", cmpEqual, "4");
        //valider les messages "Les postions suivantes du modèle n'ont aucune valeur marchande: BIE" et " Les tolérances définies pour le solde de ce compte ne sont pas repectées." dans la section message de rééquilibrage.
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        var messageReequibStep5=messageReequib+"\n"+messageReequib2Step5
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text", cmpEqual, messageReequibStep5)
    
        //fermer la fenêtre de rééquilibrage
        Get_WinRebalance_BtnClose().Click();
    
        //valider le message "Le rééquilibrage en cours sera annulé si vous continuez.  Voulez-vous continuer"
        aqObject.CheckProperty(Get_DlgConfirmation_LblMessage2(),"Text", cmpEqual, messageConfirmation1+"\r\n"+ messageConfirmation2)
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
    
        //Supprimer le compte associé et le modèle
        RemoveAccountFromModel(accountN, nameUsed);
        DeleteModelByName(nameUsed);
        
        //Vérifier la suppression du modele CROES6255
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Delay(5000);
        SearchModelByName(nameUsed);
        if (Get_ModelsGrid().Find("Value", Nmodel, 10).Exists)
            Log.Error("Le modèle n’a pas été supprimé");       
        else
            Log.Checkpoint("Le modèle a été supprimé");
    } 
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus      
    }
}
