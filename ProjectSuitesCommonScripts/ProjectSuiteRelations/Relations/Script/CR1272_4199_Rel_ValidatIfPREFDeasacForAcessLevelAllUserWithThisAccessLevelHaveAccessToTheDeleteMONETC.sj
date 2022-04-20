//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDeleteGP1859

/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4200            
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=yes  for sysadmin access level
                   Connect to croesus with uni00 and validate if we can delete a relationship with delete button, in the contextual menu (right-click)  and Edit menu:
                   Résultats attendus:delete button, in the contextual menu (right-click)  and Edit menu

                  2.Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=no  for sysadmin access level
                    connect to croesus with uni00 and validate if  delete button is disabled in main menu, in the contextual menu (right-click)  and Edit menu
                    Résultat:delete button is disabled in main menu, in the contextual menu (right-click)  and Edit menu



                  3.repeat steps 1 and 2 for all access level

                      -Firm Administrator:KEYNEJ  
                      -Firm Manager:FORTINN 
                      -Branch Administrator:KENNEJ
                      -Branch Manager:DARWIC  
                      -Investement Advisor
                      -Help Desk
                      -Ia assistant:VICTOM  
                      -Multi Branche Manager
                      -Firm User
                      -Pop Administrator: POPADMIN
                   
    Auteur : Sana Ayaz
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
   */
   
function CR1272_4199_Rel_ValidatIfPREFDeasacForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDeleteMONETC()
{
 var UserName=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "MONETC", "username");//Help Desk
 var PassWord=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "MONETC", "psw");
 var nameRelationShip12724199=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "nameRelationShip12724199", language+client);
 var defaultValueIntial=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
 var defaultValueChange=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueChangeMONETC", language+client);
 var valueActivPref = "False";
 CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDelete(UserName,PassWord,nameRelationShip12724199,defaultValueIntial,defaultValueChange,valueActivPref);
}

   