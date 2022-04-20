//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT CR1352_1038_Cli_Edit_TempFilter


/* Description :Mailler des relations vers le module clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1458
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

/* Script modifié le 07/07/2020  pour inclure la story CRM-3537
        En tant qu'utilisateur de liste courante (crochets) dans croesus
        je veux avoir une confirmation lorsque je maille pour conserver ou non ma liste courante (crochets) 
        afin d'éviter de croire que j'ai une petite liste et de faire par la suite une action qui mène à une grosse erreur.
par: Abdel Matmat */
 
 function CR1352_1458_Cli_DragRelationships_toClientModule()   
 {             
    try{  
      
          //Lien de la story dans Jira
          Log.Link("https://jira.croesus.com/browse/TCVE-1781","Lien de la story dans Jira");
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1458","Lien du cas de test dans Testlink");
           
 
          var relationTest1   = GetData(filePath_Clients,"CR1352",428,language);
          var relationTest2   = GetData(filePath_Clients,"CR1352",429,language);
          var defaultFilter   = GetData(filePath_Clients,"CR1352",430,language);
          var messageConfirm1 = GetData(filePath_Clients,"CR1352",431,language);
          var messageConfirm2 = GetData(filePath_Clients,"CR1352",432,language);
          var messageConfirm3 = GetData(filePath_Clients,"CR1352",433,language);
          var clientNumber    = GetData(filePath_Clients,"CR1352",434,language);
                    


           
 /************************************Étape 1 et 2 ************************************************************************/     
           //Se connecter à croesus avec COPERN
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1 et 2: Se connecter à croesus avec COPERN et mailler des relations dans le module Clients");
          Log.Message("Se connecter à croesus avec COPERN");
          Login(vServerClients, userName, psw, language);
          Get_ModulesBar_BtnRelationships().Click(); 
          Get_MainWindow().Maximize(); 
          
          Log.Message("Sélectionner les relations");
          if (client == "BNC"  || client == "US" || client == "CIBC"){
              //Sélectionner 3 relations 
             for(var i=0; i <=2; i++){
               Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).set_IsSelected(true)
             }  
         }
         else{// RJ. Dans le RJ il y a seulement une seule relation.
            Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).set_IsSelected(true);
        }
    
        //Mailler les relations sélectionnées vers le module client 
        Log.Message("Mailler les relations sélectionnées vers le module client ");           
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Clients().Click();
        Get_MenuBar_Modules_Clients_DragSelection().Click();
 
        Log.Message("Points de vérification");
        //Points de vérification
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
        if(client == "US" ) {
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",324,language));
        } 
        else {
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",136,language));
        }
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
        if (client == "BNC"  || client == "US" || client == "CIBC"){
        //Vérifier le tooltip 
        //aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, GetData(filePath_Clients,"CR1352",137,language));
        // Il y a un espace devant la description du tooltip, anomalie signalée et il est demandé de l'ignorer.
          if(language=="french"){
            if(client == "BNC") aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, " Relation(s) maillée(s) =00000\n00001\n00002\n"); 
            else aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, " Relation(s) maillée(s) =A0000\nA0001\nA0002\n"); 
            }
          else{
            if(client == "US" ){
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, " Dragged Relationship(s) =0000P\n0000Q\n0000R\n");
            }
            else{
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, " Dragged Relationship(s) =A0000\nA0001\nA0002\n");}
            }
          }

        else if(client == "TD" ){aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Dragged Relationship(s) =00006\n")}
          else{//RJ
              if(language=="french"){
                aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Relation(s) maillée(s) =00003\n"); 
              }
              else{ if(client == "RJ"){aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Dragged Relationship(s) =00002\n")}
                  else aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Dragged Relationship(s) =00003\n")};
              }
              
 /************************************Étape 3 ************************************************************************/     
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Selectionner la Relation #1 TEST et Mailler la relation vers compte");
          //Selectionner la relation #1 Test
          Log.Message("Selectionner la relation #1 Test");
          Get_ModulesBar_BtnRelationships().Click();
          SearchRelationshipByName(relationTest1);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationTest1, 10).Click();
          //Mailler la relation selectionnée vers comptes
          Log.Message("Mailler la relation selectionnée vers comptes");
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Accounts().Click();
          Get_MenuBar_Modules_Accounts_DragSelection().Click();
          
          //Vérifications
          Log.Message("valider que le crochet affiché en bas à droite = 0");
          aqObject.CheckProperty(Get_StatusBarContentSelection().Text, "OleValue", cmpEqual, "0"); 
          
  /************************************Étape 4 ************************************************************************/     
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Séléctionner 4 comptes et cliques sur la barre Espace");
          //Séléctionner 4 comptes
          Log.Message("Séléctionner 4 comptes");
          Get_ModulesBar_BtnAccounts().Click();
          for(var i=0; i <=3; i++){
               Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).set_IsSelected(true)
          }  
          //cliques sur la barre Espace
          Log.Message("cliquer sur la barre Espace");
          Sys.Keys(" ");
          
          //Vérifications
          Log.Message("Vérifier le nouveau filtre affiché");
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["TextBlock",defaultFilter], 10), "VisibleOnScreen", cmpEqual, true); 
          for(var i=0; i <=3; i++){             
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual, true); 
          }  
          Log.Message("valider que le crochet affiché en bas à droite = 4");
          aqObject.CheckProperty(Get_StatusBarContentSelection().Text, "OleValue", cmpEqual, "4");
          
  /************************************Étape 5 ************************************************************************/     
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: Retourner dans Relations, Select Relation #2 TEST, Mailler vers Comptes puis valider les messages");
          //Aller dans Relation
          Get_ModulesBar_BtnRelationships().Click();
          SearchRelationshipByName(relationTest2);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationTest2, 10).Click();
          //Mailler la relation selectionnée vers comptes
          Log.Message("Mailler la relation selectionnée vers comptes");
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Accounts().Click();
          Get_MenuBar_Modules_Accounts_DragSelection().Click();
          
          //Points de vérification
          Log.Message("Valider le message de confirmation affiché");
          aqObject.CheckProperty(Get_DlgConfirmation().CommentTag, "OleValue", cmpEqual, messageConfirm1+"\r\n"+messageConfirm2+"\r\n"+messageConfirm3);
          
  /************************************Étape 6 ************************************************************************/     
          Log.PopLogFolder();
          logEtape6 = Log.AppendFolder("Étape 6: Cliquer sur consever et valider les crochets");
          //Cliquer sur conserver
          Get_DlgConfirmation_BtnYes().Click();
          
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
          //WaitObject(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsChecked", true);
          Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["TextBlock",defaultFilter], 10).Click();
          
          //Vérifications
          Log.Message("Valider qu'il y a un crochet devant chaque sélection");
          for(var i=0; i <=3; i++){             
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual, true); 
          }  
          Log.Message("valider que le crochet affiché en bas à droite = 4");
          aqObject.CheckProperty(Get_StatusBarContentSelection().Text, "OleValue", cmpEqual, "4");
          
  /********************************Étape 7 ************************************************************************/     
          Log.PopLogFolder();
          logEtape7 = Log.AppendFolder("Étape 7: Retourner dans Client, Search client 800054, Mailler dans compte, Click espace sur les 2 premiers comptes"); 
          Log.Message("Aller dans Client et selectionner le client 800232");
          Get_ModulesBar_BtnClients().Click();
          Search_Client(clientNumber);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).Click();
          //Mailler le client selectionné vers comptes
          Log.Message("Mailler le client selectionné vers comptes");
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Accounts().Click();
          Get_MenuBar_Modules_Accounts_DragSelection().Click();
          
          //Cliquer sur conserver si la fenêtre est affichée
          if (Get_DlgConfirmation().Exists)
              Get_DlgConfirmation_BtnYes().Click();
          
          //Selectionner les 2 premiers comptes
          Log.Message("Selectionner les 2 premiers comptes et cliquer sur Espace");
          for(var i=0; i <=1; i++){
               Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).set_IsSelected(true)
          }  
          Sys.Keys(" ");
          
          //Vérifications
          Log.Message("Vérifier le nouveau filtre affiché");
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["TextBlock",defaultFilter], 10), "VisibleOnScreen", cmpEqual, true); 
          for(var i=0; i <=1; i++){             
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "MatchesCriterion", cmpEqual, true);
          }  
          Log.Message("valider que le crochet affiché en bas à droite = 6");
          aqObject.CheckProperty(Get_StatusBarContentSelection().Text, "OleValue", cmpEqual, "6");
          
    /********************************Étape 8 ************************************************************************/     
          Log.PopLogFolder();
          logEtape8 = Log.AppendFolder("Étape 8: Retourner dans le module Relations, Selectionner,Mailler et Appuyer sur le bouton Ne pas conserver "); 
          Log.Message("Aller dans Relation et selectionner la relation 1# TEST");
          Get_ModulesBar_BtnRelationships().Click();
          SearchRelationshipByName(relationTest1);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationTest1, 10).Click();
          //Mailler la relation selectionnée vers comptes
          Log.Message("Mailler la relation selectionnée vers comptes");
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Accounts().Click();
          Get_MenuBar_Modules_Accounts_DragSelection().Click();
          //Cliquer sur conserver si la fenêtre est affichée
          if (Get_DlgConfirmation().Exists)
              Get_DlgConfirmation_BtnCancel().Click();
          
          //Vérifications
          Log.Message("Vérifier que filtre n'est pas affiché");
          if (Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["TextBlock",defaultFilter], 10).Exists)
              Log.Error("Le filtre par défaut ne doit pas être affiché");
          else
              Log.Checkpoint("Le filtre par défaut n'est pas affiché");
          
          Log.Message("valider que le crochet affiché en bas à droite = 0");
          aqObject.CheckProperty(Get_StatusBarContentSelection().Text, "OleValue", cmpEqual, "0");
                        
        }
        
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: C L E A N U P"); 
        Log.Message("------------- C L E A N U P -----------------------------");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for(var i=0; i < count; i++){
            Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).set_IsSelected(true)
        } 
        Sys.Keys(" ");
        Sys.Keys(" ");
        
        //Fermer Croesus
        Terminate_CroesusProcess();      
    }
 }

 
 