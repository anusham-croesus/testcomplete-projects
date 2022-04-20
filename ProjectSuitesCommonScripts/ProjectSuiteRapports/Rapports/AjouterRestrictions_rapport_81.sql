--- AJOUTER DES RESTRICTIONS

-- Effacer toutes les restrictions
delete from B_RESTR_ACCOUNT
delete from B_RESTR_LINK
delete from b_restriction


--- Compte 800228-FS

-- BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,50371,1,1.99,2.98,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID, (select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,20063256,1,5,6,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,360177659,1,9,11,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,410282528,1,1.99,3.99,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,430479919,1,1.99,9.99,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,440545408,1,3,5,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc


-- NON BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,1053,1,2.99,3.2,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,1148,1,3.5,4.55,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,10150,1,2,4,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,39784,1,2,3,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,43198,1,5,6,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,55077738,1,2.99,4.99,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,225115033,1,4,10,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,410282528,1,3,5,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,425378278,1,6.99,7.5,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,430415740,1,5,6,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800228-FS') from b_restriction order by RESTR_ID desc


--- Compte 800249-NA

-- BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,355182088,1,1,2,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,1609,1,2,5,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,15038660,1,3.99,4.99,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,410288092,1,0,0.99,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,47673,1,1,1.5,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,2937,1,0.5,0.99,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,70089111,1,0.99,2.99,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,390217942,1,0.1,0.5,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc


-- NON BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,15037991,1,2,4,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,1148,1,3,5,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,50425,1,1,5,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,400264005,1,5,9,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,49326,1,5,9,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,15037957,1,6,8,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,39243,1,1,9,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,48927,1,6,9,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_compte where no_compte = '800249-NA') from b_restriction order by RESTR_ID desc


--- Relation CR1485-1

-- BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,4348,1,3,5,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,410275470,1,1,3,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,340151924,1,5,9,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,320140880,1,10,17,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,435540768,1,2,7,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,430403404,1,7,9,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,10092,1,1.99,3.99,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,440540407,1,2,5,3,2)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc


-- NON BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,49132,1,5,7,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,390230676,1,2,4,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,1857,1,3,4,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,2594,1,2,5,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,395258839,1,6,9,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,440707305,1,5,7,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,15041802,1,3.5,4.5,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,4201,1,1.89,4.65,3,1)
insert into B_RESTR_LINK (RESTR_ID,LINK_ID) select top 1  RESTR_ID,(select LINK_ID from b_LINK where SHORTNAME = 'CR1485-1') from b_restriction order by RESTR_ID desc


--- Modele CR1485-M1

--return -- Supprimer cette ligne lorsque la creation des modeles aura ete faite

-- BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,390219095,1,10,11,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,235115913,1,18,22,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, TYPE_CURRENCY, portfolio_type, severity) values (1,430535934,3,3,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc


-- NON BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,1857,1,20,25,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,2395,2,5,7,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,4154,1,3.5,6.5,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type,TYPE_MAIN_VALUE, type_minimum, type_maximum, portfolio_type, severity) values (1,26915,4,3,3,99,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,10150,1,4,9,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type,TYPE_CURRENCY, portfolio_type, severity) values (1,2404,3,20,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M1') from b_restriction order by RESTR_ID desc


--- Modele CR1485-M2

-- BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,410287110,1,18,22,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,44649,1,2,3,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,15038812,1,22,24,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,15042472,1,35,40,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type,TYPE_CURRENCY, portfolio_type, severity) values (1,4785,3,3,1,2)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc


-- NON BLOQUANTES

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,42775,2,7,10,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,440678931,1,5,10,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,440654448,1,5,9,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,340166808,1,10,10.5,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,27553,1,10,15,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,15052809,1,32,50,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,120105903,1,2,5,1,1)

insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,1342,1,9,15,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,41291,1,6,9,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,410282528,1,10,10.5,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,370191216,1,2,3,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type,TYPE_CURRENCY, portfolio_type, severity) values (1,3866,3,3,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type,TYPE_CURRENCY, portfolio_type, severity) values (1,440574957,3,20,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type,TYPE_CURRENCY, portfolio_type, severity) values (1,375179282,3,20,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type,TYPE_CURRENCY, portfolio_type, severity) values (1,440672782,3,3,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

insert into b_restriction (domain, domain_main_value, type, type_minimum, type_maximum, portfolio_type, severity) values (1,375187139,1,0,0,1,1)
insert into B_RESTR_ACCOUNT (RESTR_ID,ACCOUNT_ID) select top 1  RESTR_ID,(select ACCOUNT_ID from b_COMPTE where NOM = 'CR1485-M2') from b_restriction order by RESTR_ID desc

go