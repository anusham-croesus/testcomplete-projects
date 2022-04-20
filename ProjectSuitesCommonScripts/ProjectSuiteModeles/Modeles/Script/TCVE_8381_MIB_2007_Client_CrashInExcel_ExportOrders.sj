//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT TCVE982_PartialRebalancing_WithSubModel_BasketAndExcessCash


/**
    Description : 
    Le but de ce cas est 
    
    Valider que lors d'un rééquilibrage, a l'étape 5 en cliquant plusieurs fois sur le bouton "Aperçu" 
    lors de l'export du portefeuille projeté vers Excel si on a un assez gros volume d'ordres.
    
    https://jira.croesus.com/browse/TCVE-8381
    https://jira.croesus.com/browse/MIB-2007
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.28.2021.12-60
*/

function TCVE_8381_MIB_2007_Client_CrashInExcel_ExportOrders()
{
    try {
           var logEtape1,logEtape2, logEtape3,logEtape4, logEtape5;
           
           //Afficher le lien du cas de test
           Log.Link("https://jira.croesus.com/browse/TCVE-8381","Cas de test JIRA : TCVE-8381") 
           Log.Link("https://jira.croesus.com/browse/MIB-2007","Cas de test JIRA : MID-2007")
           
         

         
         
           /****************************************************Variables******************************************************/                     
           var userNameGP1859       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
           var passwordGP1859       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
           
           var model_ExportExcel    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "EXPORT_EXCEL", language+client);    
           var modelType            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
           
           
           var securityBMO          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "positionBMO", language+client);
           var targetBMO            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_BMO", language+client);
           var typePicker           = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
           var typePicker2          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
           
           var account800041NA      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800041NA", language+client);
           var account800060NA      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800060NA", language+client);
           var account800216NA      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800216NA", language+client);
           var account800216OB      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800216OB", language+client);
           var account800217RE      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800217RE", language+client);
           var account800230FS      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800230FS", language+client);
           var account800249NA      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800249NA", language+client);
           var account800267RE      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800267RE", language+client);
           var account800280RE      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800280RE", language+client);

           
//Étape 1           
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec GP1859 ");      
            //Se connecter à croesus avec GP1859
            Log.Message("Se connecter à croesus avec GP1859");
            Login(vServerModeles, userNameGP1859, passwordGP1859, language);
            Get_MainWindow().Maximize();

//Étape 2
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Créer le modèle EXPORT EXCEL et lui ajouter la position BMO");
            Log.Message("Créer le modèle EXPORT EXCEL"); 
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            Create_Model(model_ExportExcel,modelType) 
            
            //Ajouter la position BMO dans le Modèle  Export Excel 
            Log.Message("Ajouter la position BCE dans le Modèle Export Excel"); 
            SearchModelByName(model_ExportExcel);
            Drag( Get_ModelsGrid().Find("Value",model_ExportExcel,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            Get_DlgConfirmation_NoDesactiveModel().Click() 
            
            //Ajouter une position BMO
            AddPositionToModel(securityBMO,targetBMO,typePicker,"")
            
 //Étape 3           
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape3 : assigner les comptes  au modele EXPORT EXCEL :  ");        
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            AssociateAccountWithModel(model_ExportExcel,account800041NA);
            AssociateAccountWithModel(model_ExportExcel,account800060NA);
            AssociateAccountWithModel(model_ExportExcel,account800216NA);
            AssociateAccountWithModel(model_ExportExcel,account800216OB);
            AssociateAccountWithModel(model_ExportExcel,account800217RE);
            AssociateAccountWithModel(model_ExportExcel,account800230FS);
            AssociateAccountWithModel(model_ExportExcel,account800249NA);
            AssociateAccountWithModel(model_ExportExcel,account800267RE);
            AssociateAccountWithModel(model_ExportExcel,account800280RE);
 
                        
//Étape 4 
            //Rééquilibrer le modèle et se rendre à l'étape 2
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape4 : Rééquilibrer le modèle, generer les ordres en cliquant plusieur fois sur le bouton appercu et valider qu'il ne crache pas  "); 
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click();
             Get_WinRebalance_BtnNext().Click();  
            Get_WinRebalance_BtnNext().Click(); 
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  

            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            
            
            // Aller l'étape 5
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad");
        
            var width = Get_WinGenerateOrders().Width;
            var height = Get_WinGenerateOrders().Height;
            Log.Message(width)
            Log.Message(height)
 
 
            Get_WinGenerateOrders_GrpMode_ChkPreview().Click();
            Get_WinGenerateOrders_GrpExcel_ChkProjectedPortfolio().Click();
            Get_WinGenerateOrders_BtnGenerate().Click();
            Get_WinGenerateOrders().Click(width/3,height-100);
            if((Get_WinGenerateOrders().Exists && Get_WinGenerateOrders_BtnGenerate().IsEnabled)||(Get_DlgError().Exists)){
               Log.Error("Jira MIB-2007 : Crash detecté")
               Get_WinGenerateOrders_BtnGenerate().Click();
               
               //Fermer la fenêtre de rééquilibrage
               Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
               Get_WinRebalance_BtnClose().Click();
               Get_DlgConfirmation_BtnYes().Click();
              
               Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Keys("^a");
               Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
               if(Get_DlgConfirmation().Exists){
                 var width = Get_DlgConfirmation().Get_Width();
                 Get_DlgConfirmation().Click((width*(1/3)),73);
               }
               DeleteModelByName(model_ExportExcel) 
               

            }  
            else{
              
               Log.Checkpoint("Aucun crash détecté")
               //Fermer la fenêtre de rééquilibrage
               Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
               Get_WinRebalance_BtnClose().Click();
               Get_DlgConfirmation_BtnYes().Click();
               
                 //Restart Data
               Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Keys("^a");
               Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
               if(Get_DlgConfirmation().Exists){
               var width = Get_DlgConfirmation().Get_Width();
               Get_DlgConfirmation().Click((width*(1/3)),73);
          }

              DeleteModelByName(model_ExportExcel)
             
            }
               
                
           
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
      
          //Fermer le processus Croesus
          Terminate_CroesusProcess(); 
          //Remettre les  prefs a leur valeurs initiales 
//          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REBALANCE_PREVENT_DELTA", "YES", vServerModeles);
//          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
//          Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles);
//          Activate_Inactivate_Pref("FORTINN", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "2", vServerModeles);
                  
        
    }
}



