/****** Object:  StoredProcedure [dbo].[sp_list_OSPODIR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_OSPODIR]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_OSPODIR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


--Frankie Cheung 20090819 - list info for outstanding PO directory 

CREATE procedure [dbo].[sp_list_OSPODIR]
	@cocde nvarchar(6),
	@fm datetime,
	@to datetime
AS
BEGIN



select case poh_pursts when 'OPE' then 'N'
			when 'REL' then 'N'
			when 'CAN' then 'C'
			when 'CLO' then 'C'
			else 'C' end as poh_sts, 
	ysr_saltem, 
	poh_purord
from POORDHDR 
left join CUBASINF on cbi_cusno = poh_prmcus
left join SYSALREP on ysr_code1 = cbi_salrep
left join VNBASINF on vbi_venno = poh_venno
where 
poh_cocde in ('UCP', 'UCPP', 'EW', 'TT') and
poh_credat > '2008-01-01' and
vbi_ventyp = 'E' and

--poh_pursts in ('OPE','REL')

poh_upddat >= @fm and poh_upddat <= @to

END


GO
GRANT EXECUTE ON [dbo].[sp_list_OSPODIR] TO [ERPUSER] AS [dbo]
GO
