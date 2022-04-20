//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6025 
    Description          :  Cette préparation de l`environnement permettra de  s`assurer que les validations  (avant le CR2140) de la fenêtre 
                            d’ordre d’échange pour les comptes UMA et non discrétionnaires (FBNAGILE1-1543) fonctionnent avec le celles du CR2140.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.09.Er-11
    Date                 :  25/02/2019
    
*/


function CR2140_6025_EnvironmentPreparationForNonDiscretionaryUMAValidation() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6025","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            //Mettre la pref PREF_SLEEVE_ALLOW_TRADE = YES  pour le USer utilisé (keyneJ)
            Activate_Inactivate_Pref("KEYNEJ", "PREF_SLEEVE_ALLOW_TRADE", "YES", vServerOrders);
             
            //Mettre la pref PREF_GDO_VALIDATE_ASC_CODE = 2 ASC Code(FBN)  pour le USer utilisé (keyneJ) Cette pref est activé avec le Dump de FBN
            Activate_Inactivate_Pref("KEYNEJ", "PREF_GDO_VALIDATE_ASC_CODE", "2", vServerOrders);
            
            //Mettre la pref PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = R, Y
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TRADE_ACCOUNT_TYPES_EXCLUDED", "R,Y", vServerOrders);
            
            //Activer la PREF_ALLOW_SLEEVE_NONDISC pour pouvoir créer des slééves non discr
            Activate_Inactivate_Pref("KEYNEJ", "PREF_ALLOW_SLEEVE_NONDISC", "YES", vServerOrders);
            
            //Mettre les Prefs et config du CR2070 et CR2141
            Activate_Inactivate_PrefFirm("FIRM_1", "DISCRETIONARY_MODE", 1, vServerOrders);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_DISCRETIONARY_MODE", 1, vServerOrders);
            
            //Rendre AC43 non-discrétionnaire
            Execute_SQLQuery("delete  B_GDO_AVGCOST_ACCOUNT where rep_id = 14", vServerOrders);
            Execute_SQLQuery("update b_rep set is_discretionary = 'N'", vServerOrders);
            Execute_SQLQuery("update b_rep set is_discretionary = 'Y' where no_rep in (select r.no_rep from B_GDO_AVGCOST_ACCOUNT av join b_rep r on r.rep_id = av.rep_id and av.code_type = 'R')", vServerOrders);
            
            //Exécuter le Plugin du CR2070
            ExecuteSSHCommandCFLoader("CR2140", vServerOrders, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");
            
            //Permettre aux modeles Ambassadeurs d'être des sous-modeles
            Execute_SQLQuery("update B_MODEL_TYPE set ALLOW_EDIT_POSITIONS = 'Y',ALLOW_RESTRICTIONS = 'Y', ALLOW_CREATE = 'Y',ALLOW_delete = 'Y',ALLOW_EDIT_INFO = 'Y',ALLOW_SYNC_RULES = 'Y', CAN_BE_SUBMODEL='Y', ALLOW_ASSIGN='Y', ALLOW_SYNC='Y' where MODEL_TYPE_CODE = 'AMBA'", vServerOrders);
            
            //Redemarrer les service
            RestartServices(vServerOrders);
            
            var modelName1Croes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "modelName1Croes_6025", language+client);
            var modelName2Croes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "modelName2Croes_6025", language+client);
            var TypModelCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "TypModelCroes_6025", language+client);
            var AccountNoCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "AccountNoCroes_6025", language+client);
            var LongTermCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "LongTermCroes_6025", language+client);
            var CanadianEquityCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "CanadianEquityCroes_6025", language+client);
            var MinPercent1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "MinPercent1", language+client);
            var TargetPercent1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "TargetPercent1", language+client);
            var MaxPercent1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "MaxPercent1", language+client);
            var MinPercent2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "MinPercent2", language+client);
            var TargetPercent2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "TargetPercent2", language+client);
            var MaxPercent2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "MaxPercent2", language+client);
            
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Créer deux modèles Ambassadeurs s'ils ne le sont pas
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            Get_MainWindow().Maximize(); 
            CreateModelIfNotExist(modelName1Croes_6025, TypModelCroes_6025);
            CreateModelIfNotExist(modelName2Croes_6025, TypModelCroes_6025);
            
            //Assigner les 2 modèles à ces segments
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 50000);  
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            Search_Account(AccountNoCroes_6025);
            Get_RelationshipsClientsAccountsGrid().Find("Value",AccountNoCroes_6025,10).Click();
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
            
            //Sélectionner les classes Long terme et Actions canadiennes
            var Grid = Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("_assetMixgrid").WPFObject("RecordListControl", "", 1);
  
            Grid.FindChild("Value", LongTermCroes_6025, 10).Click(-1, -1, skCtrl);
            Grid.FindChild("Value", CanadianEquityCroes_6025, 10).Click(-1, -1, skCtrl);
            Grid.FindChild("Value", CanadianEquityCroes_6025, 10).ClickR();
            Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
            WaitObject(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
            
            //Modifier les segments des deux classes
            EditSleeve(LongTermCroes_6025, MinPercent1, TargetPercent1, MaxPercent1, modelName1Croes_6025);
            EditSleeve(CanadianEquityCroes_6025, MinPercent2, TargetPercent2, MaxPercent2, modelName2Croes_6025);
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
            
            //Validation que les deux segments sont créé et que la somme des %cible est 100
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(), "Uid", "SleevesManagerWindow_fbcd");
            if (language == "french") var sleevesGrid = Get_WinManagerSleeves().WPFObject("GroupBox", "Segments", 1).WPFObject("_sleevesGrid").WPFObject("RecordListControl", "", 1);
            else var sleevesGrid = Get_WinManagerSleeves().WPFObject("GroupBox", "Sleeves", 1).WPFObject("_sleevesGrid").WPFObject("RecordListControl", "", 1)
            var count = sleevesGrid.Items.Count;
            var totalTarget = 0;
            for (i=1;i<count;i++)
            {
                var item = sleevesGrid.Items.Item(i).DataItem;
                if (i==1)  CheckSleeves(item,LongTermCroes_6025,MinPercent1,TargetPercent1,MaxPercent1,modelName1Croes_6025);
                else       CheckSleeves(item,CanadianEquityCroes_6025,MinPercent2,TargetPercent2,MaxPercent2,modelName2Croes_6025);
                totalTarget = totalTarget + item.Ratio;
            }
            Log.Message("Le total des deux %cible est: "+totalTarget);
            if (totalTarget == 100) Log.Checkpoint("Le total des deux %cible est 100%");
            else Log.Error("Le total des deux %cible doit être 100%");
             
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          
      }
      finally {
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}
 
 function CreateModelIfNotExist(modelName,type){
    SearchModelByName(modelName)
    if(Get_ModelsGrid().Find("Value",modelName,10).Exists){
        Log.Message("Le modèle est déjà existe");
    }else{
        Create_Model(modelName,type);
    }
 }
 
 function CheckSleeves(item,description,Min,Target,Max,Model){
      aqObject.CheckProperty(item, "description", cmpEqual,description);
      aqObject.CheckProperty(item, "LowerTolerance", cmpEqual,Min);
      aqObject.CheckProperty(item, "Ratio", cmpEqual,Target);
      aqObject.CheckProperty(item, "UpperTolerance", cmpEqual,Max);
      aqObject.CheckProperty(item, "ModelName", cmpEqual,Model);
   }
    
 function EditSleeve(Description,MinPercent, TargetPercent, MaxPercent, ModelName){
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().FindChild("Value",Description,10).Click();
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().WaitProperty("Enabled", true, 30000);
        if (Get_WinManagerSleeves_GrpSleeves_BtnEdit().Enabled == false)
             Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        WaitObject(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
        Get_WinEditSleeve_TxtMinPercent().set_Text(MinPercent);
        Get_WinEditSleeve_TxtTargerPercent().set_Text(TargetPercent);
        Get_WinEditSleeve_TxtMaxPercent().set_Text(MaxPercent);
        Get_WinEditSleeve_TxtValueTextBox().set_Text("AMB");
        Get_WinEditSleeve_TxtValueTextBox().Keys("[Tab]");
        if (Get_SubMenus().Exists){
          Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).Find("Value", ModelName, 10).DblClick();
        }
        Get_WinEditSleeve_BtOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleeveWindow_e60f");
 }