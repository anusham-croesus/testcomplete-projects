//USEUNIT CR2141_6341_Mod_PreparationCases_CreateModelsWithDelegatedManagementAndPref
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2070_CR2141_6348_Mod_PreparationCaseCreateModelsPrefAndProfile



/**
    Module               :  Modeles
    CR                   :  2141/2070
    TestLink             :  Croes-6367 
    Description          :  FCT.14 - Validation lors du rééquilibrage d'une relation
                            5.2 - Déterminer la disponibilité des destinations de la génération des ordres (étape 5)

                            Le but de ce cas est de
                            - valider le rééquilibrage d'une relation disc associée à un modèle interne ou à gestion déléguée. Tous les comptes 
                              de la relation sont disc. 
                            - Valider le blocage du rééquilibrage d'une relation non disc avec des comptes disc associée à modèle interne et le 
                              rééquilibrage est possible sielle est associée à modàle à gestion déléguée.
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-13
    Date                 :  16/05/2019
    
*/


function CR2070_CR2141_6367_RebalancingDiscRelationshipAssociatedWithInternalModelOrAMBA_AllDiscCpts() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6367","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelName_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName_6322", language+client);
            var relationshipName_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "relationName1_6348", language+client);
            var option1_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option1_6361", language+client);
            var option2_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option2_6361", language+client);
            var discHeaderStep2_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "discHeaderStep2_6349", language+client);
            var accountNo_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "accountNo6_6348", language+client);
            var GroupBoxDefaut = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "GroupBoxDefaut", language+client);
            var option3_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option3_6367", language+client);
            var option4_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "option2_6363", language+client);
            var nonDicsHeaderStep2_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "nonDicsHeaderStep2_6349", language+client);
            var MsgBloc_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "MsgBloc_6367", language+client);
            var modelNameAMBA1_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "modelName1Croes_6341", language+client);
            var MsgNonBloc_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "MsgNonBloc_6367", language+client);
            var profileValue_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "profileValue1_6348", language+client);
            var frenchShort_6367 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2141", "frenchShort_6348", language+client);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            Log.Message("-------- Associer la relation"+relationshipName_6367+" au modèle "+modelName_6367+" ----------");
            AssociateRelationshipWithModel(modelName_6367, relationshipName_6367);
            
            //rééquilibrer le modèle
            Log.Message("------- Rééquilibrer jusqu'à l'étape 1 ----------------");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            //Deecocher la case tolerance
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().Click();  
            
            //Points de vérication à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option1_6367); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option2_6367); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, false); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, false); 

            //Aller à l'étape 2 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 2 de rééquilibrage sans changer de sélection 'Discrétionnaires coché' ----------------------");
            Get_WinRebalance_BtnNext().Click();
             
            //Points de vérification à l'étape 2 de rééquilibrage
            Log.Message("------------- Points de vérification à l'étape 2 ------------------");
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, discHeaderStep2_6367);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsChecked", cmpEqual, true);
            var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
            aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 1), "IsSelected", cmpEqual, true);
            var count = grid.Items.Count;
            aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 1);
            if (grid.Items.Item(0).DataItem.ShortName == relationshipName_6367) 
               Log.Checkpoint("La relation ("+relationshipName_6367+") existe dans la grille ("+discHeaderStep2_6367+")");
            else
               Log.Error("La relation ("+relationshipName_6367+") n'existe pas dans la grille ("+discHeaderStep2_6361+")");
           
            //Aller à l'étape 5 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 5 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();  
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad");
            Get_WinGenerateOrders_BtnGenerate().Click();
            if (Get_DlgConfirmation().Exists)
               Get_DlgConfirmation().Click(Get_DlgConfirmation().Get_Width()*(2/3),73);
            Log.Message("------ Vérifier que l'application se dirige vers le module Ordres ----------------");
            aqObject.CheckProperty(Get_ModulesBar_BtnOrders(),"IsChecked", cmpEqual, true);
            
            //Aller dans le module compte et électionner 800241-SF
            Log.Message("------- Aller au module comptes et accéder à info du compte No "+accountNo_6367+" --------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000); 
            Search_Account(accountNo_6367);
            Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo_6367, 10).DblClick();
            //Acceder à l'onglet Profil
            Log.Message("----------- Acceder à l'onglet Profil et enlever le contenu du profil KYC-TYPE-honoraires-----------------");
            Get_WinDetailedInfo_TabProfile().Click();
            
            Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys("^a[BS]");
            Get_WinDetailedInfo_BtnApply().Click();
            Get_WinDetailedInfo_BtnOK().Click();
            
            //Retourner dans le module modèle et rééquilibrer le modèle CH CANADIAN EQUI
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            SearchModelByName(modelName_6367);
            Get_ModelsGrid().Find("Value", modelName_6367, 10).Click();
            //rééquilibrer le modèle
            Log.Message("------- Rééquilibrer jusqu'à l'étape 1 ----------------");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            //Decocher la case tolerance
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().Click();  
            
            //Points de vérication à l'étape1
            Log.Message("------------- Points de vérification à l'étape 1 ------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "WPFControlText", cmpEqual, option3_6367); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "WPFControlText", cmpEqual, option4_6367); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsEnabled", cmpEqual, false); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsEnabled", cmpEqual, true); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_693c",10), "IsChecked", cmpEqual, false); 
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","RadioButton_823c",10), "IsChecked", cmpEqual, true); 
            
            //Aller à l'étape 2 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 2 de rééquilibrage  ----------------------");
            Get_WinRebalance_BtnNext().Click();
             
            //Points de vérification à l'étape 2 de rééquilibrage
            Log.Message("------------- Points de vérification à l'étape 2 ------------------");
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text", cmpEqual, nonDicsHeaderStep2_6367);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsChecked", cmpEqual, true);
            var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
            aqObject.CheckProperty(grid.WPFObject("DataRecordPresenter", "", 1), "IsSelected", cmpEqual, true);
            var count = grid.Items.Count;
            aqObject.CheckProperty(grid.Items, "Count", cmpEqual, 1);
            if (grid.Items.Item(0).DataItem.ShortName == relationshipName_6367) 
               Log.Checkpoint("La relation ("+relationshipName_6367+") existe dans la grille ("+nonDicsHeaderStep2_6367+")");
            else
               Log.Error("La relation ("+relationshipName_6367+") n'existe pas dans la grille ("+nonDicsHeaderStep2_6367+")");
           
            //Aller à l'étape 4 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 4 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            //Vérification du message bloquant
            Log.Message("------------ Vérification du message bloquant --------------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10), "WPFControlText", cmpEqual, MsgBloc_6367);
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
            
            //Retirer la relation du modèle
            Log.Message("-------- Retirer la relation "+relationshipName_6367+" du modèle "+modelName_6367);
            RemoveRelationshipClientAccountFromModel(modelName_6367,relationshipName_6367);
            
            Log.Message("-------- Associer la relation"+relationshipName_6367+" au modèle "+modelNameAMBA1_6367+" ----------");
            AssociateRelationshipWithModel(modelNameAMBA1_6367, relationshipName_6367);
            
            //Rééquilibrer jusqu'à étape 4
            Log.Message("--------- Rééquilibrer le modèle -------------");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize(); 
            //Decocher la case tolerance
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().Click();       
            Log.Message("-------------- Aller à l'étape 4 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();  
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            //Vérification pas de message bloquant
            Log.Message("---------- Valider qu'il n ya pas de message bloquant ---------------");
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10), "WPFControlText", cmpEqual, MsgNonBloc_6367);
            if (Get_WinRebalance().Find("Uid","TextBlock_619e",10).WPFControlText == MsgNonBloc_6367)
               Log.Checkpoint("Pas de message bloquant") ;
            
            //Aller à l'étape 5
            Log.Message("-------------- Aller à l'étape 5 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad");
            Get_WinGenerateOrders_GrpMode_ChkGeneratedOrders().set_IsChecked(true);
            Get_WinGenerateOrders_GrpPDF_ChkProjectedPortfolio().set_IsChecked(true);
            Get_WinGenerateOrders_BtnGenerate().WaitProperty("IsEnabled", true, 3000);
            if (Get_WinGenerateOrders_BtnGenerate().IsEnabled == false) 
               Get_WinGenerateOrders_BtnGenerate().Click();
            Get_WinGenerateOrders_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");
            
            
            //Fermer la fenêtre de confirmation si elle est presente
            if(Get_DlgConfirmation().Exists){
               var width = Get_DlgConfirmation().Get_Width();
               Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
            
            //Valider que le fichier PDF est généré
            Log.Message("---------- Valider que le PDF est généré ----------------");
            Sys.FindChildEx("ProcessName", GetAcrobatProcessName(), 10, true, 100000).WaitWindow("AcrobatSDIWindow", "Open*", 1, 100000); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
            aqObject.CheckProperty(Sys.FindChild("WndClass", "AcrobatSDIWindow", 10), "Visible", cmpEqual, true);
            TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
            
            //Retirer la relation du modèle AMBA1
            Log.Message("-------- Retirer la relation "+relationshipName_6367+" du modèle "+modelNameAMBA1_6367);
            RemoveRelationshipClientAccountFromModel(modelNameAMBA1_6367,relationshipName_6367);
            
            //mettre du contenu du profil pour le compte 
            Log.Message("----------- Acceder à l'onglet Profil et ajouter le contenu au profil KYC-TYPE-honoraires-----------------");
            AddProfileToAccount(accountNo_6367, frenchShort_6367, profileValue_6367);
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


function test(){
  

          if(Get_DlgConfirmation().Exists){
               var width = Get_DlgConfirmation().Get_Width();
               Get_DlgConfirmation().Click((width*(1/3)),73) 
           }
            

}
