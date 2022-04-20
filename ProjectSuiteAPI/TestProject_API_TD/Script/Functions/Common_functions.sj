
/**
    Description : Récupère le nom d'hôte utilisé pour se connecter au VServeur via SSH
    Paramètre : URL du VServeur
    Résultat : Nom d'hôte du Vserveur
    Auteur : Christophe Paring
*/
function GetVserverHostName(vServerURL)
{
    Log.Message("VServer URL is : " + vServerURL);
    hostname = aqString.Replace(aqString.Replace(aqString.Replace(vServerURL, ".croesus.local", "", false), "http://", "", false), "/", "", false);
    Log.Message("VServer host name is : " + hostname);
    return hostname;
}

/**
    Description : Crée un fichier et y écrit le texte spécifié ;
                  si le fichier existe, il est écrasé.
    Paramètres : 
        - filePath : chemin d'accès du fichier
        - text : chaîne de caractères à écrire dans le fichier
    Résultat : Fichier créé et texte écrit.
               Affichage d'un message indiquant si l'opération a réussi
    Auteur : Christophe Paring
*/
function CreateFileAndWriteText(filePath, text)
{
    Log.Message("Create the file : " + filePath + ", and write the following text to it :");
    Log.Message(text);
    
    if (aqFile.WriteToTextFile(filePath, text, aqFile.ctANSI, true))
        Log.Message("File created and text written to it successfully.");
    else
        Log.Error("Failed to create file and write text to it.");
}


/**
    Description : Exécute un fichier batch.
                  Pour utiliser l'utilitaire PLINK (permettant d'exécuter des scripts Shell Linux),
                  il faut que le fichier PLINK.EXE soit présent dans le même dossier que le fichier batch.
    Paramètres : batchFilePath (Chemin d'accès du fichier batch)
    Résultat : Fichier batch exécuté
    Auteur : Christophe Paring
*/
function ExecuteBatchFile(batchFilePath)
{
    Log.Message("Execute batch file : " + batchFilePath);
    
    defaultCurrentFolder = aqFileSystem.GetCurrentFolder();
    batchFileFolderPath = aqFileSystem.GetFileInfo(batchFilePath).ParentFolder.Path;
    
    Log.Message("Set current folder to : " + batchFileFolderPath);
    aqFileSystem.SetCurrentFolder(batchFileFolderPath);
    
    batchFilePath = "\"" + batchFilePath + "\"";
    Log.Message("Execute file : " + batchFilePath);
    shellObj = Sys.OleObject("WScript.Shell");
    shellObj.Run(batchFilePath, 1, true);
    //2eme paramètre de Run : 0 = n'affiche pas de fenêtre DOS ; 1 = affiche une fenêtre DOS (défaut)
    //3eme paramètre de Run : true = attend la fin de l'exécution ; false = n'attend pas la fin de l'exécution (défaut)
    
    Log.Message("Set current folder back to : " + defaultCurrentFolder);
    aqFileSystem.SetCurrentFolder(defaultCurrentFolder);
}


function RestartServices(nomVServer)//!!!!!!  Il faut Turn off Pop-Up Blocker of IE !!!!!!!!!!
{
    var url = nomVServer + "cfadm/";  
    //Terminate processes
    Terminate_IEProcess();
    //Launch the specified browser and opens the specified URL in it.
    Browsers.Item("iexplore").Run(url);
    // Obtains the browser process
    var browser = Sys.Browser("iexplore");
    // Obtains the page currently opened in Internet Explorer
    var page = browser.Page("*");

    page.contentDocument.Script.eval("cfadm('ALL', 'restart')");
    
    var j=1;  
    do{j++
    aqUtils.Delay(1000);
    obj = Sys.Browser("iexplore").Page(nomVServer+"cfadm/?mode=service&service=ALL&action=restart").FindChild("ObjectIdentifier", "Ok");
    
    if(j==300){
        Log.Error("L'élément button OK n'est pas présent sur la page" )
        break; 
      }    
    }while(!obj.Exists);
    Sys.Browser("iexplore").Page(nomVServer+"cfadm/?mode=service&service=ALL&action=restart").Button("Ok").Click();

    Terminate_IEProcess();
  
}


//Terminate IE process
function Terminate_IEProcess()
{
    while( Sys.WaitBrowser("iexplore",0).Exists){
        Log.Message("Terminate Internet Explorer process.");
        Sys.Browser("iexplore").Terminate();
        aqUtils.Delay(500);
    }
}


/**
    Description : Ajoute le catactères Escape Batch approprié avant certains caractères spécifiques d'une chaîne de caractères.
*/
function GetBatchEscapedCharsString(varString)
{
    varString = aqString.Replace(varString, "%", "%%");
    var escapedChars = ["^", "&", "<", ">", "|", "\\"];
    var varStringArray = varString.split("");
    for (var i in varStringArray)
        if (GetIndexOfItemInArray(escapedChars, varStringArray[i]) != -1)
            varStringArray[i] = "^" + varStringArray[i];
    
    return varStringArray.join("");
}
