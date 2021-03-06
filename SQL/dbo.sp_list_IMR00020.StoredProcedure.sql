/****** Object:  StoredProcedure [dbo].[sp_list_IMR00020]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00020]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00020]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/*
=========================================================
Program ID	: sp_list_IMR00020
Description   	: To retrive item which was over cost expire date
Programmer  	: Allan Yuen
ALTER   Date	: 2006/03/10
Table Read(s) 	:I
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/


--sp_list_IMR00020 '','','','12/31/2006'

--select * from 

CREATE  PROCEDURE [dbo].[sp_list_IMR00020]

@ibi_cocde as nvarchar(6) = ' ',
@prdVenNoFm as nvarchar(6),
@prdVenNoTo as nvarchar(6),
@cstexpdate as datetime,
@cstexpdateto as datetime
as

declare @compName varchar(100)
select @compName = yco_conam from SYCOMINF(nolock) where yco_cocde = @ibi_cocde
if @ibi_cocde<>'MS' 
begin
	set @compName = 'UNITED CHINESE GROUP'
end
----------------------------------------------------------------------------

select 
	@prdVenNoFm as 'DVFm',
	@prdVenNoTo as 'DVTo',
	@cstexpdate as 'cstexpdate',
	@cstexpdateto as 'cstexpdateto',
	ibi_itmno, 
	ibi_engdsc,
	ibi_venno + ' - ' + vbi_vensna as 'ivi_venno',
	convert(varchar(10),ici_expdat,101) as 'ici_expdat',
	@compName as 'compName'
from 
	imcstinf 
	left join imbasinf on ibi_itmno = ici_itmno
	left join vnbasinf on ibi_venno = vbi_venno
where 	
	(@prdVenNoFm = '' or (@prdVenNoFm <> '' and ibi_Venno between @prdVenNoFm and @prdVenNoTo)) and
	convert(varchar(10),ici_expdat,101) > '01/01/1900' 
--	and  @cstexpdate  > ici_expdat
	and ici_expdat between @cstexpdate and @cstexpdateto
order by 
	ici_expdat, 
	ibi_venno, 
	ibi_itmno










GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00020] TO [ERPUSER] AS [dbo]
GO
