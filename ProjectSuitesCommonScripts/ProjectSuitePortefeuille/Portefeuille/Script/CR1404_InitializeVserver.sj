//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


function CR1404_InitializeVserver()
{
  var CRFolder = "CR1404"
  var vserverCommand = vServerPortefeuille;
  var username = "christinep";
  var sshCommand1 = "cfLoader -AccruedInterestsCalculator \\\"-Date=2005.09.30 -IsBackDate\\\""; //EM : 90.08.Dy-8 : Modifié suite à la réponse de Christine P.- Suite au JIRA CROES-10981 - Avant c'était Date = 2005.10.01
  var sshCommand2 = "cfLoader -TransactionsCalculator -AccruedInitial -Firm=FIRM_1";
  var sshCommand3 = "cfLoader -TransactionsCalculator -CashflowOnly -Firm=FIRM_1";
  var sqlCommand1 = "update b_compte set trans_recalc_date='2005.09.30', recalc_mode = 1 where no_compte in " +
                    "(\"800011-NA\", \"800228-RE\", \"800241-RE\", \"300001-NA\", \"300002-OB\", \"300010-NA\", \"300010-OB\", \"300012-NA\", \"800006-OB\", \"800010-NA\", \"800011-GT\",\"800011-JW\", \"800239-SF\", \"800279-SF\", \"800021-FS\", \"800210-RE\")";
  var sqlCommand2 = "update b_compte set trans_recalc_date='2005.09.30', recalc_mode = null where no_compte in" +
                    "(\"800011-NA\", \"800228-RE\", \"800241-RE\", \"300001-NA\", \"300002-OB\", \"300010-NA\", \"300010-OB\", \"300012-NA\", \"800006-OB\", \"800010-NA\", \"800011-GT\",\"800011-JW\", \"800239-SF\", \"800279-SF\", \"800021-FS\", \"800210-RE\")";

  ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand1, username);
  Execute_SQLQuery(sqlCommand1, vserverCommand);
  ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand2, username);
  Execute_SQLQuery(sqlCommand2, vserverCommand);
  ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand3, username);
}
