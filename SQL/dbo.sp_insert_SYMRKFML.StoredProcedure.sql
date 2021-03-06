/****** Object:  StoredProcedure [dbo].[sp_insert_SYMRKFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYMRKFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYMRKFML]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003




/************************************************************************
Author:		Samuel Chan   
Date:		15th September, 2001
Description:	Insert data into SYMRKFML
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_SYMRKFML] 
--------------------------------------------------------------------------------------------------------------------------------------

@ymf_cocde	nvarchar(6) = ' ',
@ymf_degvenno	nvarchar(6),
@ymf_prdvenno	nvarchar(6),
@ymf_mkpopt	nvarchar(5),
@ymf_fmlopt	nvarchar(5),
--@ymf_def		nvarchar(2),
@ymf_updusr	nvarchar(30),
@ymf_effdat	datetime
--@cbi_updusr	nvarchar(30)


--------------------------------------------------------------------------------------------------------------------------------------
AS

declare @ymf_seq int

--Set @ymf_seq = (Select isnull(max(ymf_seq),0)+1 from symrkfml where ymf_cocde = @ymf_cocde and ymf_degvenno = @ymf_degvenno and ymf_prdvenno = @ymf_prdvenno)
Set @ymf_seq = (Select isnull(max(ymf_seq),0)+1 from symrkfml where ymf_degvenno = @ymf_degvenno and ymf_prdvenno = @ymf_prdvenno)

INSERT INTO  SYMRKFML

(
ymf_cocde,
ymf_degvenno,
ymf_prdvenno,
ymf_seq,
ymf_mkpopt,
ymf_fmlopt,
--ymf_def,
ymf_effdat,
ymf_creusr,
ymf_updusr,
ymf_credat,	
ymf_upddat
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
--@ymf_cocde,
' ',
@ymf_degvenno,
@ymf_prdvenno,
@ymf_seq,
@ymf_mkpopt,
@ymf_fmlopt,
--@ymf_def,
@ymf_effdat,
@ymf_updusr,
@ymf_updusr,
getdate(),
getdate()
)










GO
GRANT EXECUTE ON [dbo].[sp_insert_SYMRKFML] TO [ERPUSER] AS [dbo]
GO
