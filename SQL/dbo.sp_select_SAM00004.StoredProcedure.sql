/****** Object:  StoredProcedure [dbo].[sp_select_SAM00004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAM00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAM00004]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 30/07/2003  
-- Modification History  
-- Modified On + Modified By + Description  
----------------------------------------------------------------------------------------------------------------------------------  
-- 10/09/2003   Allan Yuen   add nolock to speed up the process.  
-- 11/20/2003   Marco Chan   performance tunning   
-- 03/22/2004  Lester Wu   return company code for genearate sample request with different Quotation   
--      with the same or different company code  
--      Allow return Quotation with zero sample quantity  
-- 05/21/2005  Marco Chan  Enhance with Custom Vendor  
-- 2005-10-06  Lester Wu  Incorrect cstomer vendor's contact information show  
--2006-02-08  Allan Yuen   Change logic to read vendor color from quotation color code  

-- sp_select_SAM00004 'UCPP','UQ0601874','Y'
CREATE   PROCEDURE [dbo].[sp_select_SAM00004]   
  
@cocde nvarchar(6),  
@qutno nvarchar(20),  
@optZeroQty char(1)  
AS  
  
declare @gen nvarchar(1), @mode nvarchar(3)  
  
set @gen = 'N'  
if @optZeroQty=''   
begin  
 SET @optZeroQty='N'  
end  
  
select    
 @Gen as 'Gen', qud_qutseq , qud_itmno ,  
 qud_itmdsc , qud_colcde ,   
 qud_untcde + ' / ' + ltrim(str(qud_inrqty)) + ' / ' + ltrim(str(qud_mtrqty)) as 'packing',  
 qud_stkqty, qud_cusqty, qud_smpqty,    
 qud_smpunt,  qud_qutno , qud_itmsts ,  
 bas.ibi_chndsc , qud_cuscol , qud_coldsc ,  
 qud_pckseq , qud_untcde , qud_inrqty ,  
 qud_mtrqty , qud_cft ,  qud_curcde ,  
 qud_dept ,  qud_venno , isnull(qud_subcde,  '')  as  'qud_subcde',  
 qud_cusven, qud_cussub,  
 qud_venitm ,   
 qud_ftyprc , qud_ftycst,  qud_note ,  qud_tbm ,   
 quh_issdat , quh_rvsdat ,  a.vci_adr ,   
 a.vci_stt ,  a.vci_cty ,   a.vci_zip ,   
 b.vci_cntctp , quh_cus1no , quh_cus2no ,    
 quh_cusagt , quh_salrep ,  quh_paytrm ,  
 quh_rmk,    
 c.cbi_cusno + ' - ' + c.cbi_cussna + (case c.cbi_cussts  when 'A' then ' (Active)'   
      when 'I' then ' (Inactive)'   
      when 'D' then ' (Discontinue)' end) as 'cbi_cus1na',  
 d.cbi_cusno + ' - ' + d.cbi_cussna + (case d.cbi_cussts  when 'A' then ' (Active)'   
      when 'I' then ' (Inactive)'   
      when 'D' then ' (Discontinue)' end) as 'cbi_cus2na',   
 ycf_value,  qud_smpprc, icf_vencol,    
 qud_fcurcde, qud_qutitmsts, quh_prctrm,  
 yst_charge, yst_chgval, qud_itmtyp,  
 qud_cusitm, ysr_saltem,  
 ISNULL(c.cbi_cussna,'') as 'cus1na',  
 ISNULL(d.cbi_cussna,'') as 'cus2na'  
 ,quh_cocde  

--Added by Mark Lau 20060922
,qud_alsitmno,	qud_alscolcde

--Added by Mark Lau 20070618
,qud_conftr,qud_contopc

from    
 QUOTNDTL (NOLOCK)  
  
 left join IMBASINF bas (NOLOCK) on  
 -- qud_cocde = ibi_cocde and qud_itmno = ibi_itmno  
--  (qud_itmno = ibi_itmno or qud_itmno = ibi_alsitmno ) AND  ibi_itmsts <> 'CLO'   
  qud_itmno = bas.ibi_itmno and  bas.ibi_itmsts <> 'CLO'   
  
 left join QUOTNHDR (NOLOCK) on  
 -- qud_cocde = quh_cocde and qud_qutno = quh_qutno  
  qud_qutno = quh_qutno  
  
 left join VNCNTINF a (NOLOCK)  on  
 -- qud_cocde = a.vci_cocde and qud_venno = a.vci_venno and  
 -- Lester Wu 2005-10-06 , Show Customer Vendor Address instead of Production Vendor Address  
 -- qud_venno = a.vci_venno and  
  qud_cusven = a.vci_venno and  
  vci_cnttyp = 'M'  
  
 left join VNCNTINF b (NOLOCK)  on  
 -- qud_cocde = b.vci_cocde and qud_venno = b.vci_venno and  
 -- Lester Wu 2005-10-06 , Show Customer Vendor Address instead of Production Vendor Address  
 -- qud_venno = b.vci_venno and  
  qud_cusven = b.vci_venno and  
  b.vci_cnttyp = 'GENL' and b.vci_cntdef = 'Y'  
  
 left join VNBASINF (NOLOCK) on  
  --qud_cocde = vbi_cocde and qud_venno = vbi_venno   
  qud_venno = vbi_venno   
  
 left join CUBASINF c (NOLOCK)  on   
 -- qud_cocde = c.cbi_cocde and quh_cus1no = c.cbi_cusno   
  quh_cus1no = c.cbi_cusno   
  
 left join CUBASINF d (NOLOCK)  on   
 -- qud_cocde = d.cbi_cocde and quh_cus2no = d.cbi_cusno   
  quh_cus2no = d.cbi_cusno   
  
 left join SYCONFTR (NOLOCK) on   
-- qud_cocde = ycf_cocde and ycf_code1 = qud_untcde and  
 ycf_code1 = qud_untcde and  
 ycf_code2 = qud_smpunt  
  
 left join IMCOLINF (NOLOCK) on  
 -- qud_cocde = icf_cocde and qud_itmno = icf_itmno and qud_colcde = icf_colcde  
 -- qud_itmno = icf_itmno and qud_colcde = icf_colcde  
 -- ibi_itmno = icf_itmno and qud_colcde = icf_colcde  --************Change for Alias Item no  
  --ibi_itmno = icf_itmno and qud_colcde = icf_vencol  
  bas.ibi_itmno = icf_itmno and qud_colcde = icf_colcde  
  
 left join SYSMPTRM (NOLOCK) on  
 -- qud_cocde = yst_cocde and quh_smpprd = yst_trmcde and yst_charge = 'Q'  
  quh_smpprd = yst_trmcde and yst_charge = 'Q'  
  
 left join SYSALREP (NOLOCK) on   
 -- quh_cocde = ysr_cocde and ysr_code1 = c.cbi_salrep  
  ysr_code1 = c.cbi_salrep  
  
where    
 qud_cocde = @cocde and   
 qud_qutno = @qutno  and  
 (bas.ibi_itmsts = 'INC' or bas.ibi_itmsts = 'CMP' ) and  
 vbi_vensts = 'A'   
 --Lester Wu 2004/03/22  
 --and qud_smpqty > 0   
 and (@optZeroQty='Y' or (@optZeroQty='N' and qud_smpqty>0))  
 ---------------------------------------------------------------------------------  
union  
  
select    
 @Gen as 'Gen', qud_qutseq , qud_itmno ,  
 qud_itmdsc , qud_colcde ,   
 qud_untcde + ' / ' + ltrim(str(qud_inrqty)) + ' / ' + ltrim(str(qud_mtrqty)) as 'packing',  
 qud_stkqty, qud_cusqty, qud_smpqty,    
 qud_smpunt,  qud_qutno , qud_itmsts ,  
 bas.ibi_chndsc , qud_cuscol , qud_coldsc ,  
 qud_pckseq , qud_untcde , qud_inrqty ,  
 qud_mtrqty , qud_cft ,  qud_curcde ,  
 qud_dept ,  qud_venno , isnull(qud_subcde,  '')  as  'qud_subcde',   
 qud_cusven, qud_cussub,  
 qud_venitm ,   
 qud_ftyprc , qud_ftycst,  qud_note ,  qud_tbm ,   
 quh_issdat , quh_rvsdat ,  a.vci_adr ,   
 a.vci_stt ,  a.vci_cty ,   a.vci_zip ,   
 b.vci_cntctp , quh_cus1no , quh_cus2no ,    
 quh_cusagt , quh_salrep ,  quh_paytrm ,  
 quh_rmk,    
 c.cbi_cusno + ' - ' + c.cbi_cussna + (case c.cbi_cussts  when 'A' then ' (Active)'   
      when 'I' then ' (Inactive)'   
      when 'D' then ' (Discontinue)' end) as 'cbi_cus1na',  
 d.cbi_cusno + ' - ' + d.cbi_cussna + (case d.cbi_cussts  when 'A' then ' (Active)'   
      when 'I' then ' (Inactive)'   
      when 'D' then ' (Discontinue)' end) as 'cbi_cus2na',   
 ycf_value,  qud_smpprc, icf_vencol,    
 qud_fcurcde, qud_qutitmsts, quh_prctrm,  
 yst_charge, yst_chgval, qud_itmtyp,  
 qud_cusitm, ysr_saltem,  
 ISNULL(c.cbi_cussna,'') as 'cus1na',  
 ISNULL(d.cbi_cussna,'') as 'cus2na'  
 ,quh_cocde  
--Added by Mark Lau 20060922
,qud_alsitmno,	qud_alscolcde

--Added by Mark Lau 20070618
,qud_conftr,qud_contopc
from    
 QUOTNDTL (NOLOCK)  
  
--Added on 20060919,Mark Lau
 left join IMBASINF bas (NOLOCK) on  
 -- qud_cocde = ibi_cocde and qud_itmno = ibi_itmno  
--  (qud_itmno = ibi_itmno or qud_itmno = ibi_alsitmno ) AND  ibi_itmsts <> 'CLO'   
  qud_itmno = bas.ibi_alsitmno AND  bas.ibi_itmsts <> 'CLO'   

--Mark Lau 
 left join IMBASINF als (NOLOCK) on  
  bas.ibi_alsitmno = als.ibi_itmno
--Mark Lau

 left join QUOTNHDR (NOLOCK) on  
 -- qud_cocde = quh_cocde and qud_qutno = quh_qutno  
  qud_qutno = quh_qutno  
  
 left join VNCNTINF a (NOLOCK)  on  
 -- qud_cocde = a.vci_cocde and qud_venno = a.vci_venno and  
 -- Lester Wu 2005-10-06, show Customer Vendor's contact information instead of Production Vendor  
 --  qud_venno = a.vci_venno and  
  qud_cusven = a.vci_venno and  
  vci_cnttyp = 'M'  
  
 left join VNCNTINF b (NOLOCK)  on  
 -- qud_cocde = b.vci_cocde and qud_venno = b.vci_venno and  
 -- Lester Wu 2005-10-06, show Customer Vendor's contact information instead of Production Vendor  
 -- qud_venno = b.vci_venno and  
  qud_cusven = b.vci_venno and  
  b.vci_cnttyp = 'GENL' and b.vci_cntdef = 'Y'  
  
 left join VNBASINF (NOLOCK) on  
  --qud_cocde = vbi_cocde and qud_venno = vbi_venno   
  qud_venno = vbi_venno   
  
 left join CUBASINF c (NOLOCK)  on   
 -- qud_cocde = c.cbi_cocde and quh_cus1no = c.cbi_cusno   
  quh_cus1no = c.cbi_cusno   
  
 left join CUBASINF d (NOLOCK)  on   
 -- qud_cocde = d.cbi_cocde and quh_cus2no = d.cbi_cusno   
  quh_cus2no = d.cbi_cusno   
  
 left join SYCONFTR (NOLOCK) on   
-- qud_cocde = ycf_cocde and ycf_code1 = qud_untcde and  
 ycf_code1 = qud_untcde and  
 ycf_code2 = qud_smpunt  
  
 left join IMCOLINF (NOLOCK) on  
 -- qud_cocde = icf_cocde and qud_itmno = icf_itmno and qud_colcde = icf_colcde  
 -- qud_itmno = icf_itmno and qud_colcde = icf_colcde  
 -- ibi_itmno = icf_itmno and qud_colcde = icf_colcde  --************Change for Alias Item no  
  --ibi_itmno = icf_itmno and qud_colcde = icf_vencol  
  bas.ibi_itmno = icf_itmno and qud_colcde = icf_colcde  
  
 left join SYSMPTRM (NOLOCK) on  
 -- qud_cocde = yst_cocde and quh_smpprd = yst_trmcde and yst_charge = 'Q'  
  quh_smpprd = yst_trmcde and yst_charge = 'Q'  
  
 left join SYSALREP (NOLOCK) on   
 -- quh_cocde = ysr_cocde and ysr_code1 = c.cbi_salrep  
  ysr_code1 = c.cbi_salrep  
  
where    
 qud_cocde = @cocde and   
 qud_qutno = @qutno  and  
 (bas.ibi_itmsts = 'INC' or bas.ibi_itmsts = 'CMP' ) and  
 isnull(als.ibi_itmsts,'') <> 'OLD'   and	-- 2006-09-19 Mark Lau
 vbi_vensts = 'A'   
 --Lester Wu 2004/03/22  
 --and qud_smpqty > 0   
 and (@optZeroQty='Y' or (@optZeroQty='N' and qud_smpqty>0))  
 ---------------------------------------------------------------------------  
  
order by   
 qud_qutno, qud_qutseq


GO
GRANT EXECUTE ON [dbo].[sp_select_SAM00004] TO [ERPUSER] AS [dbo]
GO
