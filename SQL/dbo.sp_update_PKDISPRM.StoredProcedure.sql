/****** Object:  StoredProcedure [dbo].[sp_update_PKDISPRM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKDISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE  procedure [dbo].[sp_update_PKDISPRM]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@ordno nvarchar(20),
@type nvarchar(15),
@seq int,
@cde nvarchar(20),
@dsc nvarchar(200),
@pctamt nvarchar(10),
@pct numeric(6,3),
@amt numeric(11,4),
@user nvarchar(30)



---------------------------------------------- 

 
AS
 

begin

 update PKDISPRM set 
pdp_cde = @cde , 
pdp_dsc = @dsc ,
pdp_pctamt = @pctamt,
pdp_pct = @pct,
pdp_amt = @amt,
pdp_updusr = @user,
pdp_upddat = getdate()
where pdp_cocde  = @code and pdp_ordno = @ordno and pdp_type = @type and pdp_seqno = @seq


end


 
 


GO
GRANT EXECUTE ON [dbo].[sp_update_PKDISPRM] TO [ERPUSER] AS [dbo]
GO
