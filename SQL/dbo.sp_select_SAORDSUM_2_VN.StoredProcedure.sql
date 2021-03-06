/****** Object:  StoredProcedure [dbo].[sp_select_SAORDSUM_2_VN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAORDSUM_2_VN]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAORDSUM_2_VN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Kenny Chan
Date:		6th FEB, 2002
Description:	Select data From SAORDSUM
Parameter:	1. Company
		2. QU No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SAORDSUM_2_VN]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sas_cocde 	nvarchar(6) ,
@sas_cus1no 	nvarchar(6),
@itmnolist nvarchar(1000),
@sas_colcde	nvarchar(30),
@sas_upddat	nvarchar(10),
@creusr	nvarchar(30),
@itmnovenno nvarchar(20)
---------------------------------------------- 
 
AS
begin


create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]

declare	@fm nvarchar(100), @to nvarchar(100)

declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''



--#TEMP_ITMNO
if ltrim(rtrim(@itmnolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @itmnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select qud_itmnoven from quotndtl   (nolock) where qud_itmnoven between @fm and @to
			 
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select qud_itmnoven from quotndtl   (nolock) where qud_itmnoven like @strPart
			 
		end
		else
		begin
			insert into #TEMP_INIT values (@strPart)
		end
	end
	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)
		if charindex('~', @strRemain) <> 0 
		begin
			set @fm = ltrim(left(@strRemain, charindex('~', @strRemain)-1))
			set @to = right(@strRemain, len(@strRemain) - charindex('~', @strRemain))
			insert into #TEMP_INIT
			select qud_itmnoven from quotndtl   (nolock) where qud_itmnoven between @fm and @to
			 
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select qud_itmnoven from quotndtl   (nolock) where qud_itmnoven like @strRemain
			 
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_ITMNO
	select distinct tmp_init from #TEMP_INIT
end





Select 

sas_cocde, --0
sas_cus1no, --1
sas_cus1na, --2
--************************************
sas_cus1no + ' - ' + sas_cus1na as 'sas_Pri', --3
--************************************
sas_itmno, --4
sas_colcde, --5
sas_itmdsc, --6
sas_smpunt, 
sas_smpqty, --7
sas_stkqty, --8
sas_cusqty, --9
sas_shpqty, --10
cast(sas_cusqty as int) - cast(sas_shpqty as int) as 'sas_outqty', --11
sas_shpchgqty, --12
sas_shpfreqty, --13
sas_freqty, --14
sas_creusr, --15
sas_updusr, --16
sas_credat, --17
sas_upddat, --18
cast(sas_timstp as int) as 'sas_timstp' , --19
sas_itmnotmp, --20
sas_itmnoven, --21
sas_itmnovenno --22


 from saordsum (nolock) where 
sas_cocde = @sas_cocde and
sas_cus1no in 
(select cbi_cusno from cubasinf (nolock) where cbi_cusno = @sas_cus1no or cbi_cusali = @sas_cus1no
 union
 select cbi_cusali from cubasinf (nolock) where cbi_cusno = @sas_cus1no)
and
 sas_itmnovenno = @itmnovenno and
--sas_itmno in 
--(Select ibi_itmno  from imbasinf (nolock) where ibi_itmno = @sas_itmno or ibi_alsitmno = @sas_itmno
--union
--select ibi_alsitmno from imbasinf (nolock) where ibi_itmno = @sas_itmno   ) 
--and 
sas_itmnoven in
(Select tmp_itmno from #TEMP_ITMNO (nolock))
and
sas_colcde between 	(case @sas_colcde when '' then '' 
			 else @sas_colcde end)		and
	(case @sas_colcde when '' then 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ' 
		 else @sas_colcde end)	and
sas_upddat	 between 	(case @sas_upddat when '' then '1900/01/01' 
			 else @sas_upddat + ' 0:0:00'  end)
		and
		(case @sas_upddat when '' then '2099/12/31' 
		 else @sas_upddat + ' 23:59:59' end) 

order by 
sas_upddat desc,
sas_itmno,
sas_colcde


drop table #TEMP_INIT 
drop table #TEMP_ITMNO  


end






GO
GRANT EXECUTE ON [dbo].[sp_select_SAORDSUM_2_VN] TO [ERPUSER] AS [dbo]
GO
