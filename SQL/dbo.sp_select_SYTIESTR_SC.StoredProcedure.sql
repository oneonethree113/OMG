/****** Object:  StoredProcedure [dbo].[sp_select_SYTIESTR_SC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYTIESTR_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYTIESTR_SC]    Script Date: 09/29/2017 15:29:10 ******/
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
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030715	Allan Yuen		For Merge Porject
*/

/************************************************************************
Author:		Kenny Chan
Date:		16th fEB, 2002
Description:	Select data From SYTIESTR
Parameter:	1. Company
		2. Venno No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SYTIESTR_SC]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yts_cocde	nvarchar(6) = ' ', 
@yts_venno	nvarchar(6),
@yts_effdat	datetime

---------------------------------------------- 
AS
begin

declare @TempDate as datetime


select 
	top 1
	@TempDate = yts_effdat
from 
	SYTIESTR
 where
--	yts_cocde = @yts_cocde and
	yts_cocde = ' ' and
	yts_venno = @yts_venno and
	yts_effdat  <=  @yts_effdat  and  
	yts_tirtyp = 'M'
order by 
	yts_effdat desc 

--select @tempdate

Select 
yts_cocde,
yts_venno,
yts_itmtyp,
yts_tirtyp,
yts_tirseq,	
yts_qtyfr,
yts_qtyto,
yts_MOQ,
yts_MOA,
yts_comrat,
yts_moqchg,
yts_moqrbe,
yts_moqchgfr,
yts_moqchgto,
yts_creusr,
yts_updusr,
yts_credat,
yts_upddat,
yts_timstp 

--------------------------------- 
 from SYTIESTR
 where
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--yts_cocde = @yts_cocde and
yts_cocde = ' ' and
yts_venno = @yts_venno and
yts_effdat = @TempDate  and  
yts_tirtyp = 'M'

order by 
yts_itmtyp,
yts_qtyfr

-------------------------- 

                                                           
end







GO
GRANT EXECUTE ON [dbo].[sp_select_SYTIESTR_SC] TO [ERPUSER] AS [dbo]
GO
