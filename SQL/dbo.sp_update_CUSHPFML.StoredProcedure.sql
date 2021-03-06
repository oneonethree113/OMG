/****** Object:  StoredProcedure [dbo].[sp_update_CUSHPFML]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUSHPFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUSHPFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[sp_update_CUSHPFML]
@csf_cocde nvarchar(6),
@csf_cus1no nvarchar(10),
@csf_cus2no nvarchar(10),
@csf_venno nvarchar(10),
@csf_shpstrbuf	int,
@csf_shpendbuf	int,
@csf_cancelbuf	int,
@csf_updusr	nvarchar(30)

AS

begin

Update CUSHPFML set
csf_shpstrbuf = @csf_shpstrbuf,
csf_shpendbuf = @csf_shpendbuf,
csf_cancelbuf = @csf_cancelbuf,
csf_updusr = @csf_updusr,
csf_upddat = getdate()
where
csf_cus1no = @csf_cus1no and
csf_cus2no = @csf_cus2no and
csf_venno = @csf_venno

end








GO
GRANT EXECUTE ON [dbo].[sp_update_CUSHPFML] TO [ERPUSER] AS [dbo]
GO
