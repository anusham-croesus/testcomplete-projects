//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6349 
    Description          :  - valider la colonne Dsicrétionnaire de l'onglet Portefeuilles associés (CR2070)
                            CR2141 
                            -  Valider le radio button
                            - Valider le nombre d'assignés discrétionnaire et non discrétionnaire affiché à étape 1 du rééquilibrage
                            - Les assignés sélectionnés à l'étape 2 du rééquilibrage
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  09/05/2019
    
*/


function CR2070_CR2141_6349_Mod_ValidateNewParameter_AssignedDiscretionaryOrNotDiscretionary() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6349","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6349", language+client);
            var relationName_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName1_6348", language+client);
            var IACode_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "IACode_6348", language+client);
            var clientNo1_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo1_6349", language+client);
            var clientNo2_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "clientNo2_6349", language+client);
            var accountNo_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo_6349", language+client);
            var discretionaryLabel = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discretionaryLabel", language+client);
            var option1_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option1_6349", language+client);
            var option2_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option2_6349", language+client);
            var discHeaderStep2_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discHeaderStep2_6349", language+client);
            var nonDicsHeaderStep2_6349 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "nonDicsHeaderStep2_6349", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            
            Log.Message("-------- Associer la relation"+relationName_6349+" au modèle "+modelName_6349+" ----------");
            AssociateRelationshipWithModel(modelName_6349, relationName_6349);
            Log.Message("-------- Associer le client"+clientNo1_6349+" au modèle "+modelName_6349+" ----------");
            AssociateClientWithModel(modelName_6349, clientNo1_6349);
            Log.Message("-------- Associer le client"+clientNo2_6349+" au modèle "+modelName_6349+" ----------");
            AssociateClientWithModel(modelName_6349, clientNo2_6349);
            Log.Message("-------- Associer le compte"+accountNo_6349+" au modèle "+modelName_6349+" ----------");
            AssociateAccountWithModel(modelName_6349, accountNo_6349);
            
            //Ajouter la colonne "Discrétionnaire" dans la grille Portefeuilles associés
            Log.Message("-------- Ajouter la colonne 'Discrétionnaire' dans la grille Portefeuilles associés ------------- ");
            Add_ColumnByLabel(Get_Models_Details_TabAssignedPortfolios_ChTotalValue(), discretionaryLabel);
            
            //Vérifier qu il ya pas de crochet pour le compte 800066-GT
            Log.Message("-------- Vérifier qu il n ya pas de crochet pour le compte "+accountNo_6349+" et le client "+clientNo2_6349+" ---------");
            Log.Message("-------- Vérifier qu il ya de crochet pour la relation "+relationName_6349+" et le client "+clientNo1_6349+" ---------");
            var grid = Get_ModelsPlugin().WPFObject("_bottomGroupBox").WPFObject("_tabCtrl").WPFObject("assignedListView").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
               if (grid.Items.Item(i).DataItem.AccountNumber == accountNo_6349 || grid.Items.Item(i).DataItem.ClientNumber == clientNo2_6349 ){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, false); 
                }
                if (grid.Items.Item(i).DataItem.ShortName == relationName_6349 || grid.Items.Item(i).DataItem.ClientNumber == clientNo1_6349 ){
                  aqObject.CheckProperty(grid.Items.Item(i).DataItem, "IsDiscretionary", cmpEqual, true); 
                }      
            }
            
            //Réquilibrer le modèle sans faire de sélection de portefeuille
            Log.Message("----------- Réquilibrer le modèle sans faire de sélection de portefeuille ---------------------");
            Get_ModulesBar_BtnModels().Click();
            Get_ModelsGrid().Find("Value",modelName_6349,10).Click();
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            //Points de vérification
            Log.Message("------ Valider que dans la section Portefeuilles à rééquilibrer les 2 options non grisés et la 1ère option sélectionnée par défaut -----");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option1_6349); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option2_6349); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, false); 
            
            //Aller à l'étape 2 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 2 de rééquilibrage sans changer de sélection 'Discrétionnaires coché' ----------------------");
            Get_WinRebalance_BtnNext().Click(); 
            //Points de vérification à l'étape 2 de rééquilibrage
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, discHeaderStep2_6349);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsChecked", cmpEqual, true);
            var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
            aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 1), "IsSelected", cmpEqual, true);
            aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 2), "IsSelected", cmpEqual, true);
            var count = grid.Items.Count;
            aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 2);
            for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.ShortName == relationName_6349 || grid.Items.Item(i).DataItem.ClientNumber == clientNo1_6349)
                   Log.Checkpoint("Le client numéro "+clientNo1_6349+" ou la relation "+relationName_6349+" existe dans la grille "+discHeaderStep2_6349);
                else
                   Log.Error("Le client numéro "+clientNo1_6349+" ou la relation "+relationName_6349+" n'existe pas dans la grille "+discHeaderStep2_6349);
            }
           
            //Cliquer sur back pour retourner à l'étape 1
            Log.Message("------------- Cliquer sur back pour retourner à l'étape 1 ---------------") ;
            Get_WinRebalance_BtnPrevious().Click(); 
            //Cocher Non discrétionnaire
            Get_WinRebalance().Find("Uid","RadioButton_823c",10).set_IsChecked(true); 
            //Aller à l'étape2
           Log.Message("-------------- Aller à l'étape 2 après changement de sélection 'Non discrétionnaires coché' ----------------------");
           Get_WinRebalance_BtnNext().Click(); 
           //Points de vérification à l'étape 2 de rééquilibrage
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, nonDicsHeaderStep2_6349);
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
           aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsChecked", cmpEqual, true);
           var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
           var count = grid.Items.Count;
           aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 2);
           for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.AccountNumber == accountNo_6349 || grid.Items.Item(i).DataItem.ClientNumber == clientNo2_6349)
                   Log.Checkpoint("Le client numéro "+clientNo2_6349+" ou le compte numéro "+accountNo_6349+" existe dans la grille "+nonDicsHeaderStep2_6349);
                else
                   Log.Error("Le client numéro "+clientNo2_6349+" ou le compte numéro "+accountNo_6349+" n'existe pas dans la grille "+nonDicsHeaderStep2_6349);
           }
           //Fermer la feêtre de rééquilibrage
           Get_WinRebalance_BtnClose().Click();
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","ResynchronizeParameterWindow_678f");
           
           //Retirer la relation, le compte et les 2 clients du modèle
           Log.Message("-------- Retirer la relation "+relationName_6349+", les clients "+clientNo1_6349+", "+clientNo2_6349+" et le compte "+accountNo_6349+" du modèle "+modelName_6349);
           RemoveRelationshipClientAccountFromModel(modelName_6349,relationName_6349);
           RemoveRelationshipClientAccountFromModel(modelName_6349,clientNo1_6349);
           RemoveRelationshipClientAccountFromModel(modelName_6349,clientNo2_6349);
           RemoveRelationshipClientAccountFromModel(modelName_6349,accountNo_6349);
                
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


