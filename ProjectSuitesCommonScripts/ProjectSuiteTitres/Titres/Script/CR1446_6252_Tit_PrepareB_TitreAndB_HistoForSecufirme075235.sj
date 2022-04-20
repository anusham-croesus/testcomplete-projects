//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Description :Préparation de B_TITRE et B_HISTO pour le secufirme 075235.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6252
    Version de scriptage : ref90-10-12--V9-croesus-co7x-1_5_565
    Analyste d'assurance qualité :carolet
    Analyste d'automatisation : Asma Alaoui
*/

function CR1446_6252_Tit_PrepareB_TitreAndB_HistoForSecufirme075235()
{
  try{
  
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6252", "CR1446_6252_Tit_PrepareB_TitreAndB_HistoForSecufirme075235()");
    var UserName = ReadDataFromExcelByRowIDColumnID(filePath_Titre,"CR1446", "Name", language+client);
         
    //Exécuter les requêtes suivantes pour b_titre et b_histo
    Execute_SQLQuery("update b_titre set prix_close = 0.00000000, date_price = 'Jan 25 2010 12:00AM', nd_price = 'Y' where secufirme = '075235' " , vServerTitre);
    Execute_SQLQuery("update b_histo set prix_close = 0.00000000, nd_price = 'Y' where date_histo = 'Jan 25 2010 12:00AM' and security in (select security from b_titre where secufirme = '075235') " , vServerTitre);
 
    //valider le résultat avec la requete suivante pour b_titre :
    var prixC =Execute_SQLQuery_GetFieldAllValues("select prix_close from b_titre where secufirme = '075235'" , vServerTitre, "prix_close");
    var price =Execute_SQLQuery_GetFieldAllValues("select nd_price from b_titre where secufirme = '075235'" , vServerTitre, "nd_price");
    var date =Execute_SQLQuery_GetFieldAllValues("select date_price from b_titre where secufirme = '075235'" , vServerTitre, "date_price");
    var secu=Execute_SQLQuery_GetFieldAllValues("select secufirme  from b_titre where secufirme = '075235'" , vServerTitre, "secufirme");
    Log.Message(prixC);
    Log.Message(price);
    Log.Message(date);
    Log.Message(secu);

    var dat =aqString.SubString(date, 4, 7)+aqString.SubString(date, 24, 5)
    var time=aqString.SubString(date, 11, 9);
    Log.Message(dat);
    Log.Message(time);
    //convertir l'heure 00:00:00 à format 12:00 AM
    var timeAM= tConv24(time);
    
    //modifier le format du prix avec 8 chiffres après le 0
    var Pdecimal=aqString.Format("%.8f ",prixC)
    Log.Message(Pdecimal);
    
    //valider les résultats
    aqObject.CompareProperty(dat, cmpEqual, "Jan 25 2010", true);
    aqObject.CompareProperty(timeAM, cmpEqual, "12:00 AM", true);
    aqObject.CompareProperty(Pdecimal, cmpEqual, "0.00000000 ", true);
    aqObject.CompareProperty(price, cmpEqual, "Y", true);
    aqObject.CompareProperty(secu, cmpEqual, "075235", true);

    //valider le résultat de la requete suivante pour b_histo :
    var prixClose =Execute_SQLQuery_GetFieldAllValues("select prix_close, nd_Price from b_histo where date_histo = 'Jan 25 2010 12:00AM' and security in (select security from b_titre where secufirme = '075235')" , vServerTitre, "prix_close");
    var ndPrice =Execute_SQLQuery_GetFieldAllValues("select prix_close, nd_Price from b_histo where date_histo = 'Jan 25 2010 12:00AM' and security in (select security from b_titre where secufirme = '075235')" , vServerTitre, "nd_Price");
    Log.Message(prixClose);
    Log.Message(ndPrice);
    var Pdecimal=aqString.Format("%.8f ",prixClose)
    Log.Message(Pdecimal);
    aqObject.CompareProperty(Pdecimal, cmpEqual, "0.00000000 ", true);
    aqObject.CompareProperty(ndPrice, cmpEqual, "Y", true);
    
    //lancer la commande loader suivante :
    ExecuteSSHCommandCFLoader("CR1446", vServerTitre, "loader -REPROCESS=800057-RE,2010.01.25 -FORCE -LOG2STDOUT", UserName);
    
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
}

function tConv24(time24) {
  var ts = time24;
  var H = +ts.substr(0, 2);
  var h = (H % 12) || 12;
  h = (h < 10)?("0"+h):h;  // leading 0 at the left for 1 digit hours
  var ampm = H < 12 ? " AM" : " PM";
  ts = h + ts.substr(2, 3) + ampm;
  return ts; 
}
