/****** Object:  StoredProcedure [dbo].[sp_update_CUBCR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUBCR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUBCR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*=========================================================
Program ID	: 	sp_update_CUBCR
Description   	: 	Update Record to Customer Risk and Credit 
Programmer  	: 	Lewis To	
Create Date   	: 	16 Jul 2003
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:	CUBCR
Parameter		:	@mode	:ONE -- single Customer
		:		 
=========================================================
 Modification History                                    
=========================================================
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_update_CUBCR] 

@dummy			varchar(6),
@mode			char(3),
@cbc_cocde		varchar(6) ,
@cbc_cusno		varchar(6)  ,
@cbc_rsklmt		numeric(13, 4) ,
@cbc_rskuse		numeric(13, 4) ,
@cbc_cdtlmt		numeric(13, 4) ,
@cbc_cdtuse		numeric(13, 4) ,
@cbc_curcde		char(3)  ,
@cbc_updusr		varchar(30),
@cbc_updprg		varchar (20)

as

begin
if @mode = 'ONE'
--************************************** Update Single Company *****************************************************
	begin
		update  CUBCR set 
		cbc_rsklmt = @cbc_rsklmt,
		cbc_cdtlmt = @cbc_cdtlmt,
		cbc_curcde = @cbc_curcde,
		cbc_updusr = @cbc_updusr,
		cbc_upddat = getdate(),
		cbc_updprg = @cbc_updprg

	where	cbc_cocde =@cbc_cocde and
		cbc_cusno = @cbc_cusno
	end
--*************************************************************************************
end




GO
GRANT EXECUTE ON [dbo].[sp_update_CUBCR] TO [ERPUSER] AS [dbo]
GO
