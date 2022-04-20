//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT 

/* Description : Générer un rapport performance du portefeuille. 
    Pré-condition
    "PREF_REPORT_PERFORMANCE=YES
    PREF_ACCESS_PERFORMANCE_FIGURES=YES
    PREF_PERFORMANCE_REPORT_DETAILS=NO
    PREF_TIME_MONEY_WEIGHTED=2
    PREF_NET_GROSS_REPORT=2"
    Français	
    KEYNEJ (FIRMADM, _FRM)
    800262-JW (BD66, CAD)
    
    Modifier les paramètres comme suit: Période _Période: Fixe
      
    Destination: Aperçu
    _Trier par: Numéro de compte
    _Devise / Currency: CAD
    _Langue / Language: Français
    
    Résultat
    1 rapport généré pour le compte sélectionné

Analyste d'assurance qualité: Christine P
Analyste d'automatisation: Ying Gao */

 
 function PerformanceDuPortefeuille_Acc_KEYNEJ_2()
{   
    client="BNC"
    
    language = "french";//english or french
    
    var account = "800262-JW";
    var typeReport = GetData(filePath_Accounts,"ReportsGeneration",3,language);  
    var reportName = "PerformanceDuPortefeuille_Acc_KEYNEJ_2";
    var acrobatProcessName = GetAcrobatProcessName(); //2021-12-24: Ajouté par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
    
    //Création un folder pour savergarder les rapports
    var folderName = GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 2);
    Create_Folder(Project.Path + "Rapport" + folderName+"\\");
   
   try    
    {     
        // Modifier les Prefs
      Activate_Inactivate_PrefBranch(0,"PREF_PERFORMANCE_REPORT_DETAILS","NO",vServerAccounts);
      Activate_Inactivate_PrefBranch(0,"PREF_TIME_MONEY_WEIGHTED","2",vServerAccounts);
      Activate_Inactivate_PrefBranch(0,"PREF_NET_GROSS_REPORT","2",vServerAccounts)
    
      // kill the Acrobat Process 
       while(Sys.waitProcess(acrobatProcessName).Exists){ //2021-12-24: MAJ par Christophe Paring
         Sys.Process(acrobatProcessName).Terminate(); //2021-12-24: MAJ par Christophe Paring
      }  
      
      //supprimer le fichier si il existe dans le dossier 
      if(aqFile.Exists(Project.Path + "Rapport" + folderName+"\\"+reportName+".pdf")){// supprimer le fichier si existe 
        aqFileSystem.DeleteFile(Project.Path + "Rapport" + folderName+"\\"+reportName+".pdf")  
     } 
          
      Login(vServerAccounts, "KEYNEJ" , psw ,language);
      Get_ModulesBar_BtnAccounts().Click();      
      
      // Chercher le compte account, rendre le compte visible
      Search_Account(account);    
      Get_RelationshipsClientsAccountsGrid().Find("value",account,10).Click();
      
      Get_Toolbar_BtnReportsAndGraphs().Click();
      Delay(2000);
      
      // Chercher le type de rapport:"Portfolio Performance"
   //   search_reports(typeReport); 
      SelectAReport(typeReport);         
      
      Get_Reports_GrpReports_BtnAddAReport().Click();               
      // Modifier les paramètres
      Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().WaitProperty("IsEnabled", true,2000);
      Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
      Get_WinParameters_GrpPeriod_CmbPeriod().Click();
      Get_SubMenus().Find("WPFControlText",GetData(filePath_Accounts,"ReportsGeneration",6,language),10).Click();
      Get_WinParameters_BtnOK().click();
            
      // Modifier les options
      Get_WinReports_GrpOptions_CmbSortBy().Click();
      Get_SubMenus().Find("WPFControlText",GetData(filePath_Accounts,"ReportsGeneration",7,language),10).Click();
      
      Get_WinReports_GrpOptions_CmbCurrency().Click();
      Get_SubMenus().Find("WPFControlText",GetData(filePath_Accounts,"ReportsGeneration",8,language),10).Click();//CAD
      Get_WinReports_GrpOptions_CmbLanguage().Click();
      Get_SubMenus().Find("WPFControlText",GetData(filePath_Accounts,"ReportsGeneration",9,language),10).Click();
            
      Get_WinReports_BtnOK().Click();

      Sys.WaitProcess(acrobatProcessName, 100000, 1); //2021-12-24: MAJ par Christophe Paring
      // Vérifier si le fichier PDF s'afficher     
      aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
      //Sauvgarder le fichier
      SaveAs_AcrobatReader(Project.Path + "Rapport" + folderName+"\\"+reportName);
             
      Delay(2000);
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();    
      FindFileInFolder(Project.Path + "Rapport" + folderName+"\\",reportName+".pdf")     
  
   }        
     
   catch(e) {
        Log.Error("Exception!");
   }
   finally{
   
     // À la fin d'exécution, remettrer les prefs à l'état initiale
     Activate_Inactivate_PrefBranch(0,"PREF_PERFORMANCE_REPORT_DETAILS","YES",vServerClients)
     Activate_Inactivate_PrefBranch(0,"PREF_TIME_MONEY_WEIGHTED","5",vServerClients)
     Activate_Inactivate_PrefBranch(0,"PREF_NET_GROSS_REPORT","1",vServerClients)
          
   }
}
