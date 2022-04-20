//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : La fonction double clic dans la section détails
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2072
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ 
 
function CR1352_2072_Cli_DetailSection_dblClick()
{
    try {
        // script spécifique a BNC
        var rootClient="800075";
        var secondaryClient="800076"; 
        var secondaryCompte="800076-FS"; 
        var relationship ="00000";
        var secondaryRelationship="800054-FS"
      
        var roots= GetData(filePath_Clients,"CR1352",202,language);   
        var relationships=GetData(filePath_Clients,"CR1352",205,language);
      
        Login(vServerClients,userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
      
        Get_MainWindow().Maximize();
      
        //sélectionner le client
        Search_Client(rootClient);
      
        //Verifier que la fenêtre info client  de la racine s'affiche 
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("OriginalValue",rootClient,10).DblClick();
        WaitObject(Get_CroesusApp(), "WindowMetricTag", "CLIENT_NOTEBOOK", 2000)  
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpContains,rootClient);
        Get_WinDetailedInfo_BtnCancel().Click();
              
        //Cliquer sur + dans le bloc Racines 
        var width= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualWidth();
        var height=Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualHeight();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click((width+5)-width, (height/2));
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).WaitProperty("IsExpanded", true, 1000)
      
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",secondaryCompte,10).Click();    
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",secondaryCompte,10).DblClick(); 

        Check_Text(secondaryCompte)
      
        Get_WinDetailedInfo_BtnCancel().Click();      
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click((width+5)-width, (height/2));
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).WaitProperty("IsExpanded", true, 1000)
      
        //Cliquer sur + dans le bloc Relations 
        var width= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).get_ActualWidth();
        var height=Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).get_ActualHeight();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click((width+5)-width, (height/2));
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).WaitProperty("IsExpanded", true, 1000)
      
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",secondaryRelationship,10).Click();    
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",secondaryRelationship,10).DblClick(); 
      
        Check_Text(secondaryRelationship)
        Get_WinDetailedInfo_BtnCancel().Click(); 
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"],10).Click((width+5)-width, (height/2));
         
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function Check_Text(component)
{
    aqObject.CheckProperty(Get_WinDetailedInfo().Find(["ClrClassName","WPFControlOrdinalNo"],["UniTextField","4"],10),"Text", cmpEqual, component);
}
 