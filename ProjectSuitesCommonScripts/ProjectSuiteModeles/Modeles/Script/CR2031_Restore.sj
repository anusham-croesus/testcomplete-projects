//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Restorer les tolérances pour chacun des modèles utilisés dans CR2031
                  Supprimer la relation CROES-6389
                  Pour Clients NON BNC décocher la case non rachetable pour CVE et ECA
      
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function CR2031_Restore()
{
    try {
      
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
         
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
         
         var relationNameCROES6389=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "relationNameCROES6389", language+client);
         
         var CVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCVE", language+client);
         var ECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityECA", language+client);
         var FTS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "SecurityFTS", language+client);       
                
        //Login
        Log.Message("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();        
        
//        Log.Message("++++++ Réinitialiser les tolérances des modèles de CR2031")
//        var modeles = new Array(modelName1,modelName2,modelName3,modelName4,modelName5,modelName6,modelName7,modelName8,modelName9,modelName10,modelName11)
//        for(i=0; i<modeles.length; i++){
//          Get_ModulesBar_BtnModels().Click();
//          Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);        
//          WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ModelListView_6fed", true]);
//          SetModelTolerances(modeles[i], position1CAD, 0, 0);
//        }
         
        Log.Message("++++++ Supprimer la relation "+relationNameCROES6389)
        DeleteRelationship(relationNameCROES6389);
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071", true]);
        
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);  
        if(client != "BNC"){
          Log.Message("++++++ Décocher la case non rachetable pour les titre "+CVE+ " et "+ECA+" pour clients NON BNC")
          EditNonRedeemableSecurityStatus(CVE, false);
          EditNonRedeemableSecurityStatus(ECA, false);
        }
        else
        {
          Log.Message("++++++ Cocher la case non rachetable pour les titre "+CVE+ ", "+ECA+" et "+FTS+" pour client BNC")
          EditNonRedeemableSecurityStatus(CVE, true);
          EditNonRedeemableSecurityStatus(ECA, true);
          EditNonRedeemableSecurityStatus(FTS, true);
        }
                               
        
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

