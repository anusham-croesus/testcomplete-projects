//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT TCVE_2984_MID_571_Validate_the_Possibility_To_ModifyAndSave_ParentModel_Possess_SubModel_Including_Basket()


/**
    Description : (MOD-1423) Valider que la création d'un modèle à 3 niveaux n'est pas possible 
    et qu'un message bloquant s'affiche suite à la sauvegarde du sous-modèle puis du modèle parent
        
    https://jira.croesus.com/browse/TCVE-7197
    https://jira.croesus.com/browse/MOD-2236
    Analyste d'assurance qualité : Christine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.27-66
*/

function TCVE_7197_MOD_2236_Validate_TheChangeTargetMarketValue_SubModel_IsCalculatedAndCorrectlySaved_InTheParentModel()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-7197") 
            Log.Link("https://jira.croesus.com/browse/TCVE-7197") 
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;
            
            
            
                               
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;       
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
            var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
         
            
            var mod_2236_S        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MOD_2236_S", language+client);
            var mod_2236_P        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MOD_2236_P", language+client);
            var modelType         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            
            var securityNBC100    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityNBC100", language+client);
            var target_mod_2236_S = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_MOD_2236_S", language+client);
            var targetNBC100      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_NBC100", language+client);
            var priceSecurity     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SECURITY_PRICE", language+client);
            
            var solde_MOD_2236    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SECURITY_SOLDE_MOD2236", language+client);
            var vmSolde_2236_S    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_SOLDE_2236_S", language+client);
            var vmSolde_2236_P    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_SOLDE_2236_P", language+client);
            var vmNBC100_2236_S   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_NBC100_2236_S", language+client);
            var vmMod_2236_S      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM_MOD_2236_S_P", language+client);
           
            var cibleSolde_2236_S   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_SOLDE_2236_S", language+client);
            var cibleSolde_2236_P   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_SOLDE_2236_P", language+client);
            var cibleNBC100_2236_S  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_NBC100_2236_S", language+client);
            var cibleMod_2236_S     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_MOD_2236_S_P", language+client);
            
            var vmMod_2236_S_Modified    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_SOLDE_2236_S", language+client);
            var vmSolde_2236_P_Modified  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_SOLDE_2236_S", language+client);
           
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej");      
  
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//Étape2         
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Créer le Sous modèle de firme MOD_2236_S et ajouter au modele creer la position NBC100");      
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle mod_M1423 
            Log.Message("Créer le modèle _MOD_2236_S"); 
            Create_Model(mod_2236_S,modelType)
            
            
            //Ajouter des position dans le Modèle MOD_2236_S
            Log.Message("Ajouter la position NBC100 au Modèle MOD_2236_S"); 
            SearchModelByName(mod_2236_S);
            Drag( Get_ModelsGrid().Find("Value",mod_2236_S,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            Get_DlgConfirmation_btnNo().Click();
            
            //Ajouter de la  position NBC100
            Log.Message("Ajout de la  position NBC100")
            AddPositionToModel(securityNBC100,targetNBC100,typePicker,"");
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            Get_PortfolioBar_BtnReinitializeMV().Click();
            Get_DlgConfirmation_BtnYes().Click();
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
//Étape3           
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3:Créer le modèle de firme mod_2236_P et lui ajouter le sous modéle MOD_2236_S "); 
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            //Creation du modele
            Log.Message("Creation du modele mod_2236_P")
            Create_Model(mod_2236_P,modelType)
            
            //Ajouter des position dans le Modèle subModel1
            Log.Message("Ajouter comme position MOD_2236_S dans le  Modèle MOD_2236_P"); 
            SearchModelByName(mod_2236_P);
            Drag( Get_ModelsGrid().Find("Value",mod_2236_P,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            Get_DlgConfirmation_btnNo().Click();

            
            //Ajout du sous modele 
            Log.Message("Ajout du sous modele");
            AddSubModelToModel(mod_2236_S,target_mod_2236_S)
            
            //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            
            Get_PortfolioBar_BtnReinitializeMV().Click(); 
            Get_DlgConfirmation_BtnYes().Click(); 
                     
            //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            //Fermer le processus Croesus
            Terminate_CroesusProcess(); 

//Étape4            
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4 : Vérifier les informations pour ces deux modèles dans la table b_portef :"); 
           
            

//Étape5    
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5: Se connecter à croesus avec Uni00");      
  
            //Se connecter à croesus avec Uni00
            Log.Message("Se connecter à croesus avec Uni00");
            Login(vServerModeles, userNameUNI00, passwordUNI00, language);
            Get_MainWindow().Maximize(); 
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
            
            
            // Mettre un nombre qui contient plus de 7 chiffres sur le prix Acheteur 
            Search_SecurityBySymbol(securityNBC100)
            Get_SecurityGrid().Find("Value",securityNBC100,10).Click();
          
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Clear();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Keys(priceSecurity);
            
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Clear();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Keys(priceSecurity);
            
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Clear();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Keys(priceSecurity);
            Get_WinInfoSecurity_BtnOK().Click()
            
            //Fermer le processus Croesus
            Terminate_CroesusProcess(); 

           
            
//Étape6            
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Se connecter à nouveau a croesus avec Keynej, Mailler successivement les deux modèles dans le module Portefeuille et valider les VM%");            

            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à nouveau a croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
            
            
            Log.Message("Vérifier que les VM(%) des modèles ont changés car le prix au marché du titre NBC100 a été modifié et est détenu dans les deux modèle"); 
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            
            
            Log.Message("Maillerle modele mod_2236_S vers portefeuilles");
            SearchModelByName(mod_2236_S);
            Drag( Get_ModelsGrid().Find("Value",mod_2236_S,10), Get_ModulesBar_BtnPortfolio());
            
            var grid = Get_Portfolio_PositionsGrid();
            var count = grid.Items.Count;
              
            for (i=0; i<count; i++){
                             
               if (grid.Items.Item(i).DataItem.Symbol== solde_MOD_2236)
                {
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmSolde_2236_S)
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,cibleSolde_2236_S)
                }     
               if (grid.Items.Item(i).DataItem.Symbol== securityNBC100)
                {
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmNBC100_2236_S)
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,cibleNBC100_2236_S)
                }   
                   
             }
             
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            
            
            Log.Message("Maillerle modele mod_2236_P vers portefeuilles");
            SearchModelByName(mod_2236_P);
            Drag( Get_ModelsGrid().Find("Value",mod_2236_P,10), Get_ModulesBar_BtnPortfolio());
            
            var grid = Get_Portfolio_PositionsGrid();
            var count = grid.Items.Count;
              
            for (i=0; i<count; i++){
                             
               if (grid.Items.Item(i).DataItem.Symbol== solde_MOD_2236)
                {
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmSolde_2236_P)
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,cibleSolde_2236_P)
                }     
               if (grid.Items.Item(i).DataItem.SecurityDescription== mod_2236_S)
                {
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmMod_2236_S)
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,cibleMod_2236_S)
                }   
                   
             }
             
               
               
              
               
//Étape8            
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Modifier la VM(%) du sous-modèle comme suit : :Valeur de marché(%) =50 % (auparavant = 75 %)");            
           
            Get_Portfolio_PositionsGrid().FindChild("WPFControlText", "MOD_2236_S", 10).DblClick();
            Get_DlgConfirmation_btnNo().Click();  
            Get_WinSubModelInfo_TxtMarketValue().Keys(vmMod_2236_S_Modified);
            Get_WinSubModelInfo_BtnOK().Click(); 
            
            //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            

  

//Étape10            
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10: Vérifier que la VM(%) du sous-modèle dans le modèle correspond à la VM(%) saisie à l'étape précédente soit 50%..");            

             var grid = Get_Portfolio_PositionsGrid();
            var count = grid.Items.Count;
              
            for (i=0; i<count; i++){
                             
               if (grid.Items.Item(i).DataItem.Symbol== solde_MOD_2236)
                {
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmSolde_2236_P_Modified)
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,cibleSolde_2236_P)
                }     
               if (grid.Items.Item(i).DataItem.SecurityDescription== mod_2236_S)
                {
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"TotalValuePercentageMarket",cmpEqual,vmMod_2236_S_Modified)
                 aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,cibleMod_2236_S)
                }   
                   
             }
            

          

 }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
        
//            //Restore data
//Étape11    
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 11 :Restore data");      
  
            //Se connecter à croesus avec Uni00
            Log.Message("Se connecter à croesus avec Uni00");
            Login(vServerModeles, userNameUNI00, passwordUNI00, language);
            Get_MainWindow().Maximize(); 
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
            
            
            // Mettre un nombre qui contient plus de 7 chiffres sur le prix Acheteur 
            Search_SecurityBySymbol(securityNBC100)
            Get_SecurityGrid().Find("Value",securityNBC100,10).Click();
          
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Clear();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Keys(1);
            
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Clear();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Keys(1);
            
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Click();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Clear();
            Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Keys(1);
            Get_WinInfoSecurity_BtnOK().Click()
		        DeleteModelByName(mod_2236_P)
            DeleteModelByName(mod_2236_S)

  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}

function test(){
   Get_Portfolio_PositionsGrid().FindChild("WPFControlText", "MOD_2236_S", 10).DblClick();
   Get_DlgConfirmation_btnNo().Click();  
   Get_WinSubModelInfo_TxtMarketValue().Keys(cibleMod_2236_S_Modified);
   Get_WinSubModelInfo_BtnOK().Click();

}

 function Get_WinSubModelInfo_TxtMarketValue(){return Get_WinSubModelInfo().FindChild("Uid", "DoubleTextBox_77e7", 10)}
 
