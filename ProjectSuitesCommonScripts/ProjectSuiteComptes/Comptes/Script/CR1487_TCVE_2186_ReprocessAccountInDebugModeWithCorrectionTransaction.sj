//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Auteur :              Sana Ayaz
    Version de scriptage:		ref90-19-2020-09-7--V9-croesus-co7x-2_1_758
    Date: 15-09-2020
    
*/


function CR1487_TCVE_2186_ReprocessAccountInDebugModeWithCorrectionTransaction() {
         
          try {
              
                    Log.Link("https://jira.croesus.com/browse/TCVE-2185","Lien du Cas de test");
                    Log.Link("https://jira.croesus.com/browse/TCVE-2189", "Lien de la story"); 
                   
                    
                    var userNameLoader                       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LOADER", "username");
                    var passwordLoader                       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LOADER", "psw");
                    var account800056FS                      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "account800056FS", language+client);
                    var textNoteTCVE2186                     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textNoteTCVE2186", language+client);
                    var userNameStep9                        = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "userNameStep9", language+client);
               
                  
//*********************************************  L'étape 1 ************************************************************");
                    Log.PopLogFolder();
                    logEtape1 = Log.AppendFolder("Étape 1: Se connecter en mode debug avec l’utilisateur Loader .Sélectionner l'option Gestionnaire de retraitement  , cliquer sur lancer un traitement taper le compte 800056-fs  cocher la case : supprimer transaction correctives");
                    Log.Message("Se connecter avec l'utilisateur Loader")
                    Login(vServerAccounts, userNameLoader ,passwordLoader,language);
                    Log.Message("Le mode debug s'affiche")
                    Get_MenuBar_Debug().OpenMenu();
                    Get_MenuBar_Debug_ReprocessingManager().Click();
                    Log.Message("Cliquer sur le bouton lancer un traitement")
                    Get_WinUserMultiSelection_BtnStartReprocessing().Click();
                    Log.Message("Taper le compte 800056-fs")
                    Get_WinReprocessParameters_TxtAccountPicker().Keys(account800056FS);
                    Get_WinReprocessParameters_BtnSearch().Click();
                    Get_WinReprocessParameters_ChkDeleteCorrectiveTransactions().set_IsChecked(true)
                    Log.Message("une section transaction s'affiche en bas de la section positions");
                    aqObject.CheckProperty(Get_WinReprocessParameters_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1), "VisibleOnScreen", cmpEqual, true);
                    
 

//*********************************************  L'étape 2 ************************************************************");
                    Log.PopLogFolder();
                    logEtape2 = Log.AppendFolder("Étape 2:Dans la section positions ,avancer avec la souris et cocher la premiere transaction, ajouter une note et lancer le retraitement ");
                    var count= Get_WinReprocessParameters_DgvReprocessPositions().WPFObject("RecordListControl", "", 1).Items.Count
                    for (var i = 1; i < count-1; i++){     
                      Get_WinReprocessParameters_DgvReprocessPositions().Keys("[Down]");
                        if(Get_WinReprocessParameters_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).HasItems == true)
                                  {
                                    Get_WinReprocessParameters_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).WaitProperty("Enabled", true, 20000);
                                
                                       var casCheckedInGridTransaction=   Get_WinReprocessParameters_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)                                                                               

//                                 casCheckedInGridTransaction.WaitProperty("IsEnabled", true, 20000);
                                  Delay(2000)
                                  if(casCheckedInGridTransaction.IsChecked == false)
                                   casCheckedInGridTransaction.Click(); 
//                                  casCheckedInGridTransaction.set_IsChecked(true); 
                                    Delay(2000)            
                                   break;
                                  }
 }
                 
                    Get_WinReprocessParameters_TxtNote().Keys(textNoteTCVE2186)
                    Log.Message("Click sur le bouton lancer le traitement")
                    Get_WinReprocessParameters().Parent.Maximize();
                    Get_WinReprocessParameters_BtnStartReprocessing().Click(); 
                    Get_WinReprocessingManager().WaitProperty("VisibleOnScreen", true, 150000);
                  
                    Log.Message("Une nouvelle ligne apparaît dans le gestionnaire de retraitement ")
                    var displayUserName=Get_WinReprocessingManager_DgvReprocessingManager().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.ReprocessUserFullName.OleValue
                    CheckEquals(displayUserName,userNameStep9,"Le nom de l'utilisateur est ");
                      
                   var displayNumberAccount=Get_WinReprocessingManager_DgvReprocessingManager().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.ReprocessAccountNo.OleValue
                   CheckEquals(displayNumberAccount,account800056FS,"Le numéro de compte est ");
                   
                   Get_WinReprocessingManager_DgvReprocessingManager().FindChild("Value", account800056FS, 10).Click();
                   Log.Message("Clic sur le bouton résutat de retraitement")
                   Get_WinUserMultiSelection_BtnReprocessingResult().Click();
                   Log.Message("sur la partie des transactions sélectionnées on a une seule transaction")
                   var countGridSelectTransact=Get_WinReprocessResult_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).Items.Count
                   CheckEquals(countGridSelectTransact,"1","Le nombre d'élément de la grille Transactions sélectionnés")
                   Log.Message("Fermeture de la fenêtre de résultat de retraitement")
                   Get_WinReprocessResult().Close();     
                     
                   

//*********************************************  L'étape 3 ************************************************************");
                    Log.PopLogFolder();
                    logEtape3 = Log.AppendFolder("Étape 3:Refaire l’étape 2 en cochant plus d'un transactions retraitement") 
                    Log.Message("Cliquer sur le bouton lancer un traitement")
                    Get_WinUserMultiSelection_BtnStartReprocessing().Click();
                    Log.Message("Taper le compte 800056-fs")
                    Get_WinReprocessParameters_TxtAccountPicker().Keys(account800056FS);
                    Get_WinReprocessParameters_BtnSearch().Click();
                    Get_WinReprocessParameters_ChkDeleteCorrectiveTransactions().set_IsChecked(true)
                    var count= Get_WinReprocessParameters_DgvReprocessPositions().WPFObject("RecordListControl", "", 1).Items.Count
                    var countTransactionSelect=0;
                    for (var i = 1; i < 15; i++){     
                      Get_WinReprocessParameters_DgvReprocessPositions().Keys("[Down]");
                        if(Get_WinReprocessParameters_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).HasItems == true)
                                  {
                                 Get_WinReprocessParameters_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).WaitProperty("Enabled", true, 20000);
                                  var casCheckedInGridTransaction=  Get_WinReprocessParameters_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)                                                                             
                                   Delay(2000)
                                    if(casCheckedInGridTransaction.IsChecked == false)
                                   casCheckedInGridTransaction.Click();   
                                     Delay(2000)           
                                   countTransactionSelect++;
                                  }
                                  if(countTransactionSelect == 3)
                                  break;
 }
                    Get_WinReprocessParameters_TxtNote().Keys(textNoteTCVE2186)
                    Log.Message("Click sur le bouton lancer le traitement")
                    Get_WinReprocessParameters().Parent.Maximize();
                    Get_WinReprocessParameters_BtnStartReprocessing().Click(); 
                    Get_WinReprocessingManager().WaitProperty("IsVisible", true, 15000);
                    Get_WinReprocessingManager_DgvReprocessingManager().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).Click();
                    Log.Message("Clic sur le bouton résutat de retraitement")
                   Get_WinUserMultiSelection_BtnReprocessingResult().Click();
                   Log.Message("sur la partie des transactions sélectionnées on a une seule transaction")
                   var countGridSelectTransact=Get_WinReprocessResult_DgvReprocessTransactions().WPFObject("RecordListControl", "", 1).Items.Count
                   CheckEquals(countGridSelectTransact,"3","Le nombre d'élément de la grille Transactions sélectionnés")
                   Log.Message("Fermeture de la fenêtre de résultat de retraitement")
                   Get_WinReprocessResult().Close();     
                   
      

         } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 

                    Terminate_CroesusProcess();
                 
                    Execute_SQLQuery("update b_compte set lock_id = null", vServerAccounts)  
                    
          }
}

