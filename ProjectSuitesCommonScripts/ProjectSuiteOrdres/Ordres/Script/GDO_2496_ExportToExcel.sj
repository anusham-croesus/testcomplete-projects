//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Export vers excel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2496
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */

 function GDO_2496_ExportToExcel()
 {
   try{

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
            
        //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
        
       Get_OrderGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).ClickR();
       Get_OrderGrid_ContextualMenu_ExportToMSExcel().Click();
       
       Sys.WaitProcess("EXCEL", 30000);
       //Dans le cas demande de valider que  Fichier MS Excel généré sans crash .
       aqObject.CheckProperty(Sys.Process("EXCEL"), "Exists", cmpEqual, true);           
        
       /*var sTempFolder = Sys.OSInfo.TempDirectory;
       var FolderPath= sTempFolder+"\CroesusTemp\\"
       Log.Message(FolderPath)
       var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
       Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains))
    
       var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
    
       // Reads text lines from the file and posts them to the test log 
       var countLineInMyFile=0; // les lignes dans le fichier 
       var countLineInGrid=0; // les lignes dans la grille de l'application Croesus, dans Manage filters 
       while(! myFile.IsEndOfFile()){    
          countLineInMyFile++;
          line = myFile.ReadLine();
          // Split at each space character.
          var textArr = line.split("	");       
          Log.Message("The resulting array is: " + textArr);
          if(countLineInMyFile==1){//vérification des entètes
              if(client=="RJ"){
                var textArrUnquote7=aqString.Unquote(textArr[1]);
              }
              else{
                var textArrUnquote7=aqString.Unquote(textArr[7]);
              }          
              aqObject.CheckProperty(Get_OrderGrid_ChSymbol(), "WPFControlText", cmpEqual, textArrUnquote7);
          }
          else {//vérification des données dans la grille 
            if(client=="RJ"){
              var textArrUnquote7=aqString.Unquote(textArr[1]);
            }
            else{
              var textArrUnquote7=aqString.Unquote(textArr[7]);
            }
            aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "OrderSymbol", cmpEqual, textArrUnquote7);           
            countLineInGrid++
          }
       } 
 
       // Closes the file
       myFile.Close();*/
    
       Close_Croesus_AltF4()  
    
       //fermer les fichier excel
       while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        } 
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    } 
 }