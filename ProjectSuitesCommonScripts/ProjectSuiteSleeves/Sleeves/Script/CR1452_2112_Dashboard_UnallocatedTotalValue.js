//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_2111_Add_UnifiedManagedAccountsBoard

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
 Le tableau de bord listera tous les comptes UMA ayant un segment non-attribué dont la valeur totale n’égale pas 0$.
 Le script valide que tous les comptes qui sont dans le tableau «Comptes à gestions unifiés) ont une valeur totale non-attribuée. 
Analyste d'automatisation: Youlia Raisper */


function CR1452_2112_Dashboard_UnallocatedTotalValue()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");       
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnDashboard().Click();
        
        if(Get_Dashboard_UnallocatedPositionSleevesBoard().Exists){            
            CheckUnallocatedTotalValue()                     
        }else{
            AddUnifiedManagedAccountsBoard();
            CheckUnallocatedTotalValue()                      
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

function CheckUnallocatedTotalValue()
{
  var count= Get_Dashboard_DvgUnallocatedPositionSleevesBoard().WPFObject("RecordListControl", "", 1).Items.Count
  for(i=0;i<count;i++){
    aqObject.CheckProperty(Get_Dashboard_DvgUnallocatedPositionSleevesBoard().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "SleeveTotalValue", cmpGreater, 0);  
  } 
} 