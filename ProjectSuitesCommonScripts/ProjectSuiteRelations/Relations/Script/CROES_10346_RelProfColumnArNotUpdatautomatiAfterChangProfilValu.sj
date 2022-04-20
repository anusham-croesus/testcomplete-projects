//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                    Se connecter avec Keynej

                    Dans le module relations , ajouter une colonne profil 

                    Sélectionner une relation et remplir le champ Profil ( ajouté comme colonne précédemment ) 

                    Appliquer et quitter 

                    Résultat attendu : La colonne Profil est mise à jour 

                    Résultat obtenu : Le contenu de la colonne  profil est vide , il faut faire un refresh  

 
    Auteur : Sana Ayaz
    Anomalie:CROES-10346
    Version de scriptage:ref90-07-Co-9--V9-Be_1-co6x
*/
function CROES_10346_RelProfColumnArNotUpdatautomatiAfterChangProfilValu()
{
    try {
        
        
      
     
        
         
       userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
 
        
        var relationshipName_CROES10346=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipName_CROES10346", language+client);
        var GroupBoxCROES10346=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "GroupBoxCROES10346", language+client);
        var EnterValueProfil1CROES10346=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "EnterValueProfil1CROES10346", language+client);
        var TabProfilText=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "TabProfilText", language+client);
        var ProfilAjouteCROES10346=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "ProfilAjouteCROES10346", language+client);
        var NumberMenitemProfil=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumberMenitemProfil", language+client);
        var NumberCelulCROES10346=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumberCelulCROES10346", language+client);
        var NumberLinCROES10346=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumberLinCROES10346", language+client);
        //Se connecter avec KEYNEJ

        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        Get_RelationshipsGrid_ChName().ClickR(); 
        Get_RelationshipsGrid_ChName().ClickR(); 
        Delay(1000)
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Delay(1000)
        Get_GridHeader_ContextualMenu_AddColumn_Profiles().Click();
        Delay(1000)
        
         Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", ProfilAjouteCROES10346], 10).DblClick();
      
        SearchRelationshipByName(relationshipName_CROES10346);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipName_CROES10346,10).DblClick();
        Get_WinDetailedInfo_TabProfile().Click();  
        WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);  
        Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", GroupBoxCROES10346], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).Keys(EnterValueProfil1CROES10346)

        //Get_WinDetailedInfo_BtnApply().Click(); 
        Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000);
        Get_WinDetailedInfo_BtnOK().Click();
       
        Log.Message("Le numéro de la colonne de la relation #1 TEST est "+NumberLinCROES10346);
        Log.Message("Le numéro de la cellule pour le profil qualité est "+NumberCelulCROES10346);
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlText"],["UniButton", "OK"]);
        var arraytabGridRelation =Get_Grid_ContentArray(Get_RelationshipsClientsAccountsGrid(), Get_RelationshipsGrid_ChRelationshipNo())
        var colonneQualite= Get_ColumnFromGridArray(ChQualite_RelationshipsGrid(ProfilAjouteCROES10346), arraytabGridRelation)
        Log.Message(colonneQualite[0]);                  
      
         if(colonneQualite[0] == EnterValueProfil1CROES10346)
      {
        Log.Checkpoint("Le profil a été mis a jour")
      }
      else
      Log.Error(" bug CROES-10346")

        Terminate_CroesusProcess();

     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
         Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
         Get_ModulesBar_BtnRelationships().Click();
         SearchRelationshipByName(relationshipName_CROES10346);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipName_CROES10346,10).DblClick();
        Get_WinDetailedInfo_TabProfile().Click();  
        Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", GroupBoxCROES10346], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).set_Text("")
        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(true);  
        Get_WinDetailedInfo_BtnApply().Click();  
         Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000); 
        Get_WinDetailedInfo_BtnOK().Click();
        /*Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ProfilAjouteCROES10346], 10).ClickR();
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ProfilAjouteCROES10346], 10).ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisField().Click(); */
        Terminate_CroesusProcess(); 
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
         SearchRelationshipByName(relationshipName_CROES10346);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value",relationshipName_CROES10346,10).DblClick();
        Get_WinDetailedInfo_TabProfile().Click();  
        Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", GroupBoxCROES10346], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).set_Text("")
        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(true); 
        Get_WinDetailedInfo_BtnApply().Click();  
         Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000); 
        Get_WinDetailedInfo_BtnOK().Click();
       /* Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ProfilAjouteCROES10346], 10).ClickR();
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ProfilAjouteCROES10346], 10).ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisField().Click();*/
        Terminate_CroesusProcess(); 
    }
}

function ChQualite_RelationshipsGrid(ProfilAjouteCROES10346)
{
// if (language=="french"){
 return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ProfilAjouteCROES10346], 10)
// }
// else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}