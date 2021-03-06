/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quot_Ass]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Quot_Ass]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Quot_Ass]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Description   	: sp_select_PDA_Quot_Ass
Programmer  	: Mark Lau
Create Date   	: 2008-07-09
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 
CREATE procedure [dbo].[sp_select_PDA_Quot_Ass]
@cocde	nvarchar(6),
@qud_cocde	nvarchar(6),
@qud_cus1no	nvarchar(10),
@qud_cus2no	nvarchar(10),
@qud_tmpqutno nvarchar(50),
@qud_assitm	nvarchar(20),
@typ	nvarchar(1)

as

if (@typ = '1')
begin
select 
case when qud_del = 'Y' then qud_del else 'N' end as 'Del',
qud_itmno,
qud_venitm,
qud_colcde,
qud_untcde,
qud_inrqty,
qud_mtrqty,
qud_venno,
qud_alsitmno,
qud_alscolcde,
case when qud_del = 'Y' then qud_del else 'N' end as 'Upd',
qud_assitm,
qud_tmpqutno,
qud_cus1no,
qud_cus2no,
qud_seq

from pda_quot_ass
where 
--qud_cus1no = @qud_cus1no and qud_cus2no = @qud_cus2no and 

( ( qud_cus1no = @qud_cus1no and @qud_cus1no <> '' ) or  @qud_cus1no = '')
and 
( ( qud_cus2no = @qud_cus2no and @qud_cus2no <> '' ) or  @qud_cus2no = '')
and
qud_tmpqutno = @qud_tmpqutno
--and qud_cocde = @qud_cocde
and qud_assitm = @qud_assitm
-- and qud_aprsts = ''

order by   qud_cocde, qud_cus1no, qud_cus2no, qud_sessid, qud_assitm, qud_seq, qud_itmno
end


if (@typ = '2')
begin
select 
*
from pda_quot_ass
where 
--qud_cus1no = @qud_cus1no and qud_cus2no = @qud_cus2no 
( ( qud_cus1no = @qud_cus1no and @qud_cus1no <> '' ) or  @qud_cus1no = '')
and 
( ( qud_cus2no = @qud_cus2no and @qud_cus2no <> '' ) or  @qud_cus2no = '')

and qud_tmpqutno = @qud_tmpqutno
--and qud_cocde = @qud_cocde
and qud_aprsts = ''
order by   qud_cocde, qud_cus1no, qud_cus2no, qud_sessid, qud_assitm, qud_seq, qud_itmno
end


GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Quot_Ass] TO [ERPUSER] AS [dbo]
GO
