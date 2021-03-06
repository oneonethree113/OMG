/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT_Rel_Check]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRRIGHT_Rel_Check]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT_Rel_Check]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO














/************************************************************************
Author:		Joe Yim
Date:		14 May, 2010
Description:	Check against SYUSRRIGHT

************************************************************************/
CREATE            procedure [dbo].[sp_select_SYUSRRIGHT_Rel_Check]
                                                                                                                                                                                                                                                                 
@cocde		nvarchar(6),
@from		nvarchar(20),
@to		nvarchar(20),
@f		nvarchar(1),
@usrid		nvarchar(30),
@doctyp		nvarchar(2)

AS

if @doctyp = 'SC'
	begin
		Select soh_ordno, soh_cus1no
		from  SCORDHDR

		left join CUBASINF
		on cbi_cusno = soh_cus1no

		left join SYSALREP
		on ysr_cocde = ' ' 
		and ysr_code1 = cbi_salrep

		where
		soh_cocde = @cocde and
		soh_ordno >= @from and
		soh_ordno <= @to and
		len(rtrim(soh_ordno)) = len(rtrim(@from))
		and 
		(	not exists
			(	
				select 1 from syusrright
				where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			and cbi_saltem not in 
			(	
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			and cbi_cusno not in 
			(
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
		)
	end
if @doctyp = 'PO'
	begin
		Select poh_purord, poh_prmcus
		from  POORDHDR

		left join CUBASINF
		on cbi_cusno = poh_prmcus

		left join SYSALREP
		on ysr_cocde = ' ' 
		and ysr_code1 = cbi_salrep

		where
		poh_cocde = @cocde and
		poh_purord >= @from and
		poh_purord <= @to and
		len(rtrim(poh_purord)) = len(rtrim(@from))
		and
		(	not exists
			(	
				select 1 from syusrright
				where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			and cbi_saltem not in 
			(	
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			and cbi_cusno not in 
			(
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
		)
	end

GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRRIGHT_Rel_Check] TO [ERPUSER] AS [dbo]
GO
