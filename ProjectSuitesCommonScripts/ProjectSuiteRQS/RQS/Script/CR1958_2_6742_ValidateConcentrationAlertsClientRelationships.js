//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6742
    Description :
                 Validate concentration alerts & Client relationships
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels:Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
**/
function CR1958_2_6742_ValidateConcentrationAlertsClientRelationships()
{
    try {
      
               //Variables             
               var RelationName          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_RelationName", language + client);               
               var RelationNum           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_RelationNum", language + client);
               var SecurityIAH           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_IAH", language + client); 
               var SecurityNA            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_NA", language + client); 
               var SecurityXBB           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_XBB", language + client);                               
               var MarketValueIAH        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_MarketValueIAH", language + client); 
               var MarketValueNA         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_MarketValueNA", language + client); 
               var MarketValueXBB        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_MarketValueXBB", language + client);               
               var ClientRelNumberFilter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_ClientRelNumberFilter", language + client);
               var ClientRelNumber       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_ClientRelNumber", language + client);
               
               var RiskRatingIAH     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_RiskRatingIAH", language + client); 
               var RiskRatingNA      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_RiskRatingNA", language + client); 
               var RiskRatingXBB     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_RiskRatingXBB", language + client);
               var Totalvalue        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_TotalValue", language + client);
               var AlerteStatut      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_AlerteStatut", language + client);                
               var RisckRatingColum  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_RiskRatingColum", language + client); 
               
               
               var PortofolioMarketValueIAH = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_PortofolioMarketValueIAH", language + client); 
               var PortofolioMarketValueNA  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_PortofolioMarketValueNA", language + client); 
               var PortofolioMarketValueXBB = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_PortofolioMarketValueXBB1", language + client);  
                 
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");

               
            
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6742","Lien testlink - Croes-6742");
//Étape 1      
       
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
       
       
               //Aller dans le module Relation 
               Log.Message("******************** Aller dans le module Relation  *******************");
               Get_ModulesBar_BtnRelationships().Click();
               Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
               
               //Faire une recherche de la relation :80030 (1SCORE CALCUL) et le mailler vers Portefeuille.
               Log.Message("******************** Faire une recherche et la relation :80030 (1SCORE CALCUL) et mailler vers Portefeuille. *******************");
               SearchRelationshipByName(RelationName)
               Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationName, 10), Get_ModulesBar_BtnPortfolio());
               
                
               //Cliquer sur le bouton par titre  (By Security)
               Log.Message("******************** Cliquer sur le bouton par titre  (By Security). *******************");
               Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity().Click();
               
               //Ajouter la colonne Cote de risque (Risck Rating)
                Log.Message("******************** Faire une recherhe et la relation :80030 (1SCORE CALCUL) et mailler vers Portefeuille. *******************");
                Get_Portfolio_PositionsGrid_ChSymbol().ClickR()
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();               
                Add_ColumnByLabel(Get_Portfolio_PositionsGrid_ChSymbol(), RisckRatingColum);
                
                
               //Valider la valeur de marché pour les trois positions  dans le module portefeuilles
               Log.Message("******************** Valider la valeur de marché pour les trois positions  dans le module portefeuilles*******************");
               
               var nbrPos = Get_Portfolio_PositionsGrid().Items.count;

               //Dans le module portefeuille chercher la position IAH et valider sa valeur de marché
               Log.Message("********************Dans le module portefeuille chercher la position IAH et valider sa valeur de marché*******************");
               Search_Position(SecurityIAH);
               for (i=0; i<nbrPos; i++){           
                   if (Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.Symbol == "IAH"){                
                       var  TotalValuePercentageMarketIAH = roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.TotalValuePercentageMarket, 2);           
                            CheckEquals(TotalValuePercentageMarketIAH, PortofolioMarketValueIAH, 'PortofolioMarketValueIAH');                                         
                    }
                 }
                
//Étape 2

                 //Dans le module portefeuille chercher la position NA et valider sa valeur de marché
                 Log.Message("******************** Dans le module portefeuille chercher la position NA et valider sa valeur de marché*******************");  
                 Search_Position(SecurityNA);;
                 for (i=0; i<nbrPos; i++){              
                     if (Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.Symbol == "NA"){
                        var  TotalValuePercentageMarketNA = roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.TotalValuePercentageMarket, 2);
                        CheckEquals(TotalValuePercentageMarketNA, PortofolioMarketValueNA, 'PortofolioMarketValueNA');                                        
                        }
                  }
                  
//Étape 3               
                   
                 //Dans le module portefeuille chercher la position XBB et valider sa valeur de marché
                  Log.Message("******************** Dans le module portefeuille chercher la position XBB et valider sa valeur de marché*******************");
                  Search_Position(SecurityXBB);
                  for (i=0; i<nbrPos; i++){                        
                       if (Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.Symbol == "XBB"){               
                           var  TotalValuePercentageMarketXBB = roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.TotalValuePercentageMarket, 2)           
                           CheckEquals(TotalValuePercentageMarketXBB, PortofolioMarketValueXBB, 'PortofolioMarketValueXBB');                                        
                     }
                   }

//Étape 4

                 //Selectionner  les positions  (IAH), NA et XBB, puis mailler les vers le module titre 
                 Log.Message("******************** Chercher les positions  (IAH), (NA) et (XBB), puis mailler les vers le module titre . *******************");
                 Search_SecurityBySymbol(SecurityIAH)
                 Get_Portfolio_PositionsGrid().FindChild("Value", SecurityIAH, 10).Click(-1, -1, skCtrl)
                 Search_SecurityBySymbol(SecurityNA)
                 Get_Portfolio_PositionsGrid().FindChild("Value", SecurityNA, 10).Click(-1, -1, skCtrl); 
                 Search_SecurityBySymbol(SecurityXBB)
                 Get_Portfolio_PositionsGrid().FindChild("Value", SecurityXBB, 10).Click(-1, -1, skCtrl); 
                 Drag(Get_Portfolio_PositionsGrid().FindChild("Value", SecurityXBB, 10), Get_ModulesBar_BtnSecurities());
               
//Étape 5
              
                 //Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenetre RQS 
                 Log.Message("******************** Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenetre RQS. *******************");
                 Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
                 var nbTries = 0; //Par Christophe : Réessayer  au cas où le clic n'aurait pas réussi à faire afficher la fenêtre
                 do {
                     Get_Toolbar_BtnRQS().Click();
                 } while((++nbTries) < 3 && !Get_WinRQS().Exists)
               
                // Cliquer sur l'onglet Alerte
                Log.Message("******************** Cliquer sur l'onglet Alerte. *******************");
                Get_WinRQS_TabAlerts().Click();  
                Get_WinRQS_TabAlerts().WaitProperty("IsChecked", true, 30000);             
               
                //Ajouter le filtre Test
                Log.Message("******************** Ajouter le filtre Test. *******************");
                Get_WinRQS_QuickFilterClick();
                Get_SubMenus().FindChild("WPFControlText", "Test", 10).Click();
                Get_WinCreateFilter().FindChild("Text", "Concentration", 10).Click();
                Get_WinCreateFilter_BtnApply().Click();              
               
                //Ajouter la colonne Numero de relation Client
                Log.Message("******************** Ajouter la colonne Numero de la  relation Client *******************");
                Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo().ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                Add_ColumnByLabel(Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo(), ClientRelNumber);
               
               
                //Ajouter le filtre Numero de la relation client (Numero de la relation client=80030)
                Log.Message("******************** Ajouter le filtre Numero de la relation client (Numero de la relation client=80030) *******************");
                Get_WinRQS_QuickFilterClick();
                Get_SubMenus().FindChild("WPFControlText", ClientRelNumberFilter, 10).Click();
                Get_WinCreateFilter_TxtValue().Clear();
                Get_WinCreateFilter_TxtValue().Keys(RelationNum);
                Get_WinCreateFilter_BtnApply().Click();
               
               
               //Les points de verifications 
                Log.Message("******************** Les points de verifications  *******************");
                var nbrAlertes = Get_WinRQS_TabAlerts_DgvAlerts().items.Count   
               
               
                //Valider le statut des alertes  pour les trois positions
                Log.Message("******************** Valider le statut des alertes  pour les trois positions    *******************");
                for (i=0; i<nbrAlertes; i++)
                  {
                   CheckEquals(Get_WinRQS_TabAlerts_DgvAlerts().Items.Item(i).DataItem.CurrentStatusDescription, AlerteStatut, 'CurrentStatusDescription');                    
                 }
             
                //Valider la valeur totale pour les trois positions  
                Log.Message("******************** Valider la valeur totale pour les trois positions    *******************");
                var width = Get_WinRQS().get_Width();
                var height= Get_WinRQS().get_Height();
                Get_WinRQS().Click((width*(2.5/3)),height-418);  
                var nbrAlertes = Get_WinRQS_TabAlerts_DgvAlerts().items.Count 
               
                for (i=0; i<nbrAlertes; i++)
                  {           
                    CheckEquals(trim(Get_WinRQS_TabAlerts_DgvAlerts().Items.Item(i).DataItem.TotalValue), Totalvalue, 'TotalValue');                    
                  }
             
                
                    
                //Valider la valeur de marché des trois positions  
                Log.Message("******************** Valider la valeur de marché pour les trois positions      *******************");
                Get_WinRQS().Parent.Maximize();
                Get_WinRQS_TabAlerlist().FindChild("Text", SecurityIAH, 10).Click();
                aqObject.CheckProperty(Get_WinRQSDetailsGrid_LblPositionMarketValue(),"Text",  cmpEqual,MarketValueIAH);

                Get_WinRQS_TabAlerlist().FindChild("Text", SecurityNA, 10).Click();
                aqObject.CheckProperty(Get_WinRQSDetailsGrid_LblPositionMarketValue(),"Text", cmpEqual,MarketValueNA)

                Get_WinRQS_TabAlerlist().FindChild("Text", SecurityXBB, 10).Click();
                aqObject.CheckProperty(Get_WinRQSDetailsGrid_LblPositionMarketValue(),"Text",  cmpEqual,MarketValueXBB)
                
                
                
                //Fermer la fenêtre RQS
                Log.Message("Fermer la fenêtre RQS");
  		       // Get_WinRQS().Close();

 
             
       //Fermer Croesus
         Close_Croesus_X(); 
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
       Terminate_CroesusProcess();
        
      
        
    }
}

 
//Clique sur l'icône "+"
function  Get_WinRQS_QuickFilterClick(){ Get_WinRQS().Click(7,100);}



    


 