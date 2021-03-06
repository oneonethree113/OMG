/****** Object:  StoredProcedure [dbo].[sp_update_PKREQDTL_05]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKREQDTL_05]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKREQDTL_05]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_update_PKREQDTL_05] 


@ordno nvarchar(20),
@vendor nvarchar(20),
@pkgitm nvarchar(20),
@price numeric(11,6),
@reqno nvarchar(20),
@reqseq int,
@user nvarchar(30)

AS
begin

declare @ordseq as int 

select @ordseq = pod_seq from pkorddtl(nolock)
where pod_ordno = @ordno and 
	pod_pkgitm = @pkgitm and 
	pod_pkgven = @vendor and 
	pod_untprc = @price

 update pkreqdtl set 
	prd_ordno = @ordno , 
	prd_ordseq = @ordseq,
	prd_updusr = @user,
	prd_upddat = getdate()
 where prd_reqno = @reqno and prd_seq = @reqseq
 

end 
 
--end 

 





GO
GRANT EXECUTE ON [dbo].[sp_update_PKREQDTL_05] TO [ERPUSER] AS [dbo]
GO
