//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT GDO_2464_Split_Of_BlockTrade


/**
    Jira Xray   : TCVE-2790
    Description : 
    Analyste d'assurance qualité : Karima Mo
    Analyste d'automatisation : A.A
    
    Version 90.21-26
**/
            var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw"); 
     
            var userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
            var passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw"); 


function CR2406_AddFiltersValidationByBranchsAndUsers(){
    
            var logEtape1, logEtape2, logRetourEtatInitial;

            var userNameLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
            var passwordLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw");
                  
//            var SQL_filePath            = ProjectSuite.Path + "Ordres\\Sql\\";
            var SQL_filePath            = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\Sql\\";
            var deleteOrdersFile        = "DeleteOrdersFromAccumulator.sql";
            var deleteOrdersFile_CR2406 = "DeleteOrdersFromAccumulator_CR2406.sql"
            var genereOrdersFile        = "TCVE-2790.sql"
            
            try {
                Log.Link("https://jira.croesus.com/browse/TCVE-2790","Lien du Cas de test sur Jira Xray");
                
                var filterOptionsList   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2406", "CR2406_FilterOptionsList", language+client);
                var branchsList         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2406", "CR2406_BranchsList", language+client);
                var NBOrdersList        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2406", "CR2406_NBOrdersList", language+client);
                
                var amongOperator       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2406", "CR2406_AmongOperator", language+client);
                var excludingOperator   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2406", "CR2406_ExcludingOperator", language+client);               
                var branchValue         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2406", "CR2406_Branch", language+client);

                var arrayOfOptionValues = (Trim(filterOptionsList) == "")? []: filterOptionsList.split("|");
                var arrayOfBranchValues = branchsList.split("|");
                var arrayOfFields       = [arrayOfOptionValues[5], arrayOfOptionValues[5], arrayOfOptionValues[4]];
                var arrayNBOrders       = NBOrdersList.split("|");
                
//                var filterOptionsList   = "Ajouter un filtre...|Gérer les filtres...|Ordre|Type d'ordre|Créé par|Succursale de l'utilisateur qui a créé les ordres"
//                var branchsList         = "Laval|Head-Office|GP1859|Toronto";

                var filterName      = "FilterTest_"
                var createdByREAGAR = "CrééPar_" + userNameREAGAR; 
                var symbol_TUP = "TUP";
                var quantity_218 = 218;
                var AB_Lincoln = "Abraham Lincoln"

//Étape1:       
                Log.PopLogFolder();        
                logEtape1 = Log.AppendFolder("Étape 1: Execution requête et fichiers SQL");
         
                //Supprimer les ordres dans l'accumulateur
                var DeleteAllOrdersQuerryString = "delete from B_GDO_ORDER where STATUS=70";
                Execute_SQLQuery(DeleteAllOrdersQuerryString, vServerOrders);
                 
                //Executer les fichiers SQL pour générer les ordres
                ExecuteSQLFile(SQL_filePath + genereOrdersFile, vServerOrders);
                             
                //Requête pour la version 2021.06 et plus pour la table b_gdo_order_rep
                var Gdo_Order_Rep_Querry= "insert into b_gdo_order_rep (ORDER_ID,REP_ID) select GDODER_ID, REP_ID from B_GDO_ORDER where STATUS = 70";
                Execute_SQLQuery(Gdo_Order_Rep_Querry, vServerOrders);
                
//Étape2:       
                Log.PopLogFolder();        
                logEtape2 = Log.AppendFolder("Étape 2: Connexion + ouvrir module Ordre.");
                
                //Login avec GP1859
                Login(vServerOrders, userNameGP1859, passwordGP1859, language);
                
                //Acceder au Module Ordres
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);                
 
//Étape3:       
                Log.PopLogFolder();        
                logEtape3 = Log.AppendFolder("Étape 3: Valider le menu entonnoire");
                
                //La liste des choix dans le menu entonnoire
                ValidateOperatorList(arrayOfOptionValues);

//Étape4-6:     
                Log.PopLogFolder();          
                logEtape4 = Log.AppendFolder("Étape 4-6: Ajouter 3 filtres et valider les résultats");                                            
                //Ajouter 3 filtres et valider le résultat retouné par chaque filtre
                for(i=0; i<3; i++){
                    AddFilterOrderAccumulator(arrayOfOptionValues[0], filterName + i, arrayOfFields[i], amongOperator, arrayOfBranchValues[i]);
                    var count = Get_OrderAccumulatorGrid().RecordListControl.items.count;
                    Log.Message(count)
                    CheckEquals(count, arrayNBOrders[i], "Nombre d'ordres dans la liste: ");
                    
                    //Fermer le fitre sauf le dernier
                    if(i<2)
                        Get_OrderAccumulatorGrid_ToggleButtn(1).WPFObject("Button", "", 2).Click();
                }
                
                //Ouvrir la fenêtre de gestion des filtres
                Get_OrderAccumulatorGrid().Click(10,25);
                Get_SubMenus().FindChild("WPFControlText", arrayOfOptionValues[1], 10).Click();
                WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935", 5000);

 //Étape7:      
                Log.PopLogFolder();         
                logEtape5 = Log.AppendFolder("Étape 7: Valider que les filtre sont sauvegadés et fermer Croesus");              
                                
                //Valider que les 3 filtres sont sauvegardés
                var objectList = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DataGrid().WPFObject("RecordListControl", "", 1)
                var count      = objectList.items.count;

                Log.Message(count);
                for(i=0; i<count; i++){
                    aqObject.CheckProperty(objectList.Items.Item(i).DataItem, "Description", cmpEqual, filterName + i);
                }
                
                //Modifier le filtre 2 de parmi à excluant et l'appliquer
                objectList.FindChild("Text", filterName+1, 10).Click();
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit().Click();
                Get_WinQuickFilterEdition_LblOperator().Click();        
                Get_SubMenus().Find("Text", excludingOperator, 10).Click();
                Get_WinQuickFilterEdition_BtnOK().Click();
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
                
                //Fermer Croesus
                Close_Croesus_X();
                if(Get_DlgConfirmation().Exists)
                        Get_DlgConfirmation_BtnYes().Click();

                        
//Étape8:       
                Log.PopLogFolder();        
                logEtape6 = Log.AppendFolder("Étape 8: Se connecter avec GP1859, valider que les filres sont actifs ");
                //Se connecter avec GP1859
                Login(vServerOrders, userNameGP1859, passwordGP1859, language);
                
                //Acceder au Module Ordres
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
                
                //Verfier que les filtres 2 et 3 sont appliqués dans le même ordre
                aqObject.CheckProperty(Get_OrderAccumulatorGrid_ToggleButtn(1).DataContext, "FilterDescription", cmpEqual, filterName + 2); 
                aqObject.CheckProperty(Get_OrderAccumulatorGrid_ToggleButtn(1), "wState", cmpEqual, 1);
            
                aqObject.CheckProperty(Get_OrderAccumulatorGrid_ToggleButtn(2).DataContext, "FilterDescription", cmpEqual, filterName + 1); 
                aqObject.CheckProperty(Get_OrderAccumulatorGrid_ToggleButtn(2), "wState", cmpEqual, 1);
                
                //Fermer Croesus
                Close_Croesus_X();
                if(Get_DlgConfirmation().Exists)
                        Get_DlgConfirmation_BtnYes().Click();
 
//Étape9:        
                Log.PopLogFolder();       
                logEtape7 = Log.AppendFolder("Étape 9-10: Se connecter avec REAGAR ajouter un filtre ");                               
                
                //Se connecter avec REAGAR
                Login(vServerOrders, userNameREAGAR, passwordREAGAR, language);
                
                //Acceder au Module Ordres
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
                
                //Ouvrir la fenêtre de gestion des filtres
                Get_OrderAccumulatorGrid().Click(10,25);
                Get_SubMenus().FindChild("WPFControlText", arrayOfOptionValues[5], 10).Click();
                WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935", 5000);
                
                //Valider qu'il ya une seule valeur 'Toronto'
                var nbValues = Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Count;
                Log.Message(nbValues);
                if(nbValues == 1)
                    aqObject.CheckProperty(Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "Value", cmpEqual, "Toronto"); 
                else
                    Log.Error("Il'y a plus d'un choix dans la liste des valeurs");
                
                Get_WinCreateFilter_BtnCancel().Click();
                
                //Ajouter un filtre pour REAGAR 
                AddFilterOrderAccumulator(arrayOfOptionValues[0], filterName + userNameREAGAR, arrayOfFields[1], amongOperator, arrayOfBranchValues[3]);
                
//Étape11:      
                Log.PopLogFolder();         
                logEtape7 = Log.AppendFolder("Étape 11: Ajouter un filtre Créé par REAGAR et fermer Croesus");                
                //Valider que le résutat contient 4 ordres
                aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.items, "Count", cmpEqual, 4);
                
                //Fermer le filtre
                Get_OrderAccumulatorGrid_ToggleButtn(1).WPFObject("Button", "", 2).Click();
                
                //Ajouter un filtre avec succursale = Toronto
                AddFilterOrderAccumulator(arrayOfOptionValues[0], createdByREAGAR, arrayOfFields[2], amongOperator, userNameREAGAR, branchValue);
                aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.items, "Count", cmpEqual, 2);
                
                //Fermer le filtre
                Get_OrderAccumulatorGrid_ToggleButtn(1).WPFObject("Button", "", 2).Click();               
               
                //Fermer Croesus
                Close_Croesus_X();
        
//Étape12:      
                Log.PopLogFolder();         
                logEtape7 = Log.AppendFolder("Étape 12: Se connecter avec LINCOA, valider que le filtre créé par REAGAR est visible");
                
                //Se connecter avec LINCOA
                Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
                
                //Acceder au Module Ordres
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
                
                //Ouvrir la fenêtre de gestion des filtres
                Get_OrderAccumulatorGrid().Click(10,25);
                Get_SubMenus().FindChild("WPFControlText", arrayOfOptionValues[1], 10).Click();
                WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935", 5000);
                
                //Valider que le filtre créé par REAGAR existe 
                var objectList = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DataGrid().WPFObject("RecordListControl", "", 1)
                var count      = objectList.items.count;

                aqObject.CheckProperty(objectList.Items.Item(0).DataItem, "Description",     cmpEqual, createdByREAGAR);
                
                //Appliquer le filtre créé par REAGAR
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DataGrid().FindChild("Text", createdByREAGAR, 10).Click();
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
                
                //Valider que le résutat contient 2 ordres
                aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.items, "Count", cmpEqual, 2);
                
//Étape13:
                Log.PopLogFolder();         
                logEtape7 = Log.AppendFolder("Étape 13: Fusionner 2 ordres et valider l'ordre résultant");
                //Fermer le filtre
                Get_OrderAccumulatorGrid_ToggleButtn(1).WPFObject("Button", "", 2).Click();
                
                //Selectionner les ordres de symboles "TUP"
                var itemsCount = Get_OrderAccumulatorGrid().RecordListControl.items.Count;
                for(i=0; i<itemsCount; i++){
                  if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == symbol_TUP)
                    Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).IsSelected = true     
                }
                //Cliquer sur Fusionner
                Get_OrderAccumulator_BtnMerge().WaitProperty("Enabled", true, 5000)
                var nbTries = 0;
                  do {
                      Get_OrderAccumulator_BtnMerge().Click();
                  } while ((++nbTries) <= 3 && !Get_DlgConfirmation().Exists)
 
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlText"], ["BaseWindow", "Confirmation"], 5000);
                Get_DlgConfirmation_BtnOk().Click();
                
                //Valider les données de l'ordre fusionné
                var itemsCount = Get_OrderAccumulatorGrid().RecordListControl.items.Count;
                for(i=0; i<itemsCount; i++){
                  if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == symbol_TUP){
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.items.Item(i).DataItem, "Quantity", cmpEqual, quantity_218);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.items.Item(i).DataItem, "UserCreateForDisplay", cmpEqual, AB_Lincoln);
                    }
                }
                //Fermer Croesus
                Close_Croesus_X();
                if(Get_DlgConfirmation().Exists)
                        Get_DlgConfirmation_BtnYes().Click();
            }
            catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally { 
                
                Log.PopLogFolder();
                Log.AppendFolder("Étape 14: Supprimer les filtres créés pour GP1859");
                //Supprimer les filtres créé par GP1859
                DeleteFiltersInOrdersAccumulator(userNameGP1859, 3, arrayOfOptionValues[1]);
                
                Log.PopLogFolder();
                Log.AppendFolder("Étape 15: Supprimer les filtres créés pour REAGAR");
                //Supprimer les filtres créé par REAGAR
                DeleteFiltersInOrdersAccumulator(userNameREAGAR, 2, arrayOfOptionValues[1]);  
    
                //Supprimer les orders de l'accumulateur
                Execute_SQLQuery(DeleteAllOrdersQuerryString, vServerOrders);
        
                //Fermer le processus Croesus
                Terminate_CroesusProcess();
            }
}

function DeleteFiltersInOrdersAccumulator(userName, nbFilters, manageFilters){
    
                Login(vServerOrders, userName, passwordGP1859, language);
                
                //Acceder au Module Ordres
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
                
                //Ouvrir la fenêtre de gestion des filtres
                Get_OrderAccumulatorGrid().Click(10,25);
                Get_SubMenus().FindChild("WPFControlText", manageFilters, 10).Click();
                WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935", 5000);
                for(i=0; i<nbFilters; i++){
                    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete().Click();
                    Get_DlgConfirmation_BtnDelete().Click();
                }
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
                
                //Fermer Croesus
                Close_Croesus_X();
                if(Get_DlgConfirmation().Exists)
                        Get_DlgConfirmation_BtnYes().Click();
}

function ValidateOperatorList(arrayOfOptions){
          
          //Clicker  sur l'entonnoire  
          Get_OrderAccumulatorGrid().Click(10,25);
          //Valider les valeurs affichées dans le sous-menu
          for (j=0; j< arrayOfOptions.length; j++){
              var operatorValue = arrayOfOptions[j];
              Log.Message(j +" : " + operatorValue);
              var componentObject = Get_SubMenus().FindChild("WPFControlText", operatorValue, 10);
            
              if(componentObject.Exists){
                      aqObject.CheckProperty(componentObject, "VisibleOnScreen", cmpEqual, true);               
                      aqObject.CheckProperty(componentObject, "Isvisible",       cmpEqual, true);
                      Log.Checkpoint("Le libellé : '" + operatorValue + "'   Existe dans la liste 'Operator' et visible");
              }
              else  
                      Log.Error("Le libellé : '" + operatorValue + "'  n'existe pas dans la liste 'Operator'");       
          }
}

function AddFilterOrderAccumulator(addAFilter, filterName, fieldValue, operator, value, accessLevel){
                
            //Clicker  sur l'entonnoire
            Get_OrderAccumulatorGrid().Click(10,25);
            //Choisir Add Filter
            Get_SubMenus().FindChild("WPFControlText", addAFilter, 10).Click();
            WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935", 5000);

            Get_WinQuickFilterEdition_TxtName().Keys(filterName) 
            if (accessLevel != undefined && accessLevel != null)
                    SelectComboBoxItem(Get_WinQuickFilterEdition_CmbAccess(), accessLevel);
                     
            SelectComboBoxItem(Get_WinQuickFilterEdition_CmbField(), fieldValue); 
            Get_WinQuickFilterEdition_LblOperator().Click();
            Get_SubMenus().Find("Text", operator, 10).Click();     
            Get_WinQuickFilterEdition().Find("Value", value, 10).Click();
            
            Get_WinQuickFilterEdition_BtnOK().Click();
}