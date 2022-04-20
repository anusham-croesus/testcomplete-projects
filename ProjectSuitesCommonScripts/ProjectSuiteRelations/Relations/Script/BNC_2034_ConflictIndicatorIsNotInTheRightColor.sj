//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      1.Environnement QA, sélectionner le client 800021(n`importe quel client peu etre utilisé,peu importe la BD)
                      2.clic droit sur sa recine, associer à un modele
                      3.clic droit sur le client puis l`associer à une relation existante
                      4.clic droit sur la relation choisie puis cliquer sur Associer à un modele existant...
                      5. OK , puis sélectionner un modele
                      6. Exploser le + devant le message de conflit

                      Résultat attendu : Message pour indiquer qu`on ne peut pas terminer l`association demandée. La validation à faire est de s`assurer que l`indicateur du conflit est rouge dans 
                      les deux colonnes de conflits (voir validation BNC-2034_rouge rouge conflit 6.PNG)
    Auteur : Sana Ayaz
    Anomalie:BNC-2034
    Version de scriptage:ref90-04-BNC-59B-11
*/
function BNC_2034_ConflictIndicatorIsNotInTheRightColor()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        var NumbClient800021BNC_2034=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumbClient800021BNC_2034", language+client);
        var rootsBNC_2034=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "rootsBNC_2034", language+client);
        var NameModelBNC_2034=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NameModelBNC_2034", language+client);
        var RelationNameBNC_2034=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "RelationNameBNC_2034", language+client);
        var IACodeBNC_2034=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "IACodeBNC_2034", language+client);
        var NameModel1BNC_2034=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NameModel1BNC_2034", language+client);
        var relationsTestCroes_7670=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationsTestCroes_7670", language+client);
        // 1.sélectionner le client 800021(n`importe quel client peu etre utilisé,peu importe la BD)
        Get_ModulesBar_BtnClients().Click();
        Search_Client(NumbClient800021BNC_2034);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumbClient800021BNC_2034, 10).Click();
        //2.clic droit sur sa recine, associer à un modele
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_2034,10).Find("OriginalValue",NumbClient800021BNC_2034,10).Click();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootsBNC_2034,10).Find("OriginalValue",NumbClient800021BNC_2034,10).ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel().Click();
        Get_WinPickerWindow_DgvElements().Find("Value",NameModelBNC_2034,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
      
       
       //Création d'une relation
       CreateRelationship(RelationNameBNC_2034, IACodeBNC_2034);
        //  3.clic droit sur le client puis l`associer à une relation existante
       Get_ModulesBar_BtnClients().Click();
       Search_Client(NumbClient800021BNC_2034);
       Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumbClient800021BNC_2034, 10).Click();
       Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumbClient800021BNC_2034, 10).ClickR();
       
       Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
       Get_ClientsAccountsGrid_ContextualMenu_Relationship_JoinToARelationship().Click();
        Get_WinPickerWindow_DgvElements().FindChild("Value", relationsTestCroes_7670, 10).Click();
        Get_WinPickerWindow_DgvElements().Keys(".");
        Get_WinQuickSearch_TxtSearch().keys(RelationNameBNC_2034);
        Get_WinQuickSearch_BtnOK().Click();
       
       
       Get_WinPickerWindow_DgvElements().Find("Value",RelationNameBNC_2034,10).Click();
       Get_WinPickerWindow_BtnOK().Click();
       Get_WinAssignToARelationship_BtnYes().Click();
       
       
        //4.clic droit sur la relation choisie puis cliquer sur Associer à un modele existant...
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(RelationNameBNC_2034);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationNameBNC_2034, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationNameBNC_2034, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
         // 5. OK , puis sélectionner un modele
        Get_WinPickerWindow_DgvElements().Find("Value",NameModel1BNC_2034,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
       
        
        
        //6. Exploser le + devant le message de conflit
        /*Résultat attendu : Message pour indiquer qu`on ne peut pas terminer l`association demandée. La validation à faire est de s`assurer que l`indicateur du conflit est rouge dans 
                      les deux colonnes de conflits (voir validation BNC-2034_rouge rouge conflit 6.PNG)*/
        var conflitFirstligne=Get_WinAssignToModel_Grid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.IsConflict.OleValue
        if(conflitFirstligne == "Error")
        {
                Log.Checkpoint("L'indice de conflit est en rouge")
              }
              else {Log.Error("L'indice de conflit n'est pas en rouge")
               Log.Message("BNC-2034")}
              
              Get_WinAssignToModel_Grid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
        
      // var croesusRowCount= Get_WinAssignToModel_Grid().WPFObject("RecordListControl", "", 1).Items.get_Count();
		  
		    for (var i = 1; i < 5; i++){
             
               var ColonConflit =Get_WinAssignToModel_Grid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter",i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).Content.OleValue;
              Log.Message(ColonConflit)
			  
              if(ColonConflit == "Error")
              {
                Log.Checkpoint("L'indice de conflit est en rouge")
              }
              else {Log.Error("L'indice de conflit n'est pas en rouge")
               Log.Message("BNC-2034")}
        


         
           }
        
       
        Get_WinAssignToModel_BtnClose().Click()
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(RelationNameBNC_2034);
        Terminate_CroesusProcess(); 
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(NameModelBNC_2034);
        Get_ModelsGrid().Find("Value",NameModelBNC_2034,10).Click();
        
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800021BNC_2034,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800021BNC_2034,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73)
         }
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800021BNC_2034,10).Exists){
           Log.Error("Le compte est toujours associé au modèle")
         }
         else{
           Log.Checkpoint("Le compte n'est plus associé au modèle")}
        DeleteRelationship(RelationNameBNC_2034);
        Terminate_CroesusProcess(); 

        
    }
}

