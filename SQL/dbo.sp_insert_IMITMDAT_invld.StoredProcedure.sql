/****** Object:  StoredProcedure [dbo].[sp_insert_IMITMDAT_invld]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMITMDAT_invld]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMITMDAT_invld]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
=========================================================
Program ID	: 	sp_select_IMITMDAT_Invld
Description   	: 	Reactivate IM Invalid Items to IMITMDAT
Programmer  	: 	David Yue
Date Created	:	2012-06-26
=========================================================
 Modification History                                    
=========================================================
2012-07-05	David Yue	Added Price Term Checking
2012-07-21	David Yue	Added User ID
=========================================================     
*/

CREATE    PROCEDURE [dbo].[sp_insert_IMITMDAT_invld]

@cocde		nvarchar(6),	@venno		nvarchar(6),	@venitm		nvarchar(20),
@itmseq		int,		@recseq		int,		@stage		nvarchar(3),
@updusr		nvarchar(30),	@newFormat	nvarchar(3)

AS

declare	-- TEMP
@refresh	nvarchar(1),	@sysmsg		nvarchar(200)

declare	-- IMITMDAT
@iid_cocde	nvarchar(6),	@iid_venno 	nvarchar(6),	@iid_prdven 	nvarchar(6),
@iid_venitm 	nvarchar(20),	@iid_itmseq 	int,		@iid_itmsts 	nvarchar(3),
@iid_stage  	nvarchar(3),	@iid_engdsc 	nvarchar(800),	@iid_chndsc 	nvarchar(1600),
@iid_lnecde 	nvarchar(10), 	@iid_catlvl4 	nvarchar(20),	@iid_untcde 	nvarchar(6),
@iid_inrqty 	int,  		@iid_mtrqty 	int,		@iid_inrlcm 	numeric(11,4),
@iid_inrwcm 	numeric(11,4), 	@iid_inrhcm 	numeric(11,4),	@iid_mtrlcm 	numeric(11,4),
@iid_mtrwcm 	numeric(11,4), 	@iid_mtrhcm 	numeric(11,4),	@iid_cft  	numeric(11,4),
@iid_conftr 	int,  		@iid_curcde 	nvarchar(6),    @iid_ftycst  	numeric(13,4),
@iid_ftyprc 	numeric(13,4), 	@iid_prctrm 	nvarchar(10),   @iid_grswgt 	numeric(6,3),
@iid_netwgt 	numeric(6,3), 	@iid_pckitr 	nvarchar(300),	@iid_xlsfil 	nvarchar(30),
@iid_veneml 	nvarchar(50),	@iid_chkdat 	nvarchar(30),	@iid_bomflg 	char(1),
@iid_orgdsgvenno varchar(6),	@iid_moq 	int,		@iid_fcurcde  	varchar(6),
@iid_wastage 	numeric(5,2),	@iid_remark 	nvarchar(2000),	@iid_cusven 	varchar(6),
@iid_alsitmno 	nvarchar(20),	@iid_alscolcde 	nvarchar(30),	@iid_period 	datetime,
@iid_cstexpdat 	datetime

declare	-- IMITMDATCST
@iic_cus1no	nvarchar(6),	@iic_cus2no	nvarchar(6),	@iic_fcA	numeric(13,4),
@iic_fcB	numeric(13,4),	@iic_fcC	numeric(13,4),	@iic_fcD	numeric(13,4),
@iic_fcTran	numeric(13,4),	@iic_fcPack	numeric(13,4),	@iic_icA	numeric(13,4),
@iic_icB	numeric(13,4),	@iic_icC	numeric(13,4),	@iic_icD	numeric(13,4),
@iic_icTran	numeric(13,4),	@iic_icPack	numeric(13,4),	@iic_nat 	nvarchar(20),
@iic_negprc 	numeric(13,4)

set @sysmsg = ''
set @refresh = 'N'

SELECT top 1
	@iid_cocde = iid_cocde,
	@iid_venno = iid_venno,
	@iid_venitm = iid_venitm,
--	@iid_itmseq = iid_itmseq,
	@iid_itmsts = iid_itmsts,
	@iid_engdsc = iid_engdsc,
	@iid_chndsc = iid_chndsc,
	@iid_lnecde = iid_lnecde,
	@iid_catlvl4 = iid_catlvl4,
	@iid_untcde = iid_untcde,
	@iid_inrqty = iid_inrqty,
	@iid_mtrqty = iid_mtrqty,
	@iid_inrlcm = iid_inrlcm,
	@iid_inrwcm = iid_inrwcm,
	@iid_inrhcm = iid_inrhcm,
	@iid_mtrlcm = iid_mtrlcm,
	@iid_mtrwcm = iid_mtrwcm,
	@iid_mtrhcm = iid_mtrhcm,
	@iid_cft = iid_cft,
	@iid_conftr = iid_conftr,
	@iid_curcde = iid_curcde,
	@iid_ftycst = iid_ftycst,
	@iid_ftyprc = iid_ftyprc,
	@iid_prctrm = iid_prctrm,
	@iid_grswgt = iid_grswgt,
	@iid_netwgt = iid_netwgt,
	@iid_pckitr = iid_pckitr,
--	@iid_stage = iid_stage,
	@iid_xlsfil = iid_xlsfil,
	@iid_veneml = iid_veneml,
	@iid_chkdat = iid_chkdat,
	@iid_prdven = iid_prdven,
	@iid_bomflg = iid_bomflg,
	@iid_orgdsgvenno = iid_orgdsgvenno,
	@iid_moq = iid_moq,
	@iid_fcurcde = iid_fcurcde,
	@iid_wastage = iid_wastage,
	@iid_remark = iid_remark,
	@iid_cusven = iid_cusven,
	@iid_alsitmno = iid_alsitmno,
	@iid_alscolcde = iid_alscolcde,
	@iid_period = iid_period,
	@iid_cstexpdat = iid_cstexpdat
FROM	IMITMDAT
WHERE	iid_cocde = @cocde and
	iid_venno = @venno and
	iid_venitm = @venitm and
	iid_itmseq = @itmseq and
	iid_stage = 'I'
ORDER BY iid_credat desc

set @iid_stage = @stage

SELECT top 1
	@iic_cus1no = iic_cus1no,
	@iic_cus2no = iic_cus2no,
	@iic_fcA = iic_fcA,
	@iic_fcB = iic_fcB,
	@iic_fcC = iic_fcC,
	@iic_fcD = iic_fcD,
	@iic_fcTran = iic_fcTran,
	@iic_fcPack = iic_fcPack,
	@iic_icA = iic_icA,
	@iic_icB = iic_icB,
	@iic_icC = iic_icC,
	@iic_icD = iic_icD,
	@iic_icTran = iic_icTran,
	@iic_icPack = iic_icPack,
	@iic_nat = iic_nat,
	@iic_negprc = iic_negprc
FROM	IMITMDATCST
WHERE	iic_cocde = @cocde and
	iic_venno = @venno and
	iic_venitm = @venitm and
	iic_itmseq = @itmseq and
	iic_recseq = @recseq and
	iic_stage = 'I'
ORDER BY iic_credat desc


-- Check Production Vendor --
if @iid_prdven <> ''
begin
	if (SELECT count(*) FROM VNBASINF WHERE vbi_venno = @iid_prdven) = 0
	begin
		if @sysmsg <> ''
		begin
			set @sysmsg = @sysmsg + ', '
		end
		set @sysmsg = @sysmsg + 'Design Vendor : [' + @iid_prdven + '] not found in Vendor Master!'
		set @iid_stage = 'I'
		set @refresh = 'Y'
	end
end
else
begin
	if @sysmsg <> ''
	begin
		set @sysmsg = @sysmsg + ', '
	end
	set @sysmsg = @sysmsg + 'Missing Design Vendor!'
	set @iid_stage = 'I'
	set @refresh = 'Y'
end

-- Check Product Line/Season Code --
if @cocde = 'UCPP'
begin
	if (SELECT count(*) FROM SYLNEINF WHERE yli_lnecde = @iid_lnecde) = 0 and @iid_bomflg <> 'Y'
	begin
		if @sysmsg <> ''
		begin
			set @sysmsg = @sysmsg + ', '
		end
		set @sysmsg = @sysmsg + @iid_lnecde + ' - Product Line/Season Code not exist!'
		set @iid_stage = 'I'
		set @refresh = 'Y'
	end
end

if (SELECT count(*) FROM SYCATREL WHERE ycr_catlvl4 = @iid_catlvl4) = 0 and @iid_bomflg <> 'Y'
begin
	if @sysmsg <> ''
	begin
		set @sysmsg = @sysmsg + ', '
	end
	set @sysmsg = @sysmsg + @iid_lnecde + ' - Category 4 not exist'
	set @iid_stage = 'I'
	set @refresh = 'Y'
end

-- Check Conversion Factor --
if (SELECT count(*) FROM SYCONFTR WHERE ycf_code1 = @iid_untcde and ycf_systyp = 'Y' and
	ycf_value = CASE WHEN @iid_conftr = '' THEN 0 ELSE @iid_conftr END) = 0
begin
	declare @cfactor nvarchar(6)
	SELECT	@cfactor = ycf_code1
	FROM	SYCONFTR
	WHERE	ycf_systyp = 'Y' and
		ycf_code2 = 'PC' and
		ycf_dsc1 = @iid_untcde and
		ycf_value = @iid_conftr
	if @cfactor = ''
	begin
		if @sysmsg <> ''
		begin
			set @sysmsg = @sysmsg + ', '
		end
		set @sysmsg = @sysmsg + @iid_conftr + ' - Invalid Conversion Factor'
	end
	else
	begin
		set @iid_untcde = @cfactor
	end
end

-- Check Custom Vendor --
if @iid_cusven <> ''
begin
	if (SELECT count(*) FROM VNBASINF WHERE vbi_venno = @iid_cusven) = 0
	begin
		if @sysmsg <> ''
		begin
			set @sysmsg = @sysmsg + ', '
		end
		set @sysmsg = @sysmsg + 'Custom Vendor : [' + @iid_cusven + '] not found in Vendor Master!'
		set @iid_stage = 'I'
		set @refresh = 'Y'
	end
end
else
begin
	if @sysmsg <> ''
	begin
		set @sysmsg = @sysmsg + ', '
	end
	set @sysmsg = @sysmsg + 'Missing Custom Vendor'
	set @iid_stage = 'I'
	set @refresh = 'Y'
end

if (select count(*) from SYSETINF where ysi_typ = '03' and ysi_cde = @iid_prctrm) = 0
begin
	declare @prctrm nvarchar(30)
	set @prctrm = ''

	select	@prctrm = ysi_cde
	from	SYSETINF
	where	ysi_typ = '03' and
		ysi_dsc = @iid_prctrm

	if @prctrm <> ''
	begin
		set @iid_prctrm = @prctrm
	end
	else
	begin
		set @sysmsg = left(@sysmsg + case when len(@sysmsg)=0 then '' else ',' end + @iid_prctrm + ' - Invalid Price Term' , 300)
		set @iid_stage = 'I'
	end
end

if @iid_period = ''
begin
	set @sysmsg = left(@sysmsg + case when len(@sysmsg)=0 then '' else ',' end + 'Period is missing' , 300)
	set @iid_stage = 'I'
end

if @iid_cstexpdat = ''
begin
	if isdate(@iid_period) = 1
	begin
		set @iid_cstexpdat = dateadd(year,1,@iid_period)
	end
end


-- REMOVE INVALID ENTRY FROM IMITMDAT --
DELETE FROM IMITMDAT
WHERE	iid_cocde = @cocde and
	iid_venno = @venno and
	iid_venitm = @venitm and
	iid_itmseq = @itmseq and
	iid_stage = 'I'

-- REMOVE INVALID ENTRY FROM IMITMDATCST --
DELETE FROM IMITMDATCST
WHERE	iic_cocde = @cocde and
	iic_venno = @venno and
	iic_venitm = @venitm and
	iic_itmseq = @itmseq and
	iic_recseq = @recseq and
	iic_stage = 'I'

-- Retrieve Next Item Sequence Number
select @iid_itmseq = isnull(max(iid_itmseq),0) + 1 from IMITMDAT
declare @temp int
select @temp = isnull(max(iid_itmseq),0) + 1 from IMITMDATH
if @iid_itmseq < @temp
	set @iid_itmseq = @temp

declare @period nvarchar(10), @cstexpdat nvarchar(10)
set @period = convert(nvarchar(10),@iid_period, 120)
set @cstexpdat = convert(nvarchar(10),@iid_cstexpdat, 120)

-- INSERT NEW ENTRY TO IMITMDAT AND IMITMDATCST --
if (SELECT count(*) FROM IMITMDAT WHERE iid_venno = @venno and iid_venitm = @venitm and iid_itmseq = @itmseq) = 0
begin
	EXEC	sp_insert_IMITMDAT @iid_cocde, @iid_venno, @iid_venitm, @iid_itmseq, @iid_itmsts, @iid_engdsc, @iid_chndsc, @iid_lnecde,
		@iid_catlvl4, @iid_untcde, @iid_inrqty, @iid_mtrqty, @iid_inrlcm, @iid_inrwcm, @iid_inrhcm, @iid_mtrlcm, @iid_mtrwcm,
		@iid_mtrhcm, @iid_cft, @iid_conftr, @iid_curcde, @iid_ftycst, @iid_ftyprc, @iid_prctrm, @iid_grswgt, @iid_netwgt,
		@iid_pckitr, @stage, @sysmsg, @iid_xlsfil, @refresh, @iid_veneml, @iid_chkdat, @iid_prdven, @iid_bomflg,
		@iid_orgdsgvenno, @iid_moq, @iid_fcurcde, @iid_wastage, @iid_remark, '1', @iid_cusven, @iid_alsitmno, @iid_alscolcde,
		@newFormat, @iic_cus1no, @iic_cus2no, @iic_fcA, @iic_fcB, @iic_fcC, @iic_fcD, @iic_fcTran, @iic_fcPack, @iic_icA,
		@iic_icB, @iic_icC, @iic_icD, @iic_icTran, @iic_icPack, @iic_nat, @iic_negprc, @period, @cstexpdat, @updusr
end







GO
GRANT EXECUTE ON [dbo].[sp_insert_IMITMDAT_invld] TO [ERPUSER] AS [dbo]
GO
