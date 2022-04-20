//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : Création du modèle et de la relation  
        
    https:https://jira.croesus.com/browse/MOD-1164
    Analyste d'assurance qualité : Christine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.15.2020.5-22
*/

function TCVE1123_CasePrepartionCreateModelsAndRelationship()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/MOD-1164","Cas de test JIRA : MOD-1164") 
                               
                   
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         
            
            var mod_Freecash         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "MODFREECASH", language+client);
            var link_Frecash         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "LINKFREECASH", language+client);
            var modelType            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker           = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            var IACodelink_Frecash   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "IACode", language+client);
           
            var securityBMO          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityBMO", language+client);
            var securityBCE          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityBCE", language+client);
            var securityCM           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityCM", language+client);
            var securityNA           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityNA", language+client);
            var securityRY           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityRY", language+client);
            var securityTD           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "SecurityTD", language+client);
            
            var targetBMO            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "TargetBMO", language+client);
            var targetBCE            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "TargetBCE", language+client);
            var targetCM             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "TargetCM", language+client);
            var targetNA             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "TargetNA", language+client);
            var targetRY             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "TargetRY", language+client);
            var targetTD             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "TargetTD", language+client);
           
            var toleranceMinBMO     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "ToleranceBMO", language+client);
            var toleranceMaxBMO     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "ToleranceBMO", language+client);
            var toleranceMinCM      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "ToleranceCM", language+client);
            var toleranceMaxCM      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "ToleranceCM", language+client);
            var toleranceMinRY      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "ToleranceRY", language+client);
            var toleranceMaxRY      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "ToleranceRY", language+client);
           
            var vmtargetRY          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "VMtargetRY", language+client);
            var vmtargetCM          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "VMtargetCM", language+client);
          
            var account800081LY     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "Acount800081LY", language+client);
            var account800246GT     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1323", "Account800246GT", language+client);
            
//Étape1    
        
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Creation du modele mod_Freecash ");
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle mod_Freecash 
            Log.Message("Créer le modèle mod_Freecash"); 
            Create_Model(mod_Freecash,modelType)
            
            
            
            //Ajouter des position dans leModèle mod_Freecash
            Log.Message("Ajouter des position dans le mod_Freecash"); 
            SearchModelByName(mod_Freecash);
            Drag( Get_ModelsGrid().Find("Value",mod_Freecash,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/3)),73)
            
            //Ajouter une position BMO
            AddPositionToModel_ToleranceAndMarketValue(securityBMO,targetBMO,"",toleranceMinBMO,toleranceMaxBMO,typePicker,"");
            //Ajouter une position BCE
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel_ToleranceAndMarketValue(securityBCE,targetBCE,"","","",typePicker,"");
            //Ajouter une position CM
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel_ToleranceAndMarketValue(securityCM,targetCM,vmtargetCM,toleranceMinCM,toleranceMaxCM,typePicker,"");
            //Ajouter une position NA
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel_ToleranceAndMarketValue(securityNA,targetNA,"","","",typePicker,"");
            //Ajouter une position RY
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel_ToleranceAndMarketValue(securityRY,targetRY,vmtargetRY,toleranceMinRY,toleranceMaxRY,typePicker,"");
            //Ajouter une position TD
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel_ToleranceAndMarketValue(securityTD,targetTD,"","","",typePicker,"");
            
            //Sauvegarder les positions ajoutées dans le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
//Étape2    

            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 2: Creation de la relation link_Freecash ");       
            //Accéder au module Relation 
            Log.Message("Accéder au module Relation");         
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            
           
            //Créer la relation RJ3 
            Log.Message("Créer la relation link_Frecash"); 
            CreateRelationship(link_Frecash, IACodelink_Frecash); 
            
            Log.Message("Associer les comptes" + account800081LY + "et"  + account800246GT + "à la relation " + link_Frecash);
            JoinAccountToRelationship(account800081LY, link_Frecash);
            JoinAccountToRelationship(account800246GT, link_Frecash);
                  
                  
        
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


function AddPositionToModel_ToleranceAndMarketValue(security,percentage,marketValue,tolMin,tolMax,typePicker,securityDescription){

  Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
  Get_SubMenus().Find("Text",typePicker,10).Click();
  Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(security);
  Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
  if(Get_SubMenus().Exists){
      if(Trim(VarToStr(securityDescription))!== "")
         Get_SubMenus().Find("Value",securityDescription,10).DblClick();
      else
         Get_SubMenus().Find("Value",security,10).DblClick();
  }
  Delay(1500)
  Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentage);
  Get_WinAddPositionSubmodel_TxtMarketValue().Keys(marketValue)
  Get_WinAddPositionSubmodel_TxtToleranceMin().Keys(tolMin);
  Get_WinAddPositionSubmodel_TxtToleranceMax().Keys(tolMax);
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
}
