/****** Object:  StoredProcedure [dbo].[sp_select_IMITMEXDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMEXDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMEXDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO














/*  
=========================================================  
Program ID : sp_select_IMITMEXDAT  
Description    :   
Programmer   :  Frankie Cheung
ALTER  Date    :	22 January, 2009   
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
 Date        Initial    Description                            
=========================================================      
2003-09-06  Allan Yuen	Fix Select Product Line Problem  
2015-06-07  Lester Wu	Add Custom Vendor  
2013-08-19  David Yue	Phase 2 Implementation - Add Transport Term
*/  
  
CREATE PROCEDURE [dbo].[sp_select_IMITMEXDAT]   
  
@cocde nvarchar(6),		@itmsts nvarchar(10),		@mode nvarchar(6),   
@fromdate nvarchar(10), 	@todate nvarchar(10), 		@fromvendor nvarchar(6),   
@tovendor nvarchar(6), 		@fromline nvarchar(10), 		@toline nvarchar(10),   
@venitm nvarchar(20), 		@approve int,  			@reject int,  
@wait int,  			@fromprdven nvarchar(6), 	@toprdven nvarchar(6),  
--Lester Wu 2005/06/07 , add custom vendor   
@fromCusVen nvarchar(6), 	@toCusVen nvarchar(6),  	@chkAlias char(1) , 
@creusr nvarchar(30)  
  
AS  
  
declare  @no  int  
set @no = 1  
  
Select  
	@no as 'no',  
	ied_stage,   
	ied_stage as 'old_stage',   
	ied_venno,  	
	ied_cusven,  
	ied_prdven, 	
	isnull(ied_cus1no,'') as 'ied_cus1no',
	isnull(ied_cus2no,'') as 'ied_cus2no',
	case (select count(*) from CUGRPINF (nolock) where cgi_cugrpcde = ied_cus1no) when 0 then
		case (select count(*) from CUBASINF (nolock) where cbi_cusno = ied_cus1no) when 0 then 'N/A' else 'CUST' end
		else 'GROUP' end as 'ied_cusgrp', 
	ied_venitm, 
	ied_ucpno,  
	isnull(ied_ditmno,'') as 'ied_ditmno',
	ied_itmtyp,  
	ied_mode,  
	ied_engdsc, 
	isnull(ied_untcde,'') as 'ied_untcde',   
	isnull(ied_inrqty,0) as 'ied_inrqty', 
	isnull(ied_mtrqty,0) as 'ied_mtrqty',   
	isnull(ied_cft,0) as 'ied_cft',  
	ied_conftr,  
	isnull(ied_curcde,'') as 'ied_curcde', 
	isnull(ied_ftyprc,0) as 'ied_ftyprc',  
	ied_lnecde,  
	isnull(ied_ftycst,0) as 'ied_ftycst',  
	isnull(ied_prctrm,'') as 'ied_prctrm', 
	isnull(ied_hkprctrm,'') as 'ied_hkprctrm',
	isnull(ied_trantrm,'') as 'ied_trantrm',
	ied_chndsc,  
	ltrim(str(month(ied_credat)))+'/'+ltrim(str(day(ied_credat)))+'/'+ltrim(str(year(ied_credat))) as 'ied_credat',  
	ied_itmsts, 
	ied_catlvl4, 
	ied_PckM,
	ied_inrlin,   
	ied_inrwin, 
	ied_inrhin, 
	ied_mtrlin,   
	ied_mtrwin, 
	ied_mtrhin, 
	ied_grswgt,  
	ied_netwgt, 
	ied_pckitr,  
	ied_intrmk,
	ied_cstrmk,
	ied_creusr,  
	cast(ied_timstp as int) as 'ied_timstp',   
	ied_itmseq,  
	ied_upddat,   
	ied_updusr, 
	ied_recseq,  --isnull(iad_venitm,'') as 'iad_venitm'  
  
	ied_chkdat,  
	ied_xlsfil,  

	round(isnull(ied_ftyprc,0) / (case  when ied_conftr is NULL then 1   
					 when ied_conftr = 0 then 1  
					 else ied_conftr end),4) as 'Fty Price in PC'  
From  IMITMEXDAT  

Where    
	(ied_itmsts = (case @itmsts when '' then 'CMP' else @itmsts end)  
	or  
	ied_itmsts = (case @itmsts when '' then 'INC' else @itmsts end)) and  
	
	ied_credat >= (case @fromdate when '' then '1900-01-01' else @fromdate end) and  
	ied_credat <= (case @todate when '' then '2099-12-31 23:59:59' else @todate + ' 23:59:59' end) and  
	--Lester Wu 2005/06/07, add Custom Vendor ------------------------------------------------------------------------  
	ied_cusven between (case @fromCusVen when '' then '' else @fromCusVen end)   
	and  
	(case @toCusVen when '' then 'ZZZZZZ' else @toCusVen end)  and  
	----------------------------------------------------------------------------------------------------------------------------------  
	ied_venno between (case @fromvendor when '' then '' else @fromvendor end)   
	and  
	(case @tovendor when '' then 'ZZZZZZ' else @tovendor end)  and  
	
	ied_prdven between (case @fromprdven when '' then '' else @fromprdven end)   
	and  
	(case @toprdven when '' then 'ZZZZZZ' else @toprdven end)  and  
	
	ied_lnecde between (case @fromline when '' then '' else @fromline end)   
	and  
	(case @toline when '' then 'ZZZZZZZZZZ' else @toline end)  and  
	
	ied_venitm between (case @venitm when '' then '' else @venitm end)   
	and  
	 (case @venitm when '' then 'ZZZZZZZZZZZZZZZZZZZZ' else @venitm end) and  
	
	(ied_stage = (case @approve when 0 then '' else 'A' end)   
	or   
	ied_stage  = (case @reject when 0 then '' else 'R' end)   
	or   
	ied_stage = (case @wait when 0 then '' else 'W' end) )  

order by ied_credat












GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMEXDAT] TO [ERPUSER] AS [dbo]
GO
