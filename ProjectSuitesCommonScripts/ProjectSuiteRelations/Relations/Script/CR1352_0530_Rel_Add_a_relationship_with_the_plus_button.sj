//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables




/**
    Description : Valider l'ajout d'une relation par le bouton « + »
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-530
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0530_Rel_Add_a_relationship_with_the_plus_button()
{
    
    var relationshipNameBtn          = GetData(filePath_Relations, "CR1352", 182, language)
    var relationshipNameClickRight   = GetData(filePath_Relations, "CR1352", 183, language)
    var relationshipNameMenuEdition  = GetData(filePath_Relations, "CR1352", 184, language)
    var relationshipNameCTRLN        = GetData(filePath_Relations, "CR1352", 185, language)
    var relationshipNameBtnStep10    = GetData(filePath_Relations, "CR1352", 186, language)
    
    
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-530", "Lien vers Jira");
        Log.Message("***************************** L'étape 1 *************************************************")
        /*le script a été révisé et remplace les scripts suivants: CCroes-6892, Croes-531, Croes-532, Croes-533
           Croes-603, Croes-2469*/
        Login(vServerRelations, userName, psw, language);
        //Les variables
        var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        Log.Message("***************************** L'étape 2 *************************************************")
        
        //Ajouter une relation par le bouton "+"
        Log.Message("Add the relationship \"" + relationshipNameBtn + "\" with the 'Add' button.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameBtn, 10);
        SearchRelationshipByName(relationshipNameBtn);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipNameBtn + "\" already exists.");
            return;
        }
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["AddDropDownMenu", true, true]);
            
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            
            Log.Message("***************************** L'étape 3 *************************************************")
            
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);  
            Log.Message("Choisir dans Nom complet= Relation_Test")  
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameBtn);
            Log.Message("Choisir le code de CP est BD88")
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click()
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88().Click();  
            Log.Message("Mettre dans le type de la relation :Relation groupée")
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemGroupedRelation().Click();
            Log.Message("Clic sur le bouton OK")
            Get_WinDetailedInfo_BtnOK().Click();
             WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWinAddRelatioShip]);
     
        }
        RestoreAutoTimeOut();
        //Vérifier que la relation a été correctement ajoutée
        Log.Message("Vérifier que la relation a été correctement ajoutée")
        CheckExistenceOfRelationship(relationshipNameBtn);
        
        Log.Message("***************************** L'étape 4 *************************************************") 
        Log.Message("Ajouter une relation a partir du clic right")
        Log.Message("Add the relationship \"" + relationshipNameClickRight + "\" by right-clicking the mouse.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameClickRight, 10);
        SearchRelationshipByName(relationshipNameClickRight);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipNameClickRight + "\" already exists.");
            return;
        }
        else {
            Get_RelationshipsClientsAccountsGrid().ClickR();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["ContextMenu", true, true]);
               
            Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
           WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["ContextMenu", true, true]);
           Log.Message("***************************** L'étape 5 *************************************************")  
            Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
             WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);  
            Log.Message("Choisir dans Nom complet= Relation_Test1")              
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameClickRight);
            Log.Message("Choisir le code de CP est BD88")
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click()
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88().Click();  
            Log.Message("Clic sur le bouton OK")
            Get_WinDetailedInfo_BtnOK().Click();
             WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWinAddRelatioShip]);
  
        }
        RestoreAutoTimeOut();
        //Vérifier que la relation a été correctement ajoutée
        Log.Message("Vérifier que la relation a été correctement ajoutée")
        CheckExistenceOfRelationship(relationshipNameClickRight);
        Log.Message("***************************** L'étape 6 *************************************************")  
              
        //Ajouter une relation par le menu "Édition"
        Log.Message("Add the relationship \"" + relationshipNameMenuEdition + "\" using the Edit menu.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameMenuEdition, 10);
        SearchRelationshipByName(relationshipNameMenuEdition);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipNameMenuEdition + "\" already exists.");
            return;
        }
        else {
            Get_MenuBar_Edit().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["PopupRoot", true, true]);
         
            Get_MenuBar_Edit_AddForRelationshipsAndClients().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["PopupRoot", true, true]);
            Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);
            Log.Message("***************************** L'étape 7 *************************************************")
            Log.Message("Choisir dans Nom complet= "+relationshipNameMenuEdition)
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameMenuEdition);
            Log.Message("Choisir le code de CP est BD88")
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click()
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88().Click();  
            Log.Message("Clic sur le bouton OK")
            Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 5000);
            Get_WinDetailedInfo_BtnOK().Click();
            
            //Dans le cas, si le click ne fonctionne pas  
            var numberOftries=0;  
            while ( numberOftries < 5 && Get_WinDetailedInfo().Exists){
                Get_WinDetailedInfo_BtnOK().Click(); 
                numberOftries++;
            }            
            
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWinAddRelatioShip]);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        }
        RestoreAutoTimeOut();
        //Vérifier que la relation a été correctement ajoutée
        CheckExistenceOfRelationship(relationshipNameMenuEdition);
        
        Log.Message("***************************** L'étape 8 *************************************************")  
        //Ajouter une relation en utilisant le raccourci "CTRL + N"
        Log.Message("Add the relationship \"" + relationshipNameCTRLN + "\" by the shortcut CTRL + N.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCTRLN, 10);
        SearchRelationshipByName(relationshipNameCTRLN);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipNameCTRLN + "\" already exists.");
            return;
        }
        else {
            Get_RelationshipsClientsAccountsGrid().Keys("^n");
           WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);
            Log.Message("***************************** L'étape 9 *************************************************")  
            Log.Message("Choisir dans Nom complet= Relation_Test3")
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCTRLN);
            Log.Message("Choisir le code de CP est BD88")
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().Click()
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88().Click();  
            Log.Message("Clic sur le bouton OK")
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniButton", 2]);
        }
        RestoreAutoTimeOut();
        //Vérifier que la relation a été correctement ajoutée
        CheckExistenceOfRelationship(relationshipNameCTRLN);
        Log.Message("***************************** L'étape 10 *************************************************")  
         //Ajouter une relation par le bouton "+" puis cliquer sur Annuler
        Log.Message("Add the relationship \"" + relationshipNameBtnStep10 + "\" with the 'Add' button.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameBtnStep10, 10);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipNameBtnStep10 + "\" already exists.");
            return;
        }
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["AddDropDownMenu", true, true]);
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]); 
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameBtnStep10);
            Log.Message("***************************** L'étape 11 *************************************************")
            Log.Message("Annuler l'action en cliquant sur Annuler")
            Get_WinDetailedInfo_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniButton", 2]);	
        }
        RestoreAutoTimeOut();
        
        //Vérifier que la relation n'a pas été ajoutée
        Log.Message("Verify that the relationship \"" + relationshipNameBtnStep10 + "\" was not added.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameBtnStep10, 10);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Error("The relationship \"" + relationshipNameBtnStep10 + "\" was added. This is not expected.");
        }
        else {
            Log.Checkpoint("The relationship \"" + relationshipNameBtnStep10 + "\" was not added.");
        }
        RestoreAutoTimeOut();
            
    }
     
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipNameBtn);
        DeleteRelationship(relationshipNameClickRight);
        DeleteRelationship(relationshipNameMenuEdition);
        DeleteRelationship(relationshipNameCTRLN);
        DeleteRelationship(relationshipNameBtnStep10);
        Terminate_CroesusProcess();
    }
        
}



function CheckExistenceOfRelationship(relationshipName)
{
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    Log.Message("Verify that the relationship \"" + relationshipName + "\" was successfully added.");
    SearchRelationshipByName(relationshipName);
    var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    SetAutoTimeOut();
    if (SearchResult.Exists == true){
        Log.Checkpoint("The relationship \"" + relationshipName + "\" was successfully added.");
    }
    else {
        Log.Error("The relationship \"" + relationshipName + "\" was not successfully added.");
    }
    RestoreAutoTimeOut();
}