//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Auteur :              Sana Ayaz
    Version de scriptage:	90.16.2020.5-28_2020-04-22
    
*/


function Regression_CR1772_TCVE_1210() {
         
          try {
              
                    Log.Link("https://jira.croesus.com/browse/TCVE-1210","Lien du Cas de test");
                    Log.Link("https://jira.croesus.com/browse/TCVE-1278", "Lien de la story"); 
                   
                    
                    var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username"); 
                    var account800255RE   =ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "account800255RE", language+client);
                    var valueTargetPercent=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "valueTargetPercent", language+client);
                    var valueSolde        =ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "valueSolde", language+client);
                    var marketValue  =ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "marketValue", language+client);
                    var valueTargetPercentStep3=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "valueTargetPercentStep3", language+client);
                    var assetClass=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "assetClass", language+client);
                    var sleeveDescription=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "sleeveDescription", language+client);
                    var targetCashPercent=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "targetCashPercent", language+client);
                    var msgConfirmation=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "msgConfirmation", language+client);
                    var sleeveUnallocated=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "sleeveUnallocated", language+client);
                    var marketValueSegmentUnallocatedStep7=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "marketValueSegmentUnallocatedStep7", language+client);
                    var marketValueSegmentTestStep7=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "marketValueSegmentTestStep7", language+client);
                    var valueTargetMarketSegmentUnallocatedStep7=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "valueTargetMarketSegmentUnallocatedStep7", language+client);
                    var valueTargetMarketSegmentTestStep7=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "valueTargetMarketSegmentTestStep7", language+client);
                    var targetCashPercentStep10=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "targetCashPercentStep10", language+client);
                    var msgConfirmationStep11  =ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "msgConfirmationStep11", language+client);
                    var valueTargetMarketSegmentUnallocatedStep12=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "valueTargetMarketSegmentUnallocatedStep12", language+client);
                    var marketValueSegmentUnallocatedStep12=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "marketValueSegmentUnallocatedStep12", language+client);
                    var marketValueSegmentTestStep12=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "marketValueSegmentTestStep12", language+client);
                    var valueTargetMarketSegmentTestStep12=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "valueTargetMarketSegmentTestStep12", language+client);
                    var msgConfirmationStep13=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "msgConfirmationStep13", language+client);
                    var targetCashPercentStep10expected=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1772", "targetCashPercentStep10expected", language+client);
                    
         
                     //*** préconditions ***
                    Log.Message("Les préconditions : activation des préférences")
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_SLEEVE_AUTO_CASH_MANAGEMENT", "YES", vServerAccounts);
                    Activate_Inactivate_Pref(user, "PREF_ENABLE_SLEEVES", "YES", vServerAccounts)
                    Activate_Inactivate_Pref(user, "PREF_SLEEVE_ALLOW_CREATE", "YES", vServerAccounts)
                    Activate_Inactivate_Pref(user, "PREF_SLEEVE_ALLOW_DELETE", "YES", vServerAccounts)
                    Activate_Inactivate_Pref(user, "PREF_SLEEVE_ALLOW_SYNC", "YES", vServerAccounts)
                    Activate_Inactivate_Pref(user, "PREF_SLEEVE_ALLOW_SYNC", "YES", vServerAccounts)
                    Activate_Inactivate_Pref(user, "PREF_SLEEVE_ALLOW_VIEW", "YES", vServerAccounts)
                    RestartServices(vServerAccounts);
                    
                    Log.Message("*********************************************  L'étape 1 ************************************************************");
      
                    Login(vServerAccounts, user ,psw,language);
                    
//                    Log.Message("*********************************************  L'étape 2 ************************************************************");
                    Log.PopLogFolder();
                    logEtape2 = Log.AppendFolder("Étape 2: Vérification de l'affichage de la case a cochée: Gestion automatique des liquidités et des valeurs :% Cible liquidités, solde et valeur de marché");
         
                    Log.Message("Choisir le module compte")
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    Log.Message("Chercher le compte 800255-RE")
                    SearchAccount(account800255RE)
                    Log.Message("Sélectionner le compte 800255-RE")
                    Get_RelationshipsClientsAccountsGrid().Find("Value",account800255RE,10).Click();
                    Log.Message("Mailler le compte 800255-RE vers portefeuille")
                    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800255RE,10), Get_ModulesBar_BtnPortfolio());
                    Log.Message("Cliquer sur le bouton Segments")
                    Get_PortfolioBar_BtnSleeves().Click();
                    Get_WinManagerSleeves().Parent.Maximize();
                                  
                    /*                    La fenêtre Gestionnaire des segments s'ouvre
                    1. La case à cocher Gestion automatique des liquidités est affichée en haut à droite de la fenêtre et est décochée
                    
                    2. Le segment Non attribués affiche:
                    % Cible liquidités=n/d
                    Solde=6 599.67
                    Valeur de marché=332 236.31
                    */                    

                    Get_WinManagerSleeves().Parent.Maximize();
      
                    aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement(), "Visible", cmpEqual, true);
                    aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement(), "IsChecked", cmpEqual, false);   
                    Log.Message("Faire clic right sur la colonne description ensuite choisir configuration par défaut")  
                    Get_WinManagerSleeves_ChSleeveDescription().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();  
                    
                    var displayValueTragetPercent=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "4"], 10).WPFObject("XamNumericEditor", "", 1).DisplayText
                    var displayCashBalance       =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "9"], 10).WPFObject("XamNumericEditor", "", 1).DisplayText
                    var displayMarketValue       =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "10"], 10).WPFObject("XamNumericEditor", "", 1).DisplayText
                    
                    Log.Message("Vérification que la valeur de la colonne  % Cible liquidités est égale a n/d")
                    CheckEquals(displayValueTragetPercent, valueTargetPercent, "La valeur de % Cible liquidités ");
                    Log.Message("Vérification que la valeur du solde est égale 6 599,67")
                    CheckEquals(displayCashBalance, valueSolde, "La valeur de la colonne solde ");
                    Log.Message("Vérification que la valeur de la colonne  valeur de marché est égale 332 236,31")
                    CheckEquals(displayMarketValue, marketValue, "La valeur de la colonne valeur de marché  ");
                    
//                    Log.Message("*********************************************  L'étape 3 ************************************************************");
                    Log.PopLogFolder();
                    logEtape3 = Log.AppendFolder("Étape 3: Vérification que la case a cochée: Gestion automatique des liquidités est côchée et de la valeurs :% Cible liquidités");
         
                    Log.Message("Cocher la case Gestion automatique des liquidités")
                    Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement().set_IsChecked(true);
                    Log.Message("La colonne % Cible liquidités affiche 100")
                    var displayValueTragetPercentStep3=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "8"], 10).WPFObject("XamNumericEditor", "", 1).DisplayText
                    CheckEquals(displayValueTragetPercentStep3, valueTargetPercentStep3, "La valeur de % Cible liquidités ");
                    
//                    Log.Message("*********************************************  L'étape 4 ************************************************************");
                    Log.PopLogFolder();
                    logEtape4 = Log.AppendFolder("Étape 4: Vérification de l'ajout d'un segment");
         
                    Log.Message("Ajout du segment dont la Description est:segment_test et dont la valeur deClasse d'actif:Actions canadiennes et la valeur de liquidité:50")
                    AddSegment(sleeveDescription,assetClass,targetCashPercent)
                    Log.Message("Le segment est ajouté")
                    SetAutoTimeOut();
                     if (Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).Exists){
                         

                              if (Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).VisibleOnScreen)
                                  
                                    Log.Checkpoint("Le segment segment_test est visible")
                                  
                              else  Log.Error("Le segment segment_test n'est pas visible")}
                                   
                      else         Log.Error("Le segment segment_test n'existe pas")             

                         RestoreAutoTimeOut();
                           
                     
                       
                    
//                    Log.Message("*********************************************  L'étape 5 ************************************************************");
                    Log.PopLogFolder();
                    logEtape5 = Log.AppendFolder("Étape 5: Validation du message affiché aprés avoir sauvegarder");
         
                    Log.Message("Cliquer sur le bouton sauvegarder de la fenêtre de gestionnaire des segments")
                    Get_WinManagerSleeves_BtnSave().Click();
                    Log.Message("Validation du message de confirmation affiché")
                    aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "Text", cmpEqual,msgConfirmation );
                    
//                    Log.Message("*********************************************  L'étape 6 ************************************************************");
                    Log.PopLogFolder();
                    logEtape6 = Log.AppendFolder("Étape 6: Fermeture du message de confirmation");
         
                    Log.Message("Cliquer sur OK dans le message de Confirmation ")
                    Get_DlgConfirmation_BtnOk().Click();
                    
//                    Log.Message("*********************************************  L'étape 7 ************************************************************");
                    /*                  Dans Portefeuille, cliquer sur Segments et valider
                    1. que la case à cocher Gestion automatique des liquidités est bien cochée

                    2. le segment est ajouté 

                    3. Les valeurs affichées pour le segment ajouté et Non attribués dans les colonnes % Cible liquidités et Valeur de marché sont les bonnes valeurs
                    */
                    Log.PopLogFolder();
                    logEtape7 = Log.AppendFolder("Étape 7: Vérification de la case a cochée: Gestion automatique des liquidités et des valeurs :% Cible liquidités, solde et valeur de marché");
         
                    Log.Message("Cliquer sur le bouton segment")
                    Get_PortfolioBar_BtnSleeves().Click();
                    Get_WinManagerSleeves().Parent.Maximize();
                    // Les points de vérifications
                    Log.Message("La case à cocher Gestion automatique des liquidités est bien cochée ")     
                    aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement(), "IsChecked", cmpEqual, true); 
                      
                    Log.Message("Vérifier que la valeur de la colonne % Cible liquidités pour le segment Non attribués est égale a 50")
                    var displayTargetCashPercentSleeUnlolocated =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveUnallocated,10).DataContext.DataItem.AutoCashRatio.OleValue
                    CheckEquals(displayTargetCashPercentSleeUnlolocated, valueTargetMarketSegmentUnallocatedStep7, "La valeur de la colonne % Cible liquidités ");
                    
                    Log.Message("Vérifier que la valeur de la colonne valeur de marché pour le segment Non attribués est égale a 176447.09")
                    var displayMarketValueSegmentUnallocatedStep7=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveUnallocated,10).DataContext.DataItem.MarketValue
                    CheckEquals(displayMarketValueSegmentUnallocatedStep7, marketValueSegmentUnallocatedStep7, "valeur de marché");
                    
                  
                    Log.Message("Vérifier que la valeur de la colonne % Cible liquidités pour le segment_test est égale a 50")
                    var displayTargetMarketSegmentTest =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).DataContext.DataItem.AutoCashRatio.OleValue
                    CheckEquals(displayTargetMarketSegmentTest, valueTargetMarketSegmentTestStep7, "La valeur de la colonne % Cible liquidités ");
                    
                    
                    Log.Message("Vérifier que la valeur de la colonne valeur de marché pour le segment_test est égale a 176447.09")
                    var displaymMrketValueSegmentTest=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).DataContext.DataItem.MarketValue
                    CheckEquals(displaymMrketValueSegmentTest, marketValueSegmentTestStep7, "valeur de marché");
                    
                   
//                    Log.Message("*********************************************  L'étape 9 ************************************************************");
                    Log.PopLogFolder();
                    logEtape9 = Log.AppendFolder("Étape 9: Sélectionner segment_test puis cliquer sur Modifier");
         
                    Log.Message("Sélectionner segment_test puis cliquer sur Modifier")
                    Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).Click();
                    Log.Message("Cliquer sur le bouton modifier")
                    Get_WinManagerSleeves_GrpSleeves_BtnEdit().WaitProperty("Enabled", true, 10000);
                    if (Get_WinManagerSleeves_GrpSleeves_BtnEdit().Enabled == false)
                         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
                    Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
                    
//                    Log.Message("*********************************************  L'étape 10 ************************************************************");
                    Log.PopLogFolder();
                    logEtape10 = Log.AppendFolder("Étape 10: Modification du segment_test ");
         
                    Log.Message("Modifier le segment : % Cible liquidités=70");
                    WaitObject(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
                    Get_WinEditSleeve_TxtTargetCashPercent().set_Text(targetCashPercentStep10); 
                    Log.Message("Click sur le bouton OK de la fenêtre modifier un segment")
                    Get_WinEditSleeve_BtOK().Click();
                    Log.Message("Sélectionner le segment test_segment ")
                    Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).Click();
                    Log.Message("Cliquer sur le bouton modifier")
                    Get_WinManagerSleeves_GrpSleeves_BtnEdit().WaitProperty("Enabled", true, 10000);
                    if (Get_WinManagerSleeves_GrpSleeves_BtnEdit().Enabled == false)
                         Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
                    Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
                    Log.Message("Validation de la valeur de % cible liquidités ")
                    aqObject.CheckProperty(Get_WinEditSleeve_TxtTargetCashPercent(), "Text", cmpEqual, targetCashPercentStep10expected);
                    Log.Message("Click sur le bouton OK de la fenêtre modifier un segment")
                    Get_WinEditSleeve_BtOK().Click();
                    
                    
//                    Log.Message("*********************************************  L'étape 11 ************************************************************");
                    
                    Log.PopLogFolder();
                    logEtape11 = Log.AppendFolder("Étape 11: Validtion du message de confirmation aprés avoir sauvegarder");
         
                    Log.Message("Cliquer sur le bouton sauvegarder de la fenêtre de gestionnaire des segments")
                    Get_WinManagerSleeves_BtnSave().Click();
                    Log.Message("Validation du message de confirmation affiché")
                    aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "Text", cmpEqual,msgConfirmationStep11 );
                    Get_DlgConfirmation_BtnOk().Click();
                    
//                    Log.Message("*********************************************  L'étape 12 ************************************************************");
                    Log.PopLogFolder();
                    logEtape12 = Log.AppendFolder("Étape 12: Validation des modifications apportées au segment_test");
         
                    Log.Message("Cliquer sur le bouton segment")
                    Get_PortfolioBar_BtnSleeves().Click();
                    Get_WinManagerSleeves().Parent.Maximize();
                    // Les points de vérifications
                    Log.Message("La case à cocher Gestion automatique des liquidités est bien cochée ")     
                    aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement(), "IsChecked", cmpEqual, true); 
                      
                     Log.Message("Vérifier que la valeur de la colonne % Cible liquidités pour le segment Non attribués est égale a 30")
                    var displayTargetCashPercentSleeUnlolocated =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveUnallocated,10).DataContext.DataItem.AutoCashRatio.OleValue
                    CheckEquals(displayTargetCashPercentSleeUnlolocated, valueTargetMarketSegmentUnallocatedStep12, "La valeur de la colonne % Cible liquidités ");
                    
                    Log.Message("Vérifier que la valeur de la colonne valeur de marché pour le segment Non attribués est égale a 175 127.16")
                    var displayMarketValueSegmentUnallocatedStep12=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveUnallocated,10).DataContext.DataItem.MarketValue
                    CheckEquals(displayMarketValueSegmentUnallocatedStep12, marketValueSegmentUnallocatedStep12, "valeur de marché");
                    
                  
                    Log.Message("Vérifier que la valeur de la colonne % Cible liquidités pour le segment_test est égale a 70")
                    var displayTargetMarketSegmentTest =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).DataContext.DataItem.AutoCashRatio.OleValue
                    CheckEquals(displayTargetMarketSegmentTest, valueTargetMarketSegmentTestStep12, "La valeur de la colonne % Cible liquidités ");
                    
                    
                    Log.Message("Vérifier que la valeur de la colonne valeur de marché pour le segment_test est égale a 157 109.15")
                    var displaymMrketValueSegmentTest=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).DataContext.DataItem.MarketValue
                    CheckEquals(displaymMrketValueSegmentTest, marketValueSegmentTestStep12, "valeur de marché");
                    
//                    Log.Message("*********************************************  L'étape 13 ************************************************************");
                    Log.PopLogFolder();
                    logEtape13 = Log.AppendFolder("Étape 13: Validation du message de confirmation affiché aprés avoir cliquer sur le bouton supprimer du segment");
         
                    Log.Message("Sélectionner le segment test_segment ")
                    Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).Click();
                    Log.Message("Cliquer sur le boton supprimer")
                    Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
                    Log.Message("validation du message de confirmation affiché")
                    aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "Text", cmpEqual,msgConfirmationStep13 );
                     
//                    Log.Message("*********************************************  L'étape 14 ************************************************************");
                    Log.PopLogFolder();
                    logEtape14 = Log.AppendFolder("Étape 14:Cliquer sur OK puis sauvegarder");
         
                    Log.Message("Clic sur le bouton OK")
                    Get_DlgConfirmation_BtnOk().Click();
                    Log.Message("Clic sur le bouton sauvegarder")
                    Get_WinManagerSleeves_BtnSave().Click();
                    
                     
//                    Log.Message("*********************************************  L'étape 15 ************************************************************");
                    Log.PopLogFolder();
                    logEtape15 = Log.AppendFolder("Étape 15:Validation de la suppression de segment_test");
         
                    Log.Message("Cliquer sur le bouton segment")
                    Get_PortfolioBar_BtnSleeves().Click();
                    Get_WinManagerSleeves().Parent.Maximize();
                    Log.Message("Le segment_test n'est pas affiché");
                    SetAutoTimeOut();
                    if (Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).Exists){
                     
                             if (Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",sleeveDescription,10).VisibleOnScreen)
                                    Log.Error("Le segment segment_test est visible ") 
                             else   Log.checkpoint("Le segment segment_test n'est pas visible")  }   
                                  
                    else         
                                    Log.checkpoint("Le segment segment_test n'existe pas")             


                          
                       RestoreAutoTimeOut();
                        // Les points de vérifications
                    Log.Message("La case à cocher Gestion automatique des liquidités est décochée ")     
                    aqObject.CheckProperty(Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement(), "IsChecked", cmpEqual, false); 
                     
                    Log.Message("% Cible liquidité pour le segment Non attribués=n/d");
                    var displayValueTragetPercent=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "4"], 10).WPFObject("XamNumericEditor", "", 1).DisplayText
                    Log.Message("Vérification que la valeur de la colonne  % Cible liquidités est égale a n/d")
                    CheckEquals(displayValueTragetPercent, valueTargetPercent, "La valeur de % Cible liquidités ");

  
                  
         } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 

                    Terminate_CroesusProcess();
                    Terminate_IEProcess(); 
                    Execute_SQLQuery("update b_compte set lock_id = null", vServerAccounts)  
                    
          }
}


function AddSegment(sleeveDescription,assetClass,targetCashPercent){
 Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        Get_WinEditSleeve_TxtSleeveDescription().set_Text(sleeveDescription); 
        Get_WinEditSleeve_CmbAssetClass().set_IsDropDownOpen(true);
        var count=Aliases.CroesusApp.subMenus.DataContext.AssetClasses.Count
        for(var i=1;i<count;i++){
        Log.Message(VarToString(Aliases.CroesusApp.subMenus.DataContext.AssetClasses.Item(i).LongDescription))
          if(VarToString(Aliases.CroesusApp.subMenus.DataContext.AssetClasses.Item(i).LongDescription)==VarToString(assetClass)){
             Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "",i+1).Click();
             break;
           }
        }
           
      Get_WinEditSleeve_TxtTargetCashPercent().set_Text(targetCashPercent); 
      Get_WinEditSleeve_BtOK().Click();
      }