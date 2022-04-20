//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT CR2160_Common_functions


/**
    Description : Valider Portefeuille sous-jacents sauvegardé en tant que compte fictif
    Le but de ce cas est de :

     Valider qu il est possible desauvegarder Portefeuille sous-jacents  en tant que compte fictif
        
    https://jira.croesus.com/browse/TCVE-1040
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Alhassane Diallo
    
   Version de scriptage:	2020.5-8
*/

function TCVE1040_UnderlyingPortfolioS_savedAs_FictiousAccount()
{
    try {
      
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/browse/TCVE-1040,") 
    
         
          //Variables                      
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
          
          var chMOYENTERME      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "CHMOYENTERME", language+client);
          var relationTest6     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "RelationTest6", language+client);
          var account300010NA   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "Account300010NA", language+client);
          var account300010OB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1039", "Account300010OB", language+client);
          
          var code_CP               = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1040", "CODE_CP", language+client);
          var accountFictifName     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1040", "ACCOUNT_FICTIFNAME", language+client);
          var validatMessage        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1040", "VALIDATEMESSAGE", language+client);
          var fictifAccountFilter   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1040", "FICTIFACCOUNTFILTER", language+client);
          var fictifAccountNum      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1040", "FICTIFACCOUNTNUM", language+client);
          
         
          
//Étape1
             Log.Message("**************************************Étape1*******************************************************************");

           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();  
           
                    
             
//Étape2
            
           Log.Message("**************************************Étape2*******************************************************************");           
           //Accéder au module modèle et associer a la relation Test6
           Log.Message("Accéder au module modèle et associer a la relation Test6");
           Get_ModulesBar_BtnModels().Click();
           Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
           AssociateRelationshipWithModel(chMOYENTERME, relationTest6);         
            
//Étape3

              
            Log.Message("**************************************Étape3*******************************************************************");
            
            //Mailler la relation dans le module portefeuille, cliquer sur simulation puis savegarder 
            Log.Message("***********Mailler la relation dans le module portefeuille, cliquer sur simulation puis savegarder ************"); 
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationTest6,10).Click();
            Drag(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationTest6,10), Get_ModulesBar_BtnPortfolio());            
            Get_PortfolioBar_BtnWhatIf().Click();
            Get_PortfolioBar_BtnSave().Click();
            
            
//Étape4 

            Log.Message("**************************************Étape4*******************************************************************"); 
            
            //Laisser l'option Nouveau compte fictif coché puis cliquer sur Sauvegarde détaillée
            Log.Message("***************Laisser l'option Nouveau compte fictif coché puis cliquer sur Sauvegarde détaillée***************");
            Get_WinWhatIfSave_BtnDetailedSave().Click();
            
              
//Étape5              
              
            Log.Message("**************************************Étape5*******************************************************************");
           
            //Donner un nom et un code cp au compte fictif (effacer le nom et le code cp si ils sont affichés par défaut)puis cliquer sur OK
            Log.Message("***Donner un nom et un code cp au compte fictif (effacer le nom et le code cp si ils sont affichés par défaut)puis cliquer sur OK***");
            Get_WinRelationshipInfo_TxtFullName().Clear();
            Get_WinRelationshipInfo_TxtFullName().Keys(accountFictifName);
            Get_WinRelationshipInfo_TxtShortName().Clear();
            Get_WinRelationshipInfo_TxtShortName().Keys(accountFictifName);
            Get_WinRelationshipInfo_TxtCPcode().Clear();
            Get_WinRelationshipInfo_TxtCPcode().Keys(code_CP);
            Get_WinRelationshipInfo_BtnOK().Click();
            
            
            
//Étape6
                
           Log.Message("**************************************Étape6*******************************************************************");
           
           //Valider la presence du texte Compte sauvegardeé sous "Compte sauvegardé sous ~F"
           Log.Message("******************Valider la presence du texte Compte sauvegardeé sous ~F******************");
           aqObject.CheckProperty(Get_DlgInformation_TextBlockMessage(), "Text", cmpStartsWith, validatMessage);
           Get_DlgInformation_BtnOK().Click();
           
//Étape7       
          

          Log.Message("**************************************Étape7*******************************************************************");
          
          
          //Revenir dans Comtes, faire un filtre rapide pour comptes fictifs et vérifier si le compte sauvegardé est présent parmi la liste
          Log.Message("Revenir dans Comtes, faire un filtre rapide pour comptes fictifs et vérifier si le compte sauvegardé est présent parmi la liste")
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_SubMenus().FindChild("WPFControlText", fictifAccountFilter, 10).Click();
          
          var grid = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1);
          var count = grid.Items.Count;
              
                         for (i=0; i<count; i++){
                             if (grid.Items.Item(i).DataItem.FullName == accountFictifName)
                                {
                                     Log.Message("le compte sauvegardé est présent parmi la liste des comptes fictifs")
                                     aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AccountNumber",cmpEqual,fictifAccountNum)
                                } 
                             else{
                                    Log.Message("le compte sauvegardé n'est pas présent parmi la liste des comptes fictifs")
                                    Log.Error("Exception :  Compte non sauvegardé ");
                                 }
                           }
                    
         
              
   }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
		    
    
         //Restart Data
         
         //Supprimer le compte fictif créé
         Log.Message("Supprimer le compte fictif créé");
         Get_RelationshipsClientsAccountsGrid().Find("Text",fictifAccountNum,10).Click();
         Get_Toolbar_BtnDelete().Click();
         Get_DlgConfirmation_BtnYes().Click();
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
         //Retirer la relation du modele 
         Log.Message("Retirer la relation du modele")
         RemoveRelationshipFromModel(chMOYENTERME,relationTest6)
         aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
         
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}
 

  
function Get_WinRelationshipInfo_TxtFullName(){return Get_WinRelationshipInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}          
function Get_WinRelationshipInfo_TxtShortName(){return Get_WinRelationshipInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 2], 10)} 
function Get_WinRelationshipInfo_TxtCPcode(){return Get_WinRelationshipInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 3], 10)} 
function Get_WinRelationshipInfo_BtnOK(){return Get_WinRelationshipInfo().Find(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)} 
function Get_DlgInformation_TextBlockMessage(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

