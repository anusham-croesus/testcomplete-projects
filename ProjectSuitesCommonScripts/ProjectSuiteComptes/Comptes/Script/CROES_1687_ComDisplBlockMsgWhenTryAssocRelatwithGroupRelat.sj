//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Étapes de test auto pour couvrir le cas mentionné par Anne:

                            1.ajouter deux relations régulieres(#1 et #2)
                            2.sélectionner le compte 800292-RE
                            3.clic droit sur 800292-RE, Relation----> Associer à une relation...
                            4.associer aux deux relations ajoutées précédemmment
                            5.ajouter une relation de type'Relation groupée' (#3)
                            6.clic droit sur la relation #1, Relation ---> Associer à relation groupée -->choisir la relation #3 --->OK
                            7.clic droit sur la relation #2, Relation----> Associer à relation groupée

                            Résultat attendu : message bloquant 'Cette relation ne peut etre ajoutée à une relation groupée'


    Auteur : Sana Ayaz
    Anomalie:CROES-1687
    Version de scriptage:ref90-06-Be-17--V9-AT_1-
*/
function CROES_1687_ComDisplBlockMsgWhenTryAssocRelatwithGroupRelat()
{
    try {
        
        
      
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
         var RELATIONSHIPCROES1687_1=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "RELATIONSHIPCROES1687_1", language+client);
         var RELATIONSHIPCROES1687_2=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "RELATIONSHIPCROES1687_2", language+client);
         var relationGroupeCROES1687=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "relationGroupeCROES1687", language+client);
         var CodeCpCROES_1687=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "CodeCpCROES_1687", language+client);
         var NumComp800228FS=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "NumComp800228FS", language+client);
         var MsgInformatCROES_1687=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "MsgInformatCROES_1687", language+client);

    
          CreatRelation(RELATIONSHIPCROES1687_1,CodeCpCROES_1687);
          CreatRelation(RELATIONSHIPCROES1687_2,CodeCpCROES_1687);
  

         //Assigner la relation relationship1 au compte 800228-FS
         Get_ModulesBar_BtnAccounts().Click();
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
         Search_Account(NumComp800228FS);
         Get_RelationshipsClientsAccountsGrid().Find("Value",NumComp800228FS,10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
         Get_ClientsAccountsGrid_ContextualMenu_Relationship_JoinToARelationship().Click();
   
       
          Get_WinPickerWindow_DgvElements().Keys("F"); 
          WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
          Get_WinQuickSearch_TxtSearch().Clear();
          Get_WinQuickSearch_TxtSearch().Keys(RELATIONSHIPCROES1687_1);
          
          Get_WinQuickSearch_BtnOK().Click()  
   
   
   
         Get_WinPickerWindow_DgvElements().Find("Value",RELATIONSHIPCROES1687_1,10).Click();
         Get_WinPickerWindow_BtnOK().Click();
         Get_WinAssignToARelationship_BtnYes().Click();
        //Assigner la relation relationship2 au compte 800228-FS
         Get_ModulesBar_BtnAccounts().Click();
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
         Search_Account(NumComp800228FS);
         Get_RelationshipsClientsAccountsGrid().Find("Value",NumComp800228FS,10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
         Get_ClientsAccountsGrid_ContextualMenu_Relationship_JoinToARelationship().Click();
   
   
          Get_WinPickerWindow_DgvElements().Keys("F"); 
          WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
          Get_WinQuickSearch_TxtSearch().Clear();
          Get_WinQuickSearch_TxtSearch().Keys(RELATIONSHIPCROES1687_2);
          
          Get_WinQuickSearch_BtnOK().Click()  
   
   
         Get_WinPickerWindow_DgvElements().Find("Value",RELATIONSHIPCROES1687_2,10).Click();
         Get_WinPickerWindow_BtnOK().Click();
         Get_WinAssignToARelationship_BtnYes().Click();
   
        //ajouter une relation de type'Relation groupée' (#3)
         CreatRelationGroup(relationGroupeCROES1687, CodeCpCROES_1687)
  
          //clic droit sur la relation 1, Relation ---> Associer à relation groupée -->choisir la relation groupé crée précédement --->OK
  
            Get_ModulesBar_BtnRelationships().Click();

                Delay(100);
    
                SearchRelationshipByName(RELATIONSHIPCROES1687_1);
                Get_RelationshipsClientsAccountsGrid().Find("Value",RELATIONSHIPCROES1687_1,10).ClickR();
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
                Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship().Click();
                Get_WinPickerWindow_DgvElements().Find("Value",relationGroupeCROES1687,10).Click();
                Get_WinPickerWindow_BtnOK().Click();
                Get_WinAssignToARelationship_BtnYes().Click();
          
          
            /*clic droit sur la relation 2, Relation ---> Associer à relation groupée
             Résultat attendu : message bloquant 'Cette relation ne peut etre ajoutée à une relation groupée'
            */ 
                SearchRelationshipByName(RELATIONSHIPCROES1687_2);
                Get_RelationshipsClientsAccountsGrid().Find("Value",RELATIONSHIPCROES1687_2,10).ClickR();
                Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
                Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship().Click();
            //Les points de vérification :  message bloquant 'Cette relation ne peut etre ajoutée à une relation groupée'
               if(Get_DlgInformation().Exists)
             {
               if (Get_DlgInformation().VisibleOnScreen)
               { 
                 aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, MsgInformatCROES_1687);
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
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        DeleteRelationship(RELATIONSHIPCROES1687_1);
        DeleteRelationship(RELATIONSHIPCROES1687_2);
        DeleteRelationship(relationGroupeCROES1687);
        Terminate_CroesusProcess(); 
    }
}

function CreatRelation(RelationName, CodCP)
{
Get_ModulesBar_BtnRelationships().Click();
Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();  
   
     Log.Message("Create the relationship \"" + RelationName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
    SearchRelationshipByName(RelationName);
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationName, 10);
    if (searchResult.Exists){
        Log.Message("The relationship " + RelationName + " already exists.");
        return;
    }
    
    Get_Toolbar_BtnAdd().Click();
    Delay(100);
    Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
    Delay(1000);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(RelationName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(RelationName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(CodCP);
    
    Get_WinDetailedInfo_BtnOK().Click();
  

}

function CreatRelationGroup(RelationName, CodCP)
{
   Log.Message("Create the grouped relationship \"" + RelationName + "\".");

    Get_ModulesBar_BtnRelationships().Click();
    Delay(100);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
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
