//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT DBA 

/* Description :Rapport des ordres Fidessa cas 1
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2473
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2473_Report_Of_FidessRates_Case1()
 {             
    try{ 
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username"); 
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2471", language+client);
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2471", language+client);
        
        if(language=="french"){
          var today="%Y/%m/%d"
        } else{
          var today="%m/%d/%Y"
        } 
        
        //fermer les fichiers excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
        //Supprimer des ordres dans accumulateur si existent
        DeleteAllOrdersInAccumulator();  
        
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        //Creation d'ordre 
        CreateEditStocksOrder(account,quantity,security)
        
        //Sélectionner l'ordre créé
        Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
        Get_OrderAccumulator_BtnEdit().Click(); 
        
        //btn Verifier
        Get_WinOrderDetail_BtnVerify().Click();
        //btn Submit
        Get_WinOrderDetail_BtnVerify().Click();
        
        //Verification
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "SecurityDesc", cmpEqual,security); 
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,status);  
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity);
        
        
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
        
        //Vérifier le changement du statut 
        Get_OrderGrid().Find("Value",security,10).Click()
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "Status", cmpEqual,statusOpen); 
        
        //*******************************************************Vérifier que le fichier Excel généré*************************************************************** 
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var folderName=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%b%d")
        //var folderPath= FolderFinder(sTempFolder+"\CroesusTemp\\Executions\\",folderName+"*")
        var folderPath=SubFoldersFinder(sTempFolder+"\CroesusTemp\\Executions\\")
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
 
 
 function FindLastModifiedFileInFolder(FolderPath, FileNameContains)
{    
    var FolderObject = aqFileSystem.GetFolderInfo(FolderPath); //The folder to look in
    var FileItems = FolderObject.Files;     //Collection of all the files in the folder
    var found;
    
    //Builds up the arrays with the filnames containing FileNameContains reg exp
    for (var i=0; i < FileItems.Count ; i++){ 
        if (i == FileItems.Count-1){
            found = FileItems.Item(i).Path;
        }
        else if ((FileItems.Item(i).Name.search(FileNameContains) > -1) && (FileItems.Item(i+1).Name.search(FileNameContains) <= -1)){
            found = FileItems.Item(i).Path;
            break;
        } 
    }    
    return found
}

function test()
{
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var folderName=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%b%d")
        var folderPath= FolderFinder(sTempFolder+"\CroesusTemp\\Executions\\",folderName+"*")
        FindLastModifiedFileInFolder(sTempFolder+"\CroesusTemp\\Executions\\", folderName)
        Log.Message(FindLastModifiedFileInFolder)
          Log.Message(SubFoldersFinder(sTempFolder+"\CroesusTemp\\Executions\\"))
       //Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
} 




function SubFoldersFinder(sPath)//sPath-Specifies the path to the desired folder
{

  // Obtains information about the folder
  var FolInfo = aqFileSystem.GetFolderInfo(sPath);
  // Obtains the collection of subfolders
  var colSubFolders = FolInfo.SubFolders;
  var subFolders=new Array();

  // Checks whether the collection is empty
  if (colSubFolders != null){
      // Posts the names of the folder's subfolders to the test log
      Log.AppendFolder("The " + sPath + " folder contains the following subfolders:");

      while (colSubFolders.HasNext()){
          // Obtains the current subfolder
          var FolItem = colSubFolders.Next();
          // Posts the subfolder's name to the test log
          Log.Message(FolItem.Name);
          subFolders.push(FolItem.Path)
      }
        Log.PopLogFolder();
      
  }else
    Log.Message("The specified folder does not contain any subfolders.");
    
    return subFolders
}
