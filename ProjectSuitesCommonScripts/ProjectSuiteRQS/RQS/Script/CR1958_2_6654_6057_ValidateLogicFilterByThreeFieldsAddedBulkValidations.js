//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA
//USEUNIT CR1958_2_6744_PredefinedSentencesNoteTransactionBlotterBulkValidate

/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6654
  
    Analyste d'assurance qualité: Carole Turcotte
    Analyste d'automatisation: Abdel Matmat
    Version de scriptage: ref90-12-Hf-109
    Date : 13-01-2020
**/

function CR1958_2_6654_6057_ValidateLogicFilterByThreeFieldsAddedBulkValidations()
{
   try {
         
               //Variables             
             
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
               
               var  waitTime = 5000;
               var CR1958_2_6655_ManualNote= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_ManualNote", language + client);
               var CR1958_2_6655_ReviewType= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_ReviewType", language + client);
               var CR1958_2_6655_QueryCategory= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_QueryCategory", language + client);
               var transactionBDate = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_transactionBDate", language + client); 
               var statusDateFrom = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_statusDateFrom", language + client); 
               var statusAll= ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6656_statusAll", language + client); 
               var CR1958_2_6655_NameStartWith=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6655_NameStartWith", language + client); 
               var CR1958_6655_Pourcentage=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_6655_Pourcentage", language + client); 
               var CR1958_6655_NotDataAvaible=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_6655_NotDataAvaible", language + client);
            
               var brancheName = "Toronto"               
               var noteText = "Toronto";
               var AllBranches = "All"
               var statusClosed = "Closed"
               
               
               
               transactionBlotterDate = aqConvert.StrToDate(transactionBDate);
               lastStatusDate = aqConvert.StrToDate(statusDateFrom);
               
            
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6654");
               
//Étape 1      
      /********************************************* Étape 1**************************************************************************************/
               Log.Message("L'étape 1 du cas de test Croes-6654 ")
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
               Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
               Get_Toolbar_BtnRQS().Click();
               var nbOfTries = 0;
               do {
                    Get_WinRQS_TabTransactionBlotter().Click();
               } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
               
              //Choisir Toronto dans le champ Current context
              Get_WinRQS_BtnTreeView().Click();
              WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
              
              if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Value",brancheName,10).Click();
                }
                WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
                
              //Désactiver tout les filtres appliqués s'ils existent              
                var nbActiveFilter = 0;
                if (Get_WinRQS_TabTransactionBlotter_ToggleItems().Exists)
                          nbActiveFilter = Get_WinRQS_TabTransactionBlotter_ToggleItems().DataContext.NbConditionInList;
                while(nbActiveFilter > 0){
                      if (Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).wState)
                          Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).set_IsChecked(false);
                      nbActiveFilter -= 1;
                }

              //Cliquer le bouton Bulk validate
              Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
              WaitObject(Get_CroesusApp(), "Uid", "Window_fff1", waitTime);
//              Get_WinTransactionReview().WaitProperty("VisibleOnScreen", true, waitTime);
              Get_WinTransactionReview_GrpNoteTextBox().Click();
              Get_WinTransactionReview_GrpNoteTextBox().SetText(noteText);
//              if(Get_WinTransactionReview_BtnBulkValidate().WaitProperty("Enabled", true, waitTime))
              
              Delay(2000)    
              Get_WinTransactionReview_BtnBulkValidate().Click();
                      
              var numberOfTries=0;  
              while (numberOfTries < 5 && Get_WinTransactionReview().Exists){
                  Get_WinTransactionReview_BtnBulkValidate().Click(); 
                  numberOfTries++;
              } 
                      
                     
              //Étape 2
               /********************************************* Étape 2 **************************************************************************************/
              //Enlever le Current context et remettre All
              Get_WinRQS_BtnTreeView().Click();
              WaitObject(Get_WinRQS(), "ClrClassName", "PopupRoot",1500);
              
              if(Get_SubMenus().Exists){
                        Get_SubMenus().Find("Content",AllBranches,10).Click();
                }
                WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);
              
              //Cliquer sur Query log
              Get_WinRQS_BtnQueryLog().Click();
              WaitObject(Get_CroesusApp(), "Uid", "QuerylogView_b490", waitTime);
              
              //Transaction Blotter Date From = '01/25/2010' et To = '01/25/2010'
              Get_WinQueryLog_GrpTransactionBlotterDate_DateFrom().Set_Value(transactionBlotterDate);
              Get_WinQueryLog_GrpTransactionBlotterDate_DateTo().Set_Value(transactionBlotterDate);     
              //Choisir Status = 'Closed'
              Get_WinQueryLog_GrpLastStatus_CmbStatus().Click();
              if(Get_SubMenus().Exists)
                  Get_SubMenus().Find("WPFControlText",statusClosed,10).Click();
              // Last status: From 01/25/2010 to : Today
              Get_WinQueryLog_GrpLastStatus_DateFrom().Set_Value(lastStatusDate);
              Log.Message("J'ai pas modifié la zone date To: parce que la date qui est par défaut c'est la date du jour");
              //Cliquer sur Generate
              Get_WinQueryLog_BtnGenerate().Click();
              //Cliquer sur Ok du petite fenêtre de pourcentage
              Get_DlgProgressCroesus_BtnOK().Click();
              
              //Point de vérification (Valider les colonnes "Status" et "Created by" dans le fichier excel
              
              
              
              
              
              
              //Étape 3
               /********************************************* Étape 3 **************************************************************************************/
              // Exécuter la requête (select * from dbo.B_RQS_BULK_VALIDATION where blotter_date between 'Jan 25 2010' and 'Jan 25 2010')
           
               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        Terminate_CroesusProcess();
        
      
        
    }
}

function Get_WinTransactionReview_BtnBulkValidate(){return Get_WinTransactionReview().FindChild("Uid", "Button_3f56", 10)}
function Get_DlgProgressCroesus_BtnOK(){return Get_DlgProgressCroesus().FindChild("Uid", "Button_5293", 10)}

function test(){
  Sys.HighlightObject(Get_WinTransactionReview_BtnBulkValidate())
}
