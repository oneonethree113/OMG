/****** Object:  StoredProcedure [dbo].[sp_list_POJBBDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_POJBBDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_POJBBDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











-- Checked by Allan Yuen at 27/07/2003

/************************************************************************
Author:		Johnson	
Date:		4th Jan, 2002
Description:	Select data From POORDDTL and PORODHDR
Parameter:	1. Company
		2. PO No
***********************************************************************
2003-10-27 Allan Yuen Add Running No.
2005-03-14 Allan Yuen Add Company Info
*/

CREATE procedure [dbo].[sp_list_POJBBDTL]
                                                                                                                                                                                                                                                               
@pjd_cocde nvarchar(6) ,
@pjd_batno nvarchar(20) ,
@export nvarchar(3)

AS
begin


-- Read Company Information --
declare 
	@yco_conam varchar(50),	@yco_addr nvarchar(200),	@yco_logoimgpth varchar(100),	@yco_phoneno varchar(50),	@yco_faxno varchar(50)

SELECT 
	@yco_conam = yco_conam,	
	@yco_addr = yco_addr,
	@yco_logoimgpth = yco_logoimgpth, 
	@yco_phoneno = yco_phoneno,
	@yco_faxno = yco_faxno 
FROM
	SYCOMINF
WHERE
	YCO_COCDE = @pjd_cocde

---------------------------------------------

if @export = 'PDF' 
begin
	select 
	pjd_cocde,
	@yco_conam,
	pjd_batno,
	pjd_batseq,
	pod_purord,
	pod_scno,
	pod_runno,
	pod_jobord,
	pod_venitm,
	vv.vbi_vensna,
	sod_subcde,
	v.vbi_vensna as 'cusven',
	cbi_cussna
	
	from 
		POJBBDTL
		inner join POORDDTL on pjd_cocde = pod_cocde and pjd_jobord = pod_jobord
		inner join POORDHDR on pjd_cocde = poh_cocde and pod_purord = poh_purord
		inner join VNBASINF v on v.vbi_venno = poh_venno
		inner join SCORDDTL on pjd_cocde = sod_cocde and pod_scno = sod_ordno and pod_scline = sod_ordseq
		inner join VNBASINF vv on vv.vbi_venno = pod_prdven 
		inner join SCORDHDR on soh_cocde = sod_cocde and soh_ordno = sod_ordno
		inner join cubasinf on cbi_cusno = soh_cus1no 
	
	where                                                                                                                                                                                                                                                                 
		pjd_cocde = @pjd_cocde and
		pjd_batno = @pjd_batno and
		pjd_confrm = 'Y'
	
	
	order by pjd_batseq
end
else if @export = 'XLS' 
begin
/*
	select 
		pjd_batseq as 'B. Seq',
		cbi_cussna as 'Cust Short Name.',
		pod_jobord as 'Job No.',
		pod_runno as 'Running No.',
		pod_venitm as 'Item No.',
		v.vbi_vensna as '清關工廠',
		vv.vbi_vensna as '生產工廠',
		sod_subcde as 'Sub Code',
		@yco_conam as 'conam'
	from 
		POJBBDTL
		inner join POORDDTL on pjd_cocde = pod_cocde and pjd_jobord = pod_jobord
		inner join POORDHDR on pjd_cocde = poh_cocde and pod_purord = poh_purord
		inner join VNBASINF v on v.vbi_venno = poh_venno
		inner join SCORDDTL on pjd_cocde = sod_cocde and pod_scno = sod_ordno and pod_scline = sod_ordseq
		inner join VNBASINF vv on vv.vbi_venno = pod_prdven 
		inner join SCORDHDR on soh_cocde = sod_cocde and soh_ordno = sod_ordno
		inner join cubasinf on cbi_cusno = soh_cus1no 
	
	where                                                                                                                                                                                                                                                                 
		pjd_cocde = @pjd_cocde and
		pjd_batno = @pjd_batno and
		pjd_confrm = 'Y'
	
	
	order by pjd_batseq
*/

	select 
		pjd_batseq,
		cbi_cussna,
		pod_jobord,
		pod_runno ,
		pod_venitm,
		v.vbi_vensna,
		vv.vbi_vensna,
		sod_subcde,
		@yco_conam as 'conam'
	into	#Result1
	from 	POJBBDTL
		inner join POORDDTL on pjd_cocde = pod_cocde and pjd_jobord = pod_jobord
		inner join POORDHDR on pjd_cocde = poh_cocde and pod_purord = poh_purord
		inner join VNBASINF v on v.vbi_venno = poh_venno
		inner join SCORDDTL on pjd_cocde = sod_cocde and pod_scno = sod_ordno and pod_scline = sod_ordseq
		inner join VNBASINF vv on vv.vbi_venno = pod_prdven 
		inner join SCORDHDR on soh_cocde = sod_cocde and soh_ordno = sod_ordno
		inner join cubasinf on cbi_cusno = soh_cus1no 	
	where                                                                                                                                                                                                                                                                 
		pjd_cocde = @pjd_cocde and
		pjd_batno = @pjd_batno and
		pjd_confrm = 'Y'		
	order by pjd_batseq

	select distinct pod_jobord into #Result2 from #Result1

	select		
		pod_jobord,
		stm_cocde,
		stm_ordno,
		stm_ordseq,
		stm_ordnoseq,
		stm_jobno,
		stm_smkno,
		stm_creusr
	into 	#Result3
	from 	#Result2 left join SCTPSMRK on (pod_jobord = stm_jobno)
	where	stm_cocde = @pjd_cocde 
	

	select distinct pod_jobord from #Result1




end


end












GO
GRANT EXECUTE ON [dbo].[sp_list_POJBBDTL] TO [ERPUSER] AS [dbo]
GO
