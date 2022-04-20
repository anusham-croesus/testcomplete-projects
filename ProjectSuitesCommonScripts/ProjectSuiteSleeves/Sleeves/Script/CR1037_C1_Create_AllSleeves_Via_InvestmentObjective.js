//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_C1_Create_AllSleeves_Via_InvestmentObjective()
{
      try{

         var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "AccountNo_C1", language+client); 
         var remainingTargetPercent= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleevesGrpSleevesTxtRemainingTargetPercent_C1", language+client);
         var assetAllocation =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationBalanced", language+client);  
              
         Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
         
         if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Exists && Get_PortfolioGrid_GrpSummary_ChkFundAllocation().VisibleOnScreen){
            if(Get_PortfolioGrid_GrpSummary_ChkFundAllocation().IsChecked){
            Get_PortfolioGrid_GrpSummary_ChkFundAllocation().Click()
            }
         }
                  
         //******************************************Vérification******************************************************************************************          
         /*a) La fenêtre 'gestionnaire des segments' doit s'afficher avec les segments (chaque segment correspond à une classe d'actif + le segment divers).
         b) Les cibles de chaque segment sont prépopulés selon l'objectif */             
         var sleeveDescription=GetAssetClassDescription();
         var targetObj=GetAssetClassObjTarget();
         CheckAssertClassVsSleeves(sleeveDescription,targetObj);
                 
         //c)Tous les titres de chaque classe d'actifs sont affichés dans la sleeve correspondante.                               
         ExpandAllAssetClassItems();
         
         var assetClassItemsCashAndCashEquivalents =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvCashAndCashEquivalents())// suavgarde les positions de chaque segment de la grille
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassItemsCashAndCashEquivalents,sleeveDescription[0])//La fonction vérifie les items de Encaisse et les compare avec les items dans la fenêtre de Gestionnaire de segments 
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(false) // Fermer + 
         
         var assetClassMediumTerm =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvMediumTerm())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassMediumTerm,sleeveDescription[1])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).set_IsExpanded(false)  
         
         var assetClassLongTerm =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvLongTerm())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassLongTerm,sleeveDescription[2])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).set_IsExpanded(false) 
         
         var assetClassOtherFixedIncome =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvOtherFixedIncome())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassOtherFixedIncome,sleeveDescription[3])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 4).set_IsExpanded(false) 
         
         var assetClassCanadianEquity =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvCanadianEquity())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassCanadianEquity,sleeveDescription[4])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",5).set_IsExpanded(false)
         
         var assetClassForeignEquity =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvForeignEquity())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassForeignEquity,sleeveDescription[6])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 7).set_IsExpanded(false)
         
         var assetClassOther =GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvOther())
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassOther,sleeveDescription[7])
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",8).set_IsExpanded(false)
                                         
         Get_PortfolioBar_BtnSleeves().Click();
         Get_WinManagerSleeves().Parent.Maximize();
         //e) Le champ '% restant de la cible' sera = 0. 
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_TxtRemainingTargetPercent(), "Text", cmpEqual, remainingTargetPercent);
         
         //f) Le champ 'Répartition d'actifs' sera grisé avec l'objectif de placement qu'on avait sélectionné.
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "Text", cmpEqual, assetAllocation);
         aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_CmbAssetAllocation(), "IsEnabled", cmpEqual,false);
         
         Get_WinManagerSleeves().Close();
         
         //d) le segment divers ne contient aucune position sauf le solde.
         CheckPositionOfUnallocated();         
                       
         //********************************************Remettre les données a l'êtas initial***************************************************************************
         //************************************************************************************************************************************************************    
         //Supprimer des segments 
         Delete_AllSleeves_WinSleevesManager();  
        
         Get_ModulesBar_BtnAccounts().Click();        
         UncheckInvestmentObjectiveWinInfo(account)     
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}

//Valide les positions a l’intérieur du segment Unallocated 
function CheckPositionOfUnallocated()
{
     var ItemSleeveUnallocated =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
     var PositionBalance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client);
      
     //Ouvrir le Gestionnaire des segments
     Get_PortfolioBar_BtnSleeves().Click();
     Get_WinManagerSleeves().Parent.Maximize();
         
     SelectSleeveWinSleevesManager(ItemSleeveUnallocated)
         
     aqObject.CheckProperty(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual, 1);
          
     if(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.SecurityDescription== PositionBalance){
        Log.Checkpoint("le segment divers ne contient aucune position sauf le solde.")
     }
     else{
         Log.Error("le segment divers contient plus que la position [solde].")
     }
     Get_WinManagerSleeves().Close();
}


//Création de segments pour le compte 800066-GT avec un Objectif:Equilibre (de firme)
//La fonction est réutilisée dans les cas de modifications
function Create_Sleeve_ForAccount_withGlobalBalancedAssetAllocation(account) 
{
      var user =ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "ROOSEF", "username");
      
      Login(vServerSleeves, user ,psw,language);
      Get_ModulesBar_BtnAccounts().Click();
 
      Search_Account(account);
      AddInvestmentObjectiveItemFirmItemGlobalBalanced();
          
      DragAccountToPortfolio(account);   
      CreateSleeveByAssetClass();  
      
      //Vérifier que des segments ont été créés
      //faire un right-click ensuite choisir créer des segements
      Get_PortfolioPlugin().ClickR(); 
      if(Get_PortfolioGrid_ContextualMenu_CreateSleeves().IsEnabled){
          Get_PortfolioPlugin().ClickR();
          Get_PortfolioPlugin().ClickR();
          Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();      
        //if(Get_DlgCroesus().Exists){//CP : Adaptation pour CO
        if (Get_DlgError().Exists){//CP : Adaptation pour CO
            Log.Checkpoint("Les segments pour le compte "+ account +"ont été créés")
            Get_DlgError().Close();
          }
          else{
            Log.Error("Les segments  pour le compte "+ account +"n'ont pas été créés")
          }
      }
      else{
        Log.Checkpoint("Les segments pour le compte "+ account +"ont été créés")
      }
}

//Ajout d'objectif:Equilibre (de firme)
function AddInvestmentObjectiveItemFirmItemGlobalBalanced()
{
   Get_AccountsBar_BtnInfo().Click();
   Get_WinAccountInfo_TabInvestmentObjective().Click();
   Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 15000);
   Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
   Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Balanced().Click();  
   Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Balanced().Click();  
   Get_WinSelectAnObjective_BtnOK().Click();
   Get_WinDetailedInfo_BtnOK().Click();
}

//La fonction sauvegarde les  descriptions de chaque class d’actif de la grille de portefeuille
function GetAssetClassDescription()
{
     //Récupérer la description de chaque segment de la grille de portefeuille
     var sleeveDescription=new Array();
     var countGrid= Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count 
     for(var i=0;i<=countGrid-1;i++){
       sleeveDescription[i]=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LongDescription     
     } 
     return sleeveDescription;
}

//La fonction suavgarde les objTargets de chaque segment de la grille de portefeuille
function GetAssetClassObjTarget()
{
     //Récupérer la objTarget de chaque segment de la grille de portefeuille
     var targetObj=new Array();
     var countGrid= Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count 
     for(var i=0;i<=countGrid-1;i++){
       targetObj[i]=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ObjTarget     
     }
     return targetObj;
}


 //La fonction vérifie la présence de tous les class d’actif de la grille, dans la fenêtre de gestionnaire des segments 
 //Pour les paramètres  il faut utiliser les fonction GetAssetClassObjTarget() et GetAssetClassDescription()
function CheckAssertClassVsSleeves(sleeveDescription,targetObj)  
{
     //Ouvrir le Gestionnaire des segments
     Get_PortfolioBar_BtnSleeves().Click();
     Get_WinManagerSleeves().Parent.Maximize();
     
     //Comparer avec la description dans la fenêtre Gestionnaire de segments 
     var countGrigManager =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
     for(var i=1;i<=countGrigManager-1;i++){
         if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(sleeveDescription[i-1]) && VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Ratio) == VarToString(targetObj[i-1])){
            Log.Checkpoint("Le segment ["+sleeveDescription[i-1]+"] est présent dans le gestionnaire et les cibles de chaque segment sont prépopulés selon l'objectif")
         }
         else{
            Log.Error("Le segment ["+sleeveDescription[i-1]+"] n'est pas présent dans le gestionnaire et les cibles de chaque segment ne sont pas prépopulés selon l'objectif")       
         }      
     } 
     Get_WinManagerSleeves().Close();    
}


//Éclater tous les  segments dans la grille de portefeuille 
function ExpandAllAssetClassItems()
{
  var countGrid= Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count    
  for(var i=1;i<=countGrid;i++){
      Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).set_IsExpanded(true)     
  }
}


//La fonction suavgarde les positions de chaque segment de la grille 
function GetAssetClassItems(assetClassItem)
{     
     var count =  assetClassItem.WPFObject("RecordListControl", "", 1).Items.Count
     var assetClassItems=new Array();
     
     for(var i=0;i<=count-1;i++){
      assetClassItems[i]=  assetClassItem.WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription 
      //Log.Message(assetClassItems[i]) 
     } 
     
     return assetClassItems;               
}


//La fonction vérifie les items de Encaisse et les compare avec les items dans la fenêtre de Gestionnaire de segments 
function Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassItems,description)
{
     
     var PositionBalance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "PositionBalance", language+client);
     
     //Ouvrir le Gestionnaire des segments
     Get_PortfolioBar_BtnSleeves().Click();
     Get_WinManagerSleeves().Parent.Maximize();
     
     SelectSleeveWinSleevesManager(description)
     
     //Comparer avec la description dans la fenêtre Gestionnaire de segments 
     var countGrigManager =Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Count;
     if(assetClassItems[0]==PositionBalance){
         for(var i=0;i<=countGrigManager-1;i++){
             if(VarToString(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription)==VarToString(assetClassItems[i])){
                Log.Checkpoint("Le titre ["+assetClassItems[i]+"] est présent dans le segment "+description+" de le gestionnaire")
             }
             else{
                Log.Error("Le titre ["+assetClassItems[i]+"] n'est pas présent dans le segment "+description+" de le gestionnaire")       
             }      
        }
     }
     else{
         for(var i=1;i<=countGrigManager-1;i++){
             if(VarToString(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription)==VarToString(assetClassItems[i-1])){
                Log.Checkpoint("Le titre ["+assetClassItems[i-1]+"] est présent dans le segment "+description+" de le gestionnaire")
             }
             else{
                Log.Error("Le titre ["+assetClassItems[i-1]+"] n'est pas présent dans le segment "+description+" de le gestionnaire")       
             }      
         }
     }
     Get_WinManagerSleeves().Close();
}

function Check_Securities_of_AssetAllocation(Description)
{
    var gridCount= Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count;
    
    for (var i = 0; i < gridCount-1; i++){    
       if(VarToString(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LongDescription)==VarToString(Description)){
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "",i+1).set_IsExpanded(true);// Growth Securities         
         var assetClassItems = GetAssetClassItems(Get_Portfolio_AssetClassesGrid_DgvItem(i+1))// suavgarde les positions de chaque segment de la grille
         Compare_UnderlyingSecurities_vs_AssetClassItems(assetClassItems ,Description)//La fonction vérifie les items de Growth Securities et les compare avec les items dans la fenêtre de Gestionnaire de segments          
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsExpanded(false) // Fermer + 
     }
    }
}

//La fonction vérifie le %Cible, Min, Max dans la fenêtre de gestionnaire.
function Check_MinMaxTarget_of_Sleeve(min,max,target,sleeveDescription)
{
      //Sélectionner le segment
      var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
      for (var i = 0; i < count; i++){          
            if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(sleeveDescription)){

                if(VarToInteger(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Ratio)==target && Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Ratio==null){
                  Log.Checkpoint("Le %cible est bon")
                }
                else{
                  Log.Error("Le %cible n'est pas bon")
                }
              
                if(VarToInteger(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.UpperToleranceWithFallback)==max && Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.UpperToleranceWithFallback==null){
                  Log.Checkpoint("Le %Max est bon")
                }
                else{
                  Log.Error("Le %Max n'est pas bon")
                }
              
                if(VarToInteger(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LowerToleranceWithFallback)==min && Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.LowerToleranceWithFallback ==null){
                  Log.Checkpoint("Le %Min est bon")
                }
                else{
                  Log.Error("Le %Min n'est pas bon")
                }
                break;
            }        
      }
}

//La fonction vérifie que la fenêtre 'Gestionnaire des segments' s'affiche avec un segment qu’on a créé et le segment divers. 
function Check_Presence_of_Unallocated_and_OtherSleeve(sleeveDescription,unallocated)
{   
     var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count; 
     if(count==2){    
       if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Description)== unallocated && VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.Description)==sleeveDescription){
          Log.Checkpoint("Le deux segments sont présents dans le gestionnaire")
       }
       else{
          Log.Error("Le deux segments ne sont pas présents dans le gestionnaire")       
       }      
     }
     else{
      Log.Error("There is more than two sleeves")
     }
}


function Check_RemainingTargetPercent()
{   
    var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
    var sumUpperTolerance=0;

    for (var i = 0; i < count; i++){          
             var UpperTolerance=Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Ratio;
             sumUpperTolerance=sumUpperTolerance+UpperTolerance              
    }
    var RemainingTargetPercent = 100-sumUpperTolerance 
    aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeves_TxtRemainingTargetPercent(), "Value", cmpEqual, RemainingTargetPercent);  
}



function Compare_GridSleeve_vs_ManagerSleeve(Description)
{
    
    var gridCount= Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count;
    
    
      for (var i = 0; i < gridCount-1; i++){    
          if(VarToString(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LongDescription)==VarToString(Description)){

             var itemObjTarget = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ObjTarget;
             var itemObjMin = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ObjMin
             var itemObjMax = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ObjMax
              break;
          }        
    }
    
    Get_PortfolioBar_BtnSleeves().Click();
    Get_WinManagerSleeves().Parent.Maximize();
    
    //Sélectionner le segment
    var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
    for (var i = 0; i < count; i++){          
          if(VarToString(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(Description)){

          
              if(VarToInteger(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Ratio)==VarToInteger(itemObjTarget)){
                Log.Checkpoint("Le %cible est bon")
              }
              else{
                Log.Error("Le %cible n'est pas bon")
              }
              
              if(VarToInteger(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.UpperTolerance)==VarToInteger(itemObjMax)){
                Log.Checkpoint("Le %Max est bon")
              }
              else{
                Log.Error("Le %Max n'est pas bon")
              }
              
              if(VarToInteger(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LowerTolerance)==(itemObjMin)){
                Log.Checkpoint("Le %Min est bon")
              }
              else{
                Log.Error("Le %Min n'est pas bon")
              }
              break;
          }        
    }
    Get_WinManagerSleeves().Close();
}



// La fonction valide si le segment 'Divers' contiendra le reste des positions.
function Check_of_Rest_Positions_in_Unallocated(sumNbrPositionPortfolioGrid,sumNbrPositionWinSleevesManager)  
{
  var nbrPositionUnallocated = VarToInteger(Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.PositionsCount)
  aqObject.CompareProperty((sumNbrPositionPortfolioGrid-sumNbrPositionWinSleevesManager),cmpEqual,nbrPositionUnallocated);
}

//La fonction return le nombre de position de tous les segments dans la grille 
function Count_Nbr_of_Position_PortfolioGrid()
{
  var countGrid= Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Count  
  var sumNbrPositionPortfolioGrid=0;
    
  for(var i=0;i< countGrid;i++){
      sumNbrPositionPortfolioGrid= sumNbrPositionPortfolioGrid + Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.NbPositions  
  }
  return VarToInteger(sumNbrPositionPortfolioGrid);
}

//La fonction return le nombre de position de tous les segments dans la fenêtre Gestionnaire de Segment, sauf "Divers"
function Count_Nbr_of_Position_WinSleevesManager()
{
  var count =Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Count;
  var sumNbrPositionWinSleevesManager=0;
    
      for (var i = 1; i < count; i++){          
             sumNbrPositionWinSleevesManager = sumNbrPositionWinSleevesManager + Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.PositionsCount;                        
    }
  return VarToInteger(sumNbrPositionWinSleevesManager-1);
}

