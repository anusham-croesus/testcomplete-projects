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


function CR2010_Croes_6640_Account_DragDropAssigHistoOthersPad()
{
    try
     {
       
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","KEYNEJ","username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var accountNumber800204FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
        var accountNumber800203RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);
        var NewRel01 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel01", language+client);
     
        //Afficher le lien de cas de test
        Log.Link ("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6640");
         
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language)
        
  //Step 1
        Log.Message("Aller dans le module Comptes");
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans la grille du module Comptes, sélectionner le compte " +  accountNumber800203RE);
        SearchAccount(accountNumber800203RE);
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " +NewRel01+ " de la section 'Relations' et mailler vers le module Modèles");
        Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber800203RE,10).Click();
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        var dragSource = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10);
        var dragDestinationMod = Get_ModulesBar_BtnModels();
        Drag(dragSource, dragDestinationMod); 
  
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        var CountMod = Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
       
         i= "0";
       
           if (CountMod == i){
             Log.Checkpoint("La grille est vide");
           }
         else {
            Log.Message("Erreur, la grille du module modèle n'est pas vide ");
         
         }
        
        
  //Step 2
        Log.Message("Revenir au module comptes et sélectionner le  compte " + accountNumber800203RE);
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " +NewRel01 +  " de la section 'Relations' et mailler vers le module Portefeuille");
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber800203RE,10).Click();      
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
       
        var dragDestinationModPort = Get_ModulesBar_BtnPortfolio();
        Drag(dragSource, dragDestinationModPort);
        
        var CountPortRel1 = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Get_Count();
      

        for (i=0; i<CountPortRel1; i++)
         {     
            AccountNo = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber;
            position = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Symbol;
                
            if (AccountNo == accountNumber800203RE)
                {
                Log.Checkpoint("La grille du module Portefeuille affiche les positions (grille non vide)  " + position);
                }
            else 
                {
                Log.Message("Le résultat n'est pas l'attendue");
                }
         }
             
        
  //Step 3   
        Log.Message("Revenir au module comptes et sélectionner le  compte  " +accountNumber800203RE);
        Get_ModulesBar_BtnAccounts().Click();
        
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " +NewRel01+ " de la section 'Relations' et mailler vers le module Transactions");
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber800203RE,10).Click();      
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        var dragDestinationModTran = Get_ModulesBar_BtnTransactions();
        Drag(dragSource, dragDestinationModTran); 
        var CountTransRel1 = VarToInt(Get_Transactions_ListView().Items.Count);
        Log.Checkpoint("La grille du module Transactions affiche toutes les transactions de la relation " +NewRel01 + " (grille non vide). Il y a  "  +CountTransRel1+ " Transactions totales ");
      
   
  //Step 4
        Log.Message("Revenir au module comptes et sélectionner le  compte " + accountNumber800204FS);
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans la grille du module Comptes, sélectionner le compte " +  accountNumber800204FS);
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNumber800204FS, 10 ).Click();
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " +NewRel01+ "de la section 'Hist. Relations' et mailler vers le module Modèles");
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        var dragSource = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10);
        var dragDestinationMod = Get_ModulesBar_BtnModels();
        Drag(dragSource, dragDestinationMod);
        
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        var CountMod = Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        i= "0";
       
         if (CountMod == i)
            {
             Log.Checkpoint("La grille est vide");
            }
         else 
            {
             Log.Message("Erreur, la grille du module modèle n'est pas vide ");
            }
  
       
  //Step 5
        Log.Message("Retourner au module compte et sélectionner le compte " +  accountNumber800204FS);
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation "  +NewRel01+ " de la section 'Hist. Relations' et mailler vers le module Portefeuille.");
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10).Click();
        WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071",1000);
        Drag(dragSource, dragDestinationModPort);
        Log.Message("La grille du module Portefeuille affiche les positions  de la relation REL01 (grillle non vide)");
                
        var CountPortRel1 = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Get_Count();
      

        for (i=0; i<CountPortRel1; i++)
         {     
            AccountNo = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber;
            position = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Symbol;
                
            if (AccountNo == accountNumber800203RE)
                {
                Log.Checkpoint("La grille du module Portefeuille affiche les positions (grille non vide)  " + position);
                }
            else 
                {
                Log.Message("Le résultat n'est pas l'attendue");
                }
         }     
    
  //Step 6
        Log.Message("Retourner au module Compte et sélectionner le compte  " +accountNumber800204FS);
        Get_ModulesBar_BtnAccounts().Click();
        Log.Message("Dans l'arborescence du module Comptes, sélectionner la relation " + NewRel01 + " de la section 'Hist. Relations' et mailler vers le module Transactions");
        var dragSource = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10);   
        var dragDestinationModTran = Get_ModulesBar_BtnTransactions();
        Drag(dragSource, dragDestinationModTran);
        
        
        var CountTransRel1 = VarToInt(Get_Transactions_ListView().Items.Count);
        Log.Checkpoint("La grille du module Transactions affiche toutes les transactions de la relation " +NewRel01 + "(grille non vide). Il y a  "  +CountTransRel1+ " Transactions totales " );
        
        
    }
      
      catch (e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      
      finally{
        Terminate_CroesusProcess();
      }
  }  
  
