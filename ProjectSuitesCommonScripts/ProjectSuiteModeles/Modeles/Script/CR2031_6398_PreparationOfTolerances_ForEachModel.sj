//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Préparation des tolérances pour chacun des modèles
    
    --IMPORTANT

      Il est requis pour la mainline FM (bâtiesur une version ER et moins) d'ajuster les tolérances de chacun des modèles utiliser pour les cas de tests auto du CR2031.
      à partir du moment ou les clients auront tous la FM, (c'est à dire version FM bâtie sur un FM ) il ne sera plus nécessaire d'exécuter ce CAS 
      car les tolérances seront déjà dans la BD de référence.
      
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6398
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-11
*/

function CR2031_6398_PreparationOfTolerances_ForEachModel()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6398","Cas de test TestLink : Croes-6398") 
                               
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
         var modelName1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_PRIN_REM_BL", language+client);
         var modelName2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_REEQ_TOTAL", language+client);
         var modelName3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_RACH_CRITERE", language+client);
         var modelName4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_RESER_LIQUID", language+client);
         var modelName5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_GESTI_RETRAI", language+client);
         var modelName6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_PANIER_RECHA", language+client);
         var modelName7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_MON_MIN_POSI", language+client);
         var modelName8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_SOUS_MODELE", language+client);
         var modelName9=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_MODEL_PARENT", language+client);
         var modelName10=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_SEGMENT", language+client);
         var modelName11=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_TAUX_CH_PRIX", language+client);
                  
         var toleranceMinMod1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD1", language+client);
         var toleranceMaxMod1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD1", language+client);
         var toleranceMinMod2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD2", language+client);
         var toleranceMaxMod2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD2", language+client);
         var toleranceMinMod3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD3", language+client);
         var toleranceMaxMod3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD3", language+client);
         var toleranceMinMod4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD4", language+client);
         var toleranceMaxMod4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD4", language+client);
         var toleranceMinMod5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD5", language+client);
         var toleranceMaxMod5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD5", language+client);
         var toleranceMinMod6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD6", language+client);
         var toleranceMaxMod6=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD6", language+client);
         var toleranceMinMod7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD7", language+client);
         var toleranceMaxMod7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD7", language+client);
         var toleranceMinMod8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD8", language+client);
         var toleranceMaxMod8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD8", language+client);
         var toleranceMinMod9=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD9", language+client);
         var toleranceMaxMod9=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD9", language+client);
         var toleranceMinMod10=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD10", language+client);
         var toleranceMaxMod10=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD10", language+client);
         var toleranceMinMod11=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD11", language+client);
         var toleranceMaxMod11=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD11", language+client);
         
                
        //Login
        Log.Message("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);        
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks pour enlever les filtres s'ils existent") //Enlever les filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ModelListView_6fed", true]);
        
        //Modifier les tolérances pour les modèles
        SetModelTolerances(modelName1, position1CAD, toleranceMinMod1, toleranceMaxMod1);
        SetModelTolerances(modelName2, position1CAD, toleranceMinMod2, toleranceMaxMod2);
        SetModelTolerances(modelName3, position1CAD, toleranceMinMod3, toleranceMaxMod3);
        SetModelTolerances(modelName4, position1CAD, toleranceMinMod4, toleranceMaxMod4);
        SetModelTolerances(modelName5, position1CAD, toleranceMinMod5, toleranceMaxMod5);
        SetModelTolerances(modelName6, position1CAD, toleranceMinMod6, toleranceMaxMod6);
        SetModelTolerances(modelName7, position1CAD, toleranceMinMod7, toleranceMaxMod7);
        SetModelTolerances(modelName8, position1CAD, toleranceMinMod8, toleranceMaxMod8);
        SetModelTolerances(modelName9, position1CAD, toleranceMinMod9, toleranceMaxMod9);
        SetModelTolerances(modelName10, position1CAD, toleranceMinMod10, toleranceMaxMod10);
        SetModelTolerances(modelName11, position1CAD, toleranceMinMod11, toleranceMaxMod11);
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));   
               
    }
    finally {
  		 //Fermer le processus Croesus
       Terminate_CroesusProcess();         
       Runner.Stop(true)
    }
}

function SetModelTolerances(model, positionSolde, tolMin, tolMax)
{
  Log.Message("*** Sélectionner le modele "+model+" et mailler dans Portefeuille");
  SearchModelByName(model);
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ModelListView_6fed", true]);
  FindResult = Get_ModelsGrid().Find("Value",model,10);
  if(!FindResult.Exists){
    Log.Error("Le modèle "+model+" n'existe pas.");
    return;
  }
  Drag(Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
  
  var ModelMinPercent = Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).DataContext.DataItem.ModelMinPercent.OleValue;
  var ModelMaxPercent = Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).DataContext.DataItem.ModelMaxPercent.OleValue;
  
  Log.Message("Séléctionner la position solde et cliquer sur Info");
  Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).Click();
  Get_PortfolioBar_BtnInfo().click();
  if(Get_DlgConfirmation().Exists){
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(2/3)),73); 
  }
  
  Log.Message("Sous la colonne écart : Modifier Tolérance min. (%) = "+tolMin+" - Tolérance max. (%) = "+tolMax);
  Get_WinPositionInfo_GrpPositionInformation_TxtToleranceMin().Set_Text(tolMin);
  Get_WinPositionInfo_GrpPositionInformation_TxtToleranceMax().Set_Text(tolMax);
  Get_WinPositionInfo().Click();
  Get_WinPositionInfo_BtnOK().WaitProperty("IsEnabled", true, 3000); 
  Get_WinPositionInfo_BtnOK().Click();
  
  Get_PortfolioBar_BtnSave().Click();
  Get_WinWhatIfSave_BtnOK().Click();
  
  //Vérifier que les valeurs de Min. Target (%) et Max. Target (%) ont été changés suite au modification de tolérances.  
  var ModelMinPercentResult = ModelMinPercent - StrToFloat(aqString.Replace(tolMin, ",", "."));
  var ModelMaxPercentResult = ModelMaxPercent + StrToFloat(aqString.Replace(tolMax, ",", "."));
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).DataContext.DataItem,"ModelMinPercent",cmpEqual, VarToFloat(ModelMinPercentResult));
  aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",positionSolde,10).DataContext.DataItem,"ModelMaxPercent",cmpEqual, VarToFloat(ModelMaxPercentResult));
  
  Log.Message("Retourner dans modèle et cocher la case Actif")
  Get_ModulesBar_BtnModels().Click();
  Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);  
  ActivateDeactivateModel(model, true);
}


