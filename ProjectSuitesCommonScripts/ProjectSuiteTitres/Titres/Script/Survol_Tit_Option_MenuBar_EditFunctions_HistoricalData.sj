//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions

 /* Description : A partir du module « Titre » ,chercher le titre 78757N (Option), afficher la fenêtre « Info » en cliquant sur MenuBar -Fonctions – HistoricalData. 
 Vérifier que l’onglet « Historique de prix » est sélectionné. Vérifier la présence des contrôles et des étiquetés dans la partie « Description » 
 et l’onglet « Historique de prix ». 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1793*/
 
 function Survol_Tit_Option_MenuBar_EditFunctions_HistoricalData()
 {
    var type="option"; //La variable qui est utilisée dans les points de vérifications 
    
    Login(vServerTitre, userName , psw ,language);
    Get_ModulesBar_BtnSecurities().Click();
    
   if (Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 2000))
     {
       Search_Security("78757N")
     }
   else
     {
       Log.Error("The BtnSecurities didn't become Checked within 2 seconds.");
     }
 
    Get_MenuBar_Edit().OpenMenu()
    Get_MenuBar_Edit_Functions().OpenMenu()
    Get_MenuBar_Edit_FunctionsForSecurities_HistoricalData().Click()
    
    //Les points de vérification en français 
     if(language=="french"){ Check_Properties_French(type)}
    //Les points de vérification en anglais 
    else {Check_Properties_English(type)}  
    
    Check_Existence_Of_Controls(type)
      
    Get_WinInfoSecurity_BtnCancel().Click()
    
    Get_MainWindow().SetFocus();
    Close_Croesus_AltF4();
 }
 
  //Fonctions  (les points de vérification pour les scripts qui testent Historical_Data)
function Check_Properties_French(type)
{    
      aqObject.CheckProperty(Get_WinInfoSecurity_BtnOK().Content, "OleValue", cmpEqual, "OK");
      //aqObject.CheckProperty(Get_WinInfoSecurity_BtnApply().Content, "OleValue", cmpEqual, "_Appliquer");//CROES-5489 Le bouton Apply devrait être retiré.
      aqObject.CheckProperty(Get_WinInfoSecurity_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
      
      //*******************************************DESCRIPTION ********************************************** 
      //les étiquetés
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription().Header, "OleValue", cmpEqual, "Description");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSubCategory().Text, "OleValue", cmpEqual, "Sous-Catégorie:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblFrenchDescription().Text, "OleValue", cmpEqual, "Description en français:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblEnglishDescription().Text, "OleValue", cmpEqual, "Description en anglais:");
      if(type=="action"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIndustryCode().Text, "OleValue", cmpEqual, "Code d'industrie:")};
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCountry().Text, "OleValue", cmpEqual, "Pays:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCurrency().Text, "OleValue", cmpEqual, "Devise:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCalculationFactor().Text, "OleValue", cmpEqual, "Facteur de calcul:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblUpdatedOn().Text, "OleValue", cmpEqual, "Modifié le:");   
      if(type=="bond"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIssueDate().Text, "OleValue", cmpEqual, "Date d'émission:")};      
      if(type=="option"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblOptionType().Text, "OleValue", cmpEqual, "Type d'option:")};     
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCreationDate().Text, "OleValue", cmpEqual, "Date de création:");   //  il faut valider le texte
      Log.Message("bug CROES-5066")
      if(type=="action")aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblConversionDate().Text, "OleValue", cmpEqual, "Date de conversion:"); 
       
      if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblDiscrMgmt().Text, "OleValue", cmpEqual, "Gestion discr.:");
      } 
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSecurity().Text, "OleValue", cmpEqual, "Titre:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblTypeClass().Text, "OleValue", cmpEqual, "Type/Classe:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblISIN().Text, "OleValue", cmpEqual, "ISIN:");     
      if(type=="option"){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblStrikePrice().Text, "OleValue", cmpEqual, "Prix d'exercice:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblExpiration().Text, "OleValue", cmpEqual, "Expiration:");}      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket().Header, "OleValue", cmpEqual, "Bourse");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainMarket().Text, "OleValue", cmpEqual, "Bourse principale:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainSymbol().Text, "OleValue", cmpEqual, "Symbole principal:");
           
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Divers");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "Content", cmpEqual, "Non rachetable");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(), "Content", cmpEqual, "Exclure du rapport Biens étrangers");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblForeignProperty().Text, "OleValue", cmpEqual, "Biens étrangers:");
      //if (client == "CIBC" || client == "BNC" || client =="US"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpGrpMiscellaneous_LblExcludeFromBilling().Text, "OleValue", cmpEqual, "Exclure de la facturation:")}; //N’existe pas dans l’automation 9 (BD FNB)   
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets().Content, "OleValue", cmpEqual, "Gérer les bourses...");
              
      //*************************************** L'ONGLET HISTORIQUE DE PRIX **************************************
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory().Header, "OleValue", cmpEqual, "Historique des prix"); // Modifié selon CROES-8855
      Log.Message("CROES-8855")
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory(), "IsSelected", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChClose().Content, "OleValue", cmpEqual, "Clôture");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChCurrency().Content, "OleValue", cmpEqual, "Devise");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière mise à jour");   //il faut valider le texte   
      Log.Message("CROES-5066")     
      if(type=="option"){aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer().Content, "OleValue", cmpEqual, "_Transfert...")};   
}

function Check_Properties_English(type)
{
    aqObject.CheckProperty(Get_WinInfoSecurity_BtnOK().Content, "OleValue", cmpEqual, "OK");
    //aqObject.CheckProperty(Get_WinInfoSecurity_BtnApply().Content, "OleValue", cmpEqual, "_Apply");//CROES-5489 Le bouton Apply devrait être retiré.
    aqObject.CheckProperty(Get_WinInfoSecurity_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
      
    //*************************************************DESCRIPTION ********************************************** 
    //les étiquetés
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription().Header, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSubCategory().Text, "OleValue", cmpEqual, "Subcategory:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblFrenchDescription().Text, "OleValue", cmpEqual, "French Desc.:");
    if(client != "US" ){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblEnglishDescription().Text, "OleValue", cmpEqual, "English Desc.:");}
    if(type=="action" && client == "RJ" ){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIndustryCode().Text, "OleValue", cmpEqual, "Sector:")};
    if(type=="action" && client != "RJ" ){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIndustryCode().Text, "OleValue", cmpEqual, "Industry Code:")};
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCountry().Text, "OleValue", cmpEqual, "Country:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCurrency().Text, "OleValue", cmpEqual, "Currency:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCalculationFactor().Text, "OleValue", cmpEqual, "Calculation Factor:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblUpdatedOn().Text, "OleValue", cmpEqual, "Updated On:");
    if(type=="bond"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIssueDate().Text, "OleValue", cmpEqual, "Issue Date:")};   
    if(type=="option"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblOptionType().Text, "OleValue", cmpEqual, "Option Type:");}
    if(type=="action")aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblConversionDate().Text, "OleValue", cmpEqual, "Conversion Date:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCreationDate().Text, "OleValue", cmpEqual, "Creation Date:");
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){ 
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblDiscrMgmt().Text, "OleValue", cmpEqual, "Discr. Mgmt:");
    }
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSecurity().Text, "OleValue", cmpEqual, "Security:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblTypeClass().Text, "OleValue", cmpEqual, "Type/Class:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblISIN().Text, "OleValue", cmpEqual, "ISIN:");    
    if(type=="option"){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblStrikePrice().Text, "OleValue", cmpEqual, "Strike Price:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblExpiration().Text, "OleValue", cmpEqual, "Expiration:");}  
        
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket().Header, "OleValue", cmpEqual, "Market");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainMarket().Text, "OleValue", cmpEqual, "Main Market:");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainSymbol().Text, "OleValue", cmpEqual, "Main Symbol:");   
     
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Miscellaneous");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "Content", cmpEqual, "Non-redeemable");
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(), "Content", cmpEqual, "Exclude from the Foreign Property report",false );
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblForeignProperty().Text, "OleValue", cmpEqual, "Foreign Property:");
    // if (client == "CIBC" || client == "BNC" || client =="US"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblExcludeFromBilling().Text, "OleValue", cmpEqual, "Exclude from billing:")}; //N’existe pas dans l’automation 9 (BD FNB)   
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets().Content, "OleValue", cmpEqual, "Manage Markets...");
         
    //********************************************** L'ONGLET HISTORIQUE DE PRIX *************************************
    aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory().Header, "OleValue", cmpEqual, "Price History",false);
    aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory(), "IsSelected", cmpEqual, true);
      
    aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
    aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChBid().Content, "OleValue", cmpEqual, "Bid");
    aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChAsk().Content, "OleValue", cmpEqual, "Ask");
    aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChClose().Content, "OleValue", cmpEqual, "Close");
    aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChCurrency().Content, "OleValue", cmpEqual, "Currency");
    if (client == "CIBC")
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChLastUpdate().Content, "OleValue", cmpEqual, "Updated on");           
    else 
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChLastUpdate().Content, "OleValue", cmpEqual, "Last Update");           
    if(type=="option"){aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer().Content, "OleValue", cmpEqual, "_Transfer...")};
}

function Check_Existence_Of_Controls(type)
{
   //Les points des vérification pour la partie "Description"    
    //******************************************************DESCRIPTION *********************************************
    //les combobox et les textbox 
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbSubCategory(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbSubCategory(), "IsReadOnly", cmpEqual, true);
     if(client != "US" ){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription(), "IsReadOnly", cmpEqual, true); }
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription(), "IsVisible", cmpEqual, true);
    if(client == "US" ){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription(), "IsReadOnly", cmpEqual, false);
    } 
    else{
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription(), "IsReadOnly", cmpEqual, true);}
    
    if(type=="action"){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbIndustryCode(), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbIndustryCode(), "IsReadOnly", cmpEqual, true)};
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCountry(), "IsVisible", cmpEqual, true);
    if(client == "US" ){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCountry(), "IsReadOnly", cmpEqual, false);
    } 
    else{
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCountry(), "IsReadOnly", cmpEqual, true);}
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), "IsVisible", cmpEqual, true); 
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), "IsReadOnly", cmpEqual, false); 
    } 
    else{
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), "IsReadOnly", cmpEqual, true); }  
      
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), "IsVisible", cmpEqual, true); 
    if(client == "US" ){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), "IsReadOnly", cmpEqual, false);
    } 
    else{
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), "IsReadOnly", cmpEqual, true);} 
     
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtUpdatedOn(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtUpdatedOn(), "IsReadOnly", cmpEqual, true); 
    
    if(type=="bond"){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtIssueDate(), "IsVisible", cmpEqual, true); 
    if(client == "US"){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtIssueDate(), "IsReadOnly", cmpEqual, false);
    } 
    else{
       aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtIssueDate(), "IsReadOnly", cmpEqual, true);
    } 
   }
    
    if(type=="option"){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbOptionType(), "IsVisible", cmpEqual, true); 
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbOptionType(), "IsReadOnly", cmpEqual, false);
    } 
    else{ aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbOptionType(), "IsReadOnly", cmpEqual, true);}
   }
    
    if(type=="action"){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtConversionDate(), "IsVisible", cmpEqual, true); 
    if( client == "US" ){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtConversionDate(), "IsReadOnly", cmpEqual, false);}
    else{
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtConversionDate(), "IsReadOnly", cmpEqual, true);}}
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCreationDate(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCreationDate(), "IsReadOnly", cmpEqual, true); 
    
      if (client == "BNC" ){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtDiscrMgmt(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtDiscrMgmt(), "IsReadOnly", cmpEqual, true);
      }
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsVisible", cmpEqual, true);
    if(type=="option"){ aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsEnabled", cmpEqual, true);}
    if(type=="bond"|| type=="action"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsEnabled", cmpEqual, false)}; 
    
    if(type=="option")
    {aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsEnabled", cmpEqual, true);}
    else {aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsEnabled", cmpEqual, false);}
       
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtSecurity(), "IsVisible", cmpEqual, true); 
    if(client == "US" ){
       aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtSecurity(), "IsReadOnly", cmpEqual, false);
    } 
    else{
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtSecurity(), "IsReadOnly", cmpEqual, true); }
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCUSIP(), "IsVisible", cmpEqual, true); 
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCUSIP(), "IsReadOnly", cmpEqual, false); 
    } 
    else{
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCUSIP(), "IsReadOnly", cmpEqual, true); 
    } 
    
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtTypeClass(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtTypeClass(), "IsReadOnly", cmpEqual, true); 
     
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtISIN(), "IsVisible", cmpEqual, true);
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtISIN(), "IsReadOnly", cmpEqual, false);
    } 
    else{
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtISIN(), "IsReadOnly", cmpEqual, true);
    } 
    
     
    if(type=="option"){
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtStrikePrice(), "IsVisible", cmpEqual, true); 
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtStrikePrice(), "IsReadOnly", cmpEqual, false);
    } 
    else{
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtStrikePrice(), "IsReadOnly", cmpEqual, true);}
        
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtExpiration(), "IsVisible", cmpEqual, true); 
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtExpiration(), "IsReadOnly", cmpEqual, false);
    } 
    else{
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtExpiration(), "IsReadOnly", cmpEqual, true);
    }}
      
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_CmbMainMarket(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_CmbMainMarket(), "IsReadOnly", cmpEqual, false);
     
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(), "IsVisible", cmpEqual, true);
    if(client == "US" && type != "option" ){
     aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(), "IsReadOnly", cmpEqual, false); 
     
    } 
    else{
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(), "IsReadOnly", cmpEqual, true);
    } 
    
      
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsEnabled", cmpEqual, false);
     
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_CmbForeignProperty(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_CmbForeignProperty(), "IsReadOnly", cmpEqual, true);
     
//    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromBilling(), "IsVisible", cmpEqual, true); //N’existe pas dans l’automation 9 (BD FNB)   
//    aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromBilling(), "IsEnabled", cmpEqual, false); //N’existe pas dans l’automation 9 (BD FNB)   
    
    if(type=="option" || type=="action"){
      if (client == "BNC" ){    
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer(), "IsVisible", cmpEqual, true)
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer(), "IsEnabled", cmpEqual, true)
      }; 
    }
}