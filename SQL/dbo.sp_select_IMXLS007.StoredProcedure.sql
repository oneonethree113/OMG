/****** Object:  StoredProcedure [dbo].[sp_select_IMXLS007]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMXLS007]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMXLS007]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
















/*
=========================================================
Program ID	: 	sp_select_IMXLS007
Description   	: 	Validate Item Number Existence
Programmer  	: 	David Yue
=========================================================
 Modification History                                   
=========================================================

=========================================================     
*/

CREATE   PROCEDURE [dbo].[sp_select_IMXLS007]
@itr_itmno	nvarchar(30),
@itr_tmpitm	nvarchar(30)

AS

set nocount on

DECLARE
@sysmsg 	nvarchar(200)

set @sysmsg = ''

if (select count(*) from IMTMPREL (nolock) where itr_itmno = @itr_itmno and itr_tmpitm = @itr_tmpitm) > 0
begin
	set @sysmsg = @sysmsg + case @sysmsg when '' then '' else ', ' end + 'Items are already related'
end
else if (select count(*) from IMTMPREL (nolock) where itr_itmno = @itr_itmno and itr_tmpitm <> @itr_tmpitm) > 0
begin
	set @sysmsg = @sysmsg + case @sysmsg when '' then '' else ', ' end + 'Item No. is already related to a Temp Item No.'
end

if (select count(*) from IMBASINF (nolock) where ibi_itmno = @itr_itmno and ibi_ftytmp = 'N') = 0
begin
	if (select count(*) from IMBASINF (nolock) where ibi_itmno = @itr_itmno) > 0
		set @sysmsg = @sysmsg + case @sysmsg when '' then '' else ', ' end + 'Item No. is not a real number'
	else
		set @sysmsg = @sysmsg + case @sysmsg when '' then '' else ', ' end + 'Item No. does not exist'
end

if (select count(*) from IMBASINF (nolock) where ibi_itmno = @itr_tmpitm and ibi_ftytmp = 'Y') = 0
begin
	if (select count(*) from IMBASINF (nolock) where ibi_itmno = @itr_tmpitm) > 0
		set @sysmsg = @sysmsg + case @sysmsg when '' then '' else ', ' end + 'Temp Item No. is not a temp number'
	else
		set @sysmsg = @sysmsg + case @sysmsg when '' then '' else ', ' end + 'Temp Item No. does not exist'
end

create table #IMXLS007tmp
(	itmno	nvarchar(30),
	tmpitm	nvarchar(30),
	sysmsg	nvarchar(200)
)

insert into #IMXLS007tmp
values
(	@itr_itmno,
	@itr_tmpitm,
	@sysmsg
)

select	*
from	#IMXLS007tmp

drop table #IMXLS007tmp

set nocount off





GO
GRANT EXECUTE ON [dbo].[sp_select_IMXLS007] TO [ERPUSER] AS [dbo]
GO
