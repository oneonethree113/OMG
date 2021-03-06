/****** Object:  StoredProcedure [dbo].[sp_update_PKESHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKESHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKESHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO














CREATE  procedure [dbo].[sp_update_PKESHDR]
                                                                                                                                                                                                                                                                 
@peh_cocde nvarchar(20),
@peh_reqno nvarchar(20),
        @peh_itemno  nvarchar(20),
        @peh_assitm  nvarchar(20),
        @peh_tmpitmno  nvarchar(20),
        @peh_venno  nvarchar(20),
        @peh_venitm  nvarchar(20),
        @peh_colcde nvarchar(20),
        @peh_price numeric(13,4),
        @peh_curcde nvarchar(20),
        @peh_creusr  nvarchar(30)

---------------------------------------------- 

 
AS
 

begin

update PKESHDR set 
peh_price = @peh_price,
peh_curcde= @peh_curcde,
peh_updusr = @peh_creusr,
peh_upddat = getdate()
where 
peh_reqno = @peh_reqno and 
peh_itemno = @peh_itemno and 
peh_assitm = @peh_assitm and 
peh_tmpitmno = @peh_tmpitmno and 
peh_venno = @peh_venno and 
peh_venitm = @peh_venitm and 
peh_colcde = @peh_colcde 


 

end




















GO
GRANT EXECUTE ON [dbo].[sp_update_PKESHDR] TO [ERPUSER] AS [dbo]
GO
