/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNBASINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_VNBASINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNBASINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_physical_delete_VNBASINF] 

@vbi_cocde nvarchar(6),
@vbi_venno nvarchar(6)


AS

begin tran T1

delete from VNBASINF
where 	
--vbi_cocde = @vbi_cocde and 	
vbi_venno = @vbi_venno

delete from VNCNTINF
where 	
--vci_cocde = @vbi_cocde and 
vci_venno=@vbi_venno

delete from VNCSEINF
where	
--vcs_cocde = @vbi_cocde and 
vcs_venno = @vbi_venno

delete from VNPUCINF
where	
--vpf_cocde = @vbi_cocde and	
vpf_venno = @vbi_venno

delete from VNCATREL
where	
--vcr_cocde = @vbi_cocde and 
vcr_venno = @vbi_venno

--Frankie Cheung 20090602
Delete from VNITMNAT
where 	
vin_venno = @vbi_venno

--Benjamin Ng 20130405
Delete from VNCUGREL
where
vcr_venno = @vbi_venno

--Benjamin Ng 20130405
Delete from VNPRCTRM
where
vpt_venno = @vbi_venno

commit tran T1



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_VNBASINF] TO [ERPUSER] AS [dbo]
GO
