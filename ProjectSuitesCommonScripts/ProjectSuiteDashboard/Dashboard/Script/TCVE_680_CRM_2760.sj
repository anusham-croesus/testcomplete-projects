//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions



/**
    Description : Automatisation du jira : CRM-2760 
    Auteur : Youlia Raisper 
*/
function TCVE_680_CRM_2760()
{
    try {
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6561");
                        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var creterionName= ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "creterionName", language+client);
        var comboBoxRelationships= ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "comboBoxRelationships", language+client);
        var comboBoxClients= ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "comboBoxClients", language+client);
        var comboBoxAccounts=ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "comboBoxAccounts", language+client);
        
        //L'étape 1
        Log.Message("Se connecter avec keynej");
        Login(vServerDashboard, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        
        Log.Message("Vider Dashboard");
        Clear_Dashboard();
        
          //L'étape 2        
        Log.Message("Dans le module Dashboard , Cliquer sur le bouton Ajouter un tableau");
        Get_Toolbar_BtnAdd().Click();
        
        SetAutoTimeOut();
        if(!Get_DlgAddBoard().Exists){
          Log.Error("La fenêtre ajouter un tableau ne s'affiche pas ");
        }else{
          Log.Checkpoint("La fenêtre ajouter un tableau s'affiche ");
        }
        RestoreAutoTimeOut();
        
        Log.Message("Cliquer sur l'option : basé sur un critére  + OK ");
        Get_DlgAddBoard_TvwSelectABoard_BasedOnACriterion().Click();
        Get_DlgAddBoard_BtnOK().Click();
        
        Log.Message("Créer le critère de recherche : Liste des relations  ayant une valeur totale supérieure à 1000000");
        Log.Message("Remplir le champ nom : Critère_Relation");
        Log.Message("Sauvegarder et actualiser");        
        CreateCriterion(comboBoxRelationships, creterionName);
        
        Log.Message("Maximizer le tableau");
        BoardMax();
        
        Log.Message("Vérifier que le critère retourne plus que 3 items");
        var criteriaBasedBoard =Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("GenericCriteriaBasedBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1)
        if (criteriaBasedBoard.Items.Count > 0){
          Log.Checkpoint("le critère retourne plus que 3 items");
        }else{
          Log.Error("le critère ne retourne pas plus que 3 items");
        }
                       
        //L'étape 3                       
        Log.Message("sélectionner 3 premières relations");
        SelectFirstTreeitems(); 

        Log.Message("Récupérer les numéros de trois premiers items ");        
        item1=criteriaBasedBoard.Items.Item(0).DataItem.LinkNumber;
        Log.Message(item1);
        var item2=criteriaBasedBoard.Items.Item(1).DataItem.LinkNumber;
        Log.Message(item2);
        var item3=criteriaBasedBoard.Items.Item(2).DataItem.LinkNumber;
        Log.Message(item3);

        Log.Message("mailler les vers le module Relations");
        Get_MenuBar_Modules().Click()
        Get_MenuBar_Modules_Relationships().Click();
        Get_MenuBar_Modules_Relationships_DragSelection().Click(); 
              
        
        Log.Message("Vérifier les trois relations s'affiichent dans le module Relations");
        CheckToolTip("relations",item1,item2,item3);     
       
          //L'étape 4
        //******************************************** Retourner dans le module dashboard ***********************************************
        Log.Message("Retourner dans le module dashboard");
        Get_ModulesBar_BtnDashboard().Click();        
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);       
        
        Log.Message("sélectionner les trois relations");
        SelectFirstTreeitems(); 
        
        Log.Message("mailler les vers le module Clients");
        Get_MenuBar_Modules().Click()
        Get_MenuBar_Modules_Clients().Click();
        Get_MenuBar_Modules_Clients_DragSelection().Click(); 
        
        
        Log.Message("ToolTip contient les 3 relations.");
        CheckToolTip("relations",item1,item2,item3);
      
        //L'étape 5
        //******************************************** Retourner dans le module dashboard ***********************************************        
        Log.Message("Retourner dans le module dashboard");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        
        Log.Message("sélectionner les trois relations ");
        SelectFirstTreeitems(); 

        Log.Message("mailler les vers le module Comptes");
        Get_MenuBar_Modules().Click()
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click(); 

        Log.Message("ToolTip contient les 3 relations.");
        CheckToolTip("relations",item1,item2,item3);

        //L'étape 6
        //********************************************************************************************************************************
        //*****************************Refaire les pas (2 et 3)  pour les clients ( mailler vers le module clients)***********************
        Log.Message("Retourner dans le module dashboard");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        
        Log.Message("Clicker sur le crayon pour modifier le ");
        BoardEdit();
        
        Log.Message("Créer le critère de recherche : Liste des clients  ayant une valeur totale supérieure à 1000000");
        Log.Message("Remplir le champ nom : Criterion_ClientsCRM2760");
        Log.Message("Sauvegarder et actualiser");
        
        CreateCriterion(comboBoxClients);
        Log.Message("Vérifier que le critère retourne plus que 3 items");
        var criteriaBasedBoard =Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("GenericCriteriaBasedBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1)
        if (criteriaBasedBoard.Items.Count > 0){
          Log.Checkpoint("le critère retourne plus que 3 items");
        }else{
          Log.Error("le critère ne retourne pas plus que 3 items");
        }
                               
        Log.Message("sélectionner les trois clients");
        SelectFirstTreeitems(); 
        
        Log.Message("Récupérer les numéros de trois premiers items ");
        var item1=criteriaBasedBoard.Items.Item(0).DataItem.ClientNumber;
        Log.Message(item1);
        var item2=criteriaBasedBoard.Items.Item(1).DataItem.ClientNumber;
        Log.Message(item2);
        var item3=criteriaBasedBoard.Items.Item(2).DataItem.ClientNumber;
        Log.Message(item3);
        
        Log.Message("mailler les vers le module Clients");
        Get_MenuBar_Modules().Click()
        Get_MenuBar_Modules_Clients().Click();
        Get_MenuBar_Modules_Clients_DragSelection().Click(); 
        
        Log.Message("Vérifier si ToolTip contient les 3 clients");
        CheckToolTip("clients",item1,item2,item3);

        //L'étape 7
        //********************************************************************************************************************************
        //*****************************Refaire les pas (2 et 3)  pour les accounts ( mailler vers le module accounts)*********************
        Log.Message("Retourner dans le module dashboard");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        
        Log.Message("Clicker sur le crayon pour modifier le ");
        BoardEdit();
        
        CreateCriterion(comboBoxAccounts);
        Log.Message("Vérifier que le critère retourne plus que 3 items");
        var criteriaBasedBoard =Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("GenericCriteriaBasedBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1)
        if (criteriaBasedBoard.Items.Count > 0){
          Log.Checkpoint("le critère retourne plus que 3 items");
        }else{
          Log.Error("le critère ne retourne pas plus que 3 items");
        }
        
        Log.Message("sélectionner les trois accounts");
        SelectFirstTreeitems(); 
        
        Log.Message("Récupérer les numéros de trois premiers items ");
        var item1=criteriaBasedBoard.Items.Item(0).DataItem.AccountNumber;
        Log.Message(item1);
        var item2=criteriaBasedBoard.Items.Item(1).DataItem.AccountNumber;
        Log.Message(item2);
        var item3=criteriaBasedBoard.Items.Item(2).DataItem.AccountNumber;
        Log.Message(item3);  
        
        Log.Message("mailler les vers le module Account");
        Get_MenuBar_Modules().Click()
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click(); 
                        
        Log.Message("ToolTip contient les 3 comptes");
        CheckToolTip("comptes",item1,item2,item3);
        

         //********************************************************************************************************************************
        //***************************** ****************Suppression de critère ************************************************************
        Log.Message("Retourner dans le module dashboard");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        BoardClose();
        
        Log.Message("Dans le module Dashboard , Cliquer sur le bouton Ajouter un tableau");
        Get_Toolbar_BtnAdd().Click();
        Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", creterionName]).Click();
        Get_DlgAddBoard_BtnDelete().Click();
        
        SetAutoTimeOut();
        if(Get_DlgAddBoard_TvwSelectABoard().FindChild(["ClrClassName", "WPFControlText"], ["TreeViewItem", creterionName]).Exists){
          Log.Error("Le tableau n'a pas été supprimé");
        }else{
          Log.Checkpoint("Le tableau a été supprimé");
        }        
        RestoreAutoTimeOut();
        
        Get_DlgAddBoard_BtnOK().Click();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function SelectFirstTreeitems()
{
    //Ajout de pause et Refresh
    Delay(5000);
    Sys.Refresh();
    var criteriaBasedBoard =Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("GenericCriteriaBasedBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1)
    criteriaBasedBoard.Refresh();
    criteriaBasedBoard.FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click();
    criteriaBasedBoard.FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click(-1, -1, skCtrl);
    criteriaBasedBoard.FindChild(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","3"],10).Click(-1, -1, skCtrl);
}

function BoardMax()
{
    var criteriaBasedBoard =Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("GenericCriteriaBasedBoard", "", 1)
    var ControlWidth= criteriaBasedBoard.get_ActualWidth()
    var ControlHeight= criteriaBasedBoard.get_ActualHeight()
    Log.Message(ControlWidth)
    Log.Message(ControlHeight)
    for (i=1; i<=1; i++) {criteriaBasedBoard.Click(ControlWidth-35,5)}
}

function BoardClose()
{
    var criteriaBasedBoard =Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("GenericCriteriaBasedBoard", "", 1)
    var ControlWidth= criteriaBasedBoard.get_ActualWidth()
    var ControlHeight= criteriaBasedBoard.get_ActualHeight()
    Log.Message(ControlWidth)
    Log.Message(ControlHeight)
    for (i=1; i<=1; i++) {criteriaBasedBoard.Click(ControlWidth-10,5)}
}

function BoardEdit()
{
    var criteriaBasedBoard =Aliases.CroesusApp.winMain.DashboardPlugin.Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("GenericCriteriaBasedBoard", "", 1)
    var ControlWidth= criteriaBasedBoard.get_ActualWidth()
    var ControlHeight= criteriaBasedBoard.get_ActualHeight()
    Log.Message(ControlWidth)
    Log.Message(ControlHeight)
    for (i=1; i<=1; i++) {criteriaBasedBoard.Click(ControlWidth-55,5)}
}

function CreateCriterion(comboBox, creterionName){

    SelectComboBoxItem(Get_WinAddSearchCriterion_CmbModule(), comboBox)
        
    if (Trim(VarToStr(creterionName)) !== ""){
      Get_WinAddSearchCriterion_TxtName().Keys(creterionName);
    }        
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().DblClick();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys("100000");
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();

}


function CheckToolTip(itemsText,item1,item2,item3){
   //Ajout de pause dynamique et affichage de l'info bulle
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).WaitProperty("DataContext.Value.Count", 3, 5000);
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).HoverMouse();
   Get_SubMenus();
   Delay(1000);
   
   if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.Value.Count==3){
      Log.Checkpoint("le critère contient les 3"+ itemsText +"");
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpContains,item1);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpContains,item2);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpContains,item3);
          
   }else{
      Log.Error("le critère ne contenant pas  les 3 "+ itemsText +".Jira:CRM-2760");
   }
}



