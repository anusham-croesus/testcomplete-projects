//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT Common_function_TCVE1961


/**
   https://jira.croesus.com/browse/TCVE-2961
    
   
    Description : Valider la sauvegarde de la selection dans le menu Utilisateur dans les differents environnements (interne, nfr et  staging)
           
    Auteur : Karima Mehinguene
    Analyste auto : Alhassane Diallo
    
    Version : 90.24.2021.04-3
    
    Date: 03/03/2021
*/

function TCVE_2961_Validate_Saving_The_Selection_In_The_User_Menu()
{
  try{
    

    Log.Link("https://jira.croesus.com/browse/TCVE-2961", "TCVE-2961");
    
/*********************************************Variables*******************************************************************************************/
     var userName               = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
     var password               = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
     var userDESLAUJE           = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "username");
     var pswDESLAUJE            = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJEstaging", "psw");

     var critereName            = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "CRITERE_NAME_COPERNIC", language+client);
     var critereNameNFR         = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "CRITERE_NAME_DESLAUJE", language+client);
     var filterName_1           = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "FILTER_NAME_1", language+client);
    
     var TotalValueTab          = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "TOTAL_VALUE_TAB", language+client);
     var RelationName           = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "RELATION_NAME_2961", language+client);
     var note2961               = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "NOTE_2961", language+client);
     var clientFictifName       = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "CLIENT_FICTIF_2961", language+client);
   
     var typePicker             = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "TYPE_PICKER", language+client);
     var positionDIS            = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "POSITION_DIS", language+client);
     var targetValueDIS         = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "TARGER_DIS", language+client);
     var NFRfilterAccountFictif = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "NFR_CLIENT_FICTIF_FILTER", language+client);
     var filterAccountFictif    = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "INTERN_CLIENT_FICTIF_FILTER", language+client);

     var TitleWin               = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "TILTE_WINDOW", language+client);
     var TitleWinCopern         = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "TILTE_WINDOW_COPERN", language+client);
     var TotalValue             = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "TOTAL_VALUE", language+client);
     var DeslaujeGPF            = ReadDataFromExcelByRowIDColumnID(filePath_SmokeTestStaging, "TCVE2961", "DESLAUJE_GPF", language+client);
    

     
     
/***************************************************Appelle de la fonction ******************************************************************/
      //Se connecter avec sysadmin( keynej, deslauje) Dans le module Dashboard , Cocher enregistrer la selection puis Cliquer sur sélection et Cliquer sur Rechercher par nom : Taper Copernic et appliquer
      Log.PopLogFolder();
      logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec sysadmin( keynej, deslauje) Dans le module Dashboard , Cocher enregistrer la selection puis Cliquer sur sélection et Cliquer sur Rechercher par nom : Taper Copernic et appliquer");

      //La solution temporaire YR
      if(StrContains("nfr", vServerSmokeTest, false)){
      
            Login_TCVE2961(vServerSmokeTest, userDESLAUJE, password, language);//http://nfrtestqa1.croesus.local/
            Validate_Saving_The_Selection_In_The_User_Menu(critereNameNFR, filterName_1, DeslaujeGPF, TitleWin, TotalValueTab, TotalValue, RelationName, note2961, clientFictifName, typePicker, positionDIS, targetValueDIS, NFRfilterAccountFictif);
       }
       else if(StrContains("staging", vServerSmokeTest, false)){
           
         Login_TCVE2961(vServerSmokeTest, userDESLAUJE, pswDESLAUJE, language);//https://fbnstaging.accessproxy.croesus.local/
         Validate_Saving_The_Selection_In_The_User_Menu(critereNameNFR, filterName_1, DeslaujeGPF, TitleWin, TotalValueTab, TotalValue, RelationName, note2961, clientFictifName, typePicker, positionDIS, targetValueDIS, NFRfilterAccountFictif);
  
       }
       else{
            Login_TCVE2961(vServerSmokeTest, userName, psw, language);
            Validate_Saving_The_Selection_In_The_User_Menu(critereName, filterName_1, critereName, TitleWinCopern, TotalValueTab, TotalValue, RelationName, note2961, clientFictifName, typePicker, positionDIS, targetValueDIS, filterAccountFictif);
      }
      
     
      
      
      //La solution temporaire YR
      if(StrContains("nfr", vServerSmokeTest, false)){
          
         Login_TCVE2961(vServerSmokeTest, userDESLAUJE, password, language);//http://nfrtestqa1.croesus.local/
         Validate_Saving_The_Selection_In_The_User_Menu_AfterReconnexion(critereNameNFR)
       }
       else if(StrContains("staging", vServerSmokeTest, false)){
           
           Login_TCVE2961(vServerSmokeTest, userDESLAUJE, pswDESLAUJE, language);//https://fbnstaging.accessproxy.croesus.local/
           Validate_Saving_The_Selection_In_The_User_Menu_AfterReconnexion(critereNameNFR)
       }
       else{
            Login_TCVE2961(vServerSmokeTest, userName, psw, language);
            Validate_Saving_The_Selection_In_The_User_Menu_AfterReconnexion(critereName)
       }
      
       
      
      }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
      //Restaurer les données
        Log.PopLogFolder();
        logEtap12 = Log.AppendFolder("Étape 12: Restaurer les données");  
        deleteFilter(filterName_1)
        deleteFilterAndFictifAccount();
        DeleteClient_TCVE2961()
        DeleteRelationship_TCVE2961(RelationName);
        deleteCriteria();
        
        
        //Terminer le procesus
        Terminate_CroesusProcess();
        Terminate_IEProcess();  
    
          
      }        
} 

