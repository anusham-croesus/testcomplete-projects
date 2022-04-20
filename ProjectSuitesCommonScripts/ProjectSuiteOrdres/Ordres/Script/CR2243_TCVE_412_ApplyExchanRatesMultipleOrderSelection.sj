//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**

                  
                
        
    storie:TCVE-403.
    lien  du cas de test sur jira: https://jira.croesus.com/browse/TCVE-412
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation :    sana Ayaz
    
    Version de scriptage:	90.15.2020.3-4
*/

function CR2243_TCVE_412_ApplyExchanRatesMultipleOrderSelection()
{
    try {
    
        var  userNameKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var  passwordKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var  textTauxTCVE412             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textTauxTCVE412", language+client);
        var  symbolMAV203TCVE412         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step6", language+client);
        var  symbolVIGTCVE412            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step3", language+client);
        var symbolBuyTCVE403Step2        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step2", language+client);
        var messageInformationTCVE412    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "messageInformationTCVE412", language+client);
        var symbol_TCVE412Step3          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbol_TCVE412Step3", language+client);
        var textOrigineDuTaux            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textOrigineDuTaux", language+client);
        var textTauxNegocie              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textTauxNegocie", language+client);
        var textTauxDeChange             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textTauxDeChange", language+client);
        var textTotalAConvertir          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textTotalAConvertir", language+client);
        var textTotalAConvertirCustom    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textTotalAConvertirCustom", language+client);
        var textNoInterne                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textNoInterne", language+client);
        var Lbl$CADUSD                   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "Lbl$CADUSD", language+client);
        var TxtUSDToConvertToCAD       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "TxtUSDToConvertToCAD", language+client);
        var textSaisiTauxChange          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiTauxChange", language+client);
        var textSaisiNoInterne           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiNoInterne", language+client);
        var message1InformationTCVE412Etap5   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "message1InformationTCVE412Etap5", language+client);
        var message2InformationTCVE412Etap5   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "message2InformationTCVE412Etap5", language+client);
        var messageCompletInformationTCVE412Etap5=message1InformationTCVE412Etap5+"\r\n"+message2InformationTCVE412Etap5
        
        var tauxGrileOrdreEtap5          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "tauxGrileOrdreEtap5", language+client);
        var symbolBuyTCVE403Step4        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step4", language+client);
        var symbolBuyTCVE403Step5        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step5", language+client);
        
        
        var textSaisiTauxChangeEtap6        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiTauxChangeEtap6", language+client);
        var textSaisiNoInterneEtap6         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textSaisiNoInterneEtap6", language+client);
        var tauxGrileOrdreSymbolStep4Etap6  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "tauxGrileOrdreSymbolStep4Etap6", language+client);
        var tauxGrileOrdreSymbolStep5Etap6  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "tauxGrileOrdreSymbolStep5Etap6", language+client);
        var securityTCVE403Step4            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "securityTCVE403Step4", language+client);
//        var symbol_TCVE412Step3             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbol_TCVE412Step3", language+client);
        var textNegotiatedRate              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textNegotiatedRate", language+client);
        var textDailyRate                   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textDailyRate", language+client);
        var textDailyRateWash               = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textDailyRateWash", language+client);
        var textNegotiatedRateWash          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textNegotiatedRateWash", language+client);
        var sc7_exchangeRateValidation      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "sc7_exchangeRateValidation", language+client);
       
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        //Creation d'ordre 
       Get_ModulesBar_BtnOrders().Click();
        Log.Message("******************L'étape 2 ************************************")
        //Ajout de la colonne taux
       Log.message("Aller dans l'entête et ajouter la colonne taux");   
            if(!Get_OrderGrid_ChRate().Exists){
                Get_OrderGrid_ChAccountName().ClickR();
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                Get_GridHeader_ContextualMenu_AddColumn_Rate().Click();
            }
            // La colonne taux est ajoutée
         Log.Message("La colonne Taux est ajouté");
         aqObject.CheckProperty(Get_OrderGrid_ChRate(), "Content", cmpEqual, textTauxTCVE412); 
         aqObject.CheckProperty(Get_OrderGrid_ChRate(), "IsVisible", cmpEqual, true); 
         /*   Sélectionner deux ordres, avoir la combinaison suivante:
              (Devise_titre1)-(Devise_compte1)
              (Devise_titre2)-(Devise_compte2)

              Scénario_1. Sélectionner deux ordres:
              Symbole: MAV203 (CAD-CAD)
              Symbole: VIG (USD-USD)
              Clic-droit/ Fonctions/ 'Taux de change' n'est pas disponible*/
         Log.Message("******************L'étape 3 ************************************") 
         //  Sélectionner deux ordres:Symbole: MAV203 (CAD-CAD)et Symbole: VIG (USD-USD)
         //Sélectionner le premier ordre symbole: MAV203
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
          Get_OrderGrid().Find("Value",symbol_TCVE412Step3,10).Click();
           //Maintenir la touche CTRL enfoncée
          Sys.Desktop.KeyDown(0x11);
           
          //Sélectionner le 2 ème Symbole: VIG 
          Get_OrderGrid().Find("Value",symbolVIGTCVE412,10).Click();
          //Relâcher la touche CTRL enfoncée
          Sys.Desktop.KeyUp(0x11);
          Get_OrderGrid().Find("Value",symbolVIGTCVE412,10).ClickR()
          Get_OrderGrid_ContextualMenu_Functions().Click();
          //les points de vérifications:Le champ Taux de change est grisé
          aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "VisibleOnScreen", cmpEqual, true);
          Log.Message("******************L'étape 4 ************************************") 
          /*      Scénario_2. Sélectionner deux ordres:
                  Symbole: MAV203 (CAD-CAD)
                  Symbole: B55444 (USD-CAD)

                  Clic-droit/ Fonctions/Taux de change est disponible
                  Cliquer sur le taux de change => un message d'information s'affiche/ Ok
                  La nouvelle fenêtre s'affiche/ Valider le contenu de la fenêtre: 'Taux de change'/'Exchange rate'(en, fr): Origine du taux: forcé à Taux négocié /Taux de change: nombre/Total à couvertir:/No interne:champ texte/ 2 btns: Annuler et OK
                  Remplir les champs: Taux de change: par ex: 1.0585 et No interne: abc123/ Ok
                  Note: Le taux de change ne doit pas dépasser l'écart maximal de 10% par rapport au taux de clôture du jour ouvrable présédent (%taux)
          */
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
            Get_OrderGrid().Find("Value",symbol_TCVE412Step3,10).Click();
           //Maintenir la touche CTRL enfoncée
          Sys.Desktop.KeyDown(0x11);
           
          //Sélectionner le 2 ème Symbole: VIG 
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step2,10).Click();
          //Relâcher la touche CTRL enfoncée
          Sys.Desktop.KeyUp(0x11);
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step2,10).ClickR()
          Get_OrderGrid_ContextualMenu_Functions().Click();
          /*      Clic-droit/ Fonctions/Taux de change est disponible
                  Cliquer sur le taux de change => un message d'information s'affiche/ Ok*/
                  
                   //les points de vérifications:Le champ Taux de change est active
          aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "Enabled", cmpEqual, true);
          aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "VisibleOnScreen", cmpEqual, true);
          //Cliquer sur le taux de change
          Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();
          //Les points de vérifications: un message d'information s'affiche
          aqObject.CheckProperty( Get_DlgInformation_LblMessage1(), "VisibleOnScreen", cmpEqual, true);
          aqObject.CheckProperty( Get_DlgInformation_LblMessage1(), "WPFControlText", cmpEqual, messageInformationTCVE412);   
          //Cliquer sur le buton OK   
           Get_DlgInformation_BtnOK().Click();
           //Survol de la fenêtre taux de change    
            //Les points de vérifications 
            Log.Message("Les points de vérification d'origine du taux")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtRateOrigin(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtRateOrigin(), "Text", cmpEqual, textOrigineDuTaux);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtRateOrigin(), "VisibleOnScreen", cmpEqual, true);  
           
            Log.Message("Les points de vérification du combobox d'origine du taux est forcé à taux négocié")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(), "Text", cmpEqual, textTauxNegocie);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(), "VisibleOnScreen", cmpEqual, true);  
            
            Log.Message("Les points de vérification du taux de change:")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRate(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRate(), "Text", cmpEqual, textTauxDeChange);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRate(), "VisibleOnScreen", cmpEqual, true);         
          
            Log.Message("Les points de vérification du taux de change:")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(), "VisibleOnScreen", cmpEqual, true);
            
            //Get_WinExchangeRate_GrpRate_LblCADUSD
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_LblCADUSD(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_LblCADUSD(), "Text", cmpEqual,Lbl$CADUSD);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_LblCADUSD(), "VisibleOnScreen", cmpEqual, true); 
            
            //Les points de vérifications de 
            
            Log.Message("Les points de vérification : Total a convertir")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtTotalToConvert(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtTotalToConvert(), "Text", cmpEqual, textTotalAConvertir);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtTotalToConvert(), "VisibleOnScreen", cmpEqual, true);       
            
            // Get_WinExchangeRate_GrpRate_TxtUSDToConvertToCAD
            Log.Message("Les points de vérification : Total a convertir")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtUSDToConvertToCAD(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtUSDToConvertToCAD(), "Text", cmpEqual,  TxtUSDToConvertToCAD );
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtUSDToConvertToCAD(), "VisibleOnScreen", cmpEqual, true);  
                                  
            

            Log.Message("Les points de vérification :champ text Total a convertir")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomTotalToConvert(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomTotalToConvert(), "Text", cmpEqual, textTotalAConvertirCustom);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomTotalToConvert(), "VisibleOnScreen", cmpEqual, true); 
            
              
            Log.Message("Les points de vérification :No interne: ")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtInternalNumber(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtInternalNumber(), "Text", cmpEqual, textNoInterne);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtInternalNumber(), "VisibleOnScreen", cmpEqual, true); 
            
            Log.Message("Les points de vérification : champ text du No interne: ")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "VisibleOnScreen", cmpEqual, true); 
            
            Log.Message("Les points de vérification du bouton OK")
            aqObject.CheckProperty(Get_WinExchangeRate_BtnOK(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_BtnOK(), "VisibleOnScreen", cmpEqual, true); 
            
            Log.Message("Les points de vérification du bouton Annuler")
            aqObject.CheckProperty(Get_WinExchangeRate_BtnCancel(), "Enabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_BtnCancel(), "VisibleOnScreen", cmpEqual, true); 
            
            Log.Message(" TCVE-1846")
            Log.Message("Valider les options dans le menu contextuel du champ ‘Origine du taux’Valider les options dans le menu contextuel du champ ‘Origine du taux’")
            Log.Message("choisir l'option taux négocié")
             Get_WinExchangeRate_GrpRate_CmbRateOrigin().set_Text(textNegotiatedRate)
            Log.Message("Taux de change et No interne devraient être disponibles")
            
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(), "VisibleOnScreen", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "VisibleOnScreen", cmpEqual, true); 
            Log.Message("Taux de change et No interne ne sont pas grisés")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, true);
            
            Log.Message("choisir l'option Taux quotidien")
            Get_WinExchangeRate_GrpRate_CmbRateOrigin().set_Text(textDailyRate)
             Log.Message("Taux de change et No interne devraient être disponibles")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(), "VisibleOnScreen", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "VisibleOnScreen", cmpEqual, true); 
            Log.Message("Taux de change et No interne sont grisés")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, false);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, false);
            
            
            
            Log.Message("choisir l'option Taux quotidien – net ")
            Get_WinExchangeRate_GrpRate_CmbRateOrigin().set_Text(textDailyRateWash)
            
            Log.Message("Taux de change et No interne devraient être disponibles")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(), "VisibleOnScreen", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "VisibleOnScreen", cmpEqual, true); 
            Log.Message("Taux de change et No interne ne sont pas grisés")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, true);
            
            
            Log.Message("choisir l'option Taux négocié – net ")
            Get_WinExchangeRate_GrpRate_CmbRateOrigin().set_Text(textNegotiatedRateWash)
            
            Log.Message("Taux de change et No interne devraient être disponibles")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(), "VisibleOnScreen", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "VisibleOnScreen", cmpEqual, true); 
            Log.Message("Taux de change et No interne ne sont pas grisés")
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, true);
            aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().DataContext, "CanEditRate", cmpEqual, true);
            
            
            
            
            
             //Remplir les champs: Taux de change: par ex: 1.0585 et No interne: abc123/ Ok
            
            //WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATE",60000);//YR
            AddExchangeRate(textSaisiTauxChange,textSaisiNoInterne)
            
            
            
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TextBlock_cc7c");
//                 Le taux de change est ajouté uniquement pour l'ordre USD_ACCAUNT --> Titre:B55444 (USD-CAD)
         
          SetAutoTimeOut();
              if(!Get_OrderGrid_ChRate().Exists){
                    Get_OrderGrid_ChAccountName().ClickR();
                    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                    Get_GridHeader_ContextualMenu_AddColumn_Rate().Click();
                }
          RestoreAutoTimeOut();
           var tauxSymB55444Step4 = Get_OrderGrid().FindChild("Value", symbolBuyTCVE403Step2, 10).DataContext.DataItem.Rate.OleValue;
           var tauxSymMAV203      = Get_OrderGrid().FindChild("Value", symbol_TCVE412Step3, 10).DataContext.DataItem.Rate;         
          Log.Message("Le taux de change est ajouté uniquement pour l'ordre USD_ACCAUNT --> Titre:B55444 (USD-CAD)")
//         //Les points de vérifications
          CheckEquals(tauxSymB55444Step4,sc7_exchangeRateValidation)
          CheckEquals(tauxSymMAV203,null)  
            
            
            
       
            //WaitObject(Get_WinFXRateConfirmation(),["ClrClassName", "WPFControlOrdinalNo"],["ClrClassName", 1]);
           
            Log.Message("******************L'étape 5 ************************************") 
             /*  Sélectionner de nouvaux les deux ordres (MAV203(CAD,CAD) et B55444(USD-CAD)) / cl. droit Fonctions/ Taux de change/ appliquer un nouvaux taux de change, ajouter un No intern

                Valide le message de confirmation: 'Un taux de change est actuellement appliqué aux ordres sélectionnés. Un taux de (on ajout un nouveau taux, par ex: 1.0099) sera utilisé pour remplacer les taux actuellement appliqués.'
                Appuyer sur le bouton 'Sélectionner tout'--> la case a cocher de l'ordre est coché/ Continuer
                Le Taux de change doit être appliqué uniquement pour l'ordres B55444 (USD-CAD); il doit être affiché dans la colonne Taux*/
                
            //Les points de vérifications
          
             Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
            Get_OrderGrid().Find("Value",symbol_TCVE412Step3,10).Click();
           //Maintenir la touche CTRL enfoncée
           Sys.Desktop.KeyDown(0x11);
           
          //Sélectionner le 2 ème Symbole
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step2,10).Click();
          //Relâcher la touche CTRL enfoncée
          Sys.Desktop.KeyUp(0x11);
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step2,10).ClickR()
          Get_OrderGrid_ContextualMenu_Functions().Click(); 
             //Cliquer sur le taux de change
          Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();
           //Cliquer sur le buton OK   
           Get_DlgInformation_BtnOK().Click();
           // Saisir taux de change te numéro interne
            AddExchangeRate(textSaisiTauxChangeEtap6,textSaisiNoInterneEtap6)
           
            //WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATECONFIRMATION",60000); //YR
            aqObject.CheckProperty( Get_DlgInformation_LblMessageFXRateConfirmation(), "WPFControlText", cmpEqual, messageCompletInformationTCVE412Etap5);
            //Appuyer sur le bouton 'Sélectionner tout'
            
            Get_WinFXRateConfirmation_BtnSelectAll().Click();
            //Les points de vérifications :la case a cocher de l'ordre est coché/
            aqObject.CheckProperty(Get_WinFXRateConfirmation_DgvOrderGrid().Find("Value",symbolBuyTCVE403Step2, 100).DataContext.DataItem,"IsChecked", cmpEqual, true);
            Get_WinFXRateConfirmation_BtnContinue().Click();
            //Les points de vérifications:Le Taux de change doit être appliqué uniquement pour l'ordres B55444 (USD-CAD); il doit être affiché dans la colonne Taux*/
            aqObject.CheckProperty(Get_OrderGrid().Find("Value",symbolBuyTCVE403Step2, 100).DataContext.DataItem,"Rate", cmpEqual,tauxGrileOrdreEtap5 );
          
            
            
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


function AddExchangeRate(exchangeRate,CustomInternalNumber){
  var textNegotiatedRate              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textNegotiatedRate", language+client);
  Get_WinExchangeRate_GrpRate_CmbRateOrigin().set_Text(textNegotiatedRate)
  Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().Keys(exchangeRate);
  Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber().Keys(CustomInternalNumber);
  Delay(100);
  Get_WinExchangeRate_BtnOK().Click();
  //WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TextBlock_cc7c");
  Delay(2000);  
  }
  
  