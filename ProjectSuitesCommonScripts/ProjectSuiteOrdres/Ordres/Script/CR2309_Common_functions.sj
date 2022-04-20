//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA

// --------------- Contient les fonctions communes du CR 2309 -------------------

function SelectTwoOrderInAccumulat(numberOrder1,numberOrder2)
{     Log.Message("Sélectionner l'ordre " +numberOrder1) 
         var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == numberOrder1 ){
                  var dispalyQuantite10001=lines[n].dataContext.dataItem.DisplayQuantityStr.OleValue;
                     
                 Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           }
          

            Sys.Desktop.KeyDown(0x11);
            Log.Message("Sélectionner l'ordre " + numberOrder2) 
             var lines = Get_Grid_VisibleLines(Get_OrderAccumulatorGrid());
           for (n=0 ; n< lines.length; n++){
               if(lines[n].dataContext.dataItem.OrderId.OleValue == numberOrder2  ){
                 
                      
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsSelected(true);
                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items.Item(n).set_IsActive(true)
//                      Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n+1).Click();
                      break;
                 }
              
           } 
         Sys.Desktop.KeyUp(0x11);
         
}

// fonction pour Selectionner et ouvrir l'ordre numero 10001
function selectOrdreAndEdit(orderNum){
  
                 var nbr = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
                 for(var i = 0; i<nbr; i++) {
                    if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderId == orderNum)
                    {
                        
                        Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).set_IsSelected(true); 
                        Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).set_IsActive(true);
                        Get_OrderAccumulator().FindChild("Text",orderNum , 10).Click();
                        Get_OrderAccumulator_BtnEdit().Click();
                      
                     
                   
                 break;
                }                
              
            }
}
 
 
 

function selectTwoOrdreAndFusionner(orderNum){
  
                 var nbr = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
                 for(var i = 0; i<nbr; i++) {
                    if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderId == orderNum)
                    {
                        
                        Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).set_IsSelected(true); 
                        Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).set_IsActive(true);
                        Get_OrderAccumulator().FindChild("Text",orderNum , 10).Click();
                        Get_OrderAccumulator_BtnEdit().Click();
                      
                     
                   
                 break;
                }                
              
            }
}
 


//function pour ajouter la colonne Numero de l'ordres
function addColumn_ChOrderNo(){
  
            Log.Message("Aller dans l'Accumulateur et click droit pour ajouter la colonne numéro d'ordre");
            if(!Get_OrderAccumulatorGrid_ChOrderNo().Exists){
               
               Get_OrderAccumulatorGrid_ChAccountName().Click();
               Get_OrderAccumulatorGrid_ChAccountName().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 3], 10).Click();
               WaitObject(Get_OrderAccumulatorGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "16"],10);
              
            }  
            
}
// fonction pour Selectionner et ouvrir l'ordre numero 1006
function selectAndopen_Order1006(orderNum){
  
                 var nbr = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
                 for(var i = 0; i<nbr; i++) {
                    if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderId == orderNum)
                    {
                        
                        Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).set_IsSelected(true); 
                        Get_OrderAccumulator().FindChild("Text",orderNum , 10).Click();
                        Get_OrderAccumulator_BtnEdit().Click();
                      
                     
                   
                 break;
                }                
              
            }
}


//fonction pour valider la quantité du titre NA dans le Pad portefeuilles en Intraday
function validateQuantityNA_PadPortefolio(accountNumber, symbol,quantity){
  
           //Acceder au Module Compte 
           Log.Message("Acceder au Module Compte");
           Get_ModulesBar_BtnAccounts().Click();
           Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);  
           
           //Selectionner le compte 300014-NA et mailler dans Portefeuille
           Log.Message("Selectionner le compte 300014-NA et mailler dans Portefeuille");
           SearchAccount(accountNumber);
           Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber,10).Click();
           Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber,10), Get_ModulesBar_BtnPortfolio());
           
           //Cliquer sur le bouton Intraday puis valider la presence du  titre NA et sa quantité(400)
           Log.Message("Cliquer sur le bouton Intraday puis valider la presence du  titre NA et sa quantité(400)");
           Get_PortfolioBar_BtnIntraday().Click();
           Get_PortfolioBar_BtnIntraday().set_IsChecked(true)
           Get_PortfolioBar_BtnIntraday().WaitProperty("IsChecked", true, 100000);

           var grid = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1)
           var nbr = grid.Items.Count;
               for(var i = 0; i<nbr; i++){
                  if(grid.Items.Item(i).DataItem.Symbol == symbol){
                    aqObject.CheckProperty(grid.Items.Item(i).DataItem, "DisplayQuantity", cmpEqual,quantity);
                  }                          
               }  
}