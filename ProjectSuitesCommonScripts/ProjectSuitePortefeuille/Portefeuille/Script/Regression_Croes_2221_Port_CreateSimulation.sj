//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Création d'une simulation à partir d'un compte réel 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2221
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2221_Port_CreateSimulation()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var nomCompte_2221 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "nomCompte_2221", language+client);
       var validation_2221 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "validation_2221", language+client);
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2221","Lien testlink - Croes-2221");
       
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
        
      
          //cliquer sur le bouton simulation puis le bouton annuler et confirmer par le bouton non
          Log.Message("***********Simuler la creation d'un compte fictif ou d'un modèle et annuler***********")
          Get_PortfolioBar_BtnWhatIf().Click();
          Get_PortfolioBar_BtnCancel().Click();
          Get_DlgConfirmation_BtnYes().Click();
          width = Get_DlgConfirmation().Width;
          height = Get_DlgConfirmation().Height;
          Get_DlgConfirmation().Click((width*(1/2)),height-45);
          //Get_DlgConfirmation().Click((width*(1/2)),73);
            
          
          //Creation d'un compte fictif via une simulation 
          Log.Message("**************Creation d'un compte fictif via une simulation********************")
          Get_PortfolioBar_BtnWhatIf().Click();
          Get_PortfolioBar_BtnSave().Click();
          Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Click();
          Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(nomCompte_2221);
          Get_WinWhatIfSave_BtnOK().Click();
         
          //Valider la presence du texte Compte sauvegardeé sous
          Log.Message("***************************Valider la presence du texte // Compte sauvegardeé sous//*****************************");
          
          aqObject.CheckProperty(Get_DlgInformation_LblMessageV(), "Text", cmpStartsWith, validation_2221);
          Get_DlgInformation_BtnOK().Click();
          
          //Suprimer le compte fictif ajouté
          Log.message("***********************Suprimer le compte fictif ajouté******************************");
          Get_ModulesBar_BtnClients().Click();
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          SearchClientByName(nomCompte_2221);
          
          
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", nomCompte_2221, 10).Click();
          Get_Toolbar_BtnDelete().Click();
          Get_DlgConfirmation_BtnRemove().Click();
          
     
        
          

        
        
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



    

function Get_DlgInformation_LblMessageV(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} 

function test(){
    var nomCompte_2221 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "nomCompte_2221", language+client);
    var validation_2221 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "validation_2221", language+client);
          //Creation d'un compte fictif via une simulation 
          Log.Message("**************Creation d'un compte fictif via une simulation********************")
          Get_PortfolioBar_BtnWhatIf().Click();
          Get_PortfolioBar_BtnSave().Click();
          Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Click();
          Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(nomCompte_2221);
          Get_WinWhatIfSave_BtnOK().Click();
         
          //Valider la presence du texte Compte sauvegardeé sous
          Log.Message("***************************Valider la presence du texte // Compte sauvegardeé sous//*****************************");
          
          aqObject.CheckProperty(Get_DlgInformation_LblMessageV(), "Text", cmpStartsWith, validation_2221);
}