//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/*
Module: Relations 

La relation REL01 contient les comptes 800203-RE (ACC01) et 800204-FS (ACC03). Puis, le compte 800204-FS a une Date de Sortie.
 
La relation REL02 contient les comptes 800212-RE (ACC02) et 800213-NA (ACC04) . Puis, le compte 800213-NA a une Date de Sortie.
 
Une relation groupée Rel--Rel02 contient les relations REL01 et REL02.
 
Auteur :   Jimenab
Analyste Manuel :  carolet
Version de scriptage:	ref90-12-HF-25 

*/

function CR2010_Croes_6636_Rel_DragDropGrilleRelOthersPad()
  {
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","KEYNEJ","username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var accountNumber800212RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","accountNumber800212RE", language+client);
        var accountNumber800204FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
        var accountNumber800203RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);
        var NewRel01 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel01", language+client);
        var NewRel02 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel02", language+client);
        var GroupedRelationName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","GroupedRelationName", language+client);
        var ShortNameCli = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","ShortNameCli", language+client);
        var ModelCHBONDS = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"CR2010","ModelCHBONDS", language+client);
        
         
  try
  {
      //Afficher le lien de cas de test
      Log.Link ("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6636");
         
      Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language)
         
      Get_ModulesBar_BtnRelationships().Click();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
  
   
      SearchRelationshipByNo(NewRel01); 
  
      Log.Message("Dans la grille du module Relations, sélectionner les relations REL01 et mailler vers le module Modèles.");
      WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","QuickSearchWindow_b326");
      var dragSource = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10);
      var dragDestinationMod = Get_ModulesBar_BtnModels();
      Drag(dragSource, dragDestinationMod);
      
      WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
    
    
      Log.Checkpoint("La grille du module Modèles affiche une grille est vide");  
      aqObject.CheckProperty(Get_ModelsGrid().Find("Value","",10),"Exists", cmpEqual, false);
      
      
      Log.Message("Dans la grille du module Relations, sélectionner la relation "  +NewRel01+" et mailler vers le module Portefeuille");
      Get_ModulesBar_BtnRelationships().Click();
      Log.Message("sélectionner la relation " +NewRel01+ " et mailler vers le module Portefeuille");
      var dragSource = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10);
      var dragDestinationPort = Get_ModulesBar_BtnPortfolio();
      Drag(dragSource, dragDestinationPort);
      
      Log.Message("La grille du module Portefeuille affiche les postions actuelles pour la relation REL01( grille NON vide)")
        
      CountPortRel1 = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Get_Count();
      Log.Message("Les total des positions lors de mailler la relation REL01  " +CountPortRel1);

      for (i=0; i<CountPortRel1; i++)
      {     
        AccountNo = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber;
        NameClient = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientShortName;
        position = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Symbol;
                
          if (AccountNo == accountNumber800203RE && NameClient == ShortNameCli )
            {
              Log.Checkpoint("La grille du module Portefeuille affiche les positions actuelles pour la relation REL01   " + position);
            }
          else 
            {
              Log.Message("Le résultat n'est pas l'attendue");
            }
        }
    
      
      Log.Message("Revenir au module relation");
      Get_ModulesBar_BtnRelationships().Click();
      Log.Message("Dans la grille du module Relations, sélectionner la relation groupée " +NewRel01+ " et " + NewRel02+ " et mailler vers le module Portefeuille");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10).Keys("[Hold]![Down][Release]");
      Drag(dragSource, dragDestinationPort);
      
      
      
      Log.Message("Faire une recherche dans le module portefeuile du compte " + accountNumber800204FS);
      Search_PositionByAccountNo(accountNumber800204FS);
      
      Log.Message("Le compte " +accountNumber800204FS+  " est non visible dans la grille portefeuille");

      CountPortRel1 = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Get_Count();
      Log.Message(CountPortRel1);

      for (i=0; i<CountPortRel1; i++)
      {
                
          AccountNo = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber;
                
          if (AccountNo != accountNumber800204FS )
          {
            Log.Checkpoint("Le compte  " +accountNumber800204FS+  "  est non visible dans la grille portefeuille   " + AccountNo);
                    
          }
          else 
          {
            Log.Message("Le résultat n'est pas l'attendue");
          }     

        }
      
      
      Log.Message("Revenir au module relation");
      Get_ModulesBar_BtnRelationships().Click();
      
      Log.Message("Dans la grille du module Relations, sélectionner la relation" + NewRel01 + " et mailler vers le module Transactions");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10).Click();

      var dragDestinationTrans = Get_ModulesBar_BtnTransactions();
      Drag(dragSource, dragDestinationTrans);

      Log.Message("La grille du module Transactions affiche les transactions pour la relation " + NewRel01 + " (grille non Vide)");
      
      CountTransRel1 = VarToInt(Get_Transactions_ListView().Items.Count);
      Log.Checkpoint(CountTransRel1);
 
         
      Log.Message("Revenir au module relation");
      Get_ModulesBar_BtnRelationships().Click();
      Log.Message("Dans la grille du module Relations, sélectionner la relation groupée "  +NewRel01 + " et " +NewRel02+ " et mailler vers le module Transactions");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10).Keys("[Hold]![Down][Release]");
      Drag(dragSource, dragDestinationTrans);

      Log.Message("La grille du module Transactions affiche les transactions pour la relation groupée (grille NON vide).");
      
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 5000);
      CountTransRel1 = VarToInt(Get_Transactions_ListView().Items.Count);
      Log.Checkpoint(CountTransRel1);
      
      
  }
  
  catch(e){
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally{
      Terminate_CroesusProcess(); 
  }
  
  
}



