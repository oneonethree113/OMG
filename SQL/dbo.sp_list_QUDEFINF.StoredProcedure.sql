/****** Object:  StoredProcedure [dbo].[sp_list_QUDEFINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUDEFINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUDEFINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_list_QUDEFINF] 

@cocde	nvarchar(5),
@qutno		nvarchar(40),
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
		yqa_defval		
	from
		SYQURPTINF, SYQUADDINF
	where
		sqi_fldid = yqa_fldid and
		sqi_cus1no =  @cus1no and
		sqi_cus2no =  @cus2no and
		sqi_rptid = @report and
		sqi_fldid like 'A%'

END


GO
GRANT EXECUTE ON [dbo].[sp_list_QUDEFINF] TO [ERPUSER] AS [dbo]
GO
