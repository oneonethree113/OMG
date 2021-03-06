/****** Object:  StoredProcedure [dbo].[sp_select_PJDHONG_PDO_SAP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PJDHONG_PDO_SAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PJDHONG_PDO_SAP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_PJDHONG_PDO_SAP]       
@cocde   nvarchar(6),      
@txtDateFm datetime,    
@txtDateTo datetime,    
@chkGen int,    
@batno varchar(30),    
@opt char(1)    
AS      
    
--select @txtDateFm , @txtDateTo    

--set @opt = 'Z'   --for gen P-note manually

if @opt = 'Z'
begin

  SELECT       
  sod_zorvbeln,     
  sod_zorposnr,    
  pod_jobord,    
  pod_scno,      
  pod_scline,    
  pod_itmno,      
  max(pjs_batno + '-' + pjs_batseq) as pjs_batno,     
  'X' as GEN ,     
  '                    ' as pjd_zutyp    
 into    
  #tmp_batno3   
 FROM       
  POJBBSAP (nolock),       
  POORDDTL (nolock),       
  SCORDDTL (nolock),    
  POJBBDTL (nolock)    
 WHERE       
--  pjs_cocde = @cocde AND     
(pjs_cocde   =  'UCPP' ) and  --20150519
  pjs_jobord = pod_jobord AND      
  pod_scno = sod_ordno and pod_scline = sod_ordseq and     
--  pjs_credat between @txtDateFm and @txtDateTo and    
  pjs_batno = pjd_batno and pjs_batseq = pjd_batseq and     
  sod_zorvbeln <> '' and    ----------------temp
  sod_zorposnr <> '999999' /*and     
  (     
   ( @chkGen = 0 and pjs_gendoc = '' ) or    
   ( @chkGen = 1 and pjs_gendoc = 'Y' )    
  )    */
--and pod_credat > '2013-01-01'

-- Re-Generate PO List Here!!
and pjs_jobord in (
'US1600542-J003',
'US1600542-J004',
'US1600542-J005',
'US1600542-J006',
'US1600542-J007',
'US1600542-J008',
'US1600573-J001',
'US1600574-J001',
'US1600575-J001'
)
group by     
  sod_zorvbeln, sod_zorposnr,    
  pod_jobord,pod_scno,      
  pod_scline, pod_itmno    


select * from #tmp_batno3

drop table #tmp_batno3

end
else if @opt = 'B'     
begin    
    
  SELECT       
  sod_zorvbeln,     
  sod_zorposnr,   
  pod_jobord,    
  pod_scno,      
  pod_scline,    
  pod_itmno,      
  max(isnull(pjs_batno,'') + '-' + isnull(pjs_batseq,'')) as pjs_batno ,     
  'X' as GEN    
 FROM       
  POJBBSAP  (nolock),       
  POORDDTL  (nolock),       
  SCORDDTL (nolock)    
 WHERE       
  pjs_cocde = @cocde AND      
  pjs_jobord = pod_jobord AND      
  pod_scno = sod_ordno and pod_scline = sod_ordseq and     
  pjs_batno =@batno and     
  sod_zorvbeln <> '' and    
  sod_zorposnr <> '999999' and     
  (     
   ( @chkGen = 0 and pjs_gendoc = '' ) or    
   ( @chkGen = 1 and pjs_gendoc = 'Y' )    
  )    
 group by     
  sod_zorvbeln, sod_zorposnr,    
  pod_jobord,pod_scno,      
  pod_scline, pod_itmno    
    
 order by pod_jobord    
    
end    
else    
begin    
    
     /*************************************************************************************/
/*           select distinct pjs_jobord as 'n_jobord' from POJBBSAP
                into #RESULT
                left join POORDDTL on pjs_jobord = pod_jobord
                left join SCORDDTL on pod_scno = sod_ordno and pod_scline = sod_ordseq
                where 
                sod_ordno is not null
                and sod_ordqty - sod_shpqty > 0
                and sod_venno in ('A','B','U','W')
                and sod_zorvbeln <> ''
*/

                select pjs_jobord, max(pjs_credat) as pjs_gendat 
                into #NotGen
                from POJBBSAP(nolock) 
                left join POORDDTL (nolock) on pjs_jobord = pod_jobord
                left join SCORDDTL (nolock) on pod_scno = sod_ordno and pod_scline = sod_ordseq
				left join SCORDHDR (nolock) on soh_ordno = sod_ordno
                where pjs_gendoc = ''
                and sod_ordno is not null
                and( sod_ordqty - sod_shpqty > 0 or (soh_ordsts = 'CLO' and sod_ordqty = sod_shpqty and  soh_upddat >=  CONVERT(VARCHAR(10),   getdate() -1, 112)))

                group by pjs_jobord
                
                select pjs_jobord, max(pjs_gendat) as pjs_gendat
                into #Gen
                from POJBBSAP (nolock) 
                where pjs_gendoc = 'Y' 
                group by pjs_jobord
                
                select 'NEW' as 'ID',n.pjs_jobord as 'n_jobord' , n.pjs_gendat as 'n_gendat',  y.pjs_jobord as 'y_jobord' , y.pjs_gendat as 'y_gendat'
                into #RESULT
                from #NotGen as n
                left join #Gen as y on n.pjs_jobord = y.pjs_jobord
                where y.pjs_jobord is null
                union 
                select 'REG' as 'ID',n.pjs_jobord as 'n_jobord' , n.pjs_gendat as 'n_gendat',  y.pjs_jobord as 'y_jobord' , y.pjs_gendat as 'y_gendat'
                from #NotGen as n
                left join #Gen as y on n.pjs_jobord = y.pjs_jobord
                where y.pjs_jobord is not null
                and n.pjs_gendat >= y.pjs_gendat
/*           
                select * from #RESULT
                
                select n_jobord,count(1) from #RESULT
                group by n_jobord
                having count(1) > 1
*/           

    /*************************************************************************************/

    
  SELECT       
  sod_zorvbeln,     
  sod_zorposnr,    
  pod_jobord,    
  pod_scno,      
  pod_scline,    
  pod_itmno,      
  max(pjs_batno + '-' + pjs_batseq) as pjs_batno,     
  'X' as GEN ,     
  '                    ' as pjd_zutyp    
 into    
  #tmp_batno    
 FROM       
  POJBBSAP (nolock),       
  POORDDTL (nolock),       
  SCORDDTL (nolock),    
  POJBBDTL (nolock)    
 WHERE       
  pjs_cocde = @cocde AND      
  pjs_jobord = pod_jobord AND      
  pod_scno = sod_ordno and pod_scline = sod_ordseq and     
--  pjs_credat between @txtDateFm and @txtDateTo and    
  pjs_batno = pjd_batno and pjs_batseq = pjd_batseq and     
  sod_zorvbeln <> '' and    
  sod_zorposnr <> '999999' and     
  (     
   ( @chkGen = 0 and pjs_gendoc = '' ) or    
   ( @chkGen = 1 and pjs_gendoc = 'Y' )    
  )    
and pod_credat > '2013-01-01'

-- Lester Wu 2007-11-29
and pjs_jobord in (
                select n_jobord from #RESULT
)
group by     
  sod_zorvbeln, sod_zorposnr,    
  pod_jobord,pod_scno,      
  pod_scline, pod_itmno    
    
-- select * from #tmp_batno     
    
 update t     
 set t.pjd_zutyp = b.pjd_zutyp    
 from #tmp_batno t , POJBBDTL b    
 where t.pjs_batno = b.pjd_batno + '-' + b.pjd_batseq    
    
 update #tmp_batno set pjd_zutyp = ltrim(pjd_zutyp)    
    
-- select * from #tmp_batno    

/*    
 update t    
 set t.pjd_zutyp = 'A' + t.pjd_zutyp    
 from #tmp_batno t, FYJOBATH f    
 where t.pod_jobord = f.fsa_jobno    
 and f.fsa_upddat between @txtDateFm and @txtDateTo     
 and f.fsa_act <> ''    
*/
   
-- Modified by Frankie Cheung 2010-05-19 
 update t    
 set t.pjd_zutyp = 'A' + t.pjd_zutyp    
 from #tmp_batno t, SCTPSMRK f    
 where t.pod_jobord = f.stm_jobno    
 and f.stm_upddat between @txtDateFm and @txtDateTo     
-- and f.stm_upddat between '2013-10-01' and @txtDateTo     
 and f.stm_act <> ''   


--select * from #tmp_batno    
    
 SELECT       
  sod_zorvbeln,     
  sod_zorposnr,    
  pod_jobord,    
  pod_scno,      
  pod_scline,    
  pod_itmno,      
  max(pjs_batno + '-' + pjs_batseq) as pjs_batno,     
  'X' as GEN,    
  'A' as pjd_zutyp    
 into     
  #tmp_batno2    
 FROM       
--FYJOBATH,     
--Frankie Cheung 2010-05-19 
  SCTPSMRK (nolock),
  POJBBSAP (nolock),       
  POORDDTL (nolock),       
  SCORDDTL (nolock),    
  POJBBDTL (nolock)     
 WHERE       
  stm_jobno = pjs_jobord and    
  pjs_cocde = @cocde AND      
  pjs_jobord = pod_jobord AND      
  pod_scno = sod_ordno and pod_scline = sod_ordseq and     
  --pjs_credat between @txtDateFm and @txtDateTo and    
  --fsa_upddat between @txtDateFm and @txtDateTo and  

  stm_upddat between @txtDateFm and @txtDateTo and    -- Frankie Cheung 2010-05-19  

--  stm_upddat between '2013-10-01' and @txtDateTo and    -- Frankie Cheung 2010-05-19  

  -- fsa_credat > '2007-07-16' and --Lester Wu 2007-07-17    
  stm_credat > '2007-07-16' and -- Frankie Cheung 2010-05-19
  pjs_batno = pjd_batno and pjs_batseq = pjd_batseq and     
  sod_zorvbeln <> '' and    
  sod_zorposnr <> '999999' and     
  -- fsa_jobno not in (select pod_jobord from #tmp_batno)    
  stm_jobno not in (select pod_jobord from #tmp_batno)   -- Frankie Cheung 2010-05-19 
 group by     
  sod_zorvbeln, sod_zorposnr,    
  pod_jobord,pod_scno,      
  pod_scline, pod_itmno    


                drop table #NotGen
                drop table #Gen
                drop table #RESULT


select top 500 a.*
from (
select * from #tmp_batno    
 union     
 select * from #tmp_batno2    
) a 
--left join  SCTPSMRK b (nolock) on a.pod_jobord = b.stm_jobno
left join SCORDHDR c (nolock) on c.soh_ordno = a.pod_scno
where 
--c.soh_cus1no not in ('50100')
--((c.soh_cus1no not in ('50100')) or (c.soh_cus1no in ('50100') and pod_itmno not like '%AS%'))
--b.stm_cocde is null and
--a.pod_jobord > 'SC1300000' and
a.pod_jobord not in (
'US1300156-J001',
'US1300156-J002',
'US1300156-J003',
'US1300228-J020',

'SC1301529-J007',
'SC1301529-J008',

--2013-10-24
'US1300435-J001',
'US1300435-J002',
'US1300435-J003',
'US1300435-J004',
'US1300435-J005',
'US1300435-J006',
'US1300435-J007',
'US1300435-J008',
'US1300435-J009',
'US1300435-J010',
'US1300435-J011',
'US1300435-J012',
'US1300435-J014',



'SC1303064-J001',
'SC1303089-J001',
'SC1303090-J001',


--2013-11-18
'SC1303435-J001',
'SC1303435-J004',
'SC1303435-J005',
'SC1303435-J006',
'SC1303435-J007',
'SC1303435-J002',
'SC1303435-J003',


--2014-01-02
'SC1303741-J002',

--2014-03-25
'US1400157-J001',
'US1400157-J002',
'US1400157-J003',
'US1400157-J004',
'US1400157-J005',
'US1400157-J006',

--2014-06-13
'US1400471-J012',
'US1400473-J013',

--2014-0617
'GS1400187-J001',
'GS1400187-J002',

--2014-0618
'GS1400187-J003',            

--2014-0618---no2
'GS1400187-J004',
'GS1400187-J005',
'GS1400187-J006',
'GS1400187-J007',
'GS1400187-J008',
'GS1400187-J009' ,
'GS1400187-J010' ,
                
--2014-0903
--'SC1403117-J012'
--'SC1403117-J013'
--'SC1403117-J014',
--'SC1403117-J015',
--'SC1403117-J016',
--'SC1403117-J017',
--'SC1403117-J018',
--'SC1403117-J019'

--2014-09-18
--'SC1403117-J013'

--2014-09-25
'SC1403117-J013'

)
-- added by Mark Lau 20090117
-- For Michael's Assortment

and pod_jobord not in 
(
select pod_jobord from poorddtl  (nolock)
inner join scorddtl  (nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
inner join scordhdr  (nolock) on sod_ordno = soh_ordno

where  --pod_jobord = 'SC0802150-J003' 
soh_cus1no = '50100' and sod_zorvbeln <> '' and sod_itmno like '%AS%'
and  ( sod_zorvbeln like 'WT%' or  sod_zorvbeln like '101101%'  or  sod_zorvbeln like '102101%'  or  sod_zorvbeln like '103101%')

)

order by pod_jobord    
    
 drop table #tmp_batno    
 drop table #tmp_batno2    
    
end

GO
GRANT EXECUTE ON [dbo].[sp_select_PJDHONG_PDO_SAP] TO [ERPUSER] AS [dbo]
GO
