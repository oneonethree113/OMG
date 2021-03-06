/****** Object:  StoredProcedure [dbo].[sp_list_FYPRTFYO_EDI]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_FYPRTFYO_EDI]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_FYPRTFYO_EDI]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



--sp_list_FYPRTFYO_EDI  'MS','MEDI'
--exec sp_general '㊣FYPRTFYO_EDI※L※MS※MSI', '', '', '', ''

CREATE PROCEDURE [dbo].[sp_list_FYPRTFYO_EDI] 

@fpf_cocde varchar(6),
@fpf_ftycde varchar(10)

AS

BEGIN

Declare @count as int
Declare @result as varchar(10)

SELECT  
	@count= left(right(max(ltrim(rtrim(fpf_filnam))),6),2) + 1

FROM             
	FYPRTFYO
where  
	fpf_ftycde = @fpf_ftycde and
	convert(varchar(10),fpf_credat,111)  = convert(varchar(10),getdate(),111)  and
	fpf_filnam like '%_EDI_%'

group by 
	fpf_ftycde,
	convert(varchar(10),fpf_credat,111) 
	


set @count = isnull(@count,1)

if @count < 10 
	set @result =  '0' + ltrim(rtrim(str(@count ))) 
else
	set @result =  ltrim(rtrim(str(@count ))) 
select @result as 'SEQ'

END


GO
GRANT EXECUTE ON [dbo].[sp_list_FYPRTFYO_EDI] TO [ERPUSER] AS [dbo]
GO
