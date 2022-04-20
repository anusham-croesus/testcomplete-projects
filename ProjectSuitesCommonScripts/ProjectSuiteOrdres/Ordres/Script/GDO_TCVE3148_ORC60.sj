//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Jira ORC-60
 
Analyste d'automatisation: Youlia Raisper
La version du scriptage:ref90-19-2020-09-52  */ 

function GDO_TCVE3148_ORC60()
{
    var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10, logEtape11, logEtape12, logEtape13, logEtape14, logRetourEtatInitial;
    try {
        //Lien de la storie dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-3148","Lien de la story dans Jira");
        //Lien du cas de test dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-2915","Lien du cas de test dans Jira");
                
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");        
        var symbolSEE= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbolSEE", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "messageORC60", language+client);//"L'ordre a déjà été vérifié par John Keynes. Conséquemment, l'opération ne peut pas être effectuée";//The order has already been verified by John Keynes. Consequently, the operation cannot be performed :
        var statusPendingApproval =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
        
        // ********************************************************Étape 1*******************************************
        logEtape1 = Log.AppendFolder("Étape 1: Supprimer tous les ordres visibles dans l'Accumulateur. Charger le fichier en pièce jointe pour créer les ordres à tester");
        
        Log.Message("Login");
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked",true,1500);
        Log.Message("Supprimer tous les ordres visibles dans l'Accumulateur");
        DeleteAllOrdersInAccumulator();
                     
        Log.Message("Ajouter les ordres --> SQL");
        var sqlRepository =folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\Sql\\";
        var sqlFilePath = sqlRepository + "TCVE-3148.sql"
        ExecuteSQLFile(sqlFilePath, vServerOrders);
        
        Log.Message("Clique sur un autre module et recliquer sur le module Ordre pour rafraîchir les ordres ajoutés");
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked",true,1500);
        Log.Message("Retourmer au module Ordre");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked",true,1500);
        
        // ********************************************************Étape 2*******************************************
        /*Dans l'accumulateur,Sélectionner tout les ordres (6 ordres)
        Cliquer sur Vérifier*/
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Vérifier les ordres");
        Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
        Get_OrderAccumulator_BtnVerify().Click(); 
      
        // ********************************************************Étape 3*******************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder( "Étape 3: Cocher tous les ordres et laisser l'ordre avec le symbole SEE (quantité=101) décoché.Cliquer sur Soumettre");
        
        Log.Message("Côcher la cas Inclure + Soumettre");          
        var count=Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Items.Count
          if(count==6){           
              Log.message("Cocher les 5 ordres");            
                  for (i=1; i<count+1; i++)
                      if(Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.OrderSymbol.OleValue !=symbolSEE)
                      Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).Find("ClrClassName","XamCheckEditor",10).Click();
        
          }else{
            Log.Error("On devrait avoir 6 ordres à vérifier")
            return;
        };
        
        Log.Message("Cliquer sur Soumettre");      
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
        Delay(5000);
        WaitObject(Get_CroesusApp(),"Uid", "DataGrid_e262");
        Get_OrderGrid().WaitProperty("IsEnabled",true,30000);
        
        Log.Message("Valider que les 5 ordres cochés sont soumis et affichés dans le blotteur");            
        var count =Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Count
        
        var numberOfOrdersExecutedtoday=0;          
        for(i=0;i<count;i++){
          var oderExpirationDate= Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ExpirationDate
          var status =Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Status
          if (oderExpirationDate !=null && status==statusPendingApproval){
              var oderDate = aqConvert.DateTimeToFormatStr(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ExpirationDate,"%m/%d/%y");
              var today = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y");     
              if(oderDate == today)
                  numberOfOrdersExecutedtoday++
          };
        };
        
        if(numberOfOrdersExecutedtoday==5)
          Log.Checkpoint("Les 5 ordres cochés sont soumis et affichés dans le blotteur");
        else
          Log.Error("Les 5 ordres cochés ne sont pas soumis et ne sont pas affichés dans le blotteur..Fix Version/s: 90.19.2020.09-48, 90.20.2020.10-23, 90.21-26");
        
        Log.Message("Valider que l'ordre qui n'est pas coché (Symbole=SEE) reste dans l'accumulateur");
        var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
        if(count==1){
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,symbolSEE);
        }else{
          Log.Error("On devrait avoir un seul ordre dans l'accumulateurFix Version/s: 90.19.2020.09-48, 90.20.2020.10-23, 90.21-26");
        };
        
        // ********************************************************Étape 4*******************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Sélectionner dans l'accumulateur l'ordre qui n'été pas coché (Symbole SEE).cliquer sur vérifier");
        Get_OrderAccumulatorGrid().Find("value",symbolSEE,10).Click();
        Get_OrderAccumulator_BtnVerify().Click(); 

        Log.Message("Jira:ORC-60. On ne devrait pas avoir ce message -->  Affichage d'un message bloquant indiquant que l'ordre a été vérifié par John Keynes. Concéquement, l'opération ne peut pas être effectuée.")
        SetAutoTimeOut();
        if(Get_DlgInformation().Exists){
          Log.Error("Jira: ORC-60.On ne devrait pas avoir le message bloquant");
          Get_DlgInformation().Keys("[Enter]");
        };
        
        aqObject.CheckProperty(Get_WinAccumulator_DgvAccumulator(), "VisibleOnScreen", cmpEqual,true);
 
    }
    catch(e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
 
        //(Cleanup)
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked",true,1500);
        Log.Message("Supprimer tous les ordres visibles dans l'Accumulateur");
        DeleteAllOrdersInAccumulator();
        Terminate_CroesusProcess(); //Fermer Croesus         

    }
}

