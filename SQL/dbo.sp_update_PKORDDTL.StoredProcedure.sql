/****** Object:  StoredProcedure [dbo].[sp_update_PKORDDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_update_PKORDDTL] 

@cocde nvarchar(6),
@ordno nvarchar(20),
@ordseq int,
@stkqty int,
@wasper numeric(13,4),
@wasqty int,
@ttlqty int,
@ttlamt numeric(13,4),
@conmak nvarchar(500),
@pkgitm nvarchar(20),
@ordqty int,
@bonqty int ,
@fty nvarchar(20),

@address nvarchar(300),
@State nvarchar(50),
@cntry nvarchar(50),
@zip nvarchar(50),
@cntper nvarchar(20),
@tel nvarchar(20),

@shpstr datetime,
@shpend datetime,
@MOA numeric(13,4),
@qtyum nvarchar(20),
@user nvarchar(30)

AS


 update PKORDDTL 
set pod_stkqty = @stkqty,
     pod_wasper = @wasper,
     pod_wasqty = @wasqty,
     pod_ttlordqty = @ttlqty,
	pod_ttlamtqty = @ttlamt,
	pod_updusr = @user,
	pod_upddat = getdate(),
	pod_conmak = @conmak,
	pod_fty = @fty,
	pod_addres_fty = @address ,
	pod_state_fty = @State ,
	pod_cntry_fty = @cntry ,
	pod_zip_fty = @zip ,
	pod_cntper_fty = @cntper,
	pod_Tel_fty = @tel ,

	pod_shpstr = @shpstr,
	pod_shpend = @shpend,
	pod_bonqty = @bonqty,	
	pod_moa = @MOA,
	pod_qtyum = @qtyum
where pod_cocde = @cocde and pod_ordno = @ordno and pod_seq = @ordseq

--if @stkqty <> 0
--begin
declare @countHDR as int

select @countHDR = count(*) from  pkinvhdr(nolock) 
where  pih_pkgitm = @pkgitm


if @countHDR = 0 
begin

	if @stkqty > 0 
	begin
	
	insert into PKINVHDR values ('',@pkgitm,'','',@stkqty,@user,@user,getdate(),getdate(),null)
	insert into PKINVDTL values ('',@pkgitm,1,'','','Y',@ordno,@ordseq,@ordqty,@stkqty,@bonqty,@ttlqty,@user,@user,getdate(),getdate(),null)
--insert into PKINVDTL values ('',@pkgitm,1,'','','Y',@ordno,@ordseq,@ordqty,@stkqty,@wasqty,@ttlqty,@user,@user,getdate(),getdate(),null)
	end 	 
	 
end 

else

begin 

declare @Dtlseq as int
select @dtlseq = count (*) + 1 from PKINVDTL(Nolock) where pid_pkgitm = @pkgitm

 update PKINVDTL set pid_latest = 'N' where pid_ordno = @ordno and pid_ordseq = @ordseq

--insert into PKINVDTL values ('',@pkgitm,@dtlseq,'','','Y',@ordno,@ordseq,@ordqty,@stkqty,@wasqty,@ttlqty,@user,@user,getdate(),getdate(),null)
insert into PKINVDTL values ('',@pkgitm,@dtlseq,'','','Y',@ordno,@ordseq,@ordqty,@stkqty,@bonqty,@ttlqty,@user,@user,getdate(),getdate(),null)

declare @SumStkQty as int 
select @SumStkQty =  sum(pid_stkqty) from PKINVDTL(Nolock) where pid_pkgitm = @pkgitm and pid_latest = 'Y'

update PKINVHDR set pih_avlqty = @SumStkQty ,
			pih_updusr =@user,
			pih_upddat = getdate()
		 where pih_pkgitm = @pkgitm

end 
--end 








GO
GRANT EXECUTE ON [dbo].[sp_update_PKORDDTL] TO [ERPUSER] AS [dbo]
GO
