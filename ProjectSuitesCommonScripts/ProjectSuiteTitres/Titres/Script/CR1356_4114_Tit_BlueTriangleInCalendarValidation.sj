//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/**
    
    Description : Régression: Validation du triangle bleu dans le calendier
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4114
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_4114_Tit_BlueTriangleInCalendarValidation(){
    
    try{            
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4114","Lien du Cas de test sur Testlink");
            
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            
        var security070623 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security070623", language+client);                               
        var recordDate070623 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "RecordDate070623", language+client); 
        var paymentDate070623 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "PaymentDate070623", language+client);
        var description070623 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Description070623", language+client); 
        var accountCount070623 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "AccountCount070623", language+client); 
        
        var security052150 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security052150", language+client); 
        var recordDate052150 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "RecordDate052150", language+client);
        var paymentDate052150 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "PaymentDate052150", language+client); 
        var description052150 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Description052150", language+client); 
        var accountCount052150 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "AccountCount052150", language+client);
        
                              
        Log.Message("**********************Login********************");                 
        Login(vServerTitre, userNameGP1859, passwordGP1859, language);
        
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 8], 15000);              
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsSelected",true, 15000);       
        Search_Security(security070623);
        
        //Click sur le titre recherché puis sur info   
        Get_SecurityGrid().Find("Value",security070623,10).Click(); 
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/15
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",recordDate070623,10).DataContext.DataItem.set_SpecialDividend(true);
        Get_WinInfoSecurity_BtnOK().Click();
                
        Search_Security(security052150);
        
        //Click sur le titre recherché puis sur info   
        Get_SecurityGrid().Find("Value",security052150,10).Click(); 
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/01
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",recordDate052150,10).DataContext.DataItem.set_SpecialDividend(true);
        Get_WinInfoSecurity_BtnOK().Click();

        Execute_SQLQuery("update b_task_group set Regen_date=null", vServerTitre);
        Execute_SQLQuery("update b_task_board set Regen_date=null", vServerTitre);      
        ExecuteSSHCommandCFLoader("CR1356", vServerTitre, "cfLoader -DashboardRegenerator ForceRegen -FIRM=FIRM_1", "amine");
       // RestartServices(vServerTitre);
        
        //Login(vServerTitre, userNameGP1859, passwordGP1859, language);       
        Get_ModulesBar_BtnDashboard().Click();
        
        //Ajouter le tableau Calendrier du tableau de bord s'il n'existe pas
        Add_CalendarBoard();
        Maximize_Board(Get_Dashboard_CalendarBoard());
        
        //Ajouter l'onglet 'Dividendes Exeptionnels' dans le tableau Calendrier du tableau de bord s'il n'existe pas
        if(!Get_Dashboard_CalendarBoard_TabSpecialDividends().Exists){
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","AddBoardDialog_c7f4");
            Get_DlgAddBoard_TvwSelectABoard_SpecialDividends().Click();       
            Get_DlgAddBoard_BtnOK().Click();
        }                        
        //Vérification que l'onglet existe et visible
        aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabSpecialDividends(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabSpecialDividends(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabSpecialDividends(), "VisibleOnScreen", cmpEqual, true);
        
        Get_Dashboard_CalendarBoard_TabSpecialDividends().Click();
        WaitObject(Get_CroesusApp(),"Uid", "DataGrid_f8ed", 20000);
        
        Get_Dashboard_CalendarBoard_MonthCalendar().set_SelectedDate(aqConvert.StrToDate(paymentDate052150));      
        
        if (language == "french")
            paymentDateCell = Get_Dashboard_CalendarBoard_MonthCalendar().FindChild(["ClrClassName", "WPFControlText"], ["MonthCalendarItem", "2009/12/30"], 10);    
        else 
            paymentDateCell = Get_Dashboard_CalendarBoard_MonthCalendar().FindChild(["ClrClassName", "WPFControlText"], ["MonthCalendarItem", "12/30/2009"], 10);    
        
        aqObject.CheckProperty(paymentDateCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "3"], 10),"Visible", cmpEqual, true);
        aqObject.CheckProperty(paymentDateCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "3"], 10),"VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(paymentDateCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "3"], 10),"Exists", cmpEqual, true);
        
        var list = Get_Dashboard_CalendarBoard_TabSpecialDividends_SpDivGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10);
        
        aqObject.CheckProperty(list.Items.Item(0).DataItem,"AccountCount", cmpEqual, accountCount052150);
        aqObject.CheckProperty(list.Items.Item(0).DataItem.SecurityDescription,"OleValue", cmpEqual, description052150);
        
        Get_Dashboard_CalendarBoard_MonthCalendar().set_SelectedDate(aqConvert.StrToDate(paymentDate070623));
        Get_Dashboard_CalendarBoard_TabSpecialDividends().Click();
        
        WaitObject(Get_CroesusApp(),"Uid", "DataGrid_f8ed", 20000);        

        aqObject.CheckProperty(list.Items.Item(0).DataItem,"AccountCount", cmpEqual, accountCount070623);
        aqObject.CheckProperty(list.Items.Item(0).DataItem.SecurityDescription,"OleValue", cmpEqual, description070623);
        var paymentDateCell;
        if (language == "french")
            paymentDateCell = Get_Dashboard_CalendarBoard_MonthCalendar().FindChild(["ClrClassName", "WPFControlText"], ["MonthCalendarItem", "2010/01/15"], 10);    
        else 
            paymentDateCell = Get_Dashboard_CalendarBoard_MonthCalendar().FindChild(["ClrClassName", "WPFControlText"], ["MonthCalendarItem", "01/15/2010"], 10);    
        
        aqObject.CheckProperty(paymentDateCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "3"], 10),"Visible", cmpEqual, true);
        aqObject.CheckProperty(paymentDateCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "3"], 10),"VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(paymentDateCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", "3"], 10),"Exists", cmpEqual, true);
            
        
    /*-------------------------------------------------------------------------------------------------------------------------------------------------*/
    /*-------------------------------------PARTIE AJOUTÉE POUR LA TCVE-1961: AUTOMATISATION DU JIRA CLIENT RISK-2769 ----------------------------------*/
    /*-------------------------------------------------------------------------------------------------------------------------------------------------*/
        
        //Vérifier que dans la BD il y'a 2 entrées pour le titre: 415318955, sinon ajouter une 2eme
        var nbRow = Execute_SQLQuery_GetNBRow("select * from b_risk_rating where SECURITY=415318955", vServerTitre);           
        Log.Message(nbRow)
        if (nbRow == 1) 
            Execute_SQLQuery("insert into b_risk_rating ( SECURITY, RATING, SOURCE, DATE_UPDATED, OVERWRITE, IS_CURRENT, CRIT_ID) values (415318955,1,'FALLBACK ','Jan 22 2010 12:00AM','N','N',Null)", vServerTitre);

        
        //Double cliquer sur le titre pour ouvrir la fenêtre Info
        Get_Dashboard_CalendarBoard_TabSpecialDividends_SpDivGrid().FindChild(["ClrClassName", "Value"], ["XamTextEditor", description070623], 10).DblClick();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        var riskRating = Get_WinInfoSecurity_GrpDescription_CmbRiskRating().Text
        var riskRatingSource = Get_WinInfoSecurity_GrpDescription_CmbRiskRatingSource().Text
        Log.Message("riskRating : "+ riskRating+ "; riskRatingSource : "+ riskRatingSource)
        
        //Décocher la case Dividende exceptionnel pour le dividende du 2009/12/15
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",recordDate070623,10).DataContext.DataItem.set_SpecialDividend(false);
        Get_WinInfoSecurity_BtnOK().Click(); 
        
        if (Get_DlgConfirmation().Exists)
                Log.Error("La fenêtre de confirmation est affichée") 
        else{
        
            Get_ModulesBar_BtnSecurities().Click(); 
            Get_ModulesBar_BtnSecurities().WaitProperty("IsSelected",true, 15000);             
            Search_Security(security070623);
        
            //Click sur le titre recherché puis sur info   
            Get_SecurityGrid().Find("Value",security070623,10).Click(); 
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
            aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbRiskRating(),      "Text", cmpEqual, riskRating);
            aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbRiskRatingSource(),"Text", cmpEqual, riskRatingSource);
        
            Get_WinInfoSecurity_BtnOK().Click();
            }
            
        //Retour à l'état initial
        Search_Security(security052150);      
        //Click sur le titre recherché puis sur info   
        Get_SecurityGrid().Find("Value",security052150,10).Click(); 
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Décocher la case Dividende exceptionnel pour le dividende du 2009/12/01
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",recordDate052150,10).DataContext.DataItem.set_SpecialDividend(false);
        Get_WinInfoSecurity_BtnOK().Click();
         }
    catch (e) {
            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {                      
        Terminate_CroesusProcess();                            
    }                    
}

function Maximize_Board(Board)
{
  if (Board.Exists) { Board.Click(Board.get_ActualWidth()-30, 13) }
}

function Execute_SQLQuery_GetNBRow(queryString, vServer)
{
    var query = queryString;	
    var Qry   = ADO.CreateADOQuery();
    
    Qry.ConnectionString = GetDBAConnectionString(vServer);	  
    Qry.SQL=query;
    Qry.Open();
    Qry.First();
    var i = 0;
      while (! Qry.EOF)
      {
        Qry.Next();
        i++;
      };
  Qry.Close();
  return i;
}