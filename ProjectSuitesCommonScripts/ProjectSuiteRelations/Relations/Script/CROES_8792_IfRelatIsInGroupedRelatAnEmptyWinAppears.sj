//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  Si ma relation est déjà comprise dans une relation groupée et que je tente néanmoins de l'associer à une relation groupée, j'ai une fenêtre vide qui s'affiche.
                  Selon le comportement standard de Croesus, une message devrait s'afficher à l'écran ou alors, l'option devrait être grisée.
                  Voir CROES-8790

                  Comportement attendu:
                  Ne pas afficher la fenêtre Relations vide, mais plutôt le message suivant;
                  FR: Cette relation ne peut pas être ajoutée à une relation groupée. [OK]
                  EN: This relationship cannot be added to a grouped relationship. [OK]


    Auteur : Sana Ayaz
    Anomalie:CROES-8792
    Version de scriptage:ref90-06-Be-17--V9-AT_1
*/
function CROES_8792_IfRelatIsInGroupedRelatAnEmptyWinAppears()
{
    try {
        
        
      
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        
         var relationGroupeCROES8792=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationGroupeCROES8792", language+client);
         var relationFamillFirm=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationFamillFirm", language+client);
         var CodeCpCROES_8792=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CodeCpCROES_8792", language+client);
         var MsgInformatCROES_8792=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "MsgInformatCROES_8792", language+client);

        //ajouter une relation de type'Relation groupée
         CreatRelationGroup(relationGroupeCROES8792, CodeCpCROES_8792)
  
          //clic droit sur la relation: RELATION_FAMILLE ---> Associer à relation groupée -->choisir la relation groupé crée précédement --->OK
  
            Get_ModulesBar_BtnRelationships().Click();
                Delay(100);
    
                SearchRelationshipByName(relationFamillFirm);
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationFamillFirm,10).ClickR();
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
                Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship().Click();
                Get_WinPickerWindow_DgvElements().Find("Value",relationGroupeCROES8792,10).Click();
                Get_WinPickerWindow_BtnOK().Click();
                Get_WinAssignToARelationship_BtnYes().Click();
                
       /*Essayer de nouveau a associer la relation : RELATION_FAMILLE à relation groupée -->choisir la relation groupé crée précédement 
          
        Résultat obtenu:message bloquant 'Cette relation ne peut etre ajoutée à une relation groupée'  */
        
                SearchRelationshipByName(relationFamillFirm);
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationFamillFirm,10).ClickR();
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
                Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship().Click();
            //Les points de vérification :  message bloquant 'Cette relation ne peut etre ajoutée à une relation groupée'
               if(Get_DlgInformation().Exists)
             {
               if (Get_DlgInformation().VisibleOnScreen)
               { 
                 aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, MsgInformatCROES_8792);
               }
             }
             else
               {
                Log.Error("Le message bloquant ne s'affiche pas");
               }
               
     
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        DeleteRelationship(relationGroupeCROES8792);
        
        Terminate_CroesusProcess(); 
    }
}



function CreatRelationGroup(RelationName, CodCP)
{
   Log.Message("Create the grouped relationship \"" + RelationName + "\".");

    Get_ModulesBar_BtnRelationships().Click();
    Delay(100);
    
    SearchRelationshipByName(RelationName);
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationName, 10);
    if (searchResult.Exists)
        Log.Message("The relationship " + RelationName + " already exists.");
    else {
        Get_Toolbar_BtnAdd().Click();
        Delay(100);
        Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
        Delay(1000);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(RelationName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(RelationName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipKEYNEJ().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemGroupedRelation().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(CodCP);
        Get_WinDetailedInfo_BtnOK().Click();
    }
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipKEYNEJ(){

return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)
}