/****** Object:  StoredProcedure [dbo].[sp_update_VNCNTINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_VNCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_VNCNTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- Checked by Allan Yuen at 29/07/2003



------------------------------------------------- 
CREATE   procedure [dbo].[sp_update_VNCNTINF]
                                                                                                                                                                                                                                                               
  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

@vci_cocde 	nvarchar(6),
@vci_venno  	nvarchar(6),
@vci_cnttyp	nvarchar(6),
@vci_seq		int,
@vci_adr	nvarchar(200),
@vci_stt	nvarchar(30),
@vci_city	nvarchar(30),
@vci_town	nvarchar(30),
@vci_cty	nvarchar(6),
@vci_zip	nvarchar(20),
@vci_adrdtl	nvarchar(200),

@vci_cntctp	nvarchar(100),
@vci_cnttil	nvarchar(30),
@vci_cntphn	nvarchar(30),
@vci_cntfax	nvarchar(30),
@vci_cnteml	nvarchar(50),
@vci_cntdef	nvarchar(1),

--Added by Mark Lau 20081027
@vci_chnadr	nvarchar(255),
@vci_updusr	nvarchar(30)
                                   
----------------------------------- 
AS


------------------
if @vci_cnttyp = 'C'
begin
	if (select count(1) from VNCNTINF
			where vci_venno	= @vci_venno and
			vci_cnttyp	= @vci_cnttyp ) = 0 
	begin

			insert into VNCNTINF 
			
			(
			vci_cocde,
			vci_venno,
			vci_cnttyp,
			vci_seq,
			vci_adr,
			vci_stt,
			vci_city,
			vci_town,
			vci_cty,
			vci_zip,
			vci_adrdtl,
			
			vci_cntctp,
			vci_cnttil,
			vci_cntphn,
			vci_cntfax,
			vci_cnteml,
			vci_cntdef,
			
			vci_creusr,
			vci_updusr,
			vci_credat,
			vci_upddat
			)
			values
			(
			--@vci_cocde,
			' ',
			@vci_venno,
			@vci_cnttyp,
			@vci_seq,
			@vci_adr,
			@vci_stt,
			@vci_city,
			@vci_town,
			@vci_cty,
			@vci_zip,
			@vci_adrdtl,
			
			@vci_cntctp,
			@vci_cnttil,
			@vci_cntphn,
			@vci_cntfax,
			@vci_cnteml,
			@vci_cntdef,
			
			@vci_updusr,
			@vci_updusr,
			getdate(),
			getdate()
			)
			
	
	
	end

end
------------------

update VNCNTINF
SET

vci_adr		= @vci_adr,
vci_stt		= @vci_stt,
vci_city		= @vci_city,
vci_town		= @vci_town,
vci_cty		= @vci_cty,
vci_zip		= @vci_zip,
vci_adrdtl	= @vci_adrdtl,

vci_cntctp	= @vci_cntctp,
vci_cnttil	= @vci_cnttil,
vci_cntphn	= @vci_cntphn,
vci_cntfax	= @vci_cntfax,
vci_cnteml	= @vci_cnteml,
vci_cntdef	= @vci_cntdef,

--Added by Mark Lau 20081027
vci_chnadr = @vci_chnadr,

vci_updusr	= @vci_updusr,
vci_upddat 	= getdate()

where 
--vci_cocde	= @vci_cocde and
--vci_cocde	= ' ' and
vci_venno	= @vci_venno and
vci_cnttyp	= @vci_cnttyp and
vci_seq		= @vci_seq 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------


GO
GRANT EXECUTE ON [dbo].[sp_update_VNCNTINF] TO [ERPUSER] AS [dbo]
GO
