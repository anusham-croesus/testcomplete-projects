//USEUNIT Common_functions
//USEUNIT Global_variables

/**
    Lien : https://jira.croesus.com/browse/QAS-866
    
    Description : Comparaison du résultat des logs d'exécution au baseline.
    
    Auteur : Frédéric Thériault
    
    Version de scriptage :	La version du baseline et des fichiers à comparer est en fonction des paramètres du fichier Excel.
**/

// Déclaration d'objets personnalisés.

function InfoResultat() {
  var projectName = "";
  var suiteName = "";
  var timestamp = "";
  var hostName = "";
  var nbNodes = 0;
  var nbPassedTests = 0;
  var nbFailedTests = 0;
  var nbFailMsg = 0;
}

function LigneResultatExcel() {
  var nomFichierExcel = "";
  var nomDuTest = "";
  var testSuite = "";
  var version = undefined;
  var nombreDifferences = 0;
  var noColonne = 0;
}

// Les cas de test

/**
    Description : Ce test permet de comparer un Log XML des résultat de tests automatisé à un baseline du Log.
    Note :
          - Utilise à la fois le DTD driver Excel pour la lecture des paramètres du test de comparaison et un OLE
          object d'application de Microsoft, pour générer un fichier Excel de résultat de comparaison d'après un
          fichier modèle dans le dossier Data des projets TestComplete.
          - Pour la lecture et la manipulation des XML, le MSXML DOM est utilisé.
    Auteur : Frédéric Thériault
**/
function RoulerTestComparaison()
{
  try {
      Log.Link("https://jira.croesus.com/browse/QAS-866", "Lien vers Jira");
        
      // Les variables
      projectName = "";
      var modelResultatExcel = folderPath_Data + "model_ComparedXMLtestsResults.xltx";
      var excelOLEapp = undefined;
      var sheetName = "Comparaison des resultats";
      var keySet;
      var ligneDeResultat;
      ligneDeResultat = new LigneResultatExcel();
      ligneDeResultat.version = new Array();
      ligneDeResultat.noColonne = 0;
      var resultatTestCase;
      resultatTestCase = new LigneResultatExcel();
      resultatTestCase.version = new Array();
      resultatTestCase.noColonne = 0;
      var match = false;
      var regExpr = "(fichierXML)[0-9]+";
        
      // Lire fichier parametres Excel
      projectName = ProjectSuite.FileName;
      projectName = FindName(projectName);
      if (projectName != undefined) {
          listeParamDict = ReadProjectDataRowFromExcel(folderPath_Data +"data_CompareXMLtestsResults.xlsx", "CompareXMLtestsResults", projectName);
          
          if (listeParamDict.length > 0) {
              dictData = listeParamDict[0];
              keySet = (new VBArray(dictData.Keys())).toArray();
              pathSaveDir = dictData.Item("pathResultat");
            
              // Charger le fichier XML baseline.
              pathXMLbaseline = dictData.Item("fichierXMLbaseline");
              xmlDOMbaseline = LoadXMLfile(pathXMLbaseline);
            
              // Load le fichier modèle de résultats Excel.
              CloseExcelProcess();
              excelOLEapp = Sys.OleObject("Excel.Application");
              Sys.WaitProcess("excel", 10000);
              modeleBook = OuvrirModeleResultatDeComparaison(excelOLEapp, modelResultatExcel, sheetName);
          
              if (modeleBook != undefined) {
                  // Boucle FOR itérative pour les fichiers à comparer.
                  // Trouver un fichiers XML à comparer
                  for (iCol = 0; iCol < keySet.length; iCol++) {
                    match = aqString.StrMatches(regExpr, keySet[iCol]);
                    if (match == true) {
                        if (dictData.Item(keySet[iCol]) != "") {
                            // Charger le fichier XML à comparer et faire la comparaison.
                            pathXMLaComparer = dictData.Item(keySet[iCol]);
                            nomFichierAComparer = FindName(pathXMLaComparer);
                            xmlDOMaComparer = LoadXMLfile(pathXMLaComparer);
                      
                            // Comparer les informations de bases et écrire le résultat dans Excel.
                            ligneDeResultat.nomFichierExcel = nomFichierAComparer;
                            ligneDeResultat.noColonne = ligneDeResultat.noColonne + 1;
                            ligneDeResultat = EcrireComparaisonDeBaseXML(xmlDOMbaseline, xmlDOMaComparer, ligneDeResultat, modeleBook, sheetName);
                            
                            /**
                            En gros, voici la stratégie dans le cas ou le fichier comparé ne serait pas égal au baseline, pour les noeuds testcase :
                              - On épure les XML DOM pour n'avoir que les noeuds identiques (métodes Document.adoptNode(), Node.appendChild() et Node.removeChild()).
                              - Pour les deltas sur les noeuds non retrouvés BL et celui sur les nouveaux noeuds CF, on transfère ces noeuds dans des XML DOM séparés.
                              - On utilisera les XML DOM épurés (seulement les noeuds identiques) pour faire la comparaison.
                              - On ajoute à la fin du Excel les noeuds manquants (dans les XML DOM séparés) et les noeuds des nouveaux tests avec le statut "NotFound" ou "New".
                            **/
                            // Faire le Delta entre les 2 XML pour retirer les Nodes testcase qui ne sont pas identiques (BL NotFound, CF NewTests).
                            xmlDOMdelta = DeltaDesNodesXML(xmlDOMbaseline, xmlDOMaComparer);
                            
                            // Comparer les Nodes des fichiers XML de résultat de tests TC.
                            resultatTestCase.noColonne = (resultatTestCase.noColonne) + 1;
                            resultatTestCase = ParcourirEtComparerResultats(xmlDOMbaseline, xmlDOMaComparer, resultatTestCase, modeleBook, sheetName, keySet[i]); // Circuler a travers les Nodes et Children nodes pour comparer.
                            if (resultatTestCase.nombreDifferences  > 0) {
                                Log.Warning("=== Des différences (" +nombreDifferences +") ont été trouvées entre les nodes XML du baseline vs fichier résultats de test comparé ===");
                                resultatTestCase.nombreDifferences = 0; // Remise à zéro pour la prochaine validation.
                            }
                            
                            xmlDOMbaseline = xmlDOMaComparer; // Le fichier qui vient d'être comparé devient le nouveau baseline.
                        }
                        //else // Notifier quand une cellule donnée est vide pour une colonne existante du fichier paramètre. // vérif. trop envahissante.
                            //Log.Error("Erreur: Il n'y a pas de donnée dans la cellule du fichier paramètre, sur la ligne " +projectName +" pour la colonne " +keySet[iCol] +".");
                    }
                  } // Fin boucle FOR
              }
              else
                  Log.Error("Erreur: Le chargement du fichier modèle a échoué.");
              
              // Prêt a enregistrer le fichier Excel.
              if ((ligneDeResultat != undefined)/* && (nombreErreurs != undefined)*/){
                  // Enregistrer le fichier Excel de comparaison sous un path et nom différents du modèle.
                  EnregistrerExcelResultat(modeleBook, pathSaveDir, "ComparedXMLtestsResults_" +aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M"));
                  excelOLEapp.Quit(); //pour OLE
              }
              else
                  Log.Error("Erreur: L'enregistrement du fichier Excel ne peut être effectué car aucune comparasion n'a eu lieu.");
          }
          else
              Log.Error("Erreur: Le chargement du fichier paramètres a échoué.");
      }
      else
          Log.Error("Erreur: Nom du projet TC non trouvé.");
  }
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      CloseExcelProcess(); //pour OLE
      TerminateExcelProcess(); //pour DDT
  }
}


// Les fonctions

/**
    Description : Effectue une comparaison sommaire avec les informations générales du
                  fichier XML et du baseline.
    Paramètres :
        - xmlDOMbaseline : un objet XML DOM document qui servira de baseline.
        - xmlDOMaComparer : un objet XML DOM document à comparer.
        - ligneDeResultat : Un objet custom LigneResultatExcel contenant les informations à inscrire dans le fichier Excel
        - modeleBook : Un objet Book correspondant au Workbook du fichier Excel ouvert.
        - sheetName : Le nom de la feuille Excel.
    Résultat : Retourne L'objet LigneResultatExcel contenant les information m-a-j.
    Note :
          - L'objet retourné contient des valeurs (true, false) selon la correspondance avec le baseline.
    Auteur : Frédéric Thériault
**/
function EcrireComparaisonDeBaseXML(xmlDOMbaseline, xmlDOMaComparer, ligneDeResultat, modeleBook, sheetName)
{
  try {
      var infoXMLBaseline;
      var infoXMLCompare;
      
      // Écrire les informations de base des fichiers à comparer dans le log.
      infoXMLBaseline = GetInfoXMLresultat(xmlDOMbaseline); // Log les informations du BaseLine.
      infoXMLCompare = GetInfoXMLresultat(xmlDOMaComparer); // Log les informations du fichier à comparer.
      
      // Comparer les informations de bases
      comparaison = ComparerInfoXMLResultats(infoXMLBaseline, infoXMLCompare);
      if (comparaison != undefined) {
          Log.Message("=== Comparaison de base des fichiers XML terminée ===");
          
          // Préparer la ligne des informations de base a enregistrer.
          if (ligneDeResultat.version.length == 0) { // Écriture des entêtes pour la 1re analyse.
              ligneDeResultat.nomDuTest = comparaison.projectName;
              ligneDeResultat.testSuite = "Comparaison de base des XML";
          }
          if (ligneDeResultat.version.length >= 0) { // Pour l'écriture des résultats de chaque analyses XML.
              if (comparaison.suiteName && comparaison.nbNodes && comparaison.nbPassedTests && comparaison.nbFailedTests && comparaison.nbFailMsg)
                  ligneDeResultat.version.push("Passed");
              else
                  ligneDeResultat.version.push("Failed");
          }
          
          // Entrer les informations de base dans le fichier Excel de comparaison.
          EcrireResutatDansExcel(ligneDeResultat, modeleBook, sheetName, 3);
      }
      else {
          Log.Error("Erreur: La comparaison de base a échoué.");
          ligneDeResultat = undefined;
      }
  }
  catch (e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      ligneDeResultat = undefined;
  }
  finally {
    return ligneDeResultat;
  }
}


/**
    Description : Ouvrir et valider le fichier Excel modèle qui compile des résultats de tests.
    Paramètres :
        - excelOLEapp : L'objet OLE correspondant à l'application Excel.
        - modelFilePath : Le path du fichier modèle Excel.
        - sheetName : Le nom de la feuille Excel.
    Résultat : Retourne un objet Book correspondant au Workbook du fichier Excel ouvert.
    Note :
          - Utilise le OLE object de Microsoft pour permettre le contrôle complet de Excel en lecture/ecriture pour générer un fichier de résultat de comparaison.
    Auteur : Frédéric Thériault
**/
function OuvrirModeleResultatDeComparaison(excelOLEapp, modelFilePath, sheetName)
{
  try {
      // Les variables
      var resultValidation = false;
    
      // Ouvrir et valider le fichier Excel modèle qui compile des résultats de tests.
      book = excelOLEapp.Workbooks.Open(modelFilePath);
    
      if (book != undefined){
        book.Sheets.Item(sheetName).Activate();
        resultValidation = _ValiderExcelModel(excelOLEapp, 1);
        if (resultValidation != true) {
            Log.Error("*** Fermeture du fichier Excel non valide ***");
            book.Close();
            book = undefined;
        }
    }
    else {
        Log.Error("L'ouverture du Workbook du fichier Excel a échoué.");
        book = undefined;
    }
  }
  catch(e) {
    CloseExcelProcess();
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    book = undefined;
  }
  finally {
    return book;
  }
}


/**
    Description : Sous-fonction de validation du fichier modèle Excel.
    Paramètres :
        - excelOLEobject : L'objet OLE correspondant à l'application Excel.
    Résultat : Retourne un objet Book correspondant au Workbook du fichier Excel ouvert.
    Note :
          - Utilise le OLE object de Microsoft pour permettre le contrôle complet de Excel en lecture/ecriture pour générer un fichier de résultat de comparaison.
    Auteur : Frédéric Thériault
**/
function _ValiderExcelModel(excelOLEobject)
{
  var succesValidation = false;
  try {
        // Les variables
        var cellValue = "";
        var titreColonnes = new Array("Nom du test", "Test Suite", "Version");
        var regExpr = aqString.Concat("(", titreColonnes[2]);
        var regExpr = aqString.Concat(titreColonnes[2], ")");
        var regExpr = aqString.Concat(titreColonnes[2], "[0-9]*");
        var erreurPresente = false;
        var statutComparaison = "Fail";
        var rowNum = 0;
        
        // Valider les titres de colonnes du fichier modèle
        for (i = 0; i < 3; i++) {
            cellValue = VarToStr(excelOLEobject.Cells(1,(i+1)).Value);
            if (aqString.Compare(cellValue, titreColonnes[i], false) == 0){
                Log.Message("Validation du fichier modèle de résultats Excel : " +cellValue +" = " +titreColonnes[i]);
            }
            else {
                if ((aqString.Find(cellValue, titreColonnes[i], 0, false) == 0) && aqString.StrMatches(regExpr, cellValue) && (i == 2)) {
                    Log.Message("Validation du modèle de résultats Excel : " +cellValue +" corresponds bien à " +titreColonnes[i] +" suivi d'un chiffre.");
                }
                else {
                   Log.Error("Erreur dans le modèle de résultats Excel fourni : La colonne " +cellValue +", ne corresponds pas à " +titreColonnes[i] +".");
                   erreurPresente = true;
                }
            }
        }
        if (erreurPresente == false) { // Le fichier modèle est valide, la vérification est un succès.
            Log.Checkpoint("=== Validation du fichier modèle des résultats terminée ===");
            succesValidation = true;
        }
        else
            Log.Error("Erreur: Le fichier modèle d'enregistrement des résultats n'est pas valide.");
  }
  catch(e) {
    CloseExcelProcess();
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    succesValidation = false;
  }
  finally {
    return succesValidation;
  }
}


/**
    Description : Ecrire une ligne de données Excel contenant le résultat de comparaison d'un test vs le baseline.
    Paramètres :
        - ligneDeResultat : Un objet custom LigneResultatExcel contenant les informations à inscrire dans
        les colonnes d'une ligne du fichier Excel.
        - excelWorkbook : L'objet OLE correspondant au Workbook du fichier Excel ouvert.
        - sheetName : Le nom de la feuille Excel.
        - rowNum : Le numéro de la ligne où écrire les données.
    Résultat : Retourne un objet Book correspondant au Workbook du fichier Excel ouvert.
    Note :
          - Utilise le OLE object de Microsoft pour permettre le contrôle complet de Excel en lecture/ecriture pour générer un fichier de résultat de comparaison.
    Auteur : Frédéric Thériault
**/
function EcrireResutatDansExcel(ligneResult, excelWorkbook, sheetName, rowNum)
{
  var status = false;
  var nCol;
  
  try {
      if (ligneResult.version.length > 0) {
          nCol = ligneResult.noColonne - 1; // Pour écrire sur la colonne du dernier XML comparé.
          if ((ligneResult.noColonne == 1) && (nCol == 0)) { // Écrire les noms de tests 1 seule fois.
            sheetExcel = excelWorkbook.Sheets.Item(sheetName);
            sheetExcel.Activate();
            sheetExcel.Cells.Item(rowNum, 1).Value2 = ligneResult.nomDuTest;
            sheetExcel.Cells.Item(rowNum, 2).Value2 = ligneResult.testSuite;
          }
          if ((ligneResult.nomFichierExcel != "") && (ligneResult.nomFichierExcel != undefined)) { // Écrire le nom du fichier XML 1 seule fois.
              sheetExcel.Cells.Item(1, (3+nCol)).Value2 = ligneResult.nomFichierExcel;
              ligneResult.nomFichierExcel = "";
          }
          iData = ligneResult.version.length -1;
          sheetExcel.Cells.Item(rowNum, (3+nCol)).Value2 = ligneResult.version[iData];
          status = true;
      }
      else
          status = false;
  }
  catch(e){
      CloseExcelProcess();
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      status = false;
  }
  finally {
    return status;
  }
}


/**
    Description : Enregistrer un Workbook Excel à l'endroit spécifié en paramètre.
    Paramètres :
        - excelBook : L'objet OLE correspondant au Workbook du fichier Excel ouvert.
        - path : Le chemin vers le répertoire choisi pour enregistrer le fichier Excel.
        - nomFichier : Le nom donné au fichier Excel.
    Auteur : Frédéric Thériault
**/
function EnregistrerExcelResultat(excelBook, path, nomFichier)
{
  var status = false;
  try {
    nomFichier = aqString.Concat(path, nomFichier);
    excelBook.SaveAs(nomFichier);
    Log.Message("*** Fichier enregistré " +nomFichier +" ***");
    status = true;
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    status = false;
  }
  finally {
    return status;
  }
}


/**
    Description : Excel datapool pour récupérer une ligne de donnée concernant le Projet en cours.
    Paramètres :
        - filePath : Le chemin d'accès du fichier paramètre Excel.
        - sheetName : Le nom de la feuille Excel.
    Résultat : Array ayant le contenu des cellules de la ligne ayant le nom du projet dans sa première colonne.
    Note :
          - Utilise le DDT driver pour la lecture, donc aucune écriture possible ici.
    Auteur : Frédéric Thériault
**/
function ReadProjectDataRowFromExcel(filePath, sheetName, projectName)
{
  var dataTableExcel;
  dataTableExcel = new Array();
  
  try{
      var Driver = DDT.ExcelDriver(filePath, sheetName, true);
      
      Log.Message("Lecture du fichier paramètres Excel pour " +projectName);
      
      while (! Driver.EOF()) {
        
        for(i = 0; i < Driver.ColumnCount; i++) {
          var ColName = aqConvert.VarToStr(Driver.ColumnName(i));
          var ColValue = aqConvert.VarToStr(Driver.Value(i));
          if (Driver.Value(0) == projectName) {
              if (i == 0)
                  var dict = new ActiveXObject("Scripting.Dictionary");
              if (dict != undefined) {
                  dict.Add(ColName, ColValue);
                  //var nbval = dict.Count;
                  //var keys = dict.Keys();
                  //var valeurs = dict.Items();
                  //var uneValeur = dict.Item(ColName);
              }
            }
          else
              break;
        }
        if (dict != undefined && Driver.Value(0) == projectName){
            if (dict.Count == Driver.ColumnCount) {
                dataTableExcel.push(dict); // Si plusieurs lignes avec le même ProjectName, elles seront toutes dans ce Array.
                isRowFound = true;
            }
        }
        Driver.Next(); // Va à la prochaine ligne
      }
      DDT.CloseDriver(Driver.Name);
      
      if(!isRowFound)
        Log.Error("ReadProjectDataFromExcel : " +projectName +" not found.", "Le projet (" +projectName +") est introuvable dans la feuille : " +sheetName +" du fichier : " +filePath);
  }
  catch (e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    DDT.CloseDriver(Driver.Name);
    dataTableExcel = undefined;
  }
  finally {
    return dataTableExcel;
  }
}


/**
    Description : Fonction qui trouve le nom d'un fichier à partir du file path.
    Résultat : Retourne le nom du fichier.
    Note :
          - Utilise des objets aqString provenant de TestComplete pour récupérer le filepath.
    Auteur : Frédéric Thériault
**/
function FindName(path)
{
  var fileName = "";
  
  try{
      aqString.ListSeparator = "\\";
      path = aqString.GetListItem(path, (aqString.GetListLength(path)-1));
      aqString.ListSeparator = ".";
      fileName = aqString.GetListItem(path, 0);
  }
  catch (e){
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      fileName = undefined;
  }
  finally {
    return fileName;
  }
}


/**
    Description : Récupérer les variables du Projet en cours à partir d'une ligne de donnés du Excel.
    Paramètres :
        - filePath : Le chemin d'accès du fichier Excel.
        - sheetName : Le nom de la feuille Excel.
    Résultat : Un objet Array contenant les valeurs des cellules de la ligne ayant le nom du projet dans sa première colonne.
    Note :
          - Le nom d'une variable corresponds au nom d'une colonne du fichier Excel.
          - Le contenu des cellules, non vides, de la ligne ayant le nom du projet dans sa première colonne est utilisé pour créer les variables.
    Auteur : Frédéric Thériault
**/
function CreateVariablesFromExcelLine(filePath, sheetName)
{
  var dataTableExcel;
  dataTableExcel = new Array();
  
  try{
      dataTableExcel = new Array();
      var Driver = DDT.ExcelDriver(filePath, sheetName, true);
      var projectName = "";
        
      projectName = ProjectSuite.FileName;
      aqString.ListSeparator = "\\";
      projectName = aqString.GetListItem(projectName, (aqString.GetListLength(projectName)-1));
      aqString.ListSeparator = ".";
      projectName = aqString.GetListItem(projectName, 0);
      
      Log.Message("Lecture du fichier Excel pour " +projectName);
      
      while (! Driver.EOF()) {
        var isRowFound = false;
        
        for(i = 0; i < Driver.ColumnCount; i++) {
          if (VarToStr(Driver.Value(0)) == "")
              Driver.Next(); // Ligne vide, aucun ID, on va à la prochaine ligne
          if (Driver.Value(0) == projectName) {
              Project.Variables.AddVariable("TESTVAR_variableNameColumnTitle", "String");
              Project.Variables.VariableByName("TESTVAR_variableNameColumnTitle") = VarToStr(Driver.Value(i));
              isRowFound = true;
              break;
          }
        }
        Driver.Next(); // Va à la prochaine ligne
      }
      
      if(!isRowFound) {
         Log.Error("CreateVariablesFromExcelLine : " +projectName +" not found.", "Le projet (" +projectName +") est introuvable dans la feuille : " +sheetName +" du fichier : " +filePath); 
         dataTableExcel = undefined;
      }
  }
  catch (e){
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    dataTableExcel = undefined;
  }
  finally {
    return dataTableExcel;
  }
}


/**
    Description : Charge un fichier XML en mémoire.
    Paramètres :
        - pathXMLfile : Le chemin d'accès du fichier XML.
    Résultat : Retourne un objet XML DOM document qui contient l'arboressence complète du XML.
    Note :
          - Le fichier peut se trouver sur un HDD ou être accessible via une URL.
    Auteur : Frédéric Thériault
**/
function LoadXMLfile(pathXMLfile)
{
  try{
    // Les variables
    var xmlFile = Sys.OleObject("Msxml2.DOMDocument.6.0");
        
    xmlFile.async = false;
    xmlFile.resolveExternals = false;
    xmlFile.load(pathXMLfile);  // Charger un fichier XML d'une URL source.
        
    if (xmlFile.parseError.errorCode != 0) {
        uneErreur = xmlFile.parseError;
        Log.Error("DOM XML chargement en erreur" +pathXMLfile, uneErreur.reason);
        xmlFile = undefined;
    }
    else {
        Log.Checkpoint("DOM XML load: " +pathXMLfile, xmlFile.xml);
    }
  }
  catch(e){
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    xmlFile = undefined;
  }
  finally {
    return xmlFile;
  }
}


/**
    Description : Récupère les informations de base d'un XML DOM document.
    Paramètres :
        - xmlDOM : Un objet XML DOM document qui contient l'arboressence complète du XML.
    Résultat : Retourne un objet InfoResultat contenant les informations récupérées du XML DOM.
    Auteur : Frédéric Thériault
**/
function GetInfoXMLresultat(xmlDOM)
{
  var resultats;
  resultats = new InfoResultat();
  
  try {
        // Les variables
        var allNodesList;
        var testSuiteElement;
        var unElement;
        
        // Débuter la récupération d'informations du XML DOM document.
        allNodesList = xmlDOM.selectNodes("//*");
        if (allNodesList.length > 0) {
            resultats.nbNodes = allNodesList.length;
            resultats.nbPassedTests = xmlDOM.selectNodes("//testcase[not(failure)]").length;
            resultats.nbFailedTests = xmlDOM.selectNodes("//testcase[failure]").length;
            resultats.nbFailMsg = xmlDOM.selectNodes("//failure").length;
            
            // Récupérer le nom de la testsuite au niveau projet TC.
            testSuiteElement = xmlDOM.getElementsByTagName("testsuites");
            resultats.projectName = testSuiteElement.item(0).getAttribute("name");
                
            testSuiteElement = xmlDOM.getElementsByTagName("testsuite");
            if (testSuiteElement.length > 0) {
              for (i = 0; i < testSuiteElement.length; i++) {
                // Extraitre les attributs name, hostname et timestamp des nodes testsuite.
                unElement = testSuiteElement.item(i);
                resultats.suiteName = unElement.getAttribute("name");
                resultats.hostName = unElement.getAttribute("hostname");
                resultats.timestamp = unElement.getAttribute("timestamp");
                Log.Message("XML log pour " +resultats.projectName +" : Timestamp de la suite " +resultats.suiteName +" exécutée sur " +resultats.hostName, resultats.timestamp);
              }
                  
              Log.Checkpoint("Nombre de nodes dans ce XML", resultats.nbNodes);
              Log.Checkpoint("Nombre de tests Passed dans ce log", resultats.nbPassedTests);
              if (resultats.nbFailedTests > 0 || resultats.nbFailMsg > 0){
                  Log.Warning("Nombre de tests Failed dans ce log", resultats.nbFailedTests);
                  Log.Warning("Nombre de Failure messages dans ce log", resultats.nbFailMsg);
              }
            }
            else
                Log.Error("Aucun élément trouvé portant le nom testsuite.");
        }
        else
            Log.Error("Le nombre de nodes de ce XML est de zéro.");
      }
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      resultats = undefined;
  }
  return resultats;
}


/**
    Description : Effectue une comparaison sommaire avec les informations générales du
                  fichier XML et du baseline.
    Paramètres :
        - XMLbaseline : L'objet custom InfoResultat qui servira de baseline pour la comparaison.
        - XMLaComparer : Un objet custom InfoResultat à comparer.
    Résultat : Retourne un objet InfoResultat contenant les résultats de la comparaison.
    Note :
          - L'objet retourné contient des valeurs (true, false) selon la correspondance avec le baseline.
    Auteur : Frédéric Thériault
**/
function ComparerInfoXMLResultats(XMLbaseline, XMLaComparer)
{ 
  try{
        // Les variables
        compare = new InfoResultat();
        compare.projectName = XMLbaseline.projectName;
        
        if (XMLaComparer.suiteName == XMLbaseline.suiteName)
            compare.suiteName = true;
        else {
            compare.suiteName = false;
            Log.Warning("Nom de la suite de test est différent du baseline.", XMLaComparer.suiteName +" vs. baseline: " +XMLbaseline.suiteName);
        }
        
        if (XMLaComparer.hostName == XMLbaseline.hostName)  // A titre informatif, le hostname ne fait pas partie de la validation.
            compare.hostName = true;
        else
            compare.hostName = false;
        
        if (XMLaComparer.nbNodes == XMLbaseline.nbNodes)
            compare.nbNodes = true;
        else {
            compare.nbNodes = false;
            Log.Warning("Nombre de nodes XML différent du baseline.", XMLaComparer.nbNodes +" vs. baseline: " +XMLbaseline.nbNodes);
        }
        
        if (XMLaComparer.nbPassedTests == XMLbaseline.nbPassedTests)
            compare.nbPassedTests = true;
        else {
            compare.nbPassedTests = false;
            Log.Warning("Nombre de tests Passed de la suite différent du baseline.", XMLaComparer.nbPassedTests +" vs. baseline: " +XMLbaseline.nbPassedTests);
        }
        
        if (XMLaComparer.nbFailedTests == XMLbaseline.nbFailedTests)
            compare.nbFailedTests = true;
        else {
            compare.nbFailedTests = false;
            Log.Error("Nombre de tests Failed de la suite différent du baseline.", XMLaComparer.nbFailedTests +" vs. baseline: " +XMLbaseline.nbFailedTests);
        }
        
        if (XMLaComparer.nbFailMsg == XMLbaseline.nbFailMsg)
            compare.nbFailMsg = true;
        else {
            compare.nbFailMsg = false;
            Log.Error("Nombre de Failure messages de la suite différent du baseline.", XMLaComparer.nbFailMsg +" vs. baseline: " +XMLbaseline.nbFailMsg);
        }
        if (compare.suiteName && compare.nbNodes && compare.nbPassedTests && compare.nbFailedTests && compare.nbFailMsg)
            Log.Checkpoint("==> Informations de base du XML identiques au baseline.");
  }
  catch(e){
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      compare = undefined;
  }
  finally {
    return compare;
  }
}


/**
    Description : Parcours le XML DOM document du baseline et celui à comparer.
                  Ecrit le résultat dans le fichier Excel et retourne le résultat de
                  la comparaison.
    Paramètres :
        - xmlDOMbaseline : un objet XML DOM document qui servira de baseline (BL).
        - xmlDOMaComparer : un objet XML DOM document à comparer (CF).
        - resultatNode : Un objet custom LigneResultatExcel contenant les informations à inscrire dans le fichier Excel
        - modeleBook : L'objet OLE correspondant au Workbook du fichier Excel ouvert.
        - sheetName : Le nom de la feuille Excel.
        - nomColXMLcompare : Nom de la colone pour entrer les informations du fichier XML comparé.
    Résultat : Retourne L'objet LigneResultatExcel contenant les information m-a-j.
    Auteur : Frédéric Thériault
**/
function ParcourirEtComparerResultats(xmlDOMbaseline, xmlDOMaComparer, resultatNode, modeleBook, sheetName, nomColXMLcompare)
{
  var erreurNonPresente = true;
  
  try {
      // Les variables
      var listeNomsNodes = Array("testsuites", "testsuite", "testcase", "failure");
      var listeAttributs = Array();
      listeAttributs = [["name", "tests", "failures", "errors"],["name", "tests", "failures", "errors"],["name", "classname"],["message"]];
      var idNodes = 0; // Pour circuler à travers la listeNomsNodes.
      var attributsIdentiques = Array();
      var nbIdentiques = 0;
      var nbNodes = 0;
      var baselineNbChildren = 0;
      var nbChildren = 0;
      var childVisit = true;
      var upOneNode = false;
      var toNextNode = true;
      var hasNextSibling = false;
      var hasChild = false;
      var hasSameChildrenNb = false;
      var isLastChild = true;
      var isLastNode = false;
      var nbErreurs = 0;
      var nbLignes = 0;
      var commentaire = "";
      var nomTestcaseDifferent = false;
      var nbNomsTescaseDifferents = 0;
      
      // Sélectionner tous les noeuds pour débuter les boucles de comparaison des noeuds XML.
      var baselineAllNodesList = xmlDOMbaseline.selectNodes("//*");
      var doc1AllNodesList = xmlDOMaComparer.selectNodes("//*");
      
      if (baselineAllNodesList.length > 0 && doc1AllNodesList.length > 0) {
        // On passe d'un noeud a l'autre jusqu'à la fin des 2 XML.
        baselineNode = xmlDOMbaseline.firstChild;
        doc1Node = xmlDOMaComparer.firstChild;
        
        if ((doc1Node.nodeName == baselineNode.nodeName) && (baselineNode.nodeName == "xml")) {
            baselineNode = baselineNode.nextSibling;
            doc1Node = doc1Node.nextSibling;
        }
        
        while (baselineNode != null && doc1Node != null) {
          if (doc1Node.nodeName == baselineNode.nodeName) {
              // Trouver l'index du nom du noeud dans la liste de noms (Permet de se situer dans la liste des attributs).
              while (listeNomsNodes[idNodes] != baselineNode.nodeName) {
                idNodes = idNodes+1;
              }
              
              // Comparer les attributs d'un noeud.
              for (iAttribut = 0; iAttribut < listeAttributs[idNodes].length; iAttribut++) {
                resultatComparaison = aqString.Compare(doc1Node.attributes.getNamedItem(listeAttributs[idNodes][iAttribut]).value, baselineNode.attributes.getNamedItem(listeAttributs[idNodes][iAttribut]).value, true);
                Log.Message((nbNodes+1) +" " +doc1Node.nodeName +" - Attribut: " +(iAttribut+1) +" " +listeAttributs[idNodes][iAttribut], doc1Node.attributes.getNamedItem(listeAttributs[idNodes][iAttribut]).value +" vs. baseline: " +baselineNode.attributes.getNamedItem(listeAttributs[idNodes][iAttribut]).value);
                if (resultatComparaison != 0) {
                   erreurNonPresente = false;
                   Log.Error((nbNodes+1) +" " +doc1Node.nodeName +" - L'attribut " +listeAttributs[idNodes][iAttribut] +" est différent du baseline. ", doc1Node.attributes.getNamedItem(listeAttributs[idNodes][iAttribut]).value +" vs. baseline: " +baselineNode.attributes.getNamedItem(listeAttributs[idNodes][iAttribut]).value); 
                   if ((listeAttributs[idNodes][iAttribut] == +listeAttributs[2][0]) && (doc1Node.nodeName == listeNomsNodes[2])) { // Le nom du testcase est différent sur les 2 noeuds comparés.
                     nomTestcaseDifferent = true;
                     nbNomsTescaseDifferents = nbNomsTescaseDifferents + 1;
                     // Rechercher le nom du testcase au baseline ailleurs dans le fichier comparé.
                     // Si retrouvé, c'est un décalage a cause d'un changement d'ordre d'exécution ou de l'ajout d'un ou plusieurs tests. L'ajouter a une liste de noeuds found.
                     // Si pas retrouvé, le testcase a été renommé ou retiré. L'ajouter a une liste de noeuds notfound.
                   }
                }
                else
                  attributsIdentiques[iAttribut] = resultatComparaison;
              }
              
              for (a=0; a < attributsIdentiques.length; a++) { // Boucle de décompte des attributs identiques.
                  if (attributsIdentiques[a] == 0)
                      nbIdentiques = nbIdentiques+1;
              }
              if (nbIdentiques == attributsIdentiques.length)
                  Log.Checkpoint("==> Noeud " +baselineNode.nodeName +" identique au baseline.");
              
              // Prendre des informations sur les noeuds courants pour la navigation dans les XML.
              
              if (baselineNode.nextSibling != null && doc1Node.nextSibling != null)
                hasNextSibling = true;
              else
                hasNextSibling = false;
                
              if (baselineNode.hasChildNodes() && doc1Node.hasChildNodes()) {
                hasChild = true;
                // Vérifier si même nombre de noeuds enfants que le baseline.
                baselineNbChildren = baselineNode.childNodes.length;
                nbChildren = doc1Node.childNodes.length;
                if (baselineNbChildren == nbChildren) {
                    childVisit = true;
                    hasSameChildrenNb = true;
                }
                else {
                    hasSameChildrenNb = false; // Les 2 XML ont failed, notifier une Erreur.
                    // Ajuster le calcul du nombre de noeuds en conséquence des noeuds qu'on ne visitera pas (prendre le plus grand nombre).
                    erreurNonPresente = false;
                    Log.Error("Le nombre de " +baselineNode.firstChild.nodeName +" n'est pas égal au baseline.", nbChildren +" vs. baseline: " +baselineNbChildren);
                    if (baselineNbChildren > nbChildren) {
                        nbNodes = nbNodes + baselineNbChildren;
                        commentaire = " BL-diff";
                    }
                    if (baselineNbChildren < nbChildren) {
                        nbNodes = nbNodes + nbChildren;
                        commentaire = " CF-diff";
                    }
                }
              }
              else { // Au moins un des fichiers n'a pas de child node.
                childVisit = false;
                hasSameChildrenNb = false;
                
                if (baselineNode.hasChildNodes()) {
                    // déséquilibre du baseline.
                    // Le test du baseline est failed, mais le test du fichier XML comparé est passed (b=x > c=0).
                    // On ne gère pas le changement d'état d'une correction, ne pas notifier d'erreur.
                    hasChild = true;
                    baselineNbChildren = baselineNode.childNodes.length;
                    Log.Warning("Il y a des " +baselineNode.firstChild.nodeName +" au baseline, mais pas dans le fichier XML comparé.", nbChildren +" vs. baseline: " +baselineNbChildren);
                    // Ajuster le calcul du nombre de noeuds en conséquence des noeuds baseline qu'on ne visitera pas.
                    nbNodes = nbNodes + baselineNbChildren;
                    erreurNonPresente = true;
                    commentaire = " CF-pass";
                }
                else if (doc1Node.hasChildNodes()) {
                    // déséquilibre du XML à comparer.
                    // Le test du baseline est passed, mais le test du fichier XML comparé est failed (b=0 < c=x), notifier une Erreur.
                    hasChild = true;
                    nbChildren = doc1Node.childNodes.length;
                    Log.Error("Il n'y a pas de " +doc1Node.firstChild.nodeName +" au baseline, mais il y en a dans le fichier XML comparé.", nbChildren +" vs. baseline: " +baselineNbChildren);
                    // Ajuster le calcul du nombre de noeuds en conséquence des noeuds du XML à comparer qu'on ne visitera pas.
                    nbNodes = nbNodes + nbChildren;
                    erreurNonPresente = false;
                    commentaire = " BL-pass";
                }
                else {
                  // Il n'y a aucun noeud enfant pour les 2 noeuds comparés.
                  hasChild = false;
                  baselineNbChildren = 0;
                  nbChildren = 0;
                }
              }
              
              if (baselineNode == baselineNode.parentNode.lastChild && doc1Node == doc1Node.parentNode.lastChild)
                isLastChild = true;
              else
                isLastChild = false;
                
              if (baselineNode.nextSibling == null && doc1Node.nextSibling == null)
                isLastNode = true;
              else
                isLastNode = false;
              
                
              // Préparer la ligne des informations de noeuds testcase qu'il faut enregistrer.
              
              if (idNodes == 2 && (baselineNode != null && doc1Node != null)) {
                  if (resultatNode.noColonne == 1) { // Écriture des entêtes pour la 1re analyse. On prends les donnés XML comparé.
                      resultatNode.nomDuTest = doc1Node.attributes.getNamedItem(listeAttributs[idNodes][0]).value;
                      resultatNode.testSuite = doc1Node.attributes.getNamedItem(listeAttributs[idNodes][1]).value;
                  }
                  if (resultatNode.version.length >= 0) { // Pour l'écriture des résultats de chaque analyses XML.
                      if (erreurNonPresente == true)
                          resultatNode.version.push(("Passed" +commentaire));
                      else
                          resultatNode.version.push(("Failed" + commentaire));
                  }
                  
                  // Entrer le resultat de la comparaison dans le fichier Excel.
                  EcrireResutatDansExcel(resultatNode, modeleBook, sheetName, (4+nbLignes));
                  nbLignes = nbLignes +1;
                  
                  // Suite à l'écriture dans Excel, décompte et remise à zéro du flag de détection d'erreur.
                  if(erreurNonPresente == false) {
                    resultatNode.nombreDifferences = resultatNode.nombreDifferences +1;
                    erreurNonPresente = true;
                  }
              }
              else if(erreurNonPresente == false) {
                  resultatNode.nombreDifferences = resultatNode.nombreDifferences +1;
                  erreurNonPresente = true;
              }
              
              
              // Conditions de visite des prochains noeuds et déplacements.

              if (hasNextSibling == true) {
                  upOneNode = false;
                  toNextNode = true;
              }
              if ((baselineNode == baselineNode.parentNode.lastChild && doc1Node == doc1Node.parentNode.lastChild) || hasNextSibling == false)
                  upOneNode = true;
                  
              if (hasChild  == true && childVisit == true) {
                  if (hasSameChildrenNb == true || idNodes < 2) {
                      // Déplacement : On va visiter les noeuds enfants.
                      Log.Message("** Visite 1er noeud enfant **");
                      baselineNode = baselineNode.firstChild;
                      doc1Node = doc1Node.firstChild;
                      // Gérer les flags des autres conditions de changement de noeuds.
                      if (hasNextSibling == true)
                          upOneNode = false;
                      
                      toNextNode = false;
                  }
                  else {
                      // Si nombre de noeuds enfants du testcase (nb. de failures) différent du baseline, ne pas visiter, on passe au prochain noeud.
                      if (hasNextSibling == true && idNodes == 2)
                          upOneNode = false;
                      childVisit = false;
                      toNextNode = true;
                  }
              }
              
              if (childVisit == false && upOneNode == true && (isLastChild == true || isLastNode == true) && hasNextSibling == false) {
                  // Déplacement : On remonte au node parent.
                  Log.Message("** Remonte au noeud parent **");
                  baselineNode = baselineNode.parentNode.nextSibling;
                  doc1Node = doc1Node.parentNode.nextSibling;
                  toNextNode = false;
              }
              if (toNextNode == true && isLastNode == false) {
                  // Déplacement : On va au prochain node sibling.
                  Log.Message("** Prochain noeud sibling **");
                  baselineNode = baselineNode.nextSibling;
                  doc1Node = doc1Node.nextSibling;
              }
              
              // M-à-j du décompte de noeuds et remises à zéro requises.
              nbNodes = nbNodes +1;
              idNodes = 0;
              attributsIdentiques.length = 0;
              nbIdentiques = 0;
              commentaire = "";
          }
          else {
              erreurNonPresente = false;
              Log.Error("Le nom des noeuds comparés est différent");
          }
        }
      }
      else {
          erreurNonPresente = false;
          Log.Error("Le nombre de noeuds de ce XML est de zéro.");
      }
  }
  
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      resultatNode = undefined;
  }
  return resultatNode;
}


/////////////////////////////////////////////////////////////////////////////////////
// Work base: Fonctions en dev. ou pour références et exemples - Not ready to Run. //
/////////////////////////////////////////////////////////////////////////////////////


/**
    Description : TODO: Gère le delta d'un fichier de résultat ayant plus de
                  nodes que le baseline et vice versa.
    Paramètres :
        - xmlDOMbl : un objet XML DOM document qui servira de baseline.
        - xmlDOMcf : un objet XML DOM document à comparer.
        - deltaType :
                  - Delta BL: Quand un noeud du baseline (BL) n'est pas présent dans le fichier comparé (CF).
                  - Delta CF: Quand le noeud du CF est un nouveau test qui n'est pas présent dans BL.
                  
    Résultat : Retourne un Array de XML DOM contenant selon le cas soit
                  - Un XML DOM de nodes+children provenant du BL qu'on ne retrouve pas dans le CF (Delta BL).
                  - Un XML DOM de nodes+children provenant du CF, nouveaux cas qu'on ne retrouve pas dans le CF (Delta CF).
    Note :
            - Utilise les métodes importNode et appendChild du XML DOM pour créer des collections de noeuds représentant le delta.
    Auteur : Frédéric Thériault
**/
function DeltaDesNodesXML(xmlDOMbl, xmlDOMcf)
{
  try {
      var nodeType = "testcase";
      var xmlDOMnotFoundBL = Sys.OleObject("Msxml2.DOMDocument.6.0");
      xmlDOMnotFoundBL.async = false;
      var xmlDOMnewTestsCF = Sys.OleObject("Msxml2.DOMDocument.6.0");
      xmlDOMnewTestsCF.async = false;
      var arrayXmlDOMdocs = new Array();
      var iListeBL = 0;
      var iListeCF = 0;
      var testNotFoundBL = undefined;
      var newTestCF = undefined;
      var newTest = false;
      var goToNextSibling = false;
      var childVisit = false;
      var nbNotFound = 0;
      var nbNewTests = 0;
      
      listeTestsBL = xmlDOMbl.getElementsByTagName(nodeType);
      listeTestsCF = xmlDOMcf.getElementsByTagName(nodeType);
      
      //       1- Préparer les DOM Delta
      
      xmlDOMnotFoundBL = PreparerXmlDOMdelta(xmlDOMbl);
      xmlDOMnewTestsCF = PreparerXmlDOMdelta(xmlDOMcf);
      
      //       2- Effectuer les validations avec la DOM NodeList de testcase pour égaliser les DOM comparés et remplir les DOM Delta.
      
      while (iListeBL < listeTestsBL.length) {
          nodeBL = listeTestsBL.item(iListeBL);
          nodeCF = listeTestsCF.item(iListeCF);
          nomTestBL = nodeBL.getAttribute("name");
          nomTestCF = nodeCF.getAttribute("name");
            
          if (nomTestBL != nomTestCF) {
              // Rechercher parmis les listes des testcase pour déterminer si c'est un test manquant ou un nouveau test.
              for (iCh = 0; iCh < listeTestsCF.length; iCh++) {
                  // Chercher dans CF le noeud de BL
                  elementCF = listeTestsCF.item(iCh);
                  if (nomTestBL == elementCF.getAttribute("name"))
                  {
                    testNotFoundBL = false;
                    newTestCF = false;
                    break;
                  }
                  else if (iCh == (listeTestsCF.length -1)) {
                    testNotFoundBL = true;  // Noeud de BL manquant au XML CF (delta BL).
                    // Déplacer le noeud testcase de BL dans le XML DOM approprié pour noter la différence.
                    Log.Message("** Ajout au XML DOM Delta notFound **", nomTestBL);
                    newElementBL = xmlDOMnotFoundBL.importNode(nodeBL, true);
                    xmlDOMnotFoundBL.getElementsByTagName("testsuite").item(0).appendChild(newElementBL);
                    xmlDOMbl.getElementsByTagName("testsuite").item(0).removeChild(nodeBL);
                    
                    listeTestsBL = xmlDOMbl.getElementsByTagName(nodeType); // On recompose la liste car il y a eu retrait.
                  }
              }
              
              //testNotFoundBL = RechercherCasTestDansXML(nodeBL, listeTestsCF, xmlDOMbl, xmlDOMnotFoundBL, "Delta notFound"); // Fonction appelée 1re fois.
              
              if (testNotFoundBL == false) {
                  // Noeuds identiques retrouvés, mais l'ordre d'exécution a changé.
                  Log.Warning("L'ordre des noeuds testscase a changé. Un test du baseline été retrouvé ailleurs dans le CF.", "Nom du test BL : " +nomTestBL);
                  // On passe au noeud BL suivant pour touver les autres Deltas.
                  iListeBL = iListeBL + 1;
                  testNotFoundBL = undefined;
              }
              else {
                  listeTestsBL = xmlDOMbl.getElementsByTagName(nodeType); // On recompose la liste au car il y a eu retrait.
                  nbNotFound = nbNotFound +1;
              }
              
              // Valider si test CF différent est un nouveau test pas dans BL.
              // Si oui, le déplacer dans le XML DOM des nouveaux tests (Delta CF).
              // Si non, on a retrouvé le test dans BL, mais l'ordre a changé.
              for (jCh = 0; jCh < listeTestsBL.length; jCh++) {
                  // Chercher dansBL le noeud de CF
                  elementBL = listeTestsBL.item(jCh);
                  if (nomTestCF == elementBL.getAttribute("name"))
                  {
                    testNotFoundBL = false;
                    newTestCF = false;
                    break;
                  }
                  else if (jCh == (listeTestsBL.length -1)) {
                    newTestCF = true;
                    // Déplacer le noeud testcase de CF dans le XML DOM approprié pour noter la différence.
                    Log.Message("** Ajout au XML DOM Delta newTests **", nomTestCF);
                    newElementCF = xmlDOMnewTestsCF.importNode(nodeCF, true);
                    xmlDOMnewTestsCF.getElementsByTagName("testsuite").item(0).appendChild(newElementCF);
                    xmlDOMcf.getElementsByTagName("testsuite").item(0).removeChild(nodeCF);
                    
                    listeTestsCF = xmlDOMcf.getElementsByTagName(nodeType); // On recompose la liste car il a eu retrait.
                  }
              }
              
              //newTestCF = RechercherCasTestDansXML(nodeXML, listeTestsBL, xmlDOMcf, xmlDOMnewTestsCF,"Delta newTests")// Fonction appelée 2e fois.
              
              if (newTestCF == false && iListeCF < iListeBL) { // On ne doit pas dépasser l'endroit ou l'on valide dans le BL.
                  testNotFoundBL = false;
                  // Noeuds identiques retrouvés, mais l'ordre d'exécution a changé.
                  Log.Warning("L'ordre des noeuds testscase a changé. Un test du CF été retrouvé ailleurs dans le baseline.", "Nom du test CF : " +nomTestCF);
                  // Ne pas s'arrêter, on passe au noeud CF suivant pour touver les autres Deltas.
                  iListeCF = iListeCF + 1;
              }
              else
                  listeTestsCF = xmlDOMcf.getElementsByTagName(nodeType); // On recompose la liste car il y a eu retrait.
          }
          else {
            // Noeuds de tests identiques, on ne fait pas de déplacement de noeuds et on passe au noeud suivant dans BL et CF.
            testNotFoundBL = false;
            iListeBL = iListeBL + 1;
            if (iListeCF < (listeTestsCF.length -1))
                iListeCF = iListeCF + 1;
          }
          
          if (testNotFoundBL) {
              nbNotFound = nbNotFound +1;
              iListeBL = iListeBL + 1; // Test non retrouvé on poursuit au prochain.
          }
          if (newTestCF){
            nbNewTests = nbNewTests +1;
          }
      }
      
      if (nbNotFound > 0)
          Log.Message(nbNotFound +" test(s) du baseline non retrouvé(s) dans le fichier XML comparé.")
          
      if (newTestCF > 0)
          Log.Message(newTestCF +" nouveaux test(s) du fichier comparé non retrouvé(s) dans le fichier baseline.")
      
      // Créer un Array() qui contient les XML DOM à retourner.
      //arrayXmlDOMdocs.AddItem(xmlDOMbl);
      //arrayXmlDOMdocs.AddItem(xmlDOMcf);
      //arrayXmlDOMdocs.AddItem(xmlDOMnotFoundBL);
      //arrayXmlDOMdocs.AddItem(xmlDOMnewTestsCF);
  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //arrayXmlDOMdocs = undefined;
  }
  finally {
    //return arrayXmlDOMdocs;
  }
}

function PreparerXmlDOMdelta(xmlDOM)
{
  try {
    var xmlDOMdelta = Sys.OleObject("Msxml2.DOMDocument.6.0");
    var goToNextSibling = false;
    var childVisit = false;
    
    nodeXML = xmlDOM.firstChild;
    
    while (nodeXML != null && (nodeXML.nodeName != "testcase")) {
        // Note: Il faut copier les noeuds testssuites et testsuite dans les XML DOM Delta pour respecter la structure.
        // Clone et ajoute la node de dans les nouveaux XML DOM selon le contexte.
        clonedNode = nodeXML.cloneNode(false);
        
        if (xmlDOMdelta.firstChild == null) {
            // Copier 1er noeud du XML DOM
            xmlDOMdelta.appendChild(clonedNode);
            nodeXMLdelta = xmlDOMdelta.firstChild;
        }
        else if (nodeXML.previousSibling != null) {
          if (nodeXML.previousSibling.nodeName == nodeXMLdelta.nodeName) {
              // Copier un sibling du noeud
              nodeXMLdelta.parentNode.appendChild(clonedNode);
              nodeXMLdelta = nodeXMLdelta.nextSibling;
          }
        }
        else if (nodeXMLdelta.nodeName == nodeXML.parentNode.nodeName && nodeXMLdelta.firstChild == null) {
            // Copier un child du noeud
            nodeXMLdelta.appendChild(clonedNode);
            nodeXMLdelta = nodeXMLdelta.firstChild;
        }
        
        // Gestion des flags de navigation du XML DOM que l'on veut copier.
        if (nodeXML.nextSibling != null)
            goToNextSibling = true;
        else
            goToNextSibling = false;
          
        if (nodeXML.firstChild != null)
            childVisit = true;
        else
            childVisit = false;
            
        // Déplacement de noeud dans le XML DOM que l'on veut copier.          
        if (goToNextSibling == true) {
            // Passer au noeud suivant si il existe.
            nodeXML = nodeXML.nextSibling;
        }
        else if (goToNextSibling == false && childVisit == true) {
            // TODO: Si pas de sibling, on descends au 1er child dans les fichiers delta et dans les XML DOM documents.
            if (nodeXML.firstChild != null && childVisit == true)
                nodeXML = nodeXML.firstChild;
        }
    }
  }
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
      xmlDOMdelta = undefined;
  }
  finally {
    return xmlDOMdelta;
  }
}

function RechercherCasTestDansXML(nodeXML, listeTests, xmlDOM, xmlDOMdelta, typeDeDelta)
{
  try {
      nomTest = nodeXML.getAttribute("name");
    
      for (iCh = 0; iCh < listeTests.length; iCh++) {
          // Chercher dans la listeTests le noeud XML
          element = listeTests.item(iCh);
          if (nomTest == element.getAttribute("name"))
          {
            testNotFound = false;
            break;
          }
          else if (iCh == (listeTests.length -1)) {
            testNotFound = true;  // Noeud du xmlDOM manquant a la liste (delta).
            // Déplacer le noeud testcase de xmlDOM dans le DOM Delta pour noter la différence.
            Log.Message("** Ajout au XML DOM " +typeDeDelta +" **", nomTest);
            newElement = xmlDOMdelta.importNode(nodeXML, true);
            xmlDOMdelta.getElementsByTagName("testsuite").item(0).appendChild(newElement);
            xmlDOM.getElementsByTagName("testsuite").item(0).removeChild(nodeXML);
          }
      }
  }
  catch (e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    testNotFound = undefined;
  }
  finally {
    return testNotFound;
  }
}


/**
    Description : Exemple création d'un nouveau Checkpoint dans le Stores de TC.
    Auteur : Frédéric Thériault
**/
/**
function CreerNouveauModeleCheckpoint(pathXMLbaselineFile, newXMLCheckpointName) {
  // Créer un nouveau modèle de Checkpoint XML dans Stores.
  if (! XML.Contains(newXMLCheckpointName)) {
      // Creates an IXMLDOMDocument object.
      XMLDoc = Sys.OleObject("Msxml2.DOMDocument.6.0");
              
      XMLDoc.async = false;
      // Loads data form the XML file to the IXMLDOMDocument object.
      XMLDoc.load(pathXMLbaselineFile);
              
      // Creates NewXMLCheckpoint and checks if the creation is successful.
      if (XML.CreateXML(newXMLCheckpointName, XMLDoc)) {
          Log.Message(newXMLCheckpointName +" has been successfully created.");
      }
      else
          Log.Error("Failed to create " +newXMLCheckpointName +".");
  }
  else {
      // If the checkpoint already exists, posts a Warning message to the log.
      Log.Warning("The " +newXMLCheckpointName +" already exists in the Stores | XML collection.");
  }
}
**/


/**
    Description : Exemple création d'un objet XML qui va utiliser le Stores de TC.
    Auteur : Frédéric Thériault
**/
/**
var xmlBaseline = Sys.OleObject("Msxml2.DOMDocument.6.0");
xmlBaseline.async = false;
xmlBaseline.resolveExternals = false;

xmlBaseline.loadXML(XML.XmlCheckpointforResults.Document.xml);  // Utiliser TC Stores pour charger le contenu XML.
if (xmlBaseline.parseError.errorCode != 0) {
    uneErreur = xmlBaseline.parseError;
    Log.Error("DOM XML BaseLine chargement en erreur", uneErreur.reason);
}
else
    Log.Checkpoint("DOM XML BaseLine load", xmlBaseline.xml);   //Log si succès.


// Exemple de remplacement du contenu d'un fichier XML existant dans le Stores de TC.

// Chargement de contenu XML pour remplacer le contenu actuel de Stores Xml.
XML.newXMLCheckpointName.Document.load(pathXMLbaselineFile);
Log.Message("Loaded data to Store", XML.newXMLCheckpointName.Document.xml);
//XML.%%newXMLCheckpointName%%.Check(pathXMLaComparer);   // Lancer la comparaison XML builtin de TC.
**/
