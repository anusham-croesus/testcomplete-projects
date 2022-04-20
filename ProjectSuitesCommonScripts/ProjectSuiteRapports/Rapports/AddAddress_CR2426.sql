--Ajouter une adresse au Conseiller BD88
--Rouler les requêtes suivantes dans la BD et faire un restart de services:

Update b_rep set EMAIL='copernic.galillei@email.com' where NO_REP='BD88'
Update b_rep set ADDRESS1_L1='10583 rue du Saint-Esprit' where NO_REP='BD88'
Update b_rep set ADDRESS2_L1='Belleville, C0D P0S' where NO_REP='BD88'
Update b_rep set ADDRESS1_L2='10583 rue du Saint-Esprit' where NO_REP='BD88'
Update b_rep set ADDRESS2_L2='Belleville, C0D P0S' where NO_REP='BD88'
Update b_rep set TELEPHONE1='1-888-555-3333' where NO_REP='BD88'
Update b_rep set TELEPHONE2='1-888-555-3232' where NO_REP='BD88'
Update b_rep set FAX='1-888-555-3333' where NO_REP='BD88'

go