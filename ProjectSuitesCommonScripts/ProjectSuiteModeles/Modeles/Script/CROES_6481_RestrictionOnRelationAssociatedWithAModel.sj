//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Jira CROES-3418 et BNC-60  Restriction sur relation associé à un modèle  (clone BNC-60)
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6581
    Lien sur Jira : https://jira.croesus.com/browse/CROES-3418
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function CROES_6481_RestrictionOnRelationAssociatedWithAModel()
{
    try {
                      
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var account800041NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Account800041NA", language+client);        
        var modeleCanadianEquity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleCanadianEquity", language+client);
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var relNameCROES3418=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "RelNameCROES3418_6481", language+client); 
        var descriptionBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "DescriptionBMO", language+client); 
        var percentageOfTotalValueMin=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "PercentageOfTotalValueMin_6481", language+client);  
        var percentageOfTotalValueMax=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "PercentageOfTotalValueMax_6481", language+client);  
        var restrictiontMessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "RestrictiontMessage_6481", language+client);
        
         
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6481","Cas de test TestLink : Croes-6481")
        Log.Link("https://jira.croesus.com/browse/CROES-3418","Lien sur Jira : CROES-3418")
               
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Log.Message("Aller dans compte et sélectionenr le compte "+account800041NA)
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        
        //Creation de la relation CROES-3418        
        Search_Account(account800041NA);
        Log.Message("Faire un right click + Relation + Créer une nouvelle relation + Associer - Nom de la relation = "+relNameCROES3418+" Code de CP = "+codeCP)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800041NA, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(relNameCROES3418);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(codeCP);
        Get_WinDetailedInfo_BtnOK().Click();
        
        Log.Message("Aller dasn le module Modèle et sélectionner le modèle "+modeleCanadianEquity)
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        SearchModelByName(modeleCanadianEquity)
        
        Log.Message("Associer la relation "+relNameCROES3418+" au modèle + OK")
        AssociateRelationshipWithModel(modeleCanadianEquity,relNameCROES3418)
        
        Log.Message("Dans Portefeuilles associés sélectionner la relation "+relNameCROES3418+" et cliquer sur le bouton Restrictions")
        Get_Models_Details_DgvDetails().FindChild("Value", relNameCROES3418, 10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
        //Pourcentage de la valeur Totale: Minimum(%) = 8  Maximum(%) = 10
        Log.Message("Ajouter une restriction symbole_description = "+descriptionBMO+"Pourcentage de la valeur Totale: Minimum(%) = "+percentageOfTotalValueMin+" Maximum(%) = "+percentageOfTotalValueMax+" + OK + Fermer")
        AddRestriction(descriptionBMO,percentageOfTotalValueMin,percentageOfTotalValueMax)
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modeleCanadianEquity,10).Click();      
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();
                            
        Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")
        //cliquez sur next pour allez a etape 2 
        Get_WinRebalance_BtnNext().Click();
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
        Get_WinRebalance_BtnNext().Click();      

        //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'         
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
        
        //Valider message = Pourcentage de la valeur totale doit être entre 8.00% et 10.00 pour Banque de Montreal(055665) et la valeur actuelle est 27.76%
        Log.Message("Etape 4 portefeuille projeté - Valider le messagede restriction dans la section message de rééquilibrage = ",restrictiontMessage) 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblDescriptionMsg() ,"Value",cmpEqual,restrictiontMessage)
        
        //Fermer la fenetre de réequilibrage
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        /*Log.Message("************************************** CLEANUP *********************************************")
        RestoreData(modeleCanadianEquity,relNameCROES3418);
        
                
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		    //Fermer le processus Croesus       
        Terminate_CroesusProcess();
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Log.Message("************************************** CLEANUP *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);        
        RestoreData(modeleCanadianEquity,relNameCROES3418);
        Runner.Stop(true)
    }
}

function RestoreData(modelName,relName){      
    //Supprimer la relation de Modele 
    Log.Message("Supprimer la relation "+relName+" de modèle "+modelName)
     RemoveAccountFromModel(relName,modelName)
     aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
     
     //Supprimer la relation
     DeleteRelationship(relName);         
}
function Test(){
  var restrictiontMessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "RestrictiontMessage_6481", language+client);
  aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblDescriptionMsg() ,"Value",cmpEqual,restrictiontMessage)
}
