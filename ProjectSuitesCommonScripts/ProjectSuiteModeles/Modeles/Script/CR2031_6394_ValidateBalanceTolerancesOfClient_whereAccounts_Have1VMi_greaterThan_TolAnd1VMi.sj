//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Valider les tolérances du solde d'un client avec comptes dont 1VMi > Tolérances et 1VMi = Tolérances
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6394
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-11
*/

function CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6394","Cas de test TestLink : Croes-6394") 
                               
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                  
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_REEQ_TOTAL", language+client);
         var client800063=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Client800063", language+client);      
         
         var account800063NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800063NA", language+client);
         var account800063OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800063OB", language+client);
         var tolMin0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD2", language+client);
         var tolMax0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD2", language+client);
         var orderTypeBuy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderType", language+client);  
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
         var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client); 
         var NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNA", language+client);
         var M84821=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "M84821", language+client);
         var M02916=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "M02916", language+client);
         var L=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "SymbolL", language+client);
         
         var positionsSolde= [position1CAD,position1USD];
                   
        //Login
        Log.AppendFolder("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        
        //assigné le client 800063 au modèle 'TOL REEQ TOTAL' 
        Log.Message("assigné le client no "+client800063+" au modèle "+modelName) 
        AssociateClientWithModel(modelName,client800063);
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
        
        Log.PopLogFolder();
        
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 2 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 2 de cas de test
         var quantiteNAEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteNAEtape2_6394", language+client); 
         var quantiteM84821Etape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM84821Etape2_6394", language+client);
         var quantiteM02916Etape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM02916Etape2_6394", language+client);
         var quantiteLEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteLEtape2_6394", language+client); 
          
         var VMAcc800063NACltSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NACltSelectionedEtape2_6394", language+client); 
         var VMAcc800063OBCltSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBCltSelectionedEtape2_6394", language+client); 
         var VMAcc800063NAAccSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NAAccSelectionedEtape2_6394", language+client); 
         var VMAcc800063OBAccSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBAccSelectionedEtape2_6394", language+client); 
        
        //Préparation des paramètres à tester        
        var accountsPO= [account800063NA,account800063NA,account800063OB,account800063OB];
        var accountsPP= [account800063NA,account800063OB];
        var securities= [null,null,M84821,M02916];
        var symboles = [NA,L,null,null]
        var quantities= [quantiteNAEtape2,quantiteLEtape2,quantiteM84821Etape2,quantiteM02916Etape2];
        var VMs1PP= [VMAcc800063NACltSelectionedEtape2,VMAcc800063OBCltSelectionedEtape2];
        var VMs2PP= [VMAcc800063NAAccSelectionedEtape2,VMAcc800063OBAccSelectionedEtape2];        
        
        Rebalancing(true, false, false, false, client800063, positionsSolde, accountsPP, VMs1PP, VMs2PP, null, null, null, accountsPO, securities, symboles, quantities, orderTypeBuy)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 3 de cas de test +++++++++++++++++++++++")        
        
        //Données Étape 3 de cas de test
         var messageCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape3_6394", language+client);
         var messageAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape3_6394", language+client);
         
         var quantiteNAEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteNAEtape3_6394", language+client); 
         var quantiteM84821Etape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM84821Etape3_6394", language+client);
         var quantiteM02916Etape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM02916Etape3_6394", language+client);
         var quantite800063OBLEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063OBLEtape3_6394", language+client);
         var quantite800063NALEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063NALEtape3_6394", language+client);  
          
         var VMAcc800063NACltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NACltSelectionedEtape3_6394", language+client); 
         var VMAcc800063OBCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBCltSelectionedEtape3_6394", language+client); 
         var VMAcc800063NAAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NAAccSelectionedEtape3_6394", language+client); 
         var VMAcc800063OBAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBAccSelectionedEtape3_6394", language+client); 
        
        //Préparation des paramètres à tester
        var accountsPO= [account800063NA,account800063NA,account800063OB,account800063NA,account800063OB];
        var accountsPP= [account800063NA,account800063OB];
        var securities= [null,null,M84821,M02916];
        var symboles = [NA,L,null,null,L]
        var quantities= [quantiteNAEtape3,quantite800063NALEtape3,quantiteM84821Etape3,quantiteM02916Etape3,quantite800063OBLEtape3];
        var VMs1PP= [VMAcc800063NACltSelectionedEtape3,VMAcc800063OBCltSelectionedEtape3];
        var VMs2PP= [VMAcc800063NAAccSelectionedEtape3,VMAcc800063OBAccSelectionedEtape3];        
        
        Rebalancing(true, false, true, false, client800063, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape3, messageAccSelectionedEtape3, account800063OB, accountsPO, securities, symboles, quantities, orderTypeBuy)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 4 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 4 de cas de test
         var quantiteNAEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteNAEtape4_6394", language+client); 
         var quantiteM84821Etape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM84821Etape4_6394", language+client);
         var quantite800063NALEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063NALEtape4_6394", language+client);  
          
         var VMAcc800063NACltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NACltSelectionedEtape4_6394", language+client); 
         var VMAcc800063OBCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBCltSelectionedEtape4_6394", language+client); 
         var VMAcc800063NAAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NAAccSelectionedEtape4_6394", language+client); 
         var VMAcc800063OBAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBAccSelectionedEtape4_6394", language+client); 
         
        //Préparation des paramètres à tester
        var accountsPO= [account800063NA,account800063NA,account800063OB];
        var accountsPP= [account800063NA,account800063OB];
        var securities= [null,null,M84821];
        var symboles = [NA,L,null]
        var quantities= [quantiteNAEtape4,quantite800063NALEtape4,quantiteM84821Etape4];
        var VMs1PP= [VMAcc800063NACltSelectionedEtape4,VMAcc800063OBCltSelectionedEtape4];
        var VMs2PP= [VMAcc800063NAAccSelectionedEtape4,VMAcc800063OBAccSelectionedEtape4];        
        
        Rebalancing(true, true, false, false, client800063, positionsSolde, accountsPP, VMs1PP, VMs2PP, null, null, null, accountsPO, securities, symboles, quantities, orderTypeBuy)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 5 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 5 de cas de test
         var quantiteNAEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteNAEtape5_6394", language+client); 
         var quantiteM84821Etape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM84821Etape5_6394", language+client);
         var quantiteM02916Etape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM02916Etape5_6394", language+client);
         var quantite800063OBLEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063OBLEtape5_6394", language+client);
         var quantite800063NALEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063NALEtape5_6394", language+client); 
          
         var VMAcc800063NACltSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NACltSelectionedEtape5_6394", language+client); 
         var VMAcc800063OBCltSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBCltSelectionedEtape5_6394", language+client); 
         var VMAcc800063NAAccSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NAAccSelectionedEtape5_6394", language+client); 
         var VMAcc800063OBAccSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBAccSelectionedEtape5_6394", language+client); 
         
        //Préparation des paramètres à tester
        var accountsPO= [account800063NA,account800063NA,account800063OB,account800063NA,account800063OB];
        var accountsPP= [account800063NA,account800063OB];
        var securities= [null,null,M84821,M02916];
        var symboles = [NA,L,null,null,L]
        var quantities= [quantiteNAEtape5,quantite800063NALEtape5,quantiteM84821Etape5,quantiteM02916Etape5,quantite800063OBLEtape5];
        var VMs1PP= [VMAcc800063NACltSelectionedEtape5,VMAcc800063OBCltSelectionedEtape5];
        var VMs2PP= [VMAcc800063NAAccSelectionedEtape5,VMAcc800063OBAccSelectionedEtape5];        
        
        Rebalancing(true, true, true, false, client800063, positionsSolde, accountsPP, VMs1PP, VMs2PP, null, null, null, accountsPO, securities, symboles, quantities, orderTypeBuy)
        
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 6 de cas de test +++++++++++++++++++++++")
        
        var toleranceMin=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_6394", language+client);
        var toleranceMax=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_6394", language+client);
        SetModelTolerances(modelName, position1CAD, toleranceMin, toleranceMax)
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
        
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 7 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 7 de cas de test
        var messageCltSelectionedEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape7_6394", language+client);
        var messageAccSelectionedEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape7_6394", language+client);
         
        var quantiteNAEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteNAEtape7_6394", language+client); 
        var quantiteM84821Etape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM84821Etape7_6394", language+client);
        var quantiteM02916Etape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM02916Etape7_6394", language+client);
        var quantite800063OBLEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063OBLEtape7_6394", language+client);
        var quantite800063NALEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063NALEtape7_6394", language+client); 
          
        var VMAcc800063NACltSelectionedEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NACltSelectionedEtape7_6394", language+client); 
        var VMAcc800063OBCltSelectionedEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBCltSelectionedEtape7_6394", language+client); 
        var VMAcc800063NAAccSelectionedEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NAAccSelectionedEtape7_6394", language+client); 
        var VMAcc800063OBAccSelectionedEtape7=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBAccSelectionedEtape7_6394", language+client); 
         
        //Préparation des paramètres à tester
        var accountsPO= [account800063NA,account800063NA,account800063NA,account800063OB,account800063OB];
        var accountsPP= [account800063NA,account800063OB];
        var securities= [null,null,M02916,M84821,null];
        var symboles = [NA,L,null,null,L]
        var quantities= [quantiteNAEtape7,quantite800063NALEtape7,quantiteM02916Etape7,quantiteM84821Etape7,quantite800063OBLEtape7];
        var VMs1PP= [VMAcc800063NACltSelectionedEtape7,VMAcc800063OBCltSelectionedEtape7];
        var VMs2PP= [VMAcc800063NAAccSelectionedEtape7,VMAcc800063OBAccSelectionedEtape7];        
        
        Rebalancing(true, false, true, false, client800063, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape7, messageAccSelectionedEtape7, account800063NA, accountsPO, securities, symboles, quantities, orderTypeBuy)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 8 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 8 de cas de test
        var quantiteNAEtape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteNAEtape8_6394", language+client); 
        var quantiteM84821Etape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM84821Etape8_6394", language+client);
        var quantiteM02916Etape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "QuantiteM02916Etape8_6394", language+client);
        var quantite800063OBLEtape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063OBLEtape8_6394", language+client);
        var quantite800063NALEtape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Quantite800063NALEtape8_6394", language+client); 
          
        var VMAcc800063NACltSelectionedEtape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NACltSelectionedEtape8_6394", language+client); 
        var VMAcc800063OBCltSelectionedEtape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBCltSelectionedEtape8_6394", language+client); 
        var VMAcc800063NAAccSelectionedEtape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063NAAccSelectionedEtape8_6394", language+client); 
        var VMAcc800063OBAccSelectionedEtape8=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800063OBAccSelectionedEtape8_6394", language+client); 
         
        //Préparation des paramètres à tester
        var accountsPO= [account800063NA,account800063NA,account800063NA,account800063OB,account800063OB];
        var accountsPP= [account800063NA,account800063OB];
        var securities= [null,null,M02916,M84821,null];
        var symboles = [NA,L,null,null,L]
        var quantities= [quantiteNAEtape8,quantite800063NALEtape8,quantiteM02916Etape8,quantiteM84821Etape8,quantite800063OBLEtape8];
        var VMs1PP= [VMAcc800063NACltSelectionedEtape8,VMAcc800063OBCltSelectionedEtape8];
        var VMs2PP= [VMAcc800063NAAccSelectionedEtape8,VMAcc800063OBAccSelectionedEtape8];        
        
        Rebalancing(true, true, true, false, client800063, positionsSolde, accountsPP, VMs1PP, VMs2PP, null, null, null, accountsPO, securities, symboles, quantities, orderTypeBuy)
        
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* CLENUP *************************************************")
        
        /*RestoreData(modelName,client800063,position1CAD, tolMin0, tolMax0)
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
		    Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)   
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,client800063,position1CAD, tolMin0, tolMax0)  
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)
    }
}

function RestoreData(modelName,client,position,tolMin,tolMax){      
     Log.Message("Supprimer le client "+client+" de Modèle") 
     RemoveClientFromModel(client,modelName)
     aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
     
     Log.Message("Remettre les tolérances du modèle "+modelName+" à l'état initial")
     SetModelTolerances(modelName, position, tolMin, tolMax)
}

function Rebalancing(TargetValueOption, option1, option2, option3, client, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionned,messageAccSelectionned, accountMessage, accountsPO, securities, symboles,quantities, orderType,withdrawalAmounts,accountsOfWithdrawalAmounts)
{  
  Log.Message("--- Étape 1 : Option Selon la valeur cible = "+TargetValueOption+ " -- Décocher/cocher les cases , valider les tolérances = "+option1+" , Répartir la liquidité = "+option2+", Appliquer les frais = "+option3);
  SetOptions(TargetValueOption, option1,option2,option3)  
  
  //cliquez sur next pour allez a etape 2 
  Get_WinRebalance_BtnNext().Click();
  
  //Étape 2 Ajouter les Gestion d'encaisse
  if(withdrawalAmounts!= undefined && withdrawalAmounts!= null)
    AddWithdrawalAmount(client,withdrawalAmounts,accountsOfWithdrawalAmounts);    
  
  Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")        
  GoToProjectedPortfolios();
  
  Log.Message("******* Etape 4 portefeuille projeté - Onglet Ordres proposés")
  //-- Valider message de rééquilibrage
  CheckRebalancingMessage(client, messageCltSelectionned,messageAccSelectionned, accountMessage)
  //Valider l'Onglet Ordres proposés
  if(accountsPO!= undefined && accountsPO!= null)
    CheckInTabProposedOrders(client, accountsPO, securities, symboles, quantities, orderType);
  
  //Valider Onglets Portefeuille projeté
  CheckInTabProjectedPortfolio(client, positionsSolde,accountsPP, VMs1PP, VMs2PP);
  
}

function AddWithdrawalAmount(client,withdrawalAmounts,accountsOfWithdrawalAmounts){
  
  /*Cliquez sur bouton Gestion encaisse ==> 800245-GT   Gestion de l'encaisse = -10000 ; 800245-JW   Gestion de l'encaisse = 50000)*/   
  DepositWithdrawalAmount(client,accountsOfWithdrawalAmounts, withdrawalAmounts);
  CheckDepositWithdrawalAmount(client,accountsOfWithdrawalAmounts, withdrawalAmounts);
}

function DepositWithdrawalAmount(client,accounts, amounts){
    
    Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",client,10).Click(); 
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    for(i=0; i<amounts.length; i++){
      Log.Message("--- Ajouter pour compte "+accounts[i]+" Gestion de l'encaisse =  "+amounts[i])      
      var index = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accounts[i],10).dataContext.Index;
      //var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10)
      //Modification suite au CR1990 le 13/02/2020
      var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)
      cellCashMgmt.Click();
      var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10); 
      
      //Remplacer le methode Keys() par Set_Text() le 17/02/2020
      //cashMgmtTxt.Keys(StrToFloat(amounts[i]));
      cashMgmtTxt.Set_Text(StrToFloat(amounts[i]));
    }    
    Get_WinCashManagement_BtnOk().click();
    
}
function CheckDepositWithdrawalAmount(client,accounts,amounts){
    
    Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",client,10).Click();
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    for(i=0; i<amounts.length; i++){
      Log.Message("--- Valider pour compte "+accounts[i]+" Gestion de l'encaisse =  "+amounts[i]) 
      aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accounts[i],10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amounts[i])
    }
    Get_WinCashManagement_BtnOk().click();
}

function CheckRebalancingMessage(client, messageCltSelectionned,messageAccSelectionned, accountMessage){
   
  if(messageCltSelectionned!= undefined && Trim(VarToStr(messageCltSelectionned))!== "" && messageCltSelectionned!= null){
    if(!Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).Exists)
      Scroll(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10));
    var index = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).dataContext.Index;
    
    Log.Message("** Avec client/Relation "+client+" selectionné : Valider que le message de rééquilibrage = "+messageCltSelectionned);
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).Click();
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,messageCltSelectionned)
    
    if(messageAccSelectionned!= undefined && Trim(VarToStr(messageAccSelectionned))!== "" && messageAccSelectionned!= null){
      Log.Message("** Avec compte "+accountMessage+" selectionné : Valider que le message de rééquilibrage = "+messageAccSelectionned);
      Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);
      Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",accountMessage,10).Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
      aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,messageAccSelectionned)
    }
    
  }
  else{
    if(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg().Exists && Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg().VisibleOnScreen && Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg().Text != "")
      Log.Error("Il existe un message de rééquilibrage inattendu = "+messageObject.Text);
    else 
      Log.Checkpoint("Aucun message de rééquilibrage")
  }
}

function CheckInTabProposedOrders(client, accounts, securities, symboles, quantities, orderType)
{
  //-- Valider les ordres
  if(!Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).Exists)
    Scroll(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10));
  var index = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).dataContext.Index;
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);      
  for(i=0; i<accounts.length; i++){   
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",accounts[i],10).Click();
    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
    if(securities[i]!= undefined && securities[i]!= null){      
      PO_SearchBySecurity(securities[i]);
      aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securities[i],10).DataContext.DataItem, "SecuritySecuFirm", cmpEqual, securities[i]);
      var searchValue = securities[i];
    }
    if(symboles[i]!= undefined && symboles[i]!= null){      
      PO_Search(symboles[i]);
      aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",symboles[i],10).DataContext.DataItem, "SecuritySymbol", cmpEqual, symboles[i]);
      var searchValue = symboles[i];
    }
    Log.Message("** Valider ordre "+orderType+" sur "+searchValue+" pour le compte "+accounts[i]+" quantité = "+quantities[i])
    aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",searchValue,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
    aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",searchValue,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantities[i]);    
  }
}

function CheckInTabProjectedPortfolio(client, positionsSolde,accounts, VMs1, VMs2)
{
  Log.Message("******* Etape 4 portefeuille projeté - Onglet portefeuille projeté")   
  Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
  Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
  
  Log.Message("** Vérifier les VM(%) dans le Portefeuille projeté: Avec client/relation "+client+" sélectionné:");
  if(!Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).Exists)
    Scroll(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10));
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).Click();
  WaitObject(Get_CroesusApp(),"Uid","DataGrid_67cd")
  for(i=0; i<accounts.length; i++){
    Log.Message("--- Valider pour symbole "+positionsSolde[i]+" et compte "+accounts[i]+" VM (%) = "+VMs1[i])
    VlaidatePPDataRow(positionsSolde[i],accounts[i],VMs1[i])
  }
  
  
  if(VMs2!= undefined && VMs2!= null){
    Log.Message("** Vérifier les VM(%) dans le Portefeuille projeté: Avec les comptes sélectionnés ");    
    var index = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client,10).dataContext.Index;
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);   
    for(i=0; i<accounts.length; i++){
      Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",accounts[i],10).Click();
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
      Log.Message("--- Valider pour symbole "+positionsSolde[i]+" et compte "+accounts[i]+"VM (%) = "+VMs2[i])
      VlaidatePPDataRow(positionsSolde[i],accounts[i],VMs2[i])
    }
  }

}
function VlaidatePPDataRow(symbole,account,VM){
    PP_Search(symbole);
    Values = new Array (account,symbole);
    var rowContent=FindRowByMultipleValues(Get_WinRebalance_PositionsGrid(), Values);
    if(rowContent != -1){
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "Symbol", cmpEqual, symbole);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "DisplayAccountNumber", cmpEqual, account);
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        CheckEquals(detected,VM,"VM (%)");
    } 
    else 
        Log.Error("Aucun portefeuille projeté pour compte = "+account+" et symbole = "+symbole);
}

function SetOptions(TargetValueOption,option1,option2,option3)
{
  Get_WinRebalance_TabParameters_RdoBasedOnTargetValue().set_IsChecked(TargetValueOption);
  
  Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(option1);
  Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(option2);
  Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(option3); 
  
}

function GoToProjectedPortfolios(){  
  //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
  Get_WinRebalance_BtnNext().Click();      
  //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'         
  Get_WinRebalance_BtnNext().Click();  
   if(Get_WinWarningDeleteGeneratedOrders().Exists) {
     Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
  } 
  WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Uid"], ["ProgressCroesusWindow", "ProgressCroesusWindow_b5e1"], 60000)
  WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", maxWaitTime); 
}
 
function GoToPreviousStep1(){
   Get_WinRebalance_BtnPrevious().Click(); 
   var width = Get_DlgConfirmation().Get_Width();
   Get_DlgConfirmation().Click((width*(1/3)),73);
   Get_WinRebalance_BtnPrevious().Click(); 
   Get_WinRebalance_BtnPrevious().Click();
}
function Scroll(searchValueObject){
 
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Click();
   if(searchValueObject == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualWidth()
        var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualHeight()  
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Click(ControlWidth-40, ControlHeight-10);
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do {
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Keys("[Right][Right][Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    }
}

