/****** Object:  StoredProcedure [dbo].[sp_insert_IMASSDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMASSDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMASSDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
=================================================================
Program ID	: sp_insert_IMASSDAT   
Description	: Insert data into IMASSDAT
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-07-14	David Yue		SP Created
=================================================================
*/

CREATE procedure [dbo].[sp_insert_IMASSDAT]

@iad_cocde	nvarchar(6),
@iad_itmseq	int,
@iad_xlsfil	nvarchar(30),
@iad_chkdat	nvarchar(30),
@iad_venitm	nvarchar(20),
@iad_acsno	nvarchar(20),
@iad_colcde	nvarchar(20),
@iad_untcde	nvarchar(10),
@iad_conftr	int,
@iad_inrqty	int,
@iad_mtrqty	int,
@iad_period	nvarchar(30),
@usrid		nvarchar(30)

AS

declare -- IMASSDAT --
@iad_recseq	int,
@iad_stage	nvarchar(1),
@iad_sysmsg	nvarchar(300),
@iad_period_bef	datetime

set @iad_stage = 'W'
set @iad_sysmsg = ''

if (select count(*) from IMITMDAT (nolock) where iid_itmseq = @iad_itmseq and iid_xlsfil = @iad_xlsfil and
	iid_chkdat = @iad_chkdat and iid_venitm = @iad_venitm) = 0
begin
	set @iad_stage = 'I'
	set @iad_sysmsg = left(@iad_sysmsg + case @iad_sysmsg when '' then '' else '. ' end + @iad_venitm + ' - Item Info not found in Excel', 300)
end
else
begin
	-- Check Assorted Item in IMBASINF --
	if (select count(*) from IMBASINF (nolock) where ibi_itmno = @iad_acsno) = 0
	begin
		set @iad_stage = 'I'
		set @iad_sysmsg = left(@iad_sysmsg + case @iad_sysmsg when '' then '' else '. ' end + @iad_acsno + ' - Assorted Item not found in Item Master', 300)
	end
	else if (select count(*) from IMBASINF (nolock) where ibi_itmno = @iad_acsno and ibi_typ = 'REG') = 0
	begin
		set @iad_stage = 'I'
		set @iad_sysmsg = left(@iad_sysmsg + case @iad_sysmsg when '' then '' else '. ' end + @iad_acsno + ' - Assorted Item not a REG Item', 300)
	end

	-- Check Assorted Item in IMCOLINF --
	if (select count(*) from IMCOLINF (nolock) where icf_itmno = @iad_acsno and icf_colcde = @iad_colcde) = 0
	begin
		set @iad_stage = 'I'
		set @iad_sysmsg = left(@iad_sysmsg + case @iad_sysmsg when '' then '' else '. ' end + @iad_acsno + ' / ' + @iad_colcde + ' - Assorted Item color not found in Item Master', 300)
	end

	select	@iad_period_bef = isnull(iba_period, '1900-01-01')
	from	IMBOMASS (nolock)
	where	iba_itmno = @iad_venitm and
		iba_typ = 'ASS'

	if @iad_period_bef = null
		set @iad_period_bef = '1900-01-01'

	-- Check Assorted Item UM --
	if @iad_untcde = ''
	begin
		set @iad_stage = 'I'
		set @iad_sysmsg = left(@iad_sysmsg + case @iad_sysmsg when '' then '' else '. ' end + @iad_acsno + ' - Assorted Item Missing UM', 300)
	end
	else
	begin
		if (select count(*) from SYCONFTR (nolock) where ycf_dsc1 = @iad_untcde and ycf_value = @iad_conftr and ycf_code2 = 'PC' and ycf_systyp = 'Y') = 0
		begin
			set @iad_stage = 'I'
			set @iad_sysmsg = left(@iad_sysmsg + case @iad_sysmsg when '' then '' else '. ' end + @iad_acsno + ' / ' + @iad_untcde + ' / ' + cast(@iad_conftr as varchar(6))  + ' - Assorted Item invalid UM and/or Conversion Factor', 300)
		end
		else
		begin
			select	@iad_untcde = ycf_code1
			from	SYCONFTR (nolock)
			where	ycf_dsc1 = @iad_untcde and
				ycf_value = @iad_conftr and
				ycf_code2 = 'PC' and
				ycf_systyp = 'Y'
		end
		
		/*
		-- Check Assorted Item Packing against IM --
		if (select count(*) from IMPCKINF (nolock) where ipi_itmno = @iad_acsno and ipi_pckunt = @iad_untcde and ipi_conftr = @iad_conftr and ipi_inrqty = @iad_inrqty and ipi_mtrqty = @iad_mtrqty) = 0
		begin
			set @iad_stage = 'I'
			set @iad_sysmsg = left(@iad_sysmsg + case @iad_sysmsg when '' then '' else '. ' end + @iad_acsno + ' / ' + @iad_untcde + ' / ' + cast(@iad_conftr as varchar(6)) + ' / ' + cast(@iad_inrqty as varchar(6)) + ' / ' + cast(@iad_mtrqty as varchar(6)) + ' - Assorted Item packing not found in Item Master', 300)
		end
		*/
	end
end

-- Change previous IMASSDAT entries to Stage 'O' --
update	IMASSDAT
set	iad_stage = 'O',
	iad_updusr = left('E-'+ @usrid, 30),
	iad_upddat = getdate()
where	iad_itmseq <> @iad_itmseq and
	iad_venitm = @iad_venitm

-- Change IMITMDAT and IMITMDATCST Stage to 'I' if IMASSDAT Stage is 'I' --
if @iad_stage = 'I'
begin
	update	IMITMDAT
	set	iid_stage = 'I',
		iid_sysmsg = left(iid_sysmsg + case iid_sysmsg when '' then '' else '. ' end + @iad_sysmsg ,300),
		iid_refresh = 'N',
		iid_updusr = left('E-'+ @usrid, 30),
		iid_upddat = getdate()
	where	iid_itmseq = @iad_itmseq and
		iid_venitm = @iad_venitm

	update	IMITMDATCST
	set	iic_stage = 'I',
		iic_updusr = left('E-'+ @usrid, 30),
		iic_upddat = getdate()
	where	iic_itmseq = @iad_itmseq and
		iic_venitm = @iad_venitm
end

-- Retrieve Next Record Sequence
select	@iad_recseq = max(iad_recseq) + 1
from	(
	select	isnull(max(iad_recseq), 0) as iad_recseq
	from 	IMASSDAT (nolock)
	where	iad_itmseq = @iad_itmseq
	UNION 
	select 	isnull(max(iad_recseq), 0)
	from 	IMASSDATH (nolock)
	where	iad_itmseq = @iad_itmseq
	) as t

-- insert data into IMASSDAT --
insert into IMASSDAT
(	iad_cocde,		iad_venno,		iad_prdven,		
	iad_venitm,		iad_acsno,		iad_itmseq,		
	iad_recseq,		iad_colcde,		iad_inrqty,		
	iad_mtrqty,		iad_untcde,		iad_conftr,		
	iad_stage,		iad_sysmsg,		iad_xlsfil,		
	iad_veneml,		iad_malsts,		iad_chkdat,		
	iad_period,		iad_period_bef,		iad_creusr,		
	iad_updusr,		iad_credat,		iad_upddat
)
values
(	'',			'',			'',
	@iad_venitm,		@iad_acsno,		@iad_itmseq,
	@iad_recseq,		@iad_colcde,		@iad_inrqty,
	@iad_mtrqty,		@iad_untcde,		@iad_conftr,
	@iad_stage,		@iad_sysmsg,		@iad_xlsfil,
	'',			'N',			@iad_chkdat,
	@iad_period,		@iad_period_bef,	left('E-'+ @usrid, 30),
	left('E-'+ @usrid, 30),	getdate(),		getdate()
)



GO
GRANT EXECUTE ON [dbo].[sp_insert_IMASSDAT] TO [ERPUSER] AS [dbo]
GO
