//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider que le critère ne s’affiche pas automatiquement si la pref =NON, module Titres
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5748
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Asma Alaoui
*/

function CR2050_5748_Sec_ValidateNotDisplayCriteriaWhenPrefNo()
{
    try{
      
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5748","CR2050");
        var criterion =  ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "Croes_5748_Classe", language+client);
        var test=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "NomCritère_5748", language+client);
       
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
        RestartServices(vServerAccounts);
        
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Accès au module Titre
        Get_ModulesBar_BtnSecurities().Click(); 
        
        //Cliquer sur le bouton "Gérer les critères de recherche"
        Get_Toolbar_BtnManageSearchCriteria().Click();     
        AddCriteria(test, criterion);
        
        //Valider bouton "Réafficher tout et conserver les crochets"
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"Exists",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"VisibleOnScreen",cmpEqual, true);
        aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsVisible",cmpEqual, true);
        
        
        //Valider les titres avec le critère defini
        ValidateMatchesCriteriaTitres(criterion);
        
        //Fermer l'application  
        Terminate_CroesusProcess();
        
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //Accès au module Titres
        Get_ModulesBar_BtnSecurities().Click();
        
        //Accèder au critère de recheche déjà créé 
        Get_MainWindow_StatusBar_NbOfcheckedElements().DblClick()
        
        //Cliquer sur "Sauvgarder et actualiser" dans la  fenêtre Modifier un critère de recherche
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        
        //Valider les titres avec le critre de recherche et les crochets
        ValidateMatchesCriteriaTitres(criterion);
        
        //Fermer l'application  
        Terminate_CroesusProcess();
        
        //changer la pref user à Non
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "NO", vServerAccounts)
        RestartServices(vServerAccounts);
    
        //Se connecter à l'application        
        Login(vServerAccounts, userNameKEYNEJ, psw, language);
    
        //Accès au module Clients
        Get_ModulesBar_BtnSecurities().Click();
        
        //Valider que le critère de recherche défini ne s'affiche plus en bas de la page à droite
       if (Get_MainWindow_StatusBar_NbOfcheckedElements().Text.OleValue != 0)
       
           Log.Error("Il y'a un critère de recheche qui appliqué ce qui ne correspond pas au fonctionnement attendu") 
         else
             Log.Checkpoint("respecte le fonctionnement attendu" ) 
        }
        
   catch(e) 
    {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
       Terminate_CroesusProcess();
       Delete_FilterCriterion(test,vServerAccounts)
       Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
       RestartServices(vServerAccounts); 
       Terminate_CroesusProcess();
      
    }
    
    finally
    {   
        
      Delete_FilterCriterion(test,vServerAccounts)//Supprimer le criterion de BD      
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
      RestartServices(vServerAccounts); 
      Terminate_CroesusProcess();
    }
}
        


//ajouter un critère de recherche
function AddCriteria(test, criterion)
{
          
    //sur la fenêtre Critères de recheche cliquer sur Ajouter
    Get_WinSearchCriteriaManager_BtnAdd().Click(); 
      
    //Saisir le nom 
    Get_WinAddSearchCriterion_TxtName().Keys(test);
    
    //Sur "Definition" modifier <Verbe> à "ayant"
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
    //Sur <Champ> choisir "Informatif" ensuite "type/classe (sous-catégorie) "
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemTypeClass().Click();
    
    //Sur <Opérateur> choisir "égal(e) à
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    
    // Entrer la valeur "310" 
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(criterion);
    
    
    //Sur <Suivant> choisir le point " . "
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
    // Cliquer sur "Sauvgarder et actualiser
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
} 

function ValidateMatchesCriteriaTitres(criterion) 
{  
    var tab = Get_Grid_ContentArray(Get_SecurityGrid(),Get_SecurityGrid_ChType());
  for(n = 0; n < tab.length; n++)
    { 
    var ligne= Get_SecurityGrid().RecordListControl.Items.Item(n);  
    var valueMatchesCriterion=ligne.DataItem.MatchesCriterion;
    var titre= ligne.DataItem.Type.OleValue;        
    
           
        if((valueMatchesCriterion == true && titre ==criterion)|| (valueMatchesCriterion == false && titre !=criterion))
                            
            Log.Checkpoint("Le titre dans la ligne "+n+" respecte le critère de recherche "+titre)
          else 
            Log.Error("La ligne d'indice "+n +" ne respecte le critère de recherche défini. Le titre est : "+titre)             
    }       
 
}
