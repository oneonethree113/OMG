/****** Object:  StoredProcedure [dbo].[sp_update_QUPRCEMT_from_Excel]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QUPRCEMT_from_Excel]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QUPRCEMT_from_Excel]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[sp_update_QUPRCEMT_from_Excel] 

@txtyp 			nvarchar(30),     --upd/new 

@qxd_xlsfil		nvarchar(50),     --for query QUXLSDTL
@qxd_fildat		nvarchar(30),     --for query QUXLSDTL
@qxd_cocde		nvarchar(10),
@qxd_qutno		nvarchar(20),

@qxd_qutseq int,		-- excel row# / grip row # ;  not seq# in  QUOTNDTL
@tmp_itmno nvarchar(30),	-- @tmp_dsc nvarchar(300), for demo

@tmp_colcde nvarchar(30),

@tmp_pckunt nvarchar(10),
@tmp_inrqty int,
@tmp_mtrqty int,

@tmp_hkprctrm nvarchar(30),
@tmp_trantrm nvarchar(30),
@tmp_cus1no nvarchar(30),
@tmp_cus2no nvarchar(30),

@tmp_CusAgt nvarchar(30),
@tmp_SalDiv nvarchar(30),
@tmp_SalRep nvarchar(30),
@tmp_Srname nvarchar(30),
@tmp_SmpPrd nvarchar(30),
@tmp_SmpFgt nvarchar(30),
@tmp_Curcde nvarchar(30),
@tmp_PrcTrm nvarchar(30),
@tmp_PayTrm nvarchar(30),

@tmp_Cus1Ad nvarchar(90), 
@tmp_Cus1St nvarchar(90), 
@tmp_Cus1Cy nvarchar(30), 
@tmp_Cus1Zp nvarchar(30), 

@tmp_Cus1Cp nvarchar(30),

@tmp_Cus1CgInt nvarchar(30),
@tmp_Cus1CgExt nvarchar(30),

@tmp_contopc nvarchar(1),
@tmp_qud_ftyprc decimal(13,4),
@tmp_gsUsrID nvarchar(30),
@tmp_case nvarchar(30)

AS

--for VB insert
declare	@new_seq	int
Set  @new_seq = (	select	isnull(max(qud_qutseq),0) + 1
		from	QUOTNDTL
		where	qud_cocde = @qxd_cocde	and
			qud_qutno = @qxd_qutno)

select @new_seq as 'max_seq_insert'

Declare
	@qxd_cat nvarchar (50)  ,
	@qxd_rmk nvarchar (300)  ,
	@qxd_inputdat nvarchar (30)  ,
	@qxd_pricust nvarchar (30)  ,
	@qxd_seccust nvarchar (30)  ,
	@qxd_tmpitm nvarchar (30)  ,
	@qxd_orgum nvarchar (30)  ,
	@qxd_period nvarchar (30)  ,
	@qxd_expdat nvarchar (30)  ,
	@qxd_itmno nvarchar (30)  ,
	@qxd_dsc nvarchar (300)  ,
	@qxd_colcde nvarchar (30)  ,
	@qxd_um nvarchar (30)  ,
	@qxd_inr nvarchar (30)  ,
	@qxd_mtr nvarchar (30)  ,
	@qxd_cft nvarchar (30)  ,
	@qxd_pcftr nvarchar (30)  ,
	@qxd_ccy nvarchar (30)  ,
	@qxd_ftycstA  decimal(13,4)  ,
	@qxd_ftycstB  decimal(13,4)  ,
	@qxd_ftycstC  decimal(13,4)  ,
	@qxd_ftycstD  decimal(13,4)  ,
	@qxd_ftycstE  decimal(13,4)  ,
	@qxd_ftycstTran  decimal(13,4)  ,
	@qxd_ftycstPack  decimal(13,4)  ,
	@qxd_ftycst decimal(13,4)  ,
	@qxd_pckitr nvarchar (300)  ,
	@qxd_inrL nvarchar (30)  ,
	@qxd_inrW nvarchar (30)  ,
	@qxd_inrH nvarchar (30)  ,
	@qxd_mtrL nvarchar (30)  ,
	@qxd_mtrW nvarchar (30)  ,
	@qxd_mtrH nvarchar (30)  ,
	@qxd_inrSize nvarchar (30)  ,
	@qxd_mtrSize nvarchar (30)  ,
	@qxd_lightSpec nvarchar (300)  ,
	@qxd_ftyMU nvarchar (30)  ,
	@qxd_ftyPrc  decimal(13,4)  ,
	@qxd_hkMU nvarchar (30)  ,
	@qxd_basprc nvarchar (30)  ,
	@qxd_prctrm nvarchar (30)  ,
	@qxd_trantrm nvarchar (30)  ,
	@qxd_vdrtranflg nvarchar (30)  ,
	@qxd_MU nvarchar (30)  ,
	@qxd_pckcst nvarchar (30)  ,
	@qxd_comm nvarchar (30)  ,
	@qxd_itmcomm nvarchar (30)  ,
	@qxd_stdprc nvarchar (30)  ,
	@qxd_cushcstbuf nvarchar (30)  ,
	@qxd_othdislmt nvarchar (30)  ,
	@qxd_maxdis nvarchar (30)  ,
	@qxd_lowerMU nvarchar (30)  ,
	@qxd_adjMU nvarchar (30)  ,
	@qxd_adjprc nvarchar (30)  ,
	@qxd_msg nvarchar (300)  ,
	@qxd_txtyp nvarchar (10)  ,
	@qxd_sts nvarchar (10)  ,
	@qxd_cus1no nvarchar (10)  ,
	@qxd_cus2no nvarchar (10)  ,
	@qxd_venno nvarchar(6),
	@qxd_vensna nvarchar(40),
	@qxd_vencolcde nvarchar(30),
	@qxd_Toshipport  nvarchar(50),
	@qxd_Toshipdatefrom  datetime ,
	@qxd_Toshipdateto  datetime ,
	@qxd_ToCUSshipdatefrom  datetime ,
	@qxd_ToCUSshipdateto  datetime ,
	@qxd_Toqty  int ,
	@qxd_Tormk  nvarchar(500),
	 @flag_exist_hdr   int,
	 @flag_exist_itm   int,
	@real_itmno nvarchar (30)  ,
	@qxd_creusr	nvarchar(30)
	
-- Start: Do the Temp Item to Real Item Mapping First
	
-- End: Do the Temp Item to Real Item Mapping First

select 1 as "Flag1.1"

Select
*
from QUXLSDTL
where qxd_xlsfil = @qxd_xlsfil 
and  qxd_fildat = @qxd_fildat
and  qxd_vencolcde= @tmp_colcde                     -- recheck
and  Left(qxd_prctrm,3)=Left(@tmp_hkprctrm,3)

select  @tmp_colcde     as 'tmp colcde'

-- get data from  QUXLSDTL
Select
@qxd_cat=qxd_cat,
@qxd_rmk=qxd_rmk,			-- hidden
@qxd_inputdat=qxd_inputdat,		-- hidden
@qxd_pricust=qxd_pricust,
@qxd_seccust=qxd_seccust,		-- hidden
@qxd_tmpitm=qxd_tmpitm,		-- hidden
@qxd_orgum=qxd_orgum,
@qxd_period=qxd_period,
@qxd_expdat=qxd_expdat,		-- hidden
@qxd_itmno=qxd_itmno,
@qxd_dsc=qxd_dsc,
@qxd_colcde=isnull(qxd_colcde,'N/A'),
@qxd_um=qxd_um,
@qxd_inr=qxd_inr,
@qxd_mtr=qxd_mtr,
@qxd_cft=qxd_cft,
@qxd_pcftr=qxd_pcftr,
@qxd_ccy=qxd_ccy,
@qxd_ftycstA=Cast(qxd_ftycstA as decimal(13,4))  ,
@qxd_ftycstB=Cast(qxd_ftycstB as decimal(13,4))  ,
@qxd_ftycstC=Cast(qxd_ftycstC as decimal(13,4))  ,
@qxd_ftycstD=Cast(qxd_ftycstD as decimal(13,4))  ,
@qxd_ftycstE=Cast(qxd_ftycstE as decimal(13,4))  ,
@qxd_ftycstTran=qxd_ftycstTran,
@qxd_ftycstPack=qxd_ftycstPack,
@qxd_ftycst=Cast(qxd_ftycst as decimal(13,4))  ,
@qxd_pckitr=qxd_pckitr,		-- hidden
@qxd_inrL=qxd_inrL,			-- hidden
@qxd_inrW=qxd_inrW,			-- hidden
@qxd_inrH=qxd_inrH,			-- hidden
@qxd_mtrL=qxd_mtrL,			-- hidden
@qxd_mtrW=qxd_mtrW,		-- hidden
@qxd_mtrH=qxd_mtrH,		-- hidden
@qxd_inrSize=qxd_inrSize,		-- hidden
@qxd_mtrSize=qxd_mtrSize,		-- hidden
@qxd_lightSpec=qxd_lightSpec,	-- hidden
@qxd_ftyMU=qxd_ftyMU,
@qxd_ftyPrc=Cast(qxd_ftyprc as decimal(13,4))  ,
@qxd_hkMU=qxd_hkMU,
@qxd_basprc=qxd_basprc,
@qxd_prctrm=qxd_prctrm,
@qxd_trantrm=qxd_trantrm,
@qxd_vdrtranflg=qxd_vdrtranflg,
@qxd_MU=qxd_MU,
@qxd_pckcst=qxd_pckcst,
@qxd_comm=qxd_comm,
@qxd_itmcomm=qxd_itmcomm,
@qxd_stdprc=qxd_stdprc,
@qxd_cushcstbuf=qxd_cushcstbuf,
@qxd_othdislmt=qxd_othdislmt,
@qxd_maxdis=qxd_maxdis,
@qxd_lowerMU=qxd_lowerMU,
@qxd_adjMU=qxd_adjMU,
@qxd_adjprc=qxd_adjprc,
@qxd_msg=qxd_msg,
@qxd_txtyp=qxd_txtyp,
@qxd_sts=qxd_sts,
@qxd_cus1no=qxd_cus1no,
@qxd_cus2no=qxd_cus2no,
@qxd_venno =qxd_venno,
@qxd_vensna =qxd_vensna,
@qxd_vencolcde =qxd_vencolcde,
@qxd_Toshipport =qxd_Toshipport,
@qxd_Toshipdatefrom  =qxd_Toshipdatefrom ,
@qxd_Toshipdateto =qxd_Toshipdateto,
@qxd_ToCUSshipdatefrom  =qxd_ToCUSshipdatefrom ,
@qxd_ToCUSshipdateto =qxd_ToCUSshipdateto,
@qxd_Toqty =qxd_Toqty ,
@qxd_Tormk =qxd_Tormk,
@qxd_creusr = qxd_creusr
from QUXLSDTL
where qxd_xlsfil = @qxd_xlsfil 
and  qxd_fildat = @qxd_fildat
and  (qxd_qutno=@qxd_qutno  or qxd_qutno='' or qxd_qutno is null)
and  qxd_cocde=@qxd_cocde
and  qxd_itmno =@tmp_itmno 
and  qxd_vencolcde= @tmp_colcde                     -- recheck
--and  ( ( qxd_um=@tmp_pckunt			 
--and qxd_inr =@tmp_inrqty
--and  qxd_mtr =@tmp_mtrqty)
--	 OR 
--	(@tmp_pckunt='ST')
--)
		and ( 
			(qxd_um = @tmp_pckunt and qxd_inr =@tmp_inrqty	and   qxd_mtr =@tmp_mtrqty)
			OR
			(  
			      left(qxd_orgum,2)='ST'
			    and qxd_um='PC'
			    and cast(right(qxd_orgum,(len(qxd_orgum)-2)) as int)*@tmp_inrqty =qxd_inr	
			    and cast(right(qxd_orgum,(len(qxd_orgum)-2)) as int)*@tmp_mtrqty =qxd_mtr	
			)
		          )
and  Left(qxd_prctrm,3)=Left(@tmp_hkprctrm,3)
and  qxd_trantrm=@tmp_trantrm

select 1 as "Flag1.2"

Select
*
from QUXLSDTL
where qxd_xlsfil = @qxd_xlsfil 
and  qxd_fildat = @qxd_fildat
--and  (qxd_qutno=@qxd_qutno  or qxd_qutno='' or qxd_qutno is null)
and  qxd_cocde=@qxd_cocde
and  qxd_itmno =@tmp_itmno 
and  qxd_vencolcde= @tmp_colcde                     -- recheck
--and  ( ( qxd_um=@tmp_pckunt			 
--and qxd_inr =@tmp_inrqty
--and  qxd_mtr =@tmp_mtrqty)
--	 OR 
--	(@tmp_pckunt='ST')
--)
		and ( 
			(qxd_um = @tmp_pckunt and qxd_inr =@tmp_inrqty	and   qxd_mtr =@tmp_mtrqty)
			OR
			(  
			      left(qxd_orgum,2)='ST'
			    and qxd_um='PC'
			    and cast(right(qxd_orgum,(len(qxd_orgum)-2)) as int)*@tmp_inrqty =qxd_inr	
			    and cast(right(qxd_orgum,(len(qxd_orgum)-2)) as int)*@tmp_mtrqty =qxd_mtr	
			)
		          )
and  Left(qxd_prctrm,3)=Left(@tmp_hkprctrm,3)
and  qxd_trantrm=@tmp_trantrm


select 1 as "Flag1.22222222222"


select *  
from QUXLSDTL
where qxd_xlsfil = @qxd_xlsfil 
and  qxd_fildat = @qxd_fildat
--and  qxd_qutno=@qxd_qutno
and  qxd_cocde=@qxd_cocde
and  qxd_itmno =@tmp_itmno 
and  qxd_vencolcde= @tmp_colcde                     -- recheck
--and  ( ( qxd_um=@tmp_pckunt			 
--and qxd_inr =@tmp_inrqty
--and  qxd_mtr =@tmp_mtrqty)
--	 OR 
--	(@tmp_pckunt='ST')
--)
		and ( 
			(qxd_um = @tmp_pckunt and qxd_inr =@tmp_inrqty	and   qxd_mtr =@tmp_mtrqty)
			OR
			(  
			      left(qxd_orgum,2)='ST'
			    and qxd_um='PC'
			    and cast(right(qxd_orgum,(len(qxd_orgum)-2)) as int)*@tmp_inrqty =qxd_inr	
			    and cast(right(qxd_orgum,(len(qxd_orgum)-2)) as int)*@tmp_mtrqty =qxd_mtr	
			)
		          )
and  left(qxd_prctrm,3)=Left(@tmp_hkprctrm,3)
and  qxd_trantrm=@tmp_trantrm


select 1 as "Flag1AAAAAAAAAAAAA"
-------------------------------
---For Sts
-------------------------------
Declare @qud_apprval as nchar(1)
Declare @qud_qutsts2 as nchar(1)
Declare @quh_qutsts2 as nchar(1)

if cast(@qxd_adjMU as decimal(13,4))>cast(@qxd_lowerMU as decimal(13,4))
begin
set @qud_apprval ='Y'
set @qud_qutsts2 ='A'
select 'xxx' as 'xxx'
end 
else
begin
set @qud_apprval ='N'
set @qud_qutsts2 ='W'
set @quh_qutsts2 ='W'
select 'yyy' as 'yyy'
end

-------------------------------
select @qxd_MU as '@qxd_MU'
select @qxd_lowerMU as '@qxd_lowerMU'





---cus2 INF start
declare @quh_cus2ad	nvarchar(200)
declare @quh_cus2st	nvarchar(20)
declare @quh_cus2cy	nvarchar(20)
declare @quh_cus2zp	nvarchar(20)
declare @quh_cus2cp	nvarchar(50)

if @tmp_cus2no = '' or @tmp_cus2no is null
begin
	set @quh_cus2ad = ''
	set @quh_cus2st = ''
	set @quh_cus2cy = ''
	set @quh_cus2zp = ''
	set @quh_cus2cp = ''
end
else
begin
	set @quh_cus2ad = isnull((select top 1 cci_cntadr from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @tmp_cus2no and cci_cnttyp = 'm'),'')
	set @quh_cus2st = isnull((select top 1 cci_cntstt from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @tmp_cus2no and cci_cnttyp = 'm'),'')
	set @quh_cus2cy = isnull((select top 1cci_cntcty from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @tmp_cus2no and cci_cnttyp = 'm'),'')
	set @quh_cus2zp = isnull((select top 1 cci_cntpst from CUCNTINF where --cci_cocde = @quh_cocde and 
								cci_cusno = @tmp_cus2no and cci_cnttyp = 'm'),'')

	set @quh_cus2cp = isnull((select top 1 cci_cntctp from CUCNTINF where --cci_cocde = @quh_cocde and 
									cci_cusno = @tmp_cus2no and cci_cnttyp = 'BUYR' and cci_delete <> 'Y'and cci_cntdef = 'Y'),'')
	if @quh_cus2cp = '' 
		set @quh_cus2cp = isnull((select top 1 cci_cntctp from CUCNTINF where --cci_cocde = @quh_cocde and 
									cci_cusno = @tmp_cus2no and cci_cnttyp = 'SALE' and cci_delete <> 'Y' and cci_cntdef = 'Y'),'')

	if @quh_cus2cp = '' 
		set @quh_cus2cp = isnull((select top 1 cci_cntctp from CUCNTINF where --cci_cocde = @quh_cocde and 
									cci_cusno = @tmp_cus2no and cci_cnttyp = 'MAGT' and cci_delete <> 'Y' and cci_cntdef = 'Y'),'')

	if @quh_cus2cp = '' 
		set @quh_cus2cp = isnull((select top 1 cci_cntctp from CUCNTINF where --cci_cocde = @quh_cocde and 
									cci_cusno = @tmp_cus2no and cci_delete <> 'Y' and cci_cntdef = 'Y'),'')

end 
---cus2 INF End

declare @seq_num_cuitmprcdtl as int

select @txtyp as '@txtyp'

if @txtyp='UPD'
begin
--select 1 as "Flag1"
--select 1 as "Flag1"
select 1 as "Flag1"

if  @quh_qutsts2 ='W'  
begin 
	update QUOTNHDR
	set quh_cus2no =@qxd_seccust,
	       quh_qutsts=@quh_qutsts2
	where   quh_qutno=@qxd_qutno
	and  quh_cocde=@qxd_cocde
end
else
begin
	update QUOTNHDR
	set quh_cus2no =@qxd_seccust
	where   quh_qutno=@qxd_qutno
	and  quh_cocde=@qxd_cocde
end


---------------
--1
select qud_qutseq 
from quotndtl
where   qud_qutno=@qxd_qutno
	and  qud_cocde=@qxd_cocde
	and  qud_colcde=@tmp_colcde
	and  qud_itmno= @tmp_itmno 
	and  (
			( qud_untcde=@tmp_pckunt
			and qud_inrqty =@tmp_inrqty	
			and  qud_mtrqty =@tmp_mtrqty 
			 
				)
		)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)
	and  qud_trantrm=@tmp_trantrm


-------------

select  qud_contopc,qud_conftr,qud_pcprc,qud_untcde, qud_inrqty,qud_mtrqty,* from quotndtl
	where   qud_qutno=@qxd_qutno
	and  qud_cocde=@qxd_cocde
	and  qud_colcde=@tmp_colcde
	and  qud_itmno= @tmp_itmno 
	and  (
			( qud_untcde=@tmp_pckunt
			and qud_inrqty =@tmp_inrqty	
			and  qud_mtrqty =@tmp_mtrqty 
			--and qud_contopc <>'Y'
				)
		      --  OR
			 
			--(--qud_inrqty =isnull(qud_conftr,1)*@tmp_inrqty	
			 --and  qud_mtrqty =isnull(qud_conftr,1)*@tmp_mtrqty 
			--and 
			--qud_contopc ='Y'
			-- and left(qud_untcde,2)='ST'
			  -- and @tmp_pckunt='PC'
		           --    )
		)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)
	and  qud_trantrm=@tmp_trantrm


-------------------------------
--Update ItmSts & qutsts
-------------------------------

 
-------------------------------


	update	QUOTNDTL  
	set 
	--qud_cocde=@qxd_cocde,
	--qud_qutno=@qxd_qutno,
	--qud_qutseq=@qxd_qutseq,
	--qud_itmno=@qxd_itmno,
	qud_itmdsc=@qxd_dsc,
	qud_imrmk = @qxd_rmk,
	--qud_qutdat = isnull( @qxd_inputdat,'01/01/1900'),
	--qud_cus2no = @qxd_seccust,
	qud_expdat = left(isnull(@qxd_expdat,'01/01/1900'),10) + ' 23:59:00.000',
	qud_inrdin = @qxd_inrL,
	qud_inrwin = @qxd_inrW,
	qud_inrhin = @qxd_inrH,
	qud_mtrdin = @qxd_mtrL,
	qud_mtrwin = @qxd_mtrW,
	qud_mtrhin = @qxd_mtrH,
	qud_apprve=@qud_apprval,
	qud_qutitmsts=@qud_qutsts2,
 	--qud_itmtyp=	case @qxd_pcftr when  '1' then	"REG"	else	"ASS"		end,
 	--qud_conftr=@qxd_pcftr,
 	qud_contopc=@tmp_contopc,
	--qud_untcde=@qxd_um,
	--qud_inrqty=@qxd_inr,
	--qud_mtrqty=@qxd_mtr,
	qud_cft=@qxd_cft,
	qud_ftycst=@qxd_ftycst,
	qud_smpprc =cast(@qxd_adjprc as decimal(13,4))/ cast(qud_conftr  as int),
	qud_pcprc =cast(@qxd_adjprc as decimal(13,4))/ cast(qud_conftr  as int),
	qud_cus1dp	=@qxd_adjprc,   -- name
	qud_cus1sp	=@qxd_stdprc,   -- name
	qud_cus1no=isnull(@qxd_cus1no,''),
	qud_pckitr = @qxd_pckitr,
	qud_fcurcde=@qxd_ccy,
	qud_basprc=@qxd_basprc,  --20140123
 	qud_ftyprc=@qxd_ftyprc,  --20140123
--	qud_pckseq=@qxd_pckseq,
--	qud_itmsts=@qxd_itmsts,
--	qud_qutitmsts=@qxd_qutitmsts,
	qud_venno=@qxd_venno,       -- new field in excel 
	qud_colcde=@qxd_vencolcde,       -- not colcde 
	qud_Toshipport=@qxd_Toshipport,       -- not colcde 
	qud_ftyshpstr=@qxd_Toshipdatefrom,       -- not colcde 
	qud_ftyshpend=@qxd_Toshipdateto,       -- not colcde 
	qud_cushpstr=@qxd_ToCUSshipdatefrom,       -- not colcde 
	qud_cushpend=@qxd_ToCUSshipdateto,       -- not colcde 
	qud_Toqty=@qxd_Toqty,       -- not colcde 
	qud_Tormk=@qxd_Tormk       -- not colcde 
--	qud_coldsc=@qxd_coldsc,
	--qud_qutdat=getdate()                -- update date ??
---	qud_creusr=@qxd_creusr,
---	qud_updusr=@qxd_updusr
	where   qud_qutno=@qxd_qutno
	and  qud_cocde=@qxd_cocde
	and  qud_itmno= @tmp_itmno 
	and  qud_colcde=@qxd_vencolcde
	and  (
			( qud_untcde=@tmp_pckunt
			and qud_inrqty =@tmp_inrqty	
			and  qud_mtrqty =@tmp_mtrqty 
			--and qud_contopc <>'Y'
				)
		    ---    OR
			 
			--(qud_inrqty =isnull(qud_conftr,1)*@tmp_inrqty	
			 --and  qud_mtrqty =isnull(qud_conftr,1)*@tmp_mtrqty 
			--and qud_contopc ='Y'
			-- and left(qud_untcde,2)='ST'
			  -- and @tmp_pckunt='PC'
		          --     )
		)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)
	and  qud_trantrm=@tmp_trantrm



	-- same condition as above update
	
	if round(@tmp_qud_ftyprc,2) <>round(@qxd_ftyprc,2)  --Basic Price Different
   		and @tmp_qud_ftyprc <> 0
	begin
		update	QUOTNDTL  
		set qud_qutitmsts = 'TBC',
    		qud_apprve = 'N'	
	where   qud_qutno=@qxd_qutno
	and  qud_cocde=@qxd_cocde
	and  qud_itmno= @tmp_itmno 
	and  qud_colcde=@qxd_vencolcde
	and  (
			( qud_untcde=@tmp_pckunt
			and qud_inrqty =@tmp_inrqty	
			and  qud_mtrqty =@tmp_mtrqty 
			--and qud_contopc <>'Y'
				)
		    ---    OR
			 
			--(qud_inrqty =isnull(qud_conftr,1)*@tmp_inrqty	
			 --and  qud_mtrqty =isnull(qud_conftr,1)*@tmp_mtrqty 
			--and qud_contopc ='Y'
			-- and left(qud_untcde,2)='ST'
			  -- and @tmp_pckunt='PC'
		          --     )
		)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)
	and  qud_trantrm=@tmp_trantrm


	end




--CIH

declare @quh_year nvarchar(20)
declare @quh_season nvarchar(20)
declare @quh_cus1no nvarchar(10)
declare @quh_cus2no nvarchar(10)

select @quh_year = quh_year, @quh_season = quh_season, @quh_cus1no = quh_cus1no, @quh_cus2no = quh_cus2no from QUOTNHDR (nolock) where quh_cocde = @qxd_cocde and quh_qutno = @qxd_qutno

declare @cis_flg as char(1)

declare @cis_key_cocde as nvarchar(10)
declare @cis_key_cusno as nvarchar(10)
declare @cis_key_seccus as nvarchar(10)
declare @cis_key_itmno as nvarchar(20)
declare @cis_key_colcde as nvarchar(30)
declare @cis_key_untcde as nvarchar(10)
declare @cis_key_conftr as int
declare @cis_key_inrqty as int
declare @cis_key_mtrqty as int
declare @cis_key_hkprctrm as nvarchar(10)
declare @cis_key_ftyprctrm as nvarchar(10)
declare @cis_key_trantrm as nvarchar(10)

declare @qud_cocde nvarchar(6),	@qud_qutno  nvarchar(20),	@qud_qutseq  int,  
@qud_itmno  nvarchar(20),	@qud_itmsts  nvarchar(4),	@qud_itmdsc  nvarchar(800),  
@qud_alsitmno nvarchar(20),	@qud_alscolcde nvarchar(20),	@qud_conftr numeric(9),
@qud_contopc nvarchar(1),	@qud_pcprc numeric(13,4),	@qud_hstref  nvarchar(20),
@qud_colcde  nvarchar(30),	@qud_cuscol  nvarchar(30),	@qud_coldsc  nvarchar(300),
@qud_pckseq  int,		@qud_untcde  nvarchar(6),	@qud_inrqty  int,
@qud_mtrqty  int,		@qud_cft numeric(11,4),	@qud_curcde  nvarchar(6),
@qud_cus1sp  numeric(13,4),	@qud_cus2sp numeric(13,4),	@qud_cus1dp  numeric(13,4),
@qud_cus2dp  numeric(13,4),	@qud_onetim  nvarchar(1),	@qud_discnt  numeric(6,3),   
@qud_moflag char(1),		@qud_orgmoq  int,		@qud_orgmoa numeric(11,4),
@qud_moq  int,		@qud_moa  numeric(11,4),	@qud_smpqty  int,
@qud_hrmcde  nvarchar(12),	@qud_dtyrat  numeric(6,3),	@qud_dept  nvarchar(20),
@qud_cususd  numeric(13,4),	@qud_cuscad  numeric(13,4),	@qud_venno  nvarchar(6),
@qud_subcde nvarchar(10),	@qud_venitm  nvarchar(20),	@qud_ftyprc  numeric(13,4),
@qud_ftycst  numeric(13,4),	@qud_note  nvarchar(300),	@qud_image  nvarchar(1),
@qud_inrdin  numeric(11,4),	@qud_inrwin  numeric(11,4),	@qud_inrhin  numeric(11,4),
@qud_mtrdin  numeric(11,4),	@qud_mtrwin  numeric(11,4),	@qud_mtrhin  numeric(11,4),
@qud_inrdcm  numeric(11,4),	@qud_inrwcm  numeric(11,4),	@qud_inrhcm  numeric(11,4),
@qud_mtrdcm  numeric(11,4),	@qud_mtrwcm  numeric(11,4),	@qud_mtrhcm  numeric(11,4),
@qud_grswgt  numeric(6,3),	@qud_netwgt  numeric(6,3),	@qud_cosmth  nvarchar(50),
@qud_smpprc numeric(13,4),	@qud_cusitm nvarchar(20),	@cus1no  nvarchar(6),
@cus1na  nvarchar(20),	@cus2no  nvarchar(6),		@cus2na  nvarchar(20),
@qud_prcsec nvarchar(3),	@qud_grsmgn numeric(6,3),	@qud_basprc numeric(13,4),
@qud_tbm nvarchar(1),	@qud_tbmsts nvarchar(3),	@rvsdat  datetime,
@qud_apprve nvarchar(1),	
--@qud_pdabpdiff nvarchar(1),	
@qud_pckitr nvarchar(300),
@qud_stkqty int,		@qud_cusqty int,		@qud_smpunt nvarchar(6),
@qud_qutitmsts nvarchar(25),	@qud_fcurcde nvarchar(6),	
--@smpprd nvarchar(6),
@qud_itmtyp nvarchar(4),	@quh_qutsts nvarchar(10),	@qud_prctrm nvarchar(10),
@qud_cusven varchar(6),	@qud_cussub varchar(10),	@qud_ftyprctrm varchar(20),
@qud_cusstyno nvarchar(50),	@qud_cbm numeric(11, 4),	@qud_upc nvarchar(50),
@qud_specpck nvarchar(255),	@qud_ftytmpitm nvarchar(1),	@qud_ftytmpitmno nvarchar(20),
@qud_custitmcat nvarchar(12),	@qud_custitmcatfml nvarchar(6),	@qud_custitmcatamt numeric(13,4),
@qud_pmu nvarchar(100),	@qud_imrmk nvarchar(255),	@qud_rndsts nvarchar(255),
@qud_calpmu numeric(13,4),	@qud_moqunttyp nvarchar(6),	@qud_qutdat datetime,
@qud_cus1no nvarchar(6),	@qud_cus2no nvarchar(6),	@qud_trantrm nvarchar(10),
@qud_effdat datetime,		@qud_expdat datetime,	@qud_itmnotyp nvarchar(1),
@qud_itmnoreal nvarchar(20),	@qud_itmnotmp nvarchar(20),	@qud_itmnoven nvarchar(20),
@qud_itmnovenno nvarchar(6),	@qud_imgpth nvarchar(200),	@qud_cususdcur nvarchar(6),
@qud_cuscadcur nvarchar(6),	@qud_dv	nvarchar(10),
@qud_tv	nvarchar(10),
@qud_ftyaud	nvarchar(10),
@qud_buyer	nvarchar(20),
@qud_toqty	int,
@qud_toshipport	nvarchar(50),
@qud_tormk	nvarchar(300),
@qud_ftyshpstr	datetime,
@qud_ftyshpend	datetime,
@qud_cushpstr	datetime,
@qud_cushpend	datetime,
@qud_creusr	nvarchar(30)

select @qud_qutseq = qud_qutseq
from quotndtl (nolock)
where   qud_qutno=@qxd_qutno
	and  qud_cocde=@qxd_cocde
	and  qud_itmno= @tmp_itmno 
	and  qud_colcde= @tmp_colcde
	and  (	( qud_untcde=@tmp_pckunt
			and qud_inrqty =@tmp_inrqty	
			and  qud_mtrqty =@tmp_mtrqty )	)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)
	and  qud_trantrm=@tmp_trantrm

set @qud_qutno = @qxd_qutno
set @qud_cocde = @qxd_cocde

select 
@qud_itmno = qud_itmno,	@qud_itmsts = qud_itmsts,	@qud_itmdsc = qud_itmdsc,  
@qud_alsitmno = qud_alsitmno,	@qud_alscolcde = qud_alscolcde,	@qud_conftr = qud_conftr,
@qud_contopc = qud_contopc,	@qud_pcprc = qud_pcprc,		@qud_hstref = qud_hstref,
@qud_colcde = qud_colcde,	@qud_cuscol = qud_cuscol,	@qud_coldsc = qud_coldsc,
@qud_pckseq = qud_pckseq,	@qud_untcde = qud_untcde,	@qud_inrqty = qud_inrqty,
@qud_mtrqty = qud_mtrqty,	@qud_cft = qud_cft,		@qud_curcde = qud_curcde,
@qud_cus1sp = qud_cus1sp,	@qud_cus2sp = qud_cus2sp,	@qud_cus1dp = qud_cus1dp,
@qud_cus2dp = qud_cus2dp,	@qud_onetim = qud_onetim,	@qud_discnt = qud_discnt,
@qud_moq = qud_moq,	@qud_moa = qud_moa,			@qud_smpqty = qud_smpqty,
@qud_hrmcde = qud_hrmcde,	@qud_dtyrat = qud_dtyrat,	@qud_dept = qud_dept,
@qud_cususd = qud_cususd,	@qud_cuscad = qud_cuscad,	@qud_venno = qud_venno,
@qud_venitm = qud_venitm,	@qud_ftyprc = qud_ftyprc,	@qud_note = qud_note,
@qud_image = qud_image,	@qud_inrdin = qud_inrdin,		@qud_inrwin = qud_inrwin,
@qud_inrhin = qud_inrhin,	@qud_mtrdin = qud_mtrdin,	@qud_mtrwin = qud_mtrwin,
@qud_mtrhin = qud_mtrhin,	@qud_inrdcm = qud_inrdcm,	@qud_inrwcm = qud_inrwcm,
@qud_inrhcm = qud_inrhcm,	@qud_mtrdcm = qud_mtrdcm,	@qud_mtrwcm = qud_mtrwcm,
@qud_mtrhcm = qud_mtrhcm,	@qud_grswgt = qud_grswgt,	@qud_netwgt = qud_netwgt,
@qud_cosmth = qud_cosmth,	
@qud_smpprc = qud_smpprc,	@qud_cusitm = qud_cusitm,	@qud_prcsec = qud_prcsec,
@qud_grsmgn = qud_grsmgn,	@qud_basprc = qud_basprc,	@qud_tbm = qud_tbm,
@qud_tbmsts = qud_tbmsts,	@qud_apprve = qud_apprve,	
@qud_pckitr = qud_pckitr,	@qud_stkqty = qud_stkqty,	@qud_cusqty = qud_cusqty,
@qud_smpunt = qud_smpunt,	@qud_qutitmsts = qud_qutitmsts,	@qud_fcurcde = qud_fcurcde,
@qud_itmtyp = qud_itmtyp,	@qud_subcde = qud_subcde,	@qud_ftycst = qud_ftycst,
@qud_prctrm = qud_prctrm,	@qud_moflag = qud_moflag,	@qud_orgmoq = qud_orgmoq,
@qud_orgmoa = qud_orgmoa,	@qud_cusven = qud_cusven,	@qud_cussub  = qud_cussub,
@qud_ftyprctrm = qud_ftyprctrm,	@qud_cusstyno = isnull(qud_cusstyno ,''),	@qud_cbm = qud_cbm,
@qud_upc = qud_upc,		@qud_specpck = qud_specpck,	@qud_ftytmpitm = qud_ftytmpitm,
@qud_ftytmpitmno = isnull(qud_ftytmpitmno,''),	
@qud_custitmcat = qud_custitmcat,	@qud_custitmcatfml = qud_custitmcatfml,
@qud_custitmcatamt = qud_custitmcatamt,	@qud_pmu = qud_pmu,	@qud_imrmk = qud_imrmk,
@qud_rndsts = qud_rndsts,	@qud_calpmu = qud_calpmu,	@qud_moqunttyp = qud_moqunttyp,
@qud_qutdat = qud_qutdat,	@qud_cus1no = qud_cus1no,	@qud_cus2no = qud_cus2no,
@qud_trantrm = qud_trantrm,	@qud_effdat = qud_effdat,	@qud_expdat = qud_expdat,
@qud_itmnotyp = qud_itmnotyp,	@qud_itmnoreal = qud_itmnoreal,	@qud_itmnotmp = qud_itmnotmp,
@qud_itmnoven = qud_itmnoven,	@qud_itmnovenno = qud_itmnovenno,	@qud_imgpth = qud_imgpth,
@qud_cususdcur = qud_cususdcur,	
@qud_cuscadcur = qud_cuscadcur,
@qud_dv=qud_dv,
@qud_tv=qud_tv,
@qud_ftyaud=qud_ftyaud,
@qud_buyer=qud_buyer,
@qud_toqty=qud_toqty,
@qud_toshipport=qud_toshipport,
@qud_tormk=qud_tormk,
@qud_ftyshpstr=qud_ftyshpstr,
@qud_ftyshpend=qud_ftyshpend,
@qud_cushpstr=qud_cushpstr,
@qud_cushpend=qud_cushpend
from quotndtl (nolock)
where qud_cocde = @qxd_cocde
and qud_qutno = @qxd_qutno
and qud_qutseq = @qud_qutseq




if @qud_itmnoreal <> '' and @qud_qutitmsts = 'A' --and @quh_qutsts = 'A' and @qud_qutitmsts = 'A - Active'	and (@qud_apprve = '' or @qud_apprve = 'Y')
	set @cis_flg = 'Y'
else
	set @cis_flg = 'N'

if @cis_flg = 'Y'
begin
	-- Insert / Update CUITMHIS
	set @cis_key_cocde = @qxd_cocde
	set @cis_key_cusno = @quh_cus1no
	set @cis_key_seccus = @quh_cus2no
	set @cis_key_itmno = @qud_itmnoreal
	set @cis_key_colcde = @qud_colcde
	set @cis_key_untcde = @tmp_pckunt
	set @cis_key_conftr = @qud_conftr
	set @cis_key_inrqty = @tmp_inrqty
	set @cis_key_mtrqty = @tmp_mtrqty
	set @cis_key_hkprctrm = @tmp_hkprctrm
	set @cis_key_ftyprctrm = @qud_ftyprctrm
	set @cis_key_trantrm = @tmp_trantrm

	select @cus1na = isnull(cbi_cussna,'') from CUBASINF (nolock) where cbi_cusno = @quh_cus1no
	select @cus2na = isnull(cbi_cussna,'') from CUBASINF (nolock) where cbi_cusno = @quh_cus2no

	declare @Itmventyp char(1)
    
	--- Get Item Vendor Type ---  
	set @Itmventyp = isnull(
				(SELECT	VBI_VENTYP    
				 FROM	IMBASINF (NOLOCK)   
				 LEFT JOIN VNBASINF (NOLOCK) ON VBI_VENNO = IBI_VENNO  
				 WHERE	IBI_ITMNO = @qud_itmnoreal	and
					VBI_VENTYP IS NOT NULL)
			,' ')  
	

	if ((select count(*) from CUITMHIS (nolock) 
			where cis_cocde = @cis_key_cocde and
				cis_cusno = @cis_key_cusno and
				cis_seccus = @cis_key_seccus and
				cis_itmno = @cis_key_itmno and
				cis_colcde = @cis_key_colcde and
				cis_untcde = @cis_key_untcde and
				cis_conftr = @cis_key_conftr and
				cis_inrqty = @cis_key_inrqty and
				cis_mtrqty = @cis_key_mtrqty and
				left(cis_hkprctrm,3) = left(@cis_key_hkprctrm,3) and
				left(cis_ftyprctrm,3) = left(@cis_key_ftyprctrm,3) and
				cis_trantrm = @cis_key_trantrm ) = 0 )
	begin
		---20140224
		if @qxd_creusr <> NULL  
		begin
			insert into CUITMHIS
			(cis_cocde,cis_cusno,cis_cussna,cis_seccus,cis_secsna,
			cis_itmno,cis_itmdsc,cis_cusitm,cis_colcde,cis_coldsc,
			cis_cuscol,cis_untcde,cis_conftr,cis_inrqty,cis_mtrqty,
			cis_cft,cis_cbm,cis_venno,cis_prdven,cis_cusven,
			cis_tradeven,cis_examven,cis_hkprctrm,cis_ftyprctrm,
			cis_trantrm,cis_cus1no,cis_cus2no,cis_refdoc,cis_docdat,
			cis_qutno,cis_qutseq,cis_cussku,cis_ordqty,cis_moqchg,
			cis_hrmcde,cis_dtyrat,cis_dept,cis_typcode,cis_code1,
			cis_code2,cis_code3,cis_cususdcur,cis_cususd,cis_cuscadcur,
			cis_cuscad,cis_inrdin,cis_inrwin,cis_inrhin,cis_mtrdin,
			cis_mtrwin,cis_mtrhin,cis_inrdcm,cis_inrwcm,cis_inrhcm,
			cis_mtrdcm,cis_mtrwcm,cis_mtrhcm,cis_pckitr,cis_itmventyp,
			cis_tirtyp,cis_moqunttyp,cis_moq,cis_moacur,cis_moa,
			cis_contopc,cis_pcprc,cis_ftytmpitm,cis_cusstyno,cis_year,
			cis_season,cis_creusr,cis_updusr,cis_credat,cis_upddat)
			values
			(@cis_key_cocde,@cis_key_cusno,@cus1na,@cis_key_seccus,@cus2na,
			@cis_key_itmno,@qxd_dsc,@qud_cusitm,@cis_key_colcde,@qud_coldsc,
			@qud_cuscol,@cis_key_untcde,@cis_key_conftr,@cis_key_inrqty,@cis_key_mtrqty,
			@qud_cft,@qud_cbm,ltrim(rtrim(@qud_dv)),ltrim(rtrim(@qud_venno)),ltrim(rtrim(@qud_cusven)),
			ltrim(rtrim(@qud_tv)),ltrim(rtrim(@qud_ftyaud)),@cis_key_hkprctrm,@cis_key_ftyprctrm,
			@cis_key_trantrm,@qud_cus1no,@qud_cus2no,@qud_qutno,@rvsdat,
			@qud_qutno,@qud_qutseq,'',0,0,
			@qud_hrmcde,@qud_dtyrat,@qud_dept,'U','',
			'','',@qud_cususdcur,@qud_cususd,@qud_cuscadcur,
			@qud_cuscad,@qud_inrdin,@qud_inrwin,@qud_inrhin,@qud_mtrdin,
			@qud_mtrwin,@qud_mtrhin,@qud_inrdcm,@qud_inrwcm,@qud_inrhcm,
			@qud_mtrdcm,@qud_mtrwcm,@qud_mtrhcm,@qud_pckitr,@ItmVenTyp,
			1,@qud_moqunttyp,@qud_moq,@qud_curcde,@qud_moa,
			@qud_contopc,@qud_pcprc,@qud_ftytmpitm,@qud_cusstyno,@quh_year,
			@quh_season,@qxd_creusr,@qxd_creusr,getdate(),getdate())
		end
	end
	else
	begin
		update CUITMHIS	set
		cis_itmdsc = @qud_itmdsc, 
		cis_cusitm = @qud_cusitm, 
		cis_coldsc = @qud_coldsc, 
		cis_cuscol = @qud_cuscol, 
		cis_cft = @qud_cft, 
		cis_cbm = @qud_cbm, 
		cis_venno = ltrim(rtrim(@qud_dv)), 
		cis_prdven = ltrim(rtrim(@qud_venno)), 
		cis_cusven = ltrim(rtrim(@qud_cusven)), 
		cis_tradeven = ltrim(rtrim(@qud_tv)), 
		cis_examven = ltrim(rtrim(@qud_ftyaud)), 
		cis_cus1no = @qud_cus1no, 
		cis_cus2no = @qud_cus2no, 
		cis_refdoc = @qud_qutno, 
		cis_docdat = @rvsdat, 
		cis_qutno = @qud_qutno, 
		cis_qutseq = @qud_qutseq, 
		--cis_cussku = '', 
		--cis_ordqty = 0, 
		--cis_moqchg = 0, 
		cis_hrmcde = @qud_hrmcde, 
		cis_dtyrat = @qud_dtyrat, 
		cis_dept = @qud_dept, 
		--cis_typcode = 'U', 
		--cis_code1 = '', 
		--cis_code2 = '', 
		--cis_code3 = '', 
		cis_cususdcur = @qud_cususdcur, 
		cis_cususd = @qud_cususd, 
		cis_cuscadcur = @qud_cuscadcur, 
		cis_cuscad = @qud_cuscad, 
		cis_inrdin = @qud_inrdin, 
		cis_inrwin = @qud_inrwin, 
		cis_inrhin = @qud_inrhin, 
		cis_mtrdin = @qud_mtrdin, 
		cis_mtrwin = @qud_mtrwin, 
		cis_mtrhin = @qud_mtrhin, 
		cis_inrdcm = @qud_inrdcm, 
		cis_inrwcm = @qud_inrwcm, 
		cis_inrhcm = @qud_inrhcm, 
		cis_mtrdcm = @qud_mtrdcm, 
		cis_mtrwcm = @qud_mtrwcm, 
		cis_mtrhcm = @qud_mtrhcm, 
		cis_pckitr = @qud_pckitr, 
		cis_itmventyp = @ItmVenTyp, 
		--cis_tirtyp = 1, 
		cis_moqunttyp = @qud_moqunttyp, 
		cis_moq = @qud_moq, 
		cis_moacur = @qud_curcde, 
		cis_moa = @qud_moa, 
		cis_contopc = @qud_contopc, 
		cis_pcprc = @qud_pcprc, 
		cis_ftytmpitm = @qud_ftytmpitm, 
		cis_cusstyno = @qud_cusstyno, 
		cis_year = @quh_year, 
		cis_season = @quh_season, 
		cis_updusr = @qxd_creusr, 
		cis_upddat = getdate()
		where 	cis_cocde = @cis_key_cocde and 
			cis_cusno = @cis_key_cusno and 
			cis_seccus = @cis_key_seccus and 
			cis_itmno = @cis_key_itmno and 
			cis_colcde = @cis_key_colcde and 
			cis_untcde = @cis_key_untcde and 
			cis_conftr = @cis_key_conftr and 
			cis_inrqty = @cis_key_inrqty and 
			cis_mtrqty = @cis_key_mtrqty and 
			left(cis_hkprctrm,3) = left(@cis_key_hkprctrm,3) and 
			left(cis_ftyprctrm,3) = Left(@cis_key_ftyprctrm,3) and 
			cis_trantrm = @cis_key_trantrm
	end
end






select 2 as "Flag2"
select @qxd_adjprc as 'test adjp'

select @qxd_adjMU  as 'test adjMU'

--select @qxd_ftycst as "Flag2222"

-- Determine Minimum Price
declare	@qpe_muminprc numeric(13, 4)

select @qxd_adjMU  as 'test adjMU1.3'

set @qpe_muminprc = ((cast(@qxd_basprc as numeric(13,4))/ (1 - cast(@qxd_lowerMU as numeric(13,4)) / 100)) + cast(@qxd_pckcst as numeric(13,4)) ) / (1 - cast(@qxd_comm as numeric(13,4)) / 100) + cast(@qxd_itmcomm as numeric(13,4))

select @qxd_adjMU  as 'test adjMU1.5'

update	QUPRCEMT
set	qpe_untcde = isnull(@qxd_um, ''),
	qpe_prctrm = isnull(@qxd_prctrm,''),
 	qpe_fml_ventranflg = isnull(@qxd_vdrtranflg,''),
	qpe_subttlper = isnull(@qxd_mu,0),
	qpe_pkgper =  isnull(@qxd_pckcst,0),
	qpe_comper = isnull(@qxd_comm,0),
	qpe_icmper = isnull(@qxd_itmcomm,0), 
	qpe_cushcstbufper = isnull(@qxd_cushcstbuf,0),
	qpe_othdisper = isnull(@qxd_othdislmt,0),
	qpe_mumin = isnull(@qxd_lowerMU,0),
	qpe_mu = isnull(@qxd_adjMU,0),
	qpe_muminprc = isnull(@qpe_muminprc, 0),
	qpe_cus1dp = isnull(@qxd_adjprc,0),
	qpe_cus1sp = isnull(@qxd_stdprc,0),
	qpe_ftycstA = isnull(@qxd_ftycstA ,0),
	qpe_ftycstB = isnull(@qxd_ftycstB ,0),
	qpe_ftycstC = isnull(@qxd_ftycstC ,0),
	qpe_ftycstD = isnull(@qxd_ftycstD,0),
	qpe_ftycstE = isnull(@qxd_ftycstE,0),
	qpe_ftycstTran = isnull(@qxd_ftycstTran,0),
	qpe_ftycstPack = isnull(@qxd_ftycstPack ,0),
	qpe_ftycst = isnull(@qxd_ftycst ,0),
	qpe_ftyprc = isnull(@qxd_ftyprc,0),
	qpe_basprc = isnull(@qxd_basprc,0),
	qpe_lightspec = isnull(@qxd_lightSpec,'')
where	qpe_cocde = @qxd_cocde and
	qpe_qutno = @qxd_qutno and
	qpe_itmno = @tmp_itmno and
	qpe_qutseq = (select qud_qutseq from QUOTNDTL (nolock) where qud_qutno = @qxd_qutno and qud_cocde = @qxd_cocde and
		qud_colcde = @tmp_colcde and qud_itmno= @tmp_itmno and qud_untcde = @tmp_pckunt and
		qud_inrqty = @tmp_inrqty and qud_mtrqty = @tmp_mtrqty and left(qud_prctrm, 3) = left(@tmp_hkprctrm, 3) and
		qud_trantrm = @tmp_trantrm)

select @qxd_adjMU  as 'test adjMU2'

/*
	update	QUPRCEMT  set 
	--qpe_itmno	=@qxd_itmno,
	qpe_untcde	=isnull(@qxd_um,''),  ---20140224,
--	qpe_fml_cus2no	= @qxd_seccust,
--	qpe_basprc	=@qxd_basprc,

	qpe_prctrm	=isnull(@qxd_prctrm,''),  ---20140224,
 	qpe_fml_ventranflg	=isnull(@qxd_vdrtranflg,''),  ---20140224,,
	qpe_subttlper	=isnull(@qxd_mu,0),  ---20140224
	qpe_pkgper	=isnull(@qxd_pckcst,0),  ---20140224   --- should be packing cost
	qpe_comper	=isnull(@qxd_comm,0),  ---20140224
	qpe_icmper	=isnull(@qxd_itmcomm,0),  ---20140224
	qpe_cushcstbufper	=isnull(@qxd_cushcstbuf,0),  ---20140224
	qpe_othdisper	=isnull(@qxd_othdislmt,0),  ---20140224
	qpe_mumin	=isnull(@qxd_lowerMU,0),  ---20140224,   -- name
	qpe_mu	=isnull(@qxd_adjMU,0),  ---20140224,   -- name
	qpe_cus1dp	=isnull(@qxd_adjprc,0),  ---20140224,   -- name
	qpe_cus1sp	=isnull(@qxd_stdprc,0),  ---20140224,   -- name
	qpe_ftycstA=  isnull(@qxd_ftycstA ,0),  ---20140224,
	qpe_ftycstB=  isnull(@qxd_ftycstB ,0),  ---20140224,
	qpe_ftycstC=  isnull(@qxd_ftycstC ,0),  ---20140224,
	qpe_ftycstD=  isnull(@qxd_ftycstD,0),  ---20140224 ,
	qpe_ftycstTran=  isnull(@qxd_ftycstTran,0),  ---20140224,,
	qpe_ftycstPack= isnull(@qxd_ftycstPack ,0),  ---20140224,,
	qpe_ftycst=  isnull(@qxd_ftycst ,0),  ---20140224,
	qpe_ftyprc= isnull(@qxd_ftyprc,0),  ---20140224,
	qpe_basprc= isnull(@qxd_basprc,0),  ---20140224,  --20140123
	qpe_lightspec = isnull(@qxd_lightSpec,'')   ---20140224,
	where   qpe_qutno=@qxd_qutno
	and  qpe_cocde=@qxd_cocde
	and  qpe_itmno= @tmp_itmno    --color?
	and  qpe_qutseq= 
		(
		select qud_qutseq 
		from quotndtl
	where   qud_qutno=@qxd_qutno
	and  qud_cocde=@qxd_cocde
	and  qud_colcde=@tmp_colcde
	and  qud_itmno= @tmp_itmno 
	and  (
			( qud_untcde=@tmp_pckunt
			and qud_inrqty =@tmp_inrqty	
			and  qud_mtrqty =@tmp_mtrqty 
			--and qud_contopc <>'Y'
				)
		    --    OR
			 
			--(qud_inrqty =isnull(qud_conftr,1)*@tmp_inrqty	
			 --and  qud_mtrqty =isnull(qud_conftr,1)*@tmp_mtrqty 
			--and qud_contopc ='Y'
			-- and left(qud_untcde,2)='ST'
			  -- and @tmp_pckunt='PC'
		        --       )
		)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)
	and  qud_trantrm=@tmp_trantrm

		)
*/


declare @qpe_cocde	nvarchar(6),	@qpe_qutno	nvarchar(20),	@qpe_qutseq	int,
@qpe_itmno	nvarchar(20),	@qpe_untcde	nvarchar(6),	@qpe_inrqty	int,
@qpe_mtrqty	int,		@qpe_cft		numeric(11,4),	@qpe_cbm		numeric(11,4),
@qpe_ftyprctrm	nvarchar(10),	@qpe_prctrm	nvarchar(10),	@qpe_trantrm	nvarchar(10),
@qpe_fml_cus1no	nvarchar(10),	@qpe_fml_cus2no	nvarchar(10),	@qpe_fml_cat		nvarchar(20),
@qpe_fml_venno	nvarchar(10),	@qpe_fml_ventranflg	char(1),		@qpe_fcurcde	nvarchar(10),
@qpe_ftycst	numeric(13, 4),	@qpe_ftyprc	numeric(13, 4),	@qpe_curcde	nvarchar(10),
@qpe_basprc	numeric(13, 4),	@qpe_mu		numeric(13, 4),	@qpe_mumin	numeric(13, 4),
@qpe_muprc	numeric(13, 4),	@qpe_cus1sp	numeric(13, 4),	@qpe_cus1dp	numeric(13, 4),
@qpe_cushcstbufper	numeric(13, 4),	@qpe_cushcstbufamt	numeric(13, 4),	@qpe_othdisper	numeric(13, 4),
@qpe_maxapvper	numeric(13, 4),	@qpe_maxapvamt	numeric(13, 4),	@qpe_spmuper	numeric(13, 4),
@qpe_dpmuper	numeric(13, 4),	@qpe_cumu	numeric(13, 4),	@qpe_pm		numeric(13, 4),
@qpe_cush	numeric(13, 4),	@qpe_thccusper	numeric(13, 4),	@qpe_upsper	numeric(13, 4),
@qpe_labper	numeric(13, 4),	@qpe_faper	numeric(13, 4),	@qpe_cstbufper	numeric(13, 4),
@qpe_othper	numeric(13, 4),	@qpe_pliper	numeric(13, 4),	@qpe_dmdper	numeric(13, 4),
@qpe_rbtper	numeric(13, 4),	@qpe_subttlper	numeric(13, 4),	@qpe_pkgper	numeric(13, 4),
@qpe_comper	numeric(13, 4),	@qpe_icmper	numeric(13, 4),	@qpe_stdprc	numeric(13,4),
@qpe_ftycstA	numeric(13, 4), @qpe_ftycstB	numeric(13, 4), @qpe_ftycstC	numeric(13, 4),
@qpe_ftycstD	numeric(13, 4),@qpe_ftycstE	numeric(13, 4), @qpe_ftycstTran	numeric(13, 4), @qpe_ftycstPack	numeric(13, 4),
@qpe_lightspec	nvarchar(300), @qpe_creusr	nvarchar(30)



select
@qpe_itmno = qpe_itmno,	@qpe_untcde = qpe_untcde,	@qpe_inrqty = qpe_inrqty,
@qpe_mtrqty = qpe_mtrqty,	@qpe_cft = qpe_cft,		@qpe_cbm = qpe_cbm,
@qpe_ftyprctrm = qpe_ftyprctrm,	@qpe_prctrm = qpe_prctrm,	@qpe_trantrm = qpe_trantrm,
@qpe_fml_cus1no = qpe_fml_cus1no,	@qpe_fml_cus2no = qpe_fml_cus2no,	@qpe_fml_cat = qpe_fml_cat,
@qpe_fml_venno = qpe_fml_venno,	@qpe_fml_ventranflg = qpe_fml_ventranflg,	@qpe_fcurcde = qpe_fcurcde,
@qpe_ftycst = qpe_ftycst,	@qpe_ftyprc = qpe_ftyprc,	@qpe_curcde = qpe_curcde,
@qpe_basprc = qpe_basprc,	@qpe_mu = qpe_mu,		@qpe_mumin = qpe_mumin,
@qpe_muprc = qpe_muprc,	@qpe_cus1sp = qpe_cus1sp,	@qpe_cus1dp = qpe_cus1dp,
@qpe_cushcstbufper = qpe_cushcstbufper,	@qpe_cushcstbufamt = qpe_cushcstbufamt,	@qpe_othdisper = qpe_othdisper,
@qpe_maxapvper = qpe_maxapvper,	@qpe_maxapvamt = qpe_maxapvamt,	@qpe_spmuper = qpe_spmuper,
@qpe_dpmuper = qpe_dpmuper,	@qpe_cumu = qpe_cumu,	@qpe_pm = qpe_pm,
@qpe_cush = qpe_cush,	@qpe_thccusper = qpe_thccusper,	@qpe_upsper = qpe_upsper,
@qpe_labper = qpe_labper,	@qpe_faper = qpe_faper,	@qpe_cstbufper = qpe_cstbufper,
@qpe_othper = qpe_othper,	@qpe_pliper = qpe_pliper,	@qpe_dmdper = qpe_dmdper,
@qpe_rbtper = qpe_rbtper,	@qpe_subttlper = qpe_subttlper,	@qpe_pkgper = qpe_pkgper,
@qpe_comper = qpe_comper,	@qpe_icmper = qpe_icmper,	@qpe_stdprc = qpe_stdprc,
@qpe_ftycstA = qpe_ftycstA, 	@qpe_ftycstB = qpe_ftycstB,	@qpe_ftycstC = qpe_ftycstC,
@qpe_ftycstD = qpe_ftycstD,	@qpe_ftycstE = qpe_ftycstE,	@qpe_ftycstTran = qpe_ftycstTran,	@qpe_ftycstPack = qpe_ftycstPack,
@qpe_lightspec = qpe_lightspec
from QUPRCEMT (nolock)
where	qpe_cocde = @qud_cocde	and
	qpe_qutno = @qud_qutno	and
	qpe_qutseq = @qud_qutseq


declare @cip_flg as char(1)

declare @cip_key_cocde as nvarchar(10)
declare @cip_key_cusno as nvarchar(10)
declare @cip_key_seccus as nvarchar(10)
declare @cip_key_itmno as nvarchar(20)
declare @cip_key_venno as nvarchar(20)
declare @cip_key_prdven as nvarchar(20)
declare @cip_key_colcde as nvarchar(10)
declare @cip_key_untcde as nvarchar(10)
declare @cip_key_conftr as int
declare @cip_key_inrqty as int
declare @cip_key_mtrqty as int
declare @cip_key_hkprctrm as nvarchar(10)
declare @cip_key_ftyprctrm as nvarchar(10)
declare @cip_key_trantrm as nvarchar(10)
declare @cip_key_effdat as datetime
declare @cip_key_expdat as datetime


if @qud_itmnoreal <> '' and @qud_qutitmsts = 'A' --and @quh_qutsts = 'A' and @qud_qutitmsts = 'A - Active'	and (@qud_apprve = '' or @qud_apprve = 'Y')
	set @cip_flg = 'Y'
else
	set @cip_flg = 'N'

set @cip_key_cocde = @qud_cocde
set @cip_key_cusno = @quh_cus1no
set @cip_key_seccus = @quh_cus2no
set @cip_key_itmno = @qud_itmnoreal
set @cip_key_venno = @qud_dv
set @cip_key_prdven = @qud_venno
set @cip_key_colcde = @qud_colcde
set @cip_key_untcde = @qud_untcde 
set @cip_key_conftr = @qud_conftr
set @cip_key_inrqty = @qud_inrqty
set @cip_key_mtrqty = @qud_mtrqty
set @cip_key_hkprctrm = @qud_prctrm
set @cip_key_ftyprctrm = @qud_ftyprctrm
set @cip_key_trantrm = @qud_trantrm
set @cip_key_effdat = @qud_effdat
set @cip_key_expdat = @qud_expdat

if @cip_flg = 'Y'
begin
	-- Insert / Update CUITMPRC


	if ((select count(*) from CUITMPRC (nolock) 
			where 	cip_cocde = @cip_key_cocde and 
				cip_cusno = @cip_key_cusno and
				cip_seccus = @cip_key_seccus and
				cip_itmno = @cip_key_itmno and
				cip_venno = @cip_key_venno and
				--cip_prdven = @cip_key_prdven and
				cip_colcde = @cip_key_colcde and
				cip_untcde = @cip_key_untcde and
				cip_conftr = @cip_key_conftr and
				cip_inrqty = @cip_key_inrqty and
				cip_mtrqty = @cip_key_mtrqty and
				left(cip_hkprctrm,3) = Left(@cip_key_hkprctrm,3) and
				left(cip_ftyprctrm,3) = Left(@cip_key_ftyprctrm,3) and
				cip_trantrm = @cip_key_trantrm and
				--cip_effdat = @cip_key_effdat and
				--cip_expdat = @cip_key_expdat ) = 0 ) 
				left(convert(varchar(20),cip_effdat,111),10) = left(convert(varchar(20),@cip_key_effdat,111),10) and
				left(convert(varchar(20),cip_expdat,111),10) = left(convert(varchar(20),@cip_key_expdat,111),10)) = 0)

	begin

		---20140224
		if @qxd_creusr <> NULL  
		begin
			insert into CUITMPRC 
			(cip_cocde,cip_cusno,cip_seccus,cip_itmno,cip_venno,
			cip_prdven,cip_colcde,cip_untcde,cip_conftr,cip_inrqty,
			cip_mtrqty,cip_hkprctrm,cip_ftyprctrm,cip_trantrm,cip_cus1no,
			cip_cus2no,cip_effdat,cip_expdat,cip_refdoc,cip_refseq,
			cip_docdat,cip_fcurcde,cip_ftycst,cip_bomcst,cip_ftyprc,
			cip_curcde,cip_basprc,cip_markup,cip_mrkprc,cip_mumin,cip_muminprc,cip_pckcst,
			cip_commsn,cip_itmcom,cip_stdprc,cip_discnt,cip_adjprc,
			cip_qutdat,cip_imqutdat,cip_creusr,cip_updusr,cip_credat,
			cip_upddat)
			values
			(@cip_key_cocde,@cip_key_cusno,@cip_key_seccus,@cip_key_itmno,@cip_key_venno,
			@cip_key_prdven,@cip_key_colcde,@cip_key_untcde,@cip_key_conftr,@cip_key_inrqty,
			@cip_key_mtrqty,@cip_key_hkprctrm,@cip_key_ftyprctrm,@cip_key_trantrm,@qud_cus1no,
			@qud_cus2no,@cip_key_effdat,@cip_key_expdat,@qud_qutno,@qud_qutseq,
			getdate(),@qpe_fcurcde,@qpe_ftycst,0,@qpe_ftyprc,
			@qpe_curcde,@qpe_basprc,@qpe_mu,@qpe_muprc,@qpe_mumin,@qpe_muminprc,@qpe_pkgper,
			@qpe_comper,@qpe_icmper,@qpe_cus1sp,0,@qpe_cus1dp,
			@qud_qutdat,'1900/01/01',@qxd_creusr,@qxd_creusr,getdate(),
			getdate())

			-- Update other PV Prices in CIH
			update CUITMPRC set 
			cip_cus1no = @qud_cus1no,
			cip_cus2no = @qud_cus2no,
			cip_refdoc = @qud_qutno,
			cip_refseq = @qud_qutseq,
			cip_docdat = getdate(),
			cip_fcurcde = @qpe_fcurcde,
			cip_ftycst = @qpe_ftycst,
	--		cip_bomcst = 0,
			cip_ftyprc = @qpe_ftyprc,
			cip_curcde = @qpe_curcde,
			cip_basprc = @qpe_basprc,
			cip_markup = @qpe_mu,
			cip_mrkprc = @qpe_muprc,
			cip_mumin = @qpe_mumin,
			cip_muminprc = @qpe_muminprc,
			cip_pckcst = @qpe_pkgper,
			cip_commsn = @qpe_comper,
			cip_itmcom = @qpe_icmper,
			cip_stdprc = @qpe_cus1sp,
	--		cip_discnt = 0,
			cip_adjprc = @qpe_cus1dp,
			cip_qutdat = @qud_qutdat,
	--		cip_imqutdat = '1900/01/01',
			cip_updusr = @qxd_creusr,
			cip_upddat = getdate()
			where 
			cip_cocde = @cip_key_cocde and
			cip_cusno = @cip_key_cusno and
			cip_seccus = @cip_key_seccus and
			cip_itmno = @cip_key_itmno and
			cip_venno = @cip_key_venno and
			cip_prdven <> @cip_key_prdven and
			cip_colcde = @cip_key_colcde and
			cip_untcde = @cip_key_untcde and
			cip_conftr = @cip_key_conftr and
			cip_inrqty = @cip_key_inrqty and
			cip_mtrqty = @cip_key_mtrqty and
			Left(cip_hkprctrm,3) = Left(@cip_key_hkprctrm,3) and
			Left(cip_ftyprctrm,3) = Left(@cip_key_ftyprctrm,3) and
			cip_trantrm = @cip_key_trantrm and
			left(convert(varchar(20),cip_effdat,111),10) = left(convert(varchar(20),@cip_key_effdat,111),10) and
			left(convert(varchar(20),cip_expdat,111),10) = left(convert(varchar(20),@cip_key_expdat,111),10)
		end
	end
	else
	begin
		update CUITMPRC set 
		cip_cus1no = @qud_cus1no,
		cip_cus2no = @qud_cus2no,
		cip_refdoc = @qud_qutno,
		cip_refseq = @qud_qutseq,
		cip_docdat = getdate(),
		cip_fcurcde = @qpe_fcurcde,
		cip_ftycst = @qpe_ftycst,
--		cip_bomcst = 0,
		cip_ftyprc = @qpe_ftyprc,
		cip_curcde = @qpe_curcde,
		cip_basprc = @qpe_basprc,
		cip_markup = @qpe_mu,
		cip_mrkprc = @qpe_muprc,
		cip_mumin = @qpe_mumin,
		cip_muminprc = @qpe_muminprc,
		cip_pckcst = @qpe_pkgper,
		cip_commsn = @qpe_comper,
		cip_itmcom = @qpe_icmper,
		cip_stdprc = @qpe_cus1sp,
--		cip_discnt = 0,
		cip_adjprc = @qpe_cus1dp,
		cip_qutdat = @qud_qutdat,
--		cip_imqutdat = '1900/01/01',
		cip_updusr = @qxd_creusr,
		cip_upddat = getdate()
		where 
		cip_cocde = @cip_key_cocde and
		cip_cusno = @cip_key_cusno and
		cip_seccus = @cip_key_seccus and
		cip_itmno = @cip_key_itmno and
		cip_venno = @cip_key_venno and
		--cip_prdven = @cip_key_prdven and
		cip_colcde = @cip_key_colcde and
		cip_untcde = @cip_key_untcde and
		cip_conftr = @cip_key_conftr and
		cip_inrqty = @cip_key_inrqty and
		cip_mtrqty = @cip_key_mtrqty and
		Left(cip_hkprctrm,3) = Left(@cip_key_hkprctrm,3) and
		Left(cip_ftyprctrm,3) = Left(@cip_key_ftyprctrm,3) and
		cip_trantrm = @cip_key_trantrm and
		left(convert(varchar(20),cip_effdat,111),10) = left(convert(varchar(20),@cip_key_effdat,111),10) and
		left(convert(varchar(20),cip_expdat,111),10) = left(convert(varchar(20),@cip_key_expdat,111),10)
	end
	
	
-- *** Insert records to CUITMPRCDTL (Update) STart *** --
	--- Get Greatest number of seq number in CUITMPRCDTL
	Set  @seq_num_cuitmprcdtl = (	select	isnull(max(cid_seqnum),0) + 1
		from	CUITMPRCDTL
		where	
			cid_cusno = @cip_key_cusno and
			cid_seccus = @cip_key_seccus and
			cid_itmno = @cip_key_itmno and
			cid_colcde = @cip_key_colcde and
			cid_untcde = @cip_key_untcde and
			cid_conftr = @cip_key_conftr and
			cid_inrqty = @cip_key_inrqty and
			cid_mtrqty = @cip_key_mtrqty and
			cid_hkprctrm = @cip_key_hkprctrm and
			cid_ftyprctrm = @cip_key_ftyprctrm and
			cid_trantrm = @cip_key_trantrm	
			)
			
			
		if @qud_apprve = ''
		set @qud_apprve = 'N'
	else if @qud_apprve = 'N'
		set @qud_apprve = 'W'
	else if @qud_apprve = 'Y'
		set @qud_apprve = 'Y'
			
	
	insert into CUITMPRCDTL(
		cid_cocde, cid_cusno, cid_seccus, cid_itmno,
		cid_colcde, cid_untcde, cid_conftr, cid_inrqty,
		cid_mtrqty, cid_hkprctrm, cid_ftyprctrm, cid_trantrm,
		--cis_venno, cid_effdat, cid_expdat,
		
		cid_seqnum, cid_refdoc, cid_refseq, cid_docdat, cid_apvsts, cid_qutitmsts,
		--Data Part Start
		cis_cussna, cis_secsna,
		cis_itmdsc, cis_coldsc, cis_cuscol, cid_cusitm, cid_cusstyno,
		cis_venno, cis_prdven, cis_cusven, cis_tradeven, cis_examven,
	
		cis_cususdcur, cis_cususd, cis_cuscadcur, cis_cuscad,
		
		cis_inrdin, cis_inrwin, cis_inrhin, cis_mtrdin, cis_mtrwin, 
		cis_mtrhin, cis_inrdcm, cis_inrwcm, cis_inrhcm, cis_mtrdcm, 
		cis_mtrwcm, cis_mtrhcm, 
		cis_cft, cis_cbm, cis_pckitr,
		
		cis_itmventyp, cis_tirtyp, cis_moqunttyp, cis_moq, cis_moacur, cis_moa,
		cis_year, cis_season, 
		cis_ftytmpitm, cis_contopc, cis_pcprc,
		--Data Part End	
		--Price Part Start
		cid_effdat, cid_expdat, cid_cus1no, cid_cus2no,
		cip_fcurcde, cip_ftycst, cip_bomcst, cip_ftyprc,
		cip_curcde, cip_basprc, cip_markup, cip_mrkprc, 
		cip_pckcst, cip_commsn, cip_itmcom, cip_stdprc, 
		cip_mumin, cip_muminprc, cip_discnt, cip_adjprc, 
		cip_qutdat,
		--Price Part End
		
		--Other Part Start
		cid_mode, cid_creusr, cid_updusr, cid_credat, cid_upddat
		--Other Part End
	)
	values(
		'',@cip_key_cusno,@cip_key_seccus,@cip_key_itmno,
		@cip_key_colcde,@cip_key_untcde,@cip_key_conftr,@cip_key_inrqty,
		@cip_key_mtrqty,@cip_key_hkprctrm,@cip_key_ftyprctrm,@cip_key_trantrm,
		--@cip_key_venno,@cip_key_effdat,@cip_key_expdat,
		
		@seq_num_cuitmprcdtl, @qxd_qutno, @qud_qutseq, getdate(), @qud_apprve, @qud_qutitmsts,--cid_docdat
		--Data Part Start
		@cus1na, @cus2na,
		@qud_itmdsc, @qud_coldsc, @qud_cuscol, @qud_cusitm, @qud_cusstyno,
		@cip_key_venno, ltrim(rtrim(@qud_venno)),ltrim(rtrim(@qud_cusven)), ltrim(rtrim(@qud_tv)),ltrim(rtrim(@qud_ftyaud)),
		
		@qud_cususdcur, @qud_cususd, @qud_cuscadcur, @qud_cuscad,
		
		@qud_inrdin, @qud_inrwin, @qud_inrhin, @qud_mtrdin, @qud_mtrwin, 
		@qud_mtrhin, @qud_inrdcm, @qud_inrwcm, @qud_inrhcm, @qud_mtrdcm, 
		@qud_mtrwcm, @qud_mtrhcm, 
		@qud_cft, @qud_cbm, @qud_pckitr,
		
		@ItmVenTyp, 1, @qud_moqunttyp, @qud_moq, @qud_curcde, @qud_moa, --@cis_tirtyp
		@quh_year, @quh_season,
		@qud_ftytmpitm, @qud_contopc, @qud_pcprc,
		
		@cip_key_effdat,@cip_key_expdat, @qpe_fml_cus1no, @qpe_fml_cus2no,	
		--Data Part End
		--Price Part Start
		@qpe_fcurcde, @qpe_ftycst, 0, @qpe_ftyprc,
		@qpe_curcde, @qpe_basprc, @qpe_mu, @qpe_muprc,
		@qpe_pkgper, @qpe_comper, @qpe_icmper,@qpe_cus1sp,
		@qpe_mumin, @qpe_muminprc, 0, @qpe_cus1dp,
		@qud_qutdat,
		--Price Part End
		--Other Part Start
		'EU', @qxd_creusr, @qxd_creusr, getdate(),getdate()
		--Other Part End
		
	)
	

-- *** Insert records to CUITMPRCDTL End *** --
	
end








select 3 as "Flag3"

	select * from quprcemt
	where   qpe_qutno=@qxd_qutno
	and  qpe_cocde=@qxd_cocde
	and  qpe_itmno= @tmp_itmno    --color?
	and  qpe_qutseq= 
		(
		select qud_qutseq
		from QUOTNDTL
		where   qud_qutno=@qxd_qutno
	and  qud_cocde=@qxd_cocde
	and  qud_colcde=@tmp_colcde
	and  qud_itmno= @tmp_itmno 
	and  (
			( qud_untcde=@tmp_pckunt
			and qud_inrqty =@tmp_inrqty	
			and  qud_mtrqty =@tmp_mtrqty 
			--and qud_contopc <>'Y'
				)
		      ---  OR
			 
			--(qud_inrqty =isnull(qud_conftr,1)*@tmp_inrqty	
			 --and  qud_mtrqty =isnull(qud_conftr,1)*@tmp_mtrqty 
			--and qud_contopc ='Y'
			-- and left(qud_untcde,2)='ST'
			  -- and @tmp_pckunt='PC'
		           --    )
		)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)
	and  qud_trantrm=@tmp_trantrm
		)


	select qud_qutseq  as 'TEST TEST'
		from QUOTNDTL
		where   qud_qutno=@qxd_qutno
		and  qud_cocde=@qxd_cocde
		and  qud_itmno= @tmp_itmno 
		and  (
				( qud_untcde=@tmp_pckunt
				and qud_inrqty =@tmp_inrqty	
				and  qud_mtrqty =@tmp_mtrqty 
				--and qud_contopc <>'Y'
					)
			  --      OR
				--(
				--(qud_inrqty =isnull(qud_conftr,1)*@tmp_inrqty	
				--and  qud_mtrqty =isnull(qud_conftr,1)*@tmp_mtrqty)
				--and qud_contopc ='Y'
				--  and left(qud_untcde,2)='ST'
				--    and @tmp_pckunt='PC'
			    --           )
			)
	and  Left(qud_prctrm,3)=Left(@tmp_hkprctrm,3)		
	and  qud_trantrm=@tmp_trantrm
		 



end
else	-- NEW

begin 


--select 4 as "Flag4"

--for header 
select @flag_exist_hdr =count (*)   
from QUOTNHDR
where quh_cocde=@qxd_cocde and quh_qutno=@qxd_qutno

--for detail & PRCEMT. at least Item exist in IMPRCINF
select @flag_exist_itm=  count(*)
from QUXLSDTL   
	--left join IMPRCINF  
	inner join IMBASINF  
		on ibi_itmno = qxd_itmno 
		--and imu_pckunt = qxd_um 
		--and imu_inrqty = qxd_inr 
		--and imu_mtrqty = qxd_mtr
		--and imu_hkprctrm = qxd_prctrm 
		--and imu_trantrm = qxd_trantrm
	where   qxd_xlsfil = @qxd_xlsfil 
		and  qxd_fildat = @qxd_fildat
		-- and  qxd_qutno=@qxd_qutno
		and  qxd_cocde=@qxd_cocde
		and  qxd_itmno=@tmp_itmno

-- Insert into Header
select @flag_exist_hdr as header_count
select @flag_exist_itm


if  not @flag_exist_hdr > =1 
begin
--seems need to select ##

select 5 as "Flag5"

insert into [QUOTNHDR] (
	quh_cocde ,	quh_qutno ,	
	quh_cus1no ,	quh_cus2no ,			
	quh_valdat,
	quh_CusAgt,
	quh_saldivtem,
	quh_SalRep,
	quh_Srname,
	quh_SmpPrd,
	quh_SmpFgt,
	quh_Curcde,
	quh_PayTrm,
	quh_Cus1Ad, 
	quh_Cus1St, 
	quh_Cus1Cy, 
	quh_Cus1Zp, 
	quh_Cus1Cp,
	quh_cugrptyp_int,
	quh_cugrptyp_ext,
	quh_prctrm,
	quh_rvsdat,quh_qutsts,quh_relatn,
	quh_cus2ad,
	quh_cus2st,
	quh_cus2cy,
	 quh_cus2zp,
	 quh_cus2cp,
	quh_creusr,quh_updusr)
values (
	@qxd_cocde ,	@qxd_qutno ,	@tmp_cus1no ,@tmp_cus2no ,
	getdate(),
	@tmp_CusAgt,
	@tmp_SalDiv,
	@tmp_SalRep,
	@tmp_Srname,
	@tmp_SmpPrd,
	@tmp_SmpFgt,
	@tmp_Curcde,
	@tmp_PayTrm,
	@tmp_Cus1Ad, 
	@tmp_Cus1St, 
	@tmp_Cus1Cy, 
	@tmp_Cus1Zp, 
	@tmp_Cus1Cp,
	@tmp_Cus1CgInt,
	@tmp_Cus1CgExt,
	isnull(@qxd_prctrm,''), 
	getdate(),'A','',
	@quh_cus2ad,
	@quh_cus2st,
	@quh_cus2cy,
	@quh_cus2zp,
	@quh_cus2cp, 
	@tmp_gsUsrID,@tmp_gsUsrID) 			  -- should be gusr

end

-- Smiple Insert into Detail  & QUPRCEMT, New Item, not in IM
select  @tmp_case as 'case'
select @flag_exist_itm  as '@flag_exist_itm '

if @tmp_case = '4'  --and @flag_exist_itm > =1 


begin

select 6 as "Flag6"


-- .. check duplicate

 Set  @new_seq = (	select	isnull(max(qud_qutseq),0) + 1
		from	QUOTNDTL
		where	qud_cocde = @qxd_cocde	and
			qud_qutno = @qxd_qutno)


select @new_seq as 'new_seq'

select 7 as "Flag7"
SELECT
qxd_cocde,
qxd_qutno,
@new_seq,
qxd_itmno,
qxd_um,
qxd_inr,
qxd_mtr,
isnull(qxd_cft,0),
0,
qxd_prctrm,
qxd_prctrm,
qxd_trantrm,
qxd_cus1no,
qxd_cus2no,
qxd_cat,
'',
'',
'',
isnull(qxd_vdrtranflg,'N'),
'',
isnull(qxd_ftycst,0),
isnull(qxd_ftyPrc,0),
isnull(qxd_ccy,''),
isnull(qxd_basprc,0),
isnull(qxd_adjMU,0),
isnull(qxd_lowerMU,0),
0,
0,
0,
isnull(qxd_cushcstbuf,0),
0,
isnull(qxd_othdislmt,0),
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
isnull(qxd_MU,0),
isnull(qxd_pckcst,0),
isnull(qxd_comm,0),
isnull(qxd_itmcomm,0),
isnull(qxd_stdprc,0),
isnull(qxd_ftycstA,0),
isnull(qxd_ftycstB,0),
isnull(qxd_ftycstC,0),
isnull(qxd_ftycstD,0),
isnull(qxd_ftycstE,0),
0,
0,
@qxd_lightSpec,
@tmp_gsUsrID,
@tmp_gsUsrID,
getdate(),
getdate(),
NULL,
''
from QUXLSDTL   
	where   qxd_xlsfil = @qxd_xlsfil 
		and  qxd_fildat = @qxd_fildat
--		and  qxd_qutno=@qxd_qutno
		and  qxd_cocde=@qxd_cocde
--		and qxd_seq = @qxd_qutseq
		and qxd_itmno = @tmp_itmno 


select 
qxd_cocde,
@qxd_qutno,
@new_seq,
qxd_itmno,
case qxd_pcftr when  '1' then	"REG"	else	"ASS"		end,
'CMP',
'A',
isnull(qxd_dsc,''),
'',
'',
'',
'',
isnull(qxd_vencolcde,''),  --##@
'',
'',
1,
@tmp_pckunt,
@tmp_inrqty,
@tmp_mtrqty,
isnull(qxd_cft ,'0'),
isnull(qxd_ccy ,'0'),
0,
0,
0,
0,
'N',
0,
0,
0,
'',
0,
0,
0,
0,
'',
0,
'',
0,
0,
isnull(qxd_venno,''),
'',
'',
'',
'',
'',
isnull(qxd_ftycst,0),
0,
0,
'',
'',
isnull(qxd_inrL,0),
isnull(qxd_inrW,0),
isnull(qxd_inrH,0),
isnull(qxd_mtrL,0),
isnull(qxd_mtrW,0),
isnull(qxd_mtrH,0),
0,
0,
0,
0,
0,
0,
0,
0,
0,
'',
'',
'',
0,
'',
'',
'',
isnull(@tmp_hkprctrm,''),
'',
0,
0,
isnull(@tmp_hkprctrm,''),
isnull(qxd_pcftr,1),
case qxd_pcftr when  '1' then	"N"	else	"Y"	end,
0,
'',
0,
'',
'',
'',
'',
'',
'',
0,
'',
isnull(qxd_rmk,''),
'',
0,
'',
isnull(qxd_inputdat,'01/01/1900'),
isnull(qxd_cus1no,''),
'',
isnull(@tmp_trantrm,''),
'01/01/1900',
isnull(qxd_expdat,'01/01/1900'),
'',
'',
'',
qxd_itmno,
qxd_venno,
'',
'',
'',
'',
'',
'',
'',
0,
0,
'01/01/1900',
'01/01/1900',
'01/01/1900',
'01/01/1900',
@tmp_gsUsrID,
@tmp_gsUsrID,
getdate(),
getdate(),
NULL

from QUXLSDTL   
	where   qxd_xlsfil = @qxd_xlsfil 
		and  qxd_fildat = @qxd_fildat
--		and  qxd_qutno=@qxd_qutno
		and  qxd_cocde=@qxd_cocde
--		and qxd_seq = @qxd_qutseq
		and qxd_itmno = @tmp_itmno 


--------------------------
-----------insert detail
--------------------------

insert into	QUOTNDTL
select 
qxd_cocde,
@qxd_qutno,
@new_seq,
qxd_itmno,
case qxd_pcftr when  '1' then	"REG"	else	"ASS"		end,
'CMP',
'A',
isnull(qxd_dsc,''),
'',
'',
'',
'',
isnull(qxd_vencolcde,''),  --##@
'',
'',
1,
@tmp_pckunt,
@tmp_inrqty,
@tmp_mtrqty,
isnull(qxd_cft ,'0'),
isnull(qxd_ccy ,'0'),
isnull(qxd_stdprc,0),
0,
isnull(qxd_adjprc,0),
0,
'N',
0,
0,
0,
'',
0,
CASE WHEN  left(qxd_orgum,2)='ST' AND qxd_um = 'PC'
	 THEN cast(qxd_adjprc as decimal(13,4) )/cast(right(qxd_orgum,(len(qxd_orgum)-2)) as int) ELSE cast(qxd_adjprc as decimal(13,4))
	END AS QUD_SMPPRC,
0,
0,
'',
0,
'',
0,
0,
isnull(qxd_venno,''),
'',
isnull(qxd_venno,''),
'',
'',
isnull(qxd_ccy,''),
isnull(qxd_ftycst,0),
isnull(qxd_ftyPrc,0),
isnull(qxd_basprc,0),
'',
'',
isnull(qxd_inrL,0),
isnull(qxd_inrW,0),
isnull(qxd_inrH,0),
isnull(qxd_mtrL,0),
isnull(qxd_mtrW,0),
isnull(qxd_mtrH,0),
0,
0,
0,
0,
0,
0,
0,
0,
0,
'',
'',
'',
0,
'',
'',
'',
isnull(@tmp_hkprctrm,''),
'',
0,
0,
isnull(@tmp_hkprctrm,''),
isnull(qxd_pcftr,1),
case qxd_pcftr when  '1' then	"N"	else	"Y"	end,
0,
'',
0,
'',
'',
'',
'',
'',
'',
0,
'',
isnull(qxd_rmk,''),
'',
0,
'',
isnull(qxd_inputdat,'01/01/1900'),
isnull(qxd_cus1no,''),
'',
isnull(@tmp_trantrm,''),
'01/01/1900',
isnull(qxd_expdat,'01/01/1900'),
'',
'',
'',
qxd_itmno,
qxd_venno,
'',
'',
'',
isnull(qxd_venno,''),
isnull(qxd_venno,''),
isnull(qxd_venno,''),
'',
qxd_Toqty,
qxd_Tormk,
qxd_Toshipdatefrom,
qxd_Toshipdateto,
qxd_ToCUSshipdatefrom,
qxd_ToCUSshipdateto,
@tmp_gsUsrID,
@tmp_gsUsrID,
getdate(),
getdate(),
NULL,
qxd_toshipport

from QUXLSDTL   
	where   qxd_xlsfil = @qxd_xlsfil 
		and  qxd_fildat = @qxd_fildat
--		and  qxd_qutno=@qxd_qutno
		and  qxd_cocde=@qxd_cocde
--		and qxd_seq = @qxd_qutseq
		and qxd_itmno = @tmp_itmno 

--------------------------
-----------insert PRCEMT---------------
---------------------------
insert into QUPRCEMT
SELECT
qxd_cocde,
@qxd_qutno,
@new_seq,
qxd_itmno,
qxd_um,
qxd_inr,
qxd_mtr,
isnull(qxd_cft,0),
0,
'',
qxd_prctrm,
qxd_trantrm,
qxd_cus1no,
qxd_cus2no,
qxd_cat,
'',
'',
'',
isnull(qxd_vdrtranflg,'N'),
'',
isnull(qxd_ftycst,0),
isnull(qxd_ftyPrc,0),
isnull(qxd_ccy,''),
isnull(qxd_basprc,0),
isnull(qxd_adjMU,0),
isnull(qxd_lowerMU,0),
0,
0,
0,
0,
isnull(qxd_cushcstbuf,0),
0,
isnull(qxd_othdislmt,0),
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
isnull(qxd_MU,0),
isnull(qxd_pckcst,0),
isnull(qxd_comm,0),
isnull(qxd_itmcomm,0),
isnull(qxd_stdprc,0),
isnull(qxd_ftycstA,0),
isnull(qxd_ftycstB,0),
isnull(qxd_ftycstC,0),
isnull(qxd_ftycstD,0),
isnull(qxd_ftycstE,0),
0,
0,
isnull(@qxd_lightSpec,''),
@tmp_gsUsrID,
@tmp_gsUsrID,
getdate(),
getdate(),
NULL,
''

from QUXLSDTL   
	where   qxd_xlsfil = @qxd_xlsfil 
		and  qxd_fildat = @qxd_fildat
--		and  qxd_qutno=@qxd_qutno
		and  qxd_cocde=@qxd_cocde
--		and qxd_seq = @qxd_qutseq
		and qxd_itmno = @tmp_itmno 

select 7.5 as "Flag7.5"

select * from
QUXLSDTL   
	where   qxd_xlsfil = @qxd_xlsfil 
		and  qxd_fildat = @qxd_fildat
		--and  qxd_qutno=@qxd_qutno
		and  qxd_cocde=@qxd_cocde
--		and qxd_seq = @qxd_qutseq
		and qxd_itmno = @tmp_itmno 


select 8 as "Flag8"



select 9 as "Flag9"
end 




end





GO
GRANT EXECUTE ON [dbo].[sp_update_QUPRCEMT_from_Excel] TO [ERPUSER] AS [dbo]
GO
