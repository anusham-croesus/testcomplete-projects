//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2166_Edit_Price_CP_Model


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3537
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_3537_Check_GPColumn_During_PriceModification()
{
    try{       
        Activate_Inactivate_Pref("GP1859", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)   
        RestartServices(vServerModeles);               
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");         
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_3537", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800204JW", language+client);
        var THI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionTHI", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
        var percentTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentTHI_3537", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client); 
        var newPriceTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPriceTHI_3537", language+client);
                
        var realizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGL3237", language+client);
        var realizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGPercent3537", language+client);
        var unrealizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnRealizedGL3537", language+client);
        var unrealizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnRealizedGLPercent3537", language+client);
                                                 
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
         
        //Créer modele et ajouter position Symbole= THI , % Cible= 50%        
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                        
        Create_Model(modelName,modelType)
            
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //Ajouter une position THI   
        AddPosition(THI,percentTHI,typePicker,"") 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(THI);  
        
        //Assigné compte 800204-JW au modele Créé et rééquilibrer
        Get_ModulesBar_BtnModels().Click();
        AssociateAccountWithModel(modelName,account)
        
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();      
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        //Rééquilibrer le modele comme suit : Etape 1 : selon la valeur au marché
        Get_WinRebalance_BtnNext().Click();      
        //3- A l'étape 3 du rééquilibrage ==> Cliquez sur Modifier le prix ==> Modifier le prix de la position THI= 50 
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Click();
        var index = Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",THI,10).dataContext.Index;
        var cellPrice = Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "4"],10);
        cellPrice.Click();
        cellPrice.WPFObject("ContentControl", "", 1).WPFObject("XamNumericEditor", "", 1).Keys(newPriceTHI);
        Get_WinEditPrices_BtnOk().Click();
        Get_WinRebalance_BtnNext().Click();  
        
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        }
           
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();         
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(THI);
        Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();

        //********************* les colonnes G/P réalisé et Non réalisé GP non réalisé = 2 906.75; % GP non réalisé=62.60; GP réalisé= 943.25.; % GP réalisé = 62.60*********  
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",THI,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",THI,10 ).DataContext.DataItem, "MarketPrice", cmpEqual,newPriceTHI);
        
         aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",THI,10 ).DataContext.DataItem, "GainLossRealizedFromOpenOrder", cmpEqual,realizedGL); 
        
        var croesusPercentGainLossRealizedFromOpenOrder =aqString.SubString(Get_WinRebalance_PositionsGrid().Find("Value",THI,10 ).DataContext.DataItem.PercentGainLossRealizedFromOpenOrder,0,5)
        if(croesusPercentGainLossRealizedFromOpenOrder!=null){
          if(croesusPercentGainLossRealizedFromOpenOrder==realizedGLPercent){
            Log.Checkpoint("La valeur est bonne" + realizedGLPercent+" = " +realizedGLPercent)
          }
          else{
            Log.Error("La valeur n'est pas bonne"  + realizedGLPercent+" est diffèrent de" +realizedGLPercent)
          } 
        } 
        else{
            Log.Error("La valeur n'est pas bonne"  + realizedGLPercent+" est diffèrent de" +realizedGLPercent)
        }        
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",THI,10 ).DataContext.DataItem, "GainLossUnrealizedFromOpenOrder", cmpEqual, unrealizedGL);    
             
        var croesusPercentGainLossUnrealizedFromOpenOrder =aqString.SubString(Get_WinRebalance_PositionsGrid().Find("Value",THI,10 ).DataContext.DataItem.PercentGainLossUnrealizedFromOpenOrder,0,5)
        if(croesusPercentGainLossUnrealizedFromOpenOrder!=null){
          if(croesusPercentGainLossRealizedFromOpenOrder==unrealizedGLPercent){
            Log.Checkpoint("La valeur est bonne" + unrealizedGLPercent+" = " +unrealizedGLPercent)
          }
          else{
            Log.Error("La valeur n'est pas bonne"  + unrealizedGLPercent+" est diffèrent de" +unrealizedGLPercent)
          } 
        }
        else{
            Log.Error("La valeur n'est pas bonne"  + unrealizedGLPercent+" est diffèrent de" +unrealizedGLPercent)
        }        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);  
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(account,modelName);    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(account,modelName);
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)
        RestartServices(vServerModeles);
        Runner.Stop(true);
    }
}