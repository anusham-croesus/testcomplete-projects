//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2111_Add_UnifiedManagedAccountsBoard()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");       
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnDashboard().Click();
        
        if(Get_Dashboard_UnallocatedPositionSleevesBoard().Exists){
            Get_Dashboard_UnallocatedPositionSleevesBoard().CloseBoard(); 
            AddUnifiedManagedAccountsBoard();
            aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard(), "VisibleOnScreen", cmpEqual, true);
            
            //********************************Le cas 2_11_7**********************************************************
            /*S'assurer que cet option ne s'affiche pas (comme le tableau 'Restrictions déclenchés, on ne voit pas l'icône du crayon)*/
            aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard(), "IsEditRulesSupported", cmpEqual, false);
                     
        }else{
            AddUnifiedManagedAccountsBoard();
            aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard(), "VisibleOnScreen", cmpEqual, true); 
             //********************************Le cas 2_11_7**********************************************************
            /*S'assurer que cet option ne s'affiche pas (comme le tableau 'Restrictions déclenchés, on ne voit pas l'icône du crayon)*/
            aqObject.CheckProperty(Get_Dashboard_UnallocatedPositionSleevesBoard(), "IsEditRulesSupported", cmpEqual, false);
                      
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

function AddUnifiedManagedAccountsBoard(){
  Get_Toolbar_BtnAdd().Click();
  Get_DlgAddBoard_TvwSelectABoard_UnifiedManagedAccounts().Click();
  Get_DlgAddBoard_BtnOK().Click();
} 