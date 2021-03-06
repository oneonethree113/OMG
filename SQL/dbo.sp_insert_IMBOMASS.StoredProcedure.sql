/****** Object:  StoredProcedure [dbo].[sp_insert_IMBOMASS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMBOMASS]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMBOMASS]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO








-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
ALTER  Date   	: 
Last Modified  	: 19 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
20030719	Allan Yuen			Modify For Merge Porject 
				(Disable company code)
20040904	Allan Yuen			Fix BOM Price decimal point error
20060621	Marco Chan	Add BOM Item Fty Cost
20100825	Marco Chan	New BOM Calculation
20121213	David Yue	Add Period Field when Inserting new BOMASS
*/

/************************************************************************
Author:		Kenny Chan
Date:		28th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_insert_IMBOMASS] 

@iba_cocde  	nvarchar(6) = '  ',
@iba_itmno  	nvarchar(20),
@iba_assitm	nvarchar(20),
--@iba_pckseq  	int,
@iba_typ  	nvarchar(4),
@iba_colcde  	nvarchar(30),
@iba_pckunt  	nvarchar(6),	--modify by Lewis on 20030616
@iba_bomqty  	int,
@iba_inrqty  	int,
@iba_mtrqty  	int,
@iba_altitmno	varchar(20),
@iba_untcst	numeric(13,4),
@iba_costing	char(1),
@iba_genpo	char(1),
@iba_curcde	varchar(4),
@iba_ftyfmlopt	varchar(5),
@iba_fmlopt	varchar(5),
@iba_bombasprc	numeric(13,4),
@iba_fcurcde	varchar(4),
@iba_ftycst	numeric(13,4),
@iba_period	varchar(10),
@iba_updusr  	nvarchar(30)

AS

declare @period datetime
set @period = @iba_period

INSERT INTO IMBOMASS
(
iba_cocde,
iba_itmno,
iba_assitm,
--iba_pckseq,
iba_typ,
iba_colcde,
iba_pckunt,
iba_bomqty,
iba_inrqty,
iba_mtrqty,
iba_altitmno,
iba_untcst,
iba_costing,
iba_genpo,
iba_curcde,
iba_ftyfmlopt,
iba_fmlopt,
iba_bombasprc,
iba_fcurcde,
iba_ftycst,
iba_period,
iba_creusr,
iba_updusr,
iba_credat,
iba_upddat)

VALUES

(
--@iba_cocde,
' ',
@iba_itmno,
@iba_assitm,
--@iba_pckseq,
@iba_typ,
@iba_colcde,
@iba_pckunt,
@iba_bomqty,
@iba_inrqty,
@iba_mtrqty,
@iba_altitmno,
@iba_untcst,
@iba_costing,
@iba_genpo,
@iba_curcde,
@iba_ftyfmlopt,
@iba_fmlopt,
@iba_bombasprc,
@iba_fcurcde,
@iba_ftycst,
@period,
@iba_updusr,
@iba_updusr,
GETDATE(),
GETDATE())
















GO
GRANT EXECUTE ON [dbo].[sp_insert_IMBOMASS] TO [ERPUSER] AS [dbo]
GO
