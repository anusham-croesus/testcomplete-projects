//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Common_functions


/*
      
      Analyste d'automatisation: Sana Ayaz*/

function RemoveReadOnlyFromFileDataPerformance(){
    try{
           //Log.Message("Is project language JavaScript? " + isJavaScript());
           Log.Message("Enlever la lecture seule du fichier : data_Performance.xlsx ")
           Log.Message(folderPath_Data)
           SetNotReadOnlyAttributeToFileDataPerfo(folderPath_Data,"data_Performance.xlsx");
       
          
    }        
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {        
              
    }
}


function SetNotReadOnlyAttributeToFileDataPerfo (Folder,FileName) 
      {
         /*Verifier l'existance du fichier*/
          var FileExiste = CheckIfFileExists(Folder,FileName)
          if(FileExiste != null) 
             {
                 var state = aqFile.GetFileAttributes(Folder+FileName);
                 if (state == 1 || state == 33 )//si read only
                   {
                      Log.Message("Le fichier "+FileName+" est en lecture seule");
                      Log.Message("Enlever la lecture seule du fichier"+FileName);
                      aqFile.SetFileAttributes(Folder+FileName,32);
                   }  
             }
      }