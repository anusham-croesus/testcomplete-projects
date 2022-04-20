//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description :Création des filtres dont le niveau d’accès est succursale
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1167
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1167_Cli_Create_BranchAccessFilter()
 {
    try{ 

        var filtre="Filtre_Succursale"
             
        Login(vServerClients,"COPERN",psw,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Create_BranchFilter(filtre)           
        
         //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filtre){
             findFilter=true;             
             break;             
          }             
        } 
        if (findFilter==true){
            Log.Checkpoint("Le filtre est sur la liste ");
        }
        else{
            Log.Error("Le filtre n'est pas sur la liste ");  
        }             
              
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click(); 
         
        //*******************************************************************************************************************************************************
        //vérifier que dans la fenêtre Gestions des filtres, le filtre Filtre_Succursale n’apparaît pas Roosef et copern ne font pas partie de la même succursale
        Login(vServerClients, "ROOSEF" , psw ,language);
        Get_ModulesBar_BtnClients().Click();  
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Frankelin Roosevelt (ROOSEF)");
        
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
         //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filtre){
             findFilter=true;             
             break;             
          }             
        } 
        if (findFilter==true){
            Log.Error("Le filtre est sur la liste ");
        }
        else{
            Log.Message("Le filtre n'est pas sur la liste ");
        }   
         Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click(); 
         
            
        //*******************************************************************************************************************************************************
        //vérifier que Dans la fenêtre Gestions des filtres, le Filtre_Succursale  apparaît, il est en mode consultation 
        Login(vServerClients, "DARWIC" , psw ,language);
        Get_ModulesBar_BtnClients().Click();       
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Charles Darwin (DARWIC)");
        
        
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click()
        
         //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres 
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
        if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filtre){
             findFilter=true;             
             break;             
          }             
        } 
        if (findFilter==true){
            Log.Message("Le filtre est sur la liste ");
        }
        else{
            Log.Error("Le filtre n'est pas sur la liste ");  
        }             
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filtre,10).Click();               
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay(), "IsEnabled", cmpEqual, true);
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click(); 
        
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(filtre,vServerClients)//Supprimer le filtre de BD   
    }
 }
 
function Create_BranchFilter(filtre)
{
    Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filtre);
    Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
    Get_WinCRUFilter_CmbAccess_ItemBranch().Click();
    if(client == "US" ){
      SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbField(), "Gender");
      SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbOperator(), "among")
     Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",317,language),10).Click()
    } 
    else{
    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
    Get_WinCRUFilter_CmbField_ItemLanguage().Click()
    Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();       
    Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",60,language),1000).Click()}
    Get_WinCRUFilter_BtnOK().Click();  
}
 