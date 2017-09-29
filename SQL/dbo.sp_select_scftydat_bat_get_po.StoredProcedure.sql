/****** Object:  StoredProcedure [dbo].[sp_select_scftydat_bat_get_po]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_scftydat_bat_get_po]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_scftydat_bat_get_po]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_select_scftydat_bat_get_po]
                                                                                                                                                                                                                                                                 
@cocde 	nvarchar(6),
@scno nvarchar(30)

 
AS

select distinct pod_purord from poorddtl
where
pod_scno = @scno
order by pod_purord asc


GO
GRANT EXECUTE ON [dbo].[sp_select_scftydat_bat_get_po] TO [ERPUSER] AS [dbo]
GO
