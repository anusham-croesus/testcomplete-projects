//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions


/**
    Description : Valider le rééquilibrage d'une relation avec un montant minimal 
    par ordre à l'étape 1 correspondant à la valeur modifiée de la pref au niveau Firme 
    puis avec une valeur modifiée manuellement
    
    
    Analyste d'assurance qualité : CaroleT
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	90.15.2020.3-31
*/

function CR2270_TCVE67_MOD1352_ValidateRebalanceRel_Whith_MinimumAmount()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6876","Cas de test TestLink : Croes-6876") 
         
         
         
          //Mettre la pref PREF_REBALANCE_MINIMUM_ORDER_AMOUNT au niveau Firm
          Activate_Inactivate_PrefFirm("Firm_1","PREF_REBALANCE_MINIMUM_ORDER_AMOUNT","2000",vServerModeles);         
         
          //Redemarrer les service
          RestartServices(vServerModeles);
         
        
         
          //Variables                      
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
          
          var MOD1397                  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "ModelMOD1397", language+client); 
          var relationMOD1396          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "RelationMOD1396", language+client);
          var account800214NA          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "Account800214NA", language+client);
          var account800215OB          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "Account800215OB", language+client);
          var minimumAmountR1          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "MinimumAmountR1", language+client);
          var quantityOrdersDCX        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "QuantityOrdersDCX", language+client);
          


          var minimumAmountR2             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "MinimumAmountR2", language+client);
          var securityDCX                 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityDCX", language+client);
          var marketValueDCX              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "MarketValueDCX", language+client);
          var marketValueR08407           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "MarketValueR08407", language+client);
          var securityR08407              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "SecurityR08407", language+client);
          var quantityOrdersR08407        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "QuantityOrdersR08407", language+client);
         
         
//Étape2

            
            Log.Message("*******************************Étape 2***********************************");
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();  
           
           
            //Accéder au module modèle et associer au modèle MOD1397 la relation relationMOD1396
            Log.Message("Accéder au module modèle et associer au modèle MOD1397 la relation relationMOD1396");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            AssociateRelationshipWithModel(MOD1397,relationMOD1396);
           
           
          
            //Rééquilibrer le MOD1397 et se rendre à l'étape  
            Log.Message("Rééquilibrer le modèle et se rendre à l'étape 1  ");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();

            
            // Cocher la case valider les limites et Décocher les cases Appliquer les frais et Répartir la liquidité.
            Log.Message("Cocher la case valider les limites et Décocher les cases Appliquer les frais et Répartir la liquidité.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(true);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            
            //Valider la valeur affichée dans le champ Montant minimum par ordre.
            Log.Message("Valider la valeur affichée dans le champ Montant minimum par ordre.");
            aqObject.CheckProperty(Get_WinRebalance_TabParameters_TxtMinimumOrderAmount(),"Value", cmpEqual, minimumAmountR1);
 

//Étape3
            Log.Message("*******************************Étape3***********************************");           
            //Continuer le Rééquilibrage et aller l'étape 4
            Log.Message("Continuer le Rééquilibrage et aller l'étape 4");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            

            //Dans l'onglet Portefeuilles prejetés, cliquer sur le bouton Grouper pour degroupe les ordres
            Log.Message("Dans l'onglet Portefeuilles prejetés, cliquer sur le bouton Grouper pour degroupe les ordres"); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");           
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();  
            
             //Sélectionner la position DCX et valider sa quantité
             Log.Message("Sélectionner la position DCX et valider sa quantité");
             var grid = Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1);
 
             var count = grid.Items.Count;
             for (i=1; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecuritySymbol == securityDCX && grid.Items.Item(i).DataItem.AccountNumber == account800215OB)
                      {
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityOrdersDCX)
                      }     
              } 
              
//Étape4 
           
               Log.Message("*******************************Étape4***********************************");  
              //Revenir à l'étape 1 et  valider la valeur affichée dans le champ Montant minimal par ordre.
              Log.Message("Revenir à l'étape1 et  valider la valeur affichée dans le champ Montant minimal par ordre. ");
              Get_WinRebalance_BtnPrevious().Click();    
              Get_DlgConfirmation_BtnYes().Click();
              Get_WinRebalance_BtnPrevious().Click();
              Get_WinRebalance_BtnPrevious().Click();
              aqObject.CheckProperty(Get_WinRebalance_TabParameters_TxtMinimumOrderAmount(),"Value", cmpEqual, minimumAmountR1);
                          
//Étape5 
           
               Log.Message("*******************************Étape5***********************************");               

              //Modifier le montant  minimum par ordre à 3000
              Log.Message("Modifier le montant  minimum par ordre à 3000");
              Get_WinRebalance_TabParameters_TxtMinimumOrderAmount().Click();
              Get_WinRebalance_TabParameters_TxtMinimumOrderAmount().Keys(minimumAmountR2);
              
//Étape6 
           
               Log.Message("*******************************Étape6***********************************");  
              
              //Continuer le Rééquilibrage et aller l'étape 4
              Log.Message("Continuer le Rééquilibrage et aller l'étape 4");
              Get_WinRebalance_BtnNext().Click(); 
              Get_WinRebalance_BtnNext().Click(); 
              Get_WinRebalance_BtnNext().Click();
              if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
              }  
              WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            

              //Dans l'onglet Portefeuilles prejetés, cliquer sur le bouton Grouper pour degroupe les ordres
              Log.Message("Dans l'onglet Portefeuilles prejetés, cliquer sur le bouton Grouper pour degroupe les ordres"); 
              WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");           
              Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();  
            
              //Sélectionner la position DCX et valider a nouveau sa quantité et sa valeur de marché
              Log.Message("Sélectionner la position DCX et valider a nouveau sa quantité");
              var grid = Get_WinRebalance_TabProposedOrders().WPFObject("_openOrdersGrids").WPFObject("_openOrdersGrid").WPFObject("RecordListControl", "", 1);
 
              var count = grid.Items.Count;
              for (i=1; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecuritySymbol == securityDCX && grid.Items.Item(i).DataItem.AccountNumber == account800215OB)
                      {
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityOrdersDCX)
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"MarketValue",cmpEqual,marketValueDCX)
                      }     
               }  
               
              //Sélectionner la position R08407 et valider a nouveau sa quantité et sa valeur de marché
              Log.Message("Sélectionner la position R08407 et valider a nouveau sa quantité");
             
              for (i=1; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecuritySymbolSecuFirm == securityR08407 && grid.Items.Item(i).DataItem.AccountNumber == account800215OB)
                      {
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Quantity",cmpEqual,quantityOrdersR08407)
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"MarketValue",cmpEqual,marketValueR08407)
                      }     
               }  
               
//Étape7 

           
              Log.Message("*******************************Étape7***********************************");    
              //Revenir à l'étape1 et  valider la valeur affichée dans le champ Montant minimal par ordre.
              Log.Message("Revenir à l'étape 1 et  valider la valeur affichée dans le champ Montant minimal par ordre. ");
              Get_WinRebalance_BtnPrevious().Click();    
              Get_DlgConfirmation_BtnYes().Click();
              Get_WinRebalance_BtnPrevious().Click();
              Get_WinRebalance_BtnPrevious().Click();
              aqObject.CheckProperty(Get_WinRebalance_TabParameters_TxtMinimumOrderAmount(),"Value", cmpEqual, minimumAmountR2);
              
              
              //Fermer la fenêtre de rééquilibrage
              Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
              Get_WinRebalance_BtnClose().Click();
              
           


                  
        
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
		    
    
         //Restart Data
         //Enlever la relation  du modèle
         RemoveRelationshipFromModel(MOD1397,relationMOD1396)
         //Supprimer le modèle
         DeleteModelByName(MOD1397);
         //Supprimer la Relation
         DeleteRelationship(relationMOD1396)
        
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();  
         Activate_Inactivate_PrefFirm("Firm_1","PREF_REBALANCE_MINIMUM_ORDER_AMOUNT","0",vServerModeles);       
        
    }
}
