//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Impression des fenêtres dans le module Portefeuille 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2261
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2261_Port_PrintInfo()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var positionNORANDA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "positionNORANDA", language+client);positionNORANDA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "positionNORANDA", language+client);

       
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2261","Lien testlink - Croes-2261");
       
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
        
       
       //Selectionner la position et cliquer sur le bouton info  pour ouvrir la fenêter info de la position
         Log.Message("**************Selectionner la position"+positionNORANDA+" et cliquer sur le bouton info  pour ouvrir la fenêter info de la position*************");
         //Get_Portfolio_PositionsGrid().Find("Value",positionNORANDA ,10).Click();
         Search_Position(positionNORANDA);
         Get_PortfolioBar_BtnInfo().Click();
         
       //Dans le menu droit de la souris (right-click), sélectionner Imprimer
        Log.Message("*********Dans le menu droit de la souris (right-click), sélectionner Imprimer**********")
        Get_WinPositionInfo().ClickR();
        Get_Win_ContextualMenu_Print().Click();
          if(Get_DlgPrint().Exists)
          {
            Log.Checkpoint("Dialogue d'impression est présent.");
            Get_DlgPrint().Close();
          }
          else
            Log.Error("Dialogue d'impression est absent.");
  
  
          Get_WinPositionInfo().Close();
         
         
        
         
        
        
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


      




