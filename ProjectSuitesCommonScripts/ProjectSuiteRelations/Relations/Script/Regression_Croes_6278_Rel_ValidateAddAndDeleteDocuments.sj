//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6278
       
    Description :Valider l'ajout et la suppression de Documents dans une Relation.
            
    Auteur : Asma Alaoui
    
    ref90-10-Fm-13--V9-croesus-co7x-1_5_1_572
    
    Date: 28/05/2019
*/


function Regression_Croes_6278_Rel_ValidateAddAndDeleteDocuments()
{
  try{
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6278", "Croes-6278");

      var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
  		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
      var relationship00000=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Relationship00000", language+client); 
      var docWord=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "NameFile_DOC", language+client);
      var commentaire=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "Comments", language+client);
      var commentaireModifie=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "NewComments", language+client); 
    
      //Accès au module Relations
      Login(vServerRelations, userNameCOPERN,passwordCOPERN,language);
      Get_ModulesBar_BtnRelationships().Click();   
      Get_MainWindow().Maximize();      
      
      //Sélectionnert la relation "00000" et cliquer sur le bouton Info ensuite sur l'onglet Document
      SearchRelationshipByNo(relationship00000);
      Get_RelationshipsBar_BtnInfo().Click();
      Get_WinDetailedInfo_TabDocuments().Click();
      Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
      
      //Ajouter le fichier Word :"test1BNC_2222.docx" et le commentaire "Regression document"
      Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
      Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
      Get_WinAddAFile_GrpFile_BtnBrowse().Click();
      var FolderPath=folderPath_Data +docWord;
      Get_DlgOpen_CmbFileName().Keys(FolderPath)
      Get_DlgOpen_BtnOpen().Click();
      Get_WinAddAFile_GrpComments_TxtComments().Keys(commentaire)
      Get_WinAddAFile_BtnOK().Click();
    
      //Valider que le document word et le commentaire ont été ajoutés
      aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments_ItemTopDocument().DataContext.Metadata.Filename, "OleValue", cmpEqual, docWord);
      aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaire)
      Get_WinDetailedInfo_BtnApply().Click();
      Delay(3000);
      Get_WinDetailedInfo_BtnOK().Click();
	  WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
    
      //Aller de nouveau sur Info et cliquer sur Document
      SearchRelationshipByNo(relationship00000);
      Get_RelationshipsBar_BtnInfo().Click();
      Get_WinDetailedInfo_TabDocuments().Click();
      Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
      
      //Modifier le commentaire dans la séction "Commentaires" et sauvgarder
      Get_PersonalDocuments_GrpComments_BtnEdit().Click();
      Get_PersonalDocuments_GrpComments_TxtComment().Clear();
      Get_PersonalDocuments_GrpComments_TxtComment().Keys(commentaireModifie);
      Get_PersonalDocuments_GrpComments_BtnSave().Click();
    
      //Valider l'affichage du nouveau commentaire
      aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaireModifie)
      aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment().Find("Text", commentaireModifie, 10),"Exists", cmpEqual, true);
      aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment().Find("Text", commentaireModifie, 10),"VisibleOnScreen", cmpEqual, true);
      Get_WinDetailedInfo_BtnOK().Click();
    
      //Supprimer le document ajouté 
      SearchRelationshipByNo(relationship00000);
      Get_RelationshipsBar_BtnInfo().Click();
      Get_WinDetailedInfo_TabDocuments().Click();
      Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
      Get_PersonalDocuments_LstDocuments_ItemTopDocument().Click();
      //Cliquer sur "Enlever"
      Get_PersonalDocuments_Toolbar_BtnRemove().Click();
      Get_DlgConfirmation_BtnDelete().Click();
    
      //Valider que le document n'est plus affiché
      aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments_ItemTopDocument(), "Exists", cmpEqual, false);
      Get_WinDetailedInfo_BtnApply().Click();
      Get_WinDetailedInfo_BtnOK().Click();
      
    }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    
    } 

}
