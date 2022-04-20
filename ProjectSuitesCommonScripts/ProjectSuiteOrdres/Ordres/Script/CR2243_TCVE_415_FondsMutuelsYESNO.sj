//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**

                  
                
        
    storie:TCVE-403.
    lien  du cas de test sur jira: https://jira.croesus.com/browse/TCVE-415
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation :    Sana Ayaz
    
    Version de scriptage:	90.15.2020.3-22
*/

function CR2243_TCVE_415_FondsMutuelsYESNO()
{
    try {
    
        var  userNameKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var  passwordKEYNEJ              = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var  textMsgTCVE415Step2         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "textMsgTCVE415Step2", language+client);
        var  symbolBuyTCVE403Step7       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step7", language+client);
        var  symbolBuyTCVE403Step2       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step2", language+client);
        var  symbolBuyTCVE403Step4       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step4", language+client);
        var  symbol_TCVE403              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbol_TCVE403", language+client);
        var  symbolBuyTCVE403Step5       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step5", language+client);
        var  symbolBuyTCVE403Step6       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolBuyTCVE403Step6", language+client);
        var symbol_TCVE412Step3          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbol_TCVE412Step3", language+client);
        var ExpectedFolder               = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\CR2243\\"+language+"\\";
        var ResultFolder                 = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\CR2243\\"+language+"\\";         
        var ExportExcelTCVE415Taux = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "ExportExcelTCVE415Taux", language+client);
                   
          
         
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_FX_TAB_MF","NO",vServerOrders)
        RestartServices(vServerOrders)
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
       
        //Creation d'ordre 
        Get_ModulesBar_BtnOrders().Click();
         Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000); 
        Log.Message("******************L'étape 2 ************************************")
       /*Dans le blotter, sélectionner l'ordre du Fond mutuels/ Symbole: FIA100 (devise: CAD) pour un compte USD (par ex:800003-OB) / 	clic droit/ Fonctions/ Taux de change*/
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step7,10).ClickR()
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step7,10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click(); 
        /*Les points de vérifications:Message d'erreur: "Cette opération n'est pas permise pour le ou les instruments financiers suivants : Fonds d'investissement."
          Le processus est arrêté. */
          
        aqObject.CheckProperty(Get_DlgError_LblMessage1(), "Text", cmpEqual, textMsgTCVE415Step2);
        aqObject.CheckProperty(Get_DlgError_LblMessage1(), "VisibleOnScreen", cmpEqual, true);
        Get_DlgError_Btn_OK().Click()
        Log.Message("******************L'étape 3 ************************************")
          
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step7,10).Click();
        //La touche CTRL enfoncée
        Sys.Desktop.KeyDown(0x11);
        // Clic-droit / Fonctions / Taux de change /Appliquer un nouveau taux de change et numéro interne; Confirmer
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step5,10).Click();
        //Relâcher la touche CTRL enfoncée
        Sys.Desktop.KeyUp(0x11);
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step5,10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();   
       /*Les points de vérifications:Message d'erreur: "Cette opération n'est pas permise pour le ou les instruments financiers suivants : Fonds d'investissement."
          Le processus est arrêté. */
          
        aqObject.CheckProperty(Get_DlgError_LblMessage1(), "Text", cmpEqual, textMsgTCVE415Step2);
        aqObject.CheckProperty(Get_DlgError_LblMessage1(), "VisibleOnScreen", cmpEqual, true);
        Get_DlgError_Btn_OK().Click();
        Terminate_CroesusProcess();  
        Log.Message("******************L'étape 4 ************************************")
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_INTERNAL_NUMBER_FX","NO",vServerOrders)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_FX_TAB_MF","YES",vServerOrders)
        RestartServices(vServerOrders)
        Log.Message("******************L'étape 5 ************************************")
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        //Creation d'ordre 
        Get_ModulesBar_BtnOrders().Click();
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step7,10).ClickR()
        Get_OrderGrid().Find("Value",symbolBuyTCVE403Step7,10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click(); 
        /*Les points de vérifications:La fenêtre de Taux de change s'ouvre.
          Le champ Numéro interne est présent, même si la PREF_GDO_INTERNAL_NUMBER_FX = NO.*/
          WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATE"); //YR
          aqObject.CheckProperty(Get_WinExchangeRateOrdre(), "VisibleOnScreen", cmpEqual, true);
       
          aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtInternalNumber(), "VisibleOnScreen", cmpEqual, true);
    
          aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "VisibleOnScreen", cmpEqual, true);
          
          Get_WinExchangeRate_BtnCancel().Click();
          
          Log.Message("******************L'étape 6 ************************************")
           /*Sélectionner deux ordres: 
          -  Symbol: AGU et MAV203

          Clic droit/ Fonctions/ Taux de change / un message d'information s'affiche /Ok /Dans la fenêtre 'Taux de change' le champ 'No interne' ne s'affiche pas*/
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          Get_OrderGrid().Find("Value",symbolBuyTCVE403Step4,10).Click();
          // la touche CTRL enfoncée
           Sys.Desktop.KeyDown(0x11);
          // Clic-droit / Fonctions / Taux de change /Appliquer un nouveau taux de change et numéro interne; Confirmer
         
          Get_OrderGrid().Find("Value",symbol_TCVE412Step3,10).Click();
          //Relâcher la touche CTRL enfoncée
          Sys.Desktop.KeyUp(0x11);
          Get_OrderGrid().Find("Value",symbol_TCVE412Step3,10).ClickR()
          Get_OrderGrid_ContextualMenu_Functions().Click();
          Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click(); 

          Log.Message("Clic sur e bouton ok du message d'information affiché")

          Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
          //Les points de vérifications   
          WaitObject(Get_CroesusApp(),"WindowMetricTag ","GDOFXRATE"); //YR
          aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtInternalNumber(), "VisibleOnScreen", cmpEqual, false);
    
          aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(), "VisibleOnScreen", cmpEqual, false);
          
          Get_WinExchangeRate_BtnCancel().Click();
          
          Log.Message("******************L'étape 7 ************************************")
          /*Sélectionner un ordre dans le blotter, clic droit Export vers Excel / 
          Valider que la colonne 'Taux' affiche correctement le taux de change*/
      
          SetDefaultConfiguration( Get_OrderGrid_ChAccountName())
          SetAutoTimeOut();
          if(!Get_OrderGrid_ChRate().Exists){
                Get_OrderGrid_ChAccountName().ClickR();
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                Get_GridHeader_ContextualMenu_AddColumn_Rate().Click();
            }
          RestoreAutoTimeOut();
          Get_OrderGrid().Find("Value",symbol_TCVE403,10).ClickR();
          Get_OrderGrid().Find("Value",symbol_TCVE403,10).ClickR(); 
          
          Get_OrderGrid_ContextualMenu_ExportToMSExcel().Click(); 
           //fermer les fichiers excel
                    CloseExcel();
          //Comparer les deux fichiers
          Log.Message("Check data exported to excel for all possible columns added with "+ExportExcelTCVE415Taux);
          ExcelFilesCompare(ExpectedFolder,ExportExcelTCVE415Taux,ResultFolder);
          
        
           




  }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
       
        Terminate_CroesusProcess();
       
        
    }
    finally {

    //fermer les fichiers excel
    CloseExcel();
          
    //Delete files exported
    aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory+"\CroesusTemp\\*.txt");
                    
    //Set the default configuration of columns in the grid
    SetDefaultConfiguration(Get_OrderGrid_ChSymbol());
    //Fermer le processus Croesus
    
     Terminate_CroesusProcess(); 
     Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_INTERNAL_NUMBER_FX","YES",vServerOrders)
     Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_FX_TAB_MF","YES",vServerOrders)
     RestartServices(vServerOrders)
     Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
      
    }
}
