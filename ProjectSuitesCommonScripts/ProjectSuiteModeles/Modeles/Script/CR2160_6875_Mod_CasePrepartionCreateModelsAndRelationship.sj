//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : Création du modèle et de la relation pour cas  
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6875
    Analyste d'assurance qualité : CaroleT
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.15.2020.3-8
*/

function CR2160_6875_Mod_CasePrepartionCreateModelsAndRelationship()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("//jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6875","Cas de test TestLink : Croes-6875") 
                               
                   
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         
            
            var modelNameRJ1     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "ModelNameRJ1", language+client);
            var modelNameRJ4     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "ModelNameRJ4", language+client);
            var relationNameRJ3  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "RelationshipNameRJ3", language+client);
            var modelType        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            var IACodeRelRJ3     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "IACodeRelRJ3", language+client);
           
            var securityAAPL     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "SecurityAAPL", language+client);
            var securityLB       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "SecurityLB", language+client);
            var securityMSFT     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "SecurityMSFT", language+client);
            var securityNA       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "SecurityNA", language+client);
            var securityDIS      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "SecurityDIS", language+client);
            
            
            var targetAAPL   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "PercentageAAPL", language+client);
            var targetLB     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "PercentageLB", language+client);
            var targetMSFT   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "PercentageMSFT", language+client);
            var targetNA     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "PercentageNA", language+client);
            var targetDIS    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "PercentageDIS", language+client);
            var targetNA2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "PercentageNA2", language+client);
            
            var account300012NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Acount300012NA", language+client);
            var account600003NA     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "Account600003NA", language+client);
            
//Étape1    
        
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle RJ1 
            Log.Message("Créer le modèle RJ1"); 
            Create_Model(modelNameRJ1,modelType)
            
            
            
            //Ajouter des position dans leModèle RJ1
            Log.Message("Ajouter des position dans leModèle RJ1"); 
            SearchModelByName(modelNameRJ1);
            Drag( Get_ModelsGrid().Find("Value",modelNameRJ1,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/3)),73)
            
            //Ajouter une position AAPL
            AddPositionToModel(securityAAPL,targetAAPL,typePicker,"")
            //Ajouter une position LB
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityLB,targetLB,typePicker,"")
            //Ajouter une position MSFT
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityMSFT,targetMSFT,typePicker,"")
            //Ajouter une position NA
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(securityNA,targetNA,typePicker,"")
            
            //Sauvegarder les positions ajoutées dans le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
//Étape2
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            
             //Créer le modèle RJ4 
            Log.Message("Créer le modèle RJ4 ");
            Create_Model(modelNameRJ4,modelType)
            
            //Ajouter des position dans leModèle RJ4
            Log.Message("Ajouter des position dans leModèle RJ1"); 
            SearchModelByName(modelNameRJ4);
            Drag( Get_ModelsGrid().Find("Value",modelNameRJ4,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/3)),73)
            
            
             //Ajouter une position NA 
             AddPositionToModel(securityNA,targetNA2,typePicker,"")
             //Ajouter une position DIS
             Get_Toolbar_BtnAdd().Click();
             AddPositionToModel(securityDIS,targetDIS,typePicker,"")
             //Sauvegarder les positions ajoutées dans le modèle
             Get_PortfolioBar_BtnSave().CLick();
             Get_WinWhatIfSave_BtnOK().CLick();
            
            
//Étape3            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Relation");         
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            
           
            //Créer la relation RJ3 
            Log.Message("Créer la relation RJ3"); 
            CreateRelationship(relationNameRJ3, IACodeRelRJ3); 
            
            Log.Message("Associer les comptes" + account300012NA + "et"  + account600003NA + "à la relation " + relationNameRJ3);
            JoinAccountToRelationship(account300012NA, relationNameRJ3);
            JoinAccountToRelationship(account600003NA, relationNameRJ3);
                  
                  
        
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
		    
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();         
        
    }
}



