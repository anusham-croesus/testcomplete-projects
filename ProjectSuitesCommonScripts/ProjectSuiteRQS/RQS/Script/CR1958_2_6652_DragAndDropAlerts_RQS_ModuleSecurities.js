//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6652
  
    Analyste de l'équipe test auto :Ayaz Sana
    Analyste d'automatisation:Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
**/

function CR1958_2_6652_DragAndDropAlerts_RQS_ModuleSecurities()
{
   try {
      
               //Variables             
               var filtreTestCROES6652 =ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "filtreTestCROES6652", language + client);               
               var valueFiltreTestDepositAndTransferInCROES6652 =ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "valueFiltreTestDepositAndTransferInCROES6652", language + client);
               var account300012NA=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "account300012NA", language + client);
               var security059960CROES6652=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "security059960CROES6652", language + client);
               var security359131CROES6652=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "security359131CROES6652", language + client);
               var valueFiltreTestManualCROES6652=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "valueFiltreTestManualCROES6652", language + client);
               var clientRelnumber9999999=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "clientRelnumber9999999", language + client);
               var nameClient8000273=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "nameClient8000273", language + client);
               var security538579CROES6652=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "security538579CROES6652", language + client);
               var valueFiltreTestChangeOfIACodeCROES665=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "valueFiltreTestChangeOfIACodeCROES665", language + client);
               var numberClient8000229=ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "numberClient8000229", language + client);
               var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\RQS\\"+language+"\\";
               var ExpectedFile_Cr1958_2Croes665 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Cr1958_2Croes6652", language+client);
               var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\RQS\\"+language+"\\";
               
               //Les variables pour le login
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
            
               //Lien Testlink
              Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6652");
               
      //Étape 1      
      /********************************************* Étape 1**************************************************************************************/
               Log.Message("*********************************************L'étape 1 du cas de test Croes-6652*******************************************")
               //Se connecter avec Keynej
               Log.Message("******************** Login *******************");
               Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
               
               Get_Toolbar_BtnRQS().WaitProperty("IsEnabled", true, 30000);
               Get_Toolbar_BtnRQS().Click();
               var nbOfTries = 0;
               do {
                    Get_WinRQS_TabTransactionBlotter().Click();
               } while (++nbOfTries < 3 && !Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, 40000))
                Get_WinRQS_TabAlerts().Click();
                var nbOfTries = 0;
               do {
                    Get_WinRQS_TabAlerts().Click();
               } while (++nbOfTries < 3 && !Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, 40000))        
              Get_WinRQS().Parent.Maximize();
            //Faire un filtre sur le champ Test = Deposit an Transfer In --> Apply
              Get_WinRQS_QuickFilterClick();
           
              Get_SubMenus().FindChild("WPFControlText", filtreTestCROES6652, 10).Click();
          		Get_WinCreateFilter_DgvValue().Find("Value", valueFiltreTestDepositAndTransferInCROES6652, 10).Click();
          		Log.Message("click on the apply button");
          		Get_WinCreateFilter_BtnApply().Click();
              
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", 5000); //Ajouté par A.A
              
              //Faire une recherche sur le Account no = 300012-NA.         
              Log.Message("Click on the keyboard to activate the quick search");                
          		Get_WinRQS_TabAlerts_DgvAlerts().Keys("h");
          		Get_WinQuickSearch_TxtSearch().SetText(account300012NA);
          		Get_WinRWS_QuickSearch().WPFObject("FieldSelector").WPFObject("ListBoxItem", "", 1).WPFObject("RadioButton", "", 1).ClickButton();
          		Get_WinQuickSearch_BtnOK().Click(); 
              
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_8b76", 5000);
              //Changer la dimension et la position de la fenêtre RQS
              if(Get_WinRQS().WindowState == "Maximized")
                      Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
              Get_WinRQS().Set_Width(1200);
              Get_WinRQS().Set_Height(1030);
              //Deplacer vers la droite
              winRQSLeft = Get_WinRQS().get_Left();
              winRQSTop  = Get_WinRQS().get_Top();         
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Drag(100,8,-winRQSLeft+700,-winRQSTop);
              //Sélectionner l'enregistrement de la grille et mailler vers le module Titres
              Log.Message("Select recording")
              Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", account300012NA, 10).Click();
              Drag(Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", account300012NA, 10), Get_ModulesBar_BtnSecurities());
              //Les points de vérifications:Les titres 059960 (ABX)  et 359131 (PJC.A) sont visibles dans le browser
              //Click sur le bouton sommation pour vérifier qu'il y a juste deux titres qui sont affichés
              //Get_Toolbar_BtnSum().Click()
              
              var DisplaySecurity059960=Get_SecurityGrid().Find("Value",security059960CROES6652,10)
              
                 if(DisplaySecurity059960.Exists && DisplaySecurity059960.VisibleOnScreen)
               {
                  Log.Checkpoint("Le titre dont le numéro est 059960 est visible dans le browser ")
               }
               else
                {
                  Log.Error("Le titre dont le numéro est 059960 n'est pas visible dans le browser ")
               }
               var DisplaySecurity359131=Get_SecurityGrid().Find("Value",security359131CROES6652,10)
              
                 if(DisplaySecurity359131.Exists && DisplaySecurity359131.VisibleOnScreen)
               {
                  Log.Checkpoint("Le titre dont le numéro est 359131 est visible dans le browser ")
               }
               else
                {
                  Log.Error("Le titre dont le numéro est 359131 n'est pas visible dans le browser ")
               }

 //Étape 2      
      /********************************************* Étape 2**************************************************************************************/
      
               Log.Message("*********************************************L'étape 2 du cas de test Croes-6652*******************************************")
               //Supprimer le filtre et en faire un nouveau sur le champ Test = Manual
               Get_WinRQS().Parent.Maximize();
               Log.Message("********************Desactiver le premier Filtre. *******************");
               
                Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10).Click()
     /*******************************************************************faire un nouveau sur le champ Test = Manual******************************************************/
              Get_WinRQS_QuickFilterClick();
              Get_SubMenus().FindChild("WPFControlText", filtreTestCROES6652, 10).Click();
          		Get_WinCreateFilter_DgvValue().Find("Value", valueFiltreTestManualCROES6652, 10).Click();
          		Log.Message("click on the apply button");
          		Get_WinCreateFilter_BtnApply().Click();
              
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", 5000); //Ajouté par A.A
              //Faire une recherche sur le Client rel. no. = 9999999
              Log.Message("Click on the keyboard to activate the quick search");                
          		Get_WinRQS_TabAlerts_DgvAlerts().Keys("h");
          		Get_WinQuickSearch_TxtSearch().SetText(clientRelnumber9999999);
          		Get_WinRWS_QuickSearch().WPFObject("FieldSelector").WPFObject("ListBoxItem", "", 3).WPFObject("RadioButton", "", 1).ClickButton();
          		Get_WinQuickSearch_BtnOK().Click(); 
              
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_8b76", 5000); //Ajouté par A.A
              //Sélectionner l'enregistrement et mailler vers le module Titres
              //Changer la dimension et la position de la fenêtre RQS
              if(Get_WinRQS().WindowState == "Maximized")
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
              Get_WinRQS().Set_Width(1200);
              Get_WinRQS().Set_Height(1030);
              //Deplacer vers la droite
              winRQSLeft = Get_WinRQS().get_Left();
              winRQSTop  = Get_WinRQS().get_Top();         
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Drag(100,8,-winRQSLeft+700,-winRQSTop);
              //Sélectionner l'enregistrement de la grille et mailler vers le module Titres
              Log.Message("Select recording");
              Delay(2000);
              Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", clientRelnumber9999999, 10).Click();
              Drag(Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", clientRelnumber9999999, 10), Get_ModulesBar_BtnSecurities());
              //Les points de vérifications:Les titres 059960 (ABX)  et 359131 (PJC.A) sont visibles dans le browser
              //Click sur le bouton sommation pour vérifier qu'il y a juste deux titres qui sont affichés
              //Get_Toolbar_BtnSum().Click()
              
              var DisplaySecurity538579=Get_SecurityGrid().Find("Value",security538579CROES6652,10)
              
                 if(DisplaySecurity538579.Exists && DisplaySecurity538579.VisibleOnScreen)
               {
                  Log.Checkpoint("Le titre dont le numéro est 538579 est visible dans le browser ")
               }
               else
                {
                  Log.Error("Le titre dont le numéro est 538579 n'est pas visible dans le browser ")
               }
     //Étape 3      
      /********************************************* Étape 3**************************************************************************************/
      
               Log.Message("*********************************************L'étape 3 du cas de test Croes-6652*******************************************")
      //Supprimer le filtre et en faire un nouveau sur le champ Test = Change of IA code
               Get_WinRQS().Parent.Maximize();
               Log.Message("********************Desactiver le premier Filtre. *******************");
               
                Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 2], 10).Click()
             /*******************************************************************faire un nouveau sur le champ Test = Change of IA code******************************************************/
              Get_WinRQS_QuickFilterClick();
              Get_SubMenus().FindChild("WPFControlText", filtreTestCROES6652, 10).Click();
          		Get_WinCreateFilter_DgvValue().Find("Value", valueFiltreTestChangeOfIACodeCROES665, 10).Click();
          		Log.Message("click on the apply button");
          		Get_WinCreateFilter_BtnApply().Click();
              
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", 5000); //Ajouté par A.A   
              
          //Sélectionner l'enregistrement du résultat du filtre et mailler vers le module Sécurities.
             //Sélectionner l'enregistrement et mailler vers le module Titres
              //Changer la dimension et la position de la fenêtre RQS
              if(Get_WinRQS().WindowState == "Maximized")
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
              Get_WinRQS().Set_Width(1200);
              Get_WinRQS().Set_Height(1030);
              //Deplacer vers la droite
              winRQSLeft = Get_WinRQS().get_Left();
              winRQSTop  = Get_WinRQS().get_Top();         
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Drag(100,8,-winRQSLeft+700,-winRQSTop);
              //Sélectionner l'enregistrement de la grille et mailler vers le module Titres
              Log.Message("Select recording")
              Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", numberClient8000229, 10).Click();
              Drag(Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", numberClient8000229, 10), Get_ModulesBar_BtnSecurities());  
        //Faire un export  avec le bouton EDIT --> Export to Ms Excel 
              Get_MenuBar_Edit().Click();
              if (!Get_SubMenus().Exists) //Le clic sur le menu Edition ne fonctionne pas du premier coup
              Get_MenuBar_Edit().Click();
           
              Get_MenuBar_Edit_ExportToMsExcel().Click()
              
              //fermer les fichiers excel
              CloseExcel();
                    
              //Comparer les deux fichiers
              Log.Message("Check data exported to excel de l'étape 3"+ExpectedFile_Cr1958_2Croes665 );
              ExcelFilesCompare(ExpectedFolder,ExpectedFile_Cr1958_2Croes665,ResultFolder);
              
               //Étape 4      
      /********************************************* Étape 4**************************************************************************************/
      //Retourner dans RQS 
      //Sélectionner l'enregistrement du résultat du filtre et mailler vers le module Client.
              Log.Message("*********************************************L'étape 4 du cas de test Croes-6652*******************************************")
              if(Get_WinRQS().WindowState == "Maximized")
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
              Get_WinRQS().Set_Width(1200);
              Get_WinRQS().Set_Height(1030);
              //Deplacer vers la droite
              winRQSLeft = Get_WinRQS().get_Left();
              winRQSTop  = Get_WinRQS().get_Top();         
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Drag(100,8,-winRQSLeft+700,-winRQSTop);
              //Sélectionner l'enregistrement de la grille et mailler vers le module client
              Log.Message("Select recording")
              Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", numberClient8000229, 10).Click();
              Drag(Get_WinRQS_TabAlerts_DgvAlerts().Find("DisplayText", numberClient8000229, 10), Get_ModulesBar_BtnClients()); 
              WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.DataRecordPresenter");
              Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 25000); 
              //Mailler le client 800229  vers le module Titre  
              Get_RelationshipsClientsAccountsGrid().Find("DisplayText", numberClient8000229, 10).Click();
              //Mailler ce client vers le module Titre
              Get_MenuBar_Modules().Click();
              Get_MenuBar_Modules_Securities().Click();
              Get_MenuBar_Modules_Securities_DragSelection().Click();
              //Faire un export  avec le bouton EDIT --> Export to Ms Excel 
              Get_MenuBar_Edit().Click();
              if (!Get_SubMenus().Exists) //Le clic sur le menu Edition ne fonctionne pas du premier coup
              Get_MenuBar_Edit().Click();
           
              Get_MenuBar_Edit_ExportToMsExcel().Click()
              
              //fermer les fichiers excel
              CloseExcel();
                    
              //Comparer les deux fichiers
              Log.Message("Check data exported to excel de l'étape 3 "+ExpectedFile_Cr1958_2Croes665 );
              ExcelFilesCompare(ExpectedFolder,ExpectedFile_Cr1958_2Croes665,ResultFolder);
              
        //Étape 5     
      /********************************************* Étape 5**************************************************************************************/
      Log.Message("*********************************************L'étape 5 du cas de test Croes-6652*******************************************")
      Log.Message("Comparer le résultat du Excel produit dans l'étape 3 avec celui produit dans l'étape 5")
      Log.Message("Létape 5 est incluse dans les deux étapes précédentes. En effet au niveau de l'étape 3 on compare le fichier excel exporté par rapport au fichier de référence..")
      Log.Message("A l'étape 4 aussi on compare aussi le fichier excel généré au même fichier de référence. ")
    }
    catch(e) {
        
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Initialiser la BD
                
        
        
    }
    finally {
    
        Terminate_CroesusProcess();
         //Initialiser la BD
        
         
        
    }
}

function  Get_WinRQS_QuickFilterClick()
{ 
// //width 1937 and height 1067
Get_WinRQS().Click(Get_WinRQS().Width-1930,Get_WinRQS().Height-967);
}
//Get_WinRQS().Click(-596,-100);



function Get_WinSecuritySum_LabelTotal()
{
 
return Get_WinSecuritySum().FindChild("Uid", "count", 10)
}