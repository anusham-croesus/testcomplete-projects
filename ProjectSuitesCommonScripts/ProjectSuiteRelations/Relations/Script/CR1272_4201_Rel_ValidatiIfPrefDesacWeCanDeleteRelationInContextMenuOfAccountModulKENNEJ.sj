//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDeleteGP1859
//USEUNIT CR1272_4201_Rel_ValidatiIfPrefActiWeCanDeleteRelationInContextMenuOfAccountModulGP1859

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4201 
                            
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=yes  for sysadmin access level
                  connect to croesus with uni00 in the account module in the details section select a relationship and validate if we can delete a relationship
                   with contextual menu (right-click)  
                   Résultat attendu:
                   we can delete a relationship with contextual menu (right-click).
                     
                   1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=no  for sysadmin access level
                   connect to croesus with uni00 in the account module in the details section select a relationship and validate if  deletebutton 
                   in contextual menu (right-click) is disabled 
                   Résultat attendu:
                    delete button in contextual menu (right-click) is disabled 
                    
                    repeat step 1 and step2 for all acces level

          Auteur : Sana Ayaz
          Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
         */
   
function CR1272_4201_Rel_ValidatiIfPrefDesacWeCanDeleteRelationInContextMenuOfAccountModulKENNEJ()
{
 var UserName=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KENNEJ", "username");
 var PassWord=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KENNEJ", "psw");
 var NumberAccountKENNEJ=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "NumberAccountKENNEJ", language+client);
 var defaultValueIntial=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
 var defaultValueChange=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueChangeKENNEJ", language+client);
 var RelationNameKENNEJ=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "RelationNameKENNEJ", language+client);
 var valueActivPref = "False";

 CR1272_4201_Rel_ValidatiIfPrefActiWeCanDeleteRelationInContextMenuOfAccountModul(UserName,PassWord,NumberAccountKENNEJ,defaultValueIntial,defaultValueChange,RelationNameKENNEJ,valueActivPref);
}

   