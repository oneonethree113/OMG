/****** Object:  StoredProcedure [dbo].[sp_select_SYMRKFML_Grp]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYMRKFML_Grp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYMRKFML_Grp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_select_SYMRKFML_Grp] 

@ymf_cocde 	nvarchar(6) = ' ' ,
@ymf_degvenno	nvarchar(6),
@ymf_prdvenno	nvarchar(6)
AS

Select 
	distinct
	ymf_effdat

from SYMRKFML
--left join SYFMLINF a on a.yfi_cocde = @ymf_cocde and a.yfi_fmlopt = ymf_mkpopt
--left join SYFMLINF b on b.yfi_cocde = @ymf_cocde and b.yfi_fmlopt = ymf_fmlopt
left join SYFMLINF a on a.yfi_fmlopt = ymf_mkpopt
left join SYFMLINF b on b.yfi_fmlopt = ymf_fmlopt
--where ymf_cocde = @ymf_cocde and
where ymf_cocde = ' ' and
ymf_degvenno = @ymf_degvenno and
ymf_prdvenno = @ymf_prdvenno
order by ymf_effdat









GO
GRANT EXECUTE ON [dbo].[sp_select_SYMRKFML_Grp] TO [ERPUSER] AS [dbo]
GO
