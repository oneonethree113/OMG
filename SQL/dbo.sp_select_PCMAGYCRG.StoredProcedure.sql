/****** Object:  StoredProcedure [dbo].[sp_select_PCMAGYCRG]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PCMAGYCRG]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PCMAGYCRG]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Program ID	: sp_select_PCMAGCRG
Description   	: Select Data form Profit Center Agency Charge Table 
Programmer  	: Marco Chan
ALTER  Date   	: 18 Sept 2003
Last Modified  	: 
Table Read(s) 	: PCMAGYCRG
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/
CREATE   procedure [dbo].[sp_select_PCMAGYCRG]
@cocde varchar(6),
@pac_pcno varchar(20)
AS
begin
select 	'' as 'pac_del',
 	pac_pcno,
	pac_cocde, 
	pac_cusno,
	case when pac_cusno='Standard' then pac_cusno else cbi_cusnam end as 'pac_cusnam', 
	pac_hdcfmlopt,
	pac_hdcfmlopt + ' - ' + yfi_fml 'pac_hdcfml',
	pac_creusr,
	'' as 'pac_status'
from	PCMAGYCRG
left join CUBASINF on cbi_cusno = pac_cusno
left join SYFMLINF on yfi_fmlopt = pac_hdcfmlopt
where pac_pcno = @pac_pcno
and pac_cusno!='STD'
order by pac_pcno, pac_cocde
end









GO
GRANT EXECUTE ON [dbo].[sp_select_PCMAGYCRG] TO [ERPUSER] AS [dbo]
GO
