//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_PREF_ORDER_DELAY()
{
    try{  
    
        var description=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CR1452_PREF_ORDER_DELAY_DESC", language+client); 
        var defaultValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CR1452_PREF_ORDER_DELAY_DEFAULTVALUE", language+client); 
        var minValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CR1452_PREF_ORDER_DELAY_DESC_MINVALUE", language+client); 
        var maxValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CR1452_PREF_ORDER_DELAY_DESC_MAXVALUE", language+client); 
        
        Log.Message(aqString.Replace(aqString.Replace(SQLQuery(vServerSleeves,"select * from b_def where cle like '%PREF_ORDER_DELAY%'","desc_l1")," ", ""),"\n",""))
                         
        if((aqString.Replace(aqString.Replace(SQLQuery(vServerSleeves,"select * from b_def where cle like '%PREF_ORDER_DELAY%'","desc_l1")," ", ""),"\n",""), cmpEqual, description)){
          Log.Checkpoint("La valeur est bonne")
        }else{
          Log.Error("La valeur n'est pas bonne")
        } 
        
        if(SQLQuery(vServerSleeves,"select * from b_def where cle like '%PREF_ORDER_DELAY%'","default_value")==defaultValue){
          Log.Checkpoint("La valeur est bonne")
        }else{
          Log.Error("La valeur n'est pas bonne")
        }
        
        if(SQLQuery(vServerSleeves,"select * from b_def where cle like '%PREF_ORDER_DELAY%'","min_value")==minValue){
          Log.Checkpoint("La valeur est bonne")
        }else{
          Log.Error("La valeur n'est pas bonne")
        }
        
         if(SQLQuery(vServerSleeves,"select * from b_def where cle like '%PREF_ORDER_DELAY%'","max_value")==maxValue){
          Log.Checkpoint("La valeur est bonne")
        }else{
          Log.Error("La valeur n'est pas bonne")
        }     
   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function SQLQuery(vServer,query,column)
{
        //SELECT     
        var querySelect=query;
        Log.Message(querySelect);
      
        var Qry =ADO.CreateADOQuery();
        Qry.ConnectionString = GetDBAConnectionString(vServer);
      
        Qry.SQL =querySelect; 
        Qry.Open();      
        Qry.First();     
        var result = Qry.FieldByName(column).Value;
        Qry.Close();
        
        return result;        
} 
 