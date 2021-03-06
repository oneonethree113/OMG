/****** Object:  StoredProcedure [dbo].[sp_insert_IMCOMDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMCOMDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMCOMDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
=================================================================
Program ID	: sp_insert_IMCOMDAT   
Description	: Insert data into IMCOMDAT
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-07-14	David Yue		SP Created
=================================================================
*/

CREATE procedure [dbo].[sp_insert_IMCOMDAT]

@imd_cocde	nvarchar(6),
@imd_itmseq	int,
@imd_xlsfil	nvarchar(30),
@imd_chkdat	nvarchar(30),
@imd_venitm	nvarchar(20),
@imd_cosmth	nvarchar(50),
@imd_compon	nvarchar(200),
@imd_asstive	int,
@imd_rmk	nvarchar(2000),
@usrid		nvarchar(30)

AS

declare -- IMCOMDAT --
@imd_recseq	int,
@imd_stage	nvarchar(1),
@imd_sysmsg	nvarchar(300)

set @imd_stage = 'W'
set @imd_sysmsg = ''

-- Convert Construction Method Code --
if @imd_cosmth = 'Glued on'
	set @imd_cosmth = 'GLU'
else if @imd_cosmth = 'Handcrafted'
	set @imd_cosmth = 'HCF'
else if @imd_cosmth = 'Hand painted'
	set @imd_cosmth = 'HPT'
else if @imd_cosmth = 'Handwrapped'
	set @imd_cosmth = 'HWP'
else if @imd_cosmth = 'Mouth-blown'
	set @imd_cosmth = 'MBW'
else if @imd_cosmth = 'Moulded'
	set @imd_cosmth = 'MOD'
else if @imd_cosmth = 'Snapped on'
	set @imd_cosmth = 'SNP'
else if @imd_cosmth = 'Weaving'
	set @imd_cosmth = 'WAV'
else if @imd_cosmth = 'Wired on'
	set @imd_cosmth = 'WRD'
else
begin
	set @imd_stage = 'I'
	set @imd_sysmsg = left(@imd_sysmsg + case @imd_sysmsg when '' then '' else '. ' end + @imd_cosmth + ' - Invalid Construction Method', 300)
end

if (select count(*) from IMITMDAT (nolock) where iid_itmseq = @imd_itmseq and iid_xlsfil = @imd_xlsfil and
	iid_chkdat = @imd_chkdat and iid_venitm = @imd_venitm) = 0
begin
	set @imd_stage = 'I'
	set @imd_sysmsg = left(@imd_sysmsg + case @imd_sysmsg when '' then '' else '. ' end + @imd_venitm + ' - Item Info not found in Excel', 300)
end

-- Change previous IMCOMDAT entries to Stage 'O' --
update	IMCOMDAT
set	imd_stage = 'O',
	imd_updusr = left('E-'+ @usrid, 30),
	imd_upddat = getdate()
where	imd_itmseq <> @imd_itmseq and
	imd_venitm = @imd_venitm

-- Change IMITMDAT and IMITMDATCST Stage to 'I' if IMCOMDAT Stage is 'I' --
if @imd_stage = 'I'
begin
	update	IMITMDAT
	set	iid_stage = 'I',
		iid_sysmsg = left(iid_sysmsg + case iid_sysmsg when '' then '' else '. ' end + @imd_sysmsg ,300),
		iid_refresh = 'N',
		iid_updusr = left('E-'+ @usrid, 30),
		iid_upddat = getdate()
	where	iid_itmseq = @imd_itmseq and
		iid_venitm = @imd_venitm

	update	IMITMDATCST
	set	iic_stage = 'I',
		iic_updusr = left('E-'+ @usrid, 30),
		iic_upddat = getdate()
	where	iic_itmseq = @imd_itmseq and
		iic_venitm = @imd_venitm
end

-- Retrieve Next Record Sequence
select	@imd_recseq = max(imd_recseq) + 1
from	(
	select	isnull(max(imd_recseq), 0) as imd_recseq
	from 	IMCOMDAT (nolock)
	where	imd_itmseq = @imd_itmseq
	UNION 
	select 	isnull(max(imd_recseq), 0)
	from 	IMCOMDATH (nolock)
	where	imd_itmseq = @imd_itmseq
	) as t

insert into IMCOMDAT
(	imd_cocde,		imd_venno,		imd_prdven,
	imd_venitm,		imd_itmseq,		imd_recseq,
	imd_cosmth,		imd_compon,		imd_asstive,
	imd_rmk,		imd_stage,		imd_sysmsg,
	imd_xlsfil,		imd_veneml,		imd_malsts,
	imd_chkdat,		imd_creusr,		imd_updusr,
	imd_credat,		imd_upddat
)
values
(	'',			'',			'',
	@imd_venitm,		@imd_itmseq,		@imd_recseq,
	@imd_cosmth,		@imd_compon,		@imd_asstive,
	@imd_rmk,		@imd_stage,		@imd_sysmsg,
	@imd_xlsfil,		'',			'N',
	@imd_chkdat,		left('E-'+ @usrid, 30),	left('E-'+ @usrid, 30),
	getdate(),		getdate()
)



GO
GRANT EXECUTE ON [dbo].[sp_insert_IMCOMDAT] TO [ERPUSER] AS [dbo]
GO
