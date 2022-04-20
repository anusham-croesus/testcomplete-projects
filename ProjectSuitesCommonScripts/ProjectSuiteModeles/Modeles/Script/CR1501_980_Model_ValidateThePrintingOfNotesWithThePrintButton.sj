//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT PDFUtils


/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-980

     Préconditions : 
     Se connecter avec COPERN
     
     
     1-Choisir le module modèle.:Le module modèle s'ouvre correctement.
     2-Sélectionner un modèle:Le modèle est bien sélectionné.
     3-Cliquer sur le bouton 'Info':La fenêtre info est ouverte.
     4-Choisir l'onglet note ensuite cliquer sur le bouton 'Imprimer'.:L'impression du brouillon de travail fonctionne correctement 
     et la liste des notes imprimée correspond aux notes de la position.
     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_980_Model_ValidateThePrintingOfNotesWithThePrintButton()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-980");
    
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
           
          
            //Se connecter avec COPERN
       Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
       
       var modelNameCroes940=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelNameCroes940", language+client);
       var modelTextAddNotCROES980=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "modelTextAddNotCROES980", language+client);
       var NameFileCROES980=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "NameFileCROES980", language+client);
       var line1ImpressioCROES980=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "line1ImpressioCROES980", language+client);
       var pageimpressionCROES980=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "pageimpressionCROES980", language+client);
       var line2ImpressioCROES980=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "line2ImpressioCROES980", language+client);
       var Userline6impressionCROES980=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1501", "Userline6impressionCROES980", language+client);
            
      
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
       //ajout d'une note
         Get_ModulesBar_BtnModels().Click();
         SearchModelByName(modelNameCroes940);
         Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();//Le modéle *FALL BACK n'as pas de note
         Get_ModelsBar_BtnInfo().Click();
         Get_WinModelInfo_TabNotes().Click();
         Get_WinModelInfo_TabNotes_TabGrid().Click();
         Get_WinModelInfo_TabNotes_TabGrid_BtnAdd().Click();
         WaitObject(Get_CroesusApp(), "Uid", " NoteDetailWindow_2d5e");
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(modelTextAddNotCROES980);
          Get_WinCRUANote_GrpNote_TxtNote().Click()
           WaitObject(Get_Models_Details(),["UID", " IsEnabled"],["Button_eb1f", true],10);
          Get_WinCRUANote_BtnSave().Click();
        
          //Les points de vérifications
             aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, modelTextAddNotCROES980);
          
            var textNotCROES980= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES980), 10)
            var x=textNotCROES980.Exists;
            Log.Message(x);
          if(textNotCROES980.Exists && textNotCROES980.VisibleOnScreen)
            {
             Log.Checkpoint("La note est ajoutée")
            }
            else{
              Log.Error("La note n'est pas ajoutée")
            }
          Get_WinModelInfo_BtnOK().Click();
          
          Get_ModulesBar_BtnModels().Click();
          SearchModelByName(modelNameCroes940);
          Get_ModelsGrid().Find("Value",modelNameCroes940,10).Click();//Le modéle *FALL BACK n'as pas de note
          Get_ModelsBar_BtnInfo().Click();
          Get_WinModelInfo_TabNotes().Click();
          Get_WinModelInfo_TabNotes_TabGrid().Click();
          
          Get_WinModelInfo_TabNotes_TabGrid_ChEffectiveDate().ClickR();
          Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
          
           
           var enteteColonne1=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10).WPFControlText
           var enteteColonne2=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10).WPFControlText
           Log.Message("valeur de la colonne enteteColonne2"+enteteColonne2)
           var enteteColonne3=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10).WPFControlText
           if(language == "french")
           { 
            var line3ImpressioCROES980=enteteColonne1+"  "+enteteColonne2+"         "+enteteColonne3;
            }
           else
           {
             var line3ImpressioCROES980="       "+enteteColonne1+"     "+enteteColonne2+"        "+enteteColonne3;
           }
           
           
           var line4ImpressioCROES980=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "4"], 10).WPFControlText
           var indexligne =Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",VarToString(modelTextAddNotCROES980), 10).Record.Index
           var  datCrationCroes980=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indexligne+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamDateTimeEditor", "", 1).DisplayText.OleValue
           var  creaBycROES980=Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indexligne+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).WPFObject("XamTextEditor", "", 1).DisplayText.OleValue
           var line5ImpressioCROES980=Userline6impressionCROES980+datCrationCroes980+"  "+creaBycROES980
           
           if (client == "CIBC"){
                line3ImpressioCROES980=enteteColonne1+"     "+enteteColonne2+"       "+enteteColonne3;
                line5ImpressioCROES980="1.                  "+datCrationCroes980+"  "+creaBycROES980
           }
           
             //Suppression du fichier pdf s'il existe
           var FilePathCROES980=Project.Path+ NameFileCROES980;
           if (aqFileSystem.Exists(FilePathCROES980))
                aqFile.Delete(FilePathCROES980);
          
          
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(modelTextAddNotCROES980), 10).Click();
          Get_WinModelInfo_TabNotes_TabGrid_BtnPrint().Click()
           if(Get_DlgPrint().Exists)
            {
              Log.Checkpoint("Dialogue d'impression est présent.");
             
            }
            else
              Log.Error("Dialogue d'impression est absent.");
              
            
              
           
              var tempFileName = aqFileSystem.GetFileNameWithoutExtension(FilePathCROES980) + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
              Log.Message("Le chemin du dossier FilePathCROES980"+FilePathCROES980)
            
             
              
              
             Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).HScroll.Pos = 0;
             Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).ClickItem("Microsoft Print to PDF");
             Get_DlgPrint_BtnPrint().Click();
             
               Get_DlgSavePrintOutputAs_CmbFileName_TxtFileName().Keys(FilePathCROES980);
              Get_DlgSavePrintOutputAs_BtnSave().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), ["WndClass", "WndCaption"], ["Button", "&Save"])
              
             
             var PDFPageNumber = 1; //Numéro de la page cible du fichier PDF
             var pictureIndex = 1; //Numéro de l'image cible dans la page cible
            
             
           var fileName= ExtratTxtFromPdf(FilePathCROES980,PDFPageNumber);
           
              //parcourir le fichier .txt
                var timeAddMinute=aqDateTime.AddMinutes(datCrationCroes980, 0);//0
                if(language == "french"){
                 var datCreationAddMinuteCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%Y/%m/%d %H:%M");
                 var datCrationCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%Y/%m/%d  %H:%M");}
                else{
                   var datCreationAddMinuteCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%m/%d/%Y %H:%M");
                   var datCrationCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%m/%d/%Y  %H:%M");
                    }
               var datCreationAndPage=datCrationCroes980+pageimpressionCROES980
               if (client == "CIBC")
                    var datCrationCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%m/%d/%Y  %H:%M");
                    //var datCreationAndPage=datCrationCroes980 +"  SA: j'ai mis en commentaire cette variable parce qu'elle est déclaré en Haut                                                                                                       page 1";
               //datCreationAddMinuteCroes980+pageimpressionCROES980
               //aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d  %#I:%M")+pageimpressionCROES980
               var arrayDataCroes980 = new Array(line1ImpressioCROES980,line2ImpressioCROES980,datCreationAndPage,line3ImpressioCROES980,line4ImpressioCROES980,line5ImpressioCROES980,modelTextAddNotCROES980);
        
              var myFile = aqFile.OpenTextFile(fileName, aqFile.faRead, aqFile.ctUTF8);
    
              // Reads text lines from the file and posts them to the test log 
              var countLineInMyFile=0; // les lignes dans le fichier txt 
              var countLineInGrid=0; // les lignes dans la grille de l'application Croesus, dans Manage filters 
              while(! myFile.IsEndOfFile()){
    
                  countLineInMyFile++;
                  line = myFile.ReadLine();

                 
                  Log.Message("La ligne est"+countLineInMyFile)
                 
                   Log.Message(line);
                   Log.Message(aqString.Trim(line),aqString.stAll);
                   Log.Message(arrayDataCroes980[countLineInMyFile-1]);
                   //SA: ajout suite au probléme de différence au niveau des minutes
                   if(countLineInMyFile == 3 && aqString.Trim(arrayDataCroes980[countLineInMyFile-1])!=aqString.Trim(line) )
                   {
                      var timeAddMinute=aqDateTime.AddMinutes(datCrationCroes980, 1);
                if(language == "french"){
                 var datCreationAddMinuteCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%Y/%m/%d %H:%M");
                 var datCrationCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%Y/%m/%d  %H:%M");}
                else{
                   var datCreationAddMinuteCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%m/%d/%Y %H:%M");
                   var datCrationCroes980=aqConvert.DateTimeToFormatStr(timeAddMinute, "%m/%d/%Y  %H:%M");
                    }
               var datCreationAndPage=datCrationCroes980+pageimpressionCROES980
                   }
                   CheckEquals(aqString.Trim(arrayDataCroes980[countLineInMyFile-1]),aqString.Trim(line),"le texte affichée sur la ligne "+countLineInMyFile)

               } 
 
    
               myFile.Close();
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));      
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(modelTextAddNotCROES980, vServerModeles)
        Terminate_CroesusProcess();
     
       
        
    }
    
}

function ExtratTxtFromPdf(PDFFilePath, startPageNumber, endPageNumber)
{
  
  if (startPageNumber != undefined && endPageNumber == undefined)
        endPageNumber = startPageNumber;
    
    Log.Message("Get Text from PDF file : " + PDFFilePath);
    
    //Copier le fichier PDF dans le dossier temporaire
    var tempFileName = aqFileSystem.GetFileNameWithoutExtension(PDFFilePath) + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
    var tempPDFFilePath = Sys.OSInfo.TempDirectory + tempFileName + ".pdf";
    var outputTextFilePath = Sys.OSInfo.TempDirectory + tempFileName + ".txt";
    aqFileSystem.CopyFile(PDFFilePath, tempPDFFilePath);
    
    //Exécuter la ligne de commande
    var commandLineParameters = "ExtractText";
    if (startPageNumber != undefined) commandLineParameters += " -startPage " + startPageNumber;
    if (endPageNumber != undefined) commandLineParameters += " -endPage " + endPageNumber;

    if (ExecuteJARAppCommandLine(commandLineParameters, tempPDFFilePath)){
        //Attendre que le fichier texte de sortie soit correctement écrit
        var nbOfChecks = 0;
        do {
            Delay(1000);
        } while (!aqFileSystem.Exists(outputTextFilePath) && ++nbOfChecks < 20)
        
        //Retourner le chemin d'accès du fichier texte de sortie
        if (aqFileSystem.Exists(outputTextFilePath)){
            Log.Message("The PDF text extracted file is : " + outputTextFilePath);
            return outputTextFilePath;
        }
    }
    
    Log.Error("The PDF text extraction was not successful.");
    return null;

}
