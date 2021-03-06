/****** Object:  StoredProcedure [dbo].[sp_update_SAINVHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SAINVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SAINVHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_update_SAINVHDR] 
--------------------------------------------------------------------------------------------------------------------------------------

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
@cpi_cdtlmt	numeric(13,4),
@cpi_cdtuse	numeric(13,4),

-- Added by Mark Lau 20090814
@sih_curexrat numeric(16,11),
@sih_curexeffdat datetime,

@approve		nvarchar(1),
@sih_updusr 	nvarchar(30)


--------------------------------------------------------------------------------------------------------------------------------------
AS

update SAINVHDR set

sih_cocde = @sih_cocde,
sih_invno = @sih_invno,
--Kenny remark on 05-10-2002
--sih_issdat =@sih_issdat,
sih_rvsdat =@sih_rvsdat,
sih_invsts = (case when @sih_invsts = 'HLD' and @approve = 1 then 'OPE' else @sih_invsts end),
sih_cus1no =@sih_cus1no,
sih_cus2no =@sih_cus2no,
sih_cus1ad=@sih_cus1ad,
sih_cus2ad=@sih_cus2ad,
sih_cus1st=@sih_cus1st,
sih_cus1cy=@sih_cus1cy,
sih_cus1zp=@sih_cus1zp,
sih_cus2st=@sih_cus2st,
sih_cus2cy=@sih_cus2cy,
sih_cus2zp=@sih_cus2zp,
sih_cus1cp=@sih_cus1cp,
sih_cus2cp=@sih_cus2cp,
--sih_salrep=@sih_salrep,
--sih_saltem = @sih_saltem,
sih_saldiv = @sih_saldiv ,
sih_salmgt = @sih_salmgt,
sih_srname = @sih_srname,	
sih_cusagt=@sih_cusagt,
sih_courier=@sih_courier,
sih_doctyp=@sih_doctyp,
sih_docno=@sih_docno,
sih_smpprd=@sih_smpprd,
sih_smpfgt=@sih_smpfgt,
sih_curcde=@sih_curcde,
sih_ttlamt=@sih_ttlamt,
sih_ttlctn=@sih_ttlctn,
sih_shprmk=@sih_shprmk,
sih_rmk=@sih_rmk,
sih_prctrm = @sih_prctrm,
sih_hdrrmk = @sih_hdrrmk,
sih_discnt = @sih_discnt,
sih_netamt = @sih_netamt,
sih_updusr=@sih_updusr,

-- Added by Mark Lau 20090814
sih_curexrat = @sih_curexrat,
sih_curexeffdat = @sih_curexeffdat ,

sih_upddat= getdate()

--------------------------------------------------------------------------------------------------------------------------------------
where 

sih_cocde		= @sih_cocde and 
sih_invno		= @sih_invno
--------------------------------------------------------------------------------------------------------------------------------------
/*
if @approve = 0 and @sih_invsts = 'OPE' and  @sih_netamt <> @sih_prvamt 
begin
	update 	CUPRCINF 
	set	cpi_cdtuse = cpi_cdtuse + @sih_netamt - @sih_prvamt,
		cpi_updusr = @sih_updusr,	cpi_upddat = getdate()
	where	cpi_cocde = @sih_cocde and cpi_cusno = @sih_cus1no
end

if @approve = 1 and @sih_invsts = 'HLD' 
begin
	update 	CUPRCINF 
	set	cpi_cdtuse = cpi_cdtuse + @sih_netamt - @sih_prvamt,
		cpi_updusr = @sih_updusr,	cpi_upddat = getdate()
	where	cpi_cocde = @sih_cocde and cpi_cusno = @sih_cus1no
end

*/








GO
GRANT EXECUTE ON [dbo].[sp_update_SAINVHDR] TO [ERPUSER] AS [dbo]
GO
