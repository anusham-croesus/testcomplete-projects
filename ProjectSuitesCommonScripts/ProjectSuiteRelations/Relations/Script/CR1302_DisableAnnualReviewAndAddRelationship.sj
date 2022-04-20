//USEUNIT CR1302_Prerequisites
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Relationships
    CR                   :  1302
    TestLink             :  Croes-6141
    Description          :  Le but de ce cas est d'ajouter une relation avec la fonction Annual review de désactivée.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.09.Er-11
    Date                 :  19/02/2019
    
*/


function CR1302_DisableAnnualReviewAndAddRelationship() 
{
     try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6141","Lien du Cas de test sur Testlink");
                
                //Activer les prefs au niveau firm PREF_ENABLE_REVIEW=1,PREF_EDIT_NOTE=oui 
                Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
                RestartServices(vServerRelations);
               
                var relationshipName_CR1302 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_relationshipName", language+client);
                var relationshipName_CR1302_Croes6139 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "relationshipName_CR1302_Croes6139", language+client);
                var ColumnAddFrequency = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_ColumnAddFrequency", language+client);
                var ColumnAddLastReview = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_ColumnAddLastReview", language+client);
                var ColumnAddNextReview = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_ColumnAddNextReview", language+client);
    
                //Se connecter à l'application avec COPERN et acceder au module Relations
                Login(vServerRelations, userName, psw, language);
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
                Get_MainWindow().Maximize();
                
                //Vérifier que les colonnes Dern.Révision, Proch. Révision et Fréquence ne sont pas affichées
                checkColumn(ColumnAddFrequency,ColumnAddLastReview,ColumnAddNextReview);
                
                ///Créer une relation 
                CreateRelationship(relationshipName_CR1302_Croes6139);
                SearchRelationshipByName(relationshipName_CR1302_Croes6139);
                
                //Acceder à la fenêtre info de la relation créée
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CR1302_Croes6139, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
                //Points de vérification
                //les champs Fréquence de révision et Prochaine révision ne sont pas affichés
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), "Exists", cmpEqual, false);             
                aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpNextReviewForRelationship(), "Exists", cmpEqual, false);
                
                //Accéder à l'onglet Grid de la section Note
                Get_WinInfo_Notes_TabGrid().Click();
                
                //Cliquer sur le bouton Ajouter dans la section Note 
                Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
                WaitObject(Get_CroesusApp(),"Uid","NoteDetailWindow_2d5e");
                
                //Vérifier que la case à cocher Révision n'est pas affichée
                aqObject.CheckProperty(Get_WinCRUANote_GrpNote_ChkReview(), "VisibleOnScreen", cmpEqual, false);
                
                //Cliquer sur Annuler pour fermer la fenetre Ajouter une note
                Get_WinCRUANote_BtnCancel1().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","NoteDetailWindow_2d5e");
                
                //Cliquer sur Annuler pour fermer la fenêtre Info relation
                Get_WinDetailedInfo_BtnCancel().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
                
      }
      catch (e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
      }         
      finally { 
                //Supprimer les relations créées
                DeleteRelationship(relationshipName_CR1302);
                DeleteRelationship(relationshipName_CR1302_Croes6139);
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();
      }    
      
}

function checkColumn(ColumnLabel1,ColumnLabel2,ColumnLabel3)
{
      Get_RelationshipsGrid_ChCurrency().ClickR();
      Get_RelationshipsGrid_ChCurrency().ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
  
      var SubMenu = Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1);
      var count = SubMenu.DataContext.Items.Item(0).Items.Count;
      for (i=0; i<count; i++)
      {
          var item = SubMenu.DataContext.Items.Item(0).Items.Item(i);
          if (item.Label == ColumnLabel1 || item.Label == ColumnLabel2 || item.Label == ColumnLabel3)
          {
              Log.Error("Au moins une des colonnes "+ColumnLabel1+", "+ColumnLabel2+", "+ColumnLabel3+" est affichée");
          }else
          {
              Log.Checkpoint("Les colonnes "+ColumnLabel1+", "+ColumnLabel2+", "+ColumnLabel3+" ne sont pas affichées");
          }
          
      } 
}

