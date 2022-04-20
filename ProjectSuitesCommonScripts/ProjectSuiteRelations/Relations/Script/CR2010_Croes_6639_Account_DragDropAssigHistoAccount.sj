//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/*
La relation REL01 contient les comptes 800203-RE (ACC01) et 800204-FS (ACC03). Puis, le compte 800204-FS a une Date de Sortie.
 
La relation REL02 contient les comptes 800212-RE (ACC02) et 800213-NA (ACC04) . Puis, le compte 800213-NA a une Date de Sortie.
 
Une relation groupée Rel--Rel02 contient les relations REL01 et REL02.


Auteur :   Jimenab
Analyste Manuel :  carolet
Version de scriptage:	ref90-13-In-3

*/


function CR2010_Croes_6639_Account_DragDropAssigHistoAccount()
{
    try
     {
       
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","KEYNEJ","username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var accountNumber800204FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
        var accountNumber800203RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);
        var NewRel01 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel01", language+client);
        

       

        
        //Afficher le lien de cas de test
        Log.Link ("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6639");
         
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language)
        
  //Step 1
        Log.Message("Aller dans le module Comptes");
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("sélectionner le compte " +accountNumber800203RE+ " dans l'arborescence seléctionner  la relation " +NewRel01+ " de la section 'Relations' et mailler vers le module Relations.");
        SearchAccount(accountNumber800203RE);
        Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber800203RE,10).Click();
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        var dragSource = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10);
        var dragDestinationModRel = Get_ModulesBar_BtnRelationships();
        Drag(dragSource, dragDestinationModRel); 
  
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
  
        var countRel = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (i=0; i<countRel; i++)
        {
          var Rel = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.FullName;
          Log.Checkpoint("La grille du module Relations affiche seulement la relation " +Rel);
        }
        
        
  //Step 2
        Log.Message("Revenir au module comptes et sélectionner le  compte  " +accountNumber800203RE);
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation  " +NewRel01 + " de la section 'Relations' et mailler vers le module Clients");
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber800203RE,10).Click();      
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        var dragDestinationModCli = Get_ModulesBar_BtnClients();
        Drag(dragSource, dragDestinationModCli); 
        
        var CountClient= Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
                
        for(i=0; i<CountClient; i++)
        {
        var CliRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber; 
        Log.Checkpoint("La grille du module Clients affiche les clients  " +  CliRes);
        }
        
        
  //Step 3   
        Log.Message("Revenir au module comptes et sélectionner le  compte  " +accountNumber800203RE);
        Get_ModulesBar_BtnAccounts().Click();
        
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " +NewRel01+ " de la section 'Relations' et mailler vers le module Comptes");
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber800203RE,10).Click();      
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        var dragDestinationAccMod = Get_ModulesBar_BtnAccounts();
        Drag(dragSource, dragDestinationAccMod); 
        
        
        var AccCount= Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
                
        for(i=0; i<AccCount; i++)
        {
        var AccRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber; 
        Log.Checkpoint("La grille du module Clients affiche les clients  " +  AccRes);
        }
                
        
  //Step 4
        Log.Message("Dans la grille du module Comptes, sélectionner le compte " +  accountNumber800204FS);
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " + NewRel01 + " de la section 'Hist. Relations' et mailler vers le module Relations");
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNumber800204FS, 10 ).Click();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        var dragSource = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10);
        var dragDestinationModRel = Get_ModulesBar_BtnRelationships();
        Drag(dragSource, dragDestinationModRel);
        
        for (i=0; i<countRel; i++)
        {
          var Rel = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.FullName;
          if (Rel == NewRel01 ){
            Log.Checkpoint("La grille du module Relations affiche seulement la relation " + Rel);
          }else {
            Log.Message("Erreur le résultat n'est pas l'attendue");
          }
          
        }
  
       
  //Step 5
        Log.Message("Retourner au module compte et sélectionner le compte " +  accountNumber800204FS);
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " + NewRel01 + " de la section 'Hist. Relations' et mailler vers le module Clients");
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        Drag(dragSource, dragDestinationModCli);
                
        for(i=0; i<CountClient; i++)
        {
        var CliRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber; 
        Log.Checkpoint("La grille du module Clients affiche les clients  " +  CliRes);
        }
        
    
  //Step 6
        Log.Message("Retourner au module Compte et sélectionner le compte  " +accountNumber800204FS);
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " + NewRel01 + " de la section 'Hist. Relations' et mailler vers le module Comptes");
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        Drag(dragSource, dragDestinationAccMod);
                
        for(i=0; i<AccCount; i++)
          {
            var AccRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber; 
            Log.Checkpoint("La grille du module Comptes affiche les comptes  " +  AccRes);
          }

        
        
    }
      
      catch (e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
        Terminate_CroesusProcess();
      }
  }  
  
