/****** Object:  StoredProcedure [dbo].[sp_insert_ac_osinv_group]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_ac_osinv_group]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_ac_osinv_group]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_insert_ac_osinv_group] AS

insert ac_osinv_group 
select cusno, cpi_curcde,
(case 	when ccy = cpi_curcde then sum(balamt) 
	when ccy = 'USD' and cpi_curcde = 'HKD' then sum(balamt) / 0.12903225806
	when ccy = 'HKD' and cpi_curcde = 'USD' then sum(balamt) * 0.12903225806 end) as 'balamt'
from ac_osinv
left join CUPRCINF on cusno = cpi_cusno
group by cusno, ccy, cpi_curcde
order by cusno 



GO
GRANT EXECUTE ON [dbo].[sp_insert_ac_osinv_group] TO [ERPUSER] AS [dbo]
GO
