//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
    Description : automatiser la désactivation du tri sur certaines colonnes CRM suite à l'ajout de la pref : ENABLE_ENCRYPTION
    Auteur : Youlia Rasiper
    Version de scriptage:	16-2020-5-8--V9
*/
function TCVE_1233_ActivationDeactivation_Sorting_CRM()
{
    try {               
            userNameLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
            passwordLINCOA = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw");
            var nameColumnTel="PhoneNumber"
            var nameColumnEmail="Email"
            var configTxt = Execute_SQLQuery_GetField("select config_txt from b_firm where firm_id=1", vServerAccounts, "config_txt");
        
            Log.Message("Se connecter avec LINCOA");
            Login(vServerAccounts, userNameLINCOA, passwordLINCOA, language);
            Get_MainWindow().Maximize();
        
            Log.Message("****************************************************l'étape 1********************************************");     
            Log.Message("Aller au module 'Client'");
            Get_ModulesBar_BtnClients().Click();
            Get_ClientsGrid_ChName().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","MenuItem_c549");
    
            Log.Message("Dans le module Clients , ajouter les colonnes suivantes: ");
            Log.Message("Add the column Telephone1");
            AddColumn(Get_ClientsGrid_ChIACode(),Get_ClientsGrid_ChTelephone1(),nameColumnTel+"1");
            Log.Message("Add the column Telephone2");
            AddColumn(Get_ClientsGrid_ChIACode(),Get_ClientsGrid_ChTelephone2(),nameColumnTel+"2");
            Log.Message("Add the column Telephone3");
            AddColumn(Get_ClientsGrid_ChIACode(),Get_ClientsGrid_ChTelephone3(),nameColumnTel+"3");
            Log.Message("Add the column Telephone4");
            AddColumn(Get_ClientsGrid_ChIACode(),Get_ClientsGrid_ChTelephone4(),nameColumnTel+"4"); 
            Log.Message("Add the column Email1");       
            AddColumn(Get_ClientsGrid_ChIACode(),Get_ClientsGrid_ChEmail1(),nameColumnEmail+"1");
            Log.Message("Add the column Email2");  
            AddColumn(Get_ClientsGrid_ChIACode(),Get_ClientsGrid_ChEmail2(),nameColumnEmail+"2");
            Log.Message("Add the column Email3");  
            AddColumn(Get_ClientsGrid_ChIACode(),Get_ClientsGrid_ChEmail3(),nameColumnEmail+"3");
             
            Log.Message("Check if the column 'Telephone1' is sortable");          
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone1()));       
            Log.Message("Check if the column 'Telephone2' is sortable");     
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone2()));        
            Log.Message("Check if the column 'Telephone3' is sortable"); 
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone3()));       
            Log.Message("Check if the column 'Telephone4' is sortable");
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone4()));   
            Log.Message("Check if the column 'Email1' is sortable");
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChEmail1()));       
            Log.Message("Check if the column 'Email2' is sortable");
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChEmail2()));       
            Log.Message("Check if the column 'Email3' is sortable");
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChEmail3()));
        
        
            Log.Message("****************************************************l'étape 2 ********************************************");
            Log.Message("Aller dans le module Comptes");
            Get_ModulesBar_BtnAccounts().Click();
            Get_AccountsGrid_ChName().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","MenuItem_c549");
        
            Log.Message("Ajouter les colonnes suivantes: ");
            Log.Message("Add the column Telephone1");
            AddColumn(Get_AccountsGrid_ChIACode(),Get_AccountsGrid_ChTelephone1(),nameColumnTel+"1");
            Log.Message("Add the column Telephone2");
            AddColumn(Get_AccountsGrid_ChIACode(),Get_AccountsGrid_ChTelephone1(),nameColumnTel+"2");        
            Log.Message("Check if the column 'Telephone1' is sortable");          
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChTelephone1()));              
            Log.Message("Check if the column 'Telephone2' is sortable");          
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChTelephone2()));

  
            Log.Message("****************************************************l'étape 3 ********************************************");
            Log.Message("Aller dans le module relations");
            Get_ModulesBar_BtnRelationships().Click();
            Get_RelationshipsGrid_ChName().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","MenuItem_c549");
       
            Log.Message("Ajouter les colonnes suivantes: ");
            Log.Message("Add the column Email1");
            AddColumn(Get_RelationshipsGrid_ChName(),Get_RelationshipsGrid_ChEmail1(),nameColumnEmail+"1");
            Log.Message("Add the column Email2");
            AddColumn(Get_RelationshipsGrid_ChName(),Get_RelationshipsGrid_ChEmail2(),nameColumnEmail+"2");
            Log.Message("Add the column Email3");
            AddColumn(Get_RelationshipsGrid_ChName(),Get_RelationshipsGrid_ChEmail3(),nameColumnEmail+"3");
       
       
            Log.Message("Check if the column 'Email1' is sortable");          
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChEmail1()));               
            Log.Message("Check if the column 'Email2' is sortable");          
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChEmail2()));        
            Log.Message("Check if the column 'Email3' is sortable");          
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChEmail3()));


            Log.Message("****************************************************l'étape 4 ********************************************");
            Terminate_CroesusProcess();
            Activate_Inactivate_PrefFirm("Firm_1", "PREF_TOGGLE_ENCRYPT_FEATURES", "YES", vServerAccounts);//SA : Changement du nom de la préférence PREF_ENABLE_ENCRYPTION à PREF_TOGGLE_ENCRYPT_FEATURES: CRM-3787
            RestartServices(vServerAccounts);
      
            Log.Message("Se connecter avec LINCOA");
            Login(vServerAccounts, userNameLINCOA, passwordLINCOA, language);
            Get_MainWindow().Maximize();
      
            Log.Message("Aller au module 'Client'");
            Get_ModulesBar_BtnClients().Click();
      
            Log.Message("Check if the column 'Telephone1' is sortable");          
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone1()));        
            Log.Message("Check if the column 'Telephone2' is sortable");     
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone2()));       
            Log.Message("Check if the column 'Telephone3' is sortable"); 
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone3()));       
            Log.Message("Check if the column 'Telephone4' is sortable");
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_ClientsGrid_ChTelephone4()));        
            Log.Message("Check if the column 'Email1' is sortable");
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_ClientsGrid_ChEmail1()));        
            Log.Message("Check if the column 'Email2' is sortable");
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_ClientsGrid_ChEmail2()));       
            Log.Message("Check if the column 'Email3' is sortable");
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_ClientsGrid_ChEmail3()));
            
            //Après la discussion avec Karima, on va valider seulement les colonnes ajoutées aux étapes 1-3.Les colonnes qu'ont été triables avant l'activation de pref
            /*Log.Message("Toutes les colonnes sont triables:seulement les colonnes par défaut ont été validées ");
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChName()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChClientNo()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChIACode()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChBalance()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChCurrency()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChMargin()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChLastContact()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChAge()));
            CheckSorting(CheckIfTheColumnSortable(Get_ClientsGrid_ChTotalValue()));*/
        
            Log.Message("****************************************************l'étape 5 ********************************************");
            Log.Message("Aller dans le module Comptes");
            Get_ModulesBar_BtnAccounts().Click();      
            Log.Message("Check if the column 'Telephone1' is sortable");          
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_AccountsGrid_ChTelephone1()));               
            Log.Message("Check if the column 'Telephone2' is sortable");          
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_AccountsGrid_ChTelephone2()));
            
            //Après la discussion avec Karima, on va valider seulement les colonnes ajoutées aux étapes 1-3.Les colonnes qu'ont été triables avant l'activation de pref 
            /*Log.Message("Toutes les colonnes sont triables:seulement les colonnes par défaut ont été validées ");
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChAccountNo()));
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChName()));
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChIACode()));
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChType()));
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChPlan()));
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChBalance()));
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChCurrency()));
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_AccountsGrid_ChMargin())); //la colonne n'est pas triable 
            CheckSorting(CheckIfTheColumnSortable(Get_AccountsGrid_ChTotalValue()));*/
      
 
            Log.Message("****************************************************l'étape 6 ********************************************");
            Log.Message("Aller dans le module relations");
            Get_ModulesBar_BtnRelationships().Click();
     
            Log.Message("Check if the column 'Email1' is sortable");          
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChEmail1()));               
            Log.Message("Check if the column 'Email2' is sortable");          
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChEmail2()));        
            Log.Message("Check if the column 'Email3' is sortable");          
            CheckSortingApterActivatingPref(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChEmail3()));
            
            //Après la discussion avec Karima, on va valider seulement les colonnes ajoutées aux étapes 1-3.Les colonnes qu'ont été triables avant l'activation de pref 
            /*Log.Message("Toutes les colonnes sont triables:seulement les colonnes par défaut ont été validées ");
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChName()));
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChRelationshipNo()));
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChIACode()));
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChBalance()));
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChCurrency()));
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChMargin()));
            CheckSorting(CheckIfTheColumnSortable(Get_RelationshipsGrid_ChTotalValue()));*/            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("update b_firm set config_txt = '" + configTxt + "' where FIRM_ID=1", vServerAccounts);
        RestartServices(vServerAccounts);       
    }
}


function  AddColumn(columnToClickOn,columnToAdd,dataContextNameOfColumnToAdd){
  
    SetAutoTimeOut();
    if (!(columnToAdd.Exists)){
       Log.Message("Add column");
       columnToClickOn.ClickR();
       Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
       Get_CroesusApp().FindChild("DataContext.Name",dataContextNameOfColumnToAdd,10).Click();
    }else{
      Log.Message("The column is already present")
    }
    RestoreAutoTimeOut(); 
}

function CheckIfTheColumnSortable(columnToSort){
   var sort=false;
   columnToSort.Click();
   if(columnToSort.SortStatus=="Descending" || columnToSort.SortStatus=="Ascending" ){
       sort=true;  
   }
   return sort;
   Delay(50);
}

function CheckSorting(sort){
    if(sort){
      Log.Checkpoint("The column is sortable")
    }else{
      Log.Error("The column is not sortable")}
}

function CheckSortingApterActivatingPref(sort){
    if(sort){
      Log.Error("The column is sortable")
    }else{
      Log.Checkpoint("The column is not sortable")}
}

