/****** Object:  StoredProcedure [dbo].[sp_list_CUAGTINF_SAM00003]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUAGTINF_SAM00003]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUAGTINF_SAM00003]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_list_CUAGTINF_SAM00003] 

@cai_cocde as nvarchar(6)

as

select 
cai_cocde,
cai_cusno,
cai_cusagt,
cai_comrat,
cai_cusdef,
cai_creusr,
cai_updusr,
cai_credat,
cai_upddat,
cast(cai_timstp as integer) as 'cai_timstp',
yai_stnam

from CUAGTINF
left join SYAGTINF on --cai_cocde = yai_cocde and 
		cai_cusagt = yai_agtcde


--where cai_cocde = @cai_cocde
order by cai_cusno




GO
GRANT EXECUTE ON [dbo].[sp_list_CUAGTINF_SAM00003] TO [ERPUSER] AS [dbo]
GO
