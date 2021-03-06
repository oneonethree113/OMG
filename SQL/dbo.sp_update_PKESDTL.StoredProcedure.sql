/****** Object:  StoredProcedure [dbo].[sp_update_PKESDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKESDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKESDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















CREATE  procedure [dbo].[sp_update_PKESDTL]
                                                                                                                                                                                                                                                                 
@ped_cocde nvarchar(20),
@ped_reqno nvarchar(20),
@ped_reqseq int ,
@ped_seq int ,
        @ped_itemno  nvarchar(20),
        @ped_assitm  nvarchar(20),
        @ped_tmpitmno  nvarchar(20),
        @ped_venno  nvarchar(20),
        @ped_venitm  nvarchar(20),
        @ped_colcde nvarchar(20),
@ped_pkgitem nvarchar(20),
        @ped_price numeric(11,6),
	@ped_curcde nvarchar(20),
        @ped_creusr  nvarchar(30)

---------------------------------------------- 

 
AS
 

begin

	 
update  PKESDTL set  
ped_price = @ped_price ,
ped_curcde = @ped_curcde,
ped_updusr = @ped_creusr,
ped_upddat  = getdate()  
where 
ped_cocde = @ped_cocde and 
ped_reqno = @ped_reqno and 
ped_reqseq  = @ped_reqseq
 

end





















GO
GRANT EXECUTE ON [dbo].[sp_update_PKESDTL] TO [ERPUSER] AS [dbo]
GO
