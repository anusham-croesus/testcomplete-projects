//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Ce script regroupe les cas de test Croes_2232, Croes_2233,Croes_2234 et Croes_2235
     Valider l'impression du brouillon de travail par different methode(, Alt+p,  Menu fichier,  Icone imprimer, Clique droit)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2232
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2233
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2234
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2235
    
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2232_a_Croes_2235_Port_Print()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var positionNORANDA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "positionNORANDA", language+client);positionNORANDA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "positionNORANDA", language+client);

       
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2232","Lien testlink - Croes-2232");       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2233","Lien testlink - Croes-2233");     
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2234","Lien testlink - Croes-2234");    
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2235","Lien testlink - Croes-2235");
       
       
       
       
       
       
        //Login
        Log.Message("******************** Login *******************");
        Login(vServerPortefeuille, userName, psw, language);
        
        
        //Sélectionner le client 300001 et mailler vers module portefeuille
        Log.Message("*********Sélectionner le client "+client300001+" et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client300001);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client300001,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
        //Validation de l'impression avec ALT + P
         Log.Message("********Validation de l'impression avec ALT + P (Croes_2232)***********")
        
        
        //Ne pas sélectionner de positions (aucun item de sélectionné ou en bleu) et faire ALT + P
         Log.Message("********Ne pas sélectionner de positions (aucun item de sélectionné ou en bleu) et faire ALT + P***********")  
         Get_Portfolio_PositionsGrid().Keys("~p");
         Validate_Presence_WinPrint()
          
             
         //Selectionner plusieur positions et  faire ALT + P
         Log.Message("********Selectionner plusieur positions et  faire ALT + P***********");
         Get_Portfolio_PositionsGrid().Keys("![Down]![Down]![Down]![Down]![Down]~p");
         //Valider la presence de la fenêtre d'impression
         Validate_Presence_WinPrint()
         
          
        //Validation de l'impression avec l'option menu Fichier - Imprimer
         Log.Message("********Validation de l'impression avec l'option menu Fichier - Imprimer (Croes_2233)***********")      
         
         
         //Ne pas sélectionner de positions (aucun item de sélectionné ou en bleu) et cliquer sur le menu Fichier - Imprimer 
         Log.Message("********Ne pas sélectionner de positions (aucun item de sélectionné ou en bleu) et cliquer sur le menu Fichier - Imprimer***********");      
         Get_MenuBar_File().Click();
         Get_MenuBar_File_Print().Click();
         //Valider la presence de la fenêtre d'impression
         Validate_Presence_WinPrint()
         
         //sélectionner plusieurs  positions et cliquer sur le menu Fichier - Imprimer 
         Log.Message("********sélectionner plusieurs  positions et cliquer sur le menu Fichier - Imprimer***********");      
         //Get_MenuBar_File().Click();
         Get_Portfolio_PositionsGrid().Keys("![Down]![Down]![Down]![Down]![Down]");
         Get_MenuBar_File().Click();
         Get_MenuBar_File_Print().Click();
         //Valider la presence de la fenêtre d'impression
         Validate_Presence_WinPrint()
         
         
         
         //Validation de l'impression avec l'option Icône Impression
         Log.Message("********Validation de l'impression avec l'option Icône Impression (Croes_2234)***********")      
         
         
         //Ne pas sélectionner de positions (aucun item de sélectionné ou en bleu) et cliquer sur l'Icône Impression
         Log.Message("********Ne pas sélectionner de positions (aucun item de sélectionné ou en bleu) et cliquer sur l'Icône Impression**********");      
         Get_Toolbar_BtnPrint().Click();
         //Valider la presence de la fenêtre d'impression
         Validate_Presence_WinPrint()
         
         //sélectionner plusieurs  positions et cliquer sur cliquer sur l'Icône Impression 
         Log.Message("********sélectionner plusieurs  positions et cliquer sur cliquer sur l'Icône Impression***********");      
//       Get_MenuBar_File().Click();
         Get_Portfolio_PositionsGrid().Keys("![Down]![Down]![Down]![Down]![Down]");
         Get_Toolbar_BtnPrint().Click();
         //Valider la presence de la fenêtre d'impression
         Validate_Presence_WinPrint()
         
         
         //Validation de l'impression avec l'option Clique droit
         Log.Message("********Validation de l'impression avec l'option Clique droit (Croes_2235)***********")      
         
         
         
         //sélectionner plusieurs  positions et faire un cliquer droit sur la selectin + Imprimer 
         Log.Message("********sélectionner plusieurs  positions et faire un cliquer droit sur la selectin + Imprimer***********");       
         Get_Portfolio_PositionsGrid().Keys("[Down]![PageDown]");
         Get_Portfolio_PositionsGrid().ClickR();
         Get_PortfolioGrid_ContextualMenu_Print().Click();
         //Valider la presence de la fenêtre d'impression
         Validate_Presence_WinPrint()
         
         
         
         
         
        
        //Fermer Croesus
          Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}


    function Validate_Presence_WinPrint(){
        
    if(Get_DlgPrint().Exists)
         {
        Log.Checkpoint("Dialogue d'impression est présent.");
        Get_DlgPrint().Close();
        Get_DlgInformation_BtnOK().Click();
       }
       else
        Log.Error("Dialogue d'impression est absent.");
        
    
    }

function test(){
    
 //sélectionner plusieurs  positions et cliquer sur cliquer sur l'Icône Impression 
         Log.Message("********sélectionner plusieurs  positions et cliquer sur cliquer sur l'Icône Impression***********");      
         //Get_MenuBar_File().Click();
         Get_Portfolio_PositionsGrid().Keys("![Down]![Down]![Down]![Down]![Down]");
         Get_Toolbar_BtnPrint().Click();



}