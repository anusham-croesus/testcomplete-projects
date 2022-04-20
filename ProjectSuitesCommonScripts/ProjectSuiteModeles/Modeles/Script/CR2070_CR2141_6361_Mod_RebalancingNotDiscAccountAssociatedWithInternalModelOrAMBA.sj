//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6361 
    Description          :  FCT.12 - Validation lors du rééquilibrage d'un compte
                            5.2 - Déterminer la disponibilité des destinations de la génération des ordres (étape 5)

                            Le but de ce cas est de
                            - Valider le rééquilibrage d'un compte non discrétionnaire associé à un modèle interne ou à gestion déléguée
                            - Valider la logique de rééquilibrage lorsqu'on change le statut des assignés 
                            - Valider que seulement les ordres sur des assignés disc associés à modèle interne sont envoyés dans GDO croesus
                            - Valider que le statut de tous les assignés disc ou non disc est discrétionnaire lorsqu'ils sont associés à modèle à 
                              gestion déléguée et les ordres sur tous les assignés peuvent être envoyer à GDO croesus.
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  10/05/2019
    
*/


function CR2070_CR2141_6361_Mod_RebalancingNotDiscAccountAssociatedWithInternalModelOrAMBA() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6361","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6361", language+client);
            var accountNo1_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo1_6361", language+client);
            var accountNo2_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo2_6361", language+client);
            var accountNo3_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo3_6361", language+client);
            var clientNo_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo_6361", language+client);
            var option1_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option1_6361", language+client);
            var option2_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option2_6361", language+client);
            var discHeaderStep2_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discHeaderStep2_6349", language+client);
            var nonDicsHeaderStep2_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "nonDicsHeaderStep2_6349", language+client);
            var msgWarning_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "msgWarning_6361", language+client);
            
            var modelNameAMBA1_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var option3_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option3_6361", language+client);
            var option4_6361 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option4_6361", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            Log.Message("-------- Associer le compte"+accountNo1_6361+" au modèle "+modelName_6361+" ----------");
            AssociateAccountWithModel(modelName_6361, accountNo1_6361); 
            Log.Message("-------- Associer le compte"+accountNo2_6361+" au modèle "+modelName_6361+" ----------");
            AssociateAccountWithModel(modelName_6361, accountNo2_6361); 
            Log.Message("-------- Associer le compte"+accountNo3_6361+" au modèle "+modelName_6361+" ----------");
            AssociateAccountWithModel(modelName_6361, accountNo3_6361); 
            
            Log.Message("-------- Associer le client"+clientNo_6361+" au modèle "+modelName_6361+" ----------");
            AssociateClientWithModel(modelName_6361, clientNo_6361);
            
            //Sélectionner le compte 800027-FS et rééquilibrer
            Get_Models_Details_DgvDetails().Find("Value",accountNo1_6361,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().WaitProperty("IsEnabled", true, 30000)
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            
            //Points de vérication à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option1_6361); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option2_6361); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, false); 
            
            //Aller à l'étape 2 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 2 de rééquilibrage sans changer de sélection 'Discrétionnaires coché' ----------------------");
            Get_WinRebalance_BtnNext().Click(); 
            //Points de vérification à l'étape 2 de rééquilibrage
            Log.Message("------------- Points de vérification à l'étape 2 ------------------");
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, discHeaderStep2_6361);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsChecked", cmpEqual, false);
            var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
            aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 1), "IsSelected", cmpEqual, true);
            aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 2), "IsSelected", cmpEqual, false);
            var count = grid.Items.Count;
            aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 2);
            for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.AccountNumber == accountNo1_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo1_6361+" existe dans la grille "+discHeaderStep2_6361);
                else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo3_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo3_6361+" existe dans la grille "+discHeaderStep2_6361);  
                   else
                      Log.Error("L'un des 2 comptes ("+accountNo1_6361+", "+accountNo3_6361+") n'existe pas dans la grille "+discHeaderStep2_6361);
            }
           
            //Aller à l'étape 4 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 4 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();  
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
            
            //Points de vérification à l'étape 4 de rééquilibrage
            Log.Message("------------- Points de vérification à l'étape 4 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","DataGrid_d123",10).WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem,"AccountNumber", cmpEqual, accountNo1_6361);
            //Valider que la grille des ordres proposés n'est pas vide
            if (Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1).HasItems)
                Log.Checkpoint("La grille des ordres proposés n'est pas vide");
            else 
                Log.Error("La grille des ordres proposés est vide, elle ne doit pas être vide");
            
            
            //Retourner à l'étape 1
            Log.Message("---------- Retourner à l'étape 1 et activer le radio bouton Non discrétionnaires ---------");
            Get_WinRebalance_BtnPrevious().Click();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click()
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            Get_WinRebalance_BtnPrevious().Click();
            Get_WinRebalance_BtnPrevious().Click();
            
            //Cocher Non discrétionnaire
            Get_WinRebalance().Find("Uid","RadioButton_823c",10).set_IsChecked(true); 
            //Aller à l'étape2
           Log.Message("-------------- Aller à l'étape 3 après changement de sélection 'Non discrétionnaires coché' ----------------------");
           Get_WinRebalance_BtnNext().Click();
           Get_WinRebalance_BtnNext().Click();
           //Valider le message d'avertissement affiché
           aqObject.CheckProperty(Get_DlgWarning().Find(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",1],10),"Text", cmpEqual, msgWarning_6361);
           Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2,Get_DlgWarning().get_ActualHeight()/2);
           
           //Points de vérification à l'étape 2 de rééquilibrage
           Log.Message("------------- Points de vérification à l'étape 2 ------------------"); 
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, nonDicsHeaderStep2_6361);
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsChecked", cmpEqual, false);
           var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
           aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 1), "IsSelected", cmpEqual, false);
           aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 2), "IsSelected", cmpEqual, false);
           var count = grid.Items.Count;
           aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 2);
          for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.AccountNumber == accountNo2_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo2_6361+" existe dans la grille "+nonDicsHeaderStep2_6361);
                else if (grid.Items.Item(i).DataItem.ClientNumber == clientNo_6361) 
                   Log.Checkpoint("Le client numéro "+clientNo_6361+" existe dans la grille "+nonDicsHeaderStep2_6361);  
                   else
                      Log.Error("Le client ou le compte ("+accountNo2_6361+", "+clientNo_6361+") n'existe pas dans la grille "+nonDicsHeaderStep2_6361);
           }
           
           //Cliquer sur le bouton Sélectionner tout
           Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().Click();
           //Aller à l'étape 4 de rééquilibrage
           Log.Message("-------------- Aller à l'étape 4 de rééquilibrage ----------------------");
           Get_WinRebalance_BtnNext().Click();
           Get_WinRebalance_BtnNext().Click();  
           if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
           }  
           WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
           
           //Points de vérification à l'étape 4 de rééquilibrage
           Log.Message("------------- Points de vérification à l'étape 4 ------------------");
           var grid = Get_WinRebalance().Find("Uid","DataGrid_d123",10).WPFObject("RecordListControl", "", 1);
           var count = grid.Items.Count;
           for (i=0; i<count; i++){
              if (grid.Items.Item(i).DataItem.AccountNumber == accountNo2_6361 )
                 Log.Checkpoint("Le compte numéro "+accountNo2_6361+" existe dans la liste des portefeuilles projetés");
              else if (grid.Items.Item(i).DataItem.ClientNumber == clientNo_6361)
                      Log.Checkpoint("Le client numéro "+clientNo_6361+" existe dans la liste des portefeuilles projetés");
                   else
                      Log.Error("Le client numéro "+clientNo_6361+" ou le compte numéro "+accountNo2_6361+" n'existe pas dans la liste des portefeuilles projetés");
           }
           //Valider que la grille des ordres proposés n'est pas vide
           if (Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1).HasItems)
                Log.Checkpoint("La grille des ordres proposés n'est pas vide");
           else 
                Log.Error("La grille des ordres proposés est vide, elle ne doit pas être vide");
            
           
           //Aller à l'étape 5 
           Log.Message("-------------- Aller à l'étape 5 de rééquilibrage ----------------------");
           Get_WinRebalance_BtnNext().Click(); 
           Get_WinRebalance_BtnGenerate().Click(); 
           WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad");
           Get_WinGenerateOrders_GrpMode_ChkGeneratedOrders().set_IsChecked(true);
           Get_WinGenerateOrders_GrpPDF_ChkProjectedPortfolio().set_IsChecked(true);
           Get_WinGenerateOrders_BtnGenerate().WaitProperty("IsEnabled", true, 10000);
           if (Get_WinGenerateOrders_BtnGenerate().IsEnabled == false) 
               Get_WinGenerateOrders_BtnGenerate().Click();
           Get_WinGenerateOrders_BtnGenerate().Click();
           WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");
           
           //Valider que le fichier PDF est généré
            Log.Message("---------- Valider que le PDF est généré ----------------");
            Delay(30000);
//            Sys.FindChild("ProcessName", GetAcrobatProcessName(), 10).WaitWindow("AcrobatSDIWindow", "*", 1, 200000); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
//            aqObject.CheckProperty(Sys.FindChild("WndClass", "AcrobatSDIWindow", 10), "Visible", cmpEqual, true);
//            TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
            
            Sys.WaitProcess(GetAcrobatProcessName(), PROJECT_AUTO_WAIT_TIMEOUT / 2).WaitWindow("AcrobatSDIWindow", "*", 1, 200000); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
            aqObject.CheckProperty(Sys.FindChild("WndClass", "AcrobatSDIWindow", 10), "Visible", cmpEqual, true);
            TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
   
           
           //Retirer les 3 comptes et le client du modèle
           Log.Message("-------- Retirer les comptes "+accountNo1_6361+", "+accountNo2_6361+", "+accountNo3_6361+", le client "+clientNo_6361+" du modèle "+modelName_6361);
           RemoveRelationshipClientAccountFromModel(modelName_6361,accountNo1_6361);
           RemoveRelationshipClientAccountFromModel(modelName_6361,accountNo2_6361);
           RemoveRelationshipClientAccountFromModel(modelName_6361,accountNo3_6361);
           RemoveRelationshipClientAccountFromModel(modelName_6361,clientNo_6361);
           
           //Associer les 3 comptes et le client au modèle ambassadeur
           Log.Message("-------- Associer le compte"+accountNo1_6361+" au modèle "+modelNameAMBA1_6361+" ----------");
           AssociateAccountWithModel(modelNameAMBA1_6361, accountNo1_6361); 
           Log.Message("-------- Associer le compte"+accountNo2_6361+" au modèle "+modelNameAMBA1_6361+" ----------");
           AssociateAccountWithModel(modelNameAMBA1_6361, accountNo2_6361); 
           Log.Message("-------- Associer le compte"+accountNo3_6361+" au modèle "+modelNameAMBA1_6361+" ----------");
           AssociateAccountWithModel(modelNameAMBA1_6361, accountNo3_6361); 
            
           Log.Message("-------- Associer le client"+clientNo_6361+" au modèle "+modelNameAMBA1_6361+" ----------");
           AssociateClientWithModel(modelNameAMBA1_6361, clientNo_6361);
           
           Get_Toolbar_BtnRebalance().Click()
           Get_WinRebalance().Parent.Maximize(); 
           
           //Points de vérication à l'étape1
           Log.Message("------------- Points de vérification à l'étape 1 ------------------");
           aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option3_6361); 
           aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option4_6361); 
           aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
           aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, false); 
           aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 
           aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, false); 
          
           //Aller à l'étape 2 de rééquilibrage
           Log.Message("-------------- Aller à l'étape 2 de rééquilibrage sans changer de sélection 'Discrétionnaires coché' ----------------------");
           Get_WinRebalance_BtnNext().Click(); 
           
           //Points de vérification à l'étape 2 de rééquilibrage
           Log.Message("------------- Points de vérification à l'étape 2 ------------------");
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, discHeaderStep2_6361);
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsChecked", cmpEqual, true);
           var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
           aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 1), "IsSelected", cmpEqual, true);
           aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 2), "IsSelected", cmpEqual, true);
           var count = grid.Items.Count;
           aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 4);
           for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.AccountNumber == accountNo1_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo1_6361+" existe dans la grille "+discHeaderStep2_6361);
                else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo3_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo3_6361+" existe dans la grille "+discHeaderStep2_6361);  
                else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo2_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo2_6361+" existe dans la grille "+discHeaderStep2_6361);  
                else if (grid.Items.Item(i).DataItem.ClientNumber == clientNo_6361) 
                   Log.Checkpoint("Le client numéro "+clientNo_6361+" existe dans la grille "+discHeaderStep2_6361);  
                else
                   Log.Error("L'un des 4 Assignés ("+accountNo1_6361+", "+accountNo3_6361+", "+clientNo_6361+", "+accountNo2_6361+") n'existe pas dans la grille "+discHeaderStep2_6361);
           }
           //Aller à l'étape 4 de rééquilibrage
           Log.Message("-------------- Aller à l'étape 4 de rééquilibrage ----------------------");
           Get_WinRebalance_BtnNext().Click();
           Get_WinRebalance_BtnNext().Click();  
           if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
           }  
           WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
           
           //Points de vérification à l'étape 4 de rééquilibrage
           Log.Message("------------- Points de vérification à l'étape 4 ------------------");
           var grid = Get_WinRebalance().Find("Uid","DataGrid_d123",10).WPFObject("RecordListControl", "", 1);
           var count = grid.Items.Count;
            for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.AccountNumber == accountNo1_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo1_6361+" existe dans la grille "+discHeaderStep2_6361);
                else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo3_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo3_6361+" existe dans la grille "+discHeaderStep2_6361);  
                else if (grid.Items.Item(i).DataItem.AccountNumber == accountNo2_6361) 
                   Log.Checkpoint("Le compte numéro "+accountNo2_6361+" existe dans la grille "+discHeaderStep2_6361);  
                else if (grid.Items.Item(i).DataItem.ClientNumber == clientNo_6361) 
                   Log.Checkpoint("Le client numéro "+clientNo_6361+" existe dans la grille "+discHeaderStep2_6361);  
                else
                   Log.Error("L'un des 4 Assignés ("+accountNo1_6361+", "+accountNo3_6361+", "+clientNo_6361+", "+accountNo2_6361+") n'existe pas dans la grille "+discHeaderStep2_6361);
           }
           //Valider que la grille des ordres proposés n'est pas vide
           if (Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1).HasItems)
                Log.Checkpoint("La grille des ordres proposés n'est pas vide");
           else 
                Log.Error("La grille des ordres proposés est vide, elle ne doit pas être vide"); 
           
           //Aller à l'étape 5 
           Log.Message("-------------- Aller à l'étape 5 de rééquilibrage ----------------------");
           Get_WinRebalance_BtnNext().Click(); 
           Get_WinRebalance_BtnGenerate().Click(); 
           WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad");
           Get_WinGenerateOrders_BtnGenerate().Click();
           if (Get_DlgConfirmation().Exists)
               Get_DlgConfirmation().Click(Get_DlgConfirmation().Get_Width()*(2/3),73);
           Log.Message("------ Vérifier que l'application se dirige vers le module Ordres ----------------");
           aqObject.CheckProperty(Get_ModulesBar_BtnOrders(),"IsChecked", cmpEqual, true); 
           
           //Aller au module Modèle et enlever les comptes associés au modèle ambassadeur
           Get_ModulesBar_BtnModels().Click();
           Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           //Retirer les 3 comptes et le client du modèle
           Log.Message("-------- Retirer les comptes "+accountNo1_6361+", "+accountNo2_6361+", "+accountNo3_6361+", le client "+clientNo_6361+" du modèle "+modelNameAMBA1_6361);
           RemoveRelationshipClientAccountFromModel(modelNameAMBA1_6361,accountNo1_6361);
           RemoveRelationshipClientAccountFromModel(modelNameAMBA1_6361,accountNo2_6361);
           RemoveRelationshipClientAccountFromModel(modelNameAMBA1_6361,accountNo3_6361);
           RemoveRelationshipClientAccountFromModel(modelNameAMBA1_6361,clientNo_6361);
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

