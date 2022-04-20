//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions


/* Description : Aller au module "Titre" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' contenant les boutons Info, 
Données historiques, Total détenu, Taux de change. Fermêture de l’application avec AltF4 */
// Lien cas de Test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-312

function Survol_Tit_AltF4() //Le script sers comme un exemple d’utilisation de datapool 
{
  Driver = DDT.ExcelDriver(dataPoolTitre, "Feuil1", true);
    //Filename: is the name of excel file being used.
   //Sheet: is the excel sheet which has the data, that will be used for test.
   //UseAceDriver: a Boolean value. If True, TestComplete makes use of ACE driver to connect an excel sheet. 
   //If it is False, TestComplete connects to the excel sheet via the Microsoft Excel ODBC driver.
   // ACE driver lets us to connect Excel 2007 sheets together with earlier version of Microsoft Excel.

    while(!Driver.EOF())
  {
    Login(vServerTitre,Driver.Value(0),Driver.Value(1),language); //Driver.Value(n), carries the data from excel sheet. The first column of the excel sheet is read as zeroth column.
    Get_ModulesBar_BtnSecurities().Click()
  
    //Les points de vérification en français 
     if(language=="french"){ Check_Properties_French()} 
   
    //Les points de vérification en anglais 
     else {Check_Properties_English()}
   
    Close_Croesus_AltF4()
    //Sys.Browser("iexplore").Close()
    Driver.Next(); // Goes to the next record
  }
  
  // Closing the driver
  DDT.CloseDriver(Driver.Name);
}

//Fonctions  (les points de vérification pour les scripts qui testent Close_Application)
function Check_Properties_French()
{
    //aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, Driver.Value(2));
    aqObject.CheckProperty(Get_SecuritiesBar_BtnInfo(), "Content", cmpEqual, "_Info");
    aqObject.CheckProperty(Get_SecuritiesBar_BtnHistoricalData(), "Content", cmpEqual, "_Données historiques");
    aqObject.CheckProperty(Get_SecuritiesBar_BtnTotalHeld(), "Content", cmpEqual, "_Total détenu");
    aqObject.CheckProperty(Get_SecuritiesBar_BtnExchangeRate(), "Content", cmpEqual, "T_aux de change");
}

function Check_Properties_English()
{
    //aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, Driver.Value(3));
    aqObject.CheckProperty(Get_SecuritiesBar_BtnInfo(), "Content", cmpEqual, "I_nfo");
    aqObject.CheckProperty(Get_SecuritiesBar_BtnHistoricalData(), "Content", cmpEqual, "Historical _Data");
    aqObject.CheckProperty(Get_SecuritiesBar_BtnTotalHeld(), "Content", cmpEqual, "T_otal Held");
    aqObject.CheckProperty(Get_SecuritiesBar_BtnExchangeRate(), "Content", cmpEqual, "Exch_ange Rate");
}

