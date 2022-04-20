//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Ord_Common_Functions


/**
    Module               :  Orders
    CR                   :  1483
    TestLink             :  Croes-3337 (cette référence de testLink est celle du module clients, ordres n'as pas de cas sur testLink
    Description          :  Vérifier que si on selectionne une succursale seulement les codes de CP de cette dernière sont affichés dans la grille client.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  10/12/2018
    
*/


function CR1483_Ord_Check_BranchSelection_IACodes() {
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3337","Lien du Cas de test sur Testlink équivalent à celui des autres modules, on prend clients");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_Check_BranchSelection_IACodes(vServerOrders,Get_ModulesBar_BtnOrders(),"Toronto", "AC", "_FRM");
}
