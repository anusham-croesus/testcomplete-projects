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


function CR1487_TCVE_2185_ReprocessAccountInDebugModeWithoutCorrectionTransaction() {
         
          try {
              
                    Log.Link("https://jira.croesus.com/browse/TCVE-2185","Lien du Cas de test");
                    Log.Link("https://jira.croesus.com/browse/TCVE-2189", "Lien de la story"); 
                   
                    
                    var userNameLoader                       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LOADER", "username");
                    var passwordLoader                       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LOADER", "psw");
                    var textDebug                            = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textDebug", language+client);
                    var textDev                              = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textDev", language+client);
                    var textOpenFolder                       = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textOpenFolder", language+client);
                    var textShowGdoTool                      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textShowGdoTool", language+client);
                    var textShowInvestigationTools           = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textShowInvestigationTools", language+client);
                    var textReprocessingManager              = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textReprocessingManager", language+client);
                    var textReprocessParameters              = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "textReprocessParameters", language+client);
                    var account300014NA                      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "account300014NA", language+client);
                    var expectednbrElementTableBStatis       = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "expectednbrElementTableBStatis", language+client);
                    var expectednbrElementTableBLot          = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "expectednbrElementTableBLot", language+client);
                    var valueCP                              = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "valueCP", language+client);
                    var CodeCpBD88                           = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "CodeCpBD88", language+client);
                    var nbreElementTableStep6                = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "nbreElementTableStep6", language+client);
                    var nbrPositionsStep8                    = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "nbrPositionsStep8", language+client);
                    var countGridStep9                       = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "countGridStep9", language+client);
                    var userNameStep9                        = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "userNameStep9", language+client);
                    var accountAsOfStep9                     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "accountAsOfStep9", language+client);
                    var titleWinReprocessingResult           = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "titleWinReprocessingResult", language+client);
                    var noteStep9                            = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1487", "noteStep9", language+client);
                    
//*********************************************  L'étape 1 ************************************************************");
                    Log.PopLogFolder();
                    logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec l'utilisateur Loader ( croesus )");
                    Log.Message("Se connecter avec l'utilisateur Loader")
                    Login(vServerAccounts, userNameLoader ,passwordLoader,language);
                    Log.Message("Le mode debug s'affiche")
                    
                    aqObject.CheckProperty(Get_MenuBar_Debug(), "VisibleOnScreen", cmpEqual, true);
                    aqObject.CheckProperty(Get_MenuBar_Debug(), "WPFControlText", cmpEqual, textDebug);
                        
//*********************************************  L'étape 2 ************************************************************");  
                    Log.PopLogFolder();                  
                    logEtape2 = Log.AppendFolder("Étape 2: Cliquer sur debug");  
                    Get_MenuBar_Debug().OpenMenu();
                    Log.Message("Une liste d'option  va s'afficher")
                   
                    Log.Message("Il y a une anomalie dans le text de la liste affichée. Le ext est en anglais même si on est connecté en français d'aprés Karima Me il faut ignorer ces erreurs pour le moments")
                    
                    Log.Message("Points de vérifications pour l'option Dev")
                    aqObject.CheckProperty(Get_MenuBar_Debug_Dev(), "VisibleOnScreen", cmpEqual, true);
                    Log.Message("Le menu Dev a le Même UID que le menu open folder")
                    aqObject.CheckProperty(Get_MenuBar_Debug_Dev(), "WPFControlText", cmpEqual, textDev);
                    
                    
                    Log.Message("Points de vérifications pour l'option Open Folder")
                    aqObject.CheckProperty(Get_MenuBar_Debug_OpenFolder(), "VisibleOnScreen", cmpEqual, true);
                    aqObject.CheckProperty(Get_MenuBar_Debug_OpenFolder(), "WPFControlText", cmpEqual, textOpenFolder);
                    
                    Log.Message("Points de vérifications pour l'option Show Gdo Tool")
                    aqObject.CheckProperty(Get_MenuBar_Debug_ShowGdoTool(), "VisibleOnScreen", cmpEqual, true);
                    aqObject.CheckProperty(Get_MenuBar_Debug_ShowGdoTool(), "WPFControlText", cmpEqual, textShowGdoTool);
                         
                    Log.Message("Points de vérifications pour l'option Show Investigation Tools")
                    aqObject.CheckProperty(Get_MenuBar_Debug_ShowInvestigationTools(), "VisibleOnScreen", cmpEqual, true);
                    aqObject.CheckProperty(Get_MenuBar_Debug_ShowInvestigationTools(), "WPFControlText", cmpEqual, textShowInvestigationTools);
                    
                    
                    Log.Message("Points de vérifications pour l'option Show Investigation Tools")
                    aqObject.CheckProperty(Get_MenuBar_Debug_ReprocessingManager(), "VisibleOnScreen", cmpEqual, true);
                    aqObject.CheckProperty(Get_MenuBar_Debug_ReprocessingManager(), "WPFControlText", cmpEqual, textReprocessingManager);

//*********************************************  L'étape 3 ************************************************************");
                    Log.PopLogFolder();
                    logEtape3 = Log.AppendFolder("Étape 3: Sélectionner l'option Gestionnaire de retraitement");
                    Log.Message("Sélectionner l'option Gestionnaire de retraitement")
                    Get_MenuBar_Debug_ReprocessingManager().Click();
                    Log.Message("La fenêtre Gestionnaire de retraitement va s'afficher")
                    aqObject.CheckProperty(Get_WinReprocessingManager(), "Title", cmpEqual, textReprocessingManager);

//*********************************************  L'étape 4 ************************************************************");
                    Log.PopLogFolder();
                    logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur  Lancer retraitement");
                    Get_WinUserMultiSelection_BtnStartReprocessing().Click();
                    Log.Message("La fenêtre paramètre  de retraitement sva s'afficher")
                    aqObject.CheckProperty(Get_WinReprocessParameters(), "Title", cmpEqual, textReprocessParameters);


//*********************************************  L'étape 5 ************************************************************");
                    Log.PopLogFolder();
                    logEtape5 = Log.AppendFolder("Étape 5: Se connecter dans la bd  pour effecer blot et b_statis du compte 300014_na select * from b_lot where no_compte='300014-na'select * from b_statis where no_compte='300014-na'");

                    var nbrElementTableBLot= Execute_SQLQuery_GetFieldAllValues("select * from b_lot where no_compte ='300014-NA'",vServerAccounts, "LOT_ID" )
                    Delay(2000)
                    Log.Message(nbrElementTableBLot.length);
                    CheckEquals(nbrElementTableBLot.length,expectednbrElementTableBLot,"Le nombre d'élément de la table b_lot ")
   
                    var nbrElementTableBStatis= Execute_SQLQuery_GetFieldAllValues("select * from b_statis where no_compte ='300014-NA'",vServerAccounts, "NO_COMPTE" )
                    Log.Message(nbrElementTableBStatis.length);
                    CheckEquals(nbrElementTableBStatis.length,expectednbrElementTableBStatis,"Le nombre d'élément de la table b_lot ")

//*********************************************  L'étape 6 ************************************************************");
                    Log.PopLogFolder();
                    logEtape6 = Log.AppendFolder("Étape 6: delete from b_lot where no_compte='300014-na'delete from b_statis where no_compte='300014-na'");
                    Execute_SQLQuery("delete from b_lot where no_compte='300014-na' ",vServerAccounts);
                    Execute_SQLQuery("delete from b_statis where no_compte='300014-na' ",vServerAccounts);
                    Log.Message("Les deux tables  :b_lot et b_statis sont vides")
                    
                    var nbrElementTableBLot= Execute_SQLQuery_GetFieldAllValues("select * from b_lot where no_compte ='300014-NA'",vServerAccounts, "LOT_ID" )
                    Log.Message(nbrElementTableBLot.length);
                    CheckEquals(nbrElementTableBLot.length,nbreElementTableStep6,"Le nombre d'élément de la table b_lot ")
              
                    var nbrElementTableBStatis= Execute_SQLQuery_GetFieldAllValues("select * from b_statis where no_compte ='300014-NA'",vServerAccounts, "NO_COMPTE" )
                    Log.Message(nbrElementTableBStatis.length);
                    CheckEquals(nbrElementTableBStatis.length,nbreElementTableStep6,"Le nombre d'élément de la table b_lot ")

//*********************************************  L'étape 7 ************************************************************");
                    Log.PopLogFolder();
                    logEtape7 = Log.AppendFolder("Étape 7: Dans la fenêtre paramètre de retraitement, section numéro de compte Sélection l'option code CP et taper BD88");
                    Get_WinReprocessParameters_CmbAccountNumberTypePicker().Click();
                    Aliases.CroesusApp.subMenus.Find("WPFControlText",valueCP,10).Click();
                    Get_WinReprocessParameters_TxtAccountPicker().Keys(CodeCpBD88);
                    Get_WinReprocessParameters_BtnSearch().Click();
                    Log.Message("Il faut ajouter les points de vérifications pour :Seuls les comptes dont le code CP88 vont s'afficher")
                    var count = Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).Items.count
                    for (var i = 1; i < 25; i++){
                       var codeCp=Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.RepresentativeNumber.OleValue
                       CheckEquals(codeCp,CodeCpBD88,"Le nombre d'élément de la table b_lot ")

                       }



//*********************************************  L'étape 8 ************************************************************");
                    Log.PopLogFolder();
                    logEtape8 = Log.AppendFolder("Étape 8: Sélectionner le compte 300014-Na");
                     if(Get_SubMenus().Exists){
                      Get_SubMenus().FindChild("Value",account300014NA,10).DblClick();
                    }
                    var count =Get_WinReprocessParameters_DgvReprocessPositions().WPFObject("RecordListControl", "", 1).Items.Count;
                    Log.Message("Positions du compte  300014-Na  s'affichent  ( 11 positions)")
                    CheckEquals(count,nbrPositionsStep8,"Le nombre d'élément de la grille positions est ");
                    for (var i = 0; i < 11; i++){
                          Log.Message("La position numéro "+i)
                          var accountDispayInGrid=Get_WinReprocessParameters_DgvReprocessPositions().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber;
                          CheckEquals(accountDispayInGrid,account300014NA,"Le numéro de compte affichée  ");
                                                   }

                    Log.Message("la date de traitement par défaut est la date de la premiere transaction")
                    var displayReprocessiongDate=Get_WinReprocessParameters_DtpValueReprocessingDate().DataContext.ReprocessDate.OleValue;
                    var displaydatFirstTrans=Get_WinReprocessParameters_DgvReprocessPositions().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.PositionAsOf.OleValue
                    CheckEquals(VarToString(displayReprocessiongDate),VarToString(displaydatFirstTrans),"la date de traitement par défaut  ");
                    
                     


//*********************************************  L'étape 9 ************************************************************");
                    Log.PopLogFolder();
                    logEtape9 = Log.AppendFolder("Étape 9:Dans la section Note. Ajouter par exemple : Retraitement du compte 300014.Cliquer sur le bouton retraitement du compte");
                    Get_WinReprocessParameters_TxtNote().Keys(noteStep9)
                    Log.Message("Click sur le bouton lancer le traitement")
                    Get_WinReprocessParameters_BtnStartReprocessing().Click(); 
                    if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);
                }
                     Get_WinReprocessingManager().WaitProperty("IsVisible", true, 15000);
                    Get_WinReprocessingManager().WaitProperty("VisibleOnScreen", true, 20000); 
                    var countGridReprocessingManager= Get_WinReprocessingManager_DgvReprocessingManager().WPFObject("RecordListControl", "", 1).Items.Count
                    Log.Message(countGridReprocessingManager);
                    CheckEquals(countGridReprocessingManager,countGridStep9,"le nombre des éléments de la grille est");
                     var displayUserName=Get_WinReprocessingManager_DgvReprocessingManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReprocessUserFullName.OleValue
                     CheckEquals(displayUserName,userNameStep9,"Le nom de l'utilisateur est ");
                      
                     var displayAccountAsOf=Get_WinReprocessingManager_DgvReprocessingManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReprocessSpecifiedDate.OleValue
                     CheckEquals(VarToString(displayAccountAsOf),VarToString(accountAsOfStep9),"Compte en date du est ");
                     
                     var displayNumberAccount=Get_WinReprocessingManager_DgvReprocessingManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ReprocessAccountNo.OleValue
                     CheckEquals(displayNumberAccount,account300014NA,"Le numéro de compte est ");
                     
                   
                    

//*********************************************  L'étape 10 ************************************************************");
                    Log.PopLogFolder();
                    logEtape10 = Log.AppendFolder("Étape 10:Cliquer sur Résultat du retraitement");
      
                    Get_WinUserMultiSelection_BtnReprocessingResult().Click();
                    if(Get_DlgConfirmation().Exists){
                                  var width = Get_DlgConfirmation().Get_Width();
                                  Get_DlgConfirmation().Click((width*(1/3)),73);
                              }
                     Log.Message("La fenêtre de résultat de retraitement va s'afficher")                 
                     aqObject.CheckProperty(Get_WinReprocessResult(), "Title", cmpEqual, titleWinReprocessingResult);
                     
                   


//*********************************************  L'étape 11 ************************************************************");
                    Log.PopLogFolder();
                    logEtape11 = Log.AppendFolder("Étape 11:Faire select   dans la bd pour S'assurer que les deux tables b_statis et b_lots sont bien populés.select * from b_lot where no_compte='300014-na'.select * from b_statis where no_compte='300014-na'");

                     var nbrElementTableBLot= Execute_SQLQuery_GetFieldAllValues("select * from b_lot where no_compte ='300014-NA'",vServerAccounts, "LOT_ID" )
                     Log.Message(nbrElementTableBLot.length);
                     CheckEquals(nbrElementTableBLot.length,expectednbrElementTableBLot,"Le nombre d'élément de la table b_lot ")
   
                     var nbrElementTableBStatis= Execute_SQLQuery_GetFieldAllValues("select * from b_statis where no_compte ='300014-NA'",vServerAccounts, "NO_COMPTE" )
                     Log.Message(nbrElementTableBStatis.length);
                     CheckEquals(nbrElementTableBStatis.length,expectednbrElementTableBStatis,"Le nombre d'élément de la table b_lot ")





         } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 

                    Terminate_CroesusProcess();
                 
                    Execute_SQLQuery("update b_compte set lock_id = null", vServerAccounts)  
                    
          }
}


