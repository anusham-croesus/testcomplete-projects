//USEUNIT Global_variables
//USEUNIT Common_functions


function LoadImageFromFile(imageFilePath)
{
    var imageObject = Utils.Picture;
    imageObject.LoadFromFile(imageFilePath);
    
    var nbOfWaitChecks = 0;
    while (imageObject.Handle == 0 && ++nbOfWaitChecks < 100)
        Delay(100);
    
    if (imageObject.Handle == 0)
        Log.Warning("There was a possible issue while loading Image from file : " + imageFilePath);
        
    return imageObject;
}



//************************ FONCTIONS UTILISANT L'API ******************************

function GetPDFDocument(PDFFilePath)
{
    try {
        ClosePdfDoc();
        if (!aqFile.Exists(PDFFilePath))
            Log.Error("File '" + PDFFilePath + "' not found.");
        else {
            var javaFile = JavaClasses.java_io.File.newInstance(PDFFilePath);
            globalPdfDoc = JavaClasses.org_apache_pdfbox_pdmodel.PDDocument.newInstance().load_2(javaFile);
        }
    }
    catch(exceptionGetPDFDocument){
        Log.Error("GetPDFDocument() Exception: " + exceptionGetPDFDocument.message, VarToStr(exceptionGetPDFDocument.stack));
        exceptionGetPDFDocument = null;
    }
    finally {
        return globalPdfDoc;
    }

}


function GetPDFDocumentAllPages(PDFFilePath)
{
    var arrayOfPdfPages = new Array();
    
    var pdfDoc = GetPDFDocument(PDFFilePath);
    var pdfPages = pdfDoc.getPages();
    
    for (var i = 0; i < pdfPages.getCount(); i++)
        arrayOfPdfPages.push(pdfPages.get(i));
    
    return arrayOfPdfPages;
}


function GetPDFDocumentPage(PDFFilePath, pageNumber)
{
    var arrayOfPDFPages = GetPDFDocumentAllPages(PDFFilePath);
    if (pageNumber < 1 || pageNumber > arrayOfPDFPages.length){
        Log.Error("There is only " + arrayOfPDFPages.length + " pages in the PDF document ; the first page number is 1.");
        return null;
    }
    
    return arrayOfPDFPages[pageNumber - 1];
}



function GetPdfImageXObjects(objectInPdfDoc)
{
    var pdfObjectResources = objectInPdfDoc.getResources();
    var arrayOfXObjects = pdfObjectResources.getXObjectNames().toArray();
    
    if (typeof globalArrayOfPdfImageXObjects == "undefined" || (GetVarType(globalArrayOfPdfImageXObjects) != varArray && GetVarType(globalArrayOfPdfImageXObjects) != varDispatch))
        globalArrayOfPdfImageXObjects = [];
    
    for (var i = 0; i < arrayOfXObjects.length; i++){
        var currentXObject = pdfObjectResources.getXObject(arrayOfXObjects.Items(i));
        if (currentXObject.JavaClassName == "PDImageXObject")
            globalArrayOfPdfImageXObjects.push(currentXObject.getImage());
        else if (currentXObject.JavaClassName == "PDTransparencyGroup")
            GetPdfImageXObjects(currentXObject);
    }
    
    return globalArrayOfPdfImageXObjects;
}



function FlushPdfImageXObjects()
{
    globalArrayOfPdfImageXObjects = null;
}


function ClosePdfDoc()
{
    if (typeof globalPdfDoc != "undefined") globalPdfDoc.close();
	globalPdfDoc = null;
}



function GetPdfImagesFromObject(objectInPdfDoc)
{
	FlushPdfImageXObjects();
    var arrayOfPdfImageXObjects = GetPdfImageXObjects(objectInPdfDoc);
    
    var imagesFolderPath = Project.Path + "ImagesPDF\\";
    if (!aqFileSystem.Exists(imagesFolderPath)) aqFileSystem.CreateFolder(imagesFolderPath);
    
    var arrayOfPdfImages = [];
    for (var j in arrayOfPdfImageXObjects){
        var imageFilePath = imagesFolderPath + "PDF_Image_" + j + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S") + ".png";
        var javaImageFile = JavaClasses.java_io.File.newInstance(imageFilePath);
        JavaClasses.javax_imageio.ImageIO.write(arrayOfPdfImageXObjects[j], "png", javaImageFile);
        arrayOfPdfImages.push(LoadImageFromFile(imageFilePath));
    }
    
	FlushPdfImageXObjects();
    return arrayOfPdfImages;
}



function GetPdfImages(PDFFilePath)
{
    return GetPdfPagesImages(PDFFilePath);
}



function GetPdfPagesImages(PDFFilePath, startPageNumber, endPageNumber)
{
    var arrayOfAllPdfPages = GetPDFDocumentAllPages(PDFFilePath);
    
    if (startPageNumber == undefined && endPageNumber == undefined){
        startPageNumber = 1;
        endPageNumber = arrayOfAllPdfPages.length
    }
    else if (endPageNumber == undefined)
        endPageNumber = startPageNumber;
    
    var arrayOfPdfImages = new Array();
    for (var i = startPageNumber - 1; i < endPageNumber; i++){
        var arrayOfCurrentPdfPageImages = GetPdfImagesFromObject(arrayOfAllPdfPages[i]);
        for (var j in arrayOfCurrentPdfPageImages) arrayOfPdfImages.push(arrayOfCurrentPdfPageImages[j]);
    }
    ClosePdfDoc();
    
    return arrayOfPdfImages;
}



//************************ FONCTIONS UTILISANT LA LIGNE DE COMMANDE ******************************

function GetPdfTextThroughCommandLine(PDFFilePath, startPageNumber, endPageNumber)
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
            var outputTextFileContent = aqFile.ReadWholeTextFile(outputTextFilePath, aqFile.ctUTF8);
            Log.Message("The PDF text extracted file is: " + outputTextFilePath, outputTextFileContent);
            return outputTextFileContent;
        }
    }
    
    Log.Error("The PDF text extraction was not successful.");
    return null;
}



function GetPdfWholePagesImagesThroughCommandLine(PDFFilePath, startPageNumber, endPageNumber)
{
    if (startPageNumber != undefined && endPageNumber == undefined)
        endPageNumber = startPageNumber;
    
    var arrayOfPdfImages = new Array();
    Log.Message("Get whole pages images from PDF file : " + PDFFilePath);
    
    //Copier le fichier PDF dans le dossier temporaire
    var currentDateTime = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
    var tempPDFFilePath = Sys.OSInfo.TempDirectory + aqFileSystem.GetFileNameWithoutExtension(PDFFilePath) + "_" + currentDateTime + ".pdf";
    aqFileSystem.CopyFile(PDFFilePath, tempPDFFilePath);
    
    //Exécuter la ligne de commande
    var imageFilesPrefix = aqFileSystem.GetFileNameWithoutExtension(PDFFilePath) + "_" + currentDateTime + "_ImageOfPage_";
    var commandLineParameters = "PDFToImage -prefix " + imageFilesPrefix;
    if (startPageNumber != undefined) commandLineParameters += " -startPage " + startPageNumber;
    if (endPageNumber != undefined) commandLineParameters += " -endPage " + endPageNumber;
    
    if (ExecuteJARAppCommandLine(commandLineParameters, tempPDFFilePath)){
        //Récupérer les images des fichiers extraits
        var foundExtractedImageFiles = null;
        var nbOfChecks = 0
        do {
            Delay(1000);
            foundExtractedImageFiles = aqFileSystem.FindFiles(aqFileSystem.GetFileFolder(tempPDFFilePath), imageFilesPrefix + "*.*");
        } while ((foundExtractedImageFiles === null || foundExtractedImageFiles.Count <= (endPageNumber - startPageNumber)) && ++nbOfChecks < 60)
        
        //Charger les images des fichiers extraits
        if (foundExtractedImageFiles !== null)
            for (var i = 0; i < foundExtractedImageFiles.Count; i++)
                arrayOfPdfImages.push(LoadImageFromFile(foundExtractedImageFiles.Item(i).Path));
    }
    
    return arrayOfPdfImages;
}



function GetPdfPagesImagesThroughCommandLine(PDFFilePath, startPageNumber, endPageNumber)
{
    if (endPageNumber == undefined) endPageNumber = startPageNumber;
    
    //Créer un fichier contenant seulement les pages d'intérêt et récupérer les images de ce fichier
    var outputFilePrefix = aqFileSystem.GetFileNameWithoutExtension(PDFFilePath) + "_Page_" + startPageNumber + "_to_" + endPageNumber + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
    var outputFilePath = aqFileSystem.GetFileFolder(PDFFilePath) + outputFilePrefix + "-1.pdf";
    var commandLineParameters = "PDFSplit -startPage " + startPageNumber + " -endPage " + endPageNumber + " -outputPrefix " + outputFilePrefix;
    if (ExecuteJARAppCommandLine(commandLineParameters, PDFFilePath)){
        if (!aqFileSystem.Exists(outputFilePath))
            Log.Error("The expected output file was not found : " + outputFilePath);
        else
            return GetPdfImagesThroughCommandLine(outputFilePath);
    }
    
    return [];
}



function GetPdfImagesThroughCommandLine(PDFFilePath)
{
    var arrayOfPdfImages = new Array();
    
    //Exécuter la ligne de commande
    var imageFilesPrefix = aqFileSystem.GetFileNameWithoutExtension(PDFFilePath) + "_Image_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
    var commandLineParameters = "ExtractImages -prefix " + imageFilesPrefix;

    if (ExecuteJARAppCommandLine(commandLineParameters, PDFFilePath)){
        //Récupérer les images des fichiers extraits
        var nbOfChecks = 0
        do {
            Delay(1000);
            var foundExtractedImageFiles = aqFileSystem.FindFiles(aqFileSystem.GetFileFolder(PDFFilePath), imageFilesPrefix + "*.*");
        } while (foundExtractedImageFiles == null && ++nbOfChecks < 10)
        
        //Charger les images des fichiers extraits
        if (foundExtractedImageFiles != null)
            for (var i = 1; i <= foundExtractedImageFiles.Count; i++){
                var foundImageFile = aqFileSystem.FindFiles(aqFileSystem.GetFileFolder(PDFFilePath), imageFilesPrefix + "-" + IntToStr(i) + ".*");
                arrayOfPdfImages.push(LoadImageFromFile(foundImageFile.Item(0).Path));
            }
    }
    
    return arrayOfPdfImages;
}



function ExecuteJARAppCommandLine(commandLineParameters, PDFFilePath)
{
    var isCommandSuccessfull = false;

    //Trouver un fichier 'pdfbox-app*.jar'
    var foundJarFiles = aqFileSystem.FindFiles(folderPath_ProjectSuiteCommonScripts, "pdfbox-app*.jar");
    if (foundJarFiles == null)
        Log.Error("No 'pdfbox-app*.jar' file was found in the folder : " + folderPath_ProjectSuiteCommonScripts);
    else {
        var pdfBoxAppJarFilePath = foundJarFiles.Next().Path;
        var previousCurrentFolder = aqFileSystem.GetCurrentFolder();
        aqFileSystem.SetCurrentFolder(aqFileSystem.GetFileFolder(PDFFilePath));
        
        var commandLine = "java -jar \"" + pdfBoxAppJarFilePath + "\" " + commandLineParameters + " \"" + PDFFilePath + "\"";
        Log.Message(commandLine, "Related to file : " + PDFFilePath);
        isCommandSuccessfull = (0 == WshShell.Run(commandLine, 1, true));
        if (!isCommandSuccessfull)
            Log.Error("The following command line execution was not successful : " + commandLine, commandLine);
    
        aqFileSystem.SetCurrentFolder(previousCurrentFolder);
    }
    
    return isCommandSuccessfull;
}



/**
    Description : Vérifier si par reconnaissance optique de caractères (OCR), un texte est présent dans une image présente sur une page PDF, en procédant comme suit :
    1- Recherche le texte dans l'image dont l'index est spécifié (la première image a pour index 1)
    2- Si la recherche 1 est infructeuse, Recherche dans toutes les images qui ont pu être récupérées
    3- Si la recherche 2 est infructeuse, Recherche dans l'image d'arrière-plan (probable) de la page en :
       3.1- vérifiant que l'image de toute la page contient le texte attendu dans l'image ;
       3.2- et en vérifiant que le texte du fichier PDF (reconnu comme texte) ne contient pas le texte recherché.
    
    Paramètres :
    - expectedString : le texte recherché (chaîne de caractères)
    - PDFFilePath : Le chemin d'accès du fichier PDF
    - PDFPageNumber : La page cible du fichier PDF (la première page a pour numéro 1)
    - pictureIndex : L'image cible sur la page (la première image a pour index 1)
    - resizeFactor : Facteur de redimensionnement (nombre décimal strictement positif) à utiliser suite aux éventuels échecs initiaux (valeur par défaut = 1.3)
    - interDelay : Temps de pause (en millisecondes) entre les différentes opérations de reconnaissance optique de caractères (valeur par défaut = 0)
    - logErrorEvenIfTextIsFoundInAnotherPicture : mettre à true si en plus du comportement décrit dans la description ci-dessus, on veut qu'un message d'erreur soit loguée advenant que la première tentative de recherche a échoué ; sinon, mettre à false ou ne pas renseigner
    
    Résultat :
    À chaque message-résultat (succès, échec ou avertissement), l'image traitée est postée dans le journal de même que le texte obtenu de sa conversion de reconnaissance optique (OCR)
    
    Auteur : Christophe Paring    
*/

function CheckIfExpectedStringIsDisplayedInPDFPagePicture(expectedString, PDFFilePath, PDFPageNumber, pictureIndex, resizeFactor, interDelay, logErrorEvenIfTextIsFoundInAnotherPicture)
{
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        if (interDelay == undefined)
            interDelay = 3000;
        
        if (resizeFactor == undefined)
            resizeFactor = 1.3;
        
        var resizeFactorArray = [null];
        if (resizeFactor != 1)
            resizeFactorArray.push(resizeFactor);
        
        if (pictureIndex != undefined && pictureIndex > 0)
            Log.Message("Vérifier si par reconnaissance optique de caractères (OCR), le texte '" + expectedString + "' apparaît dans l'image N°" + pictureIndex + " de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
        else
            Log.Message("Vérifier si par reconnaissance optique de caractères (OCR), le texte '" + expectedString + "' apparaît dans une image quelconque de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
        
        var isNbOfRetrievedPicturesOK = null;
        var isExpectedStringFoundInTargetPicture = null;
        var isExpectedStringFoundInAnyPicture = null;
        var isExpectedStringFoundInPDFPageWholePicture = null;
        var isExpectedStringFoundInPDFPageExtractedText = null;
        var PDFPageWholePicture = null;
        
        //Vérifier si le fichier PDF existe
        if (!aqFileSystem.Exists(PDFFilePath)){
            Log.Error("Le fichier PDF n'a pas été trouvé: " + PDFFilePath);
            return false;
        }
        
        //Récupérer toutes les images de la page cible du fichier PDF
        var arrayOfPDFPagePictures = GetPdfPagesImagesThroughCommandLine(PDFFilePath, PDFPageNumber);
        
        if (pictureIndex != undefined && pictureIndex > 0){
            //1- Recherche le texte dans l'image dont l'index est spécifié (la première image a pour index 1)
            isExpectedStringFoundInTargetPicture = false;
            isNbOfRetrievedPicturesOK = (pictureIndex <= arrayOfPDFPagePictures.length);
            if (isNbOfRetrievedPicturesOK){
                for (var j = 0; j < resizeFactorArray.length; j++){
                    var targetPicture = arrayOfPDFPagePictures[pictureIndex - 1];
                    var targetPictureOCRText = GetOcrTextFromPicture(targetPicture, resizeFactorArray[j]);
                    var isExpectedStringFoundInTargetPicture = (aqString.Find(targetPictureOCRText, expectedString) != -1);
                    if (isExpectedStringFoundInTargetPicture)
                        break;
                }                
            }
        }
        
        //2- Si la recherche 1 est infructeuse, Recherche dans toutes les images qui ont pu être récupérées
        if (isExpectedStringFoundInTargetPicture === null || !isExpectedStringFoundInTargetPicture){
            var arrayOfPicturesOCRText = new Array();
            var arrayOfIndexesPicturesContainingExpectedString = new Array();
            for (var i in arrayOfPDFPagePictures){
                for (var j = 0; j < resizeFactorArray.length; j++){
                    var pictureOCRText = GetOcrTextFromPicture(arrayOfPDFPagePictures[i], resizeFactorArray[j]);
                    Delay(interDelay);
                    var resizeFactorHeaderText = "Retrieved text with resizeFactor = " + resizeFactorArray[j] + "\r\n------------------------------------------------\r\n";
                    arrayOfPicturesOCRText[i] = (j == 0)? resizeFactorHeaderText + pictureOCRText: arrayOfPicturesOCRText[i] + "\r\n\r\n" + resizeFactorHeaderText + pictureOCRText;
                    var isExpectedStringFoundInPicture = (aqString.Find(pictureOCRText, expectedString) != -1);
                    if (isExpectedStringFoundInPicture){
                        arrayOfIndexesPicturesContainingExpectedString.push(i);
                        break;
                    }
                }
            }
            var isExpectedStringFoundInAnyPicture = (arrayOfIndexesPicturesContainingExpectedString.length > 0);
        }
        
        //3- Si la recherche 2 est infructeuse, Recherche dans l'image d'arrière-plan (probable) de la page
        if (isExpectedStringFoundInAnyPicture !== null && !isExpectedStringFoundInAnyPicture){
            for (var j = 0; j < resizeFactorArray.length; j++){
                //3.1- Vérifier si l'image de toute la page contient le texte attendu dans le graphique
                Delay(interDelay);
                var PDFPageWholePicture = GetPdfWholePagesImagesThroughCommandLine(PDFFilePath, PDFPageNumber)[0];
                var PDFPageWholePictureOCRText = GetOcrTextFromPicture(PDFPageWholePicture, resizeFactorArray[j]);
                var isExpectedStringFoundInPDFPageWholePicture = (aqString.Find(PDFPageWholePictureOCRText, expectedString) != -1);
                
                //3.2- Vérifier si le texte du fichier PDF (reconnu comme texte) contient le texte recherché
                var PDFPageExtractedText = GetPdfTextThroughCommandLine(PDFFilePath, PDFPageNumber);
                var isExpectedStringFoundInPDFPageExtractedText = (aqString.Find(PDFPageExtractedText, expectedString) != -1);
                
                if (isExpectedStringFoundInPDFPageWholePicture && !isExpectedStringFoundInPDFPageExtractedText)
                    break;
            }
        }
        
    }
    catch (exceptionCheckIfExpectedStringIsDisplayedInPDFPagePicture){
        Log.Error("CheckIfExpectedStringIsDisplayedInPDFPagePicture() Exception: " + exceptionCheckIfExpectedStringIsDisplayedInPDFPagePicture.message, VarToStr(exceptionCheckIfExpectedStringIsDisplayedInPDFPagePicture.stack));
        exceptionCheckIfExpectedStringIsDisplayedInPDFPagePicture = null;
    }
    finally {
        //AFFICHAGE DES RÉSULTATS
        if (pictureIndex != undefined && pictureIndex > 0){
            Log.Message("Résultat de: Vérifier si par reconnaissance optique de caractères (OCR), le texte '" + expectedString + "' apparaît dans l'image N°" + pictureIndex + " de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
            if (logErrorEvenIfTextIsFoundInAnotherPicture){
                if (!isNbOfRetrievedPicturesOK)
                    Log.Error("Seulement " + arrayOfPDFPagePictures.length + " image(s) récupérée(s) avec succès du fichier PDF ; on s'attendait à au moins " + pictureIndex + " image(s) puisque l'image cible est celle N°" + pictureIndex, PDFFilePath);
                else if (!isExpectedStringFoundInTargetPicture)
                    Log.Error("Le texte '" + expectedString + "' n'a pas été trouvé dans l'image N°" + pictureIndex + " récupérée de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
            }
            else {
                if (!isNbOfRetrievedPicturesOK)
                    Log.Message("Seulement " + arrayOfPDFPagePictures.length + " image(s) récupérée(s) avec succès du fichier PDF ; on s'attendait à au moins " + pictureIndex + " image(s) puisque l'image cible est celle N°" + pictureIndex, PDFFilePath);
                else if (!isExpectedStringFoundInTargetPicture)
                    Log.Message("Le texte '" + expectedString + "' n'a pas été trouvé dans l'image N°" + pictureIndex + " récupérée de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
            }
        }
        else {
            Log.Message("Résultat de: Vérifier si par reconnaissance optique de caractères (OCR), le texte '" + expectedString + "' apparaît dans une image quelconque de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
            if (logErrorEvenIfTextIsFoundInAnotherPicture){
                if (!isExpectedStringFoundInAnyPicture)
                    Log.Error("Le texte '" + expectedString + "' n'a été trouvé dans aucune image récupérée de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
            }
            else {
                if (!isExpectedStringFoundInAnyPicture)
                    Log.Message("Le texte '" + expectedString + "' n'a été trouvé dans aucune image récupérée de la page N°" + PDFPageNumber + " du fichier " + PDFFilePath);
            }
        }
        
        //1- Recherche le texte dans l'image dont l'index est spécifié (la première image a pour index 1)
        if (isExpectedStringFoundInTargetPicture !== null && isNbOfRetrievedPicturesOK !== null && isNbOfRetrievedPicturesOK){
            if (isExpectedStringFoundInTargetPicture)
                Log.Checkpoint("Le texte '" + expectedString + "' apparaît dans l'image cible N°" + pictureIndex + " récupérée de la page " + PDFPageNumber, "TEXTE OCR RÉCUPÉRÉ:\n\n" + targetPictureOCRText, pmNormal, null, targetPicture);
            else
                Log.Error("Le texte '" + expectedString + "' n'a pas été trouvé pas dans l'image cible N°" + pictureIndex + " récupérée de la page " + PDFPageNumber, "TEXTE OCR RÉCUPÉRÉ:\n\n" + targetPictureOCRText, pmNormal, null, targetPicture);
        }
        
        //2- Si la recherche 1 est infructeuse, Recherche dans toutes les images qui ont pu être récupérées
        if (isExpectedStringFoundInAnyPicture !== null && isExpectedStringFoundInAnyPicture){
            for (var j in arrayOfIndexesPicturesContainingExpectedString){
                var pictureIndex = VarToInt(arrayOfIndexesPicturesContainingExpectedString[j]) + 1;
                Log.Warning("Le texte '" + expectedString + "' apparaît plutôt dans l'image N°" + pictureIndex + " récupérée de la page " + PDFPageNumber, "TEXTE OCR RÉCUPÉRÉ:\n\n" + arrayOfPicturesOCRText[pictureIndex - 1], pmNormal, null, arrayOfPDFPagePictures[pictureIndex - 1]);
            }
        }
        else if (isExpectedStringFoundInAnyPicture !== null && !isExpectedStringFoundInAnyPicture){
            for (var j in arrayOfPicturesOCRText)
                Log.Message("Texte reconnu dans l'image N°" + (VarToInt(j) + 1) + " récupérée de la page: " + PDFFilePath, arrayOfPicturesOCRText[j], pmNormal, logAttributes);
        }
        
        //3- Si la recherche 2 est infructeuse, Recherche dans l'image d'arrière-plan (probable) de la page
        if (isExpectedStringFoundInPDFPageWholePicture !== null && isExpectedStringFoundInPDFPageExtractedText !== null){
            if (isExpectedStringFoundInPDFPageWholePicture && !isExpectedStringFoundInPDFPageExtractedText)
                Log.Warning("Le texte '" + expectedString + "' apparaît quand même dans l'image d'arrière-plan (probable) de la page " + PDFPageNumber, "TEXTE OCR RÉCUPÉRÉ :\n\n" + PDFPageWholePictureOCRText, pmNormal, null, PDFPageWholePicture);
            else if (!isExpectedStringFoundInPDFPageWholePicture){
                Log.Message("Texte reconnu dans l'image entière de la page avec un resizeFactor de '" + resizeFactor + "': " + PDFFilePath, PDFPageWholePictureOCRText, pmNormal, logAttributes);
                Log.Message("Le paramètre resizeFactor de la fonction GetOcrTextFromPicture() pourrait avoir un impact sur la reconnaissance optique de texte dans l'image", "", pmNormal, logAttributes);
            }
        }
        
        //Situation innatendue où aucun résultat n'a pu être obtenu
        if (isExpectedStringFoundInTargetPicture == null && isExpectedStringFoundInAnyPicture == null && isExpectedStringFoundInPDFPageWholePicture == null && isExpectedStringFoundInPDFPageExtractedText == null){
            if (PDFPageWholePicture != undefined)
                Log.Error("CheckIfExpectedStringIsDisplayedInPDFPagePicture(): Aucun résultat n'a pu être obtenu!", PDFFilePath, pmNormal, null, PDFPageWholePicture);
            else
                Log.Error("CheckIfExpectedStringIsDisplayedInPDFPagePicture(): Aucun résultat n'a pu être obtenu!");
        }
        else if (!isExpectedStringFoundInTargetPicture && !isExpectedStringFoundInAnyPicture && !(isExpectedStringFoundInPDFPageWholePicture && !isExpectedStringFoundInPDFPageExtractedText)){
            if (pictureIndex != undefined && pictureIndex > 0){
                if (PDFPageWholePicture != undefined)
                    Log.Error("Le texte '" + expectedString + "' n'a été trouvé ni dans l'image cible N°" + pictureIndex + " récupérée de la page " + PDFPageNumber + ", ni dans aucune autre image de la même page du fichier " + PDFFilePath, PDFFilePath, pmNormal, null, PDFPageWholePicture);
                else
                    Log.Error("Le texte '" + expectedString + "' n'a été trouvé ni dans l'image cible N°" + pictureIndex + " récupérée de la page " + PDFPageNumber + ", ni dans aucune autre image de la même page du fichier " + PDFFilePath);
            }
            else {
                if (PDFPageWholePicture != undefined)
                    Log.Error("Le texte '" + expectedString + "' n'a été trouvé dans aucune image récupérée de la page " + PDFPageNumber + " du fichier " + PDFFilePath, PDFFilePath, pmNormal, null, PDFPageWholePicture);
                else
                    Log.Error("Le texte '" + expectedString + "' n'a été trouvé dans aucune image récupérée de la page " + PDFPageNumber + " du fichier " + PDFFilePath);
            }
        }
        
        
    }
}



/**
    Description : Compare les textes (reconnus comme textes) de deux fichiers PDF

    Paramètres :
    - referencePDFFilePath, resultPDFFilePath : Chemins d'accès des deux fichiers PDF
    - ignorePatternRegEx : Expression régulière permettant de déterminer les parties à ignorer lors de la la comparaison
                           Valeur par défaut : /\d{4}\/\d{2}\/\d{2}\r\n(Croesus Finansoft Inc\.\r\n)\d{2}:\d{2}\r\n/g
    - ignoreReplaceString : Chaîne de caractères de remplacement des parties à ignorer
                           Valeur par défaut : "<IGNORER DATE - TESTS AUTO>\r\nCroesus Finansoft Inc\.\r\n<IGNORER HEURE - TESTS AUTO>\r\n"
    
    Résultat :
    - true : les textes des deux fichiers PDF sont équivalents
    - false : les textes des deux fichiers PDF ne sont pas équivalents
    
    Auteur : Christophe Paring    
*/
function ComparePdfText(referencePDFFilePath, resultPDFFilePath, ignorePatternRegEx, ignoreReplaceString)
{    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    Log.Message("ComparePdfText : " + resultPDFFilePath + " versus " + referencePDFFilePath, "", pmNormal, logAttributes);
    
    if (ignorePatternRegEx != undefined && ignoreReplaceString == undefined){
        Log.Error("Si vous avez fourni le paramètre 'ignorePatternRegEx', SVP fournir aussi le paramètre 'ignoreReplaceString'.");
        return null;
    }
    
    var referencePDFFileText = GetPdfTextThroughCommandLine(referencePDFFilePath);
    var resultPDFFileText = GetPdfTextThroughCommandLine(resultPDFFilePath);
    
    if (referencePDFFileText === null || resultPDFFileText === null){
        if (referencePDFFileText === null)
            Log.Error("L'extraction de texte n'a pas réussi pour le fichier : " + referencePDFFilePath);
            
        if (resultPDFFileText === null)
            Log.Error("L'extraction de texte n'a pas réussi pour le fichier : " + resultPDFFilePath);
        
        return null;
    }
    
    if (ignoreReplaceString == undefined){
        var ignoreFrenchPatternRegEx = /\d{4}\/\d{2}\/\d{2}\r\n(Croesus Finansoft Inc\.\r\n)\d{2}:\d{2}\r\n/g;
        var ignoreEnglishPatternRegEx = /\d{2}\/\d{2}\/\d{4}\r\n(Croesus Finansoft Inc\.\r\n)\d{2}:\d{2}\s\w{2}\r\n/g;
        var ignoreFrenchReplaceString = "<IGNORER DATE - TESTS AUTO>\r\nCroesus Finansoft Inc\.\r\n<IGNORER HEURE - TESTS AUTO>\r\n";
        var ignoreEnglishReplaceString = "<DATE IGNORED - TESTS AUTO>\r\nCroesus Finansoft Inc\.\r\n<TIME IGNORED - TESTS AUTO>\r\n";
        
        if (referencePDFFileText.search(ignoreFrenchPatternRegEx) != -1){
            ignorePatternRegEx = ignoreFrenchPatternRegEx;
            ignoreReplaceString = ignoreFrenchReplaceString
        }
        else {
            ignorePatternRegEx = ignoreEnglishPatternRegEx;
            ignoreReplaceString = ignoreEnglishReplaceString;
        }
    }
    
    var referenceFileTextWithIgnoredPartsReplaced = referencePDFFileText.replace(ignorePatternRegEx, ignoreReplaceString);
    var resultFileTextWithIgnoredPartsReplaced = resultPDFFileText.replace(ignorePatternRegEx, ignoreReplaceString);
    var resultComparePdfText = (referenceFileTextWithIgnoredPartsReplaced == resultFileTextWithIgnoredPartsReplaced);
    
    Log.Message("Résultat de ComparePdfText = " + resultComparePdfText + ". Ci-dessous les textes comparés. Voir plus haut dans le Log le chemin d'accès des fichiers texte générés à partir des fichiers PDF");
    Log.Message("Voir dans la partie Details le texte comparé du fichier de référence : " + referencePDFFilePath, referenceFileTextWithIgnoredPartsReplaced, pmNormal, logAttributes);
    Log.Message("Voir dans la partie Details le texte comparé du fichier de résultat : " + resultPDFFilePath, resultFileTextWithIgnoredPartsReplaced, pmNormal, logAttributes);
    
    return resultComparePdfText;
}
