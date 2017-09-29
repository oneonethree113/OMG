/****** Object:  StoredProcedure [dbo].[sp_list_SYMRKFML_SYM00016]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYMRKFML_SYM00016]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYMRKFML_SYM00016]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_list_SYMRKFML_SYM00016] 

@ymf_cocde 	nvarchar(6) = ' ',
@ymf_degvenno	nvarchar(6),
@ymf_prdvenno	nvarchar(6)
AS

Select 
ymf_creusr as 'ymf_stutas',
ymf_cocde,
ymf_degvenno,
ymf_prdvenno,
ymf_seq,
ymf_mkpopt,
ymf_fmlopt,
ymf_def,
ymf_effdat,
ymf_creusr,
ymf_updusr,
ymf_credat,
ymf_upddat,
ymf_timstp



from SYMRKFML
where 
--ymf_cocde = @ymf_cocde and
ymf_cocde =  ' ' AND 
ymf_degvenno = @ymf_degvenno and
ymf_prdvenno = @ymf_prdvenno









GO
GRANT EXECUTE ON [dbo].[sp_list_SYMRKFML_SYM00016] TO [ERPUSER] AS [dbo]
GO
