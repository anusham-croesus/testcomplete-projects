--CR1483_0210_Tit_EnvironmentPreparation_Step4

declare @rep varchar(200)

--change the IA code for the account 300001-NA ,800021-FS,800021-na and 300007-NA

---offside account
select @rep = no_rep from b_compte where no_compte = '300001-NA'
insert into b_hist_IA values (@rep, '300001-NA', 'JAN 25 2010', 'BD66', 'nov 6 2007')
update b_compte set NO_REP ='BD66' where no_compte ='300001-NA'

---offside accounts for the same client 
select @rep = no_rep from b_compte where no_compte = '800021-FS'
insert into b_hist_IA values (@rep, '800021-FS', 'JAN 25 2010', 'BD66', 'nov 6 2007')
update b_compte set NO_REP ='BD66' where no_compte = '800021-FS'

select @rep = no_rep from b_compte where no_compte = '800021-na'
insert into b_hist_IA values (@rep, '800021-na', 'JAN 25 2010', 'BD66', 'nov 6 2007')
update b_compte set NO_REP ='BD66' where no_compte = '800021-na'

---not offside account
select @rep = no_rep from b_compte where no_compte = '300007-NA'
insert into b_hist_IA values (@rep, '300007-NA', 'JAN 25 2010', 'BD66', 'nov 6 2007')
update b_compte set NO_REP ='BD66' where no_compte = '300007-NA'
