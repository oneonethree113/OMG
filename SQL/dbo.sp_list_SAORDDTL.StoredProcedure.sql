/****** Object:  StoredProcedure [dbo].[sp_list_SAORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SAORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SAORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Johnson Lai 
Date:		Feb 18, 2002
Description:	Select data From SORDSUM
Parameter:	1. Company
		2. Primary customer
		3. Item  No.
		4 Color Code
************************************************************************/

CREATE procedure [dbo].[sp_list_SAORDDTL]
                                                                                                                                                                                                                                                               
@sad_cocde nvarchar(6) ,
@sad_cus1no nvarchar(20),
@sad_itmno nvarchar(20),
@sad_colcde nvarchar(30)
 
AS
begin
select 

'   '  as 'DEL',
sad_cocde,
sad_qutno,
sad_qutseq,
sad_seqno,
sad_cus1no,
sad_cus1na,
sad_cus2no,
sad_cus2na,
sad_orgitm,
sad_itmno,
sad_itmdsc,
sad_colcde,
sad_untcde,
sad_inrqty,
sad_mtrqty,
sad_cft,
sad_curcde,
sad_smpuntcde,
sad_smpselprc,
sad_smpftyprc,
sad_smpqty,
sad_shpqty,
sad_chgqty,
sad_freqty,
sad_stkqty,
sad_cusqty,
sad_reqno,
sad_reqseq,
sad_delflg,
sad_creusr,
sad_updusr,
sad_credat,
sad_upddat,
sad_timstp,
sad_itmtyp,

sad_smpselprc as 'qud_smpprc',
sad_cuscol as 'qud_cuscol',
sad_coldsc  as 'qud_coldsc',
sad_venno  as 'qud_venno',
sad_subcde  'qud_subcde',
sad_cusven  as 'qud_cusven',
sad_cussub  'qud_cussub',
sad_fcurcde  as 'qud_fcurcde',
sad_smpftyprc  as 'qud_ftyprc',

/*
isnull(qud_smpprc,0) as 'qud_smpprc',
isnull(qud_cuscol,'') as 'qud_cuscol',
isnull(qud_coldsc,'') as 'qud_coldsc',

isnull(qud_venno,'') as 'qud_venno',
isnull(qud_subcde,'') as 'qud_subcde',
isnull(qud_fcurcde,'') as 'qud_fcurcde',


CASE sad_cocde WHEN  'UCPP' THEN round(isnull(qud_ftyprc,0) / isnull(ycf_value,1),4) 
ELSE round(isnull(qud_ftycst,0) / isnull(ycf_value,1),4) END 
 as 'qud_ftyprc',
*/

isnull(cast(sad_untcde as nvarchar(6)) + ' / ' + 
cast(sad_inrqty as nvarchar(10)) + ' / ' + 
cast(sad_mtrqty as nvarchar(10)) + ' / ' + 
cast(sad_cft as nvarchar(10)) + ' / ' + 
cast(sad_qutno as nvarchar(20)),'')  as 'sad_pck',

max(sad_credat) as 'max_sad_credat',

sad_cusitm,
vbi_ventyp
FROM SAORDDTL
left join QUOTNDTL on qud_cocde = sad_cocde and qud_qutno = sad_qutno and qud_qutseq = sad_qutseq
--left join SYCONFTR on  sad_cocde = ycf_cocde and qud_untcde = ycf_code1 and ycf_code2 = 'PC'
left join SYCONFTR on  qud_untcde = ycf_code1 and ycf_code2 = 'PC'
left join IMBASINF on ibi_itmno = sad_itmno or ibi_alsitmno = sad_itmno
left join VNBASINF on vbi_venno = ibi_venno


WHERE                                                                                                                                                                                                                                                               
sad_cocde  = @sad_cocde  and 
--sad_cus1no= @sad_cus1no and
sad_cus1no  in (select cbi_cusno from cubasinf where cbi_cusno = @sad_cus1no  or cbi_cusali =  @sad_cus1no )  and
sad_itmno = @sad_itmno and
ltrim(rtrim(sad_colcde)) = ltrim(rtrim(@sad_colcde)) 
--and (sad_delflg = 'N' or sad_delflg = 'C')  -- added by tommy on 25 march 2002
and sad_delflg = 'N' -- added by Marco at 08 July 2004


GROUP BY

sad_cocde,
sad_qutno,
sad_qutseq,
sad_seqno,
sad_cus1no,
sad_cus1na,
sad_cus2no,
sad_cus2na,
sad_orgitm,
sad_itmno,
sad_itmdsc,
sad_colcde,
sad_untcde,
sad_inrqty,
sad_mtrqty,
sad_cft,
sad_curcde,
sad_smpuntcde,
sad_smpselprc,
sad_smpftyprc,
sad_smpqty,
sad_shpqty,
sad_chgqty,
sad_freqty,
sad_stkqty,
sad_cusqty,
sad_reqno,
sad_reqseq,
sad_delflg,
sad_creusr,
sad_updusr,
sad_credat,
sad_upddat,
sad_timstp,
sad_itmtyp,

sad_smpselprc,
sad_cuscol,
sad_coldsc,
sad_venno,
sad_subcde,
sad_cusven,
sad_cussub,
sad_fcurcde,
sad_smpftyprc,


isnull(cast(sad_untcde as nvarchar(6)) + ' / ' + 
cast(sad_inrqty as nvarchar(10)) + ' / ' + 
cast(sad_mtrqty as nvarchar(10)) + ' / ' + 
cast(sad_cft as nvarchar(10)) + ' / ' + 
cast(sad_qutno as nvarchar(20)),''),
sad_cusitm,
vbi_ventyp


ORDER BY sad_untcde, sad_inrqty, sad_mtrqty, sad_cft
END




GO
GRANT EXECUTE ON [dbo].[sp_list_SAORDDTL] TO [ERPUSER] AS [dbo]
GO
