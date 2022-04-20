//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : Création du modèle MOD1397 et de la relation MOD 1396 
    pour le cas  TCVE67
        
    
    Analyste d'assurance qualité : Christine Pereault
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.15.2020.3-8
*/

function CR2270_TCVE67_Mod1396_1397_CasePrepartionCreateModelsAndRelationship()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("//jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6875","Cas de test TestLink : Croes-6875") 
                               
                   
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         
            
            var MOD1397          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "ModelMOD1397", language+client);
            var relationMOD1396  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "RelationMOD1396", language+client);
            var modelType        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            var typePicker2      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            var IACodeRelMOD1396 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "IACodeRelMOD1396", language+client);
           
            var securityDCX      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityDCX", language+client);
            var securityBPU      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityBPU", language+client);
            var securityR13369   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityR13369", language+client);
            var securityR08407   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityR08407", language+client);
            
            
            
            var targetDCX       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "TargetDCX", language+client);
            var targetBPU       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "TargetBPU", language+client);
            var targetR13369    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "TargetR13369", language+client);
            var targetR08407    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "TargetR08407", language+client);
            
            
            var account800214NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "Account800214NA", language+client);
            var account800215OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "Account800215OB", language+client);
            var MIB_3704          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "Modele_MIB_3704", language+client);
         


            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
 /***************************Création du Modèle********************************/
            Log.Message("Création du modèle")         
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle MOD1397
            Log.Message("Créer le modèle MOD1397"); 
            Create_Model(MOD1397,modelType)
                   
            
            //Ajouter des position (DCX, BP.U, R13369 et R08407) dans le Modèle modelMOD1397 
            Log.Message("Ajouter des position (DCX, BP.U, R13369 et R08407) dans le Modèle modelMOD1397 "); 
            SearchModelByName(MOD1397);
            Drag( Get_ModelsGrid().Find("Value",MOD1397,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            Get_DlgConfirmation_NoDesactiveModel().Click() 
            
            //Ajouter une position DCX
            AddPositionToModel(securityDCX,targetDCX,typePicker,"")
            //Ajouter une position BP.U
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityBPU,targetBPU,typePicker,"")
            
            //Ajouter une position R13369
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityR13369,targetR13369,typePicker2,"")
            //Ajouter une position R08407
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityR08407,targetR08407,typePicker2,"")
            
            //Sauvegarder les positions ajoutées dans le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            
            /*Validation du jira MIB-1982 (Intégrer le jira MIB-1982 dans la suite des tests automatisé du modele)
            Pour eviter de creer un nouveau script il a ete decicé  d'inclure la validation de ce jira dans  Ce script */
            Log.Message("Cette partie du script concerne la validation du  jira MIB-1982:Valider la sauvegarde des nouvelles positions dans un modèle  ");
            TCVE_5428_MIB1982_ValidateTheModifications_MadeToAModelAreSaved()
            
           
/***************************Création de la Rélation********************************/
            Log.Message("Création la Rélation")           
           
            //Accéder au module Relation
            Log.Message("Accéder au module Relation");         
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            
           
            //Créer la relation MOD1396 
            Log.Message("Créer la relation RJ3"); 
            CreateRelationship(relationMOD1396, IACodeRelMOD1396); 
            
            Log.Message("Associer les comptes" + account800214NA + "et"  + account800215OB + "à la relation " + relationMOD1396);
            JoinAccountToRelationship(account800214NA, relationMOD1396);
            JoinAccountToRelationship(account800215OB, relationMOD1396);
                  
                  
        
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
        
           //Supprimer le modele MIB-3704
	       DeleteModelByName(MIB_3704); 
  		  //Fermer le processus Croesus
          Terminate_CroesusProcess();         
        
    }
}


function TCVE_5428_MIB1982_ValidateTheModifications_MadeToAModelAreSaved(){
    

             var MIB_3704                 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "Modele_MIB_3704", language+client);
             var modelTypeMIB_3704        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
             var IAcode                   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "IA_CODE_MIB3704", language+client); 
             
             var securityNA               = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityNA", language+client);
             var securityBCE              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityBCE", language+client);
             var targetNA                 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "targetNA", language+client);
             
             var vmPercentNA              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "VM_NA", language+client);
             var typePicker               = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
             var typePicker2              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
             var targetBCE                = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "targetBCE", language+client);
             var positionSolde            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "POSITION_SOLDE", language+client); 
            
            Log.Link("https://jira.croesus.com/browse/MIB-3704")
            Log.Link("https://jira.croesus.com/browse/TCVE-5428")
            Log.Message("Créer le modèle Créer le modèle MIB-3704");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            Create_Model(MIB_3704,modelTypeMIB_3704,IAcode)
            
            //Ajouter des position (NA ET BCE) dans le Modèle MIB_3704 
            Log.Message("Ajouter des position (NA ET BCE) dans le Modèle MIB_3704  "); 
            SearchModelByName(MIB_3704);
            Drag( Get_ModelsGrid().Find("Value",MIB_3704,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            Get_DlgConfirmation_NoDesactiveModel().Click();  
            
            //Ajouter des position NA
            Log.Message("Ajouter la position NA ");
            AddPositionToModel(securityNA,targetNA,typePicker,"")
            
            //Ajouter une position BCE
            Log.Message("Ajouter la position BCE ");
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityBCE,targetBCE,typePicker,"")
            
            //Sauvegarder le model
            Log.Message("Sauvegarder le model");
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
            
            //Mailler la position de cash (1CAD) du modèle vers Portefeuille pour recharger le portefeuille du modèle
            Log.Message("Mailler la position de cash (1CAD) du modèle vers Portefeuille pour recharger le portefeuille du modèle");
            Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10).Click();
            Drag(Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10), Get_ModulesBar_BtnPortfolio());
            
            //Selectionner et supprimer la position NA
            Log.Message("Selectionner et supprimer la position NA");
            Get_PortfolioPlugin().Find("OriginalValue",securityNA,10).Click();
            Get_Toolbar_BtnDelete().Click();
            Get_DlgConfirmation_NoDesactiveModel().Click();
            Get_DlgConfirmation_BtnYes().Click();
            
            //Sauvegarder a nouveau le model
            Log.Message("Sauvegarder a nouveau le model");
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
            
            //Mailler a nouveau la position de cash (1CAD) du modèle vers Portefeuille pour recharger le portefeuille du modèle
            Log.Message("Maillera nouveau  la position de cash (1CAD) du modèle vers Portefeuille pour recharger le portefeuille du modèle");
            Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10).Click();
            Drag(Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10), Get_ModulesBar_BtnPortfolio());
            
            //Cliquer sur le bouton tous pour afficher toutes les positions
            Log.Message("Cliquer sur le bouton tous pour afficher toutes les positions");
            Get_PortfolioBar_BtnAll().Click();
            
            //Valider que la position NA a la cible VM% = 0%
            Log.Message("Valider que la position NA a la cible VM% = 0%");
             var count = Get_Portfolio_PositionsGrid().Items.Count;
             for (i=0; i<count; i++){
                  if (Get_Portfolio_PositionsGrid().Items.Item(i).DataItem.Symbol == securityNA)
                      {
                        
                        aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,vmPercentNA)
                      }     
              } 


}



function Get_DlgConfirmation_NoDesactiveModel(){return Get_DlgConfirmation().Find(["ClrClassName", "WPFControlName"], ["Button", "PART_No"], 10)} //no uid