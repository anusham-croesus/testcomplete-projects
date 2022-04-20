-- Modifier le code de CP du client 800053 de 0AED à BD88 (pour le rapport 38)
update B_CLIENT set NO_REP = 'BD88', REP_ID = (select REP_ID from B_REP where NO_REP = 'BD88') where NO_CLIENT = '800053'
update B_COMPTE set NO_REP = 'BD88', REP_ID = (select REP_ID from B_REP where NO_REP = 'BD88') where NO_CLIENT = '800053'

-- Modifier le code de CP du client 800056 de AC42 à BD88 (pour le rapport 100)
update B_CLIENT set NO_REP = 'BD88', REP_ID = (select REP_ID from B_REP where NO_REP = 'BD88') where NO_CLIENT = '800056'
update B_COMPTE set NO_REP = 'BD88', REP_ID = (select REP_ID from B_REP where NO_REP = 'BD88') where NO_CLIENT = '800056'

-- Ajouter l'adresse e-mail au code REP BD66 (pour les rapports 109, 144, 147, 148)
update B_REP set EMAIL = 'albert.einstein@email.com' where NO_REP = 'BD66'

-- Mettre a jour Infos de REP BD88 (pour le rapport 144, 147, 148)
update B_REP set EMAIL = 'copernic.galillei@email.com' where NO_REP = 'BD88'
update B_REP set ADDRESS1_L1 = '10583 rue du Saint-Esprit' where NO_REP = 'BD88'
update B_REP set ADDRESS2_L1 = 'Belleville, C0D P0S' where NO_REP = 'BD88'
update B_REP set ADDRESS1_L2 = '10583 rue du Saint-Esprit' where NO_REP = 'BD88'
update B_REP set ADDRESS2_L2 = 'Belleville, C0D P0S' where NO_REP = 'BD88'
update B_REP set TELEPHONE1 = '1-888-555-3333' where NO_REP = 'BD88'
update B_REP set TELEPHONE2 = '1-888-555-3232' where NO_REP = 'BD88'
update B_REP set FAX = '1-888-555-3333' where NO_REP = 'BD88'

go
