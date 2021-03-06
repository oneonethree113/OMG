/****** Object:  StoredProcedure [dbo].[sp_insert_FYPRTFYO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_FYPRTFYO]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FYPRTFYO]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/08/2003

------------------------------------------------- 
CREATE procedure [dbo].[sp_insert_FYPRTFYO]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@fpf_cocde	nvarchar(6), --Not use to update
@fpf_fyohdr	nvarchar(20),
@fpf_ftycde	nvarchar(6),
@fpf_ordsts	nvarchar(2),
@fpf_filnam	nvarchar(255),
@fpf_creusr	nvarchar(30) -- Not use to update
                                     
------------------------------------ 
AS
 
insert into FYPRTFYO
(
fpf_fyohdr,
fpf_ftycde,
fpf_gendat,
fpf_ordsts,
fpf_filnam,
fpf_usrid,
fpf_credat,
fpf_lckflg
)

values(
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@fpf_fyohdr,
@fpf_ftycde,
getdate(),
@fpf_ordsts,
@fpf_filnam,
"",
getdate(),
0
)     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------





GO
GRANT EXECUTE ON [dbo].[sp_insert_FYPRTFYO] TO [ERPUSER] AS [dbo]
GO
