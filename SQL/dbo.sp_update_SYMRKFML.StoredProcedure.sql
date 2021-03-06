/****** Object:  StoredProcedure [dbo].[sp_update_SYMRKFML]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYMRKFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYMRKFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003


/*
S A M U E L
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SYMRKFML]

                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ymf_cocde	nvarchar(6) = ' ',
@ymf_degvenno	nvarchar(6),
@ymf_prdvenno	nvarchar(6),
@ymf_seq		int,
@ymf_mkpopt	nvarchar(5),
@ymf_fmlopt	nvarchar(5),
--@ymf_def		nvarchar(2),
@ymf_updusr	nvarchar(30),
@ymf_effdat	datetime

---------------------------------------------- 
 
AS


begin
update symrkfml

set 
--ymf_cocde = @ymf_cocde,
ymf_degvenno = @ymf_degvenno,
ymf_prdvenno = @ymf_prdvenno,
ymf_mkpopt = @ymf_mkpopt,
ymf_fmlopt = @ymf_fmlopt,
/*
--ymf_def = @ymf_def,
*/
ymf_effdat = @ymf_effdat,
ymf_updusr = @ymf_updusr,
ymf_upddat=getdate()                                  

--------------------------------- 

 where
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--ymf_cocde = @ymf_cocde and
--ymf_cocde = ' ' and
ymf_degvenno = @ymf_degvenno and
ymf_prdvenno = @ymf_prdvenno and
ymf_seq = @ymf_seq
---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_update_SYMRKFML] TO [ERPUSER] AS [dbo]
GO
