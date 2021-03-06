/****** Object:  StoredProcedure [dbo].[sp_update_ZSITMDAT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_ZSITMDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_ZSITMDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




-- Checked by Allan Yuen at 28/07/2003

/*	Author : Tommy Ho	*/

CREATE procedure [dbo].[sp_update_ZSITMDAT]
@zid_cocde 	nvarchar(6),
@zid_itmno	varchar(20),
@zid_seqno	int,
@zid_mpono	varchar(20),
@Zid_Credat	datetime,
@zid_stage		nvarchar(3),
@zid_updusr	nvarchar(30)

AS


IF @zid_stage = 'A'
BEGIN
	UPDATE
		ZSITMLST 
	SET
		ZIL_UM = ZID_UM,
		ZIL_CUR = ZID_CURR,
		ZIL_PRC =  ZID_UNITPRC,
		ZIL_UPDDAT = GETDATE(),
		ZIL_UPDUSR = @zid_updusr
	from 
		ZSITMDAT 
	where
		Zid_itmno = @zid_itmno and
		Zid_Seqno =  @zid_seqno and
		Zid_MPONO = @zid_mpono and
		convert(varchar(19),zid_credat,121) = convert(varchar(19),@zid_credat,121) and
		zil_itmno = @zid_itmno 
	
END

 
-- Update ZSITMDAT
update 
	ZSITMDAT
SET
	zid_stage = @zid_stage, 	
	zid_updusr = @zid_updusr,	
	zid_upddat = getdate() 

where 
	Zid_itmno = @zid_itmno and
	Zid_Seqno =  @zid_seqno and
	Zid_MPONO = @zid_mpono and
	convert(varchar(19),zid_credat,121) = convert(varchar(19),@zid_credat,121)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------







GO
GRANT EXECUTE ON [dbo].[sp_update_ZSITMDAT] TO [ERPUSER] AS [dbo]
GO
