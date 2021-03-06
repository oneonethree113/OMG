/****** Object:  StoredProcedure [dbo].[sp_list_BAINVDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_BAINVDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_BAINVDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_list_BAINVDTL] 

@cocde 	nvarchar(6),
@usrid	nvarchar(30)

AS

select 

distinct

cast(ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) as datetime) as 'bid_txndat'


from 

BAINVDTL

order by cast(ltrim(str(month(bid_txndat)))+'/'+ltrim(str(day(bid_txndat)))+'/'+ltrim(str(year(bid_txndat))) as datetime) desc




GO
GRANT EXECUTE ON [dbo].[sp_list_BAINVDTL] TO [ERPUSER] AS [dbo]
GO
