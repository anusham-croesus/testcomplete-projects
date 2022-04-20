//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider que le critère ne s’affiche pas automatiquement si la pref =NON, module Clients
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5746
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Asma Alaoui
*/

function CR2050_5746_Clt_ValidateCriteriaWhenPrefNO()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5746","CR2050");
    try {
    var test= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "NomCritère_5746", language+client);
    var lang=  ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "Croes_5746_Langue", language+client);
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    
    
    //Mettre la pref par défaut à OUI
    Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
    RestartServices(vServerAccounts);
    
    //Se connecter avec KEYNEJ
    Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
   
    //Accès au module Clients
    Get_ModulesBar_BtnClients().Click();
   
    //Cliquer sur le bouton "Gérer les critères de recherche" et ajouter un le critère de recherche BD88
    Get_Toolbar_BtnManageSearchCriteria().Click();
    AddCriteria(test);
   
    //Valider que le nom du criètre de recherche s'affiche dans un carré bleu et l'option "Réafficher tout et conserver les crochets et visible"
     aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked",cmpEqual, true);
     aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"Exists",cmpEqual, true);
     aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"VisibleOnScreen",cmpEqual, true);
     aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsVisible",cmpEqual, true);
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"Exists",cmpEqual, true);
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"VisibleOnScreen",cmpEqual, true);
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsVisible",cmpEqual, true);
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsChecked",cmpEqual, true);
     
  
     //Vérifier que la colonne 'Langue' n'est pas affichée
    
        if (Get_ClientsGrid_ChLangue().Exists){
            Log.Error("'Language' column displayed. This is not expected.");
            return;
        }
         
     //Ajouter la colonne 'Langue' 
    Log.Message("Add the 'Language' column.");        
    ExecuteActionAndExpectSubmenus(Get_ClientsGrid_ChClientNo(), "CLICKR", 3); 
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Language().Click();
   
    //Vérifier que la colonne 'Langue' est affichée
    if (!(Get_ClientsGrid_ChLangue().Exists)){
            Log.Error("'Language' column not displayed. This is not expected.");
            return;
        }
       Log.Checkpoint("Language is displayed.")     
           
    //Valider l'affichage des crochets et le critère de recherche "Langue"  
    ValidateMatchesCriteriaClients(lang) 
    
    //fermer l'application  
    Terminate_CroesusProcess();
    
    //Se connecter à l'application        
    Login(vServerAccounts, userNameKEYNEJ, psw, language);
    
    //Accès au module Clients
    Get_ModulesBar_BtnClients().Click();
    
    //valider que le critère créé est bien affiché dans le module Clients
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(),"Exists",cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(),"VisibleOnScreen",cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(),"IsVisible",cmpEqual, true);
   
    
    // seulement les clients qui ont la langue anglaise auront un crochet rouge dans la liste des clients
    ValidateLanguageAndMatchesCriteriaClients(lang);
    
    // cliquer sur le critère de recherche
    Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().Click(10, Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().get_ActualHeight()/2);
   
    //Uniquement la liste des client associés au critère seront affichés
    ValidateMatchesCriteriaClients(lang);
         
    //fermer l'application  
    Terminate_CroesusProcess();
    
    //changer la pref user à Non
    Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "NO", vServerAccounts)
    RestartServices(vServerAccounts);
    
    //Se connecter à l'application        
    Login(vServerAccounts, userNameKEYNEJ, psw, language);
    
    //Accès au module Clients
    Get_ModulesBar_BtnClients().Click();
    
    //le critère n'est plus affiché et les crochets ne sont plus visible
    ValidateNoMatchesCriteriaClients(lang);
    
         
 }  
 catch(e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
       Terminate_CroesusProcess();
       Delete_FilterCriterion(test,vServerAccounts)
       Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
       RestartServices(vServerAccounts); 
       Terminate_CroesusProcess();

    }
    finally {
    ExecuteActionAndExpectSubmenus(Get_ClientsGrid_ChClientNo(), "CLICKR", 3); 
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();//rétablir la configuration par défaut des colonnes 
    Delete_FilterCriterion(test,vServerAccounts)//supprimer le critère de recherche
    Terminate_CroesusProcess(); //Fermer Croesus
    Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
    RestartServices(vServerAccounts); 
    Terminate_CroesusProcess();
     
    }
   
}

function AddCriteria(test)
{          
    //sur la fenêtre Critères de recheche cliquer sur Ajouter
    Get_WinSearchCriteriaManager_BtnAdd().Click(); 
    
    //Ouverture de la fenêtre "Ajouter un critère de recherche"
    Get_WinCRUSearchCriterionAdvanced().Click();
    
    //Saisir le nom 
    Get_WinAddSearchCriterion_TxtName().Keys(test);
       
    //Sur "Definition" modifier <Verbe> à "ayant"
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
    //Sur <Champ> choisir "Informatif" ensuite " langue"
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemLanguage().Click();
    
    //Sur <Opérateur> choisir "égal(e) à
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    
    // choisir "Anglais"
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemLanguage_Anglais().Click(); ;
    
    
    //Sur <Suivant> choisir le point " . "
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
    // Cliquer sur "Sauvgarder et actualiser
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click(); 
       
}
  
 
  //le critère et les crochets sont visibles   
function ValidateMatchesCriteriaClients(lang)
{
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
 
     for(var i = 0; i < count; i++)
   {  
       var valueMatchesCriterion=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
       var langue= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.LanguageDescription.OleValue;
           
        if (valueMatchesCriterion == true && langue == lang)   
             
            Log.Checkpoint("Le critère de recherche est respecté. La langue définie est : "+langue )
          else 
            Log.Error("la ligne d'indice "+i+" ne respecte le critère de recherche. La langue est :"+langue)                    
                 
    }  
        
}

//les crochets ne doivent pas s'afficher
function ValidateNoMatchesCriteriaClients(lang)
{  
     
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
   {  
       var valueMatchesCriterion=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
       var langue= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.LanguageDescription.OleValue;
       
        if(valueMatchesCriterion == false)
        
            Log.Checkpoint("Auncun critère de recherche n'est récupéré dans la ligne "+i+" La langue récuperée est différente de la langue définie:  "+lang )
          else 
            Log.Error("la ligne d'indice "+i+" ne respecte le critère de recherche. La langue affichée  : "+lang)                    
                 
    }  
}  


function ValidateLanguageAndMatchesCriteriaClients(lang)
{   
  var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
 
     for(var i = 0; i < count; i++)
     {  
       var valueMatchesCriterion=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
       var langue= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.LanguageDescription.OleValue;
       var clientN= Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ClientNumber.OleValue;
           
       if ((langue== lang && valueMatchesCriterion == true || langue!= lang && valueMatchesCriterion != true) )       
           Log.Checkpoint("La ligne d'inice "+i+" a la langue: "+lang+" et elle est cochée" )
           
       else       
           Log.Error("La ligne d'inice "+i+" le critere de recherche n'est pas respecté. La langue affichée est:  "+lang  +"--"+ langue+"--"+ clientN)          
     }  
}


function ExecuteActionAndExpectSubmenus(componentObject, action, maxNbOfTries)
{
    try {
        SetAutoTimeOut(500);
        
        if (maxNbOfTries == undefined)
            maxNbOfTries = 5;
        
        var nbOfTries = 0;
        do {
            if (aqString.ToUpper(action) == "CLICKR" || aqString.ToUpper(action) == "CLICKR()")
                componentObject.ClickR();
            else if (aqString.ToUpper(action) == "CLICK" || aqString.ToUpper(action) == "CLICK()")
                componentObject.Click();
            else
                componentObject.Keys(action);
            
            Delay(200);
             Aliases.CroesusApp.Refresh();
        } while (!(Get_SubMenus().Exists && Get_SubMenus().VisibleOnScreen) && (++nbOfTries < maxNbOfTries))
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        if (!(Get_SubMenus().Exists && Get_SubMenus().VisibleOnScreen)) Log.Error("Submenus was not displayed.");
        RestoreAutoTimeOut();
    }
}
