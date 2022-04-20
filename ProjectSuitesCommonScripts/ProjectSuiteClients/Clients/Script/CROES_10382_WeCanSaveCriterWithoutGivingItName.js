//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/**
        Description : 
                  
                   Menu Recherche - Critères de recherche - Ajouter un critère...
                   Vider le champ Nom et sauvegarder.
                   Retourner dans 
                   Menu Recherche - Critères de recherche - Gérer...
                   Le critère est dans la liste sans nom
                   Le message suivant devrait s'afficher:



    Auteur : Sana Ayaz
    Anomalie:CROES-10382
    Version de scriptage:ref90-07-Co-9--V9-Be_1-co6x
*/

function CROES_10382_WeCanSaveCriterWithoutGivingItName()
{
   try {
       
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        //Se connecter avec GP1859
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
        
        var MessageCROES10382=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "MessageCROES10382", language+client);
        var LevelCROES10382=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "LevelCROES10382", language+client);
        
        Get_ModulesBar_BtnClients().Click();
  
        //afficher la fenêtre  "Ajouter un critère de recherche" en cliquant sur MenuBar – SearchCriteriaSubmenuAddSearchCriterion
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_SearchCriteria().OpenMenu(); 
        Get_MenuBar_Search_SearchCriteria_AddACriterion().Click();
        
        /*  Menu Recherche - Critères de recherche - Ajouter un critère...
                   Vider le champ Nom et sauvegarder.*/
        
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
          
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCountry().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().DblClick();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys("canada");
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_BtnSave().Click();
          /*Les points de vérifications: Vérifier que le message:
          This criterion cannot be saved. Make sure a name is entered and all conditions are completely filled out.
           */
           if(Get_DlgInformation().Exists){
                          
                if(aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, MessageCROES10382))
                  
           
                Get_DlgInformation().Close();
                Get_WinAddSearchCriterion_BtnCancel().Click();
            }          
            else 
                Log.Error("Jira CROES-10382")
            
            Terminate_CroesusProcess();
  
        }
   catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
              Terminate_CroesusProcess();
              Login(vServerClients, userNameGP1859, passwordGP1859, language);
              Get_ModulesBar_BtnClients().Click();
              Get_MenuBar_Search().OpenMenu();
              Get_MenuBar_Search_SearchCriteria().OpenMenu()
              Get_MenuBar_Search_SearchCriteria_Manage().Click();
       
               Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize(); 
     
               var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
                    for (i=0; i<= count-1; i++){ 
                      if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()=="" && Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_PartyLevelName()==LevelCROES10382){
                         Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                         Get_WinSearchCriteriaManager_BtnDelete().Click();
   
                         Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
                         Get_WinSearchCriteriaManager_BtnClose().Click();    
                         break;        
                      }             
                    } 
    

            Terminate_CroesusProcess();
        
         
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
        Get_ModulesBar_BtnClients().Click();
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_SearchCriteria().OpenMenu()
        Get_MenuBar_Search_SearchCriteria_Manage().Click();
       
     Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize(); 
     
     var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
          for (i=0; i<= count-1; i++){ 
            if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()=="" && Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_PartyLevelName()==LevelCROES10382){
               Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
               Get_WinSearchCriteriaManager_BtnDelete().Click();
   
               Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
               Get_WinSearchCriteriaManager_BtnClose().Click();    
               break;        
            }             
          } 
    
        
    }
    
            Terminate_CroesusProcess();
}

