//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_279_Rebalance_SubModel()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");         
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client); 
        var subModel=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_271", language+client); 
        var valuePercent=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageOfTotalValueMSFTMin", language+client); 
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800060NA", language+client);
        var sleeveAdhocFor800060NA=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves,"CR1452", "WinEditSleeveTxtSleeveDescription_For800060NA", language+client);
        var adhocSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinEditSleeveTxtSleeveDescription_For800060NA", language+client);
        var message1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_279", language+client); 
        var sleeveDescription=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //Le changement de la BD dans AT
        var SOUSmodel="SOUS_MODELE"
        SearchModelByName(SOUSmodel);
        if(Get_ModelsGrid().Find("Value",SOUSmodel,10).Exists){
          //chainer vers le module Portefeuille
          Drag(Get_ModelsGrid().Find("Value",SOUSmodel,10), Get_ModulesBar_BtnPortfolio()); 
          //Supprimer le sous modèle 
          if(Get_PortfolioPlugin().Find("Value",model,10).Exists){
              Get_PortfolioPlugin().Find("Value",model,10).Click();
              Get_Toolbar_BtnDelete().Click(); 
              //var numberOftries=0;                     
              if(Get_DlgConfirmation().Exists) {
                var width =Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73);
                //Get_DlgConfirmation().Click((width*(1/3)),73);
              }
         var numberOftries=0;  //Si le click n'a pas fonctionné
         while ( numberOftries < 5 && Get_DlgConfirmation().Exists){
            var width =Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73);
            numberOftries++;
         }
              //sauvgarder les modification 
              Get_PortfolioBar_BtnSave().Click();
              Get_WinWhatIfSave_BtnOK().Click();
          }
        } 
        
        Get_ModulesBar_BtnModels().Click();  
        //rendre le modèle inactif
        SearchModelByName(subModel)
        ActivateDeactivateModel(subModel,false)
          
        SearchModelByName(model)
        Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",model,10).Click()
        //Mailler    
        Drag(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
          
        //Ajout d'un sous-modèle
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          Get_DlgConfirmation().Parent.Close();
        } 
        
        AddSubModelToModel(subModel,valuePercent)

        if(Get_PortfolioPlugin().Find("Value",subModel,10).Exists){
          Log.Checkpoint("Le sous modèle a été ajouté")
        } 
        else {
          Log.Error("Le sous modèle n'a pas été ajouté")
        } 
        
        //sauvgarder les modification 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click()

        Get_ModulesBar_BtnAccounts().Click();                      
        Search_Account(account);        
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer tous les segments'.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Validation du message 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, message);
   
        //valider qu'il y a des orders pour Adhoc_For800060NA
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhocFor800060NA,10).Click();             
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpNotEqual, "0");
              
        
        //valider qu'il n'y pas a d'orders pour sleeveCanadianEquity
         Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveDescription,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0"); 
        
        //Le fichier Excel n’a pas fonctionné dans le cas 
        if(client=="RJ"){
           if(language=="french"){ //Le fichier Excel n’a pas fonctionné dans ce cas 
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH CANADIAN EQUI, ~M-00006-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveDescription,10).DataContext.DataItem, "RebalanceMessage", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH CANADIAN EQUI, ~M-00006-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
            }
            else{
               aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,  "One or more models or sub-models involved in this operation are inactive:\r\nCH CANADIAN EQUI, ~M-00006-0\r\n\r\nIt is therefore impossible to rebalance.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveDescription,10).DataContext.DataItem, "RebalanceMessage", cmpEqual, "One or more models or sub-models involved in this operation are inactive:\r\nCH CANADIAN EQUI, ~M-00006-0\r\n\r\nIt is therefore impossible to rebalance.");
            }
        }else{
            if(language=="french"){ //Le fichier Excel n’a pas fonctionné dans ce cas 
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH CANADIAN EQUI, ~M-00001-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveDescription,10).DataContext.DataItem, "RebalanceMessage", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH CANADIAN EQUI, ~M-00001-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
            }
            else{
               aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,  "One or more models or sub-models involved in this operation are inactive:\r\nCH CANADIAN EQUI, ~M-00001-0\r\n\r\nIt is therefore impossible to rebalance.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveDescription,10).DataContext.DataItem, "RebalanceMessage", cmpEqual, "One or more models or sub-models involved in this operation are inactive:\r\nCH CANADIAN EQUI, ~M-00001-0\r\n\r\nIt is therefore impossible to rebalance.");
            }
        }
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
     
        //Réinitialiser les données 
        RestoreData(subModel,model)               
                    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        //Réinitialiser les données 
        RestoreData(subModel,model)

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function RestoreData(subModel,model)
{
    Get_ModulesBar_BtnModels().Click();
    SearchModelByName(subModel)
      
    //rendre le modèle actif
    Get_ModulesBar_BtnModels().Click();
    ActivateDeactivateModel(subModel,true);
          
    SearchModelByName(model);
    Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",model,10).Click();
    
    //Mailler    
    Drag(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd"); 
    
    //Supprimer le sous modèle 
    Get_PortfolioPlugin().Find("Value",subModel,10).Click();
    Get_Toolbar_BtnDelete().Click();
    
    Get_DlgConfirmation().Parent.Close();           
    var width =Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73); 
    
    //sauvgarder les modification 
    Get_PortfolioBar_BtnSave().Click();
    Get_WinWhatIfSave_BtnOK().Click()
} 
