/****** Object:  StoredProcedure [dbo].[sp_insert_SAINVHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SAINVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SAINVHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 28/07/2003

------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_SAINVHDR]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@sih_cocde 	nvarchar(6),
@sih_invno 	nvarchar(20),
@sih_issdat 	nvarchar(20),
@sih_rvsdat 	nvarchar(20),
@sih_invsts 	nvarchar(10),
@sih_cus1no 	nvarchar(6),
@sih_cus2no 	nvarchar(6),
@sih_cus1ad 	nvarchar(200),
@sih_cus2ad 	nvarchar(200),
@sih_cus1st 	nvarchar(20),
@sih_cus1cy 	nvarchar(6),
@sih_cus1zp 	nvarchar(20),
@sih_cus2st 	nvarchar(20),
@sih_cus2cy 	nvarchar(6),
@sih_cus2zp 	nvarchar(20),
@sih_cus1cp 	nvarchar(50),
@sih_cus2cp 	nvarchar(50),
@sih_salrep 	nvarchar(30),
@sih_saltem	nvarchar(20),
@sih_saldiv 	nvarchar(20),
@sih_salmgt	nvarchar(20),
@sih_srname	nvarchar(30),
@sih_cusagt 	nvarchar(6),
@sih_courier 	nvarchar(80),
@sih_doctyp 	nvarchar(10),
--@sih_docno 	nvarchar(30),
@sih_docno 	nvarchar(200),
@sih_smpprd 	nvarchar(20),
@sih_smpfgt 	nvarchar(20),
@sih_curcde 	nvarchar(6),
@sih_ttlamt 	numeric(13,4),
@sih_ttlctn 	int,
--@sih_shprmk 	nvarchar(300),
--@sih_rmk 	nvarchar(300),
@sih_shprmk 	nvarchar(600),
@sih_rmk 	nvarchar(600),
@sih_prctrm	nvarchar(6),
--@sih_hdrrmk	nvarchar(300),
@sih_hdrrmk	nvarchar(600),
@sih_discnt	int,
@sih_netamt	numeric(13,4),

-- Added by Mark Lau 20090814
@sih_curexrat numeric(16,11),
@sih_curexeffdat datetime,

@sih_updusr 	nvarchar(30)

                                     
------------------------------------ 
AS
 
insert into  SAINVHDR
(
sih_cocde,
sih_invno,
sih_issdat,
sih_rvsdat,
sih_invsts,
sih_cus1no,
sih_cus2no,
sih_cus1ad,
sih_cus2ad,
sih_cus1st,
sih_cus1cy,
sih_cus1zp,
sih_cus2st,
sih_cus2cy,
sih_cus2zp,
sih_cus1cp,
sih_cus2cp,
--sih_salrep,
sih_saltem,
sih_saldiv,
sih_salmgt,
sih_srname,
sih_cusagt,
sih_courier,
sih_doctyp,
sih_docno,
sih_smpprd,
sih_smpfgt,
sih_curcde,
sih_ttlamt,
sih_ttlctn,
sih_shprmk,
sih_rmk,
sih_prctrm,
sih_hdrrmk,
sih_discnt,
sih_netamt,

-- Added by Mark Lau 20090814
sih_curexrat ,
sih_curexeffdat ,

sih_creusr,
sih_updusr,
sih_credat,
sih_upddat
)

values(
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sih_cocde,
@sih_invno,
--Kenny Add on 05-10-2002
GETDATE(),--@sih_issdat,
GETDATE(),--@sih_rvsdat,
--********************************
@sih_invsts,
@sih_cus1no,
@sih_cus2no,
@sih_cus1ad,
@sih_cus2ad,
@sih_cus1st,
@sih_cus1cy,
@sih_cus1zp,
@sih_cus2st,
@sih_cus2cy,
@sih_cus2zp,
@sih_cus1cp,
@sih_cus2cp,
--@sih_salrep,
@sih_saltem,
@sih_saldiv,
@sih_salmgt,
@sih_srname,
@sih_cusagt,
@sih_courier,
@sih_doctyp,
@sih_docno,
@sih_smpprd,
@sih_smpfgt,
@sih_curcde,
@sih_ttlamt,
@sih_ttlctn,
@sih_shprmk,
@sih_rmk,
@sih_prctrm,
@sih_hdrrmk,
@sih_discnt,
@sih_netamt,


-- Added by Mark Lau 20090814
@sih_curexrat,
@sih_curexeffdat ,


@sih_updusr,
@sih_updusr,
getdate(),
getdate()
)     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

if @sih_invsts = 'OPE' 
begin

--	update CUPRCINF 
--	set 
--		cpi_cdtuse = cpi_cdtuse + @sih_netamt, 
--		cpi_rskuse = cpi_rskuse + @sih_netamt, 
--		cpi_updusr = @sih_updusr, cpi_upddat = getdate()
--	where 
--		cpi_cocde =@sih_cocde and 
--		cpi_cusno = @sih_cus1no


	UPDATE 
		CUBCR
	SET 
		cbc_cdtuse = cbc_cdtuse + @sih_netamt, 
		cbc_rskuse = cbc_rskuse + @sih_netamt, 
		cbc_updusr = 'SYSTEM',
		cbc_upddat = GETDATE(),
		cbc_updprg = 'SAINVHDR'
	WHERE
		cbc_cocde = @sih_cocde and 
		cbc_cusno = @sih_cus1no
end








GO
GRANT EXECUTE ON [dbo].[sp_insert_SAINVHDR] TO [ERPUSER] AS [dbo]
GO
