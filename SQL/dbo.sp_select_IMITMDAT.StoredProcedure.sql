/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













/*
=================================================================
Program ID	: sp_select_IMITMDAT
Description	: Retrieve IM Data entries for Approval
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-03-24 	David Yue		SP Created
=================================================================
*/

  
CREATE      PROCEDURE [dbo].[sp_select_IMITMDAT]   
  
@cocde		nvarchar(6),
@itmsts		nvarchar(10),
@mode		nvarchar(6),   
@fromdate	nvarchar(10),
@todate		nvarchar(10),
@fromvenno	nvarchar(6),   
@tovenno	nvarchar(6),
@fromline	nvarchar(10),
@toline		nvarchar(10),   
@venitm		nvarchar(20),
@approve	int,
@reject		int,  
@wait		int,
@fromprdven	nvarchar(6),
@toprdven	nvarchar(6),  
@fromCusVen	nvarchar(6),
@toCusVen	nvarchar(6),  
@chkAlias	char(1) , 
@cus1noFm	nvarchar(6),
@cus1noTo	nvarchar(6),
@cus2noFm	nvarchar(6),
@cus2noTo	nvarchar(6),
@usrid		nvarchar(30)  
  
AS  
  
select 	
	iid_stage,
	iid_stage as 'old_stage',
	iid_venno,
	iid_ftyprctrm,
	iid_prctrm,
	iid_trantrm,
	iid_cusven,
	iid_prdven,
	iid_venitm, 
	iid_itmno,  
	iid_itmtyp,  
	iid_mode,  
	iid_engdsc, 
	iid_pckitr, 
	iid_untcde,   
	iid_inrqty, 
	iid_mtrqty,   
	iid_cft,  
	iid_conftr,  
	iid_curcde, 
	iid_ftyprc,  
	iid_lnecde,  
	iid_ftycst,  
	iic_negprc,
	iid_chndsc,  
	right('0' + ltrim(rtrim(str(datepart(mm, iid_credat)))), 2) + '/' + right('0' + ltrim(rtrim(str(datepart(dd, iid_credat)))), 2) + '/' + ltrim(rtrim(str(datepart(yyyy, iid_credat)))) as 'iid_credat',
	iid_itmsts, 
	iid_catlvl4, 
	iid_inrlcm,   
	iid_inrwcm, 
	iid_inrhcm, 
	iid_mtrlcm,   
	iid_mtrwcm, 
	iid_mtrhcm, 
	iid_grswgt,  
	iid_netwgt, 
	case when datepart(yyyy, iid_period) = 1900 then '' else ltrim(rtrim(str(datepart(yyyy, iid_period)))) + '-' + right('0' + ltrim(rtrim(str(datepart(mm, iid_period)))), 2) end as 'iid_period',
	case when datepart(yyyy, iid_cstexpdat) = 1900 then '' else iid_cstexpdat end as 'iid_cstexpdat',
	iid_creusr,  
	cast(iid_timstp as int) as 'iid_timstp',   
	iid_itmseq,  
	iid_upddat,   
	iid_updusr, 
	iid_recseq,
	iid_chkdat,  
	iid_xlsfil,  
	round(isnull(iid_ftyprc,0) / (case  when iid_conftr is NULL then 1 when iid_conftr = 0 then 1 else iid_conftr end),4) as 'Fty Price in PC',
	iic_cus1no,
	iic_cus2no,
	isnull(iid_ftytmp,'N') as 'iid_ftytmp'
	into #temp
from	IMITMDAT HDR (nolock)
	join IMITMDATCST  DTL(nolocK) on
		iic_itmseq = iid_itmseq and
		iic_recseq = iid_recseq and
		iic_xlsfil = iid_xlsfil and
		iic_chkdat = iid_chkdat and
		iic_venitm = iid_venitm
where	iid_stage = 'W' and
	iid_itmsts between (case @itmsts when '' then '' else @itmsts end) and (case @itmsts when '' then 'ZZZ' else @itmsts end) 
	and

	(
	iid_mode 	between (case @mode when '' then '' else @mode end) 	
			and (case @mode when '' then 'ZZZ' else @mode end) 
--	and 
--	(@chkAlias = 'Y' and iid_alsitmno <> '') 
--	or (@chkAlias = 'N' and iid_alsitmno = '')
	)

	and
	(iid_mode between (case @mode when '' then '' else @mode end) and (case @mode when '' then 'ZZZ' else @mode end)) and
	iid_credat between (case @fromdate when '' then '1900-01-01' else @fromdate end) and (case @todate when '' then getdate() else @todate end) and
	iid_venno between (case @fromvenno when '' then '' else @fromvenno end) and (case @tovenno when '' then 'ZZZZZZ' else @tovenno end) and
	iid_lnecde between (case @fromline when '' then '' else @fromline end) and (case @toline when '' then 'ZZZZZZZZZZ' else @toline end) and
	iid_venitm between (case @venitm when '' then '' else @venitm end) and (case @venitm when '' then 'ZZZZZZZZZZZZZZZZZZZZ' else @venitm end) and
	((iid_stage = case @approve when 0 then '' else 'A' end) or (iid_stage = case @reject when 0 then '' else 'R' end) or (iid_stage = case @wait when 0 then '' else 'W' end)) and
	iid_prdven between (case @fromprdven when '' then '' else @fromprdven end) and (case @toprdven when '' then 'ZZZZZZ' else @toprdven end) and
	iid_cusven between (case @fromcusven when '' then '' else @fromcusven end) and (case @tocusven when '' then 'ZZZZZZ' else @tocusven end) and
	iic_cus1no between (case @cus1noFm when '' then '' else @cus1noFm end) and (case @cus1noTo when '' then 'ZZZZZZ' else @cus1noTo end) and
	iic_cus1no between (case @cus2noFm when '' then '' else @cus2noFm end) and (case @cus2noTo when '' then 'ZZZZZZ' else @cus2noTo end)
order by iid_credat, iid_venitm, iid_untcde, iid_conftr, iid_inrqty, iid_mtrqty, iic_cus1no, iic_cus2no, iid_prctrm, iid_trantrm 


select ROW_NUMBER()  OVER (ORDER BY  iid_credat, iid_venitm, iid_untcde, iid_conftr, iid_inrqty, iid_mtrqty, iic_cus1no, iic_cus2no, iid_prctrm, iid_trantrm ) as 'no',
* from #temp
drop table #temp



GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMDAT] TO [ERPUSER] AS [dbo]
GO
