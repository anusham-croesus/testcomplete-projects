//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Securities
    CR                   :  1957
    TestLink             :  Croes-4648
    Description          :  Valider la graphique qui s'affiche dans info titre.
                            Croesus Conseiller (version Windows) utilise la librairie tierce Infragistics pour les composantes de grilles et de charts.  La composante de charts a cependant été abandonnée par Infragistics depuis un certain temps.
                            Dans le but de pouvoir mettre à jour la librairie Infragistics pour la grille, nous voulons cesser d'utiliser Infragistics pour les charts.  Nous avions sélectionné la librairie LiveCharts et nous l'avions même utilisée récemment pour une modification BNC (BNC-772).
                            Dans le cadre de ce CR, nous voulons migrer tous les graphiques restants de Croesus Conseiller à la nouvelle librairie.
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  27/12/2018
    
*/


function CR1957_Croes_4648_ValidateGraphThatAppearsInTitleInfo() {
         
          try {     
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4648","Lien du Cas de test sur Testlink");
                
                    var userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
                    var passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
                    var SecuritySymbol = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_SecuritySymbol", language+client);
                    
                    var Description1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item1Description", language+client);
                    var Percentage1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item1Percentage", language+client);
                    var Color1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item1Color", language+client);
                    var Description2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item2Description", language+client);
                    var Percentage2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item2Percentage", language+client);
                    var Color2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item2Color", language+client);
                    var Description3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item3Description", language+client);
                    var Percentage3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item3Percentage", language+client);
                    var Color3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item3Color", language+client);
                    var Description4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item4Description", language+client);
                    var Percentage4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item4Percentage", language+client);
                    var Color4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item4Color", language+client);
                    var Description5 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item5Description", language+client);
                    var Percentage5 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item5Percentage", language+client);
                    var Color5 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item5Color", language+client);
                    var Description6 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item6Description", language+client);
                    var Percentage6 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item6Percentage", language+client);
                    var Color6 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item6Color", language+client);
                    var Description7 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item7Description", language+client);
                    var Percentage7 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item7Percentage", language+client);
                    var Color7 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item7Color", language+client);
                    var Description8 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item8Description", language+client);
                    var Percentage8 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item8Percentage", language+client);
                    var Color8 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item8Color", language+client);
                    var PercentDisplay1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item1PercentDisplay", language+client);
                    var PercentDisplay2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item2PercentDisplay", language+client);
                    var PercentDisplay3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item3PercentDisplay", language+client);
                    var PercentDisplay4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item4PercentDisplay", language+client);
                    var PercentDisplay5 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item5PercentDisplay", language+client);
                    var PercentDisplay6 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item6PercentDisplay", language+client);
                    var PercentDisplay7 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item7PercentDisplay", language+client);
                    var PercentDisplay8 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1957", "CR1957_Croes_4648_Item8PercentDisplay", language+client);
                    
                    //Mettre la pref "PREF_ENABLE_ALLOC_FUNDS" à la valeur YES
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_ALLOC_FUNDS","YES",vServerTitre);
                    RestartServices(vServerTitre);
                    
                    //Se connceter et acceder au module Titres
                    Login(vServerTitre, userNameREAGAR, passwordREAGAR, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Rechercher le titre avec symbole: CIG649
                    Search_SecurityBySymbol(SecuritySymbol);
                    Get_SecurityGrid().FindChild(["ClrClassName","Text"],["XamTextEditor",SecuritySymbol],10).DblClick();
                    WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
                    
                    //Acceder à l'onglet Répartitions d'actifs
                    Get_WinInfoSecurity_TabAssetAllocation().Click();
                    
                    //Points de vérification
                    //Vérification du ToolTip
                    Log.Message("Vérification du ToolTip");
                    var AssetAllocationChart = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("livePieChart");
                    while (AssetAllocationChart.ToolTip.DataContext == null)
                    {
                         AssetAllocationChart.HoverMouse();
                    }
                    
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(0).Values.Item(0),"LongDescription" ,cmpEqual, Description1);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(0).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage1);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(0).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color1);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(1).Values.Item(0),"LongDescription" ,cmpEqual, Description2);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(1).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage2);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(1).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color2);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(2).Values.Item(0),"LongDescription" ,cmpEqual, Description3);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(2).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage3);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(2).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color3);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(3).Values.Item(0),"LongDescription" ,cmpEqual, Description4);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(3).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage4);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(3).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color4);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(4).Values.Item(0),"LongDescription" ,cmpEqual, Description5);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(4).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage5);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(4).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color5);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(5).Values.Item(0),"LongDescription" ,cmpEqual, Description6);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(5).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage6);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(5).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color6);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(6).Values.Item(0),"LongDescription" ,cmpEqual, Description7);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(6).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage7);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(6).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color7);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(7).Values.Item(0),"LongDescription" ,cmpEqual, Description8);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(7).Values.Item(0),"PercentageTmp" ,cmpEqual, Percentage8);
                    aqObject.CheckProperty(AssetAllocationChart.ToolTip.DataContext.PieChartSeries.Item(7).Values.Item(0),"ColorCodeARGB" ,cmpEqual, Color8);    
                    
                    //Vérification de la table du graphique
                    var Grid = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("DataGrid", "", 1).WPFObject("RecordListControl", "", 1);
                    aqObject.CheckProperty(Grid.Items.Item(0).DataItem,"LongDescription" ,cmpEqual, Description1);
                    aqObject.CheckProperty(Grid.Items.Item(0).DataItem,"PercentageTmp" ,cmpEqual, Percentage1);
                    aqObject.CheckProperty(Grid.Items.Item(0).DataItem,"ColorCodeARGB" ,cmpEqual, Color1);
                    aqObject.CheckProperty(Grid.Items.Item(1).DataItem,"LongDescription" ,cmpEqual, Description2);
                    aqObject.CheckProperty(Grid.Items.Item(1).DataItem,"PercentageTmp" ,cmpEqual, Percentage2);
                    aqObject.CheckProperty(Grid.Items.Item(1).DataItem,"ColorCodeARGB" ,cmpEqual, Color2);
                    aqObject.CheckProperty(Grid.Items.Item(2).DataItem,"LongDescription" ,cmpEqual, Description3);
                    aqObject.CheckProperty(Grid.Items.Item(2).DataItem,"PercentageTmp" ,cmpEqual, Percentage3);
                    aqObject.CheckProperty(Grid.Items.Item(2).DataItem,"ColorCodeARGB" ,cmpEqual, Color3);
                    aqObject.CheckProperty(Grid.Items.Item(3).DataItem,"LongDescription" ,cmpEqual, Description4);
                    aqObject.CheckProperty(Grid.Items.Item(3).DataItem,"PercentageTmp" ,cmpEqual, Percentage4);
                    aqObject.CheckProperty(Grid.Items.Item(3).DataItem,"ColorCodeARGB" ,cmpEqual, Color4);
                    aqObject.CheckProperty(Grid.Items.Item(4).DataItem,"LongDescription" ,cmpEqual, Description5);
                    aqObject.CheckProperty(Grid.Items.Item(4).DataItem,"PercentageTmp" ,cmpEqual, Percentage5);
                    aqObject.CheckProperty(Grid.Items.Item(4).DataItem,"ColorCodeARGB" ,cmpEqual, Color5);
                    aqObject.CheckProperty(Grid.Items.Item(5).DataItem,"LongDescription" ,cmpEqual, Description6);
                    aqObject.CheckProperty(Grid.Items.Item(5).DataItem,"PercentageTmp" ,cmpEqual, Percentage6);
                    aqObject.CheckProperty(Grid.Items.Item(5).DataItem,"ColorCodeARGB" ,cmpEqual, Color6);
                    aqObject.CheckProperty(Grid.Items.Item(6).DataItem,"LongDescription" ,cmpEqual, Description7);
                    aqObject.CheckProperty(Grid.Items.Item(6).DataItem,"PercentageTmp" ,cmpEqual, Percentage7);
                    aqObject.CheckProperty(Grid.Items.Item(6).DataItem,"ColorCodeARGB" ,cmpEqual, Color7);
                    aqObject.CheckProperty(Grid.Items.Item(7).DataItem,"LongDescription" ,cmpEqual, Description8);
                    aqObject.CheckProperty(Grid.Items.Item(7).DataItem,"PercentageTmp" ,cmpEqual, Percentage8);
                    aqObject.CheckProperty(Grid.Items.Item(7).DataItem,"ColorCodeARGB" ,cmpEqual, Color8);
                    
                    //Vérifier l'affichage du pourcentage
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay1);
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay2);
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 3).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay3);
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 4).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay4);
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 5).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay5);
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 6).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay6);
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 7).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay7);
                    aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 8).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay8);

                    //Fermer la fenêtre info titre
                    Get_WinInfoSecurity_BtnOK().Click();
                             
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
          }         
          finally {         
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
                    //Remise de la pref par défaut
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_ALLOC_FUNDS","NO",vServerTitre);
                    RestartServices(vServerTitre);
          }
}

function test(){
     var Grid = Get_WinInfoSecurity().WPFObject("TabControl", "", 1).WPFObject("DataGrid", "", 1).WPFObject("RecordListControl", "", 1);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay1);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay2);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 3).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay3);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 4).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay4);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 5).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay5);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 6).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay6);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 7).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay7);
     aqObject.CheckProperty(Grid.WPFObject("DataRecordPresenter", "", 8).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1),"DisplayText",cmpEqual, PercentDisplay8);

}