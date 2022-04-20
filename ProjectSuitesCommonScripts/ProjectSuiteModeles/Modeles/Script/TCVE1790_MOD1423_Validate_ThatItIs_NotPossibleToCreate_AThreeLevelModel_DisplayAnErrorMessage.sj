//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : (MOD-1423) Valider que la création d'un modèle à 3 niveaux n'est pas possible 
    et qu'un message bloquant s'affiche suite à la sauvegarde du sous-modèle puis du modèle parent
        
    https://jira.croesus.com/browse/TCVE-1790
    Analyste d'assurance qualité : Christine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.17.2020.7-38
*/

function TCVE1790_MOD1423_Validate_ThatItIs_NotPossibleToCreate_AThreeLevelModel_DisplayAnErrorMessage()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-1790") 
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;
            
            
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-1790") 
                               
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;       
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         
            
            var mod_M1423         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MOD_M1423", language+client);
            var subModel1         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "M1423-SUBMODEL1", language+client);
            var subModel2         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "M1423-SUBMODEL2", language+client);
            var modelType         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            
           
            var securityBMO       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityBMO", language+client);
            var securityNA        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityNA", language+client);
            var securityTD        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityTD", language+client);
            
            var targetBMO         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetBMO", language+client);
            var targetNA          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetNA", language+client);
            var targetTD          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetTD", language+client);
            var targetSubmodel1   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetSubmodele1", language+client);
            var targetSubmodel2   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetSubmodele2", language+client);
            
            var solde_mod_M1423   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Solde_Mod_M1423", language+client);
            
            var errorMessage1   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ErrorMessage1", language+client);
            var errorMessage2   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ErrorMessage2", language+client);
            var positionSolde   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "PositionSolde", language+client);
           
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej");      
  
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//Étape2         
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Créer le modèle de firme M1423-PARENT. et ajouter au modele creer la position BMO");      
            
            
  
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle mod_M1423 
            Log.Message("Créer le modèle mod_M1423 "); 
            Create_Model(mod_M1423,modelType)
            
            
             //Ajouter des position dans le Modèle mod_M1423
            Log.Message("Ajouter la position BMO au Modèle mod_M1423"); 
            SearchModelByName(mod_M1423);
            Drag( Get_ModelsGrid().Find("Value",mod_M1423,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/3)),73)
            Get_DlgConfirmation_btnNo().Click();
            
            //Ajouter de la  position BMO
            Log.Message("Ajout de la  position BMO")
            AddPositionToModel(securityBMO,targetBMO,typePicker,"") 
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
//Étape3           
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3:Créer le modèle de firme M1423-SUBMODEL1 et ajouter lui la position NA"); 
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            //Creation du modele
            Log.Message("Creation du modele M1423-SUBMODEL1")
            Create_Model(subModel1,modelType)
            
            //Ajouter des position dans le Modèle subModel1
            Log.Message("Ajouter des position dans le  Modèle subModel1"); 
            SearchModelByName(subModel1);
            Drag( Get_ModelsGrid().Find("Value",subModel1,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/3)),73)
             Get_DlgConfirmation_btnNo().Click();

            
            //Ajouter de la  position NA
            Log.Message("Ajout de la  position NA")
            AddPositionToModel(securityNA,targetNA,typePicker,"")
            
            //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();

//Étape4            
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4:Créer le modèle de firme M1423-SUBMODEL2 et ajouter lui la position TD"); 
           
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
             //Creation du modele
            Log.Message("Creation du modele M1423-SUBMODEL2")
            Create_Model(subModel2,modelType)
            
            
            //Ajouter des position dans le Modèle subModel2
            Log.Message("Ajouter des position dans le  Modèle subModel2");  
            SearchModelByName(subModel2);
            Drag( Get_ModelsGrid().Find("Value",subModel2,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/3)),73);
            Get_DlgConfirmation_btnNo().Click();


            
            //Ajouter une position TD
            Log.Message("Ajout de la  position TD")
            AddPositionToModel(securityTD,targetTD,typePicker,"")
            
            //Sauvegarder les positions ajoutées dans le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
//Étape5            
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5:Mailler le modèle M1423-PARENT vers le module Portefeuille.Cliquer sur l'épingle pour garder le portefeuille du modèle M1423-PARENT sur l'écran.");            

            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            //Mailler le modèle M1423-PARENT vers le module Portefeuille
            Log.Message("Mailler le modèle M1423-PARENT vers le module Portefeuille"); 
            SearchModelByName(mod_M1423);
            Drag( Get_ModelsGrid().Find("Value",mod_M1423,10), Get_ModulesBar_BtnPortfolio());
            

            
//Étape6            
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6:Ajouter la position suivante au  modèle M1423-PARENT :Sous-modèle = M1423-SUBMODEL1. NE PAS sauvegarder le modèle M1423-PARENT.");            
            
            //Ajouter le sous modele subModel1  au Modele parent  mod_M1423
            Log.Message("Ajouter le sous modele au modele subModel1  au Modele parent  mod_M1423");
            Get_Toolbar_BtnAdd().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/2.8)),73)
            Get_DlgConfirmation_btnNo().Click();
            
            //Ajout du sous modele 
            Log.Message("Ajout du sous modele");
            AddSubModelToModel(subModel1,targetSubmodel1) 
            
            //Cliquer sur l'épingle pour garder le portefeuille du modèle M1423-PARENT sur l'écran
            Log.Message("Cliquer sur l'épingle pour garder le portefeuille du modèle M1423-PARENT sur l'écran"); 
            EpinglerModele1();
//            Get_MainWindow().Click(145,140);

//Étape7            
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7:Mailler le modèle M1423-SUBMODEL1 vers le module Portefeuille.Cliquer sur l'épingle pour garder le portefeuille du modèle M1423-SUBMODEL1 sur l'écran.");            

            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 

            //Ajouter le sous modele subModel2  au Modele   subModel1
            Log.Message("Ajouter le sous modele subModel2  au Modele   subModel1"); 
            SearchModelByName(subModel1);
            Drag( Get_ModelsGrid().Find("Value",subModel1,10), Get_ModulesBar_BtnPortfolio());
            
            

//Étape8            
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8:Ajouter la position suivante au  modèle M1423-SUBMODEL1 :Sous-modèle = M1423-SUBMODEL2 puis sauvegarder le modèle M1423-SUBMODEL1");            

            Get_Toolbar_BtnAdd().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/3)),73);
            Get_DlgConfirmation_btnNo().Click();
            AddSubModelToModel(subModel2,targetSubmodel2);
            
            
            //Sauvegarder les positions ajoutées dans le modèle           
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
             //Cliquer sur l'épingle pour garder le portefeuille du modèle M1423-PARENT sur l'écran
            Log.Message("Cliquer sur l'épingle pour garder le portefeuille du modèle M1423-SUBMODEL1 sur l'écran");
            EpinglerModele2();
//            Get_MainWindow().Click(410,140);
            
//Étape9            
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9:Cliquer sur l'onglet du modèle M1423-PARENT.Sauvegarder le modèle M1423-PARENT.Vérifier qu'un message bloquant s'affiche et que la sauvegarde du modèle à 3 niveaux est bloquée.)");            

   
            //Retourner au premier modele 
            Get_MainWindow().Click(165,140)
            
            //Sauvegarder les positions ajoutées dans le modèle           
            Get_PortfolioBar_BtnSave().Click();
            
            //Validation du message d'erreur
            Log.Message("Validation du message d'erreur")
            aqObject.CheckProperty(Get_DlgError_LblMessage1(), "Text", cmpEqual, errorMessage1+"\r\n"+errorMessage2);
            
            
            //Cliquer sur OK pour fermer la fenetre 
            Get_DlgError_Btn_OK().Click()
//Étape10            
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10 : Mailler la position solde du modèle M1423-PARENT vers le module Portefeuille pour rafraîchir les données de ce modèle. Vérifier que modèle M1423-PARENT contient les positions suivantes : BMO et Solde.");            
            
            Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10).Click()
            Drag( Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10), Get_ModulesBar_BtnPortfolio());
            
            // Valider que modèle M1423-PARENT contient les positions suivantes : BMO et Solde.
            Log.Message("Valider que modèle M1423-PARENT contient les positions suivantes : BMO et Solde.")
            var grid = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1)

             aqObject.CheckProperty(grid.Items ,"Count",cmpEqual,2)
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"Symbol",cmpEqual,positionSolde)
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"ModelTargetPercent",cmpEqual,solde_mod_M1423)
             aqObject.CheckProperty(grid.Items.Item(1).DataItem ,"Symbol",cmpEqual,securityBMO)
             aqObject.CheckProperty(grid.Items.Item(1).DataItem ,"ModelTargetPercent",cmpEqual,targetBMO)
          

 }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
        
            //Restore data
		    DeleteModelByName(mod_M1423)
            DeleteModelByName(subModel1)
            DeleteModelByName(subModel2)
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}

//fonction pour epingler le 1er modele  mod_M1423_parent
function EpinglerModele1()
{
  if (language=="french"){ Get_MainWindow().Click(145,140)}
  else {Get_MainWindow().Click(129,140)}
}

//fonction pour epingler le 1er modele  mod_M1423_parent
function EpinglerModele2()
{
  if (language=="french"){ Get_MainWindow().Click(410,140)}
  else {Get_MainWindow().Click(400,140)}
}

