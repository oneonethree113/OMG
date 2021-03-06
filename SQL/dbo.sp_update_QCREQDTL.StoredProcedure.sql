/****** Object:  StoredProcedure [dbo].[sp_update_QCREQDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QCREQDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QCREQDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_update_QCREQDTL]
	--Basic
	@qcd_cocde nvarchar(6), @qcd_qcno nvarchar(20), @qcd_qcseq int,
	
	--QC Detail
	@qcd_dtlsts nvarchar(5), 
	
	@qcd_mon char(1), @qcd_tue char(1), @qcd_wed char(1), @qcd_thur char(1), @qcd_fri char(1), @qcd_sat char(1), @qcd_sun char(1), 
	
	@qcd_samhdl nvarchar(10), 
	--@qcd_sidate datetime, @qcd_cydate datetime, 
	@qcd_rmk nvarchar(300), 

	--QC Itm Detail
	@qcd_xitmno nvarchar(20), @qcd_xitmdsc nvarchar(300), @qcd_xcolor nvarchar(20), @qcd_xpack nvarchar(100), 
	@qcd_xmtrdcm numeric(11, 4),@qcd_xmtrwcm numeric(11, 4),@qcd_xmtrhcm numeric(11, 4),@qcd_xinrdcm numeric(11, 4), @qcd_xinrwcm numeric(11, 4), @qcd_xinrhcm numeric(11, 4),
	@qcd_xgrswgt numeric(11, 4), @qcd_xnetwgt numeric(11, 4), @qcd_ordqty int, 
	
	
	--Basic
	@qcd_updusr nvarchar(30)
AS
BEGIN

	Update QCREQDTL 
	set
		qcd_dtlsts = @qcd_dtlsts, 
		qcd_mon = @qcd_mon, 
		qcd_tue = @qcd_tue,
		qcd_wed = @qcd_wed,
		qcd_thur = @qcd_thur,
		qcd_fri = @qcd_fri,
		qcd_sat = @qcd_sat,
		qcd_sun = @qcd_sun,
		qcd_samhdl = @qcd_samhdl, 
		--qcd_sidate = @qcd_sidate, 
		--qcd_cydate = @qcd_cydate, 
		qcd_rmk = @qcd_rmk,
		
		--QC Itm Detail
		qcd_xitmno = @qcd_xitmno, qcd_xitmdsc = @qcd_xitmdsc, qcd_xcolor = @qcd_xcolor, qcd_xpack = @qcd_xpack, 
		qcd_xmtrdcm = @qcd_xmtrdcm, qcd_xmtrwcm = @qcd_xmtrwcm, qcd_xmtrhcm = @qcd_xmtrhcm, qcd_xinrdcm = @qcd_xinrdcm, qcd_xinrwcm = @qcd_xinrwcm, qcd_xinrhcm = @qcd_xinrhcm, 
		qcd_xgrswgt = @qcd_xgrswgt, qcd_xnetwgt = @qcd_xnetwgt, qcd_ordqty = @qcd_ordqty, 
		
		qcd_updusr = @qcd_updusr, 
		qcd_upddat = getdate()
	WHERE
		qcd_qcno = @qcd_qcno AND
		qcd_qcseq = @qcd_qcseq
	
END


GO
GRANT EXECUTE ON [dbo].[sp_update_QCREQDTL] TO [ERPUSER] AS [dbo]
GO
