/****** Object:  StoredProcedure [dbo].[sp_select_BAINVDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BAINVDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BAINVDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_select_BAINVDTL] 


@Cocde 	nvarchar(10),
@txnDat	nvarchar(20),
@usrid	nvarchar(30)

AS

--SELECT  @txndat =  bid_txndat FROM BAINVDTL 
--WHERE  bid_cocde = 'AHEAD' and bid_doctyp = 'XX'

SELECT 
case when bid_cocde = 'ELLI' then 'ELLIWELL' else bid_cocde end as 'bid_cocde',
bid_doctyp + 
case when bid_doctyp = 'SH' then ' - Invoice'  else
case when bid_doctyp = 'SA' then ' - Sample Invoice' else
case when bid_doctyp = 'EL' then ' - Elliwell''s Invoice' else
case when bid_doctyp = 'EA' then ' - Elliwell''s Sample Invoice' else ''
end end end end as 'bid_doctyp',
bid_docno,
case when isnull(cbi_cussna,'')= '' then bid_cusno else bid_cusno + ' - ' + cbi_cussna end as 'bid_cusno',
bid_issdat,
bid_txndat,
case when isnull(A.ysi_dsc,'') = '' then bid_prctrm  else bid_prctrm + ' - ' +A.ysi_dsc end as 'bid_prctrm',
case when isnull(B.ysi_dsc,'') = '' then bid_paytrm  else bid_paytrm + ' - ' + B.ysi_dsc end as 'bid_paytrm',
case when bid_dptyp = 'A' then 'A - Invoice Amt' else
case when bid_dptyp = 'B' and bid_doctyp = 'EL' then 'B - Less 3% comm.' else 
case when bid_dptyp = 'B' and bid_doctyp = 'SH' then 'B - 5% Buying comm.' else
case when bid_dptyp = 'D' then 'D - Discount' else 
case when bid_dptyp = 'P' then 'P - Premium' else '' 
end end end end end  as 'bid_dptyp',

case when isnull(ydp_cde,'') = '' then bid_disprm else bid_disprm + ' - ' + ydp_dsc end as 'bid_disprm',
bid_seqno,
bid_account,
bid_desc,
bid_curcde,
bid_amount,
@txnDat as 'TxnDat'


FROM BAINVDTL

LEFT JOIN CUBASINF on cbi_cocde = Case bid_cocde when 'UCPP' then bid_cocde else 'UCP' end and bid_cusno = cbi_cusno and cbi_custyp = 'P'
LEFT JOIN SYSETINF A on A.ysi_cocde = Case bid_cocde when 'UCPP' then bid_cocde else 'UCP' end and A.ysi_typ='03' and bid_prctrm = A.ysi_cde
LEFT JOIN SYSETINF B on B.ysi_cocde = Case bid_cocde when 'UCPP' then bid_cocde else 'UCP' end and B.ysi_typ='04' and bid_paytrm = B.ysi_cde
LEFT JOIN SYDISPRM  on bid_cocde = ydp_cocde and bid_dptyp = ydp_type and bid_disprm = ydp_cde

WHERE

bid_doctyp <> 'xx'  and
convert(nvarchar(10), bid_txndat, 101) =case when @txndat='' then convert(nvarchar(10), bid_txndat, 101) else @txndat end

order by
bid_cocde,
bid_doctyp,
bid_docno



GO
GRANT EXECUTE ON [dbo].[sp_select_BAINVDTL] TO [ERPUSER] AS [dbo]
GO
