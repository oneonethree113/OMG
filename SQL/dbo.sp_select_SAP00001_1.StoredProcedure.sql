/****** Object:  StoredProcedure [dbo].[sp_select_SAP00001_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAP00001_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAP00001_1]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_select_SAP00001_1] 
@cocde		nvarchar(6) , 
@sapno		varchar(100),
@sapseq		varchar(100)

AS    
BEGIN    

select sod_ordno , sod_ordseq , sod_itmno , sod_pckunt,sod_inrctn,sod_mtrctn,soh_cus1no,soh_cus2no,sod_ordqty,sod_posstr from scorddtl (nolock) 
left join scordhdr (nolock) on sod_ordno = soh_ordno 
where sod_cocde = @cocde  and sod_zorvbeln = @sapno and sod_zorposnr = @sapseq

 

END





GO
GRANT EXECUTE ON [dbo].[sp_select_SAP00001_1] TO [ERPUSER] AS [dbo]
GO
