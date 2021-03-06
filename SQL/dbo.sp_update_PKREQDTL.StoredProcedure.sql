/****** Object:  StoredProcedure [dbo].[sp_update_PKREQDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKREQDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKREQDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












CREATE  procedure [dbo].[sp_update_PKREQDTL]
                                                                                                                                                                                                                                                                 
@cocde nvarchar(6),
@reqno nvarchar(20),
@seq int,
@multip int,
@ordqty int,
@wasper numeric(13,4),
@wasqty int,
@ttlordqty int,
@untprc numeric(11,6),
@ttlamtqty numeric(13,4),
@receqty int,
@pkgven nvarchar(20),
@quoteprc numeric(13,4),
@ctnper nvarchar(20),
@tel	nvarchar(20),
@prd_curcde nvarchar(20),
@bonqty int,
@user nvarchar(30)

---------------------------------------------- 

 
AS
 

begin

	 
Update PKREQDTL 
set 
prd_multip = @multip ,
prd_ordqty = @ordqty,
prd_wasper = @wasper,
prd_wasqty = @wasqty ,
prd_ttlordqty = @ttlordqty ,
prd_untprc = @untprc,
prd_ttlamtqty = @ttlamtqty,
prd_receqty = @receqty,
prd_pkgven = @pkgven,
prd_salprc = @quoteprc,
prd_updusr = @user,
prd_Tel = @tel , 
prd_curcde  = @prd_curcde,
prd_cntper = @ctnper,
prd_bonqty = @bonqty,
prd_upddat = getdate()
where
 prd_cocde = @cocde and prd_reqno = @reqno and prd_seq = @seq
 
 update pkreqhdr
set prh_updusr = @user , prh_upddat = getdate() , prh_revdat = getdate()
where 
prh_cocde = @cocde and prh_reqno = @reqno


end


















GO
GRANT EXECUTE ON [dbo].[sp_update_PKREQDTL] TO [ERPUSER] AS [dbo]
GO
