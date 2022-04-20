//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA



/**
  Description : Gestion de critères de recherche
  
  Regrouper les scripts suivants:
  CR1352_1511_Cli_Create_SimpleSearchCriteria_FirmAccess
  CR1352_1511_Cli_Create_SimpleSearchCriteria_BranchAccess
  CR1352_1506_Cli_UniqueName_OfSearchCriteria_DifferentLevelAccess
  CR1352_1506_Cli_UniqueName_OfSearchCriteria_SameLevelAccess
  CR1352_1488_Cli_Create_AdvancedSearchCriteria
  
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-19-2020-09-45
*/

 
function CR1352_OptiCroes_1511_1506_1488()
{   
   try{
   
      Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)
      Activate_Inactivate_Pref('ROOSEF',"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
      RestartServices(vServerClients);
      
      Log.Message("se connercter avec Copern");
      Login(vServerClients, userName,psw,language);  
      
      //********************************** Étape 1 : Création de critère simple par niveau d'accés - Niveau Firm. **********************************/
      Log.AppendFolder("Étape 1: Croes-1511 - Création de critère simple par niveau d'accés - Niveau Firm.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1511", "Cas de test TestLink: Croes-1511");  
      //**********************************************************************************************************************************************************************/
      
       var criterion="CR1352_1511_Criterion";
        
       Log.Message("Choisir le module client");
       Get_ModulesBar_BtnClients().Click();
       Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);       
       Get_MainWindow().Maximize();
   
       Log.Message("Afficher la fenêtre Search Criteria");
       Get_Toolbar_BtnManageSearchCriteria().Click();  
       
       Log.Message("creation de cretere "+criterion+" Access Firm");         
       Get_WinSearchCriteriaManager_BtnAdd().Click();
       Get_WinAddSearchCriterion_TxtName().Clear();
       Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
       Get_WinAddSearchCriterion_CmbAccess().Click();
       Get_WinAddSearchCriterion_CmbAccess_ItemFirm().Click();   
       Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
       Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
       Get_WinAddSearchCriterion_BtnSave().Click();       
       Get_WinSearchCriteriaManager_BtnClose().Click();
       
       //Fermer Croesus
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();
       
       Log.Message("Se connecter avec Roosef");
       Login(vServerClients, "ROOSEF", psw, language);
       
       Log.Message("Choisir le module client");
       Get_ModulesBar_BtnClients().Click();
       Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
       
       Log.Message("Afficher la fenêtre Search Criteria");
       Get_Toolbar_BtnManageSearchCriteria().Click();  
       Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
       Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();      
       
       Log.Message("Vérifier que  le critère de recherche est affiché mais en mode consultation");
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay(), "IsEnabled", cmpEqual, true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnEdit(), "VisibleOnScreen", cmpEqual, false)

       Get_WinSearchCriteriaManager_BtnClose().Click();
       
       //Fermer Croesus
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();       
       //Fermer le processus Croesus
       Terminate_CroesusProcess(); 
       
      Log.PopLogFolder();
       
      //********************************** Étape 2 : Création de critère simple par niveau d'accés - Niveau Branch. **********************************/
      Log.AppendFolder("Étape 2: Croes-1511 - Création de critère simple par niveau d'accés - Niveau Branch.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1511", "Cas de test TestLink: Croes-1511");  
      //**********************************************************************************************************************************************************************/
        
      Log.Message("se connercter avec Copern");
      Login(vServerClients, userName,psw,language);
      
      Log.Message("Choisir le module client");
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
       
      Log.Message("Afficher la fenêtre Search Criteria");
      Get_Toolbar_BtnManageSearchCriteria().Click();  
      Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();      
       
      Log.Message("Modifier le critère "+criterion+" Access Branch");
      Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnEdit().Click();
      Get_WinAddSearchCriterion_CmbAccess().Click();
      Get_WinAddSearchCriterion_CmbAccess_ItemBranch().Click();   
      Get_WinAddSearchCriterion_BtnSave().Click(); 
      Get_WinSearchCriteriaManager_BtnClose().Click();
      
      //Fermer Croesus
      Get_MainWindow().SetFocus();
      Close_Croesus_SysMenu();
       
      Log.Message("Se connecter avec Darwic");
      Login(vServerClients, "DARWIC", psw, language);
      Get_ModulesBar_BtnClients().Click();
       
      Log.Message("Afficher la fenêtre Search Criteria");
      Get_Toolbar_BtnManageSearchCriteria().Click();  
      Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
      Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();     
       
      Log.Message("Vérifier que  le critère de recherche est affiché mais en mode consultation");
      aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay(), "IsEnabled", cmpEqual, true)
      aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnEdit(), "VisibleOnScreen", cmpEqual, false)
      Get_WinSearchCriteriaManager_BtnClose().Click();
       
      //Fermer Croesus
      Get_MainWindow().SetFocus();
      Close_Croesus_SysMenu();       
      //Fermer le processus Croesus
      Terminate_CroesusProcess();
      
      Log.PopLogFolder();
      
      //********************************** Étape 3 : Unicité du nom du critère de recherche avec meme niveau de d'accès. **********************************/
      Log.AppendFolder("Étape 3: Croes-1506 - Unicité du nom du critère de recherche avec meme niveau de d'accès.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1506", "Cas de test TestLink: Croes-1506");  
      //**********************************************************************************************************************************************************************/
      
      var message=GetData(filePath_Clients,"CR1352",169,language)
      
      Log.Message("se connercter avec Copern");
      Login(vServerClients, userName,psw,language);
      
      Log.Message("Choisir le module client");
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
       
      Log.Message("Afficher la fenêtre Search Criteria");
      Get_Toolbar_BtnManageSearchCriteria().Click();  
      Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
      
      Log.Message("Ajouter un critère "+criterion+" portant le meme nom et ayant le meme niveau d'accès 'Branch' d'un critère existant");
      Get_WinSearchCriteriaManager_BtnAdd().Click();
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
      Get_WinAddSearchCriterion_CmbAccess().Click();
      Get_WinAddSearchCriterion_CmbAccess_ItemBranch().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSave().WaitProperty("VisibleOnScreen", true, 30000);     
      Get_WinAddSearchCriterion_BtnSave().Click();
     
      var numberOftries=0;  
      while ( numberOftries < 5 && Get_WinSearchCriteriaManager().Exists && !Get_DlgInformation().Exists){
        Get_WinAddSearchCriterion_BtnSave().Click();
        numberOftries++;
      }         
     
     Log.Message("Valider qu'un message d'erreur s'affiche : "+message);  
     Log.Message("CROES-4495")
     //aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,message); //Dans ce cas le fichier Excel n’a pas fonctionné
     if(language=="french")
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,"Un critère de recherche a déjà été enregistré sous ce nom. \r\nVeuillez vérifier le nom du critère dans les deux langues."); 
     else
       aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,"A search criterion has already been saved under this name.\r\nVerify the criterion name in both languages.");
  
     Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
          
     Log.PopLogFolder();
     
     //********************************** Étape 4 : Unicité du nom du critère de recherche avec niveaux de d'accès différents. **********************************/
      Log.AppendFolder("Étape 4: Croes-1506 - Unicité du nom du critère de recherche avec niveaux de d'accès différents.");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1506", "Cas de test TestLink: Croes-1506");  
     //**********************************************************************************************************************************************************************/   
     
     var BranchLevel = GetData(filePath_Clients,"CR1352",77,language);
     var FirmLevel = GetData(filePath_Clients,"CR1352",170,language);
     var columnName=GetData(filePath_Clients,"CR1352",162,language);
     
     Log.Message("Ajouter un critère "+criterion+" portant le meme nom et n'ayant pas le meme niveau d'accès 'Branch' d'un critère existant");
     Get_WinAddSearchCriterion_CmbAccess().Click();
     Get_WinAddSearchCriterion_CmbAccess_ItemFirm().Click();
     Get_WinAddSearchCriterion_BtnSave().WaitProperty("VisibleOnScreen", true, 30000);     
     Get_WinAddSearchCriterion_BtnSave().Click();     
     Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
     
     Log.Message("Vérifier que le critère "+criterion+"est sur la liste  ");   
     var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
     var findFilter=false;
     for (i=0; i<= count-1; i++){ 
      if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion && Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_PartyLevelName()==FirmLevel){
         findFilter=true;             
         break;             
      }             
     } 
     if (findFilter==true)
        Log.Checkpoint("Le critère est sur la liste ");
     else
        Log.Error("Le critère n'est pas sur la liste ");
         
     Log.Message("Vérifier qu' il apparaît dans le gestionnaire de critères de recherche en respectant l'ordre alphabétique");
     Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),columnName,"Description" )// dans Common_functions               
     
     Log.Message("Supprimer les deux critères");
     Delete_Criterion(criterion,BranchLevel);
     Delete_Criterion(criterion,FirmLevel);
     
     Log.PopLogFolder();
     
     //********************************** Étape 5 : Création de critère avancé **********************************/
      Log.AppendFolder("Étape 5: Croes-1488 - Création de critère avancé");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1488", "Cas de test TestLink: Croes-1488");  
     //**********************************************************************************************************************************************************************/   
     
     var advancedCriterion="CR1352_1488";
     
     Log.Message("Ajouter un critère avancé "+advancedCriterion); 
     Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
     Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Clear();
     Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().set_Text(advancedCriterion);
     Log.Message("Jira: TCVE-2004 - un crash ")
     Get_WinCRUSearchCriterionAdvanced_BtnSave().Click();
     WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CRITERIA_INFORMATION")
       
     Log.Message("Vérifier que le critère "+advancedCriterion+" est sur la liste");     
     var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
          var findFilter=false;
          for (i=0; i<= count-1; i++){ 
            if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==advancedCriterion){
               findFilter=true;             
               break;             
            }             
          } 
          if (findFilter==true){
              Log.Checkpoint("Le critère est sur la liste ");
          }
          else{
              Log.Error("Le critère n'est pas sur la liste ");
          }    
   
     Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),columnName,"Description" )// dans Common_functions
     
     Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Restore();
     Get_WinSearchCriteriaManager_BtnClose().Click();
     
     Log.PopLogFolder();        
       
   }
   catch(e) 
   {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
     
   finally
   {   
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();  	  
      
      //Supprimer le critère avancé de BD 
      Delete_FilterCriterion(advancedCriterion,vServerClients)
      Activate_Inactivate_Pref('ROOSEF',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients) 

      if(client=="RJ")
         Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients);
         
      RestartServices(vServerClients);
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();         
      Runner.Stop(true)
   }
 }
 
function Delete_Criterion(criterion,level)
 {          
     var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
     for (i=0; i<= count-1; i++){ 
      if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion && Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_PartyLevelName()==level){
         Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
         Get_WinSearchCriteriaManager_BtnDelete().Click();
   
         Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
         break;        
      }             
    } 
    
 }