delete from b_billhisto_accfee
delete from b_billhisto_linkfee
delete from b_billhisto_account
delete from b_billhisto_link
delete from b_billhisto
delete from b_billing_flowhisto
update b_linkaccount set billing_last_date = null
update b_link set billing_last_date = null
go