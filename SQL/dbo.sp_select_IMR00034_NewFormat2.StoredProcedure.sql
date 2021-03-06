/****** Object:  StoredProcedure [dbo].[sp_select_IMR00034_NewFormat2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00034_NewFormat2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00034_NewFormat2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






















/*
=========================================================
Program ID	: 	sp_select_IMR00034_NewFormat2
Description   	: 	Retrieve IM Report Inquiry Entries
Programmer  	: 	David Yue
Date Created	:	2013-08-01
=========================================================
 Modification History                                    
=========================================================
2013-08-01	David Yue	SP Created
=========================================================     
*/

CREATE             PROCEDURE [dbo].[sp_select_IMR00034_NewFormat2]
@cocde		varchar(6),	@itmnolist	varchar(1000),	@cus1nolist	varchar(1000),
@cus2nolist	varchar(1000),	@dvlist		varchar(1000),	@itmUpddatFm	varchar(16),
@itmUpddatTo	varchar(16),	@prcCredatFm	varchar(16),	@prcCredatTo	varchar(16),
@prcUpddatFm	varchar(16),	@prcUpddatTo	varchar(16),	@itmsts		varchar(4),
@period		varchar(9),@NotConvertPC		varchar(4),
@usrid		varchar(30)

AS

set nocount on
declare
@i 		int,		@start 		varchar(20),	@end 		nvarchar(20),
@value		varchar(20),	@condition 	varchar(3000),	@itmnoqry	varchar(2000),
@cus1qry 	varchar(2000),	@cus2qry 	varchar(2000),	@dvqry		varchar(2000),
@itmUpddatQry	varchar(140),	@prcCredatQry	varchar(140),	@prcUpddatQry	varchar(140),
@itmstsqry	varchar(100)

declare	-- Light Spec
@ls_itmno	nvarchar(30),	@ls_cus1no	nvarchar(6),	@ls_cus2no	nvarchar(6),
@ls_pckunt	nvarchar(6),	@ls_inrqty	int,		@ls_mtrqty	int,
@ls_conftr	int,		@ls_hkprctrm	nvarchar(10),	@ls_trantrm	nvarchar(10)

declare -- Temp No. / Asst Items
@ta_itmno	nvarchar(30),	@ta_typ		nvarchar(4),	@ta_cus1no	nvarchar(6),
@ta_cus2no	nvarchar(6),	@ta_pckunt	nvarchar(6),	@ta_inrqty	int,
@ta_mtrqty	int,		@ta_conftr	int,		@ta_hkprctrm	nvarchar(10),
@ta_trantrm	nvarchar(10)

declare
@bom_itmno	nvarchar(30),	@bom_bomqty	int,		@bom_pckunt	nvarchar(6),
@ass_itmno	nvarchar(30),	@ass_inrqty	int,		@ass_mtrqty	int,
@ass_pckunt	nvarchar(6)

declare
@ibi_chndsc	nvarchar(800),	@lightspec	nvarchar(2000),	@spacing	nvarchar(20),
@tempasst	nvarchar(300)

set @itmnoqry = ''
set @cus1qry = ''
set @cus2qry = ''
set @dvqry = ''
set @itmUpddatQry = ''
set @prcCredatQry = ''
set @prcUpddatQry = ''
set @itmstsqry = ''
set @condition = ''

set @lightspec = ''
set @spacing = '
'

create table ##temptable
(
cat nvarchar(20),
ibi_rmk nvarchar(300),
input_date datetime,
imu_cus1no varchar(6),
imu_cus2no varchar(6),
temp_asst varchar(300),
vbi_venno nvarchar(6),
vbi_vensna nvarchar(40),
imu_orgum nvarchar(6),
imu_period varchar(7),
imu_expdat varchar(10),
imu_itmno nvarchar(20),
icf_vencol nvarchar(30),
ibi_engdsc varchar(800),
imu_pckunt nvarchar(6),
imu_inrqty int,
imu_mtrqty int,
imu_cft numeric(13,4),
imu_conftr int,
imu_curcde nvarchar(4),
imu_ftycstA numeric(13,4),
imu_ftycstB numeric(13,4),
imu_ftycstC numeric(13,4),
imu_ftycstD numeric(13,4),
imu_ftycstE numeric(13,4),
imu_ftycstTran numeric(13,4),
imu_ftycstPack numeric(13,4),
imu_ftycst numeric(13,4),
ipi_pckitr nvarchar(300),
ipi_inrdin numeric(13,4),
ipi_inrwin numeric(13,4),
ipi_inrhin numeric(13,4),
ipi_mtrdin numeric(13,4),
ipi_mtrwin numeric(13,4),
ipi_mtrhin numeric(13,4),
ipi_inrsze nvarchar(300),
ipi_mtrsze nvarchar(300),
light_spec nvarchar(2000),
fty_mu varchar(10),
imu_ftyprc numeric(13,4),
hk_mu varchar(10),
imu_basprc numeric(13,4),
imu_hkprctrm nvarchar(10),
imu_trantrm nvarchar(10),
ibi_typ nvarchar(4)
)
begin-- condition analysis
	-- Process Item Number Query --
	if ltrim(rtrim(@itmnolist)) <> ''
	begin 
		set @itmnoqry = ''
		set @i = 0
	
		while charindex(',',@itmnolist) <> 0
		begin
			set @i = charindex(',',@itmnolist)
			if @i = 0 and charindex(@itmnolist,@itmnoqry) = 0
				set @i = len(@itmnolist)
			set @value = substring(@itmnolist, 0, @i)
			set @itmnolist = substring(@itmnolist,@i+1,len(@itmnolist)-@i)
			if ltrim(rtrim(@value)) <> ''
			begin
				if charindex('~',@value) > 0
				begin
					set @i = charindex('~',@value)
					set @start = substring(@value, 0, @i)
					set @end = substring(@value, @i+1,len(@value))
					set @itmnoqry = @itmnoqry + case len(@itmnoqry) when 0 then '' else ' or imu_itmno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @itmnoqry = @itmnoqry + case len(@itmnoqry) when 0 then '' else ' or imu_itmno ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@itmnolist, @itmnoqry) = 0
		begin
			if charindex('~',@itmnolist) > 0
			begin
				set @i = charindex('~',@itmnolist)
				set @start = substring(@itmnolist, 0, @i)
				set @end = substring(@itmnolist, @i+1,len(@itmnolist))
				set @itmnoqry = @itmnoqry + case len(@itmnoqry) when 0 then '' else ' or imu_itmno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @itmnoqry = @itmnoqry + case len(@itmnoqry) when 0 then '' else ' or imu_itmno ' end + '= ''' + @itmnolist + ''''
			end
		end
	
		set @itmnoqry = ' ( imu_itmno ' + @itmnoqry + ' ) '
	end -- if ltrim(rtrim(@itmnolist)) <> ''

	-- Process Primary Customer Query --
	if ltrim(rtrim(@cus1nolist)) <> ''
	begin
		set @cus1qry = ''
		set @i = 0
	
		while charindex(',',@cus1nolist) <> 0
		begin
			set @i = charindex(',',@cus1nolist)
			if @i = 0 and charindex(@cus1nolist,@cus1qry) = 0
				set @i = len(@cus1nolist)
			set @value = substring(@cus1nolist, 0, @i)
			set @cus1nolist = substring(@cus1nolist,@i+1,len(@cus1nolist)-@i)
			if ltrim(rtrim(@value)) <> ''
			begin
				if charindex('~',@value) > 0
				begin
					set @i = charindex('~',@value)
					set @start = substring(@value, 0, @i)
					set @end = substring(@value, @i+1,len(@value))
					set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or imu_cus1no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or imu_cus1no ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@cus1nolist, @cus1qry) = 0
		begin
			if charindex('~',@cus1nolist) > 0
			begin
				set @i = charindex('~',@cus1nolist)
				set @start = substring(@cus1nolist, 0, @i)
				set @end = substring(@cus1nolist, @i+1,len(@cus1nolist))
				set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or imu_cus1no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or imu_cus1no ' end + '= ''' + @cus1nolist + ''''
			end
		end
	
		set @cus1qry = 'imu_cus1no ' + @cus1qry
	end -- if ltrim(rtrim(@cus1nolist)) <> ''

	-- Process Secondary Customer Query --
	if ltrim(rtrim(@cus2nolist)) <> ''
	begin
		set @cus2qry = ''
		set @i = 0
	
		while charindex(',',@cus2nolist) <> 0
		begin
			set @i = charindex(',',@cus2nolist)
			if @i = 0 and charindex(@cus2nolist,@cus1qry) = 0
				set @i = len(@cus2nolist)
			set @value = substring(@cus2nolist, 0, @i)
			set @cus2nolist = substring(@cus2nolist,@i+1,len(@cus2nolist)-@i)
			if ltrim(rtrim(@value)) <> ''
			begin
				if charindex('~',@value) > 0
				begin
					set @i = charindex('~',@value)
					set @start = substring(@value, 0, @i)
					set @end = substring(@value, @i+1,len(@value))
					set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or imu_cus2no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or imu_cus2no ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@cus2nolist, @cus2qry) = 0
		begin
			if charindex('~',@cus2nolist) > 0
			begin
				set @i = charindex('~',@cus2nolist)
				set @start = substring(@cus2nolist, 0, @i)
				set @end = substring(@cus2nolist, @i+1,len(@cus2nolist))
				set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or imu_cus2no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or imu_cus2no ' end + '= ''' + @cus2nolist + ''''
			end
		end
	
		set @cus2qry = 'imu_cus2no ' + @cus2qry
	end -- if ltrim(rtrim(@cus2nolist)) <> ''

	-- Process Design Vendor Query --
	if ltrim(rtrim(@dvlist)) <> ''
	begin
		set @dvqry = ''
		set @i = 0
	
		while charindex(',',@dvlist) <> 0
		begin
			set @i = charindex(',',@dvlist)
			if @i = 0 and charindex(@dvlist,@dvqry) = 0
				set @i = len(@dvlist)
			set @value = substring(@dvlist, 0, @i)
			set @dvlist = substring(@dvlist,@i+1,len(@dvlist)-@i)
			if ltrim(rtrim(@value)) <> ''
			begin
				if charindex('~',@value) > 0
				begin
					set @i = charindex('~',@value)
					set @start = substring(@value, 0, @i)
					set @end = substring(@value, @i+1,len(@value))
					set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or imu_venno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or imu_venno ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@dvlist, @dvqry) = 0
		begin
			if charindex('~',@dvlist) > 0
			begin
				set @i = charindex('~',@dvlist)
				set @start = substring(@dvlist, 0, @i)
				set @end = substring(@dvlist, @i+1,len(@dvlist))
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or imu_venno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or imu_venno ' end + '= ''' + @dvlist + ''''
			end
		end
	
		set @dvqry = 'imu_venno ' + @dvqry
	end -- if ltrim(rtrim(@dvlist)) <> ''

	-- Process Upload Date Query --
	if @itmUpddatFm <> '' and @itmUpddatTo <> ''
	begin
		set @itmUpddatQry = 'imu_itmno in (select distinct ibi_itmno from IMBASINF (nolock) where ibi_upddat between ''' + @itmUpddatFm + ''' and ''' + @itmUpddatTo + ''')'
	end -- if @itmUpddatFm <> '' and @itmUpddatTo <> ''

	-- Process Approve Date Query --
	if @prcCredatFm <> '' and @prcCredatTo <> ''
	begin
		set @prcCredatQry = 'imu_credat between ''' + @prcCredatFm + ''' and ''' + @prcCredatTo + ''''
	end -- if @prcCredatFm <> '' and @prcCredatTo <> ''

	-- Process Update Date Query --
	if @prcUpddatFm <> '' and @prcUpddatTo <> ''
	begin
		set @prcUpddatQry = 'imu_upddat between ''' + @prcUpddatFm + ''' and ''' + @prcUpddatTo + ''''
	end -- if @prcUpddatFm <> '' and @prcUpddatTo <> ''

	-- Process Item Status Query --
	if @itmsts <> ''
	begin
		set @itmstsqry = 'imu_itmno in (select distinct ibi_itmno from IMBASINF (nolock) where ibi_itmsts = ''' + @itmsts + ''')'
	end -- if @prcUpddatFm <> '' and @prcUpddatTo <> ''

	--Convert to PC--
	create table #pckunit(
	pkimu_itmno nvarchar(20),
	NotConvertPC nvarchar(1))

	insert into #pckunit(
	pkimu_itmno,
	NotConvertPC )
	select distinct	imu_itmno,
	case  imu_typ when 'ASS' then @NotConvertPC else 'N' end 
	from	IMPRCINF (nolock)

	-- Concatenate Query Statement --
	if @itmnoqry <> ''
	begin
		set @condition = @itmnoqry
	end

	if @cus1qry <> ''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '(' else ' and (' end + @cus1qry + ')'
	end

	if @cus2qry <> ''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '(' else ' and (' end + @cus2qry + ')'
	end

	if @dvqry <> ''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '(' else ' and (' end + @dvqry + ')'
	end

	if @itmUpddatQry <> ''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '' else ' and ' end + @itmUpddatQry
	end

	if @prcCredatQry <> ''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '' else ' and ' end + @prcCredatQry
	end

	if @prcUpddatQry <> ''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '' else ' and ' end + @prcUpddatQry
	end

	if @itmstsqry <> ''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '' else ' and ' end + @itmstsqry
	end
	if @period <> ''''''
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '' else ' and left(convert(varchar(20),ipi_qutdat,121),7)=' + @period end 
	end
	--to show the record with DV=PV only. If the item have no record PV=DV, show all the others
	begin
		set @condition = @condition + case (len(@condition)) when 0 then '' else ' and (IMU_VENNO=IMU_PRDVEN  )' end 
	end
end
declare @header varchar(5000)

-- Editted by David Yue 2012-12-17 on Anita Leung's Request --
-- Conversion Factor will query SYCONFTR for conftr value when item type is not ASS --

set @header = 'insert into ##temptable
(	cat, ibi_rmk, input_date, imu_cus1no, imu_cus2no, temp_asst, vbi_venno, vbi_vensna,
	imu_orgum, imu_period, imu_expdat, imu_itmno, icf_vencol, ibi_engdsc, imu_pckunt,
	imu_inrqty, imu_mtrqty, imu_cft, imu_conftr, imu_curcde, imu_ftycstA, imu_ftycstB,
	imu_ftycstC, imu_ftycstD, imu_ftycstE, imu_ftycstTran, imu_ftycstPack, imu_ftycst, ipi_pckitr,
	ipi_inrdin, ipi_inrwin, ipi_inrhin, ipi_mtrdin, ipi_mtrwin, ipi_mtrhin,
	ipi_inrsze, ipi_mtrsze, light_spec, fty_mu, imu_ftyprc, hk_mu, imu_basprc,
	imu_hkprctrm, imu_trantrm, ibi_typ
)
select	distinct '' '' as ''cat'',
	ibi_rmk,
	convert(datetime,getdate(),120) as ''input_date'',
	imu_cus1no,
	imu_cus2no,
	'' '' as ''temp_asst'',
	vbi_venno,
	vbi_vensna,
	 case imu_pckunt when ''ST'' then imu_pckunt + cast(imu_conftr as varchar(6)) else imu_pckunt end as ''imu_orgum'',
	left(convert(varchar(20),ipi_qutdat,121),7) as ''imu_period'',
	convert(nvarchar(10),imu_expdat,120),
	imu_itmno,
	icf_vencol,
	ibi_engdsc,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then ''PC'' else imu_pckunt end else imu_pckunt end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_inrqty * imu_conftr else imu_inrqty end else imu_inrqty end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_mtrqty * imu_conftr else imu_mtrqty end else imu_mtrqty end,
	--imu_cft,
	ipi_cft as imu_cft,
	case NotConvertPC when ''N'' then case imu_typ when ''ASS'' then 1 else isnull((select ycf_value from SYCONFTR (nolock) where ycf_code1 = imu_pckunt and ycf_code2 = ''PC''), 0) end else imu_conftr end as ''imu_conftr'',
	imu_curcde,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycstA / imu_conftr else imu_ftycstA end else imu_ftycstA end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycstB / imu_conftr else imu_ftycstB end else imu_ftycstB end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycstC / imu_conftr else imu_ftycstC end else imu_ftycstC end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycstD / imu_conftr else imu_ftycstD end else imu_ftycstD end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycstE / imu_conftr else imu_ftycstE end else imu_ftycstE end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycstTran / imu_conftr else imu_ftycstTran end else imu_ftycstTran end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycstPack / imu_conftr else imu_ftycstPack end else imu_ftycstPack end,
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftycst / imu_conftr else imu_ftycst end else imu_ftycst end,
	ipi_pckitr,
	ipi_inrdin,
	ipi_inrwin,
	ipi_inrhin,
	ipi_mtrdin,
	ipi_mtrwin,
	ipi_mtrhin,
	isnull(ipi_inrsze,''''),
	isnull(ipi_mtrsze,''''),
	'' '' as ''light_spec'',
	case imu_ftycst when 0 then 0 else cast(imu_ftyprc/imu_ftycst as numeric(13,4)) end as ''fty_mu'',
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_ftyprc / imu_conftr else imu_ftyprc end else imu_ftyprc end,
	substring(yfi_fml,2,len(yfi_fml)-1) as ''hk_mu'',
	case NotConvertPC when ''N'' then case imu_pckunt when ''ST'' then imu_basprc / imu_conftr else imu_basprc end else imu_basprc end,
	imu_hkprctrm,
	imu_trantrm,
	ibi_typ
from	IMPRCINF (nolock)
	left join #pckunit (nolock) on pkimu_itmno = imu_itmno
	left join IMBASINF (nolock) on ibi_itmno = imu_itmno
	left join IMPCKINF (nolock) on ipi_itmno = imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty and ipi_conftr = imu_conftr and ipi_cus1no = imu_cus1no and ipi_cus2no = imu_cus2no
	left join SYFMLINF (nolock) on yfi_fmlopt = imu_fmlopt
	left join VNBASINF (nolock) on vbi_venno = imu_venno
	left join IMCOLINF (nolock) on icf_itmno = imu_itmno
'
declare @sql varchar(8000)
set @sql = @header + case (len(@condition)) when 0 then '' else 'where ' + @condition end
print @sql

exec(@sql)
---------------------
--select '##temptable'
----select * from ##temptable
--set @header = '
--select	distinct *
--from	IMPRCINF (nolock)
--	left join #pckunit (nolock) on pkimu_itmno = imu_itmno
--	left join IMBASINF (nolock) on ibi_itmno = imu_itmno
--	left join IMPCKINF (nolock) on ipi_itmno = imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty and ipi_conftr = imu_conftr and ipi_cus1no = imu_cus1no and ipi_cus2no = imu_cus2no
--	left join SYFMLINF (nolock) on yfi_fmlopt = imu_fmlopt
--	left join VNBASINF (nolock) on vbi_venno = imu_venno
--	left join IMCOLINF (nolock) on icf_itmno = imu_itmno
--'
--declare @sql2 varchar(8000)
--set @sql2 = @header-- + case (len(@condition)) when 0 then '' else 'where ' + @condition end
--print @sql2

--select '@sql2'
--exec(@sql2)

--set @header = '
--select	count ( *)
--from	IMPRCINF (nolock)
--	left join #pckunit (nolock) on pkimu_itmno = imu_itmno
--	left join IMBASINF (nolock) on ibi_itmno = imu_itmno
--	left join IMPCKINF (nolock) on ipi_itmno = imu_itmno and ipi_pckunt = imu_pckunt and ipi_inrqty = imu_inrqty and ipi_mtrqty = imu_mtrqty and ipi_conftr = imu_conftr and ipi_cus1no = imu_cus1no and ipi_cus2no = imu_cus2no
--	left join SYFMLINF (nolock) on yfi_fmlopt = imu_fmlopt
--	left join VNBASINF (nolock) on vbi_venno = imu_venno
--	left join IMCOLINF (nolock) on icf_itmno = imu_itmno
--'
--declare @sql3 varchar(8000)
--set @sql3 = @header-- + case (len(@condition)) when 0 then '' else 'where ' + @condition end
--print @sql3

--select '@sql3'
--exec(@sql3)
-----------------------
-- Retrieve Temp No/ Asst Items for Table --
DECLARE ta_items CURSOR
FOR	select	imu_itmno,	ibi_typ,	imu_cus1no,
		imu_cus2no,	imu_pckunt,	imu_inrqty,
		imu_mtrqty,	imu_conftr,	imu_hkprctrm,
		imu_trantrm
	from	##temptable

OPEN ta_items
FETCH NEXT FROM ta_items INTO
@ta_itmno,	@ta_typ,	@ta_cus1no,
@ta_cus2no,	@ta_pckunt,	@ta_inrqty,
@ta_mtrqty,	@ta_conftr,	@ta_hkprctrm,
@ta_trantrm

WHILE @@FETCH_STATUS = 0
BEGIN
	set @tempasst = ''
	
	if @ta_typ <> 'ASS'
	begin
		select	@tempasst = isnull(itr_tmpitm,'')
		from	IMTMPREL (nolock)
		where	itr_itmno = @ta_itmno
	end
	else -- @ta_typ = 'ASS'
	begin
		DECLARE ass_items CURSOR
		FOR	select	iba_assitm,
				iba_inrqty,
				iba_mtrqty,
				iba_pckunt
		from	IMBOMASS (nolock)
		where	iba_typ = 'ASS' and
			iba_itmno = @ta_itmno
		
		OPEN ass_items
		FETCH NEXT FROM ass_items INTO
		@ass_itmno,	@ass_inrqty,	@ass_mtrqty,
		@ass_pckunt

		WHILE @@FETCH_STATUS = 0
		BEGIN
			if @ass_inrqty = null or @ass_inrqty = 0
			begin
				set @tempasst = @tempasst + case len(@tempasst) when 0 then '' else @spacing end + @ass_itmno + ' x' + cast(@ass_mtrqty as nvarchar(3)) + ' ' + @ass_pckunt
			end
			else
			begin
				set @tempasst = @tempasst + case len(@tempasst) when 0 then '' else @spacing end + @ass_itmno + ' x' + cast(@ass_inrqty as nvarchar(3)) + ' ' + @ass_pckunt
			end
			
			FETCH NEXT FROM ass_items INTO
			@ass_itmno,	@ass_inrqty,	@ass_mtrqty,
			@ass_pckunt
		END
		CLOSE ass_items
		DEALLOCATE ass_items
	end
	
	-- Update Light Spec to Temp Table
	update	##temptable
	set	temp_asst = @tempasst
	where	imu_itmno = @ta_itmno and
		imu_cus1no = @ta_cus1no and
		imu_cus2no = @ta_cus2no and
		imu_pckunt = @ta_pckunt and
		imu_inrqty = @ta_inrqty and
		imu_mtrqty = @ta_mtrqty and
		imu_conftr = @ta_conftr and
		imu_hkprctrm = @ta_hkprctrm and
		imu_trantrm = @ta_trantrm

	FETCH NEXT FROM ta_items INTO
	@ta_itmno,	@ta_typ,	@ta_cus1no,
	@ta_cus2no,	@ta_pckunt,	@ta_inrqty,
	@ta_mtrqty,	@ta_conftr,	@ta_hkprctrm,
	@ta_trantrm
END
CLOSE ta_items
DEALLOCATE ta_items

-- Retrieve Light Spec Data for Table --
DECLARE ls_items CURSOR
FOR	select	imu_itmno,	imu_cus1no,	imu_cus2no,
		imu_pckunt,	imu_inrqty,	imu_mtrqty,
		imu_conftr,	imu_hkprctrm,	imu_trantrm
	from	##temptable

OPEN ls_items
FETCH NEXT FROM ls_items INTO
@ls_itmno,	@ls_cus1no,	@ls_cus2no,
@ls_pckunt,	@ls_inrqty,	@ls_mtrqty,
@ls_conftr,	@ls_hkprctrm,	@ls_trantrm

WHILE @@FETCH_STATUS = 0
BEGIN
	set @lightspec = ''

	DECLARE bom_items CURSOR
	FOR	select	iba_assitm,
			iba_bomqty,
			iba_pckunt
		from	IMBOMASS (nolock)
		where	iba_typ = 'BOM' and
			iba_itmno = @ls_itmno
	OPEN bom_items
	FETCH NEXT FROM bom_items INTO
	@bom_itmno,	@bom_bomqty,	@bom_pckunt

	WHILE @@FETCH_STATUS = 0
	BEGIN
		select	@ibi_chndsc = ibi_chndsc
		from	IMBASINF (nolock)
		where	ibi_itmno = @bom_itmno

		set @lightspec = case len(@lightspec) when 0 then '' else @lightspec + @spacing end + @ibi_chndsc + ' x' + cast(@bom_bomqty as nvarchar(3)) + ' ' + @bom_pckunt
		
		FETCH NEXT FROM bom_items INTO
		@bom_itmno,	@bom_bomqty,	@bom_pckunt
	END
	CLOSE bom_items
	DEALLOCATE bom_items
	
	-- Update Light Spec to Temp Table
	update	##temptable
	set	light_spec = @lightspec
	where	imu_itmno = @ls_itmno and
		imu_cus1no = @ls_cus1no and
		imu_cus2no = @ls_cus2no and
		imu_pckunt = @ls_pckunt and
		imu_inrqty = @ls_inrqty and
		imu_mtrqty = @ls_mtrqty and
		imu_conftr = @ls_conftr and
		imu_hkprctrm = @ls_hkprctrm and
		imu_trantrm = @ls_trantrm
	
	FETCH NEXT FROM ls_items INTO
	@ls_itmno,	@ls_cus1no,	@ls_cus2no,
	@ls_pckunt,	@ls_inrqty,	@ls_mtrqty,
	@ls_conftr,	@ls_hkprctrm,	@ls_trantrm
END
CLOSE ls_items
DEALLOCATE ls_items

select 
	cat,		ibi_rmk,	input_date,
	imu_cus1no,	imu_cus2no,	temp_asst,
	vbi_venno,	vbi_vensna,	imu_orgum,
	imu_period,	imu_expdat,	imu_itmno,
	icf_vencol,	ibi_engdsc,	imu_pckunt,
	imu_inrqty,	imu_mtrqty,	
	CASE  isnumeric(imu_cft)
  WHEN  1  THEN imu_cft
  ELSE '0.0'
  END as 'imu_cft',
	imu_conftr,	imu_curcde,	imu_ftycstA,
	imu_ftycstB,	imu_ftycstC,	imu_ftycstD,	imu_ftycstE,
	imu_ftycstTran,	imu_ftycstPack,	imu_ftycst,
	ipi_pckitr,	
	CASE  isnumeric(ipi_inrdin)
  WHEN  1  THEN ipi_inrdin
  ELSE '0.0'
  END as 'ipi_inrdin',
	CASE  isnumeric(ipi_inrwin)
  WHEN  1  THEN ipi_inrwin
  ELSE '0.0'
  END as 'ipi_inrwin',
	CASE  isnumeric(ipi_inrhin)
  WHEN  1  THEN ipi_inrhin
  ELSE '0.0'
  END as 'ipi_inrhin',
		
	CASE  isnumeric(ipi_mtrdin)
  WHEN  1  THEN ipi_mtrdin
  ELSE '0.0'
  END as 'ipi_mtrdin',

	CASE  isnumeric(ipi_mtrwin)
  WHEN  1  THEN ipi_mtrwin
  ELSE '0.0'
  END as 'ipi_mtrwin',

	CASE  isnumeric(ipi_mtrhin)
  WHEN  1  THEN ipi_mtrhin
  ELSE '0.0'
  END as 'ipi_mtrhin',
	
	
		ipi_inrsze,	ipi_mtrsze,
	light_spec,	fty_mu,		imu_ftyprc,
	hk_mu,		imu_basprc,	imu_hkprctrm,
	imu_trantrm
from ##temptable
--select distinct * from ##temptable
drop table ##temptable
drop table #pckunit
set nocount off

























GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00034_NewFormat2] TO [ERPUSER] AS [dbo]
GO
