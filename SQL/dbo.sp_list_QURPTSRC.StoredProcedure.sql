/****** Object:  StoredProcedure [dbo].[sp_list_QURPTSRC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QURPTSRC]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QURPTSRC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_list_QURPTSRC] 

@cocde	nvarchar(5),
@qutno		nvarchar(20),
@report	nvarchar(20)

AS

declare
@cus1no	nvarchar(20),
@cus2no	nvarchar(20)

BEGIN

	select 
		@cus1no = quh_cus1no, 
		@cus2no = quh_cus2no
	from 
		QUOTNHDR
	where 
		quh_qutno = @qutno


	select 
		sqi_sheet,
		sqi_fldid,
		sqi_loc,
		sqs_tbl,
		sqs_fld,
		sqs_prefix,
		sqs_postfix,
		sqs_fldrow	
	from
		SYQURPTINF, SYQURPTSRC
	where
		sqi_fldid = sqs_fldid and
		sqi_cus1no = sqs_cus1no and
		sqi_cus2no = sqs_cus2no and
		sqi_cus1no =  @cus1no and
		sqi_cus2no =  @cus2no and
		sqi_rptid = @report


/*
	select 
		sqi_fldid,
		sqi_loc,
		qdi_value,
		sqs_tbl,
		sqs_fld,
		sqs_prefix,
		sqs_postfix,
		sqs_fldrow	
	from
		SYQURPTINF, QUADDINF, SYQURPTSRC   
	where
		sqi_fldid = qdi_fldid and 
		sqi_fldid = sqs_fldid and	
		sqi_rptid = @report and (qdi_qutseq = @qutseq or qdi_qutseq is null)
*/
/*
	select 
		sqi_fldid,
		sqi_loc,
		qdi_value,
		sqs_tbl,
		sqs_fld,
		sqs_prefix,
		sqs_postfix,
		sqs_fldrow	
	from
		(SYQURPTINF left join QUADDINF on sqi_fldid = qdi_fldid) left join SYQURPTSRC  on sqi_fldid = sqs_fldid 
	where
		sqi_rptid = 'ISU' and (qdi_qutseq = @qutseq or qdi_qutseq is null)
*/

END




GO
GRANT EXECUTE ON [dbo].[sp_list_QURPTSRC] TO [ERPUSER] AS [dbo]
GO
