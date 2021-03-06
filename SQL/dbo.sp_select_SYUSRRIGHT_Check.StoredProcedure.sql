/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT_Check]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRRIGHT_Check]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRRIGHT_Check]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Joe Yim
Date:		22nd April, 2010
Description:	Check against SYUSRRIGHT

************************************************************************/
CREATE            procedure [dbo].[sp_select_SYUSRRIGHT_Check]
                                                                                                                                                                                                                                                                 
@cocde		nvarchar(6),
@usrid		nvarchar(30),
@docno		nvarchar(20),
@doctyp		nvarchar(2)

AS

if @doctyp = 'QU'
begin
	Select	quh_qutno,		quh_cus1no
	from	QUOTNHDR
	left join	CUBASINF on	cbi_cusno = quh_cus1no
	--left join SYSALREP on ysr_cocde = ' ' and ysr_code1 = cbi_salrep
	where	quh_cocde = @cocde		and
		(@docno = ''	or
		  quh_qutno = @docno)	and
		(	exists
			(	
				select 1 from syusrright
				where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			or cbi_saltem in 
			(	
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)		
			)
			or cbi_cusno in 
			(
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
		)
	end


if @doctyp = 'CL'
begin
	Select	cah_caordno,		cah_cus1no
	from	CAORDHDR
	left join	CUBASINF on	cbi_cusno = cah_cus1no
	--left join SYSALREP on ysr_cocde = ' ' and ysr_code1 = cbi_salrep
	where	cah_cocde = @cocde		and
		(@docno = ''	or
		  cah_caordno = @docno)	and
		(	cah_cus1no = '' or 
			exists
			(	
				select 1 from syusrright
				where yur_usrid = @usrid  and yur_doctyp = 'QU' and yur_lvl = 0
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			or cbi_saltem in 
			(	
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = 'QU' and yur_lvl = 1
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)		
			)
			or cbi_cusno in 
			(
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = 'QU' and yur_lvl = 2
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
		)
	end

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
		soh_cocde = @cocde and (@docno = '' or  soh_ordno = @docno)
		and
		(	exists
			(	
				select 1 from syusrright
				where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			or cbi_saltem in 
			(	
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			or cbi_cusno in 
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
		poh_cocde = @cocde and (@docno = '' or  poh_purord = @docno)
		and
		(	exists
			(	
				select 1 from syusrright
				where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			or cbi_saltem in 
			(	
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
			or cbi_cusno in 
			(
				select yur_para from syusrright
				where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
--				and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
			)
		)
	end

if @doctyp = 'CU'
	begin

declare @saltem nvarchar(20)
select @saltem = cbi_saltem from CUBASINF 
--left join SYSALREP on ysr_cocde = ' ' and ysr_code1 = cbi_salrep 
where cbi_cusno = @docno


Select cbi_cusno, cbi_cussna
from CUBASINF 
--left join SYSALREP on ysr_cocde = ' ' and ysr_code1 = cbi_salrep
where
exists
(	
	select 1 from syusrright
	where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
--	and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
)
or (cbi_saltem = @saltem and cbi_saltem in 
(	
	select yur_para from syusrright
	where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
--	and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
))
or (cbi_cusno = @docno and cbi_cusno in 
(
	select yur_para from syusrright
	where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
--	and yur_cogrp in (select yco_cogrp from sycominf where yco_cocde = @cocde)
))

end

GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRRIGHT_Check] TO [ERPUSER] AS [dbo]
GO
