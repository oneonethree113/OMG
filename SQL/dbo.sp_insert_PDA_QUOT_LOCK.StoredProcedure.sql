/****** Object:  StoredProcedure [dbo].[sp_insert_PDA_QUOT_LOCK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PDA_QUOT_LOCK]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PDA_QUOT_LOCK]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Description   	: sp_insert_PDA_QUOT_LOCK
Programmer  	: Mark Lau
Create Date   	: 2008-07-24
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 
CREATE procedure [dbo].[sp_insert_PDA_QUOT_LOCK]
@qud_tmpqutno 	nvarchar(20),
@qud_sessid 	nvarchar(50),
@qud_remark	nvarchar(255),
@qud_curusr	nvarchar(30),
@qud_cursaltem	nvarchar(12),
@qud_curpda	nvarchar(50),
@qud_curip	nvarchar(20)

as

insert into pda_quot_lock(qud_tmpqutno, qud_sessid,qud_remark,qud_curusr,qud_cursaltem,qud_curlogindat,qud_curpda,qud_curip,qud_curchkdat )
values(@qud_tmpqutno,@qud_sessid,@qud_remark,@qud_curusr,@qud_cursaltem,getdate(),@qud_curpda,@qud_curip,getdate())

select @@rowcount as 'AffectedRow'




GO
GRANT EXECUTE ON [dbo].[sp_insert_PDA_QUOT_LOCK] TO [ERPUSER] AS [dbo]
GO
