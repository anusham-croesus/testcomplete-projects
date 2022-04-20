//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
        Description : 
                  
                      Un crash se produit dans Croesus lorsqu'on clique sur l'option 'Ajouter' dans la fenêtre de catégorisation de titre
                       si le curseur se trouve positionné sur une des catégories de type Devise, Indice mixtes, Indices ou Indices réf. panier.



    Auteur : Sana Ayaz
    Anomalie:CROES-9367
    Version de scriptage:ref90-06-Be-17--V9-AT_1-co6x
*/
function CROES_9367_Cli_CrashWinTitleCategoriWhenTryToAddCategory()
{
    try {
        
		//Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/browse/CROES-9367","Anomalie : Jira CROES-9367")
        
        userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
      
        Login(vServerClients, userNameGP1859, passwordGP1859, language);
       
        var NumberTheBugCROES9367=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "NumberTheBugCROES9367", language+client);
        var Currencies=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "Currencies", language+client);
        var BlendedIndices=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "BlendedIndices", language+client);
        var Indices=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "Indices", language+client);
        var BasketRefIndices=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "BasketRefIndices", language+client);
                
        /*Dans le module Client
        Choisir Outils/Configurations/Catégorisation des titres
        */         
         Get_ModulesBar_BtnClients().Click();
         Get_MainWindow().Maximize();
        
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();
        
        Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation().Click();
        Delay(2000)
        Get_WinConfigurations_LvwListView_LlbSecurityAndCategorisation().DblClick();
        Delay(10000)
        
        // Sélectionner Autres/Devises 
        Get_WinSecurityCategorisationConfigurations().Parent.Maximize();
        Get_WinSecurityCategorisationConfigurations().Focus();
        Get_WinSecurityCategorisationConfigurations().Click();
        Delay(2000)
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCash().Click();
        //Fermer tous les catégories ouvertes pour faire apparaître les cartégories qu'on veut tester.
        set_IsExpanded_WinSecurityCategorisationConfiguration_TvwTreeview(Currencies)
        
        ReproduceCrashByCategory(Currencies,NumberTheBugCROES9367);
        ReproduceCrashByCategory(BlendedIndices,NumberTheBugCROES9367);
        ReproduceCrashByCategory(Indices,NumberTheBugCROES9367);
        ReproduceCrashByCategory(BasketRefIndices,NumberTheBugCROES9367); 
        
        
        Get_WinSecurityCategorisationConfigurationsBtnClose().Click();
        Get_WinConfigurations().Close();

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}

function CheckPointForCrash(NumberTheBug)
{
        //maxWaitTime = 10000;
        //waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
        /*while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
            Delay(1000);
            waitTime += 1000;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
        }
        
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");*/
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error(NumberTheBug);
            Get_DlgError().Click(Get_DlgError().get_ActualWidth()/2, Get_DlgError().get_ActualHeight()-45);
        }
        else
            Log.Checkpoint("No crash detected.")
}


function Scroll(searchValue)
{
    //CP : Le if a été ajouté pour faire apparaître la valeur recherchée car la logique du scroll ne fonctionne pas toujours (problème déjà rencontré avant les versions CO)
    if (searchValue == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinSecurityCategorisationConfiguration_TvwTreeview().get_ActualWidth()
        var ControlHeight=Get_WinSecurityCategorisationConfiguration_TvwTreeview().get_ActualHeight()
        Get_WinSecurityCategorisationConfiguration_TvwTreeview().Click(ControlWidth-5, ControlHeight-48)
    }
    else if (!Get_WinSecurityCategorisationConfiguration_TvwTreeview().Find("Value", searchValue, 10).Exists){
        var nbOfRows = Get_WinSecurityCategorisationConfiguration_TvwTreeview().Items.Count;
        Get_WinSecurityCategorisationConfiguration_TvwTreeview().Keys("[Home][Home]");
        var nbPageDown = 0;
        do {
            Get_WinSecurityCategorisationConfiguration_TvwTreeview().Keys("[PageDown]");
            var searchValueObject = Get_WinSecurityCategorisationConfiguration_TvwTreeview().Find("Value", searchValue, 10);
        } while (!searchValueObject.Exists && ++nbPageDown < nbOfRows)
    }
}

function ReproduceCrashByCategory(categoryLabel,NumberTheBug){
    Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCategory(categoryLabel).Click()
    Get_WinSecurityCategorisationConfigurationsBtnAdd().Click()
    //Les points de vérifications :  //Vérifier si le message d'erreur apparaît   
    SetAutoTimeOut();     
    CheckPointForCrash(NumberTheBug);
    RestoreAutoTimeOut();
    Get_WinAddSecurityCategorisationCancel().Click();
}

function set_IsExpanded_WinSecurityCategorisationConfiguration_TvwTreeview(searchValue)
{
    var arrayOfTreeviewItems = Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        if (!Get_WinSecurityCategorisationConfiguration_TvwTreeview().Find("Value", searchValue, 10).Exists)
            arrayOfTreeviewItems[i].set_IsExpanded(false);
    
    
}