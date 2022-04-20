//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
       Pour l`automatisation, utiliser les users de différents niveaux : REAGAR, JEFFET, KEYNEJ et UNI00 :
      1. sélectionner un modele puis cliquer sur Criteres de rééquilibrage
      2. cliquer sur Associer/Gérer

      Résultat attendu si critere existe déjà : valider que le niveau d`acces = Équipe de travaille

      3.Sinon, Sauvegarder un critre, par exemple : Pour chaque titre acheter position dans un compte.

      4.Résultat attendu : niveau d`acces reste 'Équipe de travail' apres sauvegarde

      5. Fermer
    Auteur : Sana Ayaz
    Anomalie:BNC-1748
    Version de scriptage:90-04-BNC-59B-9
*/

function BNC_1748_RebalaCriteriaForARepresentaTheDefaultAccessLevelShouldBeWorkgroupJEFFET()
{
 var UserName="JEFFET";
 var PassWord="JEFFET"
 var NameModel="NameModelChBonds"
BNC_1748_RebalaCriteriaForARepresentaTheDefaultAccessLevelShouldBeWorkgroup(UserName,PassWord,NameModel)
}

function BNC_1748_RebalaCriteriaForARepresentaTheDefaultAccessLevelShouldBeWorkgroup(UserName,PassWord,NameModel)
{
    try {
        
        
        var UserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", UserName, "username");
        var PassWord = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", PassWord, "psw");
       
        Login(vServerModeles, UserName, PassWord, language);
       
       
        var NameModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", NameModel, language+client);
        var NameCrietriaModelCROESUS_1748=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NameCrietriaModelCROESUS_1748", language+client);
        var AccesLevelCROESUS_1748=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AccesLevelCROESUS_1748", language+client);
      
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(NameModel);
      
        Get_ModelsGrid().Find("Value",NameModel,10).Click();
        
        
        Get_Models_Details_TabRebalancingCriteria().Click();
        Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
        
        Get_WinRebalancingCriteriaManager_PadHeader_BtnAdd().Click();
        Get_WinAccountRebalancingCriteria_TxtName().Keys(NameCrietriaModelCROESUS_1748);
        Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbNext_ItemDot().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbVerb().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbNext_ItemDot().Click();
        
        Get_WinAccountRebalancingCriteria_BtnSave().Click();

        Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaModelCROESUS_1748,10).Click();
        Get_WinRebalancingCriteriaManager_BtnAssign().Click();
        
        SearchModelByName(NameModel);
        Get_ModelsGrid().Find("Value",NameModel,10).Click();
        Get_Models_Details_TabRebalancingCriteria().Click();
        Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
        //Les points de vérifications
        var NiveaUAcce=Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaModelCROESUS_1748,10).DataContext.DataItem.PartyLevelName.OleValue
        Log.Message(NiveaUAcce)
        if(NiveaUAcce==AccesLevelCROESUS_1748)
        {
          Log.Checkpoint("Le niveau d'accés est équipe de travail")
        
        }
        
        else{
        Log.Error("Le niveau d'accés est équipe de travail, anomalie : BNC_1748")
          
        }
        
         Get_WinRebalancingCriteriaManager_BtnClose().Click();
     
        
      
       var NiveaUAcceTabCROESUS_1748=Get_Models_Details_TabRebalancingCriteriaDgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaModelCROESUS_1748,10).DataContext.DataItem.PartyLevelName.OleValue
       if(NiveaUAcceTabCROESUS_1748==AccesLevelCROESUS_1748)
          {
            Log.Checkpoint("Le niveau d'accés est équipe de travail")
        
          }
        
          else{
          Log.Error("Le niveau d'accés est équipe de travail, anomalie : BNC_1748")
          
          }
        
      
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Terminate_CroesusProcess();
        Login(vServerModeles, UserName, PassWord, language);        
    }
    finally {
        
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(NameModel); 
        Get_Models_Details_TabRebalancingCriteria().Click();
        Get_ModelsGrid().Find("Value",NameModel,10).Click();
        if(Get_Models_Details_DgvDetails().FindChild("Value", NameCrietriaModelCROESUS_1748, 10).Exists){
         Get_Models_Details_DgvDetails().FindChild("Value", NameCrietriaModelCROESUS_1748, 10).Click();
         Get_Models_Details_TabRebalancingCriteria_BtnRemove().Click(); 
        }
     
        Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
        if(Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaModelCROESUS_1748,10).Exists){
        Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaModelCROESUS_1748,10).Click();
        Get_WinRebalancingCriteriaManager_PadHeader_BtnDelete().Click();
        if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73) 
         }
        }
      Get_WinRebalancingCriteriaManager_BtnClose().Click();
      Terminate_CroesusProcess();
    }
}
