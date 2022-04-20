//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT GDO_2473_Report_Of_FidessRates_Case1
//USEUNIT GDO_2477_ChangeStatus_Of_TradeBlock_Open
//USEUNIT DBA 

/* Description :Rapport des ordres Fidessa cas 2
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2474
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2474_Report_Of_FidessRates_Case2_YES()
 {             
    try{ 
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2473", language+client);
        var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Message_2471", language+client);
        
        if(language=="french"){
          var today="%Y/%m/%d"
        } else{
          var today="%m/%d/%Y"
        } 
       
        //fermer les fichiers excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
        
        //L'ordre de status ouvert 
        ChangeStatus_Of_TradeBlock_Open();
        
         //Choisir l'order créé aujourd’hui   
        if(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem.SecurityDesc==security){
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();              
        }
        else{
          Log.Error("L’ordre n’a pas été créé")
        } 
               
        //Générer le rapport   
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_FidessaOrderReport().Click();
        
        //Valider le message 
        aqObject.CheckProperty(Get_DlgConfirmation(), "CommentTag", cmpEqual, message); 
        
        //cliquer sur YES
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), Get_DlgConfirmation().get_ActualHeight()-45);
        
        //Vérifier que le fichier Excel généré 
        if(Sys.Process("EXCEL").Exists){
          Log.Checkpoint("Le fichier Excel est ouvert")
        } 
        else{
          Log.Error("Le fichier Excel n'est pas ouvert")
        } 
        
        //Vérifier que lu statut est toujours 'ouvert'
        Get_OrderGrid().Find("Value",security,10).Click()
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "Status", cmpEqual,statusOpen); 
        
        //*******************************************************Vérifier que le fichier Excel généré*************************************************************** 
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var folderName=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%b%d")
        Log.Message(sTempFolder+"\CroesusTemp\\Executions\\",folderName+"*")
        var folderPath= FolderFinder(sTempFolder+"\CroesusTemp\\Executions\\",folderName+"*")
        Log.Message(folderName)
        Log.Message(folderPath);
        var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d") 
        var app, rowNum;
        
        app = Sys.OleObject("Excel.Application");
        app.Workbooks.Open(FindLastModifiedFileInFolder(VarToStr(folderPath),fileNameContains));
        Log.Message(FindLastModifiedFileInFolder(VarToStr(folderPath),fileNameContains))
        var RowCount = app.ActiveSheet.UsedRange.Rows.Count;
       
        //Valider que dans le fichier Excel il y a 2 lignes 
        if(RowCount==2){
         Log.Checkpoint("Le fichier contient 2 lignes. Les entêtes et 1 titres")
        }
        else{
         Log.Error("Le fichier ne contient pas 2 lignes.Les entêtes et 1 titres")
        } 
        
        var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(VarToStr(folderPath),fileNameContains), aqFile.faRead, aqFile.ctANSI);                 
        // Reads text lines from the file and posts them to the test log 
        var countLineInMyFile=0; // les lignes dans le fichier 
        while(! myFile.IsEndOfFile()){    
          countLineInMyFile++;
          line = myFile.ReadLine();
          // Split at each space character.
          var textArr = line.split("	"); 
          Log.Message(line)      
          if(countLineInMyFile==2){  
           var textArrUnquote4=aqString.Unquote(VarToString(textArr[4]));
           var textArrUnquote5=aqString.Unquote(VarToString(textArr[5]));        
              if(aqObject.CompareProperty(VarToString(textArrUnquote4),cmpContains, quantity,true,lmError) && aqObject.CompareProperty(VarToString(textArrUnquote5),cmpContains, securitySymbol,true,lmError)){
                Log.Checkpoint("Le titre est dans le fichier Excel")
              } 
              else{
                Log.Error("Le titre n'est pas dans le fichier Excel")
              } 
          }
        }  
        // Closes the file
        myFile.Close();               
              
        Close_Croesus_MenuBar();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); //CP : Modifié pour CO
        
        //fermer les fichiers excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
      Runner.Stop(true); 
    }
 }
