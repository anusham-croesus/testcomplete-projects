//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**

                  
                
        
    storie:TCVE-403.
    lien  du cas de test sur jira: https://jira.croesus.com/browse/TCVE-414
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation :    sana Ayaz
    
    Version de scriptage:	90.15.2020.3-4
*/

function CR2243_TCVE_414_ContentsOfTheOverwriteWindow()
{
    try {
    
        var  userNameKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var  passwordKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var  symbolBuyTCVE403Step7       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step7", language+client);
        var  textSaisiTauxChangeStep2    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiTauxChangeStep2", language+client);
        var  textSaisiNoInterneStep2     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiNoInterneEtap6", language+client);
        var  msgInformStep2              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "msgInformStep2", language+client);
        var  symbolBuyTCVE403Step4       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step4", language+client);
        var  textSaisiTauxChangeStep3    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiTauxChangeStep3", language+client);
        var  textSaisiNoInterneStep3     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiNoInterneStep3", language+client);
        var  symbolBuyTCVE403Step5       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step5", language+client);
        var  symbolBuyTCVE403Step2       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step2", language+client);
        var  symbolBuyTCVE414Step6       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE414Step6", language+client);
        var  textSaisiTauxChange         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiTauxChange", language+client);
        var  symbolMSFTStep6             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolMSFTStep6", language+client);
        var  tauxGrileOrdreTauxNonValid  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "tauxGrileOrdreTauxNonValid", language+client);
        var  symbolFID224                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolFID224", language+client);
        var  tauxGrileOrdreEtap5         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "tauxGrileOrdreEtap5", language+client);
        var  symbolB01610                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolB01610", language+client);
        var  symbolBuyTCVE403Step6       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step6", language+client);
        var  textSaisiTauxChangeStep7    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiTauxChangeStep7", language+client);
       
        
       
         Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        //Creation d'ordre 
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000); 
        Log.Message("******************L'étape 2 ************************************")
        /*Sélectionner un ordre (CAD-USD)/ clic droit/ Fonctions/ Taux de change/ 	
        Insérer le taux 1,90000/ No interne/ Origine de taux: Taux négocié(par défaut)/ OK/ Un message d'information s'affiche*/
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step7,10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();  
        // Insérer le taux 1,90000/ No interne/ Origine de taux: Taux négocié(par défaut)/ OK
        WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATE"); //YR
        Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().Keys(textSaisiTauxChangeStep2);
        Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber().Keys(textSaisiNoInterneStep2);
        Get_WinExchangeRate_BtnOK().Click();
        //Les points de vérifications
        //msgInformStep2
          aqObject.CheckProperty( Get_DlgInformation_LblMessage1(), "VisibleOnScreen", cmpEqual, true);
          aqObject.CheckProperty( Get_DlgInformation_LblMessage1(), "WPFControlText", cmpEqual, msgInformStep2);
            //Cliquer sur le buton OK   
            SetAutoTimeOut();
             if(Get_DlgInformation_BtnOK().Exists){
                 Get_DlgInformation_BtnOK().Click();
               }
            
           RestoreAutoTimeOut();
           Get_WinExchangeRate_BtnCancel().Click();
           Log.Message("******************L'étape 3 ************************************")
          //Sélectionner l'ordrfe dont le symbole est : 
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step7,10).Click();
          //Relâcher la touche shift enfoncée
           Sys.Desktop.KeyDown(0x10);
          // Clic-droit / Fonctions / Taux de change /Appliquer un nouveau taux de change et numéro interne; Confirmer
         
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step4,10).Click();
          //Relâcher la touche shift enfoncée
          Sys.Desktop.KeyUp(0x10);
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step4,10).ClickR()
          Get_OrderGrid_ContextualMenu_Functions().Click();

          Log.Message("Le champ 'Taux de change...' est grisé")
          aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "Enabled", cmpEqual, false);
          
          Log.Message("******************L'étape 4 ************************************")
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
             Get_OrderGrid().Find("Value",symbolBuyTCVE403Step4,10).Click();
          // la touche CTRL enfoncée
           Sys.Desktop.KeyDown(0x11);
          // Clic-droit / Fonctions / Taux de change /Appliquer un nouveau taux de change et numéro interne; Confirmer
         
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step6,10).Click();
          //Relâcher la touche CTRL enfoncée
          Sys.Desktop.KeyUp(0x11);
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step6,10).ClickR()
          Get_OrderGrid_ContextualMenu_Functions().Click();
          Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click(); 
          Log.Message("Clic sur le bouton ok du message d'information s'il est affiché")
          SetAutoTimeOut();
           if(Get_DlgInformation().Exists){
                 Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
               }
          RestoreAutoTimeOut();

         
          WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATE"); 
          Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().Keys(textSaisiTauxChangeStep3);
          Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber().Keys(textSaisiNoInterneStep3);
          Get_WinExchangeRate_BtnOK().Click();
       
             //Les points de vérifications   
          var existSymbolBNsStep4=Get_WinFXRateConfirmation_DgvOrderGrid().Find("Value",symbolBuyTCVE403Step6,10)
          var nbrElementGrill=Get_WinFXRateConfirmation_DgvOrderGrid().ChildCount
          if(existSymbolBNsStep4.Exists == true && nbrElementGrill == 1)
              
            Log.Checkpoint(" Uniquement l'ordre BNS est affiché dans la sélection")
              
           else   
               Log.Error("C'est pas juste l'ordre BNS qui est affiché seule dans la sélection")
               
       
          Log.Message("******************L'étape 5 ************************************")
         
          
          /*Cliquer Sélectionner tout.*/
          Get_WinFXRateConfirmation_BtnSelectAll().Click();
          /*Les points de vérifications :Tous les ordres sont cochés.*/
          aqObject.CheckProperty(Get_WinFXRateConfirmation_DgvOrderGrid().Find("Value",symbolBuyTCVE403Step6, 100).DataContext.DataItem,"IsChecked", cmpEqual, true);
          Log.Message("******************L'étape 6 ************************************")   
          /*Cliquer Désélectionner tout.*/
          Get_WinFXRateConfirmation_BtnUnselectAll().Click();
          /*Les points de vérifications :Tous les ordres sont décochés.*/
          aqObject.CheckProperty(Get_WinFXRateConfirmation_DgvOrderGrid().Find("Value",symbolBuyTCVE403Step6, 100).DataContext.DataItem,"IsChecked", cmpEqual, false);
        

          Log.Message("******************L'étape 7************************************")  
          
          Log.Message("Sélectionner l'ordre de nouveau ")
//         Get_WinFXRateConfirmation_DgvOrderGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).WPFObject("XamCheckEditor", "", 1).set_IsChecked(true);
          
          Get_WinFXRateConfirmation_BtnSelectAll().Click();
          Log.Message("Cliquer sur le bouton Continuer")
          Get_WinFXRateConfirmation_BtnContinue().Click();

//         Le nouveau taux de change est appliqué pour l'ordre BNS
          Log.Message("Ajouter la colonne taux parmi la liste des colonnes de la grille")
          SetAutoTimeOut();
              if(!Get_OrderGrid_ChRate().Exists){
                    Get_OrderGrid_ChAccountName().ClickR();
                    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                    Get_GridHeader_ContextualMenu_AddColumn_Rate().Click();
                }
          RestoreAutoTimeOut();
           var tauxSymBNSStep7 = Get_OrderGrid().FindChild("Value", symbolBuyTCVE403Step6, 10).DataContext.DataItem.Rate.OleValue;
           var tauxSymAGUStep7 = Get_OrderGrid().FindChild("Value", symbolBuyTCVE403Step4, 10).DataContext.DataItem.Rate.OleValue;
//         //Les points de vérifications
          CheckEquals(tauxSymBNSStep7,textSaisiTauxChangeStep7)
          CheckEquals(tauxSymAGUStep7,textSaisiTauxChangeStep7)





    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
       
        
    }
    finally {
		//Fermer le processus Croesus
    Terminate_CroesusProcess();  
      
    }
}
