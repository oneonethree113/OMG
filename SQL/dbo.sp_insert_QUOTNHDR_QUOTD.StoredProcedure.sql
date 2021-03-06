/****** Object:  StoredProcedure [dbo].[sp_insert_QUOTNHDR_QUOTD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUOTNHDR_QUOTD]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUOTNHDR_QUOTD]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO










/************************************************************************
Author:		Samuel Chan   
Date:		01 - 10 -  2002
Description:	Insert data into Quotation Header

************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_QUOTNHDR_QUOTD] 
--------------------------------------------------------------------------------------------------------------------------------------

@quh_cocde	nvarchar(6),
@qutno	nvarchar(20),
@quh_cus1no	nvarchar(6),
@quh_cus2no	nvarchar(6),
@quh_currel	nvarchar(1),
@quh_curcde	nvarchar(6),
@quh_creusr	nvarchar(30)

AS 
if @quh_cus2no  is null  
begin 
set @quh_cus2no = '' 
end 

if @quh_currel  is null 
begin 
set @quh_currel = '' 
end 

if @quh_curcde  is null 
begin 
set @quh_curcde = '' 
end 

--declare @qsd_qutseq	int
--Set  @qsd_qutseq = (Select isnull(max(qai_qutseq),0)  + 1 from QUASSINF where qai_cocde = @qsd_cocde and qai_qutno = @qutno and qai_itmno = @qsd_itmno)

declare @quh_issdat	datetime   
set @quh_issdat = getdate()

declare @quh_rvsdat	datetime  
set @quh_rvsdat = getdate()

declare @quh_qutsts	nvarchar(1)
set @quh_qutsts = 'A'

declare @quh_cus1ad	nvarchar(200)
set @quh_cus1ad	= isnull((select top 1 cci_cntadr from CUCNTINF where --cci_cocde = @quh_cocde and 
							cci_cusno = @quh_cus1no and cci_cnttyp = 'm'),'N/A')

declare @quh_cus1st	nvarchar(20)
set @quh_cus1st	= isnull((select top 1 cci_cntstt from CUCNTINF where --cci_cocde = @quh_cocde and 
							cci_cusno = @quh_cus1no and cci_cnttyp = 'm'),'')

declare @quh_cus1cy	nvarchar(20)
set @quh_cus1cy = isnull((select top 1cci_cntcty from CUCNTINF where --cci_cocde = @quh_cocde and 
							cci_cusno = @quh_cus1no and cci_cnttyp = 'm'),'')

declare @quh_cus1zp	nvarchar(20)
set @quh_cus1zp = isnull((select top 1 cci_cntpst from CUCNTINF where --cci_cocde = @quh_cocde and 
							cci_cusno = @quh_cus1no and cci_cnttyp = 'm'),'')

declare @quh_cus1cp	nvarchar(50)
-- Edited by Mark Lau 20080724
set @quh_cus1cp	= isnull((select top 1 cci_cntctp from CUCNTINF where --cci_cocde = @quh_cocde and 
							cci_cusno = @quh_cus1no and cci_cnttyp = 'BUYR' and cci_delete <> 'Y'),'')

declare @quh_cus2ad	nvarchar(200)
declare @quh_cus2st	nvarchar(20)
declare @quh_cus2cy	nvarchar(20)
declare @quh_cus2zp	nvarchar(20)
declare @quh_cus2cp	nvarchar(50)

if @quh_cus2no = '' or @quh_cus2no is null
begin
	set @quh_cus2ad = ''
	set @quh_cus2st = ''
	set @quh_cus2cy = ''
	set @quh_cus2zp = ''
	set @quh_cus2cp = ''
end
else
begin
	set @quh_cus2ad = isnull((select top 1 cci_cntadr from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @quh_cus2no and cci_cnttyp = 'm'),'')
	set @quh_cus2st = isnull((select top 1 cci_cntstt from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @quh_cus2no and cci_cnttyp = 'm'),'')
	set @quh_cus2cy = isnull((select top 1cci_cntcty from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @quh_cus2no and cci_cnttyp = 'm'),'')
	set @quh_cus2zp = isnull((select top 1 cci_cntpst from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @quh_cus2no and cci_cnttyp = 'm'),'')
-- Edited by Mark Lau 20080724
	set @quh_cus2cp = isnull((select top 1 cci_cntctp from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @quh_cus2no and cci_cnttyp = 'SALE' and cci_delete <> 'Y'),'')
end 


declare @quh_salrep	nvarchar(30)
set @quh_salrep = isnull((select top 1 cbi_salrep from CUBASINF where --cbi_cocde = @quh_cocde and 
							cbi_cusno = @quh_cus1no),'')

declare @quh_valdat	datetime
set @quh_valdat = (select getdate() +  (select yco_expday from SYCOMINF  where yco_cocde = @quh_cocde))

declare @quh_smpprd	nvarchar(20)
set @quh_smpprd	= isnull((select top 1 cpi_smpprd from CUPRCINF where -- cpi_cocde = @quh_cocde and 
							cpi_cusno = @quh_cus1no),'')

declare @quh_smpfgt	nvarchar(20)
set @quh_smpfgt	= isnull((select top 1 cpi_smpfgt from CUPRCINF where --cpi_cocde = @quh_cocde and 
							cpi_cusno = @quh_cus1no),'')

declare @quh_prctrm	nvarchar(6)
set @quh_prctrm	= isnull((select top 1 cpi_prctrm from CUPRCINF where --cpi_cocde = @quh_cocde and 
							cpi_cusno = @quh_cus1no),'')

declare @quh_paytrm	nvarchar(6)
set @quh_paytrm	= isnull((select top 1 cpi_paytrm from CUPRCINF where --cpi_cocde = @quh_cocde and 
							cpi_cusno = @quh_cus1no),'')


declare @quh_cusagt	nvarchar(6)
set @quh_cusagt = ''

declare @quh_relcnt	int
set @quh_relcnt = 0

declare @quh_rmk	nvarchar(300)
set @quh_rmk = ''

INSERT INTO  QUOTNHDR
(
quh_cocde,	quh_qutno,	quh_issdat,	quh_rvsdat,
quh_qutsts,	quh_cus1no,	quh_cus2no,	quh_relatn,
quh_cus1ad,	quh_cus2ad,	quh_cus1st,	quh_cus1cy,
quh_cus1zp,	quh_cus2st,	quh_cus2cy,	quh_cus2zp,
quh_cus1cp,	quh_cus2cp,	quh_salrep,	
quh_valdat,	quh_smpprd,	quh_smpfgt,	quh_prctrm,
quh_paytrm,	quh_curcde,
quh_creusr,	quh_updusr,	quh_credat,	quh_upddat,
quh_cusagt,	quh_relcnt,	quh_rmk
)

values

(
@quh_cocde,	@qutno,		@quh_issdat,	@quh_rvsdat,
@quh_qutsts,	@quh_cus1no,	isnull(@quh_cus2no,''),	@quh_currel,
@quh_cus1ad,	@quh_cus2ad,	@quh_cus1st,	@quh_cus1cy,
@quh_cus1zp,	@quh_cus2st,	@quh_cus2cy,	@quh_cus2zp,
@quh_cus1cp,	@quh_cus2cp,	@quh_salrep,	
@quh_valdat,	@quh_smpprd,	@quh_smpfgt,	@quh_prctrm,	
isnull(@quh_paytrm,''), @quh_curcde,	
@quh_creusr,	@quh_creusr,
getdate(),		getdate(),
@quh_cusagt,	@quh_relcnt,	@quh_rmk	
)






GO
GRANT EXECUTE ON [dbo].[sp_insert_QUOTNHDR_QUOTD] TO [ERPUSER] AS [dbo]
GO
