//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Tester la fenêtre de Création des filtres temporaires (rapides) a partir de l'icone (Y) de la barre principale
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1037
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters()
 {
 try{
   var filtre ="BD88";
   var filtreModif= GetData(filePath_Clients,"CR1352",390,language)
   var nbreClient= GetData(filePath_Clients,"CR1352",391,language)
   var nbreClientRacine= GetData(filePath_Clients,"CR1352",392,language)
   var nbreClientApresDesactivFiltre=GetData(filePath_Clients,"CR1352",393,language)
   var nbreClientRacineApresDesactivFiltre=GetData(filePath_Clients,"CR1352",394,language)
   
   
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
   Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
   Get_Toolbar_BtnQuickFilters_ContextMenu_IACode().Click();
        
   Create_TemporaryCPFilter(filtre)
   /*Cliquer sur le crayon :La fenêtre 'Modifier le filtre' s’est ouverte .

                            Seuls les champs : Opérateur et valeur sont modifiables*///Changement du cas du test par Karima
                            
     // Cliquer sur le crayon
     Log.Message("************* Étape : 5   ***********************")    
      var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13);
    //Les points de vérifications: seules les champs:Opérateur et valeur sont modifiables
        //Opérateur est modifiable                       
     aqObject.CheckProperty(Get_WinCreateFilter_CmbOperator(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinCreateFilter_CmbOperator(), "IsVisible", cmpEqual, true);
        //Valeur est modifiable 
                   
     aqObject.CheckProperty(Get_WinCreateFilter_TxtValue(), "Enabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinCreateFilter_TxtValue(), "Visible", cmpEqual, true);
     
     Log.Message("************* Étape :  6   ***********************")    
     /*Modifier les champs opérateur et valeur 

          Opérateur: débutant par 

          Valeur : 0

          Cliquer sur sauvegarder et Appliquer :
          Résultat:La fenêtre sauvegarder le filtre s'affiche 
     */    
     
       Get_WinCreateFilter_CmbOperator().DropDown();
       Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
       Get_WinCreateFilter_TxtValue().Clear();
       Get_WinCreateFilter_TxtValue().Keys("0");
       Get_WinCreateFilter_BtnSaveAndApply().Click();
       //La fenêtre de sauvegarder le filtre s'affiche
       aqObject.CheckProperty(  Get_WinSaveFilter(), "IsVisible", cmpEqual, true);
       /*Remplir  le champ 'Nom :TestCodeCp ' de la Fenêtre Sauvegarder le filtre 
       Cliquer sur OK:Résultat:Le filtre apparaît dans la grille portant  le nom ( TestCodeCp) qu’on a inscrit dans le champ  Nom de la fenêtre sauvegarder le filtre . */
       
       Log.Message("************* Étape :  7   ***********************")    
       Get_WinSaveFilter_TxtName().Keys(filtreModif);
       Get_WinSaveFilter_BtnOK().Click();
       WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SaveQuickFilterWindow_151d");  
       
       //Les points de vérifications  le filtre s'affiche
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filtreModif);
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif   
       
       Log.Message("************* Étape :  8   ***********************")    
       /*Cliquer sur Sommation :Nombre de clients : 12

                                Nombre de racine clients :17*/   
                                
       //Cliquer sur Sommation
       Get_Toolbar_BtnSum().Click()
       //Nombre de client :12 et Nombre de racine clients:17
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, nbreClient);
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, nbreClientRacine); 
       Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        /*Redémarrer croesus:
         Au redémarrage : le filtre temporaire sauvegardée : TestCodeCp est chargé*/
       Log.Message("************* Étape :  9   ***********************")                            
       Get_MainWindow().SetFocus();
       Close_Croesus_MenuBar();                           
      
           
       Login(vServerClients,userName,psw,language);
       Get_ModulesBar_BtnClients().Click();
       //vérification 
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filtreModif)   
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
       
       Log.Message("************* Étape :  10   ***********************")    
        /*Cliquer sur Sommation :Nombre de clients : 12
          Nombre de racine clients :17*/   
                                
       //Cliquer sur Sommation
       Get_Toolbar_BtnSum().Click()
       //Nombre de client :12 et Nombre de racine clients:17
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, nbreClient);
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, nbreClientRacine);   
       Get_WinRelationshipsClientsAccountsSum_BtnClose().Click(); 
      /*Cliquer sur le filtre rapide  puis faire une sommation:
      Résultat:
      Le filtre est inactif , tous les clients vont s'afficher 

      Nombre de clients : 55*/   
      
      Log.Message("************* Étape :  11   ***********************")    
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
        //Cliquer sur Sommation
       Get_Toolbar_BtnSum().Click()
       //Nombre de client :55 et Nombre de racine clients:68
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, nbreClientApresDesactivFiltre);
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, nbreClientRacineApresDesactivFiltre);   
       Get_WinRelationshipsClientsAccountsSum_BtnClose().Click(); 
      
              
       
   }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
   finally{
   
          Delete_FilterCriterion(filtreModif,vServerClients);
		  Terminate_CroesusProcess();
   }       
  } 
 
function Create_TemporaryCPFilter(filtre)
{       
   //Les points de vérification: Pour vérifier les champs dans la fenêtre de création d’un filtre 
   Check_WinCreateFilter_Properties(language);
   
   //Dans le champ Opérateur , sélectionner l'opérateur égal(e) a et mettre la valeur BD88
   Get_WinCreateFilter_CmbOperator().DropDown();
   Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
   Get_WinCreateFilter_TxtValue().Keys(filtre);
   Get_WinCreateFilter_BtnApply().Click();
    
   //Les points de vérification 
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 6, language));
   
   //Les points de vérification : Vérifier que dans le gris, il y a seulement des clients avec le Code de CP BD88
   var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;//Conter les résultats dans le grid 
   
   for (i=0; i<= count-1; i++){ 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.RepresentativeNumber, "OleValue", cmpEqual, filtre); //YR: Avant RepresentativeId dans CX
   }     
      
   if (client == "BNC" ){
     //Vérifier le nombre de clients dans la grille et le comparer avec le nombre de clients dans la fenêtre sommation    
     Compare_SumGrid_clientNumber()
   } 
   else{
     Compare_SumGrid_clientNumber_WithExternalClient()
   }
        
   // Fermer le filtre
  // Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click();
}

 //Les points de vérification: Pour vérifier les champs dans la fenêtre de création d’un filtre 
function Check_WinCreateFilter_Properties(language)
{
   aqObject.CheckProperty(Get_WinCreateFilter_LblField(), "Text", cmpEqual, GetData(filePath_Clients,"WinCreateFilter", 3, language));
   aqObject.CheckProperty(Get_WinCreateFilter_TxtField(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinCreateFilter_TxtField(), "Text", cmpEqual, GetData(filePath_Clients,"WinCreateFilter" ,4, language));
   
   aqObject.CheckProperty(Get_WinCreateFilter_LblOperator(), "Text", cmpEqual, GetData(filePath_Clients,"WinCreateFilter", 5, language));
   aqObject.CheckProperty(Get_WinCreateFilter_CmbOperator(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinCreateFilter_LblValue(), "Text", cmpEqual, GetData(filePath_Clients,"WinCreateFilter", 6, language));
   aqObject.CheckProperty(Get_WinCreateFilter_TxtValue(), "IsVisible", cmpEqual, true);
}
