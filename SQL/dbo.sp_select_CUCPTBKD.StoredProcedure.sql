/****** Object:  StoredProcedure [dbo].[sp_select_CUCPTBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=================================================================
Program ID	: sp_select_CUCPTBKD
Description	: Retrieve Customer Material Breakdown
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-01-02 	David Yue		SP Created
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_select_CUCPTBKD] 

@cocde  nvarchar(6),
@cus1no	nvarchar(6),
@cus2no	nvarchar(6),
@itmno	nvarchar(30),
@colcde nvarchar(30),
@creusr	nvarchar(30)

AS

declare
@ccb_cus1no nvarchar(100),
@ccb_cus2no nvarchar(100),
@ccb_itmno nvarchar(100),
@ccb_colcde nvarchar(100),
@condition nvarchar(400)

if @cus1no <> ''
	set @ccb_cus1no = 'ccb_cus1no = ''' + @cus1no + ''''
else
	set @ccb_cus1no = ''

if @cus2no <> ''
	set @ccb_cus2no = 'ccb_cus2no = ''' + @cus2no + ''''
else
	set @ccb_cus2no = ''

if @itmno <> ''
	set @ccb_itmno = 'ccb_itmno = ''' + @itmno + ''''
else
	set @ccb_itmno = ''

if @colcde <> ''
	set @ccb_colcde = 'ccb_colcde = ''' + @colcde + ''''
else
	set @ccb_colcde = ''

set @condition = ''
if @ccb_cus1no <> ''
	set @condition = @condition + case @condition when '' then ' where ' else ' and ' end + @ccb_cus1no
if @ccb_cus2no <> ''
	set @condition = @condition + case @condition when '' then ' where ' else ' and ' end + @ccb_cus2no
if @ccb_itmno <> ''
	set @condition = @condition + case @condition when '' then ' where ' else ' and ' end + @ccb_itmno
if @ccb_colcde <> ''
	set @condition = @condition + case @condition when '' then ' where ' else ' and ' end + @ccb_colcde
exec('select ccb_cus1no, ccb_cus2no, ccb_itmno, ccb_colcde, ccb_cpt, ccb_curcde, ccb_cst, ccb_cstpct, ccb_pct, ccb_creusr from CUCPTBKD (nolock)' + @condition)



GO
GRANT EXECUTE ON [dbo].[sp_select_CUCPTBKD] TO [ERPUSER] AS [dbo]
GO
