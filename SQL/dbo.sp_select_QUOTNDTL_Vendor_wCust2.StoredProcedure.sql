/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_Vendor_wCust2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUOTNDTL_Vendor_wCust2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUOTNDTL_Vendor_wCust2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- It is based on sp_select_QUOTNDTL_Vendor
/********************************************************************************************************************
Modification History
********************************************************************************************************************
Modify on		Modify by		Description
********************************************************************************************************************

********************************************************************************************************************/
CREATE   PROCEDURE [dbo].[sp_select_QUOTNDTL_Vendor_wCust2] 

@ivi_cocde 	nvarchar(6),
@ivi_itmno	nvarchar(20),
--@ipi_pckseq	int,
@ipi_pckunt	nvarchar(6),
@ipi_inrqty	int,
@ipi_mtrqty	int,
@ipi_conftr	numeric(9),
@imu_cus1no	nvarchar(20),
@imu_cus2no 	nvarchar(20),
@creusr		nvarchar(30)

AS
--------------------------------------------
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
	-- Get Exchange Rate --
	select @rate1 = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'
	----------------------------
	set  @Curr = 'HKD'
--------------------------------------------

-- ******* Check for ALias Item or not **********
if (select count(*) from IMBASINF where  ibi_alsitmno = @ivi_itmno and ibi_itmsts <>'CLO') = 0
            if (select count(*) from IMBASINF where  ibi_itmno = @ivi_itmno and ibi_itmsts <>'CLO') = 1 
	begin
	select 	ivi_def , 			ivi_venno,			ivi_venitm, 
		imu_ventyp as 'imu_ventyp', 	imu_curcde,		vbi_ventyp,
		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftyprc',
		vbi_vensts,			imu_bcurcde,		imu_basprc,
		vbi_vensna,		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftycst',
		isnull(imu_hkprctrm,'') + ' - ' + isnull(prc.ysi_dsc,'') as 'imu_prctrm', 
		isnull(imu_ftyprctrm,'') + ' - ' + isnull(prcfty.ysi_dsc,'')  as 'imu_ftyprctrm',
		imu_trantrm, imu_cus1no, imu_cus2no, imu_effdat, imu_expdat
	from IMVENINF
	left join IMPRCINF on	ivi_itmno = imu_itmno	and 
				ivi_venno = imu_prdven
	left join VNBASINF on	ivi_venno = vbi_venno	
	left join SYSETINF prc on	prc.ysi_cocde = ' '		and 
				prc.ysi_cde = imu_hkprctrm 	and 
				prc.ysi_typ = '03'
	left join SYSETINF prcfty on 	prcfty.ysi_cocde = ' '		and 
				prcfty.ysi_cde = imu_ftyprctrm 	and 
				prcfty.ysi_typ = '03'	
	where	ivi_itmno = @ivi_itmno				and
		ivi_def = 'Y'					and 
--		imu_status = 'ACT'					and
		imu_pckunt = @ipi_pckunt				and
		imu_inrqty = @ipi_inrqty				and
		imu_mtrqty = @ipi_mtrqty				and
		imu_conftr = @ipi_conftr				--and
--		imu_cus1no = @imu_cus1no				and
--		imu_cus2no = @imu_cus2no				and
--		imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)		and
--		imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)
	order by 	ivi_def desc, imu_ventyp desc, ivi_venno
	end	
         else
	begin
	select 	ivi_def , 			ivi_venno,			ivi_venitm, 
		imu_ventyp as 'imu_ventyp',	imu_curcde,		vbi_ventyp,
		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftyprc',
		vbi_vensts,			imu_bcurcde,		imu_basprc,
		vbi_vensna,		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftycst',
		isnull(imu_hkprctrm,'') + ' - ' + isnull(prc.ysi_dsc,'') as 'imu_prctrm', 
		isnull(imu_ftyprctrm,'') + ' - ' + isnull(prcfty.ysi_dsc,'')  as 'imu_ftyprctrm',
		imu_trantrm, imu_cus1no, imu_cus2no, imu_effdat, imu_expdat
	from IMVENINFH	
	left join IMPRCINFH	on 	ivi_itmno = imu_itmno 	and 
				ivi_venno = imu_prdven 
	left join VNBASINF on 	ivi_venno = vbi_venno
	left join SYSETINF prc on	prc.ysi_cocde = ' ' 		and
				prc.ysi_cde = imu_hkprctrm	and
				prc.ysi_typ = '03'	
	left join SYSETINF prcfty on	prcfty.ysi_cocde = ' '		and
				prcfty.ysi_cde = imu_ftyprctrm	and
				prcfty.ysi_typ = '03'	
	where	ivi_itmno = @ivi_itmno				and
		ivi_def = 'Y'					and
--		imu_status = 'ACT'					and
		imu_pckunt = @ipi_pckunt				and
		imu_inrqty = @ipi_inrqty				and
		imu_mtrqty = @ipi_mtrqty				--and
--		imu_cus1no = @imu_cus1no				and
--		imu_cus2no = @imu_cus2no				and
--		imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)		and
--		imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)
	order by 	ivi_def desc, imu_ventyp desc, ivi_venno
	end
else
begin
	select 	ivi_def , 			ivi_venno,			ivi_venitm, 
		imu_ventyp as 'imu_ventyp', 	imu_curcde,		vbi_ventyp,
		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftyprc',
		vbi_vensts,			imu_bcurcde,		imu_basprc,
		vbi_vensna,		(case imu_negprc when 0  then imu_ftyprc else imu_negprc end) as 'imu_ftycst',
		isnull(imu_hkprctrm,'') + ' - ' + isnull(prc.ysi_dsc,'') as 'imu_prctrm', 
		isnull(imu_ftyprctrm,'') + ' - ' + isnull(prcfty.ysi_dsc,'')  as 'imu_ftyprctrm',
		imu_trantrm, imu_cus1no, imu_cus2no, imu_effdat, imu_expdat
	from IMVENINF
	left join IMPRCINF on	ivi_itmno = imu_itmno 	and 
				ivi_venno = imu_prdven 
	left join VNBASINF on 	ivi_venno = vbi_venno
	left join SYSETINF prc on	prc.ysi_cocde = ' '		and
				prc.ysi_cde = imu_hkprctrm	and
				prc.ysi_typ = '03'
	left join SYSETINF prcfty on	prcfty.ysi_cocde = ' '		and
				prcfty.ysi_cde = imu_ftyprctrm	and
				prcfty.ysi_typ = '03'	
	where	(
			select ivi_venitm
			from imveninf
			where	ivi_itmno = @ivi_itmno	and
				ivi_def = 'Y' ) = ivi_itmno	and
--		imu_status = 'ACT'					and
		imu_pckunt = @ipi_pckunt				and
		imu_inrqty = @ipi_inrqty				and
		imu_mtrqty = @ipi_mtrqty				and
		imu_conftr = @ipi_conftr				--and
--		imu_cus1no = @imu_cus1no				and
--		imu_cus2no = @imu_cus2no				and
--		imu_effdat <= CONVERT(varchar(100), GETDATE(), 1)		and
--		imu_expdat >= CONVERT(varchar(100),  dateadd(dd, 1, GETDATE()), 1)
	order by 	ivi_def desc, imu_ventyp desc, ivi_venno
end






GO
GRANT EXECUTE ON [dbo].[sp_select_QUOTNDTL_Vendor_wCust2] TO [ERPUSER] AS [dbo]
GO
