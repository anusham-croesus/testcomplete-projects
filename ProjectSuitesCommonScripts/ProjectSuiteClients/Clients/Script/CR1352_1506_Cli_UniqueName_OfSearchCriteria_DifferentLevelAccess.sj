//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :Unicité du nom du critère de recherche par niveau de d'accés
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1506
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1506_Cli_UniqueName_OfSearchCriteria_DifferentLevelAccess()
 {  
    if (client == "CIBC" || client == "BNC"  || client == "US" ){
        Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)
        RestartServices(vServerClients);   
        if(language=="french"){
          var criterion="clients avec VT dif de 0"
          var level="Firme"
        }
        else{
          var criterion="Compte avec valeur totale sup à 0"
          var level="Firm"
        }
    }
    else{//RJ
    if(language=="french"){
        var criterion="Comptes détenant un des deux titres"
        var level="Utilisateur"
      }
      else{
        var criterion="Accounts holding one of two securities"
        var level="User"
      }
    }
   
     var message=GetData(filePath_Clients,"CR1352",169,language)
     var columnName=GetData(filePath_Clients,"CR1352",162,language)
   
     Login(vServerClients, userName, psw, language);
     Get_ModulesBar_BtnClients().Click();
     
     Get_MainWindow().Maximize();
   
     //Afficher la fenêtre "Search Criteria"
     Get_Toolbar_BtnManageSearchCriteria().Click(); 
     Get_WinSearchCriteriaManager_BtnAdd().Click();
     WaitObject(Get_CroesusApp(),"WindowMetricTag","CRITERIA_WINDOW");
     
     //creation de cretere 
     Get_WinAddSearchCriterion_TxtName().Clear();
     Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
     //Get_WinAddSearchCriterion_TxtName().Keys(criterion);
     if (client == "CIBC" || client == "BNC"  || client == "US" ){
       Get_WinAddSearchCriterion_CmbAccess().Click();
       Get_WinAddSearchCriterion_CmbAccess_ItemFirm().Click();   
     }
     Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
     Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
     Get_WinAddSearchCriterion_BtnSave().Click();
   
     Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
    //Vérifier que le critère est sur la liste     
     var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
     var findFilter=false;
          for (i=0; i<= count-1; i++){ 
            if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
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
     
     //Supprimer le critere
     Delete_Criterion(criterion,level)
          
     Get_MainWindow().SetFocus();
     Close_Croesus_SysMenu();
 }
 
 function Delete_Criterion(criterion,level)
 {
     Get_Toolbar_BtnManageSearchCriteria().Click(); 
     Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize(); 
     
     var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
          for (i=0; i<= count-1; i++){ 
            if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion && Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_PartyLevelName()==level){
               Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
               Get_WinSearchCriteriaManager_BtnDelete().Click();
   
               Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
               Get_WinSearchCriteriaManager_BtnClose().Click();    
               break;        
            }             
          } 
    
 }
 
