/****** Object:  StoredProcedure [dbo].[sp_insert_SCDISPRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SCDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SCDISPRM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 27/07/2003


/************************************************************************
Author:		Kenny Chan
Date:		21th dec, 2001
Description:	Insert data From SCDISPRM
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_SCDISPRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sdp_cocde  nvarchar     (6),
@sdp_ordno  nvarchar     (20),
@sdp_type  nvarchar     (15),
@sdp_cde  nvarchar     (20),
@sdp_dsc  nvarchar     (200),
@sdp_pctamt  nvarchar     (10),
@sdp_pct  numeric  (6,   3),
@sdp_amt  numeric  (11,4),
@sdp_updusr  nvarchar(30 )



----------------------------------------------  
AS
Declare @sdp_seqno  int
Set @sdp_seqno = (Select isnull(max(sdp_seqno),0) + 1 from SCDISPRM Where sdp_cocde = @sdp_cocde and sdp_ordno = @sdp_ordno and sdp_type= @sdp_type) 


begin
Insert SCDISPRM (
sdp_cocde,
sdp_ordno,
sdp_type,
sdp_seqno,
sdp_cde,
sdp_dsc,
sdp_pctamt,
sdp_pct,
sdp_amt,
sdp_creusr,
sdp_updusr,
sdp_credat,
sdp_upddat
)
Values
(
@sdp_cocde,
@sdp_ordno,
@sdp_type,
@sdp_seqno,
@sdp_cde,
@sdp_dsc,
@sdp_pctamt,
@sdp_pct,
@sdp_amt,
@sdp_updusr,
@sdp_updusr,
GETDATE(),
GETDATE()
)


---------------------------------------------------------- 
end






GO
GRANT EXECUTE ON [dbo].[sp_insert_SCDISPRM] TO [ERPUSER] AS [dbo]
GO
