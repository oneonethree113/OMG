/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_Vendor]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUOTNDTL_Vendor]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_Vendor]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/********************************************************************************************************************
Modification History
********************************************************************************************************************
Modify on		Modify by		Description
********************************************************************************************************************
2006-01-19		Lester Wu		Retrieve Factory Price Term
2006-02-09		Lester Wu		Add Factory Price Cost
2006-02-11		Lester Wu		For DV <> PV Set BOM Cost to Zero
2006-06-22		Marco Chan		Get Ftybomcst from imu_ftybomcst
********************************************************************************************************************/

CREATE  PROCEDURE [dbo].[sp_select_QUOTNDTL_Vendor] 
@ivi_cocde 	nvarchar(6),
@ivi_itmno	nvarchar(20),
@imu_pckunt	nvarchar(6),
@imu_inrqty	int,
@imu_mtrqty	int,
@imu_cus1no	nvarchar(6),
@imu_cus2no	nvarchar(6),
@imu_ftyprctrm	nvarchar(10),
@imu_hkprctrm	nvarchar(10),
@imu_trantrm	nvarchar(10),
@creusr		nvarchar(30)

AS

declare @TtlFtyCst  as numeric(9,4)
declare @Curr as varchar(6)
declare @selRate as numeric(16,11)
declare 
@rate1 numeric (16,11),
@iba_curcde varchar (6),
@iba_untcst numeric(13,4),
@iba_bomqty int
set @TtlFtyCst = 0
set @Curr = ''
select @selRate = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'
select @rate1 = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'
set  @Curr = 'HKD'

declare @key_pckunt nvarchar(6)
declare @key_inrqty int
declare @key_mtrqty int
declare @key_cus1no nvarchar(6)
declare @key_cus2no nvarchar(6)
declare @key_ftyprctrm nvarchar(10)
declare @key_hkprctrm nvarchar(10)
declare @key_trantrm nvarchar(10)

declare @vbi_ventyp nvarchar(1)

set @key_pckunt = ''
set @key_inrqty = 0
set @key_mtrqty = 0
set @key_cus1no = ''
set @key_cus2no = ''
set @key_ftyprctrm = ''
set @key_hkprctrm = ''
set @key_trantrm = ''

set @key_pckunt = @imu_pckunt
set @key_inrqty = @imu_inrqty
set @key_mtrqty = @imu_mtrqty
--set @key_cus1no = @imu_cus1no
--set @key_cus2no = @imu_cus2no
set @key_ftyprctrm = @imu_ftyprctrm
set @key_hkprctrm = @imu_hkprctrm
set @key_trantrm = @imu_trantrm

-- ******* Check for ALias Item or not **********
if (select count(*) from IMBASINF where  ibi_alsitmno = @ivi_itmno and ibi_itmsts <>'CLO') = 0
begin
	if (select count(*) from IMBASINF where  ibi_itmno = @ivi_itmno and ibi_itmsts <>'CLO') = 1 
	begin
		set @vbi_ventyp = (	select	vbi_ventyp
				from	IMVENINF, VNBASINF
				where	ivi_venno = vbi_venno		and
					ivi_itmno = @ivi_itmno	and
					ivi_def = 'Y')

		--Find out corresponding key in current
		if (select count(*) from 
			IMVENINF, IMPRCINF
			where	ivi_itmno = @ivi_itmno and
				ivi_def = 'Y' and 
				ivi_venno = imu_prdven and
				ivi_itmno = imu_itmno and
				imu_status = 'ACT' and
				imu_pckunt = @imu_pckunt and 
				imu_inrqty = @imu_inrqty and 
				imu_mtrqty = @imu_mtrqty and 
				imu_cus1no = @imu_cus1no and 
				imu_cus2no = @imu_cus2no and
				imu_ftyprctrm = @imu_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @imu_hkprctrm and
				imu_trantrm = @imu_trantrm) = 1 
		begin
			set @key_cus1no = @imu_cus1no
			set @key_cus2no = @imu_cus2no
		end
		else if (select count(*) from 
			IMVENINF, IMPRCINF
			where	ivi_itmno = @ivi_itmno and
				ivi_def = 'Y' and 
				ivi_venno = imu_prdven and
				ivi_itmno = imu_itmno and
				imu_status = 'ACT' and
				imu_pckunt = @imu_pckunt and 
				imu_inrqty = @imu_inrqty and 
				imu_mtrqty = @imu_mtrqty and 
				imu_cus1no = @imu_cus1no and
				imu_cus2no = '' and
				imu_ftyprctrm = @imu_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @imu_hkprctrm and
				imu_trantrm = @imu_trantrm) = 1 
		begin
			set @key_cus1no = @imu_cus1no
			set @key_cus2no = ''
		end
		else if (select count(*) from 
			IMVENINF, IMPRCINF
			where	ivi_itmno = @ivi_itmno and
				ivi_def = 'Y' and 
				ivi_venno = imu_prdven and
				ivi_itmno = imu_itmno and
				imu_status = 'ACT' and
				imu_pckunt = @imu_pckunt and 
				imu_inrqty = @imu_inrqty and 
				imu_mtrqty = @imu_mtrqty and 
				imu_cus1no = (	select	case @vbi_ventyp when 'E' then
									cbi_cugrptyp_ext
							else
									cbi_cugrptyp_int
							end as 'cbi_cugrptyp'
						from	cubasinf
						where	cbi_cusno = @imu_cus1no) and
				imu_cus2no = ''  and
				imu_ftyprctrm = @imu_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @imu_hkprctrm and
				imu_trantrm = @imu_trantrm) = 1 
		begin
			set @key_cus1no = (	select	case @vbi_ventyp when 'E' then
								cbi_cugrptyp_ext
						else
								cbi_cugrptyp_int
						end as 'cbi_cugrptyp'
					from	cubasinf
					where	cbi_cusno = @imu_cus1no)
			set @key_cus2no = ''
		end
		else
		begin
			set @key_cus1no = ''
			set @key_cus2no = ''
		end

		select 	
		ivi_def ,
 		ivi_venno,
	 	ivi_venitm, 
		imu_ventyp,
	 	imu_curcde,
		vbi_ventyp,
		case vbi_ventyp when 'E' then 
			imu_ttlcst
		else
			case isnull(imu_negprc,0) when 0 then imu_ttlcst else imu_negprc end 
		end as 'imu_ftyprc',
		vbi_vensts,
		imu_bcurcde,
		imu_basprc,
		imu_prdven,
		vbi_vensna,
		imu_ftycst as 'imu_ftycst',
		isnull(imu_hkprctrm,'') as 'imu_prctrm', 
		isnull(imu_ftyprctrm,'') as 'imu_ftyprctrm',
		isnull(imu_trantrm,'') as 'imu_trantrm',
		imu_cus1no,
		imu_cus2no,
		imu_effdat,
		imu_expdat,
		ibi_catlvl3,
		imu_ftycstA,
		imu_ftycstB,
		imu_ftycstC,
		imu_ftycstD,
		imu_ftycstE,
		imu_ftycstTran,
		imu_ftycstPack
		from IMVENINF
		left join IMPRCINF on ivi_itmno = imu_itmno and ivi_venno = imu_prdven
		left join VNBASINF on ivi_venno = vbi_venno
		--left join SYSETINF prc on prc.ysi_cocde = ' ' and prc.ysi_cde = imu_hkprctrm and prc.ysi_typ = '03'
		--left join SYSETINF prcfty on prcfty.ysi_cocde = ' ' and prcfty.ysi_cde = imu_ftyprctrm and prcfty.ysi_typ = '03'
		--left join SYSETINF prctran on prctran.ysi_cocde = ' ' and prctran.ysi_cde = imu_trantrm and prctran.ysi_typ = '03'
		left join IMBASINF on ivi_itmno = ibi_itmno
		where
		ivi_itmno = @ivi_itmno	and
		ivi_def = 'Y' and 
		imu_status = 'ACT' and
		imu_pckunt = @key_pckunt and imu_inrqty = @key_inrqty and imu_mtrqty = @key_mtrqty and
		imu_cus1no = @key_cus1no and imu_cus2no = @key_cus2no and
				imu_ftyprctrm = @key_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @key_hkprctrm and
				imu_trantrm = @key_trantrm
		order by ivi_def desc, imu_ventyp desc, ivi_venno
         end
         else
         begin
		set @vbi_ventyp = (	select	vbi_ventyp
				from	IMVENINFH, VNBASINF
				where	ivi_venno = vbi_venno		and
					ivi_itmno = @ivi_itmno	and
					ivi_def = 'Y')

		--Find out corresponding key in current
		if (select count(*) from 
			IMVENINFH, IMPRCINFH
			where	ivi_itmno = @ivi_itmno and
				ivi_def = 'Y' and 
				ivi_venno = imu_prdven and
				ivi_itmno = imu_itmno and
				imu_status = 'ACT' and
				imu_pckunt = @imu_pckunt and 
				imu_inrqty = @imu_inrqty and 
				imu_mtrqty = @imu_mtrqty and 
				imu_cus1no = @imu_cus1no and 
				imu_cus2no = @imu_cus2no and
				imu_ftyprctrm = @imu_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @imu_hkprctrm and
				imu_trantrm = @imu_trantrm) = 1 
		begin
			set @key_cus1no = @imu_cus1no
			set @key_cus2no = @imu_cus2no
		end
		else if (select count(*) from 
			IMVENINFH, IMPRCINFH
			where	ivi_itmno = @ivi_itmno and
				ivi_def = 'Y' and 
				ivi_venno = imu_prdven and
				ivi_itmno = imu_itmno and
				imu_status = 'ACT' and
				imu_pckunt = @imu_pckunt and 
				imu_inrqty = @imu_inrqty and 
				imu_mtrqty = @imu_mtrqty and 
				imu_cus1no = @imu_cus1no and
				imu_cus2no = '' and
				imu_ftyprctrm = @imu_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @imu_hkprctrm and
				imu_trantrm = @imu_trantrm) = 1 
		begin
			set @key_cus1no = @imu_cus1no
			set @key_cus2no = ''
		end
		else if (select count(*) from 
			IMVENINFH, IMPRCINFH
			where	ivi_itmno = @ivi_itmno and
				ivi_def = 'Y' and 
				ivi_venno = imu_prdven and
				ivi_itmno = imu_itmno and
				imu_status = 'ACT' and
				imu_pckunt = @imu_pckunt and 
				imu_inrqty = @imu_inrqty and 
				imu_mtrqty = @imu_mtrqty and 
				imu_cus1no = (	select	case @vbi_ventyp when 'E' then
									cbi_cugrptyp_ext
							else
									cbi_cugrptyp_int
							end as 'cbi_cugrptyp'
						from	cubasinf
						where	cbi_cusno = @imu_cus1no) and
				imu_cus2no = '' and
				imu_ftyprctrm = @imu_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @imu_hkprctrm and
				imu_trantrm = @imu_trantrm) = 1 
		begin
			set @key_cus1no = (	select	case @vbi_ventyp when 'E' then
								cbi_cugrptyp_ext
						else
								cbi_cugrptyp_int
						end as 'cbi_cugrptyp'
					from	cubasinf
					where	cbi_cusno = @imu_cus1no)
			set @key_cus2no = ''
		end
		else
		begin
			set @key_cus1no = ''
			set @key_cus2no = ''
		end

		select 	
		ivi_def ,
 		ivi_venno,
	 	ivi_venitm, 
		imu_ventyp,
	 	imu_curcde,
		vbi_ventyp,
		case vbi_ventyp when 'E' then 
			imu_ttlcst
		else
			case isnull(imu_negprc,0) when 0 then imu_ttlcst else imu_negprc end 
		end as 'imu_ftyprc',
		vbi_vensts,
		imu_bcurcde,
		imu_basprc,
		imu_prdven,
		vbi_vensna,
		imu_ftycst as 'imu_ftycst',
		isnull(imu_hkprctrm,'') as 'imu_prctrm', 
		isnull(imu_ftyprctrm,'') as 'imu_ftyprctrm',
		isnull(imu_trantrm,'') as 'imu_trantrm',
		imu_cus1no,
		imu_cus2no,
		imu_effdat,
		imu_expdat,
		ibi_catlvl3,
		imu_ftycstA,
		imu_ftycstB,
		imu_ftycstC,
		imu_ftycstD,
		imu_ftycstE,
		imu_ftycstTran,
		imu_ftycstPack
		from IMVENINFH
		left join IMPRCINFH on ivi_itmno = imu_itmno and ivi_venno = imu_prdven
		left join VNBASINF on ivi_venno = vbi_venno
		--left join SYSETINF prc on prc.ysi_cocde = ' ' and prc.ysi_cde = imu_hkprctrm and prc.ysi_typ = '03'
		--left join SYSETINF prcfty on prcfty.ysi_cocde = ' ' and prcfty.ysi_cde = imu_ftyprctrm and prcfty.ysi_typ = '03'
		--left join SYSETINF prctran on prctran.ysi_cocde = ' ' and prctran.ysi_cde = imu_trantrm and prctran.ysi_typ = '03'
		left join IMBASINF on ivi_itmno = ibi_itmno
		where
		ivi_itmno = @ivi_itmno	and
		ivi_def = 'Y' and 
		imu_status = 'ACT' and
		imu_pckunt = @key_pckunt and imu_inrqty = @key_inrqty and imu_mtrqty = @key_mtrqty and
		imu_cus1no = @key_cus1no and imu_cus2no = @key_cus2no and
				imu_ftyprctrm = @key_ftyprctrm and
				rtrim(ltrim(imu_hkprctrm)) = @key_hkprctrm and
				imu_trantrm = @key_trantrm
		order by ivi_def desc, imu_ventyp desc, ivi_venno
	end
end








GO
GRANT EXECUTE ON [dbo].[sp_select_QUOTNDTL_Vendor] TO [ERPUSER] AS [dbo]
GO
