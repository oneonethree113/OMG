/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_Q_upditm]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMBASINF_Q_upditm]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_Q_upditm]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/************************************************************************
Author:		Lester Wu    
Date:		28th September, 2008
Description:	Select IM data for fty tmp #
***********************************************************************
*/



CREATE PROCEDURE [dbo].[sp_select_IMBASINF_Q_upditm] 

@ibi_cocde 	nvarchar(6),
@ibi_itmno	nvarchar(20),
@oriitmno	nvarchar(20)       ,
@qud_qutseq	int        





AS

--------------------------------------------
-- Lester Wu 2006-02-09
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


-- AY Renark at 2006-03-10
	select @selRate = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'

--	select 
--		@TtlFtyCst = sum(iba_bomqty*iba_untcst) , 
--		@Curr = iba_curcde
--	from IMBOMASS 
--	where iba_itmno = @ivi_itmno
--	and iba_typ = 'BOM'
--	group by iba_curcde


	-- Get Exchange Rate --
	select @rate1 = ysi_selrat from SYSETINF where ysi_typ = '06' and ysi_cde = 'HKD'
	----------------------------

/*
	DECLARE IMBOMASS_cursor CURSOR FOR 
		select iba_curcde, iba_bomqty, iba_untcst from imbomass  
		where iba_itmno = @ivi_itmno

	OPEN IMBOMASS_cursor 

	FETCH NEXT FROM IMBOMASS_cursor 
	INTO @iba_curcde, @iba_bomqty, @iba_untcst

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		if @iba_curcde = 'USD'
			set @TtlFtyCst = @TtlFtyCst + ((@iba_bomqty * @iba_untcst) /  @rate1) 
		else
			set @TtlFtyCst = @TtlFtyCst + (@iba_bomqty * @iba_untcst) 

		FETCH NEXT FROM IMBOMASS_cursor 
		INTO @iba_curcde, @iba_bomqty, @iba_untcst

	END
	CLOSE IMBOMASS_cursor 
	DEALLOCATE IMBOMASS_cursor 
*/
	set  @Curr = 'HKD'

--------------------------------------------

-- ******* Check for ALias Item or not **********
if (select count(*) from IMBASINF where  ibi_alsitmno = @ibi_itmno	 and ibi_itmsts <>'CLO') = 0

--if (select count(*) from IMBASINF where --ibi_cocde = @ivi_cocde and ibi_itmno = @ivi_itmno) = 1 
            if (select count(*) from IMBASINF where  ibi_itmno = @ibi_itmno	 and ibi_itmsts <>'CLO') = 1 

	begin
	
	select 	--distinct 
			@oriitmno as 'qud_itmno',
			@qud_qutseq as 'qud_qutseq',
			ibi_itmno as 'vw_itmno',
			isnull(ibi_engdsc,'') as 'vw_engdsc',
			isnull(icf_colcde,'') as 'vw_colcde', 
			isnull(rtrim(ltrim(imu_pckunt)) + '/' +  rtrim(ltrim(str(imu_inrqty))) + '/' +  rtrim(ltrim(str(imu_mtrqty))) ,'') as 'vw_pckunt',
			isnull(ibi_alsitmno,'') as 'ibi_alsitmno',
			isnull(ibi_alscolcde,'') as 'ibi_alscolcde',


			--Added by Mark Lau 20061109
			 'The matched item is in ' + case ibi_itmsts 	
							
							--when 'HLD' then 'Hold'
							when 'DIS' then  'Discontinued'
							--when 'INA' then 'Inactive'
							--when 'TBC' then 'To Be Confirmed '
							--when 'OLD' then 'Old Item'
					end + ' Status.' as 'Remarks',
			isnull(ibi_ftytmp,'') as 'vw_ftytmpitm',
			case when isnull(imu_std,'') <> 'N' then	isnull(imu_basprc,0) else 0 end as 'vw_basprc'
	from IMVENINF
	left join imbasinf on ibi_itmno = ivi_itmno
	left join imcolinf on ibi_itmno = icf_itmno
	left join IMMRKUP 
		on 	--ivi_cocde = imu_cocde 	and 
			ivi_itmno = imu_itmno 	and 
			ivi_venno = imu_prdven --imu_venno
	left join VNBASINF 
		on 	--ivi_cocde = vbi_cocde 	and 
			ivi_venno = vbi_venno
	--Kenny Add on 04-10-2002
	left join SYSETINF prc on
	prc.ysi_cocde = ' ' --ivi_cocde 
	and prc.ysi_cde = imu_prctrm and prc.ysi_typ = '03'
	-- Lester Wu 2006-01-19
	left join SYSETINF  prcfty on prcfty.ysi_cocde = ' ' and prcfty.ysi_cde = imu_ftyprctrm and prcfty.ysi_typ = '03'
	
	where	--ivi_cocde = @ivi_cocde	and
		ivi_itmno = @ibi_itmno		and
		--imu_pckseq = @ipi_pckseq	and
		--imu_ventyp = (case @ivi_cocde when 'UCPP' then 'P'  
			     -- else 'D' end)	and
		imu_ventyp = --'P'  and --
			(case vbi_ventyp when 'I' then 'P' 
				 when 'J' then 'P'
				else 'D' end)	and
		ivi_def = 'Y'	
		-- Lester Wu 2008-10-28
		--and isnull(imu_std,'') <> 'N'	
	order by 	ivi_def desc, imu_ventyp desc, ivi_venno
         end
         else
         begin
	select 				@oriitmno as 'qud_itmno',
			@qud_qutseq as 'qud_qutseq',
			ibi_itmno as 'vw_itmno',
			isnull(ibi_engdsc,'') as 'vw_engdsc',
			isnull(icf_colcde,'') as 'vw_colcde', 
			isnull(rtrim(ltrim(imu_pckunt)) + '/' +  rtrim(ltrim(str(imu_inrqty))) + '/' +  rtrim(ltrim(str(imu_mtrqty))) ,'') as 'vw_pckunt',
			isnull(ibi_alsitmno,'') as 'ibi_alsitmno',
			isnull(ibi_alscolcde,'') as 'ibi_alscolcde',


			--Added by Mark Lau 20061109
			 'The matched item is in ' + case ibi_itmsts 	
							
							--when 'HLD' then 'Hold'
							when 'DIS' then  'Discontinued'
							--when 'INA' then 'Inactive'
							--when 'TBC' then 'To Be Confirmed '
							--when 'OLD' then 'Old Item'
					end + ' Status.' as 'Remarks',
			isnull(ibi_ftytmp,'') as 'vw_ftytmpitm',
			case when isnull(imu_std,'') <> 'N' then	isnull(imu_basprc,0) else 0 end as 'vw_basprc'
	from IMVENINFh
	left join imbasinfh on ibi_itmno = ivi_itmno
	left join imcolinfh on ibi_itmno = icf_itmno
	left join IMMRKUPH 
		on 	--ivi_cocde = imu_cocde 	and 
			ivi_itmno = imu_itmno 	and 
			ivi_venno = imu_prdven  --imu_venno
	left join VNBASINF 
		on 	--ivi_cocde = vbi_cocde 	and 
			ivi_venno = vbi_venno
	--Kenny Add on 04-10-2002
	left join SYSETINF prc on
	prc.ysi_cocde = ' ' --ivi_cocde 
	and prc.ysi_cde = imu_prctrm and prc.ysi_typ = '03'
	-- Lester Wu 2006-01-19
	left join SYSETINF  prcfty on prcfty.ysi_cocde = ' ' and prcfty.ysi_cde = imu_ftyprctrm and prcfty.ysi_typ = '03'
	
	where	--ivi_cocde = @ivi_cocde	and
		ivi_itmno = @ibi_itmno		and
		--imu_pckseq = @ipi_pckseq	and
		imu_ventyp = (case vbi_ventyp when 'I' then 'P' 
				 when 'J' then 'P'
				else 'D' end) and --
			--(case @ivi_cocde when 'ucpp' then 'P'  
		--	      else 'D' end)	and
		ivi_def = 'Y'	
		-- Lester Wu 2008-10-28
		--and isnull(imu_std,'') <> 'N'	
	order by 	ivi_def desc, imu_ventyp desc, ivi_venno
         end
else

begin
	select 				@oriitmno as 'qud_itmno',
			@qud_qutseq as 'qud_qutseq',
			ibi_itmno as 'vw_itmno',
			isnull(ibi_engdsc,'') as 'vw_engdsc',
			isnull(icf_colcde,'') as 'vw_colcde', 
			isnull(rtrim(ltrim(imu_pckunt)) + '/' +  rtrim(ltrim(str(imu_inrqty))) + '/' +  rtrim(ltrim(str(imu_mtrqty))) ,'') as 'vw_pckunt',
			isnull(ibi_alsitmno,'') as 'ibi_alsitmno',
			isnull(ibi_alscolcde,'') as 'ibi_alscolcde',


			--Added by Mark Lau 20061109
			 'The matched item is in ' + case ibi_itmsts 	
							
							--when 'HLD' then 'Hold'
							when 'DIS' then  'Discontinued'
							--when 'INA' then 'Inactive'
							--when 'TBC' then 'To Be Confirmed '
							--when 'OLD' then 'Old Item'
					end + ' Status.' as 'Remarks',
			isnull(ibi_ftytmp,'') as 'vw_ftytmpitm',
			case when isnull(imu_std,'') <> 'N' then	isnull(imu_basprc,0) else 0 end as 'vw_basprc'
	from IMVENINF
	left join imbasinf on ibi_itmno = ivi_itmno
	left join imcolinf on ibi_itmno = icf_itmno
	left join IMMRKUP 
		on 	--ivi_cocde = imu_cocde 	and 
			ivi_itmno = imu_itmno 	and 
			ivi_venno = imu_prdven --imu_venno
	left join VNBASINF 
		on 	--ivi_cocde = vbi_cocde 	and 
			ivi_venno = vbi_venno
	--Kenny Add on 04-10-2002
	left join SYSETINF  prc on
	prc.ysi_cocde = ' ' --ivi_cocde 
	and prc.ysi_cde = imu_prctrm and prc.ysi_typ = '03'
	-- Lester Wu 2006-01-19
	left join SYSETINF  prcfty on prcfty.ysi_cocde = ' ' and prcfty.ysi_cde = imu_ftyprctrm and prcfty.ysi_typ = '03'
	
	where	--ivi_cocde = @ivi_cocde	and
		 (select ivi_venitm from imveninf where ivi_itmno = @ibi_itmno and ivi_def = 'Y') = ivi_itmno	and
		--ivi_itmno = @ivi_itmno	and
		--imu_pckseq = @ipi_pckseq	and
		--imu_ventyp = (case @ivi_cocde when 'UCPP' then 'P'  
		--	      else 'D' end)	and
		imu_ventyp = (case vbi_ventyp when 'I' then 'P' 
				 when 'J' then 'P'
				else 'D' end)	and
	
		ivi_def = 'Y'		
		-- Lester Wu 2008-10-28
		--and isnull(imu_std,'') <> 'N'	
	order by 	ivi_def desc, imu_ventyp desc, ivi_venno
end


GO
GRANT EXECUTE ON [dbo].[sp_select_IMBASINF_Q_upditm] TO [ERPUSER] AS [dbo]
GO
