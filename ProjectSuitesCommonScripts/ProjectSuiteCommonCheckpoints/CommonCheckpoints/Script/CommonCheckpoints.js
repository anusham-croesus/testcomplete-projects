//USEUNIT Common_Get_functions
//USEUNIT Titres_Get_functions
//USEUNIT Agenda_Get_functions
//USEUNIT Portefeuille_Get_functions
//USEUNIT Clients_Get_functions
//USEUNIT Modeles_Get_functions
//USEUNIT Dashboard_Get_functions
//USEUNIT Transactions_Get_functions
//USEUNIT Ordres_Get_functions

 
//+++++++++++++++++++++++++++++++WIN AGENDA CHECK POINTS++++++++++++++++++++++++++++++++++++++++
//Fonctions  (les points de vérification pour les scripts qui testent Agenda)
//function Check_WinAgenda_Properties_French()
//{
//    aqObject.CheckProperty(Get_WinAgenda(), "WPFControlText", cmpEqual, "Agenda");
//
//    aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "WPFControlText", cmpEqual, "OK");
//    aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "WPFControlText", cmpEqual, "Annuler");
//    aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "WPFControlText", cmpEqual, "_Appliquer");
//  
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Horaire"); 
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, true);
// 
//    Get_WinAgenda_ButtonBar_BtnTasks().Click() 
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Tâches");
//    
//    Get_WinAgenda_ButtonBar_BtnOverdue().Click()
//    aqObject.CheckProperty( Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Activités échues");
//   
//    Get_WinAgenda_ButtonBar_BtnBirthdays().Click()
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Anniversaires");
//  
//    Get_WinAgenda_ButtonBar_BtnAlarms().Click() 
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Alarmes");
//  
//    Get_WinAgenda_ButtonBar_BtnFilesProcessing().Click()
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Traitements");
//}
//
//function Check_WinAgenda_Properties_English()
//{
//   aqObject.CheckProperty(Get_WinAgenda(), "WPFControlText", cmpEqual, "Agenda");
//   aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "WPFControlText", cmpEqual, "OK");
//   aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "WPFControlText", cmpEqual, "Cancel");
//   aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "WPFControlText", cmpEqual, "_Apply");
//  
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Schedule"); 
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, true);
// 
//    Get_WinAgenda_ButtonBar_BtnTasks().Click() 
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Tasks");
//    
//    Get_WinAgenda_ButtonBar_BtnOverdue().Click()
//    aqObject.CheckProperty( Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Overdue");
//   
//    Get_WinAgenda_ButtonBar_BtnBirthdays().Click()
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Birthdays");
//  
//    Get_WinAgenda_ButtonBar_BtnAlarms().Click() 
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Alarms");
//  
//    Get_WinAgenda_ButtonBar_BtnFilesProcessing().Click()
//    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, true);
//    aqUtils.Delay (1000);
//    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, "Files Processing");
//}
//
//function Check_WinAgenda_Existence_Of_Controls()
//{
//    aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsEnabled", cmpEqual, true);
//}

function Check_WinAgenda_Properties(language)// Les points de vérification, utilisation de fichier Excel  
{
    aqObject.CheckProperty(Get_WinAgenda(), "WPFControlText", cmpEqual, GetData(filePath_Common,"Agenda",2,language));
    aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "WPFControlText", cmpEqual, GetData(filePath_Common,"Agenda",3,language));
    aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"Agenda",4,language));
    aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"Agenda",5,language));
  
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Agenda",6,language)); 
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnSchedule(), "IsChecked", cmpEqual, true);
 
    Get_WinAgenda_ButtonBar_BtnTasks().Click() 
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnTasks(), "IsChecked", cmpEqual, true);
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a",GetData(filePath_Agenda,"Survol_Age_Tasks",3,language), true]); 
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Agenda",7,language));
    
    Get_WinAgenda_ButtonBar_BtnOverdue().Click()
    aqObject.CheckProperty( Get_WinAgenda_ButtonBar_BtnOverdue(), "IsChecked", cmpEqual, true);
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_Overdue",3,language), true]);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Agenda",8,language));
   
    Get_WinAgenda_ButtonBar_BtnBirthdays().Click()
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnBirthdays(), "IsChecked", cmpEqual, true);
     WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_Birthdays",3,language), true])
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Agenda",9,language));
  
    Get_WinAgenda_ButtonBar_BtnAlarms().Click() 
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnAlarms(), "IsChecked", cmpEqual, true);
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Alarms", 3, language), true]);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Agenda",10,language));
  
    Get_WinAgenda_ButtonBar_BtnFilesProcessing().Click()
    aqObject.CheckProperty(Get_WinAgenda_ButtonBar_BtnFilesProcessing(), "IsChecked", cmpEqual, true);
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_FilesProcessing",3,language), true]);
    aqObject.CheckProperty(Get_WinAgenda_PadHeaderBar().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Agenda",11,language));
    
    aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_BtnOk(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_BtnCancel(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAgenda_BtnApply(), "IsEnabled", cmpEqual, true);
}


//+++++++++++++++++++++++++++++++WIN PORTFOLIO MANAGE CHECK POINTS++++++++++++++++++++++++++++++++++++++++
 //Fonctions  (les points de vérification pour les scripts qui testent Gestion de portefeuilles )
 
function Check_WinLockTheApplication_Properties()
{
  aqObject.CheckProperty(Get_WinLockTheApplication_TxtPassword(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinLockTheApplication_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinLockTheApplication_BtnOK(), "IsEnabled", cmpEqual, true);
 
  aqObject.CheckProperty(Get_WinLockTheApplication_BtnQuit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinLockTheApplication_BtnQuit(), "IsEnabled", cmpEqual, true);

  aqObject.CheckProperty(Get_WinLockTheApplication(), "Title", cmpEqual, GetData(filePath_Common, "Lock_Application", 2, language));
  aqObject.CheckProperty(Get_WinLockTheApplication_LblPassword(), "WPFControlText", cmpEqual, GetData(filePath_Common, "Lock_Application", 3, language)); 
  aqObject.CheckProperty(Get_WinLockTheApplication_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common, "Lock_Application", 4, language));
  aqObject.CheckProperty(Get_WinLockTheApplication_BtnQuit(), "WPFControlText", cmpEqual, GetData(filePath_Common, "Lock_Application", 5, language));
 }
 
 
function Check_DlgUserNameOrPasswordIsNotValid_Properties()
{
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "IsVisible", cmpEqual, true);

  Log.Message ("CROES-6707")
 //aqObject.CheckProperty(Get_DlgCroesus_LblMessage(), "Text", cmpEqual, GetData(filePath_Common, "Lock_Application", 6, language)); //YR modif pour 78-CX BNC avant WPFControlText
   aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual,GetData(filePath_Common, "Lock_Application", 6, language)); //EM : Modifié depuis 90-07-CO-15

//  aqObject.CheckProperty(Get_DlgUserNameOrPasswordIsNotValid_BtnOK(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_DlgUserNameOrPasswordIsNotValid_BtnOK(), "IsEnabled", cmpEqual, true);

//  aqObject.CheckProperty(Get_DlgUserNameOrPasswordIsNotValid().Title, "OleValue", cmpEqual, GetData(filePath_Common, "Lock_Application", 6, language));
  //aqObject.CheckProperty(Get_DlgUserNameOrPasswordIsNotValid_LblUserNameOrPasswordIsNotValid().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Lock_Application", 6, language));
//  aqObject.CheckProperty(Get_DlgUserNameOrPasswordIsNotValid_BtnOK().Content.Text, "OleValue", cmpEqual, GetData(filePath_Common, "Lock_Application", 7, language));
} 

//+++++++++++++++++++++++++++++++WIN INFO CASH CHECK POINTS+++++++++++++++++++++++++++++++++++++++++++++++
 //Fonctions  (les points de vérification pour les scripts qui testent Info) Pour les modules Portfolio et Transactions 
function Check_Properties_Info_Cash_French()
{
     //aqObject.CheckProperty(Get_WinPositionInfoBalance().Title, "OleValue", cmpEqual, "SOLDE ( CAD )");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnOK(), "Content", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnCancel(), "Content", cmpEqual, "Annuler");
     
     //Security Information:
//     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpSecurityInformation().Header, "OleValue", cmpEqual, "Information sur le titre"); //YR 90-04-32
//     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpSecurityInformation_LblSubcategory().Text, "OleValue", cmpEqual, "Sous-catégorie:"); //YR 90-04-32
     
     //Position Information (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation().Header, "OleValue", cmpEqual, "Information sur la position (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblQuantity().Text, "OleValue", cmpEqual, "Quantité:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblCost().Text, "OleValue", cmpEqual, "Coût:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblHeldIn().Text, "OleValue", cmpEqual, "Détenue en CAD");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblValue().Text, "OleValue", cmpEqual, "Valeur:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblTotalValuePercent().Text, "OleValue", cmpEqual, "Valeur (%):"); // "Valeur totale (%):" in auto 9
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblInvestedCapital().Text, "OleValue", cmpEqual, "Capital investi");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblBookValue().Text, "OleValue", cmpEqual, "Valeur comptable");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblMarketValue().Text, "OleValue", cmpEqual, "Valeur de marché");
     
     //Gains/Losses(CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses().Header, "OleValue", cmpEqual, "Gains/Pertes (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblBookValue().Content, "OleValue", cmpEqual, "Valeur comptable");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblUnrealized().Content, "OleValue", cmpEqual, "Non réalisés:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblUnrealizedPercent().Content, "OleValue", cmpEqual, "Non réalisés (%):");
     
     //Income (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome().Header, "OleValue", cmpEqual, "Revenu (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_LblAnnual().Content, "OleValue", cmpEqual, "Annuel:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Int./Div. courus:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Int./Div. cumulés:");
     
     //Miscellaneous (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Divers (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_LblCommission().Text, "OleValue", cmpEqual, "Commission:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_LblLastBuy().Text, "OleValue", cmpEqual, "Dernier achat:"); 
}

function Check_Properties_Info_Cash_English()
{
     //aqObject.CheckProperty(Get_WinPositionInfoBalance().Title, "OleValue", cmpEqual, "BALANCE ( CAD )");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnOK(), "Content", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnCancel(), "Content", cmpEqual, "Cancel");
     
     //Security Information:
     //aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpSecurityInformation().Header, "OleValue", cmpEqual, "Security Information"); //YR 90-04-32
     //aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpSecurityInformation_LblSubcategory().Text, "OleValue", cmpEqual, "Subcategory:");//YR 90-04-32
     
     //Position Information (CAD)
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation().Header, "OleValue", cmpEqual, "Position Information (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblQuantity().Text, "OleValue", cmpEqual, "Quantity:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblCost().Text, "OleValue", cmpEqual, "Cost:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblHeldIn().Text, "OleValue", cmpEqual, "Held in CAD");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblValue().Text, "OleValue", cmpEqual, "Value:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblTotalValuePercent().Text, "OleValue", cmpEqual, "Value (%):");// "Total Value (%):" in auto 9
     if( client == "US" ) {aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblCostBasis().Text, "OleValue", cmpEqual, "Cost Basis");}//90-04-49
     else {
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblInvestedCapital().Text, "OleValue", cmpEqual, "Invested Cap.");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblBookValue().Text, "OleValue", cmpEqual, "Book Value");}
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_LblMarketValue().Text, "OleValue", cmpEqual, "Market Value");
     if( client == "US")// 90-04-49
     {Log.Message("La partie de Gains/Losses(CAD) n'existe pas pour la US")}
     else {
     //Gains/Losses(CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses().Header, "OleValue", cmpEqual, "Gains/Losses (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblInvestedCapital().Content, "OleValue", cmpEqual, "Invested Cap.");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblBookValue().Content, "OleValue", cmpEqual, "Book Value");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblUnrealized().Content, "OleValue", cmpEqual, "Unrealized:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_LblUnrealizedPercent().Content, "OleValue", cmpEqual, "Unrealized (%):");
     }
     //Income (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome().Header, "OleValue", cmpEqual, "Income (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_LblAnnual().Content, "OleValue", cmpEqual, "Annual:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Accrued Int./Div.:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Accum. Int./Div.:");
     
     //Miscellaneous (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Miscellaneous (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_LblCommission().Text, "OleValue", cmpEqual, "Commission:");
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_LblLastBuy().Text, "OleValue", cmpEqual, "Last Buy:");
     
     
     
         
}

function Check_Existence_Of_Controls_Info_Cash(btnType)
{
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnOK(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnOK(), "IsEnabled", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnCancel(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_BtnCancel(), "IsEnabled", cmpEqual, true);
     
     //Security Information:
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtQuantity(), "IsVisible", cmpEqual, true);     
     if (btnType=="whatif"){aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtQuantity(), "IsReadOnly", cmpEqual, false)}
     else{aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtQuantity(), "IsReadOnly", cmpEqual, true)}
     
     if( client == "US"){Log.Message("la partie de Invested cap. et Book value n'existent pas pour la US")
     // Les points de vérifications de Cost Basis
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisCost(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisValue(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisValue(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisTotalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisTotalValuePercent(), "IsReadOnly", cmpEqual, true);
     }// 90-04-49
     else{
     //Position Information (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalCost(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalValue(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalValue(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalTotalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalTotalValuePercent(), "IsReadOnly", cmpEqual, true);
     
         
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueCost(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueValue(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueValue(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueTotalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueTotalValuePercent(), "IsReadOnly", cmpEqual, true);
     }
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueCost(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueValue(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueValue(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueTotalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueTotalValuePercent(), "IsReadOnly", cmpEqual, true);
     
     if(client == "US"){
       Log.Message("La partie de Gain/Losses(CAD) n'existe pas pour la US")
     } 
     else{
     
     //Gains/Losses(CAD)    
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtBookValueUnrealized(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtBookValueUnrealized(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtBookValueUnrealizedPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpGainsLosses_TxtBookValueUnrealizedPercent(), "IsReadOnly", cmpEqual, true);
      }    
     //Income (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_TxtAnnual(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_TxtAnnual(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_TxtAccruedIntDiv(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_TxtAccruedIntDiv(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_TxtAccumIntDiv(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpIncome_TxtAccumIntDiv(), "IsReadOnly", cmpEqual, true);
     
     //Miscellaneous (CAD)
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_TxtCommission(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_TxtCommission(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_TxtLastBuy(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfoBalance_GrpMiscellaneous_TxtLastBuy(), "IsReadOnly", cmpEqual, true);
}


//+++++++++++++++++++++++++++++++WIN ARCHIVE DOCUMENTS CHECK POINTS++++++++++++++++++++++++++++++++++++++++ 
 //Fonctions  (les points de vérification pour les scripts qui testent Archive_Documents)
//function Check_WinPersonalDocuments_Properties_French()
//{
//    //aqObject.CheckProperty(Get_WinPersonalDocuments().Title, "OleValue", cmpEqual, "Documents personnels de Nicolas Copernic (COPERN)");// COPERN
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments_BtnEdit().Content, "OleValue", cmpEqual, "Mo_difier");
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments().Header, "OleValue", cmpEqual, "Commentaires");   
//    aqObject.CheckProperty(Get_WinPersonalDocuments_BtnOK().Content.Text, "OleValue", cmpEqual, "OK");
//}
//
//function Check_WinPersonalDocuments_Properties_English()
//{
//    //aqObject.CheckProperty(Get_WinPersonalDocuments().Title, "OleValue", cmpEqual, "Nicolas Copernic (COPERN) personal documents");// COPERN
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments_BtnEdit().Content, "OleValue", cmpEqual, "_Edit");
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments().Header, "OleValue", cmpEqual, "Comments");   
//    aqObject.CheckProperty(Get_WinPersonalDocuments_BtnOK().Content.Text, "OleValue", cmpEqual, "OK");
//}
//
//function Check_WinPersonalDocuments_Existence_Of_Controls()
//{
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnShowHideFolderView(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnShowHideFolderView(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnAddAFile(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnAddAFile(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnRemove(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnRemove(), "IsEnabled", cmpEqual, false);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnRefresh(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnRefresh(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnCut(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnCut(), "IsEnabled", cmpEqual, false);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnCopy(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnCopy(), "IsEnabled", cmpEqual, false);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnPaste(), "IsVisible", cmpEqual, true);  
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnPaste(), "IsEnabled", cmpEqual, false);  
//       
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_TxtSearch(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_TxtSearch(), "IsReadOnly", cmpEqual, false);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnSearch(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnSearch(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterAll(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterAll(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterEmail(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterEmail(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterPdf(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterPdf(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterFile(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_Toolbar_BtnFilterFile(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_TvwDocuments(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_TvwDocuments(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_LstDocuments(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_LstDocuments(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments_BtnEdit(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments_BtnEdit(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_BtnOK(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_BtnOK(), "IsEnabled", cmpEqual, true);
//    
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments_TxtComment(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinPersonalDocuments_GrpComments_TxtComment(), "IsReadOnly", cmpEqual, true);
//    
//}

function Check_WinPersonalDocuments_Properties(language)//Les points de vérification, utilisation de fichier Excel  
{
    //aqObject.CheckProperty(Get_WinPersonalDocuments().Title, "OleValue", cmpEqual, "Nicolas Copernic (COPERN) personal documents");// COPERN
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Archive_Documents",2,language));
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments().Header, "OleValue", cmpEqual, GetData(filePath_Common,"Archive_Documents",3,language));   
    aqObject.CheckProperty(Get_WinPersonalDocuments_BtnOK().Content.Text, "OleValue", cmpEqual, GetData(filePath_Common,"Archive_Documents",4,language));
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnShowHideFolderView(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnShowHideFolderView(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnAddAFile(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnAddAFile(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRemove(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRemove(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRefresh(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRefresh(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCut(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCut(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCopy(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCopy(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnPaste(), "IsVisible", cmpEqual, true);  
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnPaste(), "IsEnabled", cmpEqual, false);  
       
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_TxtSearch(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_TxtSearch(), "IsReadOnly", cmpEqual, false);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnSearch(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnSearch(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterAll(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterAll(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterEmail(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterEmail(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterPdf(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterPdf(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterFile(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterFile(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinPersonalDocuments_TvwDocuments(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPersonalDocuments_TvwDocuments(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinPersonalDocuments_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPersonalDocuments_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "IsReadOnly", cmpEqual, true);
    
}


//+++++++++++++++++++++++++++++++WIN BOND CALCULATOR CHECK POINTS++++++++++++++++++++++++++++++++++++++++++ 
 //Fonctions  (les points de vérification pour les scripts qui testent Bond_Calculator)
 function Check_BondCalculator_Properties(language)
 {
      aqObject.CheckProperty(Get_WinBondCalculator().Title, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",2,language));
      
      //*******************************LES BTNS*******************************
      //Fermer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnClose().Content.Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",3,language));
      //Jours entre les dates
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates().Content.Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",4,language));
      //Calculer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCalculate().Content.Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",5,language));
      //Copier l'obligation..
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCopyBond().Content.Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",6,language))
      //Reinitialiser
      aqObject.CheckProperty(Get_WinBondCalculator_BtnReset().Content.Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",7,language));
      
      //****************************LES COMBO LISTES**************************
      //Type d'obligation:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondABondType().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",8,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBBondType().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",9,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCBondType().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",10,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDBondType().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",11,language));
      
      //Format de calendrier:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondADayCount().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",12,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBDayCount().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",13,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCDayCount().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",14,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDDayCount().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",15,language));
      
      //Composition:      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondACompounding().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",16,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",17,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",18,language));
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDCompounding().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",19,language));
      
      //Les étiquettes       
      aqObject.CheckProperty(Get_WinBondCalculator_LblBondType().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",20,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblInterestRate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",21,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblFirstCouponDate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",22,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblPurchaseDate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",23,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblMaturityDate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",24,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblIssueDate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",25,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblCurrentDate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",26,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblConversionDate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",27,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblDayCount().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",28,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblCompounding().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",29,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblPurchasePrice().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",30,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblMarketPrice().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",31,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblParValue().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",32,language));     
      aqObject.CheckProperty(Get_WinBondCalculator_LblCostYield().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",33,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblMarketYield().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",34,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblYieldToDate().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",35,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblModifiedDuration().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",36,language));
      aqObject.CheckProperty(Get_WinBondCalculator_LblAccInterest().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Bon_Calculator",37,language));    
      
      //********************************LES BTNS*******************************
      //Fermer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnClose(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnClose(), "IsEnabled", cmpEqual, true);
      //Jours entre les dates
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      //Calculer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCalculate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      //Copier l'obligation..
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCopyBond(), "IsVisible", cmpEqual, true)
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      //Reinitialiser
      aqObject.CheckProperty(Get_WinBondCalculator_BtnReset(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      
      
        //****************************LES COMBO LISTES**************************
      //Type d'obligation:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondABondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondABondType(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBBondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBBondType(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCBondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCBondType(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDBondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDBondType(), "IsEnabled", cmpEqual, true);
      
      //Format de calendrier:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondADayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondADayCount(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBDayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBDayCount(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCDayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCDayCount(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDDayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDDayCount(), "IsEnabled", cmpEqual, true);
      
      //Composition:      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondACompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondACompounding(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCCompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCCompounding(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDCompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDCompounding(), "IsEnabled", cmpEqual, true);
      
      
      //les textbox
      //Interest Rate
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBInterestRate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCInterestRate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDInterestRate(), "IsEnabled", cmpEqual, true);
      
      //First Coupon Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      //Purshase Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      //Maturity Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAMaturityDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBMaturityDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCMaturityDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDMaturityDate(), "IsEnabled", cmpEqual, true);
          
      //Issue Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAIssueDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBIssueDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCIssueDate(), "IsEnabled", cmpEqual, true);
          
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDIssueDate(), "IsEnabled", cmpEqual, true);
      
      //Current Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondACurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondACurrentDate(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBCurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBCurrentDate(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCCurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCCurrentDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDCurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDCurrentDate(), "IsEnabled", cmpEqual, true);
            
      //Conversion Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAConversionDate(), "IsReadOnly", cmpEqual, true);
          
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBConversionDate(), "IsReadOnly", cmpEqual, true);
        
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCConversionDate(), "IsReadOnly", cmpEqual, true);
         
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDConversionDate(), "IsReadOnly", cmpEqual, true);
      
      
      //Purchase Price
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "IsEnabled", cmpEqual, true);
           
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBPurchasePrice(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCPurchasePrice(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDPurchasePrice(), "IsEnabled", cmpEqual, true);
      
      //Market Price
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "IsEnabled", cmpEqual, false);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketPrice(), "IsEnabled", cmpEqual, false);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketPrice(), "IsEnabled", cmpEqual, false);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketPrice(), "IsEnabled", cmpEqual, false);
      
      //Par Value
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBParValue(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCParValue(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDParValue(), "IsEnabled", cmpEqual, true);
      
      //Cost Yield
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBCostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBCostYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCCostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCCostYieldPercent(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDCostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDCostYieldPercent(), "IsEnabled", cmpEqual, true);
      
      //Market Yield
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketYieldPercent(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketYieldPercent(), "IsEnabled", cmpEqual, true);
      
      //Yid-to-Date
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
      
      //Modified Duration 
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBModifiedDuration(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCModifiedDuration(), "IsReadOnly", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDModifiedDuration(), "IsReadOnly", cmpEqual, true);
      
      //Acc.Int/1000
       aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBAccInt(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCAccInt(), "IsReadOnly", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDAccInt(), "IsReadOnly", cmpEqual, true);   

 }
 
 
function Check_BondCalculator_Properties_French()
{
     aqObject.CheckProperty(Get_WinBondCalculator().Title, "OleValue", cmpEqual, "Calculatrice d\'obligations");
      
      //*******************************LES BTNS*******************************
      //Fermer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnClose().Content.Text, "OleValue", cmpEqual, "_Fermer");
      //Jours entre les dates
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates().Content.Text, "OleValue", cmpEqual, "_Jours entre les dates");
      //Calculer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCalculate().Content.Text, "OleValue", cmpEqual, "Calculer");
      //Copier l'obligation..
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCopyBond().Content.Text, "OleValue", cmpEqual, "_Copier l\'obligation...")
      //Reinitialiser
      aqObject.CheckProperty(Get_WinBondCalculator_BtnReset().Content.Text, "OleValue", cmpEqual, "Réi_nitialiser");
      
      //****************************LES COMBO LISTES**************************
      //Type d'obligation:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondABondType().Text, "OleValue", cmpEqual, "Ordinaire");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBBondType().Text, "OleValue", cmpEqual, "Ordinaire");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCBondType().Text, "OleValue", cmpEqual, "Ordinaire");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDBondType().Text, "OleValue", cmpEqual, "Ordinaire");
      
      //Format de calendrier:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondADayCount().Text, "OleValue", cmpEqual, "Actuel/Actuel");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBDayCount().Text, "OleValue", cmpEqual, "Actuel/Actuel");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCDayCount().Text, "OleValue", cmpEqual, "Actuel/Actuel");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDDayCount().Text, "OleValue", cmpEqual, "Actuel/Actuel");
      
      //Composition:      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondACompounding().Text, "OleValue", cmpEqual, "Semestriel");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding().Text, "OleValue", cmpEqual, "Semestriel");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding().Text, "OleValue", cmpEqual, "Semestriel");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDCompounding().Text, "OleValue", cmpEqual, "Semestriel");
      
      //Les étiquettes       
      aqObject.CheckProperty(Get_WinBondCalculator_LblBondType().Content, "OleValue", cmpEqual, "Type d\'obligation:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblInterestRate().Content, "OleValue", cmpEqual, "Taux d\'intérêt:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblFirstCouponDate().Content, "OleValue", cmpEqual, "Date premier coupon:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblPurchaseDate().Content, "OleValue", cmpEqual, "Date d\'achat:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblMaturityDate().Content, "OleValue", cmpEqual, "Date d\'échéance:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblIssueDate().Content, "OleValue", cmpEqual, "Date d\'émission:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblCurrentDate().Content, "OleValue", cmpEqual, "Date courante:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblConversionDate().Content, "OleValue", cmpEqual, "Date de conversion:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblDayCount().Content, "OleValue", cmpEqual, "Format de calendrier:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblCompounding().Content, "OleValue", cmpEqual, "Composition:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblPurchasePrice().Content, "OleValue", cmpEqual, "Prix d\'achat:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblMarketPrice().Content, "OleValue", cmpEqual, "Prix au marché:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblParValue().Content, "OleValue", cmpEqual, "Valeur au pair:");     
      aqObject.CheckProperty(Get_WinBondCalculator_LblCostYield().Content, "OleValue", cmpEqual, "Rend. achat (%):");
      aqObject.CheckProperty(Get_WinBondCalculator_LblMarketYield().Content, "OleValue", cmpEqual, "Rend. au marché (%):");//La modification a été faite selon le fichier Excel Modification_Documentation 
      aqObject.CheckProperty(Get_WinBondCalculator_LblYieldToDate().Content, "OleValue", cmpEqual, "Rend. à jour (%):");
      aqObject.CheckProperty(Get_WinBondCalculator_LblModifiedDuration().Content, "OleValue", cmpEqual, "Durée modifiée:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblAccInterest().Content, "OleValue", cmpEqual, "Int.courus/1000:");       

}

function Check_BondCalculator_Properties_English()
{
     aqObject.CheckProperty(Get_WinBondCalculator().Title, "OleValue", cmpEqual, "Bond Calculator");
      
      //********************************LES BTNS*******************************
      //Fermer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnClose().Content.Text, "OleValue", cmpEqual, "_Close");
      //Jours entre les dates
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates().Content.Text, "OleValue", cmpEqual, "_Days Between Dates");
      //Calculer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCalculate().Content.Text, "OleValue", cmpEqual, "Calculate");
      //Copier l'obligation..
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCopyBond().Content.Text, "OleValue", cmpEqual, "Copy _Bond...")
      //Reinitialiser
      aqObject.CheckProperty(Get_WinBondCalculator_BtnReset().Content.Text, "OleValue", cmpEqual, "_Reset");
      
      //************************LES COMBO LISTES*******************************
      //Type d'obligation:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondABondType().Text, "OleValue", cmpEqual, "Regular");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBBondType().Text, "OleValue", cmpEqual, "Regular");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCBondType().Text, "OleValue", cmpEqual, "Regular");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDBondType().Text, "OleValue", cmpEqual, "Regular");
      
      //Format de calendrier:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondADayCount().Text, "OleValue", cmpEqual, "Actual/Actual");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBDayCount().Text, "OleValue", cmpEqual, "Actual/Actual");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCDayCount().Text, "OleValue", cmpEqual, "Actual/Actual");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDDayCount().Text, "OleValue", cmpEqual, "Actual/Actual");
      
      //Composition:      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondACompounding().Text, "OleValue", cmpEqual, "Semi-annual");
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding().Text, "OleValue", cmpEqual, "Semi-annual");     
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCCompounding().Text, "OleValue", cmpEqual, "Semi-annual");      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDCompounding().Text, "OleValue", cmpEqual, "Semi-annual");
      
      //Les étiquettes       
      aqObject.CheckProperty(Get_WinBondCalculator_LblBondType().Content, "OleValue", cmpEqual, "Bond Type:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblInterestRate().Content, "OleValue", cmpEqual, "Interest Rate:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblFirstCouponDate().Content, "OleValue", cmpEqual, "First Coupon Date:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblPurchaseDate().Content, "OleValue", cmpEqual, "Purchase Date:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblMaturityDate().Content, "OleValue", cmpEqual, "Maturity Date:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblIssueDate().Content, "OleValue", cmpEqual, "Issue date:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblCurrentDate().Content, "OleValue", cmpEqual, "Current Date:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblConversionDate().Content, "OleValue", cmpEqual, "Conversion Date:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblDayCount().Content, "OleValue", cmpEqual, "Day Count:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblCompounding().Content, "OleValue", cmpEqual, "Compounding:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblPurchasePrice().Content, "OleValue", cmpEqual, "Purchase Price:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblMarketPrice().Content, "OleValue", cmpEqual, "Market Price:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblParValue().Content, "OleValue", cmpEqual, "Par Value:");     
      aqObject.CheckProperty(Get_WinBondCalculator_LblCostYield().Content, "OleValue", cmpEqual, "Cost Yield (%):");
      aqObject.CheckProperty(Get_WinBondCalculator_LblMarketYield().Content, "OleValue", cmpEqual, "Market Yield (%):");
      aqObject.CheckProperty(Get_WinBondCalculator_LblYieldToDate().Content, "OleValue", cmpEqual, "Yld-to-Date (%):");
      aqObject.CheckProperty(Get_WinBondCalculator_LblModifiedDuration().Content, "OleValue", cmpEqual, "Modified Duration:");
      aqObject.CheckProperty(Get_WinBondCalculator_LblAccInterest().Content, "OleValue", cmpEqual, "Acc. Int /1000:");  
}

function Check_BondCalculator_Existence_Of_Controls()
{
  //********************************LES BTNS*******************************
      //Fermer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnClose(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnClose(), "IsEnabled", cmpEqual, true);
      //Jours entre les dates
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      //Calculer
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCalculate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      //Copier l'obligation..
      aqObject.CheckProperty(Get_WinBondCalculator_BtnCopyBond(), "IsVisible", cmpEqual, true)
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      //Reinitialiser
      aqObject.CheckProperty(Get_WinBondCalculator_BtnReset(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_BtnDaysBetweenDates(), "IsEnabled", cmpEqual, true);
      
      
        //****************************LES COMBO LISTES**************************
      //Type d'obligation:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondABondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondABondType(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBBondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBBondType(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCBondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCBondType(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDBondType(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDBondType(), "IsEnabled", cmpEqual, true);
      
      //Format de calendrier:
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondADayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondADayCount(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBDayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBDayCount(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCDayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCDayCount(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDDayCount(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDDayCount(), "IsEnabled", cmpEqual, true);
      
      //Composition:      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondACompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondACompounding(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondBCompounding(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCCompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondCCompounding(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDCompounding(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_CmbBondDCompounding(), "IsEnabled", cmpEqual, true);
      
      
      //les textbox
      //Interest Rate
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBInterestRate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCInterestRate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDInterestRate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDInterestRate(), "IsEnabled", cmpEqual, true);
      
      //First Coupon Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDFirstCouponDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDFirstCouponDate(), "IsEnabled", cmpEqual, true);
      
      //Purshase Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDPurchaseDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDPurchaseDate(), "IsEnabled", cmpEqual, true);
      
      //Maturity Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAMaturityDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBMaturityDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCMaturityDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDMaturityDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDMaturityDate(), "IsEnabled", cmpEqual, true);
          
      //Issue Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAIssueDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBIssueDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCIssueDate(), "IsEnabled", cmpEqual, true);
          
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDIssueDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDIssueDate(), "IsEnabled", cmpEqual, true);
      
      //Current Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondACurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondACurrentDate(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBCurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBCurrentDate(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCCurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCCurrentDate(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDCurrentDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDCurrentDate(), "IsEnabled", cmpEqual, true);
            
      //Conversion Date
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAConversionDate(), "IsReadOnly", cmpEqual, true);
          
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondBConversionDate(), "IsReadOnly", cmpEqual, true);
        
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondCConversionDate(), "IsReadOnly", cmpEqual, true);
         
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDConversionDate(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_DtpBondDConversionDate(), "IsReadOnly", cmpEqual, true);
      
      
      //Purchase Price
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "IsEnabled", cmpEqual, true);
           
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBPurchasePrice(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCPurchasePrice(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDPurchasePrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDPurchasePrice(), "IsEnabled", cmpEqual, true);
      
      //Market Price
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "IsEnabled", cmpEqual, true); //YR ref 90-04-32 false CROES-5450
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketPrice(), "IsEnabled", cmpEqual, true);//YR ref 90-04-32 false CROES-5450
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketPrice(), "IsEnabled", cmpEqual, true);//YR ref 90-04-32 false CROES-5450
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketPrice(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketPrice(), "IsEnabled", cmpEqual, true);//YR ref 90-04-32 false CROES-5450
      
      //Par Value
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBParValue(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCParValue(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDParValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDParValue(), "IsEnabled", cmpEqual, true);
      
      //Cost Yield
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBCostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBCostYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCCostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCCostYieldPercent(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDCostYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDCostYieldPercent(), "IsEnabled", cmpEqual, true);
      
      //Market Yield
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBMarketYieldPercent(), "IsEnabled", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCMarketYieldPercent(), "IsEnabled", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketYieldPercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDMarketYieldPercent(), "IsEnabled", cmpEqual, true);
      
      //Yid-to-Date
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDYieldToDatePercent(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDYieldToDatePercent(), "IsReadOnly", cmpEqual, true);
      
      //Modified Duration 
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBModifiedDuration(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCModifiedDuration(), "IsReadOnly", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDModifiedDuration(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDModifiedDuration(), "IsReadOnly", cmpEqual, true);
      
      //Acc.Int/1000
       aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondBAccInt(), "IsReadOnly", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondCAccInt(), "IsReadOnly", cmpEqual, true);
            
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDAccInt(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinBondCalculator_TxtBondDAccInt(), "IsReadOnly", cmpEqual, true);
      
}

//+++++++++++++++++++++++++++++++MENU OF BTN INTERNET CHECK POINTS+++++++++++++++++++++++++++++++++++++++++ 
  //Fonctions  (les points de vérification pour les scripts qui testent btnInternet )pour les modules Portfolio, Transactions, Security
function Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_French(module)
{
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Quotes().Header, "OleValue", cmpEqual, "Cotes"); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Graphs().Header, "OleValue", cmpEqual, "Graphiques"); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Analysis().Header, "OleValue", cmpEqual, "Analyse"); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_News().Header, "OleValue", cmpEqual, "Nouvelles");
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Company().Header, "OleValue", cmpEqual, "Compagnie");
    if(module=="transaction")
    {
        aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions().Header, "OleValue", cmpEqual, "_Aller à la page d'accueil de votre navigateur...");
        aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions().Header, "OleValue", cmpEqual, "_Composer une adresse...");
    }
    else{
        aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage().Header, "OleValue", cmpEqual, "Aller à la page d'accueil de votre navigateur...");
        aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress().Header, "OleValue", cmpEqual, "Composer une adresse...");
    }
}

function Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_English(module)
{
  if(client != "TD" &&  client != "CIBC" ){

    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Quotes().Header, "OleValue", cmpEqual, "Quotes"); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Graphs().Header, "OleValue", cmpEqual, "Graphs"); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Analysis().Header, "OleValue", cmpEqual, "Analysis"); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_News().Header, "OleValue", cmpEqual, "News");
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Company().Header, "OleValue", cmpEqual, "Company"); } 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage().Header, "OleValue", cmpEqual, "Access your browser home page...");
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress().Header, "OleValue", cmpEqual, "Compose Address...");
   
    
}

function Check_ToolBar_InternetForPortfolioTransactionsSecurity_Existence_Of_Controls(module)
{
   if(client != "TD" &&  client != "CIBC" )
  { aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Quotes(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Graphs(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Analysis(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_News(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Company(), "IsVisible", cmpEqual, true); 
    
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Quotes(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Graphs(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Analysis(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_News(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_Company(), "IsEnabled", cmpEqual, true);}
    
    if(module=="transaction"){
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions(), "IsEnabled", cmpEqual, true);
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions(), "IsEnabled", cmpEqual, true);
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions(), "IsVisible", cmpEqual, true);
    }
    else{
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage(), "IsEnabled", cmpEqual, true);
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress(), "IsEnabled", cmpEqual, true);
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress(), "IsVisible", cmpEqual, true);
    }
   
}

function Check_MenuBar_InternetForPortfolioTransactionsSecurity_Properties_French(module)
{
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Quotes().Header, "OleValue", cmpEqual, "Cotes"); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Graphs().Header, "OleValue", cmpEqual, "Graphiques"); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Analysis().Header, "OleValue", cmpEqual, "Analyse"); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_News().Header, "OleValue", cmpEqual, "Nouvelles");
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Company().Header, "OleValue", cmpEqual, "Compagnie");
    if(module=="transaction"){
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePageForTransactions().Header, "OleValue", cmpEqual, "_Aller à la page d'accueil de votre navigateur...");
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddressForTransactions().Header, "OleValue", cmpEqual, "_Composer une adresse...");
    }
    else{
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage().Header, "OleValue", cmpEqual, "Aller à la page d'accueil de votre navigateur...");
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddress().Header, "OleValue", cmpEqual, "Composer une adresse...");
    }
}

function Check_MenuBar_InternetForPortfolioTransactionsSecurity_Properties_English(module)
{
  if(client != "TD" && client!= "CIBC"){
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Quotes().Header, "OleValue", cmpEqual, "Quotes"); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Graphs().Header, "OleValue", cmpEqual, "Graphs"); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Analysis().Header, "OleValue", cmpEqual, "Analysis"); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_News().Header, "OleValue", cmpEqual, "News");
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Company().Header, "OleValue", cmpEqual, "Company");}
    if(module=="transaction"){
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePageForTransactions().Header, "OleValue", cmpEqual, "_Access your browser home page...");
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddressForTransactions().Header, "OleValue", cmpEqual, "_Compose Address...");  
    }
    else{
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage().Header, "OleValue", cmpEqual, "Access your browser home page...");
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddress().Header, "OleValue", cmpEqual, "Compose Address...");  
    }
}

function Check_MenuBar_InternetForPortfolioTransactionsSecurity_Existence_Of_Controls(module)
{
   if(client != "TD" && client!= "CIBC"){
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Quotes(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Graphs(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Analysis(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_News(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Company(), "IsVisible", cmpEqual, true);}
    if(module=="transaction"){
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePageForTransactions(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddressForTransactions(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePageForTransactions(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddressForTransactions(), "IsEnabled", cmpEqual, true);
    }
    else{
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddress(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddress(), "IsEnabled", cmpEqual, true);        
    }
     if(client != "TD" && client!= "CIBC"){
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Quotes(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Graphs(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Analysis(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_News(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_MenuBar_Tools_Internet_Company(), "IsEnabled", cmpEqual, true);}
    
    
}

 //Fonctions  (les points de vérification pour les scripts qui testent btnInternet )pour les modules Dashboard, Models,Relationships,Clients,Accounts,Orders
function Check_MenuBarToolsInternet_Properties()
{
  aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddress(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddress(), "IsEnabled", cmpEqual, true);

  aqObject.CheckProperty(Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage().Header, "OleValue", cmpEqual, GetData(filePath_Common, "Internet", 7, language));
  aqObject.CheckProperty(Get_MenuBar_Tools_Internet_ComposeAddress().Header, "OleValue", cmpEqual, GetData(filePath_Common, "Internet", 8, language));
}

function Check_ToolBarInternet_Properties()
{
  aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress(), "IsEnabled", cmpEqual, true);

  aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage().Header, "OleValue", cmpEqual, GetData(filePath_Common, "Internet", 7, language));
  aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress().Header, "OleValue", cmpEqual, GetData(filePath_Common, "Internet", 8, language));
}


//+++++++++++++++++++++++++++++++MENU OF BTN INTERNET- COMPOSE ADDRESS CHECK POINTS+++++++++++++++++++++++++ 
  //Fonctions  (les points de vérification pour les scripts qui testent btnInternet )
function Check_Internet_ComposeAddress_Properties_French()
{
  aqObject.CheckProperty(Get_WinComposeAddress(), "Title", cmpEqual, "Composer");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunch().Content, "OleValue", cmpEqual, "Lancer...");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
  aqObject.CheckProperty(Get_WinComposeAddress_LblAddress().Text, "OleValue", cmpEqual, "Adresse:");
}

function Check_Internet_ComposeAddress_Properties_English()
{
  aqObject.CheckProperty(Get_WinComposeAddress(), "Title", cmpEqual, "Compose");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunch().Content, "OleValue", cmpEqual, "Launch...");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
  aqObject.CheckProperty(Get_WinComposeAddress_LblAddress().Text, "OleValue", cmpEqual, "Address:");
}

function Check_Internet_ComposeAddress_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunch(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunch(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinComposeAddress_TxtAddress(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComposeAddress_TxtAddress(), "IsEnabled", cmpEqual, true);
}

//++++++++++++++++++++++++++++++++++++++++++++++WIN PRINT CHECK POINTS++++++++++++++++++++++++++++++++++++++
//Fonctions  (les points de vérification pour les scripts qui testent Print)
function Check_Print_Properties_French()
{
 
  aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, GetData(filePath_Common, "Print", 2, language));
  aqObject.CheckProperty(Get_DlgPrint(), "Exists", cmpEqual, true);
  Get_DlgPrint_BtnCancel().Click()
  //EM: Modifié pour CO-90-07-22
  //aqObject.CheckProperty(Get_DlgPrinting(), "WndCaption", cmpEqual, "Impression");
  //aqObject.CheckProperty(Get_DlgPrinting_LblMessage(), "Visible", cmpEqual, true);//Le lbl a été mappé avec la propriété texte, si le composant a été bien trouvé ça veut dire que le texte est correct
   aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual,GetData(filePath_Common, "Print", 3, language));
   aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual,GetData(filePath_Common, "Print", 4, language)); 
}

function Check_Print_Properties_English()
{
//  if(client == "CIBC"){Log.Message("Suite a la correction de l'anomalie : BNC-1278")
//                       aqObject.CheckProperty(Get_DlgError(), "Title", cmpEqual, "Error");
//                       Get_DlgError().Click(Get_DlgError().Width - 200, Get_DlgError().Height - 40);// cliquer sur le bouton OK
//                       
//                      }
//  else{
      aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, GetData(filePath_Common, "Print", 2, language));
      aqObject.CheckProperty(Get_DlgPrint(), "Exists", cmpEqual, true);
      Get_DlgPrint_BtnCancel().Click() 
      //EM: Modifié pour CO-90-07-22
      /*aqObject.CheckProperty(Get_DlgPrinting(), "WndCaption", cmpEqual, "Printing");
      aqObject.CheckProperty(Get_DlgPrinting_LblMessage(), "Visible", cmpEqual, true);*/ //Le lbl a été mappé avec la propriété texte, si le composant a été bien trouvé ça veut dire que le texte est correct     
      aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual,GetData(filePath_Common, "Print", 3, language));
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual,GetData(filePath_Common, "Print", 4, language));  
//    }
}
function Check_Print_Properties()
{
  aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, GetData(filePath_Common, "Print", 2, language));
  Get_DlgPrint_BtnCancel().Click()
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Common, "Print", 3, language)); 
  aqObject.CheckProperty(Get_DlgInformation(), "CommentTag", cmpEqual, GetData(filePath_Common, "Print", 4, language));//Le lbl a été mappé avec la propriété texte, si le composant a été bien trouvé ça veut dire que le texte est correct 
}


//La boîte de dialogue "Impression annulée" diffère pour l'impression de tous les tableaux
function Check_Print_Properties_ForPrintEveryBoard_French()
{
  aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, "Print");
  Get_DlgPrint_BtnCancel().Click();
  aqObject.CheckProperty(Get_DlgPrinting(), "WndCaption", cmpEqual, "Impression"); 
  aqObject.CheckProperty(Get_DlgPrinting_LblMessageForPrintEveryBoard(), "Text", cmpEqual, "Impression annulée");
  aqObject.CheckProperty(Get_DlgPrinting_LblMessageForPrintEveryBoard(), "Visible", cmpEqual, true);
}


function Check_Print_Properties_ForPrintEveryBoard_English()
{
  aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, "Print");
  Get_DlgPrint_BtnCancel().Click();
  aqObject.CheckProperty(Get_DlgPrinting(), "WndCaption", cmpEqual, "Printing"); 
  aqObject.CheckProperty(Get_DlgPrinting_LblMessageForPrintEveryBoard(), "Text", cmpEqual, "Printing cancelled");
  aqObject.CheckProperty(Get_DlgPrinting_LblMessageForPrintEveryBoard(), "Visible", cmpEqual, true);
}


//++++++++++++++++++++++++++++++++++++++++++++++WIN SEARCH MANAGE CHECK POINTS++++++++++++++++++++++++++++++
//Fonctions  (les points de vérification pour les scripts qui testent Search_Manage)
function Check_SearchManage_Properties_French()
{   
  Get_WinSearchCriteriaManager().set_Width(1086);
  Get_WinSearchCriteriaManager().set_Height(355);
  
  aqObject.CheckProperty(Get_WinSearchCriteriaManager().Title, "OleValue", cmpEqual, "Gestionnaire de critères de recherche"); 
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Critères de recherche");
  
  //************************ HEADERS OF COLUMNS**********************************************
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName().Content, "OleValue", cmpEqual, "Nom");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess().Content, "OleValue", cmpEqual, "Accès");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation().Content, "OleValue", cmpEqual, "Création");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule().Content, "OleValue", cmpEqual, "Module");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified().Content, "OleValue", cmpEqual, "Modifié");
  // aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords().DataContext.HeaderName.Text, "OleValue", cmpEqual, "Nb. d'enreg."); //N’existe pas dans automation 9 
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated().Content, "OleValue", cmpEqual, "Généré");
      
   //*************************TEXTE DES BOUTONS**********************************************       
 if (Get_WinSearchCriteriaManager_BtnDisplay().Exists ){aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay().Content, "OleValue", cmpEqual, "Consulter")}
 if (Get_WinSearchCriteriaManager_BtnCreateFromTemplate().Exists ){aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCreateFromTemplate().Content, "OleValue", cmpEqual, "_Créer à partir de...")}
 if (Get_WinSearchCriteriaManager_BtnEdit().Exists){aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnEdit().Content, "OleValue", cmpEqual, "Mo_difier")}

  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAdd().Content, "OleValue", cmpEqual, "Aj_outer");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAddAdvanced().Content, "OleValue", cmpEqual, "Ajouter (avancé)...");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad().Content, "OleValue", cmpEqual, "Char_ger");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnRefresh().Content, "OleValue", cmpEqual, "_Actualiser");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy().Content, "OleValue", cmpEqual, "Copier");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete().Content, "OleValue", cmpEqual, "S_upprimer");     
}

function Check_SearchManage_Properties_English()
{
  Get_WinSearchCriteriaManager().set_Width(1086);
  Get_WinSearchCriteriaManager().set_Height(355);
  
  aqObject.CheckProperty(Get_WinSearchCriteriaManager().Title, "OleValue", cmpEqual, "Search Criteria Manager"); 
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Search Criteria");
  
  //************************ HEADERS OF COLUMNS**********************************************
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName().Content, "OleValue", cmpEqual, "Name");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess().Content, "OleValue", cmpEqual, "Access");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation().Content, "OleValue", cmpEqual, "Creation");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule().Content, "OleValue", cmpEqual, "Module");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified().Content, "OleValue", cmpEqual, "Modified");
  // aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords().DataContext.HeaderName.Text, "OleValue", cmpEqual, "No. of Records");//N’existe pas dans automation 9 
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated().Content, "OleValue", cmpEqual, "Generated");
      
   //*************************TEXTE DES BOUTONS**********************************************       
 if (Get_WinSearchCriteriaManager_BtnDisplay().Exists){aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay().Content, "OleValue", cmpEqual, "Display")}//D_isplay in auto 9
 if (Get_WinSearchCriteriaManager_BtnCreateFromTemplate().Exists ){aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCreateFromTemplate().Content, "OleValue", cmpEqual, "Cr_eate from template...")}
 if (Get_WinSearchCriteriaManager_BtnEdit().Exists ){aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnEdit().Content, "OleValue", cmpEqual, "_Edit")}//_Edit... in auto9

  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAdd().Content, "OleValue", cmpEqual, "_Add"); //A_dd... in automation 9
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAddAdvanced().Content, "OleValue", cmpEqual, "Add (Advanced)..."); //_Add (Advanced)... in automation 9
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad().Content, "OleValue", cmpEqual, "L_oad");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnRefresh().Content, "OleValue", cmpEqual, "_Refresh");//_Regenerate in auto9
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnClose().Content, "OleValue", cmpEqual, "_Close");
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy().Content, "OleValue", cmpEqual, "Copy");//Co_py... in auto9
  aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete().Content, "OleValue", cmpEqual, "De_lete");
}

function Check_SearchManage_Existence_Of_Controls()
{
      //la présence des contrôles
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAdd(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAddAdvanced(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnClose(), "IsEnabled", cmpEqual, true);
    
    //*******LA VÉRIFICATION DE VISIBILITÉ DES BOUTONS DÉPENDANT D’UNE LIGNE SÉLECTIONNÉE****** 
   if (Get_WinSearchCriteriaManager_BtnDisplay().Exists)
    {
        if (Get_WinSearchCriteriaManager_BtnDisplay().VisibleOnScreen){  
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay(), "IsEnabled", cmpEqual, true);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, true);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete(), "IsEnabled", cmpEqual, false);
        }
    }
  
   if (Get_WinSearchCriteriaManager_BtnCreateFromTemplate().Exists)
    {
         if (Get_WinSearchCriteriaManager_BtnCreateFromTemplate().VisibleOnScreen){  
              aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCreateFromTemplate(), "IsEnabled", cmpEqual, true);
              aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, false);
              aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete(), "IsEnabled", cmpEqual, false);
              aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad(), "IsEnabled", cmpEqual, false); 
         } 
    }
    else
    {aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnRefresh(), "IsEnabled", cmpEqual, true);}

    if (Get_WinSearchCriteriaManager_BtnEdit().Exists)
    {
        if(Get_WinSearchCriteriaManager_BtnEdit().VisibleOnScreen){
              aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnEdit(), "IsEnabled", cmpEqual, true);
              aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, true);   
              aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete(), "IsEnabled", cmpEqual, false);   
          }
    }
}


//************************************************************************ORDERS********************************************************************************
//**************************************************************************************************************************************************************

//***********************************************************WIN ORDERS MODULE CHECK POINTS*********************************************************************

//Fonctions  (les points de vérification , btnCreateBuyOrder )
function Check_Properties_FinancialInstrumentSelector(language,type)
{    
    
    if(type=="buy"){
      aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",109,language));
    }
    
    if(type=="sell"){
      aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",116,language));
    }
    
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoStocks().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Financial_Instrument_Selector",3,language));
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoStocks(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoStocks(), "IsEnabled", cmpEqual, true)
    
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoFixedIncome().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Financial_Instrument_Selector",4,language));
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoFixedIncome(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoFixedIncome(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoMutualFunds().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Financial_Instrument_Selector",5,language));
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoMutualFunds(), "IsChecked", cmpEqual, false);
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_RdoMutualFunds(), "IsEnabled", cmpEqual, true);
    
    
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_BtnCancel().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Financial_Instrument_Selector",8,language));
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_BtnCancel(), "IsEnabled", cmpEqual, true);
       
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_BtnOK().Content, "OleValue", cmpEqual, GetData(filePath_Common,"Financial_Instrument_Selector",7,language));
    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector_BtnOK(), "IsEnabled", cmpEqual, false);
      
}

//***********************************************************WIN ORDERS MODULE STOCKS CHECK POINTS********************************************************************* 
//Fonctions  (les points de vérification , btnCreateBuyOrder -Stocks )

/** 
    Cette fonction vérifie les composants qui sont dans les fenêtres Buy Order et Sell Order .  
    Elle fonction pour tous les modules et pour trois types d’ordre. 
    type – pour distinguer entre les  Stocks, Fixed Income et Mutual Funds
    module – pour distinguer entre les différents modules à partir desquelles on lance un script 
    order - pour distinguer entre la fenêtre sell et buy 
    calledFrom - le bouton à partir duquel la fenêtre a été ouverte
    orderStatus - le statut de l'ordre
*/

function Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus,currency)
{
    Get_WinOrderDetail().Set_Width(900);
    Get_WinOrderDetail().Set_Height(635);
  
    //***************************************************   Vérification de la partie en haut « BUY » **************************************
    if(calledFrom == "CFO"){
      aqObject.CheckProperty(Get_WinOrderDetail(), "Title", cmpContains, GetData(filePath_Common, "Create_Order_DifType", 117, language)); 
    }else{
      aqObject.CheckProperty(Get_WinOrderDetail(), "Title", cmpContains, GetData(filePath_Common, "Create_Order_DifType", 2, language)); 
    }
    if ((calledFrom == "CFO") || (calledFrom == "View")){
        aqObject.CheckProperty(Get_WinOrderDetail_CmbAccount(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_CmbAccount(), "IsEnabled", cmpEqual, false);
        
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 4, language));
            aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsVisible", cmpEqual, true);
            Log.Message("Corrigé sur Be-16. Selon Mammoudou: Pr utilisateur, celui  qui a le droit de Trader, c`est à dire si la PREF_TRADER_ACCESS est activé pour lui et est soit un SysAdmin ou FirmAdmin.Ce qui n`est pas le cas pour le REAGAR : donc, si anomalie Ça sera cela. ")
            aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsEnabled", cmpEqual, false);
        }
    } else {
        aqObject.CheckProperty(Get_WinOrderDetail_BtnSave(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 3, language));
        aqObject.CheckProperty(Get_WinOrderDetail_BtnSave(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_BtnSave(), "IsEnabled", cmpEqual, true);
    
        aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 4, language));
        aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsEnabled", cmpEqual, true);
    }
    
    aqObject.CheckProperty(Get_WinOrderDetail_BtnCancel(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 5, language));
    aqObject.CheckProperty(Get_WinOrderDetail_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderDetail_BtnCancel(), "IsEnabled", cmpEqual,true);
    
    if (orderStatus == "TraderApproval"){
        aqObject.CheckProperty(Get_WinOrderDetail_BtnReject(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 87, language));
		if(client!="RJ"){
            Log.Message("Jira CROES-10224");        
			aqObject.CheckProperty(Get_WinOrderDetail_BtnReject(), "IsVisible", cmpEqual, true);
			aqObject.CheckProperty(Get_WinOrderDetail_BtnReject(), "IsEnabled", cmpEqual, false);
		}
        
        if ((type == "stocks") || (type == "fixedIncome")){
            aqObject.CheckProperty(Get_WinOrderDetail_BtnApprove(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 86, language));
			if(client!="RJ"){
                Log.Message("Jira CROES-10571");             
				aqObject.CheckProperty(Get_WinOrderDetail_BtnApprove(), "IsVisible", cmpEqual, true);
				aqObject.CheckProperty(Get_WinOrderDetail_BtnApprove(), "IsEnabled", cmpEqual, false);
			}
        }
    }
    
    
    if (type == "stocks"){
        
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 115, language));
        } else {
            if (order == "buy"){
                aqObject.CheckProperty(Get_WinStocksOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 110, language));
            }
      
            if (order == "sell"){
                aqObject.CheckProperty(Get_WinStocksOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 113, language));
            }
        }
      
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblAccount(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 8, language));
    
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblQuantity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 9, language));
        
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, true);
        }
    }
    
    if (type == "fixedIncome"){
  
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 114, language));
        } else {
            if (order == "buy"){
              aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 107, language));
            }
    
            if(order == "sell"){
                aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 111, language));
            }
        }
        
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblAccount(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 8, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblQuantity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 9, language));
        
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblFaceValue().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",53,language));
        
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, true);
        }
    }
  
    if (type == "mutualFunds"){
  
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 83, language));
        } else {
            if (order == "buy"){
                aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 108, language));
            }
    
            if (order == "sell"){
                aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 112, language));
            }
        }
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblAccount(), "Text", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",8,language));
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblQuantity(), "Text", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",9,language));
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsEditable", cmpEqual, false);
        
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, false);
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsEnabled", cmpEqual, true);
        }
    }
    
    if ((calledFrom != "CFO") && (calledFrom != "View")){
    
        aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_CmbTypePicker(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey(), "IsEnabled", cmpEqual, true);
  
        if ((module == "titre") || (module == "orders")){ //Exécution du script a partir du module  «Titre» et «Orders»
            aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_BtnSearch(), "IsEnabled", cmpEqual, false);
        }
  
        if (module == "portefeuille"){ //Exécution du script a partir du module  «portefeuille»
            aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_BtnSearch(), "IsEnabled", cmpEqual, true);
        }
  
        aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_TxtName(), "IsVisible", cmpEqual, true);
      
        aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_CmbTypePicker(), "IsEnabled", cmpEqual, true);

        if (module == "orders" || (module == "titre")){ //Exécution du script a partir du module  «Orders» et  «Titre»
            aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_BtnSearch(), "VisibleOnScreen", cmpEqual, true);
        }
  
        if ((module == "portefeuille")){ //Exécution du script a partir du module «portefeuille»
           // aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_BtnSearch(), "IsEnabled", cmpEqual, true);
        }
    }
    
    if (type == "mutualFunds"){
       Log.message("Selon Karima: les deux points qui manquent, Jira GDO-1817");
       aqObject.CheckProperty(Get_WinOrderDetail_LblSecurity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 120, language));// Selon Karima, on devrait avoir "Fonds" 

    }else{
       Log.message("Selon Karima: les deux points qui manquent, Jira GDO-1817");
       aqObject.CheckProperty(Get_WinOrderDetail_LblSecurity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 10, language));
    }
    
    if ((calledFrom == "CFO") || (calledFrom == "View")){
        aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey(), "IsEnabled", cmpEqual, false);
    } else {
        aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey(), "IsEnabled", cmpEqual, true);
    }
    aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_LblSymbol(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 11, language));
    aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtSymbol(), "IsVisible", cmpEqual, true);
    


//****************il adapter les vérifications suite aux changements faits dans les fenêtres "créer un ordre d'achat", "créer un ordre de vente" ************
//***********************************************************************************************************************************************************


    if (type == "stocks"){
        aqObject.CheckProperty(Get_WinStocksOrderDetail_GrpSecurity_LblMarket(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 12, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_GrpSecurity_TxtMarket(), "IsVisible", cmpEqual, true);
    
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblPrice(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 13, language));

//        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 15, language));
//        if (calledFrom == "View"){
//            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "IsEnabled", cmpEqual, false);
//        } else {
//            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "IsEnabled", cmpEqual, true);
//        }
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "IsChecked", cmpEqual, true);
//  
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 16, language));
//        if (calledFrom == "View"){
//            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "IsEnabled", cmpEqual, false);
//        } else {
//            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "IsEnabled", cmpEqual, true);
//        }
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "IsChecked", cmpEqual, false);
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtAtPrice(), "IsEnabled", cmpEqual, false);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblExpiration(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 17, language));
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 18, language));
        if (calledFrom == "View"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "IsEnabled", cmpEqual, true);
        }
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "IsChecked", cmpEqual, true);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 19, language));
//        if (calledFrom == "View"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "IsEnabled", cmpEqual, false);
//        } else {
//            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "IsEnabled", cmpEqual, true);
//        }
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "IsChecked", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_DtpExpirationSpecificDate(), "IsEnabled", cmpEqual, false);
    
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblSolicited(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 20, language));
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 21, language));
        //aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "IsChecked", cmpEqual, true);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 22, language));
        //aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false);
    
    
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkOnStop(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 24, language));
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkOnStop(), "IsEnabled", cmpEqual, false);
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkStopLimit(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 25, language));
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkStopLimit(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 26, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "IsEnabled", cmpEqual, false);
  
//        aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtStopLimit(), "IsEnabled", cmpEqual, false);
    }
    
//*********************************************************************************************************************************************************************
    
    if (type == "fixedIncome"){
        //Price
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPrice().Text, "OleValue", cmpEqual, aqConvert.VarToStr(GetData(filePath_Common, "Create_Order_DifType", 52, language)));  //Story GDO-769  
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPriceIA(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 54, language)); 
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPriceClient(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 55, language)); 
    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPriceClient(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 55, language)); 
        //Yield
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYield(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 56, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYieldIA(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 57, language));    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYieldIASAPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 58, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYieldIAANNPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 59, language));
    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblClient(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 60, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblClientSAPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 61, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblClientANNPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 62, language));
    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblSolicited(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 20, language));
        
//il faut adapter les vérifications suite aux changements faits dans les fenêtres
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoSolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 21, language));
        //aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoSolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoSolicited(), "IsChecked", cmpEqual, true);//-------------------------A.V false
  
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoUnsolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 22, language));
        //aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoUnsolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false); 
    }
  
    if (type == "mutualFunds"){
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblDistribution(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 69, language)); //YR CROES-8053
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 70, language)); //YR CROES-8053
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "IsEnabled", cmpEqual, true);//YR CROES-8053
        }
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "IsChecked", cmpEqual, true);//YR CROES-8053
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 71, language));//YR CROES-8053
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "IsEnabled", cmpEqual, true);//YR CROES-8053
        }
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "IsChecked", cmpEqual, false);//YR CROES-8053
    
//il adapter les vérifications suite aux changements faits dans les fenêtres "créer un ordre d'achat", "créer un ordre de vente" 
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblSolicited(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 20, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoSolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 21, language));
        //aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoSolicited(), "IsEnabled", cmpEqual, false); 
        
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoSolicited(), "IsChecked", cmpEqual,true);
    
//il adapter les vérifications suite aux changements faits dans les fenêtres "créer un ordre d'achat", "créer un ordre de vente" 
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoUnsolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 22, language));
        //aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoUnsolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false);
    
        if (order == "buy"){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblFrontEndFund(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 72, language));
        }
       
        if (order == "sell"){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblFrontEndFund(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 80, language));
        }
      
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoGross(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 73, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoGross(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoGross(), "IsChecked", cmpEqual, true); //A enlever?? Peut varier pour les ordres existants
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoNet(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 74, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoNet(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoNet(), "IsChecked", cmpEqual,false); //A enlever?? Peut varier pour les ordres existants
    }
    
    
    //*********************** L’onglet "Comptes sous-jacents" (Underlying Accounts) tab *****************************
    
    if ((calledFrom == "CFO") || (calledFrom == "View")){
    
        //Vérification du titre de l'onglet
        Get_WinOrderDetail_TabUnderlyingAccounts().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 91, language));
        
        //Vérification des boutons dans l'onglet
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 93, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(), "IsEnabled", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 94, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(), "IsEnabled", cmpEqual, false);
        
        //Vérification des en-têtes de colonne de l'onglet 
        Get_WinOrderDetail_TabUnderlyingAccounts_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 96, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChName(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 97, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChIACode(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 98, language));
        Log.Message("BNC-2243")
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChCurrency(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 99, language));  //EM: 90-06-Be-13 datapool modifié selon le Jira BNC-2243
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChRequestedQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 100, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChAllocatedQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 101, language));
        Log.Message("BNC-2243")
        if(currency == "USD")
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChTotalValueUSD(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 104, language));  //EM: 90-07-CO-18 modifié selon le Jira 
        else
            aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 102, language));  //EM: 90-06-Be-13 datapool modifié selon le Jira BNC-2243
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChSource(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 103, language));
    }
  
    //*************************************************** L’onglet "Fills" **************************************
    if ((type == "stocks") || (type == "fixedIncome")){
        
        Get_WinOrderDetail_TabFills().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 28, language));
        
        Get_WinOrderDetail_TabFills_ChExecutionDate().ClickR(); //Story GDO-686
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
        //aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChStatus(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 29, language));//Story GDO-686
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChExecutionDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 32, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSettlementDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 33, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 34, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSymbol(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 35, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChPrice(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 36, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChTotal(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 37, language));
        
        //Vérification du contenu de la liste. Le nombre de colonnes qu’on peut ajouter
        Get_WinOrderDetail_TabFills_ChExecutionDate().ClickR();//Story GDO-686
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 3);
      
        Get_WinOrderDetail_TabFills_ChExecutionDate().ClickR();
        while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true){
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
            Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
            //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
            Get_WinOrderDetail_TabFills_ChExecutionDate().ClickR();
        }
    
        //aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChStatus(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 29, language));Story GDO-686
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChOurRole(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 30, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChMarket(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 31, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChExecutionDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 32, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSettlementDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 33, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 34, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSymbol(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 35, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChPrice(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 36, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChTotal(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 37, language));
    }
  
  
    //*************************************************** L’onglet "Warnings" ***********************************
    Get_WinOrderDetail_TabWarnings().Click();
    aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 39, language));
  
    aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings_ChLevel(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 40, language));
    aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings_ChMessage(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 41, language));
  
  
    //*************************************************** L’onglet "Order Log" ***********************************
    Get_WinOrderDetail_TabOrderLog().Click();
  
    aqObject.CheckProperty(Get_WinOrderDetail_TabOrderLog(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 43, language));  
  
  
   //*************************************************** L’onglet "Notes" ***************************************
    if ((type == "stocks") || (type == "fixedIncome")){
        Get_WinOrderDetail_TabNotes().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabNotes(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 45, language));
  
        aqObject.CheckProperty(Get_WinOrderDetail_TabNotes_GrpNotes(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 45, language));
  
        if(type=="stocks"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_LblTradingNotes(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 47, language));
        }
      
        if(type=="fixedIncome"){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TabNotes_GrpNotes_LblClientNotes(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 64, language));
        }
      
        if(type=="stocks"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes(), "IsVisible", cmpEqual, true);
        }
      
        if(type=="fixedIncome"){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TabNotes_GrpNotes_TxtClientNotes(), "IsVisible", cmpEqual, true);
        }
    }
}

//***********************************************************WIN ADD OR DISPLAY ANACTIVE CRITERION *********************************************************************
//********************************************************************************************************************************************************************** 
//Fonctions  (les points de vérification , Add Search Criterion )

function Check_AddOrDisplayAnActiveCriterion_Properties_French()
{
  aqObject.CheckProperty(Get_WinAddSearchCriterion().Title, "OleValue", cmpEqual, "Ajouter un critère de recherche");
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Content, "OleValue", cmpEqual, "Sauvegarder et _actualiser"); // Sauvegarder et _régénérerdans automation 10
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSave().Content, "OleValue", cmpEqual, "Sau_vegarder");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblName().Text, "OleValue", cmpEqual, "Nom:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblDescription().Text, "OleValue", cmpEqual, "Description:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblAccess().Text, "OleValue", cmpEqual, "Accès:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblModule().Text, "OleValue", cmpEqual, "Module:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblDefinition().Text, "OleValue", cmpEqual, "Définition:");
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkReadOnly().Content, "OleValue", cmpEqual, "Lecture seulement");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkAddParentheses().Content, "OleValue", cmpEqual, "Ajouter des parenthèses");
}

function Check_AddOrDisplayAnActiveCriterion_Properties_English()
{
  aqObject.CheckProperty(Get_WinAddSearchCriterion().Title, "OleValue", cmpEqual, "Add Search Criterion");
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Content, "OleValue", cmpEqual, "_Save and Refresh"); //  _Save and Regenerate dans automation 9
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSave().Content, "OleValue", cmpEqual, "Sa_ve");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblName().Text, "OleValue", cmpEqual, "Name:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblDescription().Text, "OleValue", cmpEqual, "Description:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblAccess().Text, "OleValue", cmpEqual, "Access:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblModule().Text, "OleValue", cmpEqual, "Module:");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblDefinition().Text, "OleValue", cmpEqual, "Definition:");
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkReadOnly().Content, "OleValue", cmpEqual, "Read Only");
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkAddParentheses().Content, "OleValue", cmpEqual, "Add Parentheses");
  
}

function Check_Check_AddOrDisplayAnActiveCriterion_Properties_French_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSaveAndRegenerate(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSaveAndRegenerate(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSave(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnSave(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnCancel(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_BtnCancel(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_TxtName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_TxtName(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_TxtDescription(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_TxtDescription(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_CmbAccess(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_CmbAccess(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_CmbModule(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_CmbModule(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkReadOnly(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkReadOnly(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkAddParentheses(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkAddParentheses(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblDefinition(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddSearchCriterion_LblDefinition(), "IsVisible", cmpEqual, true);
    
}

//***********************************************************WIN ADD FILTER *********************************************************************
//***********************************************************************************************************************************************
//Fonctions  (les points de vérification pour les scripts qui testent Add_Filter)
function Check_AddFilter_Properties_French()
{
    aqObject.CheckProperty(Get_WinAddFilter().Title, "OleValue", cmpEqual, "Ajouter un filtre");
    //aqObject.CheckProperty(Get_WinAddFilter().Title, "OleValue", cmpEqual, Project.Variables.Var1.Item(1,0))
   
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK().Content.Text, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel().Content.Text, "OleValue", cmpEqual, "Annuler");
    
    aqObject.CheckProperty(Get_WinAddFilter_LblName().Content, "OleValue", cmpEqual, "Nom"); //Description dans automation 9 
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition().Header, "OleValue", cmpEqual, "Condition");
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblField().Content, "OleValue", cmpEqual, "Champ:");
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblOperator().Content, "OleValue", cmpEqual, "Opérateur:");
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblValue().Content, "OleValue", cmpEqual, "Valeur:");   
    
}

function Check_AddFilter_Properties_English()
{
    aqObject.CheckProperty(Get_WinAddFilter().Title, "OleValue", cmpEqual, "Add Filter");  
    
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK().Content.Text, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel().Content.Text, "OleValue", cmpEqual, "Cancel");
    
    aqObject.CheckProperty(Get_WinAddFilter_LblName().Content, "OleValue", cmpEqual, "Name"); //Description  dans automation 9
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition().Header, "OleValue", cmpEqual, "Condition");
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblField().Content, "OleValue", cmpEqual, "Field:");   
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblOperator().Content, "OleValue", cmpEqual, "Operator:");
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_LblValue().Content, "OleValue", cmpEqual, "Value:"); 
    
}

function Check_AddFilter_Existence_Of_Controls()
{
    Delay(200);
    aqObject.CheckProperty(Get_WinAddFilter_TxtName(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_TxtName(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbField(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbField(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbOperator(), "IsVisible", cmpEqual, true);  
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_CmbOperator(), "IsEnabled", cmpEqual, true); 
       
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_TxtValue(), "IsVisible", cmpEqual, true);  
    aqObject.CheckProperty(Get_WinAddFilter_GrpCondition_TxtValue(), "IsEnabled", cmpEqual, true);
    if(client !== "US" ){
    aqObject.CheckProperty(Get_WinAddFilter_BtnLanguages(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnLanguages(), "IsEnabled", cmpEqual, true);}
    
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinAddFilter_BtnCancel(), "IsEnabled", cmpEqual, true);
}


 //Fonctions  (les points de vérification pour les scripts qui testent AddFilterForRelationshipsClientsAccounts)
function Check_AddFilterForRelationshipsClientsAccounts_Properties(language)
{
  aqObject.CheckProperty(Get_WinCRUFilter(), "Title", cmpEqual, GetData(filePath_Common,"Add_Filter",2,language));
  
  aqObject.CheckProperty(Get_WinCRUFilter_BtnOK(), "Content", cmpEqual,GetData(filePath_Common,"Add_Filter",9,language));
  aqObject.CheckProperty(Get_WinCRUFilter_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinCRUFilter_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinCRUFilter_BtnCancel(), "Content", cmpEqual, GetData(filePath_Common,"Add_Filter",10,language));
  aqObject.CheckProperty(Get_WinCRUFilter_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinCRUFilter_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition(), "Header", cmpEqual, GetData(filePath_Common,"Add_Filter",3,language));
  
  aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_LblName(), "Text", cmpEqual, GetData(filePath_Common,"Add_Filter",4,language));
  aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_TxtName(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_TxtName(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_LblAccess(), "Text", cmpEqual, GetData(filePath_Common,"Add_Filter",5,language));
  aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_CmbAccess(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_CmbAccess(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition(), "Header", cmpEqual, GetData(filePath_Common,"Add_Filter",6,language));
  
  aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_LblField(), "Text", cmpEqual, GetData(filePath_Common,"Add_Filter",7,language));
  aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbField(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbField(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_LblOperator(), "Text", cmpEqual, GetData(filePath_Common,"Add_Filter",8,language));
  aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbOperator(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbOperator(), "IsVisible", cmpEqual, true);
  
}


//***********************************************************WIN Quick_Filters Manage *********************************************************************
//*********************************************************************************************************************************************************
 //Fonctions  (les points de vérification pour les scripts qui testent Quick_Filters)
function Check_QuickFiltersManage_Properties_French(module)
{
     aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, "Gestionnaire de filtres");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Filtres");
     //Les btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd().Content.Text, "OleValue", cmpEqual, "_Ajouter...");
     if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
        aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay().Content.Text, "OleValue", cmpEqual, "Co_nsulter");
     }
     else{
       if(module=="transactions"){
        aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit().Content.Text, "OleValue", cmpEqual, "M_odifier...");
       }       
     }
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Content.Text, "OleValue", cmpEqual, "S_upprimer");    
     aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose().Content.Text, "OleValue", cmpEqual, "_Fermer");
     
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView(), "Header", cmpEqual, "Affichage");
     //Les radio btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters().Content, "OleValue", cmpEqual, "_Tous les filtres");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters().Content, "OleValue", cmpEqual, "Filtres _firme"); // YR: Corrigé suite à la réponse de Karima. Avant pour CX Get_WinQuickFiltersManager_GrpView_RdoGlobalFilters() ??? Est-ce que les filtres sont toujours globaux
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters().Content, "OleValue", cmpEqual, "_Mes filtres");
      
}

function Check_QuickFiltersManage_Properties_English(module)
{
     aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, "Filters Manager");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Filters");
     //Les btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd().Content.Text, "OleValue", cmpEqual, "A_dd...");
     if (client == "BNC" ){
        aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay().Content.Text, "OleValue", cmpEqual, "D_isplay");
     }
     else{
      if(module=="transactions"){
        aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit().Content.Text, "OleValue", cmpEqual, "_Edit...");
      }
     }
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Content.Text, "OleValue", cmpEqual, "De_lete");    
     aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose().Content.Text, "OleValue", cmpEqual, "_Close");
     
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView(), "Header", cmpEqual, "View");
     //Les radio btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters().Content, "OleValue", cmpEqual, "_All Filters");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters().Content, "OleValue", cmpEqual, "_Firm Filters"); // ??? Est-ce que les filtres sont toujours globaux
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters().Content, "OleValue", cmpEqual, "_My Filters");

}

function Check_QuickFiltersManage_Existence_Of_Controls(module)
{
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "IsChecked", cmpEqual, true);
    
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters(), "IsVisible", cmpEqual, true); //YR: Corrigé suite à la réponse de Karima .Avant pour CX Get_WinQuickFiltersManager_GrpView_RdoGlobalFilters()
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters(), "IsEnabled", cmpEqual, true); //Avant Get_WinQuickFiltersManager_GrpView_RdoGlobalFilters()
   
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd(), "IsEnabled", cmpEqual, true);
   
   if (client == "BNC" ){
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay(), "IsEnabled", cmpEqual, true);
   }
   else{ //Valide pour RJ car il a un filtere Test qu'on peut Modifier et Supprimer 
    if(module=="transactions"){
       aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit(), "IsEnabled", cmpEqual, true);
     }
     else{// module ordres RJ
       aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay(), "IsEnabled", cmpEqual, true);
     }
   }
   
   aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true); 
   if (client == "BNC" ){
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, false);
   }
   else{
     if(module=="transactions"){
       aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, true);
     }
     else{// module ordres RJ
       aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, false);
     }
   }
   
}

//********************************************UNDER.PERFOMANCE (Module Models), PERFOMANCE (Module Clients)***********************************************
//********************************************************************************************************************************************************
 //Fonctions  (les points de vérification pour les scripts qui testent Under.Perfomance)
function Check_Properties_Performance_French(module)
{
  if(module=="modeles"){
    aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpEqual, "Performance des comptes sous-jacents au modèle: ~M-0000S-0")}
   
  if(module=="clients"){
    aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpEqual, "Performance du client: 1CALCUL SCORE, 800300")}
   
  if(module=="accounts"){
    aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpStartsWith, "Performance du compte:")
  }  
    
   aqObject.CheckProperty(Get_WinPerformance_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
   //Period
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances().Header, "OleValue", cmpEqual, "Performance");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod().Header, "OleValue", cmpEqual, "Période");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "wItemList", cmpEqual, "Cumulative|Fixe");
   //Accounts converted to
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo().Header, "OleValue", cmpEqual, "Comptes convertis en");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency().Content, "OleValue", cmpEqual, "Défaut : CAD");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "wItemList", cmpEqual, "CAD|EUR|NOK|SEK|USD");
   //Method
   if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod().Header, "OleValue", cmpEqual, "Méthode");
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "wItemList", cmpEqual, "Rendement pondéré dans le temps|Rendement pondéré en dollars");
   }
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblFrom().Content, "OleValue", cmpEqual, "Du:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblTo().Content, "OleValue", cmpEqual, "Au:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod1().Text, "OleValue", cmpEqual, "3 Mois");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod2().Text, "OleValue", cmpEqual, "6 Mois");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod3().Text, "OleValue", cmpEqual, "1 An");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod4().Text, "OleValue", cmpEqual, "Depuis le début");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriodOther().Text, "OleValue", cmpEqual, "Autre");
   //Net of fees return
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNet().Content, "OleValue", cmpEqual, "Net:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetROIPercent().Content, "OleValue", cmpEqual, "RCI (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetStandardDeviationPercent().Content, "OleValue", cmpEqual, "Écart type (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetSharpeIndex().Content, "OleValue", cmpEqual, "Indice de Sharpe")
   
      //Missing in Automation 9 
//   //Gross of Fees Return
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGross().Content, "OleValue", cmpEqual, "Brut:");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossROIPercent().Content, "OleValue", cmpEqual, "RCI (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossStandardDeviationPercent().Content, "OleValue", cmpEqual, "Écart type (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossSharpeIndex().Content, "OleValue", cmpEqual, "Indice de Sharpe");
//   
   //tab Perfomance Graph
   Get_WinPerformance_TabPerformanceGraph().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph().Header, "OleValue", cmpEqual, "Graphique de performance");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph_LblGraphTitle().Text, "OleValue", cmpEqual, "RCI (%) (Net)");
   Get_WinPerformance_TabPerformanceHistory().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_LblCurrencyMessage().Content, "OleValue", cmpEqual, "Les montants sont affichés dans la devise du compte (CAD)");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChTotalValue().Content, "OleValue", cmpEqual, "Valeur totale");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChCashFlow().Content, "OleValue", cmpEqual, "Mouv. encaisse");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChNetROIPercent().Content, "OleValue", cmpEqual, "RCI net (%)");
   
    //Missing in Automation 9 
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChGrossROIPercent().Content, "OleValue", cmpEqual, "RCI brut (%)");
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChFees().Content, "OleValue", cmpEqual, "Frais");
   
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow().Content, "OleValue", cmpEqual, "_Mouvements d'encaisse");
   
    //tab Default Indices (%)
   if(client=="RJ"){   
     if( module=="relationships"){
         Get_WinPerformance_TabDefaultIndices().Click()
         aqObject.CheckProperty(Get_WinPerformance_TabDefaultIndices(), "IsSelected", cmpEqual, true);
         aqObject.CheckProperty(Get_WinPerformance_TabDefaultIndices().Header, "OleValue", cmpEqual, "Indices par défaut (%)");
     }
   }
}

function Check_Properties_Performance_English(module)
{
  if(module=="modeles"){
   aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpEqual, "Model's Underlying Accounts Performance: ~M-0000S-0")}
  
  if(module=="clients"){
   aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpEqual, "Client Performance: 1CALCUL SCORE, 800300")}
   
  if(module=="account"){
    aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpStartsWith, "Account Performance:")
  }
   
   aqObject.CheckProperty(Get_WinPerformance_BtnClose().Content, "OleValue", cmpEqual, "_Close");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances().Header, "OleValue", cmpEqual, "Performance");
   //Period
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod().Header, "OleValue", cmpEqual, "Period");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "wItemList", cmpEqual, "Cumulative|Fixed");
   //Accounts converted to
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo().Header, "OleValue", cmpEqual, "Accounts converted to");
   /*if( client == "US" ){
   if(module == "Relationships"){
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency().Content, "OleValue", cmpEqual, "Default : USD");
   } 
   else{
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency().Content, "OleValue", cmpEqual, "Default : CAD");}}*/
  // else{
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency().Content, "OleValue", cmpEqual, "Default : CAD");//}
   if(client == "CIBC"){aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "wItemList", cmpEqual, "CAD|CHF|EUR|GBP|HKD|JPY|MEX|NOK|SEK|SGD|USD");}
   else {aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "wItemList", cmpEqual, "CAD|EUR|NOK|SEK|USD");}
    //Method
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod().Header, "OleValue", cmpEqual, "Method");
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "wItemList", cmpEqual, "Time-Weighted Return|Money-Weighted Return");
   }
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblFrom().Content, "OleValue", cmpEqual, "From:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblTo().Content, "OleValue", cmpEqual, "To:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod1().Text, "OleValue", cmpEqual, "3 Months");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod2().Text, "OleValue", cmpEqual, "6 Months");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod3().Text, "OleValue", cmpEqual, "1 Year");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod4().Text, "OleValue", cmpEqual, "Since Inception");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriodOther().Text, "OleValue", cmpEqual, "Other");
   //Net of fees return
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNet().Content, "OleValue", cmpEqual, "Net of Fees Return:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetROIPercent().Content, "OleValue", cmpEqual, "ROI (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetStandardDeviationPercent().Content, "OleValue", cmpEqual, "Standard Deviation (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetSharpeIndex().Content, "OleValue", cmpEqual, "Sharpe Index")
   
//    //Missing in Automation 9   
//   //Gross of Fees Return
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGross().Content, "OleValue", cmpEqual, "Gross of Fees Return:");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossROIPercent().Content, "OleValue", cmpEqual, "ROI (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossStandardDeviationPercent().Content, "OleValue", cmpEqual, "Standard Deviation (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossSharpeIndex().Content, "OleValue", cmpEqual, "Sharpe Index");
   
   //tab Perfomance Graph
   Get_WinPerformance_TabPerformanceGraph().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph().Header, "OleValue", cmpEqual, "Performance Graph");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph_LblGraphTitle().Text, "OleValue", cmpEqual, "ROI (%) (Net of Fees)");
   
   Get_WinPerformance_TabPerformanceHistory().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory(), "IsSelected", cmpEqual, true);
  /* if( client == "US" ){
   if(module == "Relationships"){aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_LblCurrencyMessage().Content, "OleValue", cmpEqual, "Amounts are displayed in the account currency (USD)");}
   else {
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_LblCurrencyMessage().Content, "OleValue", cmpEqual, "Amounts are displayed in the account currency (CAD)");}}*/
   //else{
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_LblCurrencyMessage().Content, "OleValue", cmpEqual, "Amounts are displayed in the account currency (CAD)");
   //}
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChTotalValue().Content, "OleValue", cmpEqual, "Total Value");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChCashFlow().Content, "OleValue", cmpEqual, "Cash Flow");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChNetROIPercent().Content, "OleValue", cmpEqual, "Net ROI (%)");
   
   //Missing in Automation 9 
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChGrossROIPercent().Content, "OleValue", cmpEqual, "Gross ROI (%)");
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChFees().Content, "OleValue", cmpEqual, "Fees");
   
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow().Content, "OleValue", cmpEqual, "Cash _Flow");
   
//   //tab Default Indices (%)   Après la discussion avec Zakaria. Le code est commenté suite à la nouvelle BD.
//   if(client=="RJ"){   
//    if( module=="relationships"){
//       Get_WinPerformance_TabDefaultIndices().Click()
//       aqObject.CheckProperty(Get_WinPerformance_TabDefaultIndices(), "IsSelected", cmpEqual, true);
//       aqObject.CheckProperty(Get_WinPerformance_TabDefaultIndices().Header, "OleValue", cmpEqual, "Default Indices (%)");
//     }
//   }
}

function Check_Performance_Existence_Of_Controls(module)
{
     aqObject.CheckProperty(Get_WinPerformance_BtnClose(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_BtnClose(), "IsEnabled", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "IsReadOnly", cmpEqual, false);
     if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
       aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "IsReadOnly", cmpEqual, false);
     }
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherFrom(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherFrom(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherTo(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherTo(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetROIPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetROIPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetROIPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetROIPercent(), "IsVisible", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetSharpeIndex(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetSharpeIndex(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetSharpeIndex(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetSharpeIndex(), "IsVisible", cmpEqual, true);

     
//    //Missing in Automation 9  
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1GrossROIPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2GrossROIPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3GrossROIPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4GrossROIPercent(), "IsVisible", cmpEqual, true);
     //aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossROIPercent(), "IsVisible", cmpEqual, true);
     
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     //aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1GrossSharpeIndex(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2GrossSharpeIndex(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3GrossSharpeIndex(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4GrossSharpeIndex(), "IsVisible", cmpEqual, true);
     //aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossSharpeIndex(), "IsVisible", cmpEqual, true);
     
    Get_WinPerformance_TabPerformanceHistory().Click()
    aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow(), "IsVisible", cmpEqual, true); 
    if(module=="modeles" || module == "relationships"){
      aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow(), "IsEnabled", cmpEqual, true);}
    if(module=="clients" || module == "accounts" ){
      aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow(), "IsEnabled", cmpEqual, false);}     
    if (module == "accounts"){
      aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnDailyDataForAccount(), "IsVisible", cmpEqual, true); 
    }
}



//***********************************************************  WIN DETAILED INFO   ************************************************************************
//********************************************************************************************************************************************************
 //Fonctions  (les points de vérification pour les scripts qui testent DETAILED INFO)
 
 // WIN DETAILED INFO - L'ONGLET INFO 
function Check_Properties_DetailedInfo_TabInfo(language,btn)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);

  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",2,language))
  }
    
  if(btn=="addFictitious"){
      aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",2,language))
  }
  
  if(btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Clients,"WinAddClient",6,language))
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, false)
  }
  
  //L'onglet Info
  Get_WinDetailedInfo_TabInfo().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",6,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "IsSelected", cmpEqual, true);
  
  //Grp General
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo",7,language));
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblFullName(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",8,language));
  if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "IsReadOnly", cmpEqual, false);
  }
  else{//RJ
    if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "IsReadOnly", cmpEqual, true);
    }
    else{
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "IsReadOnly", cmpEqual, false);
    }
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "IsVisible", cmpEqual, true);
     
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblShortName(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",9,language));
  if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "IsReadOnly", cmpEqual, false);
  }
  else{//RJ
    if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "IsReadOnly", cmpEqual, true);
    }
    else{
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "IsReadOnly", cmpEqual, false);
    }
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "IsVisible", cmpEqual, true);
  if(client == "US" ) {Log.Message("D'aprés Sofia c'est le même texte qu'on a sur la US la prod donc on le garde en attendant de vérifier ça aprés");
  Log.Message("USDEV-341 d'aprés Stev on devrait être IA Code.");}
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblIACode(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",10,language));
  
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient(), "IsReadOnly", cmpEqual, true);  
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForClientCreation(), "IsReadOnly", cmpEqual, false);  
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForClientCreation(), "IsVisible", cmpEqual, true)
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblTypeForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",11,language));
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClientCreation(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClientCreation(), "IsVisible", cmpEqual, true)
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblLanguageForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",12,language));
  
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForClientCreation(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForClientCreation(), "IsVisible", cmpEqual, true)
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblCurrencyForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",13,language));
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForClientCreation(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForClientCreation(), "IsVisible", cmpEqual, true)
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblGenderForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",14,language));
  
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="add"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClientCreation(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClientCreation(), "IsVisible", cmpEqual, true)
  }
  if( client == "US" ){
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblSINForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",55,language));
  } 
  else{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblSINForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",15,language));}
  
  if(btn=="info"){
      if (client == "BNC"){
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(), "IsReadOnly", cmpEqual, false);
      }
      else{
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(), "IsReadOnly", cmpEqual, true);
      }
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClientCreation(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClientCreation(), "IsVisible", cmpEqual, true)
  }
  
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblDateOfBirthForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",16,language));
  if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(), "IsReadOnly", cmpEqual, false);
  }
  else{
   if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(), "IsReadOnly", cmpEqual, true);
   }
   else{
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(), "IsReadOnly", cmpEqual, false);
   }
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblBNForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",17,language));
  
  if(btn=="info"){
      if (client == "BNC"){
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient(), "IsReadOnly", cmpEqual, false);
      }
      else{
         aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient(), "IsReadOnly", cmpEqual, true);
      }
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClientCreation(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClientCreation(), "IsVisible", cmpEqual, true)
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblFiscalYearForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",18,language));
  if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFiscalYearForClient(), "IsReadOnly", cmpEqual, false);
  }
  else{
    if(btn=="info"){
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFiscalYearForClient(), "IsReadOnly", cmpEqual, true);
    }
    else{
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFiscalYearForClient(), "IsReadOnly", cmpEqual, false);
    }
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFiscalYearForClient(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblmmddForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",19,language));
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblProvincialBNForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",20,language));

  if(btn=="info"){
      if (client == "BNC"){
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient(), "IsReadOnly", cmpEqual, false);
      }
      else{
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient(), "IsReadOnly", cmpEqual, true);
      }
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient(), "IsVisible", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClientCreation(), "IsReadOnly", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClientCreation(), "IsVisible", cmpEqual, true)
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblProspectForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",21,language));
  
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkProspectForClient(), "IsEnabled", cmpEqual, false)
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkProspectForClient(), "IsChecked", cmpEqual, false)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkProspectForClient(), "IsEnabled", cmpEqual, true)
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkProspectForClient(), "IsChecked", cmpEqual, true)
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkProspectForClient(), "IsVisible", cmpEqual, true);

  //Grp Amounts
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",23,language))
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts(), "Header", cmpEqual, GetData(filePath_Clients,"WinAddClient",4,language))
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblBalance(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",24,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtBalance(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtBalance(), "IsReadOnly", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblTotalValue(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",25,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue(), "IsReadOnly", cmpEqual, true);
  
  if(btn=="info"){
    if (client == "BNC"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblMarginOrExcessMargin(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",26,language))
    }
    else{//RJ
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblMarginOrExcessMargin(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",54,language))
    }
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblMarginOrExcessMargin(), "Text", cmpEqual, GetData(filePath_Clients,"WinAddClient",3,language))
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtMarginOrExcessMargin(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtMarginOrExcessMargin(), "IsReadOnly", cmpEqual, true);
  
  //Grp Follow up 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",28,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblSegmentation(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",29,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblContactPerson(), "Text", cmpEqual,GetData(filePath_Common,"WinDetailedInfo",30,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(), "IsVisible", cmpEqual, true);
  
  if(btn=="info"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(), "IsEnabled", cmpEqual, true)
  }
  
  if(btn=="add"){
       aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(), "IsEnabled", cmpEqual, false)
  }
   
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblAccountManager(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",31,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(), "IsVisible", cmpEqual, true);
 
  
  if(btn=="info"){
       aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(), "IsEnabled", cmpEqual, true)
  }
  
  if(btn=="addFictitious" || btn=="addExternal"){
       aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(), "IsEnabled", cmpEqual, false)
   }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblCommunication(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",32,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(), "IsEnabled", cmpEqual, true);
  
  if (client == "BNC"){ 
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblReportVisualSupportForClient(), "Text", cmpEqual,GetData(filePath_Common,"WinDetailedInfo",33,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbReportVisualSupportForClient(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbReportVisualSupportForClient(), "IsEnabled", cmpEqual, false);
  
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",34,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(), "IsEnabled", cmpEqual, true);
  }
  
  //Grp Date
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDateForClient(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",36,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_LblCreationForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",37,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_DtpCreationForClient(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_DtpCreationForClient(), "IsVisible", cmpEqual,true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_LblUpdateForClient(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",38,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_DtpUpdateForClient(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpDate_DtpUpdateForClient(), "IsVisible", cmpEqual,true);
  
  //Gtp Note 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpNotes(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",40,language));
  //Gtp Note - tab grid  
//  Get_WinInfo_Notes_TabGrid().Click();
//  
//  //Onglet Grille dans l'onglet Notes
//  
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid(), "Header", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 3, language));
//  
//  Get_WinInfo_Notes_TabGrid().Click();
//  
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 4, language)); // YR 90-04-32(Content.Text) dans 90-04-44 (Content)
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 5, language));// YR 90-04-32(Content.Text) dans 90-04-44 (Content)
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 6, language));// YR 90-04-32(Content.Text) dans 90-04-44 (Content)
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 7, language));//YR
// 
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "IsVisible", cmpEqual, true);
//  
//  if(btn=="info"){
//     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, true);// YR false dans 90-04-44 CR1664
//  } else{
//      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, false);// YR false dans 90-04-44 CR1664
//  }
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "IsEnabled", cmpEqual, false);
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "IsEnabled", cmpEqual, false);
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsEnabled", cmpEqual, false)
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsVisible", cmpEqual, true)
//  
////  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "IsVisible", cmpEqual, true); //YR CR1664
////  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtSearch(), "IsVisible", cmpEqual, true); //YR CR1664
////  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnSearch(), "IsVisible", cmpEqual, true); //YR CR1664
////  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnSearch(), "IsEnabled", cmpEqual, true);//YR CR1664
////  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsVisible", cmpEqual, true);//YR CR1664
////  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsEnabled", cmpEqual, true);//YR CR1664
//  
//  // Les en-têtes de colonne de la configuration par défaut
//  Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
//  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
//  
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 9, language));
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 10, language));
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 11, language));
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 12, language));//YR 90-04-44
//  
//  
//   //Ajouter les entêtes
//  Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
//  Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
//  var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
//  for(i=1; i<count; i++){
//    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
//    //Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 10).Click(); //YR 90-04-32
//    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 10).Click(); //YR 90-04-44
//    Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR(); 
//  }
//  
//  //Les autres en-têtes de colonne
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 14, language));
//  //aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChDeclareAsReview(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 15, language));//YR 90-04-32
//  
//  
//  //Onglet Sommaire dans l'onglet Notes
//  
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary(), "Header", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 17, language));
//  
//  Get_WinInfo_Notes_TabSummary().Click();
//  
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary_TxtSummary(), "IsVisible", cmpEqual, true);
//  
   Check_Properties_WinInfo_Notes(language,btn);
}

// WIN DETAILED INFO - L'ONGLET ADRESSES 
function Check_Properties_DetailedInfo_TabAdresses(language, module)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true);
  
  
  //L'onglet Addresses
  Get_WinDetailedInfo_TabAddresses().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Addresses",2,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses(), "IsSelected", cmpEqual, true);
  
  //L'onglet Adresses - grp addresses
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblType(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType(), "IsVisible", cmpEqual, true); 
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblStreet(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(), "IsVisible", cmpEqual, true);
  
  if( client == "US" ){
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblCityProv(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",34,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv(), "IsVisible", cmpEqual, true);}
  else {
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblCityProv(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",6,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv(), "IsVisible", cmpEqual, true);}
  if( client == "US" ){
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblPostalCode(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",35,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode(), "IsVisible", cmpEqual, true);}
  else{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblPostalCode(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",7,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode(), "IsVisible", cmpEqual, true);}
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblCountry(), "Text", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Addresses",8,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(), "IsVisible", cmpEqual, true);
  if(client == "US" ){
    Log.Message("D'aprés la réponse de Sofia il faut mettre a jour le script parce que c'est le même texte qu'on a sur la prod ");
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkMailingAddress(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",37,language));
  } 
  else{
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkMailingAddress(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",9,language));} 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkMailingAddress(), "IsEnabled", cmpEqual, false); 
  
  if(module=="clients"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkMailingAddress(), "IsChecked", cmpEqual, true);
  }
  if(module=="relationships"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkMailingAddress(), "IsChecked", cmpEqual, false);
  }
  if(client == "US" ){
    Log.Message("D'aprés la réponse de Sofia il faut mettre a jour le script parce que c'est le même texte qu'on a sur la prod ");
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblRelevantFrom(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",38,language)); 
  } 
  else{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblRelevantFrom(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",10,language)); }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtRelevantFrom(), "IsReadOnly", cmpEqual, true); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtRelevantFrom(), "IsVisible", cmpEqual, true); 
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblFromMmDd(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",11,language));   
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblTo(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",12,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtTo(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtTo(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblToMmDd(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",13,language));
  if(client == "US" ){
    Log.Message("D'aprés la réponse de Sofia il faut mettre a jour le script parce que c'est le même texte qu'on a sur la prod ");
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblTheRelevantPeriodHasPrecedenceOverTheMailingAddress(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",39,language));
  } 
  else{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblTheRelevantPeriodHasPrecedenceOverTheMailingAddress(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",14,language));}
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",16,language));  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd(), "IsVisible", cmpEqual, true); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd(), "IsEnabled", cmpEqual, true); 
   
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",17,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit(), "IsVisible", cmpEqual, true); 
  
  if(module=="clients"){
  if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit(), "IsEnabled", cmpEqual, true);
  }
  else{
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit(), "IsEnabled", cmpEqual, false);
  } 
  }
  if(module=="relationships"){
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit(), "IsEnabled", cmpEqual, false); 
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",18,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete(), "IsVisible", cmpEqual, true); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete(), "IsEnabled", cmpEqual, false);  
  
  if(module=="relationships"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship(), "WPFControlText", cmpEqual, GetData(filePath_Relations,"WinInfo_Addresses",2,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_GrpRepresentativeInformationForRelationship(), "Header", cmpEqual, GetData(filePath_Relations,"WinInfo_Addresses",3,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_GrpRepresentativeInformation_TxtRepresentativeInformationForRelationship(), "IsVisible", cmpEqual, true);
  }
  
  //Grp Telephones
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",20,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",23,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",24,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit(), "IsVisible",cmpEqual, true);
  
  if(module=="clients"){
    if (client == "BNC"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit(), "IsEnabled",cmpEqual, true);
    }
    else{
      aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit(), "IsEnabled",cmpEqual, false);
    }
  }
   if(module=="relationships"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit(), "IsEnabled",cmpEqual, false);
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",25,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete(), "IsEnabled",cmpEqual, false);
  
  //Grp Telephones- les entêtes 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones_ChType(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",21,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones_ChNumber(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",22,language));
  
  //Grp E-mails
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",27,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChType(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",28,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChEmail(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",29,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChDefault(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",30,language));
  
  if (client == "CIBC" || client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChConsent(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",31,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChEffectiveDate(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",32,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChExpirationDate(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Addresses",33,language));
  }
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_BtnSend(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_BtnSend(), "IsEnabled", cmpEqual, true);
}

// WIN DETAILED INFO - L'ONGLET AGENDA 
function Check_Properties_DetailedInfo_TabAgenda(language)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true);
  
  
  //L'onglet Agenda
  Get_WinDetailedInfo_TabAgendaForClient().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Agenda",2,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient(), "IsSelected", cmpEqual, true);
  
  //Grp Filters 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblStatus(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbStatus(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbStatus(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblType(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbType(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbType(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblAssignee(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",6,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbAssignee(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbAssignee(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblSearchDescription(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",7,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_TxtSearchDescription(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_TxtSearchDescription(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_BtnNext(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_BtnNext(), "IsVisible", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_BtnPrevious(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_BtnPrevious(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_BtnPrint(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_BtnPrint(), "IsEnabled", cmpEqual, true);
  
  //Les entêtes 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList_ChDateTime(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",8,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList_ChTypeDuration(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",9,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList_ChFrequencyDescription(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",10,language));
  
  //Grp Information 
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Agenda",12,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblType(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",13,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtType(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtType(), "IsReadOnly", cmpEqual, true);
  
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblDate(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",14,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDate(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDate(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblPriority(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",15,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtPriority(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtPriority(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblClient(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",16,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtClient(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtClient(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblDescription(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",17,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDescription(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDescription(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblStatus(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",18,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtStatus(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtStatus(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblTime(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",19,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtTime(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtTime(), "IsReadOnly", cmpEqual, true); 
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblReminder(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",20,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtReminder(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtReminder(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblAccountNo(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",21,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtAccountNo(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtAccountNo(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblFrequency(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",22,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtFrequency(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtFrequency(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblDuration(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",23,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDuration(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDuration(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblLastUpdate(), "Content", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Agenda",24,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtLastUpdate(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtLastUpdate(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblAssignee(), "Content", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Agenda",25,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtAssignee(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtAssignee(), "IsReadOnly", cmpEqual, true);
  
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",28,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd(), "IsVisible", cmpEqual,true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnEdit(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",29,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnEdit(), "IsVisible", cmpEqual,true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnEdit(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",30,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete(), "IsVisible", cmpEqual,true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnLastCommunication(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Agenda",31,language));
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnLastCommunication(), "IsVisible", cmpEqual,true);
   aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnLastCommunication(), "IsEnabled", cmpEqual, true);
}

// WIN DETAILED INFO - L'ONGLET PRODUITSAERVICES
function Check_Properties_DetailedInfo_TabProduitsServices(language,module)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true);
  
  //L'onglet PRODUITSAERVICES
  Get_WinDetailedInfo_TabProductsAndServices().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",2,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "IsSelected", cmpEqual, true);
  
  //Grp Products 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",3,language));
  if(client == "US" ){aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Content, "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",15,language));}
  else {
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Content, "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",4,language));}
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup(), "IsVisible", cmpEqual, true);
  
  //Grp Services
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",6,language));
  if(module=="clients"){
     aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",7,language));
  }
   if(module=="relationships"){
     aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup(), "WPFControlText", cmpEqual, GetData(filePath_Relations,"WinInfo_InvestmentObjective",4,language));
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup(), "IsVisible", cmpEqual, true);
  
  //Tab Investment Objective
  Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();

  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective(), "IsSelected", cmpEqual, true);
  
  if(module=="clients"){
    if (client == "BNC"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",9,language));
     }
     else{//RJ
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",14,language));
     }
     Check_Properties_WinInfo_TabInvestmentObjective(language)
  }
  
  if(module=="relationships"){
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective(), "Header", cmpEqual, GetData(filePath_Relations,"WinInfo_InvestmentObjective",2,language));
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_ChkInvestmentObjectiveForRelationship(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_ChkInvestmentObjectiveForRelationship(), "IsChecked", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_ChkInvestmentObjectiveForRelationship(), "IsEnabled", cmpEqual, true);
  
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_BtnInvestmentObjectiveForRelationship(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_BtnInvestmentObjectiveForRelationship(), "IsEnabled", cmpEqual, true);
  
      aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_LblAssetIndexForRelationship(), "Text", cmpEqual, GetData(filePath_Relations,"WinInfo_InvestmentObjective",3,language));
  }
  
  //Tab Default Reports
  Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",10,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports(), "IsSelected", cmpEqual, true);
  Check_Properties_GrpReports(language,"info")
  
  //Tab Default Indices
  Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_ProduitService",11,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices(), "IsSelected", cmpEqual, true);
  Check_Properties_WinInfo_TabDefaultIndices(language)  
}

// WIN DETAILED INFO - L'ONGLET PROFILE
function Check_Properties_DetailedInfo_TabProfile(language)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true);
  
  
  //L'onglet Profile
  Get_WinDetailedInfo_TabProfile().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProfile(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Profile",2,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProfile(), "IsSelected", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Profile",3,language));
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "IsChecked", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinInfo_TabProfile_LblNoDataAvailable(), "Text", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Profile",4,language));
  
  aqObject.CheckProperty(Get_WinInfo_TabProfile_BtnSetup(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Profile",5,language));
  aqObject.CheckProperty(Get_WinInfo_TabProfile_BtnSetup(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabProfile_BtnSetup(), "IsEnabled", cmpEqual, true);
}


// WIN DETAILED INFO - L'ONGLET DOCUMENTS
function Check_Properties_DetailedInfo_TabDocuments(language,module)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true);
  
  //L'onglet Documents
  Get_WinDetailedInfo_TabDocuments().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabDocuments(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Doc",2,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabDocuments(), "IsSelected", cmpEqual, true);
  
  aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit().Content, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Doc",4,language));
  aqObject.CheckProperty(Get_PersonalDocuments_GrpComments().Header, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Doc",3,language));   
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnShowHideFolderView(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnShowHideFolderView(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnAddAFile(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnAddAFile(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRemove(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRemove(), "IsEnabled", cmpEqual, false);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRefresh(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnRefresh(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCut(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCut(), "IsEnabled", cmpEqual, false);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCopy(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnCopy(), "IsEnabled", cmpEqual, false);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnPaste(), "IsVisible", cmpEqual, true);  
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnPaste(), "IsEnabled", cmpEqual, false);  
       
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_TxtSearch(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_TxtSearch(), "IsReadOnly", cmpEqual, false);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnSearch(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnSearch(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterAll(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterAll(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterEmail(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterEmail(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterPdf(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterPdf(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterFile(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_Toolbar_BtnFilterFile(), "IsEnabled", cmpEqual, true);
  
  if(module=="clients"){  
      aqObject.CheckProperty(Get_PersonalDocuments_TvwDocumentsForClientAndModel(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_PersonalDocuments_TvwDocumentsForClientAndModel(), "IsEnabled", cmpEqual, true);
  }
  
   if(module=="relationships"){  
      aqObject.CheckProperty(Get_WinDetailedInfo_TabDocuments_TvwDocumentsForRelationship(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabDocuments_TvwDocumentsForRelationship(), "IsEnabled", cmpEqual, true);
  }
    



  aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments(), "IsEnabled", cmpEqual, true);
    
  aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_BtnEdit(), "IsEnabled", cmpEqual, true);
     
  aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "IsReadOnly", cmpEqual, true);
    
}

// WIN DETAILED INFO - L'ONGLET CLIENTS NETWORK
function Check_Properties_DetailedInfo_TabClientNetwork(language)
{
  Get_WinDetailedInfo().set_Width(1528);
  Get_WinDetailedInfo().set_Height(810);
  Get_WinDetailedInfo().set_Top(30);
  Get_WinDetailedInfo().set_Left(8);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true);
  
  //L'onglet ClientNetwork
  Get_WinDetailedInfo_TabClientNetworkForClient().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_CliNetwork",2,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient(), "IsSelected", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnAdd().Content, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnEdit().Content, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnEdit(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnDelete().Content, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnDelete(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnPotential().Content, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",6,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnPotential(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_BtnPotential(), "IsEnabled", cmpEqual, false);
  
  //Vérification des entêtes de colonnes par défaut 
  Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChName().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  Delay(3000);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChName(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",9,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChClientNo(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",10,language));
  
  if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChFamily(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",11,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChSocial(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",12,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChProfessionnal(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",13,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",14,language));
  }
  else{ //RJ
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",57,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChLink(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",55,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChType(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",56,language));
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChSource(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",15,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChNumber(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",16,language));
 
  
   //Ajouter les entêtes
  Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChName().ClickR(); 
  for(i=1; i<=12; i++)
  {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click(); 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChName().ClickR(); 
  }

 //Vérification de tous les entêtes de colonnes  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChName(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",21,language));
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone4(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",22,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone3(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",23,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone2(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",24,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone1(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",25,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChIACode(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",26,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChFullName(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",27,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChEmail3(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",28,language));
  
   //cliquer sur scrollbar pour faire l'entête de colonne visible
   var ControlWidth=Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().Width;
   var ControlHeight=Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().Height;
   Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().Click(ControlWidth -40, ControlHeight -3)
   
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChEmail2(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",29,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChEmail1(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",30,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChDateOfBirth(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",31,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChBalance(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",32,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChAge(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",33,language));
   
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChClientNo(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",34,language));
  
  if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChFamily(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",35,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChSocial(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",36,language));
  }
  if(client=="RJ"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChLink(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",55,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChType(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",56,language));
  }
    
  //cliquer sur scrollbar pour faire l'entête de colonne visible
   var ControlWidth=Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().Width;
   var ControlHeight=Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().Height;
   Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().Click(ControlWidth -40, ControlHeight -3) 
   
   if (client == "BNC"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChProfessionnal(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",37,language));
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",38,language));
  }
  if(client=="RJ"){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",57,language));
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChSource(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",39,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChNumber(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",40,language));
  
  //Grp client network summary 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",42,language));
  Log.Message("CROES-4322")
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChType(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",43,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChNoOfClients(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",44,language));
  if(client == "US" ){
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",59,language));  
  }
  else{ 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",45,language));}
 
  //Relationships summary
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary(), "Header", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",48,language));
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary_ChName(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",49,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary_ChRelationshipNo(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",50,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChType(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",51,language));
   if(client == "US" ){
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",59,language));  
  }
  else{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_CliNetwork",52,language));}
}

// WIN DETAILED INFO - L'ONGLET CAMPAIGNS
function Check_Properties_DetailedInfo_TabCampaigns(language)
{
  Get_WinDetailedInfo().set_Width(1528);
  Get_WinDetailedInfo().set_Height(882);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Common,"WinDetailedInfo",5,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsEnabled", cmpEqual, true);
  
  //L'onglet Client Network
  Get_WinDetailedInfo_TabCampaignsForClient().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Campaigns",2,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient(), "IsSelected", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_BtnAdd().Content, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",3,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_BtnEdit().Content, "OleValue", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",4,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_BtnEdit(), "IsEnabled", cmpEqual, false);

  //Vérification des entêtes de colonnes par défaut 
  Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChName().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  Delay(3000);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChName(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",7,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChAccess(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",8,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChCampaign(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",9,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChStart(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",10,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChEnd(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",11,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChResults(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",12,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChUnitOfMeasure(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",13,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChStatus(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",14,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChComments(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",15,language));  
  
   //Ajouter les entêtes
  Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChName().ClickR(); 
  for(i=1; i<=3; i++)
  {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click(); 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChName().ClickR(); 
  }

 //Vérification de tous les entêtes de colonnes  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChName(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",19,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChLastContact(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",20,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChCampaignSalutation(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",21,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChAddressee(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",22,language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChAccess(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",23,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChCampaign(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",24,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChStart(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",25,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChEnd(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",26,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChResults(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",27,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChUnitOfMeasure(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",28,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChStatus(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",29,language)); 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChComments(), "Content", cmpEqual, GetData(filePath_Common,"WinDetailedInfo_Campaigns",30,language)); 
  
}





function Check_Properties_WinActivities(language)
{
  aqObject.CheckProperty(Get_WinActivities_BtnClose(), "Content", cmpEqual,  GetData(filePath_Common, "Activities", 2, language));
  aqObject.CheckProperty(Get_WinActivities_BtnClose(), "IsVisible", cmpEqual,  true);
  aqObject.CheckProperty(Get_WinActivities_BtnClose(), "IsEnabled", cmpEqual,  true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities(), "Header", cmpEqual, GetData(filePath_Common, "Activities", 3, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities(), "IsVisible", cmpEqual, true); //Ajouté par Chris
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate(), "Header", cmpEqual,GetData(filePath_Common, "Activities", 4, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate(), "IsVisible", cmpEqual, true); //Ajouté par Chris
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpFrom(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpFrom(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpTo(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_DtpTo(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_CmbPeriodSelector(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpDate_CmbPeriodSelector(), "IsVisible", cmpEqual, true);
 
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpKeywords(), "Header", cmpEqual, GetData(filePath_Common, "Activities", 5, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpKeywords(), "IsVisible", cmpEqual, true); //Ajouté par Chris
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpKeywords_TxtKeywords(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpKeywords_TxtKeywords(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpActivityType(), "Header", cmpEqual, GetData(filePath_Common, "Activities", 6, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpActivityType(), "IsVisible", cmpEqual, true); //Ajouté par Chris
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType(), "IsReadOnly", cmpEqual, false);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext(), "Header", cmpEqual, GetData(filePath_Common, "Activities", 7, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext(), "IsVisible", cmpEqual, true); //Ajouté par Chris
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "IsChecked", cmpEqual, true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 8, language));
  
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_BtnClearFilters(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 9, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_BtnClearFilters(), "IsVisible", cmpEqual,  true);
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_BtnClearFilters(), "IsEnabled", cmpEqual,  true);
  
  //les en-têtes    
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChDate(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 12, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChType(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 13, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChSource(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 14, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChName(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 15, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChCreatedBy(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 16, language));
  aqObject.CheckProperty(Get_WinActivities_GrpActivities_ChDescription(), "Content", cmpEqual, GetData(filePath_Common, "Activities", 17, language));
}



function Check_Properties_WinRestrictionsManager(language)
{
  aqObject.CheckProperty(Get_WinRestrictionsManager(), "Title", cmpStartsWith,  GetData(filePath_Common, "Restrictions", 2, language));
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 3, language));
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 4, language));
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 5, language));
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 6, language));
  aqObject.CheckProperty(Get_WinRestrictionsManager_BtnClose().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 7, language));
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChType().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 10, language));
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChSeverity().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 11, language));
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChRestriction().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Restrictions", 12, language));
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnEdit(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnDelete(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BtnClose(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BtnClose(), "IsEnabled", cmpEqual, true);
}



function Check_Properties_WinInfo_Notes(language,btn)
{
  //Onglet Grille dans l'onglet Notes
  
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid(), "Header", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 3, language));
  
  Get_WinInfo_Notes_TabGrid().Click();
  
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 4, language)); // YR 90-04-32(Content.Text) dans 90-04-44 (Content)
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 5, language));// YR 90-04-32(Content.Text) dans 90-04-44 (Content)
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 6, language));// YR 90-04-32(Content.Text) dans 90-04-44 (Content)
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 7, language));//YR
 
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "IsVisible", cmpEqual, true);
   if(btn=="info" || btn=="infoRel" ){
     aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, true);// YR false dans 90-04-44 CR1664
  } else{
      aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnAdd(), "IsEnabled", cmpEqual, false);// YR false dans 90-04-44 CR1664
  }
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "IsVisible", cmpEqual, true);
  if(btn=="infoRel"){ 
       
       
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "IsEnabled", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsEnabled", cmpEqual, true)
  } 
  else{
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsEnabled", cmpEqual, false)
  }
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsVisible", cmpEqual, true)
  
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "IsVisible", cmpEqual, true); //YR CR1664
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtSearch(), "IsVisible", cmpEqual, true); //YR CR1664
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnSearch(), "IsVisible", cmpEqual, true); //YR CR1664
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnSearch(), "IsEnabled", cmpEqual, true);//YR CR1664
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsVisible", cmpEqual, true);//YR CR1664
//  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnPrint(), "IsEnabled", cmpEqual, true);//YR CR1664
  
  // Les en-têtes de colonne de la configuration par défaut
  Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 9, language));
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 10, language));
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 11, language));
 // if(client == "US"){
  Log.Message("L'anomalie est trouvée pour CX:CROES-7776 pour le module relation et CROES-7797 pour le module client et compte ");//}// SA: Suite a l'exécution de 90-04-78 (US)
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 12, language));//YR 90-04-44
  
  
   //Ajouter les entêtes
  Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
  Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
  var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
  for(i=1; i<count; i++){
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    //Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 10).Click(); //YR 90-04-32
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 10).Click(); //YR 90-04-44
    Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR(); 
  }
  
  //Les autres en-têtes de colonne
 // if(client == "US"){
  Log.Message("L'anomalie est trouvée pour CX:CROES-7776 pour le module relation et CROES-7797 pour le module client et compte ");//}// SA: Suite a l'exécution de 90-04-78 (US)
  aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 14, language));
  //aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChDeclareAsReview(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 15, language));//YR 90-04-32
  
  
  //Onglet Sommaire dans l'onglet Notes
  
  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary(), "Header", cmpEqual, GetData(filePath_Common, "WinInfo_Notes", 17, language));
  
  Get_WinInfo_Notes_TabSummary().Click();
  
  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary_TxtSummary(), "IsVisible", cmpEqual, true);
}



function Check_Properties_WinInfo_TabInvestmentObjective(language)
{
  aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_TxtInvestmentObjectiveForClientAndAccount(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_TvwAssetAllocationsForClientAndAccount(), "IsVisible", cmpEqual, true);
}



function Check_Properties_GrpReports(language,btn)
{
  aqObject.CheckProperty(Get_Reports_GrpReports(), "Header", cmpEqual, GetData(filePath_Common, "GrpReports", 3, language));
  aqObject.CheckProperty(Get_Reports_GrpReports(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_Reports_GrpReports_TabReports(), "Header", cmpEqual, GetData(filePath_Common, "GrpReports", 4, language));
  aqObject.CheckProperty(Get_Reports_GrpReports_TabReports(), "IsVisible", cmpEqual, true);
  Get_Reports_GrpReports_TabReports().Click();
  aqObject.CheckProperty(Get_Reports_GrpReports_TabReports_LvwReports(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_Reports_GrpReports_TabSavedReports(), "Header", cmpEqual, GetData(filePath_Common, "GrpReports", 5, language));
  aqObject.CheckProperty(Get_Reports_GrpReports_TabSavedReports(), "IsVisible", cmpEqual, true);
  Get_Reports_GrpReports_TabSavedReports().Click();
  Get_Reports_GrpReports_TabSavedReports().WaitProperty("IsSelected", true, 20000);
  if((btn=="info") && (client != "CIBC")){
      aqObject.CheckProperty(Get_Reports_GrpReports_TabSavedReports_LvwSavedReports(), "IsVisible", cmpEqual, true)}
  if(btn=="reports"){
      WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", "1"]);
      aqObject.CheckProperty(Get_Reports_GrpReports_TabSavedReports_TvwSavedReports(), "IsVisible", cmpEqual, true)}
  
  aqObject.CheckProperty(Get_Reports_GrpReports_TabSavedReports_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_TabSavedReports_BtnDelete().Content, "Text", cmpEqual, GetData(filePath_Common, "GrpReports", 6, language));
  
  aqObject.CheckProperty(Get_Reports_GrpReports_BtnAddAReport(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_BtnRemoveAReport(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_BtnRemoveAllReports(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_BtnMoveTheReportUp(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_BtnMoveTheReportDown(), "IsVisible", cmpEqual, true);
  
  if(btn=="info"){
  aqObject.CheckProperty(Get_Reports_GrpReports_LblDefaultReports(), "Text", cmpEqual, GetData(filePath_Common, "GrpReports", 7, language))}
  
  if(btn=="reports"){
  aqObject.CheckProperty(Get_Reports_GrpReports_LblCurrentReports(), "Content", cmpEqual, GetData(filePath_Common, "Reports", 28, language))}
  
  aqObject.CheckProperty(Get_Reports_GrpReports_LvwCurrentReports(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_BtnSave().Content, "Text", cmpEqual, GetData(filePath_Common, "GrpReports", 8, language));
  aqObject.CheckProperty(Get_Reports_GrpReports_BtnSave(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_Reports_GrpReports_GrpCurrentParameters(), "Header", cmpEqual, GetData(filePath_Common, "GrpReports", 10, language));
  aqObject.CheckProperty(Get_Reports_GrpReports_GrpCurrentParameters(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_GrpCurrentParameters_TxtCurrentParameters(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Content, "Text", cmpEqual, GetData(filePath_Common, "GrpReports", 11, language));
  aqObject.CheckProperty(Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters(), "IsVisible", cmpEqual, true);
  
}



function Check_Properties_WinInfo_TabDefaultIndices(language)
{
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpAvailableIndices(), "Header", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 4, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpAvailableIndices(), "IsVisible", cmpEqual, true);
  
  // Les en-têtes de colonne (configuration par défaut)
  Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChDescription().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChDescription(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 5, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChSecurity(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 6, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChCurrency(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 7, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChSymbol(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 8, language));

  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices(), "Header", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 10, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices(), "IsVisible", cmpEqual, true);
  
  // Les en-têtes de colonne (configuration par défaut)
  Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChDescription().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChDescription(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 11, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChSecurity(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 12, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChCurrency(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 13, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChSymbol(), "Content", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 14, language));

  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_BtnMoveTheIndiceUp(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_BtnMoveTheIndiceDown(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_BtnAddIndices(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_BtnRemoveIndices(), "IsVisible", cmpEqual, true);
  Log.Message("CROES-9353")
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_LblTargetReturn(), "WPFControlText", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 16, language)); // EM : datapool a été modifié selon le Jira CROES-9353 - avant "Rendement visé:"
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_LblTargetReturn(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_TxtTargetReturn(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_LblPercent(), "WPFControlText", cmpEqual, GetData(filePath_Common, "WinInfo_DefaultIndices", 17, language));
  aqObject.CheckProperty(Get_WinInfo_TabDefaultIndices_LblPercent(), "IsVisible", cmpEqual, true);

}



function Check_Properties_WinInfo_TabProfile(language)
{
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "WPFControlText", cmpEqual, GetData(filePath_Common, "WinInfo_Profile", 3, language));
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabProfile_ChkHideEmptyProfiles(), "IsChecked", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinInfo_TabProfile_BtnSetup(), "WPFControlText", cmpEqual, GetData(filePath_Common, "WinInfo_Profile", 4, language));
  aqObject.CheckProperty(Get_WinInfo_TabProfile_BtnSetup(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_TabProfile_BtnSetup(), "IsEnabled", cmpEqual, true);
}

//+++++++++++++++++++++++++++++++WIN REPORTS CHECK POINTS++++++++++++++++++++++++++++++++++++++++
 //Fonctions  (les points de vérification pour les scripts qui testent Reports)

function Check_Properties_Reports(language,module,btn)
{   
    if(module=="portfolio"){
    aqObject.CheckProperty(Get_WinReports(), "Title", cmpEqual, GetData(filePath_Portefeuille, "Reports", 2, language))}
    if(module=="clients"){
    aqObject.CheckProperty(Get_WinReports(), "Title", cmpEqual, GetData(filePath_Clients, "Reports", 2, language))}
    if(module =="accounts"){
    aqObject.CheckProperty(Get_WinReports(), "Title", cmpEqual, GetData(filePath_Accounts, "Reports", 2, language))}
    if(module=="modeles"){
    aqObject.CheckProperty(Get_WinReports(), "Title", cmpEqual, GetData(filePath_Modeles, "Reports", 2, language))}
    if(module =="relationships"){
    aqObject.CheckProperty(Get_WinReports(), "Title", cmpEqual, GetData(filePath_Relations, "Reports", 2, language))}
    if(module=="security"){
    aqObject.CheckProperty(Get_WinReports(), "Title", cmpEqual, GetData(filePath_Titre, "Reports", 2, language))}
    
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Common, "Reports", 2, language));
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "WPFControlText", cmpEqual, GetData(filePath_Common, "Reports", 3, language));
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "IsEnabled", cmpEqual, true);
    
    //Grp Rapports
    Check_Properties_GrpReports(language,btn);
    
    //Options
    aqObject.CheckProperty(Get_WinReports_GrpOptions().Header, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 6, language));
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblDestination().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 7, language));
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbDestination(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbDestination(), "IsVisible", cmpEqual, true);
    
    if(module=="modeles" ||  module =="relationships" || module =="clients" || module=="accounts"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkArchiveReports(), "IsChecked", cmpEqual, false)
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkArchiveReports(), "IsEnabled", cmpEqual, true)}
    
    if(module=="modeles" ||  module =="clients" ||  module =="accounts" ||  module =="relationships" || module=="security"){
      if (client == "BNC" ){
        aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkPrintDuplex(), "IsChecked", cmpEqual, false)
        aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkPrintDuplex(), "IsEnabled", cmpEqual, true)
      }
    }
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblSortBy().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 10, language)); 
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbSortBy(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbSortBy(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblCurrency().Content, "OleValue", cmpEqual,GetData(filePath_Common, "Reports", 11, language));
    if(module=="modeles" || module=="security" || module=="clients"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbCurrency(), "IsEnabled", cmpEqual, true)}
    if(module=="portfolio" ){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbCurrency(), "IsEnabled", cmpEqual, false)}
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbCurrency(), "IsVisible", cmpEqual, true);  
     
    if( client == "US")
    { Log.Message("On vérifie pas le champ langue parce que pour la US on se connecte juste en anglais ")}
    else
    {
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblLanguage().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 12, language)); 
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbLanguage(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbLanguage(), "IsVisible", cmpEqual, true);
    }
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblSource().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 13, language));
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbSource(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinReports_GrpOptions_CmbSource(), "IsVisible", cmpEqual, true);
   
    if(module=="modeles" || module=="relationships" || module =="clients" || module=="accounts" ){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblCurrentSelection().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 14, language))}
    
    if(module=="modeles" || module=="relationships" || module =="clients"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblAccountCriteria().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 15, language))
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblAccountCriteria(), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_WinReports_GrpOptions_LblAccountCriteria(), "IsEnabled", cmpEqual, true)}
    
    //En-tête (Header)
    if (client == "CIBC" || client == "BNC" || client == "TD" ){
      aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpHeader().Header, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 17, language));
    
      aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpHeader_LblName().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 18, language));
      aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpHeader_CmbName(), "IsEnabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpHeader_CmbName(), "IsVisible", cmpEqual, true);
       
      aqObject.CheckProperty( Get_WinReports_GrpOptions_GrpHeader_LblTitle().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 19, language));
      aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpHeader_CmbTitle(), "IsEnabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpHeader_CmbTitle(), "IsVisible", cmpEqual, true);
    }
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkGroupInTheSameReport(), "Content", cmpEqual, GetData(filePath_Common, "Reports", 20, language));
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkGroupInTheSameReport(), "IsEnabled", cmpEqual, false);
    
    if(module=="security" || module =="portfolio"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkGroupInTheSameReport(), "IsChecked", cmpEqual, true)}
    
    if(module=="modeles" || module=="relationships" || module =="clients" || module=="accounts" ){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkGroupInTheSameReport(), "IsChecked", cmpEqual, false)}
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkConsolidatePositions().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 21, language));
    
    if(module=="security" || module =="modeles" || module=="accounts"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkConsolidatePositions(), "IsEnabled", cmpEqual, false)}  
    if(module=="portfolio" || module =="clients" || module =="relationships"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkConsolidatePositions(), "IsEnabled", cmpEqual, true)}
    
    if(module=="portfolio" || module=="accounts" || module =="clients" || module =="modeles" || module =="relationships"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkConsolidatePositions(), "IsChecked", cmpEqual, false)
    }
    
    if(client=="RJ"){  
      if(module=="accounts" || module =="clients" || module =="relationships"){ //valider si ça s'applique au modelé
        aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention(), "IsEnabled", cmpEqual, false)
        aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention(), "IsChecked", cmpEqual, false) 
      }  
    }
    
    if (client == "BNC" ){
      if(module =="clients"){
      aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkGroupUnderlyingClients(), "IsEnabled", cmpEqual, true)
      aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkGroupUnderlyingClients(), "IsChecked", cmpEqual, true)}
    }
    
     //Message
    aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpMessage().Header, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 24, language)) 
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpMessage_ChkInclude().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 25, language)); 
    aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpMessage_ChkInclude(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpMessage_ChkInclude(), "IsChecked", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpMessage_BtnEdit().Content, "Text", cmpEqual, GetData(filePath_Common, "Reports", 26, language)); 
    aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpMessage_BtnEdit(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_GrpOptions_GrpMessage_BtnEdit(), "IsEnabled", cmpEqual, true); 
    if(client == "US" && module != "modeles"){
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkDisplayAccountClientRelationshipNumbersInFull().Content, "OleValue", cmpEqual, GetData(filePath_Common, "Reports", 29, language)); 
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkDisplayAccountClientRelationshipNumbersInFull(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_GrpOptions_ChkDisplayAccountClientRelationshipNumbersInFull(), "IsChecked", cmpEqual, false);} 
}


