/****** Object:  StoredProcedure [dbo].[sp_IMCOMDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_IMCOMDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_IMCOMDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*	Author : Tommy Ho	*/

-- Checked by Allan Yuen at 1 Aug 2003

CREATE procedure [dbo].[sp_IMCOMDAT]
                                                                                                                                                                                                                                                                 
@imd_cocde 	nvarchar(6),	@imd_venitm	nvarchar(20),
@imd_cosmth	nvarchar(50),	@imd_compon	nvarchar(200),
@imd_asstive	int,		@imd_rmk	nvarchar(2000),
@imd_itmseq	int,
@imd_chkdat	nvarchar(30),	@imd_stage	nvarchar(3),
@imd_xlsfil 	nvarchar(30),	@imd_veneml	nvarchar(50),
@imd_malsts	nvarchar(1),	@imd_venno	nvarchar(6),
@imd_prdven	nvarchar(6)

AS

declare 	@imd_recseq	int,	@itmno 		nvarchar(20),	@imd_sysmsg	nvarchar(300)

if @imd_cosmth = 'Glued on'
begin
	set @imd_cosmth = 'GLU'
end
if @imd_cosmth = 'Handcrafted'
begin
	set @imd_cosmth = 'HCF'
end
if @imd_cosmth = 'Hand painted'
begin
	set @imd_cosmth = 'HPT'
end
if @imd_cosmth = 'Handwrapped'
begin
	set @imd_cosmth = 'HWP'
end
if @imd_cosmth = 'Mouth-blown'
begin
	set @imd_cosmth = 'MBW'
end
if @imd_cosmth = 'Moulded'
begin
	set @imd_cosmth = 'MOD'
end
if @imd_cosmth = 'Snapped on'
begin
	set @imd_cosmth = 'SNP'
end
if @imd_cosmth = 'Weaving'
begin
	set @imd_cosmth = 'WAV'
end
if @imd_cosmth = 'Wired on'
begin
	set @imd_cosmth = 'WRD'
end
if @imd_cosmth is null 
begin
	set @imd_cosmth = ''
end


Set  @imd_recseq = (Select isnull(max(imd_recseq),0)  + 1 from IMCOMDAT where imd_cocde = @imd_cocde)

/*
if (select count(*) from IMITMDAT where 	iid_cocde = @imd_cocde and iid_venno = @imd_venno and iid_venitm = @imd_venitm and
					iid_xlsfil = @imd_xlsfil and iid_chkdat = @imd_chkdat) = 0
begin
	set @itmno = ''
	select @itmno = ivi_itmno from IMVENINF where ivi_cocde = @imd_cocde and 
			ivi_venitm = @imd_venitm and ivi_venno = @imd_venno

	if @itmno is null or @itmno = ''
	begin
		set @imd_stage = 'I'
		set @imd_sysmsg = 'Vendor Item Number not exist'
	end
	else
	begin
		set @imd_stage = 'W'
		set @imd_sysmsg = ''
	end
end
*/

insert into  IMCOMDAT
(	
	imd_cocde, 	imd_venitm, 	imd_itmseq,
	imd_recseq,	imd_cosmth, 	imd_compon,	
	imd_asstive,	imd_creusr, 	imd_updusr, 	
	imd_credat, 	imd_upddat,	imd_chkdat,
	imd_stage,	imd_xlsfil,	imd_veneml,
	imd_malsts,	imd_sysmsg,	imd_venno,
	imd_prdven,	imd_rmk
)
values
(
	@imd_cocde, 	@imd_venitm, 	@imd_itmseq,
	@imd_recseq,	@imd_cosmth, 	@imd_compon,	
	@imd_asstive,	'Excel', 		'Excel', 		
	getdate(), 		getdate(),		@imd_chkdat,
	@imd_stage,	@imd_xlsfil,	@imd_veneml,
	@imd_malsts,	@imd_sysmsg,	@imd_venno,
	@imd_prdven,	@imd_rmk
)      
---------------------------------------------------------------------------------------------------------------------------------------------------------------------



GO
GRANT EXECUTE ON [dbo].[sp_IMCOMDAT] TO [ERPUSER] AS [dbo]
GO
