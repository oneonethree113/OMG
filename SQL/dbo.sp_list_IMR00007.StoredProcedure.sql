/****** Object:  StoredProcedure [dbo].[sp_list_IMR00007]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00007]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00007]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
ALTER  Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject
*/

CREATE PROCEDURE [dbo].[sp_list_IMR00007]

@ibi_cocde as nvarchar(6) = ' ',
@fromcatlvl4 as nvarchar(20),
@tocatlvl4 as nvarchar(20),
@fromitmno as nvarchar(20),
@toitmno as nvarchar(20)


as

select 
	ibi_catlvl4, 
	ibi_lnecde, 
	ibi_itmno, 
	ibi_engdsc, 
	datediff
	(day, ibi_credat, getdate()) as daterange, 
	@fromcatlvl4,
	@tocatlvl4,
	@fromitmno,
	case @toitmno when 'ZZZZZZZZZZZZZZZZZZZZ' then '' else @toitmno end as '@toitmno'
from 
	imbasinf
where 
	--ibi_cocde = @ibi_cocde and
	ibi_catlvl4 between @fromcatlvl4 and @tocatlvl4 and
	ibi_itmno between @fromitmno and @toitmno

order by 
	ibi_catlvl4, ibi_lnecde, ibi_itmno











GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00007] TO [ERPUSER] AS [dbo]
GO
