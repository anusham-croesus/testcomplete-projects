//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6651
  
    Analyste de l'équipe test auto :Ayaz Sana
    Analyste d'automatisation:Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
**/

function CR1958_2_6651_ValidtAddDeletCopyVisiblPredefinedSentences()
{
   try {
      
               //Variables             
               var TextAddNameSentenceCROES6651 =ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "TextAddNameSentenceCROES6651", language + client);               
               var TextAddSentenceCROES6651 =ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "TextAddSentenceCROES6651", language + client);
               var createdBySentPrefedCROES6651=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "createdBySentPrefedCROES6651", language+client);
               var TextAddSentenceModifCROES6651=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "TextAddSentenceModifCROES6651", language+client);
               var TextAddNameSentenceCopyCROES6651=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "TextAddNameSentenceCopyCROES6651", language+client);
               var TextAddNameSentenceDarwicCROES6651=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "TextAddNameSentenceDarwicCROES6651", language+client);
               var TextAddSentenceDarwicCROES6651=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "TextAddSentenceDarwicCROES6651", language+client);
               var createdBySentPrefedDarwicCROES6651=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "createdBySentPrefedDarwicCROES6651", language+client);
               //Les variables pour le login
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
               var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
               var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
               
            
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6651");
               
      //Étape 1      
      /********************************************* Étape 1**************************************************************************************/
             Log.Message("L'étape 1 du cas de test Croes-6651 ")
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
               Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
               Get_Toolbar_BtnRQS().Click();
               var nbOfTries = 0;
               do {
                    Get_WinRQS_TabTransactionBlotter().Click();
               } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
               
               Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
               Get_WinBulkValidation_BtnAddPredefinedSentences().Click();
               //Ajout d'une phrase prédéfinie
               Get_WinAddNewSentence_TxtName().Click()
               Get_WinAddNewSentence_TxtName().set_Text(TextAddNameSentenceCROES6651);
               Get_WinAddNewSentence_TxtSentence().set_Text(TextAddSentenceCROES6651);
               Get_WinAddNewSentence_TxtName().Click()
               Get_WinAddNewSentence_BtnSave().WaitProperty("IsEnabled", true, 30000); 
               Get_WinAddNewSentence_BtnSave().Click();
               WaitUntilObjectDisappears(Get_CroesusApp(), "Uid","PredefSentenceSaveWindow_1986" );
      
               //Les points de vérifications
               var displaySenPredefCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCROES6651, 10)//.WPFControlText
               if(displaySenPredefCROES6651.Exists && displaySenPredefCROES6651.VisibleOnScreen)
               {
                 var textDisplaySenPredefCROES6651=displaySenPredefCROES6651.WPFControlText;
                 Log.Message(textDisplaySenPredefCROES6651)
                 CheckEquals(textDisplaySenPredefCROES6651,TextAddNameSentenceCROES6651,"Le nom de la phrase prédéfinie ");
                 var index =displaySenPredefCROES6651.Record.index
                 var displayCreatedByCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue

                 CheckEquals(displayCreatedByCROES6651,createdBySentPrefedCROES6651,"Créée par est ")
               }
               else 
               {
                 Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
               }
         
               //La fermeture de la fenêtre Bluk validation
               Get_WinBulkValidation_BtnClose().Click();
       
                     
      //Étape 2      
      /********************************************* Étape 2**************************************************************************************/
               Log.Message("L'étape 2 du cas de test Croes-6651 ")
               //Cliquer sur le bouton Bulk validate et sélectionner la Sentence 1 créée à l'étape 1
               
              Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
              Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCROES6651, 10).Click();
              //cliquer sur Edit 
              Get_WinBulkValidation_BtnEditPredefinedSentences().Click();
              //Modifer le contenu de Sentence  pour : régression CR1958 modifié 
              Get_WinAddNewSentence_TxtSentence().Click()
              Get_WinAddNewSentence_TxtSentence().set_Text(TextAddSentenceModifCROES6651);
              Get_WinAddNewSentence_BtnSave().WaitProperty("IsEnabled", true, 30000); 
              Get_WinAddNewSentence_BtnSave().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid","PredefSentenceSaveWindow_1986" );
            
               //Les points de vérifications: Ouvrir la fenêtre Edit sentence et vérifier dans le champ texte Sentence qu'on a : régression CR1958 modifié 
               Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCROES6651, 10).Click();
              //cliquer sur Edit 
              Get_WinBulkValidation_BtnEditPredefinedSentences().Click();
              aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "IsVisible", cmpEqual, true);
              aqObject.CheckProperty(Get_WinEditSentence_TxtSentence(), "Text", cmpEqual, TextAddSentenceModifCROES6651);
              //Save --> Close
              Get_WinEditSentence_BtnSave().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid","PredefSentenceSaveWindow_1986" );
              Get_WinBulkValidation_BtnClose().Click();
              
      //Étape 3      
      /********************************************* Étape 3**************************************************************************************/
              Log.Message("L'étape 3 du cas de test Croes-6651 ")
              //Cliquer sur le bouton Bulk validate et sélectionner la Sentence 1 créée à l'étape 1
               
              Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
              //Cliquer sur le bouton Bulk validate et sélectionner la sentence créée de l'étape 1
              Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCROES6651, 10).Click();
              //cliquer sur Copy
              Get_WinBulkValidation_BtnCopyPredefinedSentences().Click();
              //Modifer le name  pour : Sentence 2  -->  Save 
              Get_WinAddNewSentence_TxtName().Click();
              Get_WinAddNewSentence_TxtName().set_Text(TextAddNameSentenceCopyCROES6651);
              Get_WinEditSentence_BtnSave().Click();
              //Les points de vérifications:La sentence  2 est copiée
              var displaySenPredefCopyCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCopyCROES6651, 10)
              if(displaySenPredefCopyCROES6651.Exists && displaySenPredefCopyCROES6651.VisibleOnScreen)
               {
                 var textDisplaySenPredefCopyCROES6651=displaySenPredefCopyCROES6651.WPFControlText;
                 Log.Message(textDisplaySenPredefCopyCROES6651)
                 CheckEquals(textDisplaySenPredefCopyCROES6651,TextAddNameSentenceCopyCROES6651,"Le nom de la phrase prédéfinie copié");
                 var index =displaySenPredefCopyCROES6651.Record.index
                 var displayCreatedByCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue

                 CheckEquals(displayCreatedByCROES6651,createdBySentPrefedCROES6651,"Créée par est ")
               }
              else 
               {
                 Log.Error("La phrase prédéfinie copiée précédemment n'existe pas parmi la liste des phrases prédéfinies")
               } 

      //Étape 4      
      /********************************************* Étape 4**************************************************************************************/
              Log.Message("L'étape 4 du cas de test Croes-6651 ") 
              //Sélectionner la Sentence 1 et cliquer sur Delete
              Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCROES6651, 10).Click();      
              Get_WinBulkValidatione_BtnDeletePredefinedSentences().Click();
              //répondre Delete 
              Get_DlgConfirmation_BtnDelete().Click();
              //Les points de vérifications:La Sentence1 est détruite
              var displaySenPredefCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCROES6651, 10)//.WPFControlText
              if(displaySenPredefCROES6651.Exists && displaySenPredefCROES6651.VisibleOnScreen)
               {
                 
               Log.Error("La phrase prédéfinie dont le nom est Sentence1 n'est pas supprimé")
                
               }
              else 
               {
               Log.Checkpoint("La phrase prédéfinie dont le nom est Sentence1 est supprimé")
   
               }
               //après validation cliquer sur Close
               Get_WinBulkValidation_BtnClose().Click();
         //Étape 5      
      /********************************************* Étape 5**************************************************************************************/       
               Log.Message("L'étape 5 du cas de test Croes-6651 ") 
               //Se loguer avec Darwic
               Log.Message("******************** Login *******************");
               Login(vServerRQS, userDARWIC, pswdDARWIC, language);
               //Aller dans RQS
               Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
               Get_Toolbar_BtnRQS().Click();
               var nbOfTries = 0;
               do {
                    Get_WinRQS_TabTransactionBlotter().Click();
               } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
               //Cliquer sur le bouton Bulk validate.
               Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
               //Dans la section Predefined Sentences cliquer sur Add pour ajouter une phrase .
               Get_WinBulkValidation_BtnAddPredefinedSentences().Click();
               /*Ajout de la phrase prédéfinie:dans le name écrire:  Darwic 1 dans Sentence écrire : Darwic CR1958  Save */
               Get_WinAddNewSentence_TxtName().Click()
               Get_WinAddNewSentence_TxtName().set_Text(TextAddNameSentenceDarwicCROES6651);
               Get_WinAddNewSentence_TxtSentence().set_Text(TextAddSentenceDarwicCROES6651);
               Get_WinAddNewSentence_TxtName().Click()
               Get_WinAddNewSentence_BtnSave().WaitProperty("IsEnabled", true, 30000); 
               Get_WinAddNewSentence_BtnSave().Click();
               WaitUntilObjectDisappears(Get_CroesusApp(), "Uid","PredefSentenceSaveWindow_1986" );
              /*Les points de vérifications:Sous Predefined Sentences la Sentence 2 est visible les boutons Edit et Delete sont grisés
                la phrase Darwic 1 est ajoutée*/
               var displaySenPredefCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCopyCROES6651, 10)
               if(displaySenPredefCROES6651.Exists && displaySenPredefCROES6651.VisibleOnScreen)
                {
                  Log.Checkpoint("La phrase prédéfinie Sentence 2 est visible ")
                  Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceCopyCROES6651, 10).Click();
                  aqObject.CheckProperty(Get_WinBulkValidation_BtnEditPredefinedSentences(), "Enabled", cmpEqual, false);//
                  aqObject.CheckProperty(Get_WinBulkValidatione_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, false);
                }
               else 
               {
                  Log.Error("La phrase prédéfinie Sentence 2 n'est pas visible ")
               } 
                //la phrase Darwic 1 est ajoutée
               
               
                var displaySenPredefDarwicCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceDarwicCROES6651, 10)//.WPFControlText
               if(displaySenPredefDarwicCROES6651.Exists && displaySenPredefDarwicCROES6651.VisibleOnScreen)
               {
                 var textDisplaySenPredefCROES6651=displaySenPredefDarwicCROES6651.WPFControlText;
                 Log.Message(textDisplaySenPredefCROES6651)
                 CheckEquals(textDisplaySenPredefCROES6651,TextAddNameSentenceDarwicCROES6651,"Le nom de la phrase prédéfinie ");
                 var index =displaySenPredefDarwicCROES6651.Record.index
                 var displayCreatedByCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue

                 CheckEquals(displayCreatedByCROES6651,createdBySentPrefedDarwicCROES6651,"Créée par est ")
              
               }
               else 
               {
                 Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
               }
               
               Get_WinBulkValidation_BtnClose().Click();
               //Se déloguer de Darwic
               Close_Croesus_MenuBar();
      //Étape 6      
      /********************************************* Étape 6**************************************************************************************/       
               /*Avec keynej 
               Aller dans RQS  cliquer sur le bouton Bulk validate*/
               Log.Message("L'étape 6 du cas de test Croes-6651 ")
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
               Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
               Get_Toolbar_BtnRQS().Click();
               var nbOfTries = 0;
               do {
                    Get_WinRQS_TabTransactionBlotter().Click();
               } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
               //Cliquer sur le bouton Bulk validate.
               Get_WinRQS_TabTransactionBlotter_BtnBulkValidate().Click();
               /*La sentence Darwic 1 n'est pas visible*/
                 
                var displaySenPredefDarwicCROES6651=Get_WinBulkValidation_DgvPredefinedSentences().FindChild("Value",TextAddNameSentenceDarwicCROES6651, 10)//.WPFControlText
               if(displaySenPredefDarwicCROES6651.Exists && displaySenPredefDarwicCROES6651.VisibleOnScreen)
               {
                 Log.Error("La phrase prédéfinie ajoutée précédemment existe parmi la liste des phrases prédéfinies")
               }
               else 
               {
                 Log.Checkpoint("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
               }
             

    }
    catch(e) {
        
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Initialiser la BD
        Terminate_CroesusProcess
        Delete_PredefinedSentences(TextAddNameSentenceCopyCROES6651, vServerRQS)
        Delete_PredefinedSentences(TextAddNameSentenceDarwicCROES6651, vServerRQS)
        Delete_PredefinedSentences("", vServerRQS)
        Delete_PredefinedSentencesGRD(vServerRQS)

         
        
        
    }
    finally {
    
        Terminate_CroesusProcess();
         //Initialiser la BD
        Delete_PredefinedSentences(TextAddNameSentenceCopyCROES6651, vServerRQS)
        Delete_PredefinedSentences(TextAddNameSentenceDarwicCROES6651, vServerRQS)
        Delete_PredefinedSentences("", vServerRQS)
        Delete_PredefinedSentencesGRD(vServerRQS)
         
        
    }
}
