//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT CR2010_Croes_6619_Rel_CasPreconditions


/*
Module: Relations 

La relation REL01 contient les comptes 800203-RE (ACC01) et 800204-FS (ACC03). Puis, le compte 800204-FS a une Date de Sortie.
 
La relation REL02 contient les comptes 800212-RE (ACC02) et 800213-NA (ACC04) . Puis, le compte 800213-NA a une Date de Sortie.
 
Une relation groupée Rel--Rel02 contient les relations REL01 et REL02.
 
Auteur :   Jimenab
Analyste Manuel :  carolet
Version de scriptage:	ref90-12-HF-25 

*/

function CR2010_Croes_6635_Rel_DragDropGrilleRelCliAcc()
{
   try 
   {
     
      var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","KEYNEJ","username");
      var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
      var accountNumber800203RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);
      var accountNumber800204FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
      var accountNumber800212RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","accountNumber800212RE", language+client);
      var accountNumber800213NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","accountNumber800213NA", language+client);
      var GroupedRelationName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","GroupedRelationName", language+client);
      var NewRel01 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel01", language+client);
      var NewRel02 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel02", language+client);
      var clientNumber800203 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800203", language+client);
      var clientNumber800204 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800204", language+client);
        
     
     //Afficher le lien de cas de test
     Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6635");
     
     Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language)
     
  
     
      Get_ModulesBar_BtnRelationships().Click();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
  
   
      SearchRelationshipByNo(NewRel01); 
  
      Log.Message("Mailler vers le module relation avec l'option drag drop");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10).Keys("[Hold]![Down][Release]");
      
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
      Log.Message("Dans la grille du module Relations, sélectionner les relation REL01 et REL02 et mailler vers le module Relations.");
      
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Relationships().Click();
      Get_MenuBar_Modules_Relationships_DragSelection().Click();
      

      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
    
    
      Log.Message("La grille de relation affiche les deux relations")       
      var countRel = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
      Log.Message("Total relations " +countRel);

      for (i=0; i<countRel; i++)
        {
          var Rel = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.FullName;
          Log.Checkpoint("La grille du module Relations affiche seulement la relation " +Rel);
        }
        
      
        
        
      Log.Message("Dans la grille du module Relations, sélectionner la relation " +NewRel01+ " et mailler vers le module Clients.");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10).Click();
 
      WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","QuickSearchWindow_b326");
      var dragSource = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10);
      var dragDestination = Get_ModulesBar_BtnClients();
      Drag(dragSource, dragDestination);
      
      
              
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
      Log.Message("La grille du module Client affiche les clients  " +  clientNumber800203 + " et "  + clientNumber800204);
       
      var countCli = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
      Log.Message("Total clients " +countCli);

      for (i=0; i<countCli; i++)
        {
          var ClientsRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber;
          Log.Checkpoint("La grille du module Client affiche les clients  " +ClientsRes);
        }
       
        
        
      Log.Message("Revenir au module relation");
      Get_ModulesBar_BtnRelationships().Click();
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
      Log.Message("Dans la grille du module Relations, sélectionner les relation " +NewRel01+ " et " +NewRel02+ " et mailler vers le module Clients");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10).Keys("[Hold]![Down][Release]");
      
      Log.Message("Mailler vers le module Clients");
      Get_MenuBar_Modules().Click();
      Get_MenuBar_Modules_Clients().Click();
      Get_MenuBar_Modules_Clients_DragSelection().Click();
      
      Log.Message("La grille du module Clients affiche tous les clients 800213, 800203, 800212-2 (pour FBN) , 800211, et 800204");
      
       
      var countManyCli = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
      Log.Message("Total clients " +countManyCli);

      for (i=0; i<countManyCli; i++)
        {
          var ManyClientsRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber;
          Log.Checkpoint("La grille du module Client affiche les clients  " +ManyClientsRes);
        }
        
        
        
      Log.Message("Revenir au module relation");
      Get_ModulesBar_BtnRelationships().Click();
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      SearchRelationshipByName(GroupedRelationName);
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", GroupedRelationName, 10).Click();
 
      Log.Message("Dans la grille du module Relations, sélectionner la relation groupée" +GroupedRelationName+ "REL01---REL02 et mailler vers le module Clients");
      
       
      var dragSourceGroup = Get_RelationshipsClientsAccountsGrid().FindChild("Value", GroupedRelationName, 10);
      Drag(dragSourceGroup, dragDestination);

      Log.Message("La grille du module Clients affiche  les clients 800213, 800203, 800212-2 (pour FBN) , 800211, et 800204");
      
      var countCliGroup = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
      Log.Message("Total clients " +countCliGroup);

      for (i=0; i<countCliGroup; i++)
        {
          var ClientsGroupRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber;
          Log.Checkpoint("La grille du module Client affiche les clients  " +ClientsGroupRes);
        }
      
        
      Log.Message("Revenir au module relation");
      Get_ModulesBar_BtnRelationships().Click();
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);

      SearchRelationshipByName(NewRel02);
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel02, 10).Click();
 
      Log.Message("Dans la grille du module Relations, sélectionner la relation " +NewRel02 + " et mailler vers le module Comptes");
      
       
      var dragSourceRel2 = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel02, 10);
      var dragDestinationAcc = Get_ModulesBar_BtnAccounts();
      Drag(dragSourceRel2, dragDestinationAcc);

      Log.Message("La grille du module Comptes affiche  les comptes " + accountNumber800213NA + " et " + accountNumber800212RE);
      
      var countCliRel02 = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
      Log.Message("Total clients " +countCliRel02);

      for (i=0; i<countCliRel02; i++)
        {
          var ClientsRel02 = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber;
          Log.Checkpoint("La grille du module Client affiche les clients  " +ClientsRel02);
        }
     
        
        
      Log.Message("Revenir au module relation");
      Get_ModulesBar_BtnRelationships().Click();
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 10);

      SearchRelationshipByName(GroupedRelationName);
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", GroupedRelationName, 10).Click();
      
        
      Log.Message("Dans la grille du module Relations, sélectionner la relation groupée " + GroupedRelationName + "  REL01---REL02 et mailler vers le module Comptes.");
      
      var dragSourceGroup = Get_RelationshipsClientsAccountsGrid().FindChild("Value", GroupedRelationName, 10); 
      Drag(dragSourceGroup, dragDestinationAcc);

      Log.Message("La grille du module Comptes affiche  les comptes 800213-NA ,800203-RE, 800212-RE et 800204-FS.");
      
      var countAccGroup = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
      Log.Message("Total comptes " +countAccGroup);

      for (i=0; i<countAccGroup; i++)
        {
          var AccGroup = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber;
          Log.Checkpoint("La grille du module Client affiche les clients  " +AccGroup);
        }
        
    
    
   }

   catch(e){
     Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
   finally {
    Terminate_CroesusProcess();  
   }
 
}



