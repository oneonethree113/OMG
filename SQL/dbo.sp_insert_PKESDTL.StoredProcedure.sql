/****** Object:  StoredProcedure [dbo].[sp_insert_PKESDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PKESDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PKESDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO













CREATE  procedure [dbo].[sp_insert_PKESDTL]
                                                                                                                                                                                                                                                                 
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

	 
	 
insert into PKESDTL

values 
(@ped_cocde,
@ped_reqno,
@ped_reqseq,
@ped_seq,
@ped_itemno,
@ped_assitm,
@ped_tmpitmno,
@ped_venno,
@ped_venitm,
@ped_colcde,
@ped_pkgitem,
@ped_price,
@ped_curcde,
@ped_creusr,
@ped_creusr,
getdate(),
getdate(),
null
 )
 

end



















GO
GRANT EXECUTE ON [dbo].[sp_insert_PKESDTL] TO [ERPUSER] AS [dbo]
GO
