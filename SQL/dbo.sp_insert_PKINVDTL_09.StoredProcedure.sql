/****** Object:  StoredProcedure [dbo].[sp_insert_PKINVDTL_09]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PKINVDTL_09]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PKINVDTL_09]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_insert_PKINVDTL_09] 

@cocde nvarchar(6),
@pkgitm nvarchar(20),
@ordno nvarchar(20),
@ordseq int,
@ordqty int,
@stkqty int,
@wasqty int,
@ttlqty int,
@user nvarchar(30)

AS


 
declare @countHDR as int

select @countHDR = count(*) from  pkinvhdr(nolock) 
where  pih_pkgitm = @pkgitm


if @countHDR = 0 
begin

	if @stkqty > 0 
	begin
	
	insert into PKINVHDR values ('',@pkgitm,'','',@stkqty,@user,@user,getdate(),getdate(),null)
	insert into PKINVDTL values ('',@pkgitm,1,'','','Y',@ordno,@ordseq,@ordqty,@stkqty,@wasqty,@ttlqty,@user,@user,getdate(),getdate(),null)

	end 	 
	 
end 

else

begin 

declare @Dtlseq as int
select @dtlseq = count (*) + 1 from PKINVDTL(Nolock) where pid_pkgitm = @pkgitm

-- update PKINVDTL set pid_latest = 'N' where pid_ordno = @ordno and pid_ordseq = @ordseq

insert into PKINVDTL values ('',@pkgitm,@dtlseq,'','','Y',@ordno,@ordseq,@ordqty,@stkqty,@wasqty,@ttlqty,@user,@user,getdate(),getdate(),null)

declare @SumStkQty as int 
select @SumStkQty =  sum(pid_stkqty) from PKINVDTL(Nolock) where pid_pkgitm = @pkgitm and pid_latest = 'Y'

update PKINVHDR set pih_avlqty = @SumStkQty ,
			pih_updusr =  @user , 
			pih_upddat = getdate()
	where pih_pkgitm = @pkgitm

end 
--end 




GO
GRANT EXECUTE ON [dbo].[sp_insert_PKINVDTL_09] TO [ERPUSER] AS [dbo]
GO
