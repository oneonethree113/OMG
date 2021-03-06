/****** Object:  StoredProcedure [dbo].[sp_insert_TOORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_TOORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_TOORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE      PROCEDURE [dbo].[sp_insert_TOORDDTL]
@tod_cocde nvarchar(6),
@tod_toordno nvarchar(20),
@tod_seqno int,
@tod_verno int,
@tod_latest char(1),
@tod_refno nvarchar(20),
@tod_sts nvarchar(20),
@tod_todat datetime,
@tod_customer nvarchar(50),
@tod_cus1no nvarchar(10),
@tod_cus2no nvarchar(10),
@tod_buyer nvarchar(50),
@tod_category nvarchar(100),
@tod_jobno nvarchar(20),
@tod_ftyitmno nvarchar(20),
@tod_itmsku nvarchar(20),
@tod_ftytmpitmno nvarchar(20),
@tod_itmdsc nvarchar(800),
@tod_venno nvarchar(6),
@tod_venitm nvarchar(30),
@tod_colcde nvarchar(6),	
@tod_inrqty int,
@tod_mtrqty int,
@tod_pckunt nvarchar(10),
@tod_conftr int,
@tod_cft numeric(13, 4),
@tod_cbm numeric(13,4),
@tod_ftyprctrm nvarchar(10),
@tod_hkprctrm nvarchar(10),
@tod_trantrm nvarchar(10),
@tod_period nvarchar(10),
@tod_fobport nvarchar(50),
@tod_retail numeric(13, 4),
@tod_projqty bigint,
@tod_ftyshpdatstr datetime,
@tod_ftyshpdatend datetime,
@tod_dsgven nvarchar(20),
@tod_prdven nvarchar(20),
@tod_cusven nvarchar(20),
@tod_imgpth nvarchar(200),
@tod_sapno nvarchar(20),
@tod_cuspono nvarchar(50),
@tod_rmk nvarchar(800),
@tod_upc nvarchar(30),
@tod_ctnL numeric(13, 4),
@tod_ctnW numeric(13, 4),
@tod_ctnH numeric(13, 4),
@tod_ctnupc nvarchar(20),
@tod_venstk nvarchar(20),
@tod_cushpdatstr datetime,
@tod_cushpdatend datetime,
@tod_fcurcde nvarchar(6),
@tod_ftycst numeric(13, 4),
@tod_curcde nvarchar(6),
@tod_selprc numeric(13, 4),
@tod_qtyb_cuspo nvarchar(50),
@tod_qtyb_ordqty bigint,
@tod_podat datetime,
@tod_pcktyp nvarchar(800),
@tod_basprc		decimal(13, 4),
@tod_qutitmsts	nvarchar(10),
@tod_qutno nvarchar(20),
@tod_qutseq int,
@tod_markup numeric(13, 4),			
@tod_mrkprc numeric(13, 4),			
@tod_mumin  numeric(13, 4),			
@tod_muminprc  numeric(13, 4),	
@tod_pckcst numeric(13, 4),			
@tod_commsn numeric(13, 4),			
@tod_itmcom numeric(13, 4),			
@tod_stdprc numeric(13, 4),			
@tod_adjprc numeric(13, 4),			
@usrid nvarchar(30)	

AS

declare @count as int
declare @tod_cntctp as nvarchar(100)

select @tod_cntctp =  vci_cntctp from vncntinf(nolock) where vci_venno = @tod_prdven and vci_cntdef ='Y'

 

if @tod_seqno <> 0

begin

update TOORDDTL set tod_latest = 'N' where tod_toordno = @tod_toordno and tod_toordseq = @tod_seqno and tod_latest = 'Y'

insert into TOORDDTL
(
tod_cocde  ,
tod_toordno ,  
tod_toordseq,   
tod_verno    ,
tod_latest   ,
tod_refno  ,
tod_sts   ,
tod_todat , 
tod_customer   ,
tod_cus1no   ,
tod_cus2no   ,
tod_buyer   ,
tod_category,    
tod_jobno   ,
tod_ftyitmno,   
tod_itmsku   ,
tod_ftytmpitmno,   
tod_itmdsc    ,
tod_venno    ,
tod_venitm    ,
tod_colcde    ,
tod_inrqty    ,
tod_mtrqty    ,
tod_pckunt    ,
tod_conftr    ,
tod_cft    ,
tod_cbm  , 
tod_ftyprctrm,  
tod_hkprctrm ,  
tod_trantrm   ,
tod_period   ,
tod_fobport   ,
tod_retail   ,
tod_projqty ,  
tod_ftyshpdatstr,   
tod_ftyshpdatend,   
tod_dsgven   ,
tod_prdven   ,
tod_cusven   ,
tod_imgpth   ,
tod_sapno   ,
tod_cuspono  , 
tod_rmk   ,
tod_upc    ,
tod_ctnL   ,
tod_ctnW  ,  
tod_ctnH   ,
tod_ctnupc ,   
tod_venstk  ,  
tod_cushpdatstr,    
tod_cushpdatend ,   
tod_fcurcde    ,
tod_ftycst    ,
tod_curcde   , 
tod_selprc    ,
tod_qtyb_cuspo,    
tod_qtyb_ordqty ,   
tod_podat    ,
tod_pcktyp   , 
tod_qutno    ,
tod_qutseq   , 
tod_cntctp,
tod_basprc,
tod_qutitmsts,
tod_markup,			
tod_mrkprc,			
tod_mumin,			
tod_muminprc,
tod_pckcst,			
tod_commsn,			
tod_itmcom,			
tod_stdprc,			
tod_adjprc,			
tod_creusr,
tod_updusr,
tod_credat,
tod_upddat
) 
values
(
@tod_cocde  ,
@tod_toordno ,  
@tod_seqno,   
@tod_verno    ,
@tod_latest   ,
@tod_refno  ,
@tod_sts   ,
@tod_todat , 
@tod_customer,   
@tod_cus1no   ,
@tod_cus2no   ,
@tod_buyer   ,
@tod_category,    
@tod_jobno   ,
@tod_ftyitmno,   
@tod_itmsku   ,
@tod_ftytmpitmno,   
@tod_itmdsc    ,
@tod_venno    ,
@tod_venitm    ,
@tod_colcde    ,
@tod_inrqty    ,
@tod_mtrqty    ,
@tod_pckunt    ,
@tod_conftr    ,
@tod_cft    ,
@tod_cbm  , 
@tod_ftyprctrm , 
@tod_hkprctrm  , 
@tod_trantrm   ,
@tod_period   ,
@tod_fobport   ,
@tod_retail   ,
@tod_projqty ,  
@tod_ftyshpdatstr,   
@tod_ftyshpdatend ,  
@tod_dsgven   ,
@tod_prdven   ,
@tod_cusven   ,
@tod_imgpth   ,
@tod_sapno   ,
@tod_cuspono  , 
@tod_rmk   ,
@tod_upc    ,
@tod_ctnL   ,
@tod_ctnW  ,  
@tod_ctnH   ,
@tod_ctnupc ,   
@tod_venstk  ,  
@tod_cushpdatstr,    
@tod_cushpdatend ,   
@tod_fcurcde    ,
@tod_ftycst    ,
@tod_curcde   , 
@tod_selprc    ,
@tod_qtyb_cuspo,    
@tod_qtyb_ordqty ,   
@tod_podat    ,
@tod_pcktyp   , 
@tod_qutno    ,
@tod_qutseq   , 
@tod_cntctp,
@tod_basprc,
@tod_qutitmsts,
@tod_markup,			
@tod_mrkprc,			
@tod_mumin,			
@tod_muminprc,
@tod_pckcst,			
@tod_commsn,			
@tod_itmcom,			
@tod_stdprc,			
@tod_adjprc,			
@usrid,
@usrid,
getdate(),
getdate()
)

select @count = count(*) from QUDTLSHP(nolock) where qds_qutno = @tod_qutno and qds_qutseq = @tod_qutseq

if @count <> 0
begin
insert into todtlshp 
select '',@tod_toordno,@tod_seqno,@tod_verno,qds_shpseq,qds_ftyshpstr,
	qds_ftyshpend,qds_custshpstr,qds_custshpend,qds_shpqty,null,qds_pckunt,
	@usrid,@usrid,getdate(),getdate(),null from QUDTLSHP(nolock)
where qds_qutno = @tod_qutno and qds_qutseq = @tod_qutseq
end



end 
else
begin
declare @seq int

select @seq = isnull(max(tod_toordseq),0) + 1 from toorddtl 
where tod_cocde = @tod_cocde  and tod_toordno = @tod_toordno  and tod_latest ='Y'

insert into TOORDDTL
(
tod_cocde  ,
tod_toordno ,  
tod_toordseq,   
tod_verno    ,
tod_latest   ,
tod_refno  ,
tod_sts   ,
tod_todat , 
tod_customer   ,
tod_cus1no   ,
tod_cus2no   ,
tod_buyer   ,
tod_category,    
tod_jobno   ,
tod_ftyitmno,   
tod_itmsku   ,
tod_ftytmpitmno,   
tod_itmdsc    ,
tod_venno    ,
tod_venitm    ,
tod_colcde    ,
tod_inrqty    ,
tod_mtrqty    ,
tod_pckunt    ,
tod_conftr    ,
tod_cft    ,
tod_cbm  , 
tod_ftyprctrm,  
tod_hkprctrm ,  
tod_trantrm   ,
tod_period   ,
tod_fobport   ,
tod_retail   ,
tod_projqty ,  
tod_ftyshpdatstr,   
tod_ftyshpdatend,   
tod_dsgven   ,
tod_prdven   ,
tod_cusven   ,
tod_imgpth   ,
tod_sapno   ,
tod_cuspono  , 
tod_rmk   ,
tod_upc    ,
tod_ctnL   ,
tod_ctnW  ,  
tod_ctnH   ,
tod_ctnupc ,   
tod_venstk  ,  
tod_cushpdatstr,    
tod_cushpdatend ,   
tod_fcurcde    ,
tod_ftycst    ,
tod_curcde   , 
tod_selprc    ,
tod_qtyb_cuspo,    
tod_qtyb_ordqty ,   
tod_podat    ,
tod_pcktyp   , 
tod_qutno    ,
tod_qutseq   , 
tod_cntctp,
tod_basprc,
tod_qutitmsts,
tod_markup,			
tod_mrkprc,			
tod_mumin,			
tod_muminprc,
tod_pckcst,			
tod_commsn,			
tod_itmcom,			
tod_stdprc,			
tod_adjprc,			
tod_creusr,
tod_updusr,
tod_credat,
tod_upddat
)
values
(
@tod_cocde  ,
@tod_toordno ,  
@seq,   
@tod_verno    ,
@tod_latest   ,
@tod_refno  ,
@tod_sts   ,
@tod_todat , 
@tod_customer,   
@tod_cus1no   ,
@tod_cus2no   ,
@tod_buyer   ,
@tod_category,    
@tod_jobno   ,
@tod_ftyitmno,   
@tod_itmsku   ,
@tod_ftytmpitmno,   
@tod_itmdsc    ,
@tod_venno    ,
@tod_venitm    ,
@tod_colcde    ,
@tod_inrqty    ,
@tod_mtrqty    ,
@tod_pckunt    ,
@tod_conftr    ,
@tod_cft    ,
@tod_cbm  , 
@tod_ftyprctrm , 
@tod_hkprctrm  , 
@tod_trantrm   ,
@tod_period   ,
@tod_fobport   ,
@tod_retail   ,
@tod_projqty ,  
@tod_ftyshpdatstr,   
@tod_ftyshpdatend ,  
@tod_dsgven   ,
@tod_prdven   ,
@tod_cusven   ,
@tod_imgpth   ,
@tod_sapno   ,
@tod_cuspono  , 
@tod_rmk   ,
@tod_upc    ,
@tod_ctnL   ,
@tod_ctnW  ,  
@tod_ctnH   ,
@tod_ctnupc ,   
@tod_venstk  ,  
@tod_cushpdatstr,    
@tod_cushpdatend ,   
@tod_fcurcde    ,
@tod_ftycst    ,
@tod_curcde   , 
@tod_selprc    ,
@tod_qtyb_cuspo,    
@tod_qtyb_ordqty ,   
@tod_podat    ,
@tod_pcktyp   , 
@tod_qutno    ,
@tod_qutseq   , 
@tod_cntctp,
@tod_basprc,
@tod_qutitmsts,
@tod_markup,			
@tod_mrkprc,			
@tod_mumin,			
@tod_muminprc,
@tod_pckcst,			
@tod_commsn,			
@tod_itmcom,			
@tod_stdprc,			
@tod_adjprc,			
@usrid,
@usrid,
getdate(),
getdate()
)

select @count = count(*) from QUDTLSHP(nolock) where qds_qutno = @tod_qutno and qds_qutseq = @tod_qutseq

if @count <> 0
begin
insert into todtlshp 
select '',@tod_toordno,@seq,@tod_verno,qds_shpseq,qds_ftyshpstr,
	qds_ftyshpend,qds_custshpstr,qds_custshpend,qds_shpqty,null,qds_pckunt,
	@usrid,@usrid,getdate(),getdate(),null from QUDTLSHP(nolock)
where qds_qutno = @tod_qutno and qds_qutseq = @tod_qutseq
end


end









GO
GRANT EXECUTE ON [dbo].[sp_insert_TOORDDTL] TO [ERPUSER] AS [dbo]
GO
