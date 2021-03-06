/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRPARA]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRPARA]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRPARA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO








/************************************************************************
Author:		Joe Yim
Date:		19th April, 2010
Description:	Select data From SYUSRPRF

************************************************************************/
CREATE           procedure [dbo].[sp_select_SYUSRPARA]
                                                                                                                                                                                                                                                                 
@yul_cocde	nvarchar(6)  = ' ',
@yul_lvl		int                                               

 
AS

begin

	if @yul_lvl = 1
	begin
--		select distinct ysr_saltem as yul_para, 'Team ' + ysr_saltem as yul_pdesc
--		from SYSALREP
--		order by ysr_saltem
		select distinct ssi_saltem as yul_para, 'Team ' + ssi_saltem as yul_pdesc
		from SYSALINF where ssi_typ = 'TEAM' order by ssi_saltem
	end

	if @yul_lvl = 2
	begin
		select cbi_cusno as yul_para, cbi_cussna as yul_pdesc
		from CUBASINF where 
		cbi_cussts = 'A' and
		cbi_custyp = 'P' and
		cbi_cusno >= 50000
		order by cbi_cusno
	end
end










GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRPARA] TO [ERPUSER] AS [dbo]
GO
