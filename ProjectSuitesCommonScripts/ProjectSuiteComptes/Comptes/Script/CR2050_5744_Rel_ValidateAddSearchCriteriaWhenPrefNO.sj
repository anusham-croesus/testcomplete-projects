//USEUNIT Common_functions
//USEUNIT CR2050_5743_Mod_ValidateCriteriaWhenPrefNO
//USEUNIT DBA
//USEUNIT ExcelUtils
//USEUNIT Global_variables

/**
    Description :Valider l’ajout d’un critère de recherche avoir la pref =Non, module Relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5744
   Analyste d'assurance qualité : Marina Gasin
   Analyste d'automatisation : Asma Alaoui
*/

function CR2050_Croes_5744_Rel_ValidateAddSearchCriteriaWhenPrefNO()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5744","CR2050");    
        var criterion =  ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "CodeCP", language+client);
        var test=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2050", "NomCritère_5744", language+client);    
           
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "NO", vServerAccounts)
        RestartServices(vServerAccounts);
        
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
         //Accès au module Relations 
        Get_ModulesBar_BtnRelationships().Click();
        //Cliquer sur le bouton "Gérer les critères de recherche"
        Get_Toolbar_BtnManageSearchCriteria().Click();
        AddCriteria(test, criterion)
        
        //Valider bouton "Réafficher tout et conserver les crochets" et le nom du criètre de recherche s'affiche dans un carré bleu
         aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsChecked",cmpEqual, true);
         aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"Exists",cmpEqual, true);
         aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"VisibleOnScreen",cmpEqual, true);
         aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(),"IsVisible",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"Exists",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"VisibleOnScreen",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsVisible",cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10),"IsChecked",cmpEqual, true);
 
        //Valider les relations avec le critère de recherche défini
        ValidateMatchesCriteriaRelations(criterion)        
        //Fermer l'application  
        Terminate_CroesusProcess();
    
        //se reconnecter à l'application    
        Login(vServerAccounts, userNameKEYNEJ, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Aucun critère de recherche n'est appliqué
        ValidateNoMatchesCriteriaRelations();
}

    catch(e) {
       Log.Error("Exception: " + e.message, VarToStr(e.stack));
       Terminate_CroesusProcess();
       Delete_FilterCriterion(test, vServerAccounts)
       Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
       RestartServices(vServerAccounts); 
       Terminate_CroesusProcess();
      
}
    
    finally {   
        
      Delete_FilterCriterion(test,vServerAccounts)//Supprimer le critère de recherche      
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_AUTOMATIC_CRITERIA", "YES", vServerAccounts)
      RestartServices(vServerAccounts); 
      Terminate_CroesusProcess();
    }
} 

    //Verifier la pésence de crochet rouge sur les codes de CP BD88
function ValidateMatchesCriteriaRelations(criterion)
    {       
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
      {  
       var valueMatchesCriterion=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
       var code = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber.OleValue;
           
        if ((valueMatchesCriterion == true && code ==criterion) || (valueMatchesCriterion == false && code != criterion ))
        
            Log.Checkpoint("Le code de CP et les crochets dans la ligne "+i+" respectent le critère de recherche c'est le "+code+" qui est récupéré" )
          else 
            Log.Error("la ligne d'indice "+i+" ne respecte le critère de recherche. Le code de CP est : "+code)                    
                 
    }  
    
}    
    
    //les crochets ne doivent pas s'afficher
function ValidateNoMatchesCriteriaRelations()
    {  
     
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
 
  for(var i = 0; i < count; i++)
      {  
       var valueMatchesCriterion=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.MatchesCriterion;
       var code = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber.OleValue;
           
        if(valueMatchesCriterion == false)
        
            Log.Checkpoint("Auncun critère de recherche n'est récupéré dans la ligne "+i+" "+code )
          else 
            Log.Error("la ligne d'indice "+i+" ne respecte le critère de recherche. Le code de CP est : "+code)                    
                 
    }  
}