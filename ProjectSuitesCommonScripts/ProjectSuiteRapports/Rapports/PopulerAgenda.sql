--- EVENEMENTS RAPPORTS 19, 35, 39, 40, 68

--- *** Effacer les tableaux de l'agenda

truncate table b_aguser
truncate table b_agenda
go

sp_chgattribute b_agenda, "identity_burn_max", 0, "0"


---- Inserer les taches (rapport 19)


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 12 2019 12:00AM', 30, 1, ' ', '800240', 1, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 1', '800240-OB')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 12 2019 12:00AM', 30, 1, ' ', '800265', 2, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 2', '800265-LY')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 13 2019 12:00AM', 30, 1, ' ', '800068', 3, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 3', '800068-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 13 2019 12:00AM', 30, 1, ' ', '800270', 1, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 4', '800270-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 14 2019 12:00AM', 30, 1, ' ', '800270', 3, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 5', '800270-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 14 2019 12:00AM', 30, 1, ' ', '800288', 2, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 6', '800288-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 15 2019 12:00AM', 30, 1, ' ', '800288', 1, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 7', '800288-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 15 2019 12:00AM', 30, 1, ' ', '800214', 2, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 8', '800214-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 16 2019 12:00AM', 30, 1, ' ', '800214', 3, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 9', '800214-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Aug 16 2019 12:00AM', 30, 1, ' ', '300001', 1, 5, -1, 'Jul 11 2017 12:35PM', 'Jul 11 2017 12:35PM', 'Task Calendar 10', '300001-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


---- Evenements Rapports 39, 40, 68 

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Jul 02 2019 8:00AM', 30, 4, ' ', '800228', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1', '800228-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 2,'Jul 08 2019 9:00AM', 30, 4, ' ', '800054', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2', '800054-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 3,'Jul 10 2019 10:00AM', 60, 4, ' ', '800290', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 3', '800290-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 09 2019 8:00AM', 60, 4, ' ', '800249', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 4', '800249-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 5,'Jul 16 2019 9:00AM', 60, 4, ' ', '800236', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 5', '800236-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 6,'Jul 12 2019 11:00AM', 60, 4, ' ', '800067', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 6', '800067-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 7,'Jul 15 2019 11:00AM', 60, 1, ' ', '800240', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 7', '800240-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 8,'Jul 17 2019 11:00AM', 30, 1, ' ', '800270', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 8', '800270-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 9,'Jul 22 2019 1:00PM', 30, 1, ' ', '800232', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 9', '800232-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 10,'Jul 23 2019 1:00PM', 30, 1, ' ', '800238', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 10','800238-DQ')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 11,'Jul 26 2019 1:00PM', 30, 1, ' ', '800282', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 11', '800282-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 12,'Jul 29 2019 1:00PM', 60, 1, ' ', '800065', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 12', '800065-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 13,'Jul 31 2019 1:00PM', 30, 1, ' ', '800070', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 13', '800070-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 14,'Jul 31 2019 3:00PM', 30, 1, ' ', '800261', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 14', '800261-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 15,'Jul 31 2019 5:00PM', 30, 1, ' ', '800079', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 15', '800079-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

---- Inserer les taches (Horaire Journalier) (rapport 39)

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Jul 05 2019 7:00AM', 30, 3, ' ', '800228', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.0', '800228-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 2,'Jul 05 2019 8:30AM', 30, 3, ' ', '800228', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.1', '800228-JW')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 3,'Jul 05 2019 9:00AM', 30, 3, ' ', '800228', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.2', '800228-RE')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 4,'Jul 05 2019 10:00AM', 30, 3, ' ', '800229', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.3', '800229-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 5,'Jul 05 2019 11:00AM', 30, 3, ' ', '800229', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.4', '800229-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 6,'Jul 05 2019 12:00PM', 30, 3, ' ', '800231', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.5', '800231-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 7,'Jul 05 2019 1:00PM', 30, 3, ' ', '800231', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.6', '800231-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 8,'Jul 05 2019 2:00PM', 30, 3, ' ', '800231', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.7', '800231-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 9,'Jul 05 2019 3:30PM', 30, 3, ' ', '800232', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.8', '800232-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 10,'Jul 05 2019 4:00PM', 30, 3, ' ', '800232', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.9', '800232-JW')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 11,'Jul 05 2019 5:30PM', 30, 3, ' ', '800232', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.10', '800232-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 12,'Jul 05 2019 6:00PM', 30, 3, ' ', '800233', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.11', '800233-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 13,'Jul 05 2019 7:00PM', 30, 3, ' ', '800233', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.12', '800233-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 14,'Jul 05 2019 8:00PM', 30, 3, ' ', '800233', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.13', '800233-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 15,'Jul 05 2019 9:00PM', 30, 3, ' ', '800241', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.14', '800241-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 16,'Jul 05 2019 10:00PM', 30, 3, ' ', '800241', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 1.15', '800241-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO



---- Inserer les taches (Horaire Hebdomadaire) (Rapport 40)

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 1,'Jul 11 2019 7:00AM', 30, 3, ' ', '800228', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.0', '800228-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 3,'Jul 08 2019 12:00PM', 30, 4, ' ', '800228', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.1', '800228-JW')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 09 2019 10:00AM', 30, 4, ' ', '800228', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.2', '800228-RE')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 08 2019 11:00AM', 30, 4, ' ', '800229', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.3', '800229-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 09 2019 12:00PM', 30, 3, ' ', '800229', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.4', '800229-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 09 2019 7:00AM', 30, 3, ' ', '800231', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.5', '800231-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 11 2019 9:00AM', 30, 3, ' ', '800231', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.6', '800231-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 10 2019 8:00AM', 30, 3, ' ', '800231', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.7', '800231-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte)
values (120, 4,'Jul 11 2019 10:00AM', 30, 3, ' ', '800232', 0, 5, 0, 'Jun 15 2017  8:00AM', 'Jun 15 2017  8:00AM', 'Test du rapport Taches DARWIC 2.8', '800232-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


---- Inserer les taches dans le passe (Rapport 35)

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 1,'Apr 4 2016 7:00AM', 30, 1, ' ', '800241', 0, 5, 0, 'Apr 4 2016 7:00AM', 'Apr 4 2016 7:00AM', 'Test du rapport retards DARWIC 1', '800241-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 2,'Apr 4 2016 8:00AM', 30, 1, ' ', '800241', 0, 5, 0, 'Apr 4 2016 8:00AM', 'Apr 4 2016 8:00AM', 'Test du rapport retards DARWIC 2', '800241-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 3,'Apr 4 2016 02:00PM', 30, 1, ' ', '800241', 0, 5, 0, 'Apr 4 2016 02:00PM', 'Apr 4 2016 02:00PM', 'Test du rapport retards DARWIC 3', '800241-JW')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 4,'Apr 5 2016 09:00AM', 30, 1, ' ', '800241', 0, 5, 0, 'Apr 5 2016 09:00AM', 'Apr 5 2016 09:00AM', 'Test du rapport retards DARWIC 4', '800241-RE')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 5,'Apr 5 2016 12:00PM', 30, 1, ' ', '800241', 0, 5, 0, 'Apr 5 2016 12:00PM', 'Apr 5 2016 12:00PM', 'Test du rapport retards DARWIC 5', '800241-SF')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 6,'Apr 6 2016 07:00AM', 30, 1, ' ', '800245', 0, 5, 0, 'Apr 6 2016 07:00AM', 'Apr 6 2016 07:00AM', 'Test du rapport retards DARWIC 6', '800245-GT')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 7,'Apr 6 2016 02:00PM', 30, 1, ' ', '800245', 0, 5, 0, 'Apr 6 2016 02:00PM', 'Apr 6 2016 02:00PM', 'Test du rapport retards DARWIC 7', '800245-JW')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 8,'Apr 12 2016 10:00AM', 30, 1, ' ', '800245', 0, 5, 0, 'Apr 12 2016 10:00AM', 'Apr 12 2016 10:00AM', 'Test du rapport retards DARWIC 8', '800245-RE')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 9,'Apr 12 2016 03:00PM', 30, 1, ' ', '800270', 0, 5, 0, 'Apr 12 2016 03:00PM', 'Apr 12 2016 03:00PM', 'Test du rapport retards DARWIC 9', '800270-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 10,'Apr 14 2016 06:00AM', 30, 1, ' ', '800270', 0, 5, 0, 'Apr 14 2016 06:00AM', 'Apr 14 2016 06:00AM', 'Test du rapport retards DARWIC 10', '800270-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 11,'Apr 14 2016 11:00AM', 30, 1, ' ', '800067', 0, 5, 0, 'Apr 14 2016 11:00AM', 'Apr 14 2016 11:00AM', 'Test du rapport retards DARWIC 11', '800067-NA')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 11,'Apr 14 2016 12:00PM', 30, 1, ' ', '800067', 0, 5, 0, 'Apr 14 2016 12:00PM', 'Apr 14 2016 12:00PM', 'Test du rapport retards DARWIC 12', '800067-OB')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO


insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 11,'Apr 14 2016 01:00PM', 30, 1, ' ', '800067', 0, 5, 0, 'Apr 14 2016 01:00PM', 'Apr 14 2016 01:00PM', 'Test du rapport retards DARWIC 13', '800067-RE')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 11,'Apr 14 2016 02:00PM', 30, 1, ' ', '800067', 0, 5, 0, 'Apr 14 2016 02:00PM', 'Apr 14 2016 02:00PM', 'Test du rapport retards DARWIC 14', '800067-SF')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO

insert into b_agenda (owner_num, type, date_ag, duree_ag, freq_ag, commenta, no_client, 
priorite, statut, rappel, date_creat, date_maj, comment, no_compte) 
values (120, 12,'Apr 29 2016 12:00PM', 30, 1, ' ', '800065', 0, 5, 0, 'Apr 29 2016 12:00PM', 'Apr 29 2016 12:00PM', 'Test du rapport retards DARWIC 15', '800065-FS')
GO

INSERT INTO B_AGUSER(NO_AGENDA,USER_NUM) 
select top 1 NO_AGENDA, OWNER_NUM from B_AGENDA order by NO_AGENDA desc
GO
