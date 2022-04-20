-- Suppression des ordres
-- ***********************************

SELECT GDODER_ID, WIRE_NUMBER INTO #tmpGdoIdToDelete FROM B_GDO_ORDER WHERE GDODER_ID in (793, 794, 811, 812, 829, 846, 847, 896, 897)

delete from b_gdo_order where gdoder_id in (select GDODER_ID from #tmpGdoIdToDelete)
delete from b_gdo_block_accounts where gdoder_id in (select GDODER_ID from #tmpGdoIdToDelete)
delete from b_gdo_messagelog where order_id in (select GDODER_ID from #tmpGdoIdToDelete)
delete from b_gdo_fill where wire_number in (select WIRE_NUMBER from #tmpGdoIdToDelete)
delete b_note from b_note t1, b_gdo_ordernotes t2 where t1.note_id = t2.note_id and t2.gdoder_id in (select GDODER_ID from #tmpGdoIdToDelete)
delete b_gdo_ordernotes where gdoder_id in (select GDODER_ID from #tmpGdoIdToDelete)

drop table #tmpGdoIdToDelete

go