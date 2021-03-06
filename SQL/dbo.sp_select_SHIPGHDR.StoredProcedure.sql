/****** Object:  StoredProcedure [dbo].[sp_select_SHIPGHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHIPGHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHIPGHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO












CREATE   procedure [dbo].[sp_select_SHIPGHDR]
                                                                                                                                                                                                                                                               
@hih_cocde nvarchar(6) ,
@hih_shpno nvarchar(20) 
 AS

 Select 

hih_cocde,
hih_shpno,
convert(char(10),hih_issdat,101) as hih_issdat,
convert(char(10), hih_rvsdat,101) as hih_rvsdat,
hih_cus1no,
hih_cus2no,
hih_smpshp,
hih_shpsts,
hih_ves,
hih_voy,
hih_slnonb,
hih_arrdat,
hih_potloa,
hih_dst,
hih_crr,
hih_crrso,
hih_goddsc,
hih_bilent,
hih_biladr,
hih_bilstt,
hih_bilcty,
hih_bilzip,
hih_bilrmk,
hih_ttlctn,
isnull(hih_ttlcbm,0) as 'hih_ttlcbm',
hih_ttlnwg,
hih_ttlgwg,
hih_untamt,
hih_ttlamt,
hih_lcno,
hih_creusr,
hih_updusr,
hih_credat,
hih_upddat,
cast(hih_timstp as int) as hih_timstp,
cbi_salrep,
ysr_saltem,
hih_lcbank,
hih_cntyorgn,
hih_invsm

 from SHIPGHDR
left join CUBASINF on --cbi_cocde = hih_cocde and 
		cbi_cusno = hih_cus1no  
left join SYSALREP on --ysr_cocde = hih_cocde and 
		ysr_code1 = cbi_salrep
where                                                                                                                                                                                                                                                                 
hih_cocde = @hih_cocde and
hih_shpno = @hih_shpno













GO
GRANT EXECUTE ON [dbo].[sp_select_SHIPGHDR] TO [ERPUSER] AS [dbo]
GO
