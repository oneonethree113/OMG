/****** Object:  StoredProcedure [dbo].[sp_SYCAT_UCPP_to_UCP_Sub]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_SYCAT_UCPP_to_UCP_Sub]
GO
/****** Object:  StoredProcedure [dbo].[sp_SYCAT_UCPP_to_UCP_Sub]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003
-- Disable all function at merge project

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
20030715	Allan Yuen		Modify For Merge Porject 
*/


CREATE PROCEDURE [dbo].[sp_SYCAT_UCPP_to_UCP_Sub] 

AS

Declare
@ycr_cocde  nvarchar(6) ,
@ycr_catseq  int,
@ycr_catlvl0  nvarchar(20),
@ycr_catlvl1  nvarchar(20),
@ycr_catlvl2  nvarchar(20),
@ycr_catlvl3  nvarchar(20),
@ycr_catlvl4  nvarchar(20),
@ycr_upddat  datetime,
@Seq int
set nocount on
/*
DECLARE cur_SYCATREL CURSOR
FOR Select 	ycr_cocde,	ycr_catseq,
		ycr_catlvl0,	ycr_catlvl1,
		ycr_catlvl2,	ycr_catlvl3,
		ycr_catlvl4,	ycr_upddat

From SYCATREL 
Where	ycr_cocde = 'UCPP' 
	
OPEN cur_SYCATREL
FETCH NEXT FROM cur_SYCATREL INTO
		@ycr_cocde,	@ycr_catseq,
		@ycr_catlvl0,	@ycr_catlvl1,
		@ycr_catlvl2,	@ycr_catlvl3,
		@ycr_catlvl4,	@ycr_upddat
While @@fetch_status = 0
Begin
	IF (Select count(*) from SYCATREL where 	ycr_cocde = 'UCP' and ycr_catlvl0 = @ycr_catlvl0 and ycr_catlvl1 = @ycr_catlvl1 and
						ycr_catlvl2=@ycr_catlvl2 and ycr_catlvl3 = @ycr_catlvl3 and ycr_catlvl4 = @ycr_catlvl4) = 0

	BEGIN
		SET @seq = (Select isnull(max(ycr_catseq),0) + 1 from SYCATREL where ycr_cocde = 'UCP')
		INSERT INTO SYCATREL
		(ycr_cocde,	ycr_catseq,
		ycr_catlvl0,	ycr_catlvl1,
		ycr_catlvl2,	ycr_catlvl3,
		ycr_catlvl4,	ycr_creusr,
		ycr_updusr,	ycr_credat,
		ycr_upddat)
		Values
		('UCP',		@seq,
		@ycr_catlvl0,	@ycr_catlvl1,
		@ycr_catlvl2,	@ycr_catlvl3,
		@ycr_catlvl4,
		'SYSTEM_UPD',
		'SYSTEM_UPD',	
		GETDATE(),
		GETDATE())
		
	END
FETCH NEXT FROM cur_SYCATREL INTO
		@ycr_cocde,	@ycr_catseq,
		@ycr_catlvl0,	@ycr_catlvl1,
		@ycr_catlvl2,	@ycr_catlvl3,
		@ycr_catlvl4,	@ycr_upddat
END
CLOSE cur_SYCATREL
DEALLOCATE cur_SYCATREL
*/

set nocount off





GO
GRANT EXECUTE ON [dbo].[sp_SYCAT_UCPP_to_UCP_Sub] TO [ERPUSER] AS [dbo]
GO
