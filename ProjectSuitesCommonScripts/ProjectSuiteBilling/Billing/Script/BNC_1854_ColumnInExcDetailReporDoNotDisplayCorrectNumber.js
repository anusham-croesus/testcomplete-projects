//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT Helper



/**
        Description : 
                  
                      Étapes pour reproduire :

                        Facturer la relation 'End_of_period' jusqu'on Decembre2009 (Tools/Billing)
                        Cliquer sur le bouton 'Generate', puis sélectionner 'Export to Excel (Detailed), OK.
                        -Constater que les colonnes qui devraient afficher les taux de la grille tariffaire, affiche 'Fees[0].Percentage'.
                        -Voir SVP ci-joint le 'Detailed Report'
    Anomalie:BNC-1854
    Version de scriptage:ref90-07-23
*/
function BNC_1854_ColumnInExcDetailReporDoNotDisplayCorrectNumber()
{
    try {
        
        
        
           EmptyBillingHistory();
          // UncheckedAUMBillable();
          // UncheckedBillableRelastionShip();
       
        
         Login(vServerBilling, userNameBilling, pswBilling, language);
         var NamRelatBNC1854=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "NamRelatBNC1854", language+client);
         //ouvrir le module relation
         Get_ModulesBar_BtnRelationships().Click();
         SearchRelationshipByName(NamRelatBNC1854);
          Get_RelationshipsClientsAccountsGrid().Find("Value",NamRelatBNC1854,100).Click();
          Get_RelationshipsClientsAccountsGrid().Find("Value",NamRelatBNC1854,100).DblClick();
            Delay(3000);
            // côcher Billable Relationship
            //Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Set_IsChecked(true);
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(8000);
            // choisir l'onglet billing
            Get_WinDetailedInfo_TabBillingForRelationship().Click();
            Delay(3000);
            Get_WinDetailedInfo_BtnApply().Click();
            // FillInTheBottomPartOfAccounts(16);
            FillRelationshipBillingTab([GetData(filePath_Billing,"WinAssignCompte",30,language),GetData(filePath_Billing,"WinAssignCompte",29,language)], GetData(filePath_Billing,"RelationBilling",16,language))
            Delay(1000);
            // Clic sur le bouton OK pour fermer la fenêtre info de relation
            Get_WinDetailedInfo_BtnApply().Click();
            Delay(1000);
            Get_WinDetailedInfo_BtnOK().Click();
            Delay(3000);
         
         
         
         
          //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            // Décôcher sur la partie frequencies Quarterly,Semiannual et Annual
            Get_WinBillingParameters_RdoInArrears().Click();
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);

            // click sur le bouton de date 
              x=7*(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth()/8);
            y=Get_WinBillingParameters_DtpBillingDate().get_ActualHeight()/7;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //choisir l'année 2009
            Get_Calendar_LstYears_Item("2009").Click();
            Delay(300)
            //Choisir le mois décembre
             Get_Calendar_LstMonths_ItemDecember().Click();
             Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
             Get_WinBillingParameters_BtnOK().Click();
             WaitUntilCroesusDialogBoxClose();
             Get_WinBilling_BtnGenerate().Click()
             Get_WinOutputSelection_GrpOutput_ChkExportToExcelSummarized().Click()
             Get_WinOutputSelection_GrpOutput_ChkExportToExcelDetailed().Click()
             Get_WinOutputSelection_BtnOK().Click()
             x=Get_DlgConfirmation().get_ActualWidth()-388;
             y=Get_DlgConfirmation().get_ActualHeight()-45;
             Get_DlgConfirmation().Click(x, y)
         
             WaitUntillWinBillingClose()

           
             
              var sTempFolder = Sys.OSInfo.TempDirectory;
              var FolderPath= sTempFolder+"\CroesusTemp\\"
              Log.Message(FolderPath)
        
        
              var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
              Log.Message(FileNameContains);
              var FileNameContainsDetailReport= "Detailed Report"+ FileNameContains;
              Log.Message(FileNameContainsDetailReport);
              Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContainsDetailReport));
              var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContainsDetailReport), aqFile.faRead, aqFile.ctANSI);
        
               // Reads text lines from the file and posts them to the test log 
               var countLineInMyFile=0; // les lignes dans le fichier txt 
      
         
         
              while(! myFile.IsEndOfFile()){
    
                         countLineInMyFile++;
                         line = myFile.ReadLine();
        
                         var textArr = line.split("	");       
         
                          var Res = aqString.Find(textArr, 'Fees[0].Percentage');
                                if ( Res != -1 ) 
                                  Log.Error("Substring '" +'Fees[' + "' was found in string '" + line + "' at position " + Res)
                                else
                                  Log.Checkpoint("There are no occurrences of '" + 'Fees[' + "' in '" + line + "'")
                               }
           
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        EmptyBillingHistory();
        
    }
    finally {
        
        Terminate_CroesusProcess();
        EmptyBillingHistory();
       
      //  UncheckedAUMBillable();
     //   UncheckedBillableRelastionShip();
           
    }
}


function WaitUntillWinBillingClose(maxWaitTime)
{
    if (maxWaitTime == undefined)
        maxWaitTime = 300000;
        
    Delay(1000);
    waitTime = 0;
    isFound = Get_WinBilling().Exists;
    while (!isFound && waitTime < maxWaitTime){
        Delay(2000);
        waitTime += 2000;
        isFound = Get_WinBilling().Exists;
    }
    Delay(1000);
    
    if (!isFound)
        Log.Message("Billing  Window not display after  " + waitTime + " ms.");
}
