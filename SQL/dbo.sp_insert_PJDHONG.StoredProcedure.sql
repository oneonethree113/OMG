/****** Object:  StoredProcedure [dbo].[sp_insert_PJDHONG]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PJDHONG]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PJDHONG]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_PJDHONG]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@pjd_cocde	nvarchar(6),
@pjd_batno	nvarchar(20),
@pjd_jobord	nvarchar(20),
@pjd_confrm	nvarchar(1),
@pjd_updusr 	nvarchar(30)
AS
INSERT INTO POJBBDTL
(
pjd_cocde,	
pjd_batno,	
pjd_jobord,
pjd_confrm,
pjd_updusr,
pjd_creusr
) VALUES (
@pjd_cocde,	
@pjd_batno,	
@pjd_jobord,
@pjd_confrm,
@pjd_updusr,
@pjd_updusr
)     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------





GO
GRANT EXECUTE ON [dbo].[sp_insert_PJDHONG] TO [ERPUSER] AS [dbo]
GO
