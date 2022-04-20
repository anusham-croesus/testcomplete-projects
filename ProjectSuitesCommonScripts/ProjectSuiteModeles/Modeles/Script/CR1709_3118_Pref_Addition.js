//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3118
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_3118_Pref_Addition()
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)// la pref est déjà a no dans BNC   
        RestartServices(vServerModeles);         
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800002NA", language+client);               
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "800002NA", language+client);  
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_CR1709_2166", language+client); 
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue2166", language+client);
        var positionTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionTHI", language+client);
        var quantityTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityTHI", language+client);
        var newPrice=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPriceTHI", language+client);
        var newQuantityTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewQuantityTHI", language+client);
        var newMarketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewMarketValue2166", language+client);
        var marketValueTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueTHI", language+client);
        
        var realizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGL", language+client);
        var realizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLPercent", language+client);
        var unrealizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGL", language+client);
        var unrealizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLPercent", language+client);
                                      
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        WaitObject(Get_CroesusApp(), "Uid", "GridSection_0466");  
        //Créer un Modèle
        Get_PortfolioBar_BtnWhatIf().Click();    
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);    
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Click();
        Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modelName);
        Get_WinWhatIfSave_BtnOK().Click();
    
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/2)),73); */ //EM : Modifié depuis CO: 90-07-22-Be-1
         if(Get_DlgInformation().Exists) {    
                Get_DlgInformation().Close();
        }
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelName);
        ActivateDeactivateModel(modelName,true);
               
        //assigné le compte 800204-JW au modèle
        AssociateAccountWithModel(modelName,account)
                                                                 
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
              
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click(); 
        
        SetAutoTimeOut() 
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        RestoreAutoTimeOut();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        //Dégrouper 
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();        
        /*a etape 4 du rééquilibrage valider que les colonnes G/P ne sont pas disponbles dans
        1-onglet ordres proposé*/
        if(FindColumn(realizedGL)){
          Log.Error("La colonne présente");
        } else{
          Log.Checkpoint("La colonne ne présente pas ");
        } 
        
        if(FindColumn(realizedGLPercent)){
         Log.Error("La colonne "+realizedGLPercent+" présente");
        } else{
          Log.Checkpoint("La colonne "+realizedGLPercent+" ne présente pas ");
        } 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL(), "Exists", cmpEqual, false);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent(), "Exists", cmpEqual, false);
        ScrollTabProposedOrdersBlockOffDgvProposedOrders();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL(), "Exists", cmpEqual, false);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent(), "Exists", cmpEqual, false);
                
        /*2-Onglet portefeuille projeté*/
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        if(FindColumnTabProjectedPortfolio(realizedGL)){
         Log.Error("La colonne "+realizedGL+" présente");
        } else{
          Log.Checkpoint("La colonne "+realizedGL+" ne présente pas ");
        }
        
        if(FindColumnTabProjectedPortfolio(realizedGLPercent)){
         Log.Error("La colonne "+realizedGLPercent+" présente");
        } else{
          Log.Checkpoint("La colonne "+realizedGLPercent+" ne présente pas ");
        }
        
        if(FindColumnTabProjectedPortfolio(unrealizedGL)){
         Log.Error("La colonne "+unrealizedGL+" présente");
        } else{
          Log.Checkpoint("La colonne "+unrealizedGL+" ne présente pas ");
        }
        
        if(FindColumnTabProjectedPortfolio(unrealizedGLPercent)){
         Log.Error("La colonne "+unrealizedGLPercent+" présente");
        } else{
          Log.Checkpoint("La colonne "+unrealizedGLPercent+" ne présente pas ");
        }
        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGLPercent() , "Exists", cmpEqual, false); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGL() , "Exists", cmpEqual, false);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent() , "Exists", cmpEqual, false);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGL() , "Exists", cmpEqual, false);
        Scroll();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGLPercent() , "Exists", cmpEqual, false); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGL() , "Exists", cmpEqual, false);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent() , "Exists", cmpEqual, false);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGL() , "Exists", cmpEqual, false);
        
        /*3-sommaire du portefeuille dans Onglet portefeuille projeté*/
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLReg() , "VisibleOnScreen", cmpEqual, false);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLReg() , "VisibleOnScreen", cmpEqual, false);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLReg() , "VisibleOnScreen", cmpEqual, false);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLNonReg() , "VisibleOnScreen", cmpEqual, false);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLNonReg() , "VisibleOnScreen", cmpEqual, false);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLNonReg() , "VisibleOnScreen", cmpEqual, false);
        

        /*a etape 5 du rééquilibrage valider que les colonnes G/P ne sont pas disponbles dans*/
        //Avancer à l'étape suivante par la flèche en-bas à droite 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnGenerate().Click(); 
                       
        /*2-Excel : -portefeuille projeté -Ordres individuels - Ordres groupés*/         
        Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().Click();
        Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().Click();
        Get_WinGenerateOrders_BtnGenerate().Click(); 
        Delay(15000);
                      
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        Log.Message(FolderPath)       
        
        var FileNameContains =aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-") 
        Log.Message(FileNameContains) 
        var filesArray=FindLastModifiedFilesInFolder(FolderPath,FileNameContains);
        Log.Message(filesArray);
        for(j=0;j<filesArray.length;j++){
          Log.Message(filesArray[j])
        } 
                          
        //valider la colonne realizedGL   
        for(j=0;j<filesArray.length;j++){
           if(CheckColumnInExcel(filesArray[j],realizedGL)){
            Log.Error("La colonne " +realizedGL+ " présente dans le fichier " + filesArray[j]);
       
          } else{
            Log.Checkpoint("La colonne " +realizedGL + " ne présente pas dans le fichier " + filesArray[j]);
          }
        } 
       
        //valider la colonne realizedGLPercent
        for(j=0;j<filesArray.length;j++){
           if(CheckColumnInExcel(filesArray[j],realizedGLPercent)){
            Log.Error("La colonne "+realizedGLPercent+" présente dans le fichier " + filesArray[j]);
       
          } else{
            Log.Checkpoint("La colonne "+realizedGLPercent+" ne présente pas dans le fichier " + filesArray[j]);
          }
        }
        
         //valider la colonne unrealizedGL
         for(j=0;j<filesArray.length;j++){
           if(CheckColumnInExcel(filesArray[j],unrealizedGL)){
            Log.Error("La colonne "+unrealizedGL+" présente dans le fichier " + filesArray[j]);
       
          } else{
            Log.Checkpoint("La colonne "+unrealizedGL+" ne présente pas dans le fichier " + filesArray[j]);
          }
        }
         
        //valider la colonne unrealizedGLPercent
        for(j=0;j<filesArray.length;j++){
           if(CheckColumnInExcel(filesArray[j],unrealizedGLPercent)){
            Log.Error("La colonne "+unrealizedGLPercent+" présente dans le fichier " + filesArray[j]);
       
          } else{
            Log.Checkpoint("La colonne "+unrealizedGLPercent+" ne présente pas dans le fichier " + filesArray[j]);
          }
        } 
        
        //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
                
        //Supprimer les fichiers 
        aqFileSystem.DeleteFile(FolderPath + "*.*");  
                                
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(account,modelName);     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    
    }
    finally {  
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
      Login(vServerModeles, user, psw, language);
      ResetData(account,modelName)        
      //Supprimer les fichiers 
      aqFileSystem.DeleteFile(FolderPath + "*.*"); 
      Delay(15000);
      //fermer les fichier excel
      while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
      }
      //Supprimer les fichiers 
      aqFileSystem.DeleteFile(FolderPath + "*.*"); 
	    Runner.Stop(true);
    }
}



function ResetData(account,modelName){
    Get_ModulesBar_BtnModels().Click();    
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
    
    //Supprimer le modèle
    DeleteModelByName(modelName);
}

function FindColumn(columName){
  Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
  Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
  var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
  Log.Message("Number of items in a menu " + count)
  var found=false;
  for(i=0;i<count-1;i++){
    //Log.Message(i);
    //Log.Message(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).DataContext.Label);
      if(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).DataContext.Label==columName)    
      {      
        found=true;
      } 
      //Log.Message(found)
    }
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Click(); 
    return found;
   
} 

function FindColumnTabProjectedPortfolio(columName){
  Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChName().ClickR();
  Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
  var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount
  Log.Message("Number of items in a menu " + count)
  var found=false;
  for(i=0;i<count-1;i++){
    //Log.Message(i);
    //Log.Message(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).DataContext.Label);
      if(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", i+1).DataContext.Label==columName)    
      {      
        found=true;
      } 
      //Log.Message(found)
    }
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Click(); 
    return found;
   
}

function ScrollTabProposedOrdersBlockOnDgvProposedOrders(searchValueObject)
{
    //EM : Le if a été ajouté pour faire apparaître la colonne recherchée car le scroll ne fonctionne pas toujourssur la VM 
    if(searchValueObject == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders().get_ActualWidth();
        var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders().get_ActualHeight();
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders().Click(ControlWidth-100, ControlHeight-48); 
        //Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders().Click(ControlWidth-100, ControlHeight-38);  
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do { 
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_DgvProposedOrders().Keys("[Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    } 
}

function ScrollTabProposedOrdersBlockOffDgvProposedOrders(searchValueObject)
{
    //EM : Le if a été ajouté pour faire apparaître la colonne recherchée car le scroll ne fonctionne pas toujourssur la VM
    if(searchValueObject == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().get_ActualWidth();
        var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().get_ActualHeight();
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Click(ControlWidth-100, ControlHeight-48);  
       // Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Click(ControlWidth-100, ControlHeight-38);  
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do {
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Keys("[Right][Right][Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    }       
}

function ScrollPositionsGrid(searchValueObject)
{
    //EM : Le if a été ajouté pour faire apparaître la colonne recherchée car le scroll ne fonctionne pas toujourssur la VM 
    if(searchValueObject == undefined){
       //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinRebalance_PositionsGrid().get_ActualWidth();
        var ControlHeight=Get_WinRebalance_PositionsGrid().get_ActualHeight();
        Get_WinRebalance_PositionsGrid().Click(ControlWidth-110, ControlHeight-30); //EM: 90-06-Be-26: Changement dûe au changement de la position de Scroll
        //Get_WinRebalance_PositionsGrid().Click(ControlWidth-110, ControlHeight-27); 
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do {        
            Get_WinRebalance_PositionsGrid().Keys("[Right][Right][Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    }    
}

function Scroll(){
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().get_ActualWidth();
    var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().get_ActualHeight();
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Click(ControlWidth-100, ControlHeight-48);
}


function CheckColumnInExcel(filesArrayItem,columnName){
    Log.Message(filesArrayItem)
    var myFile = aqFile.OpenTextFile(filesArrayItem, aqFile.faRead, aqFile.ctANSI); // avant ctUnicode
    // Reads text lines from the file and posts them to the test log 
    var countLineInMyFile=0; // les lignes dans le fichier txt 
    var found=false;
    while(! myFile.IsEndOfFile()){
        countLineInMyFile++;
        line = myFile.ReadLine();

        // Split at each space character.
        var textArr = line.split("	");
       
        //Log.Message("The resulting array is: " + textArr);
        //Log.Message(textArr.length)
        
        if(countLineInMyFile<3){
          for(i=0;i<textArr.length;i++){
            if(textArr[i]==columnName){
              found=true;
            } 
          } 
        } 
     } 
     // Closes the file
     myFile.Close();
     return found;
} 


