/****** Object:  StoredProcedure [dbo].[sp_insert_SHDISPRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHDISPRM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_insert_SHDISPRM] 
--------------------------------------------------------------------------------------------------------------------------------------

@hdp_cocde	nvarchar(6),
@hdp_shpno	nvarchar(20),
@hdp_invno	nvarchar(20),
@hdp_type	nvarchar(6),
@hdp_seqno	int,
@hdp_cde	nvarchar(20),
@hdp_dsc	nvarchar(200),
@hdp_pctamt	nvarchar(10),
@hdp_pct	numeric(6,3),
@hdp_amt	numeric(11,4),
@hdp_updusr	nvarchar(30)

--------------------------------------------------------------------------------------------------------------------------------------
AS

set @hdp_seqno = 0

Set @hdp_seqno = (Select isnull(max(hdp_seqno ),0) + 1 from SHDISPRM 
	Where hdp_cocde= @hdp_cocde and hdp_shpno = @hdp_shpno and hdp_invno = @hdp_invno and
		@hdp_type = @hdp_type)


insert into SHDISPRM 

(

hdp_cocde,
hdp_shpno,
hdp_invno,
hdp_type,
hdp_seqno,
hdp_cde,
hdp_dsc,
hdp_pctamt,
hdp_pct,	
hdp_amt,
hdp_creusr,
hdp_updusr,
hdp_credat,
hdp_upddat

) values (

@hdp_cocde,
@hdp_shpno,
@hdp_invno,
@hdp_type,
@hdp_seqno,
@hdp_cde,
@hdp_dsc,
@hdp_pctamt,
@hdp_pct,	
@hdp_amt,
@hdp_updusr,
@hdp_updusr,
getdate(),
getdate()
)

--------------------------------------------------------------------------------------------------------------------------------------









GO
GRANT EXECUTE ON [dbo].[sp_insert_SHDISPRM] TO [ERPUSER] AS [dbo]
GO
