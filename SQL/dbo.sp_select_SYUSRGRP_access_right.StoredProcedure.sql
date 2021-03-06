/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP_access_right]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRGRP_access_right]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP_access_right]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*	Author : Tommy Ho	*/
/***********************************************************************************************************************************************************************
Modification History
************************************************************************************************************************************************************************
Modified by		Modified on		Description
************************************************************************************************************************************************************************
Lester Wu		2005-04-13		add company group selection, cater user group without user function problem of MS company
************************************************************************************************************************************************************************
*/

--sp_select_SYUSRGRP_access_right 'UC-G','MIS-S','SYS00001','MSG'
--sp_select_SYUSRGRP_access_right 'UC-G','MIS-S','SYS00001','UCG'
--sp_select_SYUSRGRP_access_right 'UC-G','MIS-S','XXXXXXXXXX','UCG'
--sp_select_SYUSRGRP_access_right 'UC-G','MIS-S','XXXXXXXXXX','MSG'
--sp_select_SYUSRGRP_access_right 'UC-G','XJ01','XXXXXXXXXX','XXXXXX'


CREATE PROCEDURE [dbo].[sp_select_SYUSRGRP_access_right] 

@cocde nvarchar(6),
@usrgrp nvarchar(6),
@usrfun nvarchar(10),
@cogrp nvarchar(6)
AS

declare @del nvarchar(3)

set @del = ''

select  @del as 'Del',
yug_usrfun, 	yug_fundsc,  
(case yug_assrig when 'MWD' then 'MWD - Maintenace with Delete' 
	 	   when 'MOD' then 'MOD - Maintenance without Delete'
  		   else 'ENQ - Enquiry Only' end) as 'yug_assrig', 
yug_usrgrp, 	yug_credat,	yug_upddat,
yug_creusr,	yug_updusr, 	cast(yug_timstp as int) as 'yug_timstp',
yug_funseq,  	yug_grpdsc,
yug_cogrp
from  syusrgrp 


where yug_usrgrp = @usrgrp 
--and yug_cocde = @cocde
and yug_usrfun between 
	(case @usrfun when 'XXXXXXXXXX' then '0'
	 else @usrfun end)
	and
	(case @usrfun when 'XXXXXXXXXX' then 'ZZZZZZZZZZ'
	 else @usrfun end)
--and yug_cogrp = @cogrp
and yug_cogrp between 
	(case @cogrp when 'XXXXXX' then '0'
	 else @cogrp end)
	and
	(case @cogrp when 'XXXXXX' then 'ZZZZZZZZZZ'
	 else @cogrp end)
order by yug_cogrp,yug_usrfun

/*
select distinct yug_cogrp,yug_usrgrp,max(yug_grpdsc) as 'yug_grpdsc'
into #tmp_grp
from syusrgrp(nolock)
where yug_usrgrp = @usrgrp 
group by yug_cogrp,yug_usrgrp

select yug_usrgrp, yug_usrfun, yug_funseq, yug_fundsc,  yug_assrig, yug_creusr, yug_updusr, yug_credat, yug_upddat, yug_timstp
into #tmp_fun
from syusrgrp (nolock)
where 
	yug_usrgrp = @usrgrp and 
	yug_usrfun between 
		(case @usrfun when 'XXXXXXXXXX' then '0'
		 else @usrfun end)
		and
		(case @usrfun when 'XXXXXXXXXX' then 'ZZZZZZZZZZ'
		 else @usrfun end) 
	and yug_cogrp between 
		(case  @cogrp when 'XXXXXX' then '0'
		else @cogrp end)
		and
		(case  @cogrp when 'XXXXXX' then 'ZZZZZZ'
		else @cogrp end)



--select * from #tmp_grp
--select * from #tmp_fun

select @del as 'Del',
isnull(fun.yug_usrfun,'') as 'yug_usrfun',
isnull(fun.yug_fundsc,'') as 'yug_fundsc',  
(case isnull(fun.yug_assrig,'')
	when 'MWD' then 'MWD - Maintenace with Delete' 
	when 'MOD' then 'MOD - Maintenance without Delete'
	when 'ENQ' then  'ENQ - Enquiry Only' 
	else '' end) as 'yug_assrig', 
isnull(gp.yug_usrgrp,'') as 'yug_usrgrp',
isnull(fun.yug_credat,'01/01/1900') as 'yug_credat',	
isnull(fun.yug_upddat,'01/01/1900') as'yug_upddat',
isnull(fun.yug_creusr,'~*ADD*~') as 'yug_creusr',
isnull(fun.yug_updusr,'') as 'yug_updusr',
cast(isnull(fun.yug_timstp,0) as int) as 'yug_timstp',
isnull(fun.yug_funseq,0) as 'yug_funseq',
isnull(gp.yug_grpdsc,'') as 'yug_grpdsc',
gp.yug_cogrp as 'yug_cogrp'
--------------------------------
from 
#tmp_grp gp
left join #tmp_fun fun (nolock) on gp.yug_usrgrp = fun.yug_usrgrp and gp.yug_cogrp = fun.yug_cogrp
order by fun.yug_usrfun


drop table #tmp_grp
drop table #tmp_fun
*/



GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRGRP_access_right] TO [ERPUSER] AS [dbo]
GO
