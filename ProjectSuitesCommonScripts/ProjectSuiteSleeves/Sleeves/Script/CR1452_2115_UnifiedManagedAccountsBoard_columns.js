//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Les colonnes qui devraient exister dans ce tableau: No de compte, Nom, Code de CP, Valeur totale non-attribuée, Valeur totale du compte, Devise, Assignée à
Analyste d'automatisation: Youlia Raisper */


function CR1452_2115_UnifiedManagedAccountsBoard_columns()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");       
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnDashboard().Click();
        
        if(Get_Dashboard_UnallocatedPositionSleevesBoard().Exists){
           CheckUnifiedManagedAccountsBoardColumns();          
        }else{
           Get_Toolbar_BtnAdd().Click();
           Get_DlgAddBoard_TvwSelectABoard_UnifiedManagedAccounts().Click();
           Get_DlgAddBoard_BtnOK().Click();
           CheckUnifiedManagedAccountsBoardColumns();
        }                            
                
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

function CheckUnifiedManagedAccountsBoardColumns(){
  aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard_ChAccountNo(), "VisibleOnScreen", cmpEqual, true);  
  aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard_ChName(), "VisibleOnScreen", cmpEqual, true);
  aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard_ChIACode(), "VisibleOnScreen", cmpEqual, true);
  aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard_ChAccountTotalValue(), "VisibleOnScreen", cmpEqual, true);
  aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard_ChUnallocatedTotalValue(), "VisibleOnScreen", cmpEqual, true);
  aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard_ChCurrency(), "VisibleOnScreen", cmpEqual, true);
  aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard_ChAssignedTo(), "VisibleOnScreen", cmpEqual, true);
  
} 