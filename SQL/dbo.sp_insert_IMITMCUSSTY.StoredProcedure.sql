/****** Object:  StoredProcedure [dbo].[sp_insert_IMITMCUSSTY]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMITMCUSSTY]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMITMCUSSTY]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Marco Chan
Date:		12th September, 2008
Description:	insert data into IMITMCUSSTY
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_IMITMCUSSTY]

@iic_cocde	nvarchar(6),
@iic_upload	datetime,
@iic_seq	int,
@iic_itmno	nvarchar(20),
@iic_cusno	nvarchar(6),
@iic_cusstyno	nvarchar(30),
@iic_filnam	nvarchar(200),
@iic_creusr	nvarchar(30)
 
AS

BEGIN

declare @custyp char(1)
declare @cus1no nvarchar(6)



--------------------------------------------------------------------------------------------------
declare @saltem nvarchar(6)
declare @sts char(1)
declare @sysmsg nvarchar(200)
declare @counter int
declare @iic_sts char(1)
declare	@iic_mode nvarchar(6)
declare	@iic_sysmsg nvarchar(200)
declare @debug int






-- 0. Check with Item Exist

select @counter = count(*) 
from IMBASINF
where ibi_itmno = @iic_itmno
if @counter > 0 
begin
	set @sts = 'W'  -- Wait for approval
end
else
begin
	set @sts = 'I'	-- Invalid
	set @sysmsg = '[E000] Item: ' + @iic_itmno + ' does not exist. ' 
end


-- 0a. Check with Customer Exist

if @sts = 'W'
begin
	select @counter = count(*) 
	from CUBASINF
	where cbi_cusno = @iic_cusno

	if @counter > 0 
	begin
		set @sts = 'W'  -- Wait for approval
	end
	else
	begin
		set @sts = 'I'	-- Invalid
		set @sysmsg = '[E004] Customer: ' + @iic_cusno + ' does not exist. ' 
	end
end


if @sts = 'W'
begin
	select @custyp = cbi_custyp 
	from CUBASINF
	where cbi_cusno = @iic_cusno

	if ltrim(rtrim(@custyp)) = 'p' 
	begin
		set @sts = 'W'  -- Wait for approval
	end
	else
	begin
		set @sts = 'I'	-- Invalid
		set @sysmsg = '[E006] Customer: ' + @iic_cusno + ' is not primary customer. ' 
	end
end

if @sts = 'W'
begin

	if left(ltrim(rtrim(@iic_cusno)),1) = '5' 
	begin
		set @sts = 'W'  -- Wait for approval
	end
	else
	begin
		set @sts = 'I'	-- Invalid
		set @sysmsg = '[E007] Customer no: ' + @iic_cusno + ' is not larger than 50000. ' 
	end
end


if @sts = 'W'
begin
set @saltem = ''
set @sts = ''
set @sysmsg = ''


create table #TEMP_SALTEM
(
tmp_saltem nvarchar(10)
)

-- 1. Check valid Sales Team
------------------------------------------------------------------------------------
insert into #TEMP_SALTEM
select isnull(yur_para, '') from SYUSRRIGHT where yur_usrid = @iic_creusr and yur_doctyp = 'QU' and yur_lvl = 1
--select @saltem = isnull(ysr_saltem, '') from SYSALREP where ysr_code = @iic_creusr

declare @saltemS int
set @saltemS = 0

select @saltemS = count(*) from #TEMP_SALTEM where tmp_saltem = 'S'

if (@iic_creusr = 'mis') or (@saltemS >= 1) -- full control for Cus Style
begin
	set @sts = 'W'  -- Wait for approval
end
else
begin
	select @counter = count(*) 
	from CUBASINF, SYSALREP,#TEMP_SALTEM 
	where cbi_salrep = ysr_code1 and cbi_cusno = @iic_cusno and ysr_saltem = tmp_saltem
	
	if @counter > 0 
	begin
		set @sts = 'W'  -- Wait for approval
	end
	else
	begin
		set @sts = 'I'	-- Invalid
		set @sysmsg = '[E001] User ID: ' + @iic_creusr + ' has no access for updating Cust. ' + @iic_cusno + ' Team (' + @saltem + ') information'
	end
end
end

--declare @custyp char(1)
--declare @cus1no nvarchar(6)
--declare @cus2no nvarchar(6)

-- 2. Check valid Data in SC and QU
------------------------------------------------------------------------------------
--select @custyp = isnull(cbi_custyp, '') from CUBASINF (nolock) where cbi_cusno = @iic_cusno
--if @custyp = 'S'
--begin
--	set @cus2no = @iic_cusno
--	select @cus1no = isnull(csc_prmcus, '') from CUSUBCUS (nolock) where csc_seccus = @iic_cusno
--end
--else
--begin
set @cus1no = @iic_cusno
--	set @cus2no = ''
--end

if @sts = 'W'
begin
	select @counter = count(*) from QUOTNHDR (nolock)
	left join QUOTNDTL (nolock) on qud_qutno = quh_qutno
	where quh_cus1no = @cus1no and qud_cusstyno = @iic_cusstyno and quh_qutsts <> 'E'  
	
	if @counter > 0 
	begin
		set @sts = 'I'	-- Invalid
		set @sysmsg = '[E002] Customer Style is used in valid Quotaiton'
	end
end

if @sts = 'W'
begin
	select @counter = count(*) from SCORDHDR (nolock)
	left join SCORDDTL (nolock) on sod_ordno = soh_ordno
	where soh_cus1no = @cus1no and sod_cusstyno = @iic_cusstyno and soh_ordsts not in ('CLO', 'CAN')

	if @counter > 0 
	begin
		set @sts = 'I'	-- Invalid
		set @sysmsg = '[E003] Customer Style is used in valid Sales Confirmation'
	end
end

-- 3. set Data mode
------------------------------------------------------------------------------------
if @sts = 'W'
begin
	select @counter = count(*) from IMCUSSTY (nolock)
	where ics_cusno = @iic_cusno and ics_cusstyno = @iic_cusstyno

	if @counter > 1
		set @iic_mode = 'UPD'
	else
		set @iic_mode = 'NEW'
end
else
begin
	set @iic_mode = 'NEW'
end


-- 4. Update for existing Wait for approval data to Old
------------------------------------------------------------------------------------

if @sts = 'W'
begin
	update IMITMCUSSTY set iic_sts = 'O' where iic_cusno = @iic_cusno and iic_cusstyno = @iic_cusstyno and iic_sts = 'W'
end


-- 5. Check Duplicate of record in same batch of upload
------------------------------------------------------------------------------------
if @sts = 'W'
begin

set @counter = 0

select @counter = count(*) from IMITMCUSSTY
where 
	iic_upload = @iic_upload and
	iic_cusno = @iic_cusno and
	iic_cusstyno = @iic_cusstyno

if @counter > 0 
begin
	set @sts = 'I'	-- Invalid
	set @sysmsg = '[E005] Duplicate Record Exist ' + @iic_cusno + ' ' + @iic_cusstyno

	Update	IMITMCUSSTY
	set
		iic_sts = 'I',
		iic_sysmsg = '[E005] Duplicate Record Exist ' + @iic_cusno + ' ' + iic_cusstyno
	where
		 iic_upload = @iic_upload and
		iic_cusno = @iic_cusno and
		iic_cusstyno = @iic_cusstyno and iic_sts <> 'I'		
end

end



insert into IMITMCUSSTY
(
	iic_upload,
	iic_seq,
	iic_itmno,
	iic_cusno,
	iic_cusstyno,
	iic_sts,
	iic_mode,
	iic_sysmsg,
	iic_filnam,
	iic_creusr,
	iic_updusr,
	iic_credat,
	iic_upddat
	)
values
(
	@iic_upload,
	@iic_seq,
	@iic_itmno,
	@iic_cusno,
	@iic_cusstyno,
	@sts,
	@iic_mode,
	@sysmsg,
	@iic_filnam,
	@iic_creusr,
	@iic_creusr,

	getdate(),
	getdate()
	)




END





GO
GRANT EXECUTE ON [dbo].[sp_insert_IMITMCUSSTY] TO [ERPUSER] AS [dbo]
GO
