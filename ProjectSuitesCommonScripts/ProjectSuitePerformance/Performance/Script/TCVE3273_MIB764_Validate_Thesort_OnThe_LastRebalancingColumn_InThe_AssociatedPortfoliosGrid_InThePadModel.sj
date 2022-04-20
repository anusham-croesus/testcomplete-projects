//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/* 
Jira                     : https://jira.croesus.com/browse/MIB-1499
Résumé                   : Valider le tri sur la colonne Dernier rééquilibrage dans l'onglet Portefeuilles associés du module Modèles.
Précondition             : CE JIRA DOIT ÊTRE AUTOMATISÉ DANS L'ENVIRONNEMENT NFR.
Analyste d'automatisation: Alhassane DIALLO 
*/

function TCVE3273_MIB764_Validate_Thesort_OnThe_LastRebalancingColumn_InThe_AssociatedPortfoliosGrid_InThePadModel() {

          try {
                    
          
                   var userDESLAUJE        = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DESLAUJE", "username");
                   var pswDESLAUJE         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "psw");
                   var modelNumber         = "~M-0ANXL-0"
                   
                    // Se connecter à croesus avec le user Deslauje
                    Log.PopLogFolder();
                    logEtape1 = Log.AppendFolder("Etape 1:Se connecter à croesus avec le user Deslauje ");
                    Login(vServerPerformance, userDESLAUJE, pswDESLAUJE, language);
                    

                    // Attend le module Modele soit présent et actif puis y acceder
                    Log.PopLogFolder();
                    logEtape2 = Log.AppendFolder("Etape 2: Attend le module Modele soit présent et actif puis y acceder ");
                    Get_ModulesBar_BtnModels().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnModels().Click(); 
                    WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
                    
                    
                    
                    //Sélectionner le modèle NAME ~M-0ANXL-0 puis acceder a  l'onglet Portefeuilles associés.
                    Log.PopLogFolder();
                    logEtape3 = Log.AppendFolder("Etape 3: Sélectionner le modèle NAME ~M-0ANXL-0 puis acceder a  l'onglet Portefeuilles associés. ");
                    Search_Model(modelNumber); 
                    Get_ModelsGrid().Find("Value",modelNumber,10).Click();
                    
                    //Cliquer sur la colonne Dernier rééquilibrage pour faire un tri par odre croissant
                    Log.PopLogFolder();
                    logEtape4 = Log.AppendFolder("Etape 4 : Cliquer sur la colonne Dernier rééquilibrage pour faire un tri par odre croissant. ");
                    Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing().Click();
                    
                    
                    //Valider que le tri par odres croissant
                    Log.PopLogFolder();
                    logEtape5 = Log.AppendFolder("Etape 5 :Valider que le tri par odres croissant");
                    var grid = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1)
                    var count = grid.Items.Count
                              
                    if(Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing().SortStatus=="Ascending"){              
                         for (i = 0; i<=count-2; i++){
                    
                                    var date1 = grid.Items.Item(i).DataItem.LastSyncDate
                                    var date2 = grid.Items.Item(i+1).DataItem.LastSyncDate
                            
                                    if (date1 != undefined && date2 != undefined ){
                                
                                        var valueReturnFunction  = aqDateTime.Compare(date2, date1);
                                        if (valueReturnFunction== -1) {
                                               break;
                                        }
                                    }
                          }
                    }
 
                    if (valueReturnFunction== -1) {
                        Log.Error("les dates de la colonne Dernier rééquilibrage ne sont  pas triés par ordre croissant")         
                    }  
                    else {
                        Log.Checkpoint("les dates de la colonne Dernier rééquilibrage ne sont  triés par ordres croissant")
                    }
                    
                    //Valider que le tri par odres decroissant
                    Log.PopLogFolder();
                    logEtape6 = Log.AppendFolder("Etape 6 :Valider que le tri par odres decroissant"); 
                    Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing().Click();
                    var grid = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1)
                    var count = grid.Items.Count
                    if(Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing().SortStatus=="Descending"){
                        for (i = 0; i<=count-2; i++){
                    
                                    var date1 = grid.Items.Item(i).DataItem.LastSyncDate
                                    var date2 = grid.Items.Item(i+1).DataItem.LastSyncDate
                            
                          
                                    if (date1 != undefined && date2 != undefined ){
                                
                                        var valueReturnFunction  = aqDateTime.Compare(date1, date2);
                                        if (valueReturnFunction== -1) {
                                                 break;
                                        }     
                                    }         
                     }   
                         
                       
                     if (valueReturnFunction== -1) {
                        Log.Error("les dates de la colonne Dernier rééquilibrage ne sont  pas trié par ordre decroissant")         
                     }  
                     else {
                        Log.Checkpoint ("les dates de la colonne Dernier rééquilibrage sont  trié par ordres decroissant")
                     }
                          
                 }

                   
          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
          finally {
                   

                    
                    //Fermer Croesus
                    Terminate_CroesusProcess(); 
                    Terminate_IEProcess();
          }

}


