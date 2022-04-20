//USEUNIT CR1302_AddFrequencyAndValidateNextRevisionDate
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 




/**
    Module               :  Relationships
    CR                   :  1302
    TestLink             :  Croes-6147
    Description          :  Le but de ce cas est d'ajouter une relation avec la fonction Annual review et de créer des critères sur les champs du CR1302 Annual review.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.09.Er-11
    Date                 :  18/02/2019
    
*/


function CR1302_CreateAndEditSearchCriteriaWithAnnualReview() 
{
     try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6147","Lien du Cas de test sur Testlink");
               
                var relationshipName_CR1302 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_relationshipName", language+client);
                var IACode_CR1302 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_IACode", language+client);
                var languageRelation = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_languageRelation", language+client);
                var reviewFrequency = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_reviewFrequency", language+client);
                var currency = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CR1302_currency", language+client);
                var CriterionName1_Croes6147 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CriterionName1_Croes6147", language+client);
                var CriterionName2_Croes6147 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CriterionName2_Croes6147", language+client);
                var CriterionName3_Croes6147 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "CriterionName3_Croes6147", language+client);
                var Days_Croes6147 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1302", "Days_Croes6147", language+client);
                
                //Se connecter à l'application avec COPERN et acceder au module Relations
                Login(vServerRelations, userName, psw, language);
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
                Get_MainWindow().Maximize();
                
                //Créer une relation avec le champ fréquence de révision=annuelle
                CreateRelationship(relationshipName_CR1302,IACode_CR1302, currency, languageRelation, reviewFrequency);
                
                //Ajouter un critere actif "Liste des relations ayant révision en retard depuis plus de 400 jours."
                CreateCriterion(CriterionName1_Croes6147);
                
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_LblReviewPastDue().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ForOver().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_Days().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_Days().Keys(Days_Croes6147);
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
                Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
                
                //Vérifier que aucune relation trouvée
                var items = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = items.Count;
                if (count == 0)
                {
                  Log.Checkpoint("Aucune relation trouvée, la table est vide");
                }else
                {
                  Log.Error("Au moins une relation trouvée");
                }
                
                //Rafraichir la page pour afficher les relations sans critere
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
                //Ajouter un critere actif "Liste des relations ayant une révision prévue dans les prochains 400 jours."
                CreateCriterion(CriterionName2_Croes6147);
                
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_LblReview().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_InTheNext().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_Days().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_Days().Keys(Days_Croes6147);
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
                Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
                
                // vérifier que les relations qui ont la date d'aujourd'hui+1an sont affichées.
                var items = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = items.Count;
                var currentDate = aqDateTime.Today(); 
                var nextYear = aqDateTime.AddMonths(currentDate, 12);
                for (i=0; i<count; i++)
                {
                  aqObject.CheckProperty(items.Item(i).DataItem, "NextReviewDate", cmpEqual, nextYear);
                }
                
                //Rafraichir la page pour afficher les relations sans critere
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                
                
                //Ajouter un critere actif "Liste des relations ayant date de la prochaine révision ultérieure à aujourd'hui."
                CreateCriterion(CriterionName3_Croes6147);
                
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_LblNextReviewDate().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_AfterThe().Click();
                var width = Get_WinAddSearchCriterion().get_Width();
                var height = Get_WinAddSearchCriterion().get_Height();
                if (language == "english"){Get_WinAddSearchCriterion().Click(width*(2/3)+10,(height/3)+10);}
                else {Get_WinAddSearchCriterion().Click(width*(4/5),(height/3)+10);}
                Get_Calendar_BtnOK().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
                Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
                        
                // vérifier que les relations qui ont la date d'aujourd'hui+1an sont affichées.
                var items = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items;
                var count = items.Count;
                var currentDate = aqDateTime.Today(); 
                var nextYear = aqDateTime.AddMonths(currentDate, 12);
                for (i=0; i<count; i++)
                {
                  aqObject.CheckProperty(items.Item(i).DataItem, "NextReviewDate", cmpEqual, nextYear);
                }
                
                //Rafraichir la page pour afficher les relations sans critere
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      }
      catch (e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
      }         
      finally { 
                //Supprimer les critères créés
                DeleteCriterion(CriterionName1_Croes6147);
                DeleteCriterion(CriterionName2_Croes6147);
                DeleteCriterion(CriterionName3_Croes6147);
                
                //Supprimer la relation créée
                //DeleteRelationship(relationshipName_CR1302);
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();
      }    
      
}

                
function CreateCriterion(CriterionName){
    Log.Message("Add the '" + CriterionName + "' search criterion.");
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
    WaitObject(Get_CroesusApp(),"Uid","LocaleTextbox_a093");
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(CriterionName);
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate().OpenMenu();
}
