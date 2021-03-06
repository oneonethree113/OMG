/****** Object:  StoredProcedure [dbo].[sp_insert_QCREQACT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QCREQACT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QCREQACT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/*
=============================================================================


=============================================================================
*/

--sp_select_POR00003 'UCP','PR0202457-B001','PR03000090-B001','Y'

CREATE PROCEDURE [dbo].[sp_insert_QCREQACT]
@cocde	nvarchar(6),	
@qcno	nvarchar(20),	
@verno	int,	
@actyp		nvarchar(1),
@oldsts		nvarchar(3),
@newsts		nvarchar(3),
@usr		nvarchar(30),
@insp_year smallint,
@insp_week smallint,
@alert nvarchar(1)


AS


INSERT INTO QCREQACT(qca_cocde,qca_qcno,qca_verno,qca_actyp,qca_oldsts,qca_newsts,qca_usr,qca_actdat,qca_timstp,qca_inspyear,qca_inspweek,qca_alert)
VALUES				 (@cocde,     @qcno,   @verno,   @actyp,   @oldsts,   @newsts,   @usr, getdate(),   null   ,@insp_year  ,@insp_week  ,@alert   );







GO
GRANT EXECUTE ON [dbo].[sp_insert_QCREQACT] TO [ERPUSER] AS [dbo]
GO
