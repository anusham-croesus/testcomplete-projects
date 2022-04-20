//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Modèle/Exclusion des titres non supportés lors de la génération de block trades
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2460
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2460_Exclusion_Of_UnsupportedSecurities()
 {             
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var userUNI00=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
        var modelDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ModelNo_2460", language+client)
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CodeCP_2509", language+client);
        var security802708=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Security802708", language+client);
        var securityN26997=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityN26997", language+client);
        var security940108=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Security940108", language+client);
        var securityR76795=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityR76795", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Message_2460", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_800049OB", language+client);
        
        //RemoveAccountFromModel qui a été ajoute depuis ref90-04-BNC-Int-Mainline-50--V9-CX_1-co6x
        /*Login(vServerOrders, userUNI00 , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();                        
        SearchModelByName("RECHANGE_PANIER");
        
        RemoveAccountFromModel("800285", "RECHANGE_PANIER")
        Terminate_CroesusProcess(); //Fermer Croesus*/ //EM : 90.10.Fm-13 : A partir de CR2031, sur le Dump le client 800285 n'est plus assigné au modèle RECHANGE_PANIER : Confirmé par Carole.
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
               
        //Création d'un modèle         
        Get_Toolbar_BtnAdd().Click();    
        Get_WinModelInfo_GrpModel_TxtFullName().Keys(modelDescription);
        Get_WinModelInfo_GrpModel_CmbIACode().Click();
        Aliases.CroesusApp.subMenus.Find("DataContext",codeCP,10).Click();
        Get_WinModelInfo_BtnOK().Click();
        SetAutoTimeOut();          
        if( Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription,10).Exists){
            Log.Checkpoint("Le modèle a été créé ")
        } else{
            Log.Error("Le modèle n'a pas été créé")
        }
        RestoreAutoTimeOut();       
        //Sélectionner des titres 
        Get_ModulesBar_BtnSecurities().Click();        
        Search_Security(security802708)
        Get_SecurityGrid().Find("DisplayText",security802708,10).Click(); // "Value" Ne fonctionne plus depuis ref90-05-8--V9-CX_1-co6x
        Search_Security(securityN26997)
        Get_SecurityGrid().Find("DisplayText",securityN26997,10).Click(10,10,skCtrl);
        Search_Security(security940108)
        Get_SecurityGrid().Find("DisplayText",security940108,10).Click(10,10,skCtrl);
        Search_Security(securityR76795)
        Get_SecurityGrid().Find("DisplayText",securityR76795,10).Click(10,10,skCtrl);
        
        //Mailler les titres sélectionnés ver le module comptes   
        Drag(Get_SecurityGrid().Find("Value",securityR76795,10), Get_ModulesBar_BtnAccounts());
        
        //Valider que les 4  titres ont été maillés
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpContains, security802708);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpContains, securityN26997);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpContains, security940108);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpContains, securityR76795);
                
        //Associer à un modèle
        Get_RelationshipsClientsAccountsGrid().Keys("^a");
        Get_RelationshipsClientsAccountsGrid().ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
        
        Get_WinPickerWindow_DgvElements().Find("Value",modelDescription,10).Click();
        Get_WinPickerWindow_BtnOK().Click();        
        Get_WinAssignToModel_BtnYes().Click();
        
        //Rééquilibrer le modèle 
        Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Find("Value",modelDescription,10).Click();
        Get_Toolbar_BtnRebalance().Click();
         
        //La fenêtre de rééquilibrage  
        //L’étape 1 
        Get_WinRebalance_BtnNext().Click();
        //L’étape 2
        Get_WinRebalance_BtnNext().Click();
        //L’étape 3
        Get_WinRebalance_BtnNext().Click();  
        //L’étape 4     
        Get_WinRebalance_BtnNext().WaitProperty("Enabled",true, 2000)
        Get_WinRebalance_BtnNext().Click();
        //L’étape 5
        Get_WinRebalance_BtnGenerate().Click();
        
        Get_WinGenerateOrders_BtnGenerate().Click();
        SetAutoTimeOut();
        if(Get_DlgInformation().Exists){
          var width = Get_DlgInformation().Get_Width();
          Get_DlgInformation().Click((width*(1/3)),73);          
        } 
        RestoreAutoTimeOut();       
        //Validation du message
        if(language=="french"){
        Log.Message("CROES-7699")
          aqObject.CheckProperty(Get_DlgConfirmation(), "CommentTag", cmpEqual, "Les titres suivants ne peuvent pas être ajoutés à l'Accumulateur: N26997, R76795.\r\nVoulez-vous les exporter dans un fichier Excel?"); //EM: Modifié selon le Jira CROES-7699
        }
        else{
          aqObject.CheckProperty(Get_DlgConfirmation(), "CommentTag", cmpEqual, "The following securities cannot be added in the Accumulator: N26997, R76795.\r\nDo you want to export them to Excel?"); //EM: Modifié selon le Jira CROES-7699
        } 
        
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      
        //****************************************************************Validation du fichier Excel************************************************************        
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        Log.Message(FolderPath)
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
        Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains))
       
        var app, rowNum;
        app = Sys.OleObject("Excel.Application");
        app.Workbooks.Open(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
        var RowCount = app.ActiveSheet.UsedRange.Rows.Count;
       
        //Valider que dans le fichier Excel il y a 3 lignes 
        if(RowCount==3){
         Log.Checkpoint("Le fichier contient 3 lignes. Les entêtes et 2 titres")
        }
        else{
         Log.Error("Le fichier ne contient pas 3 lignes.Les entêtes et 2 titres")
        } 
    
        var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);       
        // Reads text lines from the file and posts them to the test log 
        var countLineInMyFile=0; // les lignes dans le fichier 
        while(! myFile.IsEndOfFile()){    
          countLineInMyFile++;
          line = myFile.ReadLine();
          // Split at each space character.
          var textArr = line.split("	");       
          if(countLineInMyFile==2){//vérification des entètes
              Log.Message(VarToString(textArr[14]))
              var textArrUnquote=aqString.Unquote(VarToString(textArr[14]));
              aqObject.CompareProperty(VarToString(securityR76795),cmpEqual, textArrUnquote,true,lmError);
          }
           if(countLineInMyFile==3){//vérification des entètes
              Log.Message(VarToString(textArr[14]))
               var textArrUnquote=aqString.Unquote(VarToString(textArr[14]));
              aqObject.CompareProperty(VarToString(securityN26997),cmpEqual, textArrUnquote,true,lmError);             
          }
        }  
        // Closes the file
        myFile.Close(); 
       
       //Remettre les données   
       Get_ModulesBar_BtnModels().Click(); 
       Get_ModelsGrid().RecordListControl.Find("Value",modelDescription,10).Click();
       Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Find("Value", account,100).Click();
       Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Find("Value", account,100).Keys("^a"); 
       Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click()
       
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       
       Get_ModelsGrid().RecordListControl.Find("Value",modelDescription,10).Click();
       Get_Toolbar_BtnDelete().Click();
       
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
       Close_Croesus_MenuBar();
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        //Remettre les données 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        if(Get_ModelsGrid().RecordListControl.Find("Value",modelDescription,10).Exists){
             var count=Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items.Count
             if(count>0){
               //Remettre les données  
               Get_ModelsGrid().RecordListControl.Find("Value",modelDescription,10).Click();  
               Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Find("Value", account,100).Click()
               Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Find("Value", account,100).Keys("^a"); 
               Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click()
       
               Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       
               Get_ModelsGrid().RecordListControl.Find("Value",modelDescription,10).Click();
               Get_Toolbar_BtnDelete().Click();
               
               Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
             }
       }
       Close_Croesus_MenuBar();
    }
    finally {  
    
       //fermer les fichiers excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        } 
        
        Terminate_CroesusProcess(); //Fermer Croesus
               
    }
 }


 

