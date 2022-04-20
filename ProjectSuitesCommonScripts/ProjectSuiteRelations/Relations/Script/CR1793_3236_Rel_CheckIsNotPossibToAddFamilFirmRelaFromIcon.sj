//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3236                
                  1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie.
                  2.Aller dans le module relation et appuyer sur l'icône '+' et sélectionner ''Ajouter une relation'':La fenêtre ''Créer une relation'' s'ouvre.
                  3.Valider dans l'option ''Type'' de la fenêtre l’absence de l'option Famille-Firme:L'option Famille-Firme n'est pas présente.
                   
    Auteur : Sana Ayaz
*/
function CR1793_3236_Rel_CheckIsNotPossibToAddFamilFirmRelaFromIcon()
{
    try {
      
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
         
      

          
         //1.Ouvrir une session avec l'utilisateur REAGAR: La connexion est établie. 
         Login(vServerRelations, userNameREAGAR, passwordREAGAR, language);
         // 2.Aller dans le module relation  
         Get_ModulesBar_BtnRelationships().Click();
         //2.appuyer sur l'icône '+'
         
         Get_Toolbar_BtnAdd().Click();
         var numberOftries=0;  
           while ( numberOftries < 5 && !Get_SubMenus().Exists){
             Get_Toolbar_BtnAdd().Click();
             numberOftries++;
           } 

         Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
         
         var numberOftries=0;  
           while ( numberOftries < 5 && !Get_WinDetailedInfo().Exists){
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
             numberOftries++;
           } 
           
           //3.Valider dans l'option ''Type'' de la fenêtre l’absence de l'option Famille-Firme:L'option Famille-Firme n'est pas présente.
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Click();
          // Les points de vérifications
          aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemFamilyFirm(), "Exists", cmpEqual, false);
          if(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemFamilyFirm().Exists)
          
          {
          if (Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemFamilyFirm().VisibleOnScreen){  
            Log.Error("L'option Famille-Firme est présente")
          }
           else{
             Log.Checkpoint("L'option Famille-Firme n'est présente")
           }
         }
         

         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
      
    }
}
