/****** Object:  StoredProcedure [dbo].[sp_prepare_QCRpt_submit]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_prepare_QCRpt_submit]
GO
/****** Object:  StoredProcedure [dbo].[sp_prepare_QCRpt_submit]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_prepare_QCRpt_submit]
@tmprptno nvarchar(20)
--,@actcde nvarchar(20)

AS

SET NOCOUNT ON

declare @submitAvailable bit

set @submitAvailable = 0

--#check report data exist

if (select count(*) from qcrpthdr where qrh_tmprptno = @tmprptno) <> 0
begin
	
	if (select count(*) from qcrpthdr where 
	qrh_tmprptno = @tmprptno 
	and (qrh_rptstatus in ('VALID','IN-VALID','OPEN') or (qrh_rptstatus = 'CONFIRM' and upper(qrh_shipapprv) like '%REJECT%')))
	 <> 0
	begin
		set @submitAvailable = 1
	end
	else
	--report is confirm, not allow submit again
	begin
		set @submitAvailable = 0
	end
end
else
begin
	set @submitAvailable = 1
end

if @submitAvailable = 1
begin 
	DELETE FROM QCRPTHDR where qrh_tmprptno = @tmprptno	

	DELETE FROM QCRPTDTL where qrd_tmprptno = @tmprptno	

	DELETE FROM QCRPTGNL where qrg_tmprptno = @tmprptno	

	DELETE FROM QCRPTIMG where qri_tmprptno = @tmprptno	

	DELETE FROM QCRPTDFT where qdt_tmprptno = @tmprptno	

	DELETE FROM QCDFTIMG where qdt_tmprptno = @tmprptno	
end

select @submitAvailable submitAvailable
--, @actcde actcde




GO
GRANT EXECUTE ON [dbo].[sp_prepare_QCRpt_submit] TO [ERPUSER] AS [dbo]
GO
