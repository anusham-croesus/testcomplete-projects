//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
  Description : Jira PF-2532 L'application roule dans le vide lorsqu'on backdate.   
  Étapes pour Reproduire:
  Mailler le compte 800300-na au module portefeuille
  Antidaté le portefeuille  31/01/2001
  
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-19-2020-09-33
*/


function TCVE_2777_PF_2532()
{
   try {
          
          //Lien de la storie dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2777","Tâche TCVE-2777");
           //Lien du cas de test dans Jira
           Log.Link("https://jira.croesus.com/browse/PF-2532","Anomalie PF-2532");
           
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          var AccountNumber800300NA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "NumberAccount800300NA", language+client);
          var PortefeuilleDateValue = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "PortefeuilleDateValue_PF2532", language+client);
          var DisplayMessage = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "Message_PF2532", language+client); //Aucune donnée n'est disponible à la date choisie.
          var DisplayBlinkingText = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "DisplayBlinkingText_PF2532", language+client); //"ANTIDATÉ AU:2001/01/31"
          
          Log.Message("se connercter avec "+userNameKEYNEJ);
          Login(vServerPortefeuille, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
          
          Log.Message("Sélectionner le compte n "+AccountNumber800300NA)                    
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
          Search_Account(AccountNumber800300NA)         
          
          //mailler vers portefeuille 
          Log.Message("mailler le compte n "+AccountNumber800300NA+" vers portefeuille")                    
          Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", AccountNumber800300NA, 10), Get_ModulesBar_BtnPortfolio());
          
          Log.Message("Antidaté le portefeuille "+PortefeuilleDateValue)
          Get_PortfolioGrid_BarToolBarTray_dtpDate().Click();
          Get_PortfolioGrid_BarToolBarTray_dtpDate().keys("^a");
          Get_PortfolioGrid_BarToolBarTray_dtpDate().set_StringValue(PortefeuilleDateValue);
          //Il faut faire actualiser apres modification de la date pour que la grille puisse se mettre a jour (ou bien tout simplement faire Enter) 
          Get_Portfolio_AssetClassesGrid().click();
          Get_Portfolio_AssetClassesGrid().WaitProperty("IsEnabled", true, 15000);
          
          //Vérifier le message clignotant
          var verifBlinkingText = aqObject.CheckProperty(Get_PortfolioGrid_LblBlinkingText(),"Text", cmpEqual,DisplayBlinkingText+PortefeuilleDateValue)
          if(!verifBlinkingText)
            Log.Error("Bug PF-2532")            
          
          Log.Message("Valider qu'un message d'information s'affiche disant qu'on ne peut pas le backdater.")
          if(Get_DlgInformation().Exists)
          {
            aqObject.CheckProperty(Get_DlgInformation(),"Exists", cmpEqual, true)
            aqObject.CheckProperty(Get_DlgInformation_LblMessage1(),"Text", cmpEqual, DisplayMessage) 
            Get_DlgInformation_BtnOK().Click();
            WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["DataGrid_67cd",true]);            
          }
          else
            Log.Error("Bug PF-2532");            
                    
          //Vérification de curseur
          Log.Message("Valider que le curseur est un pointeur est ne roule pas dans le vide(pas en état de load).")
          //CaptureCursor();
          var cursorState = GetCursorState(Get_MainWindow());
          if(cursorState == "Arrow")
            Log.Checkpoint("L'état de curseur est : "+cursorState);
          else if(cursorState == "Busy")
            Log.Error("Bug PF-2532: l'état de curseur est : "+cursorState);
          else
            Log.Error("l'état de curseur n'est pas pointeur, il est : "+cursorState);

    }
    catch(e) 
    {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
                          
    }
    finally 
    {   
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
}

function CaptureCursor()

{
  // Obtains the coordinates of the mouse pointer

  X = Sys.Desktop.MouseX;

  Y = Sys.Desktop.MouseY;

  // Captures a rectangle area of the desktop including the mouse cursor

  pics = Sys.Desktop.Picture(X-20, Y-20, 40, 40, true);

  // Posts the captured image to the test log

  Log.Picture(pics,"Validation de type de curseur","Cursor State",pmHighest);
}

/**
    Get the current cursor state
    Original function obtained from: https://support.smartbear.com/viewarticle/17632/
*/
function GetCursorState(objComponent)
{
    if (typeof CURSOR_LIBRARY_DLL_USER32 == 'undefined' || CURSOR_LIBRARY_DLL_USER32 == undefined){
        var dDLL = DLL.DefineDLL("USER32");
        var dProc = dDLL.DefineProc("LoadCursorW", vt_i4, vt_ui2, vt_i4);
        CURSOR_LIBRARY_DLL_USER32 = DLL.Load("USER32.DLL", "USER32");
    }
    
    var currentCursor = GetCurrentCursor(objComponent);
    var strCursorState = GetCursorType(currentCursor, CURSOR_LIBRARY_DLL_USER32);
    Log.Picture(objComponent, "The cursor state is: " + strCursorState);
    return strCursorState;
}


/**
    Get the current cursor object
    Ref.: https://support.smartbear.com/viewarticle/17632/
*/
function GetCurrentCursor(wndObj)
{
    var pid = Win32API.GetWindowThreadProcessId(wndObj.Handle, null);
    var tid = Win32API.GetCurrentThreadId();
    Win32API.AttachThreadInput(pid, tid, true);
    var crsr = Win32API.GetCursor();
    Win32API.AttachThreadInput(pid, tid, false);
    return crsr;
}


/**
    Get the cursor type
    Original function obtained from: https://support.smartbear.com/viewarticle/17632/
    Returns:
        "Arrow", "Text select", "Busy", "Precision select", 
        "Alternate select", "Size", "Icon", "Diagonal resize 1 (NW-SE)", 
        "Diagonal resize 2 (NE-SW)", "Horizontal resize", "Vertical resize", 
        "Move", "Unavailable", "Hand", "Background", "Help"
    Ref. https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-loadcursora
*/
function GetCursorType(cursorID, cursorLibrary)
{
    var cursorType = cursorID;
    
    switch (cursorID) {
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_ARROW):
            cursorType = "Arrow";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_IBEAM):
            cursorType = "Text select";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_WAIT):
            cursorType = "Busy";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_CROSS):
            cursorType = "Precision select";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_UPARROW):
            cursorType = "Alternate select";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZE):
            cursorType = "Size";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_ICON):
            cursorType = "Icon";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZENWSE):
            cursorType = "Diagonal resize 1 (NW-SE)";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZENESW):
            cursorType = "Diagonal resize 2 (NE-SW)";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZEWE):
            cursorType = "Horizontal resize";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZENS):
            cursorType = "Vertical resize";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZEALL):
            cursorType = "Move";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_NO):
            cursorType = "Unavailable";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_HAND):
            cursorType = "Hand";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_APPSTARTING):
            cursorType = "Background";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_HELP):
            cursorType = "Help";
            break;
    }
    
    return cursorType;  
}