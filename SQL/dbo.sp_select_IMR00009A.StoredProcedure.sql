/****** Object:  StoredProcedure [dbo].[sp_select_IMR00009A]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00009A]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00009A]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/************************************************************************************************************************************************  
Author:  Kath Ng       
Date:  21st January, 2001  
Report ID: IMR00009  
Description: Document Report For Label  
************************************************************************************************************************************************  
Modification History  
************************************************************************************************************************************************  
Modified by Modified on Description  
************************************************************************************************************************************************  
Lester Wu  2005-05-26 add custom vendor, Secondary Customer Item #  
Lester Wu  2005-06-17 add respective PO # (Header and Detail)  
Marco Chan 2010-08-17 Extract Data with Relea
************************************************************************************************************************************************/  

--sp_select_IMR00009A 'UCPP','US0500001','US0500001'  

--sp_select_IMR00009A 'UCPP','US0500001','US0500001'  

CREATE PROCEDURE [dbo].[sp_select_IMR00009A]   
@gsCompany nvarchar(6),
@FromPriCustno nvarchar(5), 
@ToPriCustno nvarchar(5),
@FromJobno nvarchar(20),
@ToJobno nvarchar(20)--,

--@SCType char(1)  
AS  
  
BEGIN  
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

DECLARE @flg_pricustfrom char(1), @flg_pricustto char(1), @flg_jobnofrom char(1), @flg_jobnoto char(1), @flg_jobno char(1), @flg_jobno2 char(1)
SET @flg_jobno = 'N'
SET @flg_jobno2 = 'N'
SET @flg_jobnofrom = 'N'
SET @flg_jobnoto = 'N'

if @FromPriCustno <> ''
	SET @flg_pricustfrom = 'Y'
Else
	SET @flg_pricustfrom = 'N'
	
if @ToPriCustno <> ''
	SET @flg_pricustto = 'Y'
Else
	SET @flg_pricustto = 'N'

if @fromJobno = @ToJobno
	BEGIN
		SET @flg_jobno = 'Y'
	END
ELSE
	BEGIN
		if @FromJobno <> '' AND @ToJobno <> ''
			BEGIN
				Set @flg_jobno2 = 'Y'
			END
		Else
			BEGIN
				if @FromJobno <> ''
					SET @flg_jobnofrom = 'Y'
				if @ToJobno <> ''
					SET @flg_jobnoto = 'Y'
			END
			
	END
	

Select  
   
 --@gsCompany,  
 --@FromJobno,  
 --@ToJobno,  
 ltrim(isnull(dtl.sod_cusven,'') + ' ' + isnull(cusven.vbi_vensna,'')) as 'Custom Vendor',  --Lester Wu 2005-05-27, add Custom Vendor  
 dtl.sod_venno + ' ' + ven.vbi_vensna as 'Vendor',  
 --isnull(dtl.sod_subcde,'') as 'Sub Code',  
  
 dtl.sod_purord as 'PO No.',
 --poh_pursts as 'PO Status',
 dtl.sod_ordno as 'SC No.', 
 hdr.soh_ordsts as 'SC Status',
 pri.cbi_cusno + ' - ' + pri.cbi_cussna as 'Primary Customer', 
 case isnull(sec.cbi_cusno, '') when '' then '' else sec.cbi_cusno + ' - ' + sec.cbi_cussna end as 'Secondary Customer', 
 
 isnull(pod.pod_jobord,'') as 'Job Order No.',  
 dtl.sod_itmno as 'Item No',  
 dtl.sod_venitm as 'Vendor Item No.',  
 dtl.sod_cusitm as 'Customer Item#',  
 dtl.sod_seccusitm as 'Sec. Customer Item #', --Lester Wu 2005-05-27, add Secondary Customer Item No  
 dtl.sod_cussku as 'Customer SKU No.',  
 dtl.sod_itmdsc as 'English Desc.',  
 dtl.sod_colcde as 'Color Code',  
 dtl.sod_cuscol as 'Customer Color',  
 dtl.sod_coldsc as 'Color Desc.',  
 dtl.sod_dept as 'Dept',  
 dtl.sod_cususd as 'USD',   
 dtl.sod_cuscad as 'CAD',  
-- dtl.sod_pckunt,  
 ysi_dsc as 'UM',  
 dtl.sod_inrctn as 'Inner ',  
 dtl.sod_mtrctn as 'Master ',  
 --Lester Wu 2005/04/16  
 dtl.sod_cft as 'CFT',  
 dtl.sod_pckitr as 'Packing Inst.',   
 hdr.soh_cuspo as 'Cust PO# (Header)',  
 dtl.sod_cuspo as 'Cust PO# (Detail)',   
 --Lester Wu 2005-06-17  
 hdr.soh_resppo as 'Resp. PO# (Header)',  
 dtl.sod_resppo as 'Resp. PO# (Detail)',   
 --Lester Wu 2005/04/16  
 dtl.sod_code1 as 'UPC/EAN#(M)',   
-- dtl.sod_contopc as 'Convert To PC' ,	-- Lester Wu 2008-05-21
 dtl.sod_conftr as 'Conversion Factor',
 dtl.sod_ordqty as 'Order Qty',  
 dtl.sod_code2 as 'UPC/EAN#(I)',   
-- sod_inrctn = case dtl.sod_inrctn when 0 then '0' else str(dtl.sod_ordqty / dtl.sod_inrctn,10,0) end as 'I/ Qty',  
 case dtl.sod_inrctn when 0 then 0 else 0 + ltrim(rtrim(str(dtl.sod_ordqty / dtl.sod_inrctn,10,0))) end as 'I/ Qty',  
 dtl.sod_code3 as 'UPC/EAN#(C)',   
-- sod_mtrctn = case  dtl.sod_mtrctn when 0 then '0' else str(dtl.sod_ordqty / dtl.sod_mtrctn,10,0) end as 'M/ Qty',  
 case  dtl.sod_mtrctn when 0 then 0 else 0 + ltrim(rtrim(str(dtl.sod_ordqty / dtl.sod_mtrctn,10,0))) end as 'M/ Qty',  
-- ven.vbi_vennam,  
-- hdr.soh_lbldue  
 ltrim(str(dtl.sod_ctnstr,10,0)) as 'Start Ctn',  
 ltrim(str(dtl.sod_ctnend,10,0)) as 'End Ctn',  
 dtl.sod_shpstr as 'S/C Ship Start Date',  
 dtl.sod_shpend as 'S/C Ship End Date',  
 --ltrim(rtrim(isnull(convert(varchar(20),pod.pod_shpstr,101),''))) as 'PO Ship Start Date',  
 --ltrim(rtrim(isnull(convert(varchar(20),pod.pod_shpend,101),''))) as 'PO Ship End Date',   
 
 case isdate(pod.pod_shpstr) when 0 then '' else ltrim(rtrim(isnull(convert(varchar(20),pod.pod_shpstr,101),''))) end as 'PO Ship Start Date',
 case isdate(pod.pod_shpend) when 0 then '' else ltrim(rtrim(isnull(convert(varchar(20),pod.pod_shpend,101),''))) end as 'PO Ship End Date',
 --left(dtl.sod_rmk,200),  
 --substring(dtl.sod_rmk,201,100)  
 isnull(dtl.sod_hrmcde,'') as 'hstu#',
 dtl.sod_rmk as 'Remark',
 dtl.sod_pormk as 'PO Remark'
  
FROM SCORDHDR hdr
 left join SCORDDTL dtl on soh_ordno = sod_ordno
 --Lester Wu 2005-05-26, add custom vendor  
 left join VNBASINF cusven on isnull(sod_cusven,'') = vbi_venno
 left join CUBASINF pri on soh_cus1no = pri.cbi_cusno
 left join CUBASINF sec on soh_cus2no = sec.cbi_cusno
 left join POORDDTL pod on dtl.sod_cocde = pod.pod_cocde and dtl.sod_purord = pod.pod_purord and dtl.sod_purseq = pod.pod_purseq
 left join POORDHDR poh on pod_cocde = poh_cocde and pod_purord = poh_purord


 , VNBASINF ven, SYSETINF  
  
  
Where    
  
 hdr.soh_cocde = dtl.sod_cocde and hdr.soh_ordno = dtl.sod_ordno  
  
--and  dtl.sod_cocde = ven.vbi_cocde and dtl.sod_venno = ven.vbi_venno  
and  dtl.sod_venno = ven.vbi_venno  
  
  
--and dtl.sod_cocde = ysi_cocde and dtl.sod_pckunt = ysi_cde and ysi_typ = '05'  
and dtl.sod_pckunt = ysi_cde and ysi_typ = '05'  
  
--and hdr.soh_ordno between @FromJobno and @ToJobno
and hdr.soh_cocde = @gsCompany
and ((@flg_pricustfrom = 'N') OR ( @flg_pricustfrom = 'Y' and soh_cus1no >= @FromPriCustno))
and ((@flg_pricustto = 'N') OR (@flg_pricustto = 'Y' and soh_cus1no <= @ToPriCustno))
and ((@flg_jobnofrom = 'N') OR (@flg_jobnofrom = 'Y' and hdr.soh_ordno >= @FromJobno))
and ((@flg_jobnoto = 'N') OR (@flg_jobnoto = 'Y' and hdr.soh_ordno <= @ToJobno))
and ((@flg_jobno = 'N') OR (@flg_jobno = 'Y' and hdr.soh_ordno = @FromJobno))
and ((@flg_jobno2 = 'N') OR (@flg_jobno2 = 'Y' and hdr.soh_ordno between @FromJobno and @ToJobno))
--and hdr.soh_ordno between 'S0200022'  and 'S0200022'  and hdr.soh_cocde = 'UCP'  
--Lester Wu 2005-05-26, add custom vendor  
--and  dtl.sod_cusven = cusven.vbi_venno  
  
order by dtl.sod_cusven,dtl.sod_venno,dtl.sod_ordno, dtl.sod_cusitm,dtl.sod_seccusitm  



  
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
END






GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00009A] TO [ERPUSER] AS [dbo]
GO
