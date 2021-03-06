/****** Object:  StoredProcedure [dbo].[sp_select_BJ_rpt]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BJ_rpt]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BJ_rpt]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[sp_select_BJ_rpt]

as

set nocount on 

Begin

 

create table #temp_jb_sts

(

tmp_jobid nvarchar(20),

tmp_ttl_cnt int,

tmp_ttl_success int,

tmp_jb_sts nvarchar(20) 

)

 

 

 

 

insert into #temp_jb_sts

select bms_jobid,count(*),sum(

case bms_status01 when 'SUCCESS' then 1 else 0 end 

+

case bms_status02 when 'SUCCESS' then 1 else 0 end 

+

case bms_status03 when 'SUCCESS' then 1 else 0 end 

+

case bms_status04 when 'SUCCESS' then 1 else 0 end 

+

case bms_status05 when 'SUCCESS' then 1 else 0 end 

+

case bms_status06 when 'SUCCESS' then 1 else 0 end 

+

case bms_status07 when 'SUCCESS' then 1 else 0 end 

+

case bms_status08 when 'SUCCESS' then 1 else 0 end 

+

case bms_status09 when 'SUCCESS' then 1 else 0 end 

+

case bms_status10 when 'SUCCESS' then 1 else 0 end 

),''

from BJMONSUM 

left join BJMONSET  on bms_pgid = bst_pgid 

where bms_credat >Cast(Replace(cast(DateAdd(Day, Datediff(Day,0, GetDate() -1), 0) as nvarchar(30)),'12:00AM','14:59') as datetime)

and bst_pgstepid ='01' and bms_lastflag <> 'N'

group by bms_jobid

 

 

update #temp_jb_sts 

set tmp_jb_sts = 'SUCCESS' 

where tmp_ttl_cnt = tmp_ttl_success

 

--select * from        #temp_jb_sts

 

------------------------------------------------------------------------

 

create table #temp_maxdate

(

tmp_pgid nvarchar(20),

tmp_credat datetime

)

 

insert into #temp_maxdate 

select  bms_pgid,

max(bms_credat   )

from BJMONSUM 

left join BJMONSET  on bms_pgid = bst_pgid 

left join #temp_jb_sts on tmp_jobid = bms_jobid

where bms_credat >Cast(Replace(cast(DateAdd(Day, Datediff(Day,0, GetDate() -1), 0) as nvarchar(30)),'12:00AM','14:59') as datetime)

and bst_pgstepid ='01' and bms_lastflag <> 'N'

group by bms_pgid 

        

 

 

--(select max(bms_credat) 

--from BJMONSUM 

--left join BJMONSET  on bms_pgid = bst_pgid 

--left join #temp_jb_sts on tmp_jobid = bms_jobid

--)

-------------------------------------------------------------------------

 

select distinct bms_jobid,bms_jobname,tmp_jb_sts as 'tmp_bj_sts' , 

bms_pgid,bst_pgname,bms_totalpg, 

bms_jobstartdate,bms_jobenddate, 

UPPER(bms_status01) as 'bms_status01',

UPPER(bms_status02) as 'bms_status02',

UPPER(bms_status03) as 'bms_status03',

UPPER(bms_status04) as 'bms_status04',

UPPER(bms_status05) as 'bms_status05',

bms_credat   

from BJMONSUM 

left join BJMONSET  on bms_pgid = bst_pgid 

left join #temp_jb_sts on tmp_jobid = bms_jobid

left join #temp_maxdate  on tmp_pgid = bms_pgid

 

where bms_credat >Cast(Replace(cast(DateAdd(Day, Datediff(Day,0, GetDate() -1), 0) as nvarchar(30)),'12:00AM','14:59') as datetime)

and bst_pgstepid ='01' and bms_lastflag <> 'N'

and  bms_credat = tmp_credat

 

order by bms_jobid,bms_credat  

        

 

 

drop table #temp_jb_sts

drop table #temp_maxdate

 

 

END        

        

 

 


GO
GRANT EXECUTE ON [dbo].[sp_select_BJ_rpt] TO [ERPUSER] AS [dbo]
GO
