/****** Object:  StoredProcedure [dbo].[sp_select_SAINVDTL_CHECK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAINVDTL_CHECK]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAINVDTL_CHECK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_select_SAINVDTL_CHECK] 

@cus1no	nvarchar(10),		
@qutno		nvarchar(20),
@qutseq	integer ,
@reqno		nvarchar(20),
@reqseq	integer 


AS


select sad_curcde from saorddtl 
where sad_qutno = @qutno and
	sad_qutseq = @qutseq and
	sad_reqno = @reqno and
	sad_reqseq = @reqseq and
	sad_cus1no = @cus1no


GO
GRANT EXECUTE ON [dbo].[sp_select_SAINVDTL_CHECK] TO [ERPUSER] AS [dbo]
GO
