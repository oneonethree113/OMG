/****** Object:  StoredProcedure [dbo].[sp_select_ITEMNO_UCPP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_ITEMNO_UCPP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ITEMNO_UCPP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject, disable company code
*/


CREATE procedure [dbo].[sp_select_ITEMNO_UCPP]  

@ibi_cocde	nvarchar(6), 
@ibi_venno	nvarchar(6), 
@ibi_lnecde	nvarchar(10)

AS
declare @Year  nvarchar(2), @no nvarchar(5)
SET @Year = (Select right(Year(Getdate()),2))

begin

select @no = 
case when a.itmno>b.itmno then a.itmno 
else b.itmno
end + 1
--as 'Max_itmno'
from
(
Select isnull(Max(cast(right(ibi_itmno,5) as int)),0)  as 'itmno' 
from imbasinf 
where 
--	ibi_cocde = @ibi_cocde and
	ibi_venno = @ibi_venno and
	ibi_lnecde = @ibi_lnecde and
	left(ibi_itmno,2) = @Year and
	ibi_credat > '2010-01-01'
)a, 
(Select isnull(Max(cast(right(ibi_itmno,5) as int)),0)  as 'itmno' 
from imbasinfh 
where 
--	ibi_cocde = @ibi_cocde and
	ibi_venno = @ibi_venno and
	ibi_lnecde = @ibi_lnecde and
	left(ibi_itmno,2) = @Year and
	ibi_credat > '2010-01-01'

)b
end

if len(@no) = 1 
begin
       set @no = '0000'+@no
end
if len(@no) = 2
begin
       set @no = '000'+@no
end
if len(@no) = 3
begin
       set  @no = '00'+@no
end
if len(@no) = 4
begin
       set  @no = '0'+@no
end

Select @year+@ibi_venno+@ibi_lnecde+'-'+@no as 'Itemno'

GO
GRANT EXECUTE ON [dbo].[sp_select_ITEMNO_UCPP] TO [ERPUSER] AS [dbo]
GO
