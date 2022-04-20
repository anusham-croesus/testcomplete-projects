//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Valider l'anomalie 2
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6283
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-4
*/

function CR2083_6283_Anomaly2_Validation()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6283","Cas de test TestLink : Croes-6283") 
                               
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "Model_6283", language+client);
         var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
         var relName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "RelName_6283", language+client);         
         var account800200FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "Account800200FS", language+client);
         var conflictMessageP1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "ConflictMessageP1_6283", language+client);
         var conflictMessageP2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "ConflictMessageP2_6283", language+client);
                
        //Login
        Log.Message("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 15000);        
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks pour enlever les filtres s'ils existent") //Enlever les filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071", true]);
        
        Log.Message("Création de la relation "+relName+" cp ="+codeCP);
        CreateRelationship(relName, codeCP)
        var relNo = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relName, 10).DataContext.DataItem.LinkNumber.OleValue;
        
        //associer le compte 800200-FS à la relation  
        Log.Message("Associer le compte "+account800200FS+" à la relation "+relName);
        JoinAccountToRelationship(account800200FS,relName); 
        
        Log.Message("Création de modele "+modelName+" cp ="+codeCP);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        Create_Model(modelName,"",codeCP);
        
        Log.Message("Associer la raltion "+relName+" au modèle "+modelName);
        AssociateRelationshipWithModel(modelName,relNo)
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
        
        //Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.
        Log.Message("--- Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.")
        if(Get_WinRebalance_TabParameters_ChkValidateTargetRange().Exists)
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().Exists)
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkApplyAccountFees().Exists)
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);       
       
        Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")
        //cliquez sur next pour allez a etape 2 
        Get_WinRebalance_BtnNext().Click();
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
        Get_WinRebalance_BtnNext().Click();      

        //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'         
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists)
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();        
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
        
        Log.Message("Etape 4 portefeuille projeté - Valider message")            
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,conflictMessageP1+"\r\n"+conflictMessageP2)
        
        
        Log.Warning("Dans la section de gauche sous la colonne Mess... porter le curseur dans  sur le petit carré jaune. Valider que info bulle = "+conflictMessageP1,"[Validation de l'info bulle ne peux pas être automatisée] -- Voir capture d'écran pour le valider")
        var index = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",relName,10).dataContext.Index;
        var msgCell = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)
        msgCell.HoverMouse(msgCell.Width/2,msgCell.Height/2)
        Log.Picture(Get_WinRebalance(), "Valider que info bulle = "+conflictMessageP1, "ToolTip ScreenShot", pmHighest);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",relName,10).dataContext.dataItem ,"RebalanceMessage",cmpEqual,conflictMessageP1)
        
        
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.Message("************************************************* CLEANUP *************************************************")
        /*RestoreData(modelName,account800200FS,relName);
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        
    }
    finally {
  		 //Fermer le processus Croesus
        Terminate_CroesusProcess();        
        Log.Message("************************************************* CLEANUP *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();        
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000); 
        Get_MainWindow().Maximize();
        RestoreData(modelName,account800200FS,relName);
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();        
        Runner.Stop(true)
    }
}


function RestoreData(modelName,accountNo,relName){      
    Log.Message("Supprimer la relation "+relName+" de Modele "+modelName);
    RemoveAccountFromModel(relName,modelName);
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
        
    Log.Message("Supprimer le modele "+modelName); 
    DeleteModelByName(modelName); 
     
    DeleteRelationship(relName); 
}
