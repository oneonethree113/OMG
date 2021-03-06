/****** Object:  StoredProcedure [dbo].[sp_select_BAINVDTL_SUB]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BAINVDTL_SUB]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BAINVDTL_SUB]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_select_BAINVDTL_SUB] 


@Cocde 	nvarchar(10),
@txnDat	nvarchar(20),
@usrid	nvarchar(30)

AS


SELECT 

bid_cocde,
bid_account,
sum(bid_amount) as 'bid_amount',
@txnDat as 'TxnDat'

FROM BAINVDTL

WHERE

bid_doctyp <> 'xx'  and
convert(nvarchar(10), bid_txndat, 101) =case when @txndat='' then convert(nvarchar(10), bid_txndat, 101) else @txndat end

group by bid_cocde, bid_account
order by bid_cocde, bid_account



GO
GRANT EXECUTE ON [dbo].[sp_select_BAINVDTL_SUB] TO [ERPUSER] AS [dbo]
GO
