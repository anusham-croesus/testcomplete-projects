//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3113
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3113_Check_Labels_SubstitutionTitle()
 {             
    try{  

        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");       
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client);
        var AGF420=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionAGF420", language+client);
        var rdoComplementSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RdoComplementSecurity", language+client);
        var rdoReplacementSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RdoReplacementSecurity", language+client);
        var rdoFallbackSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RdoFallbackSecurity", language+client);
        var grpSubstitutionType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GrpSubstitutionType", language+client);
        var SecurityNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescription_2975", language+client);
        var txtFallbackMessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TxtFallbackMessage", language+client);
        var txtReplacementSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TxtReplacementSecurity", language+client);
        var txtComplementSecurity =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TxtComplementSecurity", language+client);
        var RonaInc=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RonaInc", language+client);
        var titleSubstitutionType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TitleSubstitutionType", language+client);
        var substituteTypeReplacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);
        var symbolNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNA", language+client);
        var DescriptionNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionNA", language+client);
        var PositionMTG411=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionMTG411", language+client);
        var SecurityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var DescriptionNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionNBC100", language+client);
        var DescriptionPJCA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionPJCA", language+client);
        var complement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Complement", language+client);
        var SymbolPJCA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SymbolPJCA", language+client);
        var alternative=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Alternative", language+client);
        
        Login(vServerModeles, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(model);
                       
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",model,10).Click();
        //chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");    
        Get_Portfolio_PositionsGrid().Find("Value",AGF420,10).Click();
        Get_PortfolioBar_BtnInfo().Click();
        if(Get_DlgConfirmation().Exists){
          var width =Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(3/5)),73); 
        }
        
        /*Dans la section Titres de substitution valider que les les colonnes Rang , Type de substitution , symbole + description sont disponible
        Titre de rechange d'un remplacement*/
        
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChRank(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChSubstitutionType(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChSymbol(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChDescription(), "VisibleOnScreen", cmpEqual,true);
       if(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("ClrClassName","VirtualizingDataRecordCellPanel",10).ChildCount==4){              
           Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChRank().ClickR();
           Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
           aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChFallbackSecurityReplacement(), "VisibleOnScreen", cmpEqual,true);        
       }
       else{
         aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChFallbackSecurityReplacement(), "VisibleOnScreen", cmpEqual,true); 
       }
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("ClrClassName","VirtualizingDataRecordCellPanel",10), "ChildCount", cmpEqual,5);
        
       /*Après avoir cliqué  sur le btn Modifier. Dans la section Titres de substitution valider que les les colonnes Rang , Type de substitution , symbole + description sont disponible, Titre de rechange d'un remplacement*/
       Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
       Get_WinSubstitutionSecurities().parent.Maximize();     
       aqObject.CheckProperty(Get_WinSubstitutionSecurities_ChRank(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinSubstitutionSecurities_ChSubstitutionType(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinSubstitutionSecurities_ChSymbol(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinSubstitutionSecurities_ChDescription(), "VisibleOnScreen", cmpEqual,true);
       if(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("ClrClassName","VirtualizingDataRecordCellPanel",10).ChildCount==4){              
           Get_WinSubstitutionSecurities_ChRank().ClickR();
           Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
           aqObject.CheckProperty(Get_WinSubstitutionSecurities_ChFallbackSecurityReplacement(), "VisibleOnScreen", cmpEqual,true);        
       }
       else{
         aqObject.CheckProperty(Get_WinSubstitutionSecurities_ChFallbackSecurityReplacement(), "VisibleOnScreen", cmpEqual,true); 
       }
       aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("ClrClassName","VirtualizingDataRecordCellPanel",10), "ChildCount", cmpEqual,5);

       /*Cliquez sur Ajouter la nouvelle fenetre Titres de Substitution qui contients les sctions: 
       Desc + Type se substitution ==> 3 radio button sont : Titre de complément, Titre de remplacement + Titre de rechange*/
       Get_WinSubstitutionSecurities_BtnAdd().Click();
       Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionSecurity(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoComplementSecurity(), "VisibleOnScreen", cmpEqual,true);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity(), "VisibleOnScreen", cmpEqual,true);
       
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType(), "Header", cmpEqual,grpSubstitutionType);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(), "Content", cmpEqual,rdoFallbackSecurity);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoComplementSecurity(), "Content", cmpEqual,rdoComplementSecurity);
       aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity(), "Content", cmpEqual,rdoReplacementSecurity);

        /*Séléctionner symbole == > Saisir NA ==> Rechercher ==>
        La fenêtre Titre de substitution est est affichée
        valider les sections
        dESC= bANQUE NATIONAL DU CDA 
        Type de substitution
        Titre de complément : Le titre de complément BANQUE NATIONAL DU CDA(NA) sera considéré comme un équivalent au titre principal AGF OBL CDN R/E /S/N (agf420), mais aucun nouvel achat ne sera effectué avec ce titre
        Titre de remplacement : Pour les portefeuilles déjà détenteurs du titre BANQUE NATIONAL DU CDA(NA), celui-ci sera utilisé pour la création de l’ordre d’achat en remplacement du titre AGF OBL CDN R/E /S/N (agf420.
        Pour les portefeuilles non détenteurs du titre BANQUE NATIONAL DU CDA(NA), le titre AGF OBL CDN R/E /S/N (agf420) sera utilisé pour la création de l’ordre d’achat.
        -Titre de rechange : Le titre de rechange BANQUE NATIONAL DU CDA(NA), sera utilisé dans un ordre d’achat seulement si le titre principal  AGF OBL CDN R/E /S/N (agf420 ) est bloqué par une restriction ou ne peut être acheté en entier en raison de limites d’achat.
        */
        
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(SecurityNA);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
        
        aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_TxtFallbackMessage(), "Text", cmpEqual,txtFallbackMessage);
        //Dans ce cas le fichier Excel n’a pas marché 
        if(language=="french"){
          aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_TxtReplacementSecurity(), "Text", cmpContains,"Pour les portefeuilles déjà détenteurs du titre BANQUE NATIONALE DU CDA (NA), celui-ci sera utilisé pour la création de l'ordre d'achat en remplacement du titre AGF OBL CDN R/E /S/N (AGF420).\r\n\r\nPour les portefeuilles qui ne sont pas détenteurs du titre BANQUE NATIONALE DU CDA (NA), le titre AGF OBL CDN R/E /S/N (AGF420) sera utilisé pour la création de l'ordre d'achat.");
        }
        else{
          aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_TxtReplacementSecurity(), "Text", cmpContains,"For portfolios already holding the security NATIONAL BANK OF CDA (NA), it will be used to create the buy order in place of the security AGF CDN H/Y BD  /D/N (AGF420).\r\n\r\nFor portfolios not holding the security NATIONAL BANK OF CDA (NA), the security AGF CDN H/Y BD  /D/N (AGF420) will be used to create the buy order.");
        }
        
        aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_TxtComplementSecurity(), "Text", cmpEqual,txtComplementSecurity);
        
        /*Séléctionner Titre de remplacement et valider que la section Titre de rechange d'un remplacement est dégrisé ==>
        Saisir !RONA INC dans le champ Desc ==> recherche
        Et valider que le titre de la section devient : Titre de rechange d'un remplacement BANQUE NATIONA DU cda (NA)
        Cliquez sur OK*/
        Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity().set_IsChecked(true);
        Get_WinReplacement_GrpSubstitutionType_TxtSubstitutionType().set_Text(RonaInc);
        Get_WinReplacement_GrpSubstitutionType_TxtSubstitutionType().Keys("[Tab]");
        aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_TxtTitleSubstitutionType(), "Text", cmpEqual,titleSubstitutionType);
        Get_WinReplacement_BtnOK().Click();
        
        /*Valider les colonnes affichent :
        -Type de substitution : Icone + remplacement--> Validation d’icone ne peux pas être automatiséee   
        2-Symbole =NA
        3-dESCRIPTION = BANQUE NATIONAL DU CDA
        4-Titre de rechange de remplacemnet = Icone + !RONA INC --> Validation d’icone ne peux pas être automatisée 
        5-OK*/
        Get_WinSubstitutionSecurities().parent.Maximize();
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbolNA,10).DataContext.DataItem,"SubstituteType",cmpEqual, substituteTypeReplacement)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbolNA,10).DataContext.DataItem,"SecurityDescription",cmpEqual, DescriptionNA)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbolNA,10).DataContext.DataItem,"SecurityAltDescription",cmpEqual,RonaInc)
        Get_WinSubstitutionSecurities_BtnOK().Click();
                        
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",symbolNA,10).DataContext.DataItem,"SubstituteType",cmpEqual, substituteTypeReplacement)
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",symbolNA,10).DataContext.DataItem,"SecurityDescription",cmpEqual, DescriptionNA)
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",symbolNA,10).DataContext.DataItem,"SecurityAltDescription",cmpEqual,RonaInc)
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",symbolNA,10).DataContext.DataItem,"OrderPriority",cmpEqual,1)
        Get_WinPositionInfo_BtnOK().Click();
        
        /*Dans portefeuille séléctionner position MTG411 ==> Info ==>
        Modifier ==> Ajouter ==> Symbole =NBC100
        Choisir titre de complement ==> Ok
        Sans fermer la fentre Titre de substitution ==> Cliquez sur Ajouter 
        Dans desc  ==> JEAN COUTU GRP-A SV
        Cocher titre de rechange
        Ok*/
        
        Get_Portfolio_PositionsGrid().Find("Value",PositionMTG411,10).Click();
        Get_PortfolioBar_BtnInfo().Click();
        if(Get_DlgConfirmation().Exists){
          var width =Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(3/5)),73); 
        }
        Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
        Get_WinSubstitutionSecurities_BtnAdd().Click();
        Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(DescriptionNBC100);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
        Get_WinReplacement_GrpSubstitutionType_RdoComplementSecurity().set_IsChecked(true);
        Get_WinReplacement_BtnOK().Click();
        
        Get_WinSubstitutionSecurities_BtnAdd().Click();
        Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(DescriptionPJCA);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
        Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity().set_IsChecked(true);
        Get_WinReplacement_BtnOK().Click();
         
        /*Valider les colonnes 
        Rang 1 :
        -Type de substitution : Icone + Complement --> Validation d’icone ne peux pas être automatisée 
        2-Symbole =NBC100
        3-dESCRIPTION = ALT COM SURET  /SF/N
        4-Titre de rechange de remplacemnet = Vide
        Rang 2 :
        -Type de substitution : Icone + Rechange --> Validation d’icone ne peux pas être automatisée 
        2-Symbole =PJC.A
        3-dESCRIPTION = JEAN COUTU GRP-A SV
        4-Titre de rechange de remplacemnet = Vide
        oK
        */
        Get_WinSubstitutionSecurities().parent.Maximize();        
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SecurityNBC100,10).DataContext.DataItem,"SubstituteType",cmpEqual, complement)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SecurityNBC100,10).DataContext.DataItem,"SecurityDescription",cmpEqual, DescriptionNBC100)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SecurityNBC100,10).DataContext.DataItem,"OrderPriority",cmpEqual,1)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SecurityNBC100,10).DataContext.DataItem,"SecurityAltDescription",cmpEqual,null)
                       
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SymbolPJCA,10).DataContext.DataItem,"SubstituteType",cmpEqual, alternative)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SymbolPJCA,10).DataContext.DataItem,"SecurityDescription",cmpEqual, DescriptionPJCA)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SymbolPJCA,10).DataContext.DataItem,"OrderPriority",cmpEqual,2)
        aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SymbolPJCA,10).DataContext.DataItem,"SecurityAltDescription",cmpEqual,null)
        Get_WinSubstitutionSecurities_BtnOK().Click();
        Get_WinPositionInfo_BtnOK().Click();
        
        /*Dans portefeuille valider que la colonne Titres de substitution affiche 2 Icones: Titre de remplacement + rechange de remplacement SUR mtg411.
        2 Icones: Titre de Rechange +Titres de complement Sur AGF420
        Sauvegarder le modele--> Validation d’icone ne peux pas être automatisée */ 
                
        aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",PositionMTG411,10).DataContext.DataItem,"CountAlternativeSubstitutes",cmpEqual, 1)
        aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",PositionMTG411,10).DataContext.DataItem,"CountComplementSubstitutes",cmpEqual, 1)
        
        aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",AGF420,10).DataContext.DataItem,"CountReplacementAlternativeSubstitutes",cmpEqual, 1)
        aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",AGF420,10).DataContext.DataItem,"CountReplacementSubstitutes",cmpEqual, 1)
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        /*Dans Modele ==> Séléctionner CH REVENU FIXE 
        Onglet position et valider laes icones ajoutés a la colonne Titres de substitution
        2 Icones: Titre de Rechange +Titres de complement Sur AGF420 --> Validation d’icone ne peux pas être automatisée*/
        
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_Models_Details_TabPositions().Click();

        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",AGF420,10).DataContext.DataItem,"CountReplacementAlternativeSubstitutes",cmpEqual, 1)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",AGF420,10).DataContext.DataItem,"CountReplacementSubstitutes",cmpEqual, 1)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",AGF420,10).DataContext.DataItem,"HasReplacementAlternativeSecurity",cmpEqual, true)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",AGF420,10).DataContext.DataItem,"HasReplacementSecurity",cmpEqual, true)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",AGF420,10).DataContext.DataItem,"HasSubstitutes",cmpEqual, true)

        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",PositionMTG411,10).DataContext.DataItem,"CountAlternativeSubstitutes",cmpEqual, 1)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",PositionMTG411,10).DataContext.DataItem,"CountComplementSubstitutes",cmpEqual, 1)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",PositionMTG411,10).DataContext.DataItem,"HasAlternativeSecurity",cmpEqual, true)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",PositionMTG411,10).DataContext.DataItem,"HasComplementSecurity",cmpEqual, true)
        aqObject.CheckProperty(Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Find("Value",PositionMTG411,10).DataContext.DataItem,"HasSubstitutes",cmpEqual, true)
        
        //RestoreData(model,PositionMTG411,SecurityNBC100,SymbolPJCA,AGF420,symbolNA)
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        

    }
    finally {  
        Login(vServerModeles, user , psw ,language);
        RestoreData(model,PositionMTG411,SecurityNBC100,SymbolPJCA,AGF420,symbolNA);
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true)
    }
 }
 
 function RestoreData(model,PositionMTG411,SecurityNBC100,SymbolPJCA,AGF420,symbolNA){
 
    Get_ModulesBar_BtnModels().Click();
    SearchModelByName(model);
         
    //Sélectionner le modèle 
    Get_ModelsGrid().Find("Value",model,10).Click();
    //chainer vers le module Portefeuille,
    Drag( Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");    
    Get_Portfolio_PositionsGrid().Find("Value",PositionMTG411,10).Click();
    Get_PortfolioBar_BtnInfo().Click();
    if(Get_DlgConfirmation().Exists){
      var width =Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(3/5)),73); 
    }
    
    Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
    Get_WinSubstitutionSecurities().parent.Maximize();
    if(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SecurityNBC100,10).Exists){
      Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SecurityNBC100,10).Click();
      Get_WinSubstitutionSecurities_BtnRemove().Click();
      /*var width = Get_DlgCroesus().Get_Width();
      Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
    }
    if(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SymbolPJCA,10).Exists){
      Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",SymbolPJCA,10).Click();
      Get_WinSubstitutionSecurities_BtnRemove().Click();
      /*var width = Get_DlgCroesus().Get_Width();
      Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
    }
   Get_WinSubstitutionSecurities_BtnOK().Click();
   Get_WinPositionInfo_BtnOK().Click();
    
   WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");    
   Get_Portfolio_PositionsGrid().Find("Value",AGF420,10).Click();
   Get_PortfolioBar_BtnInfo().Click();
   if(Get_DlgConfirmation().Exists){
      var width =Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(3/5)),73); 
   } 
      
   Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
   Get_WinSubstitutionSecurities().parent.Maximize();
    if(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbolNA,10).Exists){
      Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",symbolNA,10).Click();
      Get_WinSubstitutionSecurities_BtnRemove().Click();
      /*var width = Get_DlgCroesus().Get_Width();
      Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
      var width = Get_DlgConfirmation().Get_Width();
      Get_DlgConfirmation().Click((width*(1/3)),73);
    }
   Get_WinSubstitutionSecurities_BtnOK().Click();
   Get_WinPositionInfo_BtnOK().Click();
   
   Get_PortfolioBar_BtnSave().Click();
   Get_WinWhatIfSave_BtnOK().Click();
       
 }
 
