/****** Object:  StoredProcedure [dbo].[sp_list_CUBCR_alias]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUBCR_alias]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUBCR_alias]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





/*=========================================================
Program ID	: 	sp_list_CUBCR_aliad
Description   	: 	Grid List Record From Customer Risk and Credit 
Programmer  	: 	Lewis To	
Create Date   	: 	16 Jul 2003
Last Modified  	: 
Table Read(s) 	:	CUBCR
Table Write(s) 	:	
=========================================================
 Modification History                                    
=========================================================
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_list_CUBCR_alias] 

@cbc_cocde		varchar(6) ,
@cbc_cusno		varchar(6)  

as
declare 
@cnt  int

begin
select @cnt = count(1) from cubasinf where cbi_cusali = @cbc_cusno

select 
' ' as 'cbc_del',
@cbc_cusno as 'cbc_cusno', --	cbc_cusno,
cbc_cocde,
cbc_curcde,
sum(cbc_rsklmt) as 'cbc_rsklmt',
sum(cbc_rskuse) as 'cbc_rskuse',
sum(cbc_cdtlmt) as 'cbc_cdtlmt',
sum(cbc_cdtuse) as 'cbc_cdtuse',
@cnt as 'cbc_ali' --cbc_creusr
from 
(select 
	' ' as'cbc_del',
--	cbc_cusno,
	cbc_cocde,
	cbc_curcde,
	cbc_rsklmt,
	cbc_rskuse,
	cbc_cdtlmt,
	cbc_cdtuse
--	cbc_creusr
 from CUBCR 
where   cbc_cusno = @cbc_cusno
union
select 
	' ' as 'cbc_del',
--	cbc_cusno,
	cbc_cocde,
	cbc_curcde,
	cbc_rsklmt,
	cbc_rskuse,
	cbc_cdtlmt,
	cbc_cdtuse
--	cbc_creusr
 from CUBCR,CUBASINF 
where   cbi_cusali = @cbc_cusno and cbc_cusno = cbi_cusno
) vw

group by cbc_cocde, cbc_curcde
end




GO
GRANT EXECUTE ON [dbo].[sp_list_CUBCR_alias] TO [ERPUSER] AS [dbo]
GO
