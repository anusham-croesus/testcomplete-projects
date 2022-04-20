//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Orders
    Jira                 :  TCVE-1741
    Description          :  Automatisation des stories ( GDO-2572 et GDO-2691)
    Préconditions        : 
    
    Auteur               :  Sana Ayaz
    Version de scriptage :	90.16.2020.7-33
    date                 :  30-06-2020 
  
    
*/

function GDO_TCVE_1741_ScenarioToCoverStoryGDO2572AndGDO2691()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1741","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/TCVE-1723","Lien du cas de test dans Jira");
    
    
           //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
           var nameCritereStep1      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "nameCritereStep1",language+client);
           var account800302OB       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800302OB", language+client);
           var account800217RE       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800217RE", language+client);
           var account800217SF       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800217SF", language+client);
           var account800228FS       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800228FS", language+client);
           var account800228JW       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800228JW", language+client);
           var valueDecompteStep3    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueDecompteStep3", language+client);
           var sourceTypeStep4       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "sourceTypeStep4", language+client);  
           var valueDecompteStep4    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueDecompteStep4", language+client); 
           var valueDecompteStep6    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueDecompteStep6", language+client); 
           var nameCritereStep9      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "nameCritereStep9", language+client);
           var valueDecompteStep12   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "valueDecompteStep12", language+client);
           var sourceTypeStep13      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "sourceTypeStep13", language+client);
           var transactionVente      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "transactionTCVE1281", language+client);
           var quantityTCVE1741      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTCVE1741", language+client);
           var cmbTransaction        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
           var symbolMSFT            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolMSFT", language+client);
           var quantityStep16        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityStep16", language+client);
           var displayquantityStep16 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "displayquantityStep16", language+client);
           var cmbTransactionStep16  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionStep16", language+client);
           var symbolStep16          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolStep16", language+client);
/************************************Étape 1************************************************************************/     
           /*Aller dans le module Comptes
             Créer puis appliquer un critère de recherche contenant plusieurs comptes*/
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Aller dans le module Comptes,Créer puis appliquer un critère de recherche contenant plusieurs comptes");
          Log.Message("Se connecter à croesus avec KEYNEJ")
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
          Log.Message("Clic sur le module compte")
          Get_ModulesBar_BtnAccounts().Click();
          Log.Message("Créer puis appliquer le critère la liste de comptes ayant Devise égal à USD")
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().Keys(nameCritereStep1);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCurrency().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemUSD().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
          Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 15000);
          
/************************************Étape 2************************************************************************/     
           //Désactiver, sans supprimer le critère
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Désactiver, sans supprimer le critère");
          Log.Message("Récupérer le nombre de comptes qui respecte le critère de recherche")
          var displayNbrAccountCritRecher =aqConvert.StrToInt(Get_MainWindow_StatusBar_NbOfcheckedElements().get_Text())
          Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().Click();
       
/************************************Étape 3************************************************************************/     
           //Sélectionner 5 comptes(les comptes devrait avoir une valeur total>0) puis dans la barre de menu cliquer sur le bouton Bloc-Swich 
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Sélectionner 5 comptes(les comptes devrait avoir une valeur total>0) puis dans la barre de menu cliquer sur le bouton Bloc-Swich ");
          //Sélectionner les comptes 800302-OB,800217-RE,800217-SF,800228-FS et 800228-JW
          Log.Message("Sélectionner les comptes: "+account800302OB+", "+account800217RE+", "+account800217SF+" ,"+account800228FS+" ,"+account800228JW);
          var arrayOfAccountsNo= new Array(account800302OB,account800217RE,account800217SF,account800228FS,account800228JW)
          SelectAccountsWithoutRemoveCheckMarks(arrayOfAccountsNo)     
          Log.Message("Dans la barre de menu cliquer sur le bouton Bloc-Swich")
          Get_Toolbar_BtnSwitchBlock().Click();
          Log.Message("Le décompte égal  a 5 élements");
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, valueDecompteStep3);

/************************************Étape 4************************************************************************/     
           //Changer la Source à Liste courante (Crochets)
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Changer la Source à Liste courante (Crochets)");
          
          //Changer la Source à Liste courante (Crochets)
          Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
          Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceTypeStep4],10).Click();  
          
          Log.Message("Le décompte devient 96 élements");
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, displayNbrAccountCritRecher+valueDecompteStep4);//valueDecompteStep4
          
/************************************Étape 5************************************************************************/     
           //Fermer la fênetre du swich
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: Fermer la fenêtre du swich");
          Get_WinSwitchBlock_BtnCancel().Click(); 

/************************************Étape 6************************************************************************/     
           /*"Mailler les 5 comptes sélectionnés à étape 3 vers le module Portefeuille
              Sélectionner des positions dans 3 comptes différents
              Cliquer sur le bouton Bloc-Swich"*/ 
          Log.PopLogFolder();
          logEtape6 = Log.AppendFolder("Étape 6: Fermer la fenêtre du swich");
          //Mailler ver le module Portefeuille
          Log.Message("Mailler ver le module Portefeuille")
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().Click();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
          Log.Message("Sélectionner des positions dans 3 comptes différents")
         
           var lines = Get_Grid_VisibleLines(Get_Portfolio_AssetClassesGrid());
           var arrayOfAccountsNo= new Array(account800217RE,account800228FS,account800228JW)

          Sys.Desktop.KeyDown(0x11);
          var j=0;
          Log.Message("Sélectionner la position dont le compte est :  " +arrayOfAccountsNo[0]) 
             var lines = Get_Grid_VisibleLines(Get_Portfolio_AssetClassesGrid());
           for (n=0 ; n< lines.length; n++){
              
               if(lines[n].dataContext.dataItem.AccountNumber.OleValue == arrayOfAccountsNo[0] || lines[n].dataContext.dataItem.AccountNumber.OleValue == arrayOfAccountsNo[1] || lines[n].dataContext.dataItem.AccountNumber.OleValue == arrayOfAccountsNo[2]  ){
                  if(j==3  ){
                 break;
                  } 
                      
                      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
//                      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
               j=j+1;
                     
                 }
              
             } 
          Sys.Desktop.KeyUp(0x11);
          Log.Message("Cliquer sur le bouton Bloc-Swich")
          Get_Toolbar_BtnSwitchBlock().Click();
          Log.Message("Le décompte égal 3 comptes")
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, valueDecompteStep6);
/************************************Étape 7************************************************************************/     
           /*Changer la Source à Liste courante (Crochets)*/ 
          Log.PopLogFolder();
          logEtape7 = Log.AppendFolder("Étape 7: Changer la Source à Liste courante (Crochets)");
         //Le champ Source est grisé. La modification est impossible
         aqObject.CheckProperty(Get_WinSwitchBlock_GrpParameters_CmbSources(), "IsEnabled", cmpEqual, false);
         
/************************************Étape 8************************************************************************/     
           /* Fermer la fenêtre du Swich puis aller dans le module Comptes*/ 
          Log.PopLogFolder();
          logEtape8 = Log.AppendFolder("Étape 8: Fermer la fenêtre du Swich puis aller dans le module Comptes");
          Log.Message("Fermer la fenêtre du switch")
          Get_WinSwitchBlock_BtnCancel().Click(); 
          Log.Message("Aller au module compte")
          Get_ModulesBar_BtnAccounts().Click();
/************************************Étape 9************************************************************************/     
           /* Créer et appliquer un critère de recherche contenant plusieurs comptes*/ 
          Log.PopLogFolder();
          logEtape9 = Log.AppendFolder("Étape 9: Créer et appliquer un critère de recherche contenant plusieurs comptes");
          Log.Message("Créer et appliquer un critère de recherche contenant plusieurs comptes:Liste de comptes ayant Devise égal à USD ET ayant Devise égal à CAD")
           Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove().Click();
   
          Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().Keys(nameCritereStep9);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCurrency().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemUSD().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCurrency().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemCAD().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
          Delay(5000);
          Log.Message("La liste retournée est vide")
          var numberElementGril=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count
           if(numberElementGril ==0  )
                 Log.Checkpoint("La liste retournée est vide")
           else                           
                 Log.Error("La liste retournée n'est pas vide") 
                 
/************************************Étape 10************************************************************************/     
           /* Désactiver le critère sans le supprimer*/ 
          Log.PopLogFolder();
          logEtape10 = Log.AppendFolder("Étape 10: Désactiver le critère sans le supprimer");
          Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().Click();
             
/************************************Étape 11************************************************************************/     
           /* Sélectionner 5 comptes puis cliquer sur le bouton Bloc-Swich*/ 
          Log.PopLogFolder();
          logEtape11 = Log.AppendFolder("Étape 11: Sélectionner 5 comptes puis cliquer sur le bouton Bloc-Swich");
           //Sélectionner les comptes 800302-OB,800217-RE,800217-SF,800228-FS et 800228-JW
          Log.Message("Sélectionner les comptes: "+account800302OB+", "+account800217RE+", "+account800217SF+" ,"+account800228FS+" ,"+account800228JW);
          var arrayOfAccountsNo= new Array(account800302OB,account800217RE,account800217SF,account800228FS,account800228JW)
          SelectAccountsWithoutRemoveCheckMarks(arrayOfAccountsNo)     
          Log.Message("Dans la barre de menu cliquer sur le bouton Bloc-Swich")
          Get_Toolbar_BtnSwitchBlock().Click();
          Log.Message("Le décompte égal  a 5 élements");
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, valueDecompteStep3);
          
/************************************Étape 12************************************************************************/     
           /* Changer la source à Liste courante (Crochets)*/ 
          Log.PopLogFolder();
          logEtape12 = Log.AppendFolder("Étape 12: Changer la source à Liste courante (Crochets)");
          //Changer la Source à Liste courante (Crochets)
          Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
          Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceTypeStep4],10).Click();  
          
          Log.Message("Le décompte devient 0 élements");
          aqObject.CheckProperty( Get_WinSwitchBlock_GrpParameters_LblElements(), "WPFControlText", cmpEqual, valueDecompteStep12);
/************************************Étape 13************************************************************************/     
           /* Remettre la Source à Sélection courante*/ 
          Log.PopLogFolder();
          logEtape13 = Log.AppendFolder("Étape 13: Remettre la Source à Sélection courante");
           //Remettre la Source à Sélection courante
          Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
          Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",sourceTypeStep13],10).Click();    
                 
/************************************Étape 14************************************************************************/     
           /* Dans la fênetre Transaction: Vente, ajouter une action puis sauvegarder*/ 
          Log.PopLogFolder();
          logEtape14 = Log.AppendFolder("Étape 14: Dans la fênetre Transaction: Vente, ajouter une action puis sauvegarder");
          // Ajouter une transaction Vente Quantité=100, Sélectionner Unité par compte, Titre:Symbole=MSFT
           Log.Message("Ajouter une transaction Vente");
           Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
           Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionVente],10).Click();
           Log.Message("clic sur le bouton ajouter")
           Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10);
           Log.Message(" Quantité=100, Sélectionner Unité par compte, Titre:Symbole=MSFT")
           AddASellBySymbol(quantityTCVE1741,cmbTransaction,symbolMSFT);
           Log.Message("L'action ajoutée est affiché dans la fênetre Transaction de vente,Le bouton Générer est grisé et inactif,Le bouton Aperçu est activé")
           var symbol=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Items.Item(0).DataItem.SymbolDisplay.OleValue
           CheckEquals(symbol,symbolMSFT ,"Le symbole est")
           Log.Message("Le bouton Aperçu est activé")
           aqObject.CheckProperty(Get_WinSwitchBlock_BtnPreview(), "IsEnabled", cmpEqual, true);
               
           Log.Message("Le bouton Générer est grisé")
           aqObject.CheckProperty(Get_WinSwitchBlock_BtnGenerate(), "IsEnabled", cmpEqual, false);
/************************************Étape 15************************************************************************/     
           /* Cliquer sur Aperçu*/ 
          Log.PopLogFolder();
          logEtape15 = Log.AppendFolder("Étape 15: Cliquer sur Aperçu");
          Get_WinSwitchBlock_BtnPreview().Click();
          Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
          Log.Message( "La vente du titre MSFT est coché dans les 5 comptes")
          var displayIncludItem1=Get_WinSwitchBlock_DgvOrders().Items.Item(0).DataItem.IsIncluded
          var displayIncludItem2=Get_WinSwitchBlock_DgvOrders().Items.Item(1).DataItem.IsIncluded
          var displayIncludItem3=Get_WinSwitchBlock_DgvOrders().Items.Item(2).DataItem.IsIncluded
          var displayIncludItem4=Get_WinSwitchBlock_DgvOrders().Items.Item(3).DataItem.IsIncluded
          var displayIncludItem5=Get_WinSwitchBlock_DgvOrders().Items.Item(4).DataItem.IsIncluded
          
          CheckEquals(displayIncludItem1, true, "Le case à  côhée inclure pour le premier compte est ");
          CheckEquals(displayIncludItem2, true, "Le case à  côhée inclure pour le deuxième ompte est ");
          CheckEquals(displayIncludItem3, true, "Le case à  côhée inclure pour le troisième compte est ");
          CheckEquals(displayIncludItem4, true, "Le case à  côhée inclure pour le quatrième compte est ");
          CheckEquals(displayIncludItem5, true, "Le case à  côhée inclure pour le cinquième compte est ");
          
          Log.Message("Le bouton Générer devient actif")
          aqObject.CheckProperty(Get_WinSwitchBlock_BtnGenerate(), "IsEnabled", cmpEqual, true);
          
/************************************Étape 16************************************************************************/     
           /* Cliquer sur le bouton Modifier pour modifier n'importe quel champ de l'action ajoutée */ 
          Log.PopLogFolder();
          logEtape16 = Log.AppendFolder("Étape 16: Cliquer sur le bouton Modifier pour modifier n'importe quel champ de l'action ajoutée ");
          Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();     
          Get_WinSwitchSource_TxtQuantity().Keys(quantityStep16);
          Get_WinSwitchSource_btnOK().Click();
          WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
          //Le bouton Générer devient inactif et grisé
          Log.Message("Le bouton Générer inactif et grisé")
          aqObject.CheckProperty(Get_WinSwitchBlock_BtnGenerate(), "IsEnabled", cmpEqual, false);
          var quantity=Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Items.Item(0).DataItem.DisplayQuantity.OleValue
          CheckEquals(quantity,displayquantityStep16 ,"La quantité est")
/************************************Étape 17************************************************************************/     
           /* Répéter les étapes 15 et 16 pour toutes les valeurs pouvant être modifiées dans la fenêtre et valider que 
              - le bouton Générer est grisé à chaque modification
              - Cliquer sur Aperçu pour activer le bouton Générer*/ 
          Log.PopLogFolder();
          logEtape17 = Log.AppendFolder("Étape 17: Répéter les étapes 15 et 16 pour toutes les valeurs pouvant être modifiées dans la fenêtre et valider que - le bouton Générer est grisé à chaque modification- Cliquer sur Aperçu pour activer le bouton Générer ");
              
          //Changement de la combo de transaction pour : % de la position détenue
          Log.Message("Changement de la combo de transaction pour : % de la position détenue")
          Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();    
          Get_WinSwitchSource_CmbQuantity().Click();
          Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransactionStep16],10).Click();         
          Get_WinSwitchSource_btnOK().Click();
          WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
          //le bouton Générer est grisé à chaque modification
          Log.Message("Le bouton Générer inactif et grisé")
          aqObject.CheckProperty(Get_WinSwitchBlock_BtnGenerate(), "IsEnabled", cmpEqual, false);
          //Cliquer sur Aperçu pour activer le bouton Générer  
          Log.Message("Cliquer sur Aperçu")
          Get_WinSwitchBlock_BtnPreview().Click();  
          Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,30000);
            
          //Changement de symbole pour le symbole NA
          Log.Message("Changement de symbole pour  le symbole NA")
          Get_WinSwitchBlock_GrpTransactions_BtnEdit().WaitProperty("IsEnabled",true,30000);
          Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();    
          Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
          Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
            Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbolStep16);
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
            SetAutoTimeOut();
            if(Get_SubMenus().Exists){
              Get_SubMenus().FindChild("Value",symbolStep16,10).DblClick();
            }
            RestoreAutoTimeOut();
            Get_WinSwitchSource_btnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            //le bouton Générer est grisé à chaque modification
          Log.Message("Le bouton Générer inactif et grisé")
          aqObject.CheckProperty(Get_WinSwitchBlock_BtnGenerate(), "IsEnabled", cmpEqual, false);
          Log.Message("Clic sur le bouton Annuler pour fermer la fenêtre ordre multiple en block")
          Get_WinSwitchBlock_BtnCancel().Click();
          Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove().Click();
        }

          
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        
          // Initialiser la BD 
          Get_Toolbar_BtnManageSearchCriteria().Click();
          Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
                 
          Get_WinSearchCriteriaManager_BtnClose().Click();
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

          //Fermer Croesus
          Terminate_CroesusProcess();     
          Delete_FilterCriterion(nameCritereStep1,vServerOrders) 
          Delete_FilterCriterion(nameCritereStep9,vServerOrders)  
    }
 }
 
 


function SelectAccountsWithoutRemoveCheckMarks(arrayOfAccountsNumbersToBeSelected)
{
    if (GetVarType(arrayOfAccountsNumbersToBeSelected) != varArray && GetVarType(arrayOfAccountsNumbersToBeSelected) != varDispatch)
        arrayOfAccountsNumbersToBeSelected = new Array(arrayOfAccountsNumbersToBeSelected);
    
    //Aller au module Comptes et enlever toute sélection
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    
    
    if (VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count) < 1){
        Log.Error("The Accounts data grid is empty.");
        return false;
    }
    
    //Sélectionner les comptes désirés
    for (var i in arrayOfAccountsNumbersToBeSelected){
        SearchAccount(arrayOfAccountsNumbersToBeSelected[i]);
        var accountNumberCell = Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", arrayOfAccountsNumbersToBeSelected[i], 10, true, 30000);
        SetAutoTimeOut();
        if (accountNumberCell.Exists)
            accountNumberCell.Click(-1, -1, skCtrl);
        else
            Log.Error("The Account number '" + arrayOfAccountsNumbersToBeSelected[i] + "' cell was not found.");
    }
    RestoreAutoTimeOut();
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text === null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements < arrayOfAccountsNumbersToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedElements + " out of " + arrayOfAccountsNumbersToBeSelected.length + " accounts have been selected!");
    
    return (nbOfSelectedElements == arrayOfAccountsNumbersToBeSelected.length);
}
 