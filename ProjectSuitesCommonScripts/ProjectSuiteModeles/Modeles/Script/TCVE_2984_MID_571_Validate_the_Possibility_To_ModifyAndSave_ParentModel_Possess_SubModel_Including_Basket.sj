//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : (MIB-440) Valider qu'il est possible de modifier et sauvegarder un modèle parent
    qui détient un sous-modèle incluant un panier
        
    https://jira.croesus.com/browse/MIB-571
    Analyste d'assurance qualité : Christine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.20.2020.10-11
*/

function TCVE_2984_MID_571_Validate_the_Possibility_To_ModifyAndSave_ParentModel_Possess_SubModel_Including_Basket()
{
    try {
            
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7;
            
            
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-2984") 
                               
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;       
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         
            
            var mod_M571_subModel = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "M571_SUBMODEL", language+client);
            var mod_M571_parent   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "M571_PARENT", language+client);
            var basket_GROWTH     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "BASKET_GROWTH", language+client);
            var modelType         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
            var typePicker        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            
            var panier           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "PANIER", language+client);
            var securityBMO      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityBMO", language+client);
            var securityNA       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityNA", language+client);
            var securityGROWTH   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securityGROWTH", language+client);
             
            var targetBMO         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetBMO_571", language+client);
            var targetNA          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetNA_571", language+client);
            var targetSubmodel1   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_SUBMODEL", language+client);
            var targetGROWTH      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_GROWTH", language+client);
            
            var targetSubModelModified       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGETSUBMODEL_MODIFIED", language+client);
            var positionSolde                = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "POSITION_SOLDE", language+client);
            var panier_coissance             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "PANIER_CROISSANCE", language+client);
            var targetGROWTH_AJUSTED         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TargetNA_571", language+client);
            var targetGROWTH_AJUSTED_1       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_GROWTH_AJUSTED_1", language+client);
            var securityDescription_subModel = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SECURITY_DESCRIPTION_SUBMODEL", language+client);
            
            
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej");      
  
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//Étape2         
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Créer le modèle de firme M571-SUBMODEL. et ajouter au modele creer la position :Symbole = NA Cible(%) = 40 VM(%) = 40");      
            
            
  
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle mod_M1423 
            Log.Message("Créer le modèle mod_M571_subModel "); 
            Create_Model(mod_M571_subModel,modelType)
            
            
            //Ajouter des position dans le Modèle mod_M1423
            Log.Message("Ajouter la position NA au Modèle mod_M571_subModel"); 
            SearchModelByName(mod_M571_subModel);
            Drag( Get_ModelsGrid().Find("Value",mod_M571_subModel,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/2.9)),73);
            
            //Ajouter de la  position NA
            Log.Message("Ajout de la  position NA")
            AddPositionToModel(securityNA,targetNA,typePicker,"");
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
             
            //Cliquer sur l'épingle pour garder le portefeuille du modèle mod_M571_subModel sur l'écran
            Log.Message("Cliquer sur l'épingle pour garder le portefeuille du modèle mod_M571_subModel sur l'écran");
            EpinglerModele1();
            
            
//Étape3           
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3:Créer le modèle de firme mod_M571_parent et ajouter lui la position NA"); 
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            //Creation du modele
            Log.Message("Creation du modele mod_M571_parent")
            Create_Model(mod_M571_parent,modelType)
            
            //Ajouter des position dans le Modèle mod_M571_parent
            Log.Message("Ajouter des position dans le  Modèle mod_M571_parent"); 
            SearchModelByName(mod_M571_parent);
            Drag( Get_ModelsGrid().Find("Value",mod_M571_parent,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/2.9)),73)
            
            //Ajouter de la  position BMO
            Log.Message("Ajout de la  position BMO")
            AddPositionToModel(securityBMO,targetBMO,typePicker,""); 
            
            
            //Ajout du panier au sous modele M571-SUBMODEL
            Log.Message("Ajout du panier au sous modele M571-SUBMODEL");
            Get_Toolbar_BtnAdd().Click();
            AddSubModelToModel(mod_M571_subModel,targetSubmodel1);
            
            //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            //Cliquer sur l'épingle pour garder le portefeuille du modèle mod_M571_parent a l'écran
            Log.Message("Cliquer sur l'épingle pour garder le portefeuille du modèle mod_M571_parent a l'écran");
            EpinglerModele2();


//Étape4            
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4:Cliquer sur l'onglet du modèle M571-SUBMODEL et lui ajouter la position suivante :Position panier : Sous-modèle = GROWTH Cible(%) = 50 VM(%) = 50");
             
            //Retourner au premier modele 
            Get_MainWindow().Click(165,140)
            
            
            //Ajout du panier au sous modele M571-SUBMODEL
            Log.Message("Ajout du panier au sous modele M571-SUBMODEL");
            Get_Toolbar_BtnAdd().Click();
            AddSubModelToModel(basket_GROWTH,targetGROWTH);
            
             //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
           
            
            
//Étape5            
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5:Cliquer sur l'onglet du modèle M571-PARENT et mailler la position Solde vers le module portefeuille pour rafraichir les positions du modèle.");            

            
             //Aller au premier M571-PARENT 
            Get_MainWindow().Click(550,140);
            
            
            Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10).Click()
            Drag(Get_PortfolioPlugin().Find("OriginalValue",positionSolde,10), Get_ModulesBar_BtnPortfolio());
            
            //Valider que la cible du sous-modèle M571-SUBMODEL est cible = 80%  qui inclut la position panier PANIER CROISSANCE (cible = 40%)
            Log.Message("Valider que la cible du sous-modèle M571-SUBMODEL est cible = 80%  qui inclut la position panier PANIER CROISSANCE (cible = 40%).");
            var grid = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
             
               for (i=0; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecurityDescription == securityDescription_subModel){
                     
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,targetSubmodel1);
                        
                      } 
               }           
              grid.WPFObject("DataRecordPresenter", "", 3).set_IsExpanded(true);
               var grid = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1);
           
               var count = grid.Items.Count;
               
               for (i=0; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecurityDescription == panier_coissance){
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,targetGROWTH_AJUSTED);
                        
                      } 
               }
              
               
               
//Étape6            
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6:Cliquer sur l'onglet du modèle M571-PARENT et modifier la position suivante :Sous-modèle = M571-SUBMODEL Cible(%) = 50 VM(%) = 50.");            
            
            
            //Modifier la position suivante :Sous-modèle = M571-SUBMODEL Cible(%) = 50 VM(%) = 50
            Log.Message("Modifier la position suivante :Sous-modèle = M571-SUBMODEL Cible(%) = 50 VM(%) = 50");
            Get_Portfolio_AssetClassesGrid().Find("Value", securityDescription_subModel,10).DblClick(); 
            
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/2.9)),73) 
 
            if(targetSubModelModified != undefined && Trim(VarToStr(targetSubModelModified))!== ""){
               Get_WinSubModelInfo_TxtTargetValue().Keys(targetSubModelModified);
    
            } 
            Get_WinSubModelInfo_BtnOK().Click();
           
            //Sauvegarder le modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
            
            //Valider que la cible du sous-modèle M571-SUBMODEL est modifiée et sauvegardé  sans message d'erreur.avec 50 % (incluant le panier PANIER CROISSANCE avec cible = 25 %) 
            Log.Message("Valider que la cible du sous-modèle M571-SUBMODEL est modifiée et sauvegardé  sans message d'erreur.avec 50 % (incluant le panier PANIER CROISSANCE avec cible = 25 %) ");
            var grid = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
             
               for (i=0; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecurityDescription == securityDescription_subModel){
                     
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,targetSubModelModified);
                        
                      } 
               } 

               var grid = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1);
           
               var count = grid.Items.Count;
               
               for (i=0; i<count; i++){
                  if (grid.Items.Item(i).DataItem.SecurityDescription == panier_coissance){
                        
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetPercent",cmpEqual,targetGROWTH_AJUSTED_1);
                        
                      } 
               }  
 }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
            //Restore data
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7:Restore data");             
	
            DeleteModelByName(mod_M571_parent)
            DeleteModelByName(mod_M571_subModel)
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}

//fonction pour epingler le 1er modele  mod_M1423_parent
function EpinglerModele1()
{
  if (language=="french"){ Get_MainWindow().Click(145,140)}
  else {Get_MainWindow().Click(129,140)}
}

//fonction pour epingler le 1er modele  mod_M1423_parent
function EpinglerModele2()
{
  if (language=="french"){ Get_MainWindow().Click(410,140)}
  else {Get_MainWindow().Click(400,140)}
}
function AddSubModelToModel(subModel, valuePercent, marketValue ){

  Get_WinAddPositionSubmodel_TxtSubmodel().Click();
  Get_WinAddPositionSubmodel_TxtSubmodel().Keys(subModel);
  Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Enter]");

  if(valuePercent != undefined && Trim(VarToStr(valuePercent))!== ""){
    Get_WinAddPositionSubmodel_TxtValuePercent().Keys(valuePercent);
  }
  if(marketValue != undefined &&Trim(VarToStr(marketValue))!== ""){
    Get_WinAddPositionSubmodel_TxtMarketValue().Keys(marketValue);
  }
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
} 

function Get_WinPanierInfo(){return Get_WinSubModelInfo().FindChild("Uid", "SubModelInfoWindow_3afa", 10)}
function Get_WinPositionInfo_GrpPanierInformation_TxtTargetValue(){return Get_WinSubModelInfo().FindChild("Uid", "DoubleTextBox_b119", 10)}
function Get_WinSubModelInfo_TxtTargetValue(){return Get_WinSubModelInfo().FindChild("Uid", "DoubleTextBox_e4ec", 10)}
