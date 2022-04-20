//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Valider le Menu contextuel du module Portefeuille (l'option copier)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4456
    Analyste d'assurance qualité : Isabelle 
    Analyste d'automatisation : Alhassane
    Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_4456_Port_CheckFunctionContexMenuCopy()
{
    try {
        
       //Variables
       var client800300= ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "client800300", language+client);
       var non_dispo = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Non_dispo", language+client);
       var forma_dec2 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Forma_dec_2", language+client);
       var forma_dec3 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Forma_dec_3", language+client);
       var affichage_Yes_OUI = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Affichage_Yes_OUI", language+client);
       var affichage_No_Non = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Affichage_No_Non", language+client);
       var pos_R76899 =  ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "pos_R76899", language+client);
          



 
 


       //Lien Testlink        
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4456","Lien testlink - Croes-4456");
        
        //Login
        Log.Message("******************** Login *******************")
        Login(vServerPortefeuille, userName, psw, language);
        
        
    
        
        
        
        //Sélectionner le client 800300 et mailler vers module portefeuille
        Log.Message("*********Sélectionner le client 800300 et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client800300);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client800300,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd"); 
        
        
        //Remettre la configuration par defaut des colonnes 
          Get_Portfolio_PositionsGrid_ChSymbol().ClickR()
          Get_Portfolio_PositionsGrid_ChSymbol().ClickR()
          Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
         
         // Verifier que la presence de la colonne Instrument financier sinon ajouter la 
         Log.Message("*****Verifier la presence de la colonne Instrument Financier sinon ajouter la*******")
         if(!Get_Portfolio_PositionsGrid_ChFinancialInstrument().Exists){
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_GridHeader_ContextualMenu_AddColumn().Click();
         Get_GridHeader_ContextualMenu_AddColumn_FinancialInstrument().Click();
        }   
        
         
        //Selectionner la position CDN TIRE (R76899) et ouvrir le menu contextuel
       Log.Message("********* Selectionner la position "+pos_R76899+" et faire un cliquer droit pour  ouvrir le menu contextuel********")
       var count = Get_Portfolio_PositionsGrid().Items.Count;
       for (i=0;i<count;i++){
           if (Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.DisplayAccountNumber == "800300-NA" && Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.Symbol == "R76899")
            {
                Get_Portfolio_PositionsGrid().Items.Item(i).set_IsSelected(true);
                
                Get_Portfolio_PositionsGrid().Keys("[Apps]");
         
                //Valider l'option copier offert  par le menu contextuel
                var numberOftries=0;  
                while ( numberOftries < 5 && !Get_SubMenus().Exists){
                  Get_Portfolio_PositionsGrid().Keys("[Apps]");
                  numberOftries++;
                   } 
                        
              //Clic sur le bouton Copy
              Get_PortfolioGrid_ContextualMenu_Copy().Click();
      
      
               var copiedText = Sys.Clipboard
              // Split at each space character.
              var textArr = copiedText.split("	"); //Création du tableau avec le texte       
              Log.Message("The resulting array is: " + textArr);
      
      
        // Les points de vérifications
            //Account No
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "DisplayAccountNumber", cmpEqual, textArr[0]);
            //IA code
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "DisplayRepresentativeNumber", cmpEqual, textArr[1]);            
            //Name
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "DisplayClientShortName", cmpEqual, textArr[2]);
            //Type
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "DisplayAccountType", cmpEqual, textArr[3]);
            //Quantity
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "DisplayQuantityStr", cmpEqual, textArr[4]);            
            //Description
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "SecurityDescription", cmpEqual, textArr[5]);
            //Symbole
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "Symbol", cmpEqual, textArr[6]);           
            //Finanial Instrument
            aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "FinancialInstrumentDescription", cmpEqual, textArr[7]);                     
           
           
           //ACB
           if(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.AdjustedCostBase == null)
                CheckEquals(textArr[8],non_dispo ,"AdjustedCostBase (ABC)");
           else
                aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "AdjustedCostBase", cmpEqual, textArr[8]);               
         
           //MarketPrice
           if(aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketPrice,",")== -1 && aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketPrice,".")==-1)
           CheckEquals(textArr[9],Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketPrice+forma_dec3 ,"MarketPrice ");
          
           // BookValueACB      
           if(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.BookValueACB == null)
                CheckEquals(textArr[10],non_dispo ,"BookValueACB ");
           else
                aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "BookValueACB", cmpEqual, textArr[10]);
                
           //MarketValue                           
           if(aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketValue,",")== -1 && aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketValue,".")==-1)
           var val = aqString.Replace(textArr[11], ",", "")
           var val2 = aqString.Replace(textArr[11], " ", "")
            if(language=="french")
            CheckEquals(val2,Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketValue+forma_dec2 ,"MarketValue ");
            else
             CheckEquals(val,Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketValue+forma_dec2 ,"MarketValue ");
           //MV (%)
           var ModelTargetPercent = roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.ModelTargetPercent, 3);
           var val3 = aqString.Replace(textArr[12], ",", ".")
           if(language=="french"){
             CheckEquals(val3, ModelTargetPercent, "ModelTargetPercent ")
           }
           else
             CheckEquals(textArr[12], ModelTargetPercent, "ModelTargetPercent ");
           
           //GainLossACB
           if(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.GainLossACB == null)
              CheckEquals(textArr[13],non_dispo ,"GainLossACB ");
           else
                aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "GainLossACB", cmpEqual, textArr[13]);
           
           //PercentGainLossACB
           if(aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.PercentGainLossACB,",")== -1 && aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.PercentGainLossACB,".")==-1)
             CheckEquals(textArr[14],Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.PercentGainLossACB+forma_dec2,"G/L(%) ");
          //   CostYield          
           if(aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.CostYield,",")== -1 && aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.CostYield,".")==-1)
            CheckEquals(textArr[15],Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.CostYield+forma_dec2 ,"Cost Yield(%)");
           
           //MarketYield
           //aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "MarketYield", cmpEqual, roundDecimal(aqConvert.StrToFloat(textArr[16]),2));
           //var MarketYield = roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketYield, 2); 
           var MarketYield = Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.MarketYield ;        
           var val6 = aqString.Replace(textArr[16], ",", ".")
           if(language=="french"){
             CheckEquals(val6, MarketYield, "MarketYield")
           }
           else
             CheckEquals(textArr[16], MarketYield, "MarketYield ");
                      
           //CurrentYield
            if(aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.CurrentYield,",")== -1 && aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.CurrentYield,".")==-1)
            CheckEquals(textArr[17],Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.CurrentYield+forma_dec2,"CCY(%)");
          
           //YTM- cost(%)
           if(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.YieldToMaturityCostEffective == null)
              CheckEquals(textArr[18],non_dispo ,"YTM- cost(%) ");
           else
              aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem, "YieldToMaturityCostEffective", cmpEqual, textArr[18]);
           
          //YTM - Market(%)
           //aqObject.CheckProperty(roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.YieldToMaturityMarketEffective, 2), "YieldToMaturityMarketEffective", cmpEqual, textArr[19]);
           var yieldToMaturityMarketEffective = roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.YieldToMaturityMarketEffective, 2);           
           var val5 = aqString.Replace(textArr[19], ",", ".")
           if(language=="french"){
             CheckEquals(val5, yieldToMaturityMarketEffective, "YTM - Market(%)")
           }
           else
             CheckEquals(textArr[19], yieldToMaturityMarketEffective, "YTM - Market(%) ");
           
          //Mod.Duration
           if(aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.ModifiedDuration,",")== -1 && aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.ModifiedDuration,".")==-1)
            CheckEquals(textArr[21],Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.ModifiedDuration+forma_dec2 ,"Mod Duration ");   
            
           //YTD  
           var value = Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.YieldToDateACBNominal
            if (value.oleValue == null){
            CheckEquals(textArr[20],non_dispo ,"YieldToDateACBNominal ");
          } 
           //Accrued I/D
          var AccruedInterestDividend = roundDecimal(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.AccruedInterestDividend, 2);
          var val4 = aqString.Replace(textArr[22], ",", ".")
           if(language=="french"){
             CheckEquals(val4, AccruedInterestDividend, "Accured I/D ")
           }
          else
            CheckEquals(textArr[22], AccruedInterestDividend, "Accured I/D ");
           
            // Ann.Inc                       
            if(aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.AnnualIncome,",")== -1 && aqString.Contains(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.AnnualIncome,".")==-1)
            CheckEquals(textArr[23],Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.AnnualIncome+forma_dec2 ,"Ann Inc");
          
            
           //Locked.        
           if(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.IsBlockedSecurity == false)
              CheckEquals(textArr[24],affichage_No_Non ,"position bloquée ");
           else
              CheckEquals(textArr[24],Affichage_Yes_OUI ,"position bloquée ");

            //Exclud..            
           if(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.ExcludedFromBilling == false)
              CheckEquals(textArr[25],affichage_No_Non ,"Excluded From Billing ");
           else
              CheckEquals(textArr[25],Affichage_Yes_OUI ,"Excluded From Billing ");

            
         }
       }
        
        //Fermer Croesus
          Close_Croesus_X();
         
     
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
} 


function Get_GridHeader_ContextualMenu_AddColumn_FinancialInstrument(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: FinancialInstrumentDescription"], 10)}
