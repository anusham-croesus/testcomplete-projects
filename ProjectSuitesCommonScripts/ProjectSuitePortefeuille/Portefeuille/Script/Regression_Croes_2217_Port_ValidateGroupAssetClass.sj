//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Validation du bouton Grouper par classe d'actifs
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2217
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2217_Port_ValidateGroupAssetClass()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var testNumber = "2217-";
       var n= 0;
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2217","Lien testlink - Croes-2217");
       
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
        
        
      
       
          //Cliquer sur le bouton Grouper par classe d'actif
          Log.Message("*************Grouper par Classe d'actif************");
          Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
         
  
         //Verifier si le bouton INFO est non-disponible (grisé)
          Log.Message("*************Verifier que le bouton INFO est non-disponible (grisé)************");
          aqObject.CheckProperty(Get_PortfolioBar_BtnInfo(), "Enabled", cmpEqual, false);
          //Fermer la fenetre 
         
          
          
          //Vérifier que le bouton Solde Date Transaction affiche la fenêtre correctement lorsque le mode Groupé est actif
          Log.Message("************Vérifier que le bouton Solde Date Transaction affiche la fenêtre correctement lorsque le mode Grouper est actif************")
          Get_PortfolioBar_BtnTradeDateBalance().Click();
          aqObject.CheckProperty(Get_WinBalance(), "Visible", cmpEqual, true);
          //Fermer la fenetre 
          Get_WinBalance_BtnClose().Click();
            
          //Cliquer sur le bouton projection de liquidité et Valider que la projection de liquidité  s'affiche correctement
          Log.Message("*************Cliquer sur le bouton projection de liquidité et Valider que la projection de liquidité  s'affiche correctement*************");
          Get_PortfolioBar_BtnCashFlowProject().Click();   
          aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid(), "Visible", cmpEqual, true);
          
          
          //Cliquer sur le bouton projection de liquidité pour quitter la fenêtre projection de liquidité
          Get_PortfolioBar_BtnCashFlowProject().Click();
          
          //Cliquer sur le bouton Grouper par classe d'actif pour  revenir à la grille principale de portefeuilles
          Log.Message("*************Retour  à la grille principale de portefeuilles en cliquant sur le bouton grouper par classe d actif*************");
          Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
          Log.Message("*************Valider le retour a la grille principale du module portefeuilles*********")
          aqObject.CheckProperty(Get_Portfolio_PositionsGrid(), "Visible", cmpEqual, true);
              
     
        
         
        
        
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


      




