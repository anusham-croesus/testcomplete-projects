//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider que le critère ne s’affiche pas automatiquement si la pref =NON, module Modèles
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5743
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Asma Alaoui
*/

function CR2050_5743_Mod_ValidateCriteriaWhenPrefNO()
{   
   try { 
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5743","CR2050");
   
        var criterion =  ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "CodeCP", language+client);
        var test=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "NomCritère_5743", language+client);

        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
        RestartServices(vServerAccounts);
   
        
        
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Accès au module Modèles    
        Get_ModulesBar_BtnModels().Click();
        
        //Cliquer sur le bouton "Gérer les critères de recherche"
        Get_Toolbar_BtnManageSearchCriteria().Click();
        AddCriteria(test,criterion);
        
        //Valider le bouton "Réafficher tout et conserver les crochets" 
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"Exists",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"VisibleOnScreen",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsVisible",cmpEqual, true);
        
        //Valider que les modèles associés au critère de recherhce ont un crochet rouge
        ValidateMatchesCriteriaModel(criterion);
      
        //Fermer l'application  
         Terminate_CroesusProcess();
    
        //se reconnecter à l'application    
        Login(vServerAccounts, userNameKEYNEJ, psw, language);
        Get_ModulesBar_BtnModels().Click(); 
        
      
        //Cliquer sur l'icône "Réafficher tout et conserver les crochets"
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
        
        //Valider les modèles avec le critère de recherche défini
        ValidateMatchesCriteriaModel(criterion);
        
        //fermer l'application  
        Terminate_CroesusProcess();
            
        // Modifier PREF_ENABLE_AUTOMATIC_CRITERIA à NON 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "No", vServerAccounts)    
        RestartServices(vServerAccounts);
        
        //Se connecter à l'application        
        Login(vServerAccounts, userNameKEYNEJ, psw, language);
        
        //Vérifier qu'aucun critère de recherche n'est appliqué

        Get_ModulesBar_BtnModels().Click();
        ValidateNoMatchesCriteriaModel();
      
      }
    catch(e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
       Terminate_CroesusProcess();
       Delete_FilterCriterion(test,vServerAccounts)
       Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
       RestartServices(vServerAccounts); 
       Terminate_CroesusProcess();
      
    }
    
    finally {   
        
      Delete_FilterCriterion(test,vServerAccounts)  
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
      RestartServices(vServerAccounts); 
      Terminate_CroesusProcess();
    }
}


function AddCriteria(test, criterion){
          
    //sur la fenêtre Critères de recheche cliquer sur Ajouter
    Get_WinSearchCriteriaManager_BtnAdd().Click(); 
    
    //Ouverture de la fenêtre "Ajouter un critère de recherche"
    Get_WinCRUSearchCriterionAdvanced().Click();
    
    //Saisir le nom 
    Get_WinAddSearchCriterion_TxtName().Keys(test);
    
    //Sur "Definition" modifier <Verbe> à "ayant"
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
    //Sur <Champ> choisir "Informatif" ensuite " code de CP"
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemIACode().Click();
    
    //Sur <Opérateur> choisir "égal(e) à
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    
    // Entrer la valeur "BD88" 
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(criterion);
    
    
    //Sur <Suivant> choisir le point " . "
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
    // Cliquer sur "Sauvgarder et actualiser
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
   }
     

    //Verifier la pésence des crochets rouges sur les codes de CP BD88
function ValidateMatchesCriteriaModel(criterion)// matchCriteriaModule
{   
     var count = Get_ModelsGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
      {  
       var valueMatchesCriteria=Get_ModelsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriteria;
       var code = Get_ModelsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber.OleValue;
           
        if(valueMatchesCriteria == true && code == criterion)
        
            Log.Checkpoint("Le code de CP dans la ligne "+i+" respecte le critère de recherche c'est le "+code+" qui est récupéré" )
          else 
            Log.Error("la ligne d'indice "+i+" ne respecte le critère de recherche. Le code de CP est : "+code)                    
                 
    } 
    
    
}
    //les crochets ne doivent pas s'afficher
function ValidateNoMatchesCriteriaModel()
{  
     var count = Get_ModelsGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
   {  
       var valueMatchesCriteria=Get_ModelsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriteria;
       var code = Get_ModelsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber.OleValue;
           
        if(valueMatchesCriteria == false)
        
            Log.Checkpoint("Auncun critère de recherche n'est récupéré "+i+" "+code )
          else 
            Log.Error("la ligne d'indice "+i+" ne respecte le critère de recherche. Le code de CP est : "+code)                    
                                   
                 
    } 
     
}
