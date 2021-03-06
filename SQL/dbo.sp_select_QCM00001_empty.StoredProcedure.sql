/****** Object:  StoredProcedure [dbo].[sp_select_QCM00001_empty]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00001_empty]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00001_empty]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_QCM00001_empty]

AS
BEGIN
	Select 
		'' as 'ACT',
		--'' as 'Week Fm',
		--'' as 'Week To',
		--'' as 'Date',
		'' as 'Year',
		'' as 'Week',
		'' as 'Mon', 
		'' as 'Tue', 
		'' as 'Wed', 
		'' as 'Thur', 
		'' as 'Fri', 
		'' as 'Sat', 
		'' as 'Sun',
		'OPE' as 'Req. Status',
		
		'' as 'Insp. Typ',
		'' as 'Sample',
		'' as 'GenBy',
		'' as 'GenBy Vendor',
		--'' as 'InspectMode',
		'' as 'SI Date', 
		'' as 'CY Date', 


		
		
		'' as 'CV',
		'' as 'PV',
		'' as 'FA',
		'' as 'Pri. Cust',
		'' as 'Sec. Cust',
		'' as 'SC No',
		'' as 'PO No',
		'' as 'Cust. PO',
		'' as 'PO Header Ship Date',	--Ship Start date

		--POORDDTL Only
		'' as 'PO_Seq',
		'' as 'Item Number',
		'' as 'Cust. Item No.',
		'' as 'Vendor Item No.',
		'' as 'Color', 
		'' as 'Packing & Terms',
		'' as 'Order Qty',
		'' as 'PO Detail Ship Date', --Ship Start date
		
		'' as 'Remark'

END

GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00001_empty] TO [ERPUSER] AS [dbo]
GO
