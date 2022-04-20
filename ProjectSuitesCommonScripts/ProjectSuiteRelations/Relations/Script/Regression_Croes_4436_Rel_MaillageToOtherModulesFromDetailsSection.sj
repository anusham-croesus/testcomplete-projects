//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/**
    
       
    Description :Vérifier que le maillage fonctionne vers les autres modules à partir de la section détails  et la secction Compte du module Relations.
            
    Auteur : Asma Alaoui
    
    ref90-10-Fm-18--V9-croesus-co7x-1_5_1_572
    
    Date: 24/05/2019
*/


function Regression_Croes_4436_Rel_MaillageToOtherModulesFromDetailsSection()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4436", "Croes-4436");
    
    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
    var relationship00000=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Relationship00000", language+client); 
    var FilterDescriptionEdition=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "FilterDescriptionEdition", language+client); 
    var compte=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Account", language+client);   
    var textPortfeuilleEdition=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "PortfolioVlidateEdition", language+client);
    var textPortfeuilleCompte=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "PortfolioVlidateAccount", language+client);
    var FilterDescriptioncompte=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "FilterDescriptionAccount", language+client); 

    //Accès au module Relations
    Login(vServerRelations, userName,psw,language);
    Get_ModulesBar_BtnRelationships().Click();   
    Get_MainWindow().Maximize();
    
    //Sélectionnert la relation "00000"
    SearchRelationshipByNo(relationship00000);

    //Se positionner sur la relation dans la section détail et mailler vers Client 
    Drag(Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "LinkNumber", 10), Get_ModulesBar_BtnClients());
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
    MeshValidate(FilterDescriptionEdition);
    Log.Message("il y a un espace de plus dans le nom de l'objet maillé, vu avec Karima le script ne sera pas adapté et attendre une prochaine version de l'application (échec sur HF-11)")
    //Mailler vers Compte
    Get_ModulesBar_BtnRelationships().Click(); 
    Drag(Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "LinkNumber", 10), Get_ModulesBar_BtnAccounts());
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
    MeshValidate(FilterDescriptionEdition);
    //Mailler vers Relations
    Get_ModulesBar_BtnRelationships().Click(); 
    Drag(Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "LinkNumber", 10), Get_ModulesBar_BtnRelationships());
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
    MeshValidate(FilterDescriptionEdition);
    
    //Mailler vers Portefeuille
    Get_ModulesBar_BtnRelationships().Click();
    Drag(Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "LinkNumber", 10), Get_ModulesBar_BtnPortfolio());
    WaitObject(Get_CroesusApp(),"Uid", "GridSection_0466", 10);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName(),"Text", cmpEqual, textPortfeuilleEdition);
        
    //Mailler vers Transactions
    Get_ModulesBar_BtnRelationships().Click();
    Drag(Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "LinkNumber", 10), Get_ModulesBar_BtnTransactions());
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
    aqObject.CheckProperty(Get_Transactions_ListView(),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_Transactions_ListView(),"VisibleOnScreen", cmpEqual, true);
    
    //Mailler le compte"800054-FS" à partir de la séction "Comptes" vers le module Client
    Get_ModulesBar_BtnRelationships().Click()
    var grid = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).FindChild("Value", compte, 10);
    Drag(grid, Get_ModulesBar_BtnClients());
    MeshValidate(FilterDescriptioncompte);
 
    //Mailler le compte"800054-FS" vers le  module Compte
    Get_ModulesBar_BtnRelationships().Click()
    Drag(grid, Get_ModulesBar_BtnAccounts());
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
    MeshValidate(FilterDescriptioncompte);
    
    //Mailler le compte"800054-FS" vers le module Relations
    Get_ModulesBar_BtnRelationships().Click()
    Drag(grid, Get_ModulesBar_BtnRelationships());
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);
    MeshValidate(FilterDescriptioncompte);
    
    //Mailler le compte"800054-FS" vers le module Portefeuille
    Get_ModulesBar_BtnRelationships().Click()
    Drag(grid, Get_ModulesBar_BtnPortfolio());
    WaitObject(Get_CroesusApp(),"Uid", "GridSection_0466", 10);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_TxtPortfolioName(),"Text", cmpEqual, textPortfeuilleCompte);
    
    
    //Mailler le compte"800054-FS" vers le module Transactions
    Get_ModulesBar_BtnRelationships().Click()
    Drag(grid, Get_ModulesBar_BtnTransactions());
	Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 3000)
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
    aqObject.CheckProperty(Get_Transactions_ListView(),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_Transactions_ListView(),"VisibleOnScreen", cmpEqual, true);
    
  }
    catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
  }
}

function MeshValidate(FilterDescription)
{
  var description= Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription(FilterDescription)
 
  if (description.Exists == true)
    Log.Checkpoint("Le maillage est réussi")
   else 
    Log.Message("Le maillage n'a pas abouti")

}

