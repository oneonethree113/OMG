/****** Object:  StoredProcedure [dbo].[sp_insert_IMCTYINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMCTYINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMCTYINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject
*/

CREATE PROCEDURE [dbo].[sp_insert_IMCTYINF] 

@ici_cocde  	nvarchar(6) = ' ',
@ici_itmno  	nvarchar(20),
@ici_cusno 	nvarchar(8),
@ici_ctycde	nvarchar(6),
@ici_valdat 	datetime,
@ici_rmk 	nvarchar(200), 
@ici_updusr  	nvarchar(30)

AS
declare @max_seq int

--SET @max_seq = (Select isnull(max(ici_ctyseq),0) +1 from IMCTYINF where ici_cocde = @ici_cocde and ici_itmno = @ici_itmno)
SET @max_seq = (Select isnull(max(ici_ctyseq),0) +1 from IMCTYINF where ici_itmno = @ici_itmno)

insert into IMCTYINF
(
ici_cocde,
ici_itmno,
ici_ctyseq , 
ici_cusno ,
ici_ctycde,
ici_valdat ,
ici_rmk , 
ici_creusr,
ici_updusr  ,
ici_credat  ,
ici_upddat )

values
(
--@ici_cocde,
' ',
@ici_itmno,
@max_seq,
@ici_cusno,
@ici_ctycde,
@ici_valdat,
@ici_rmk,
@ici_updusr,
@ici_updusr ,
getdate(),
getdate())










GO
GRANT EXECUTE ON [dbo].[sp_insert_IMCTYINF] TO [ERPUSER] AS [dbo]
GO
