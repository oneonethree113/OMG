/****** Object:  StoredProcedure [dbo].[sp_select_bjs]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_bjs]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_bjs]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_select_bjs] 

AS

begin

declare @count_scnew int
declare @count_scftydat int

set @count_scnew  =
(select count(*) from
(
SELECT   distinct 
	pod_scno,  
	pod_jobord,  
	pod_credat,
	pod_runno,  
	pod_itmno,  
	vbi_vensna,  
	'Y' as 'pjd_confrm',  
	'' as 'pjd_batseq',  
	'new' as 'pjd_recsts',  
	vbi_venno as vencde  , 
	'' as 'ZUTYPE',
	soh_cus1no, cbi_cussna
FROM
	SCORDHDR
	left join SCORDDTL (nolock) on soh_cocde = sod_cocde and soh_ordno = sod_ordno
	left join POORDDTL (nolock) on sod_cocde = pod_cocde and sod_ordno = pod_scno and sod_ordseq = pod_scline
	left join IMPNTINF (nolock) on sod_itmno = ipt_itmno
	left join VNBASINF (nolock) on sod_venno = vbi_venno
	left join IMBASINF (nolock) on sod_itmno = ibi_itmno
	-- Added by Mark Lau 20091231,  Item No. of part of the items have to be changed
	left join TEMP_CONVERSION_TABLE(nolock) on sod_itmno = tmp_old_itmno
	left join CUBASINF on cbi_cusno = soh_cus1no
where 
	-- Added by Mark Lau 20091231,  Item No. of part of the items have to be changed
	isnull(tmp_old_itmno,'') = '' and

	--soh_cocde = @cocde 
	--and 
	(sod_ordqty - sod_shpqty > 0)
	and
	( soh_ordsts in ('REL', 'ACT', 'HLD')  or ( soh_ordsts = 'CLO' and sod_credat >= '2008-06-01'))
	and 
	(
	( soh_ordsts in ('REL', 'ACT', 'HLD') and sod_ordqty > sod_shpqty )
	
	or
	( soh_ordsts in ('CLO','REL') and sod_credat >= '2008-12-20' and sod_ordqty = sod_shpqty and sod_ordqty <> 0 )
	
	)

	
	
	and
	(
	(
	 ibi_venno in ('A','B','U','W','C','D','T','V','I','O','Y') and 
	( (pod_shpstr >= '2008-01-01' and pod_shpstr <= '2008-12-31') or (pod_shpend >= '2008-01-01' and pod_shpend <= '2008-12-31')  ) and
	sod_cusven in ('A','B','U','W')
	)
	or
	( ibi_venno in ('A','B','U','W','C','D','T','V','I','O','Y') and (pod_shpstr >= '2009-01-01' or pod_shpend >= '2009-01-01'))
	)
	
	and isnull(pod_jobord,'') <> ''
	and pod_jobord not in ('US0900853-J001', 'US1300582-J001')
	and sod_zorvbeln = ''
	and ipt_itmno is not null
	and pod_jobord is not null

	-- Added by Mark Lau 20080228	
	and charindex('-',sod_itmno)<= 0 
	and charindex('/',sod_itmno)<= 0 
	and len(sod_itmno) = 13
--order by 
--	pod_scno, pod_itmno


) ttt
)


set @count_scftydat = (select count (*) from 
(select * from scftydat  where sfd_credat > getdate() -1 ) tttt )



select  @count_scnew as 'scnew_today',
             @count_scftydat as 'scftydat_yesterday'


end





GO
GRANT EXECUTE ON [dbo].[sp_select_bjs] TO [ERPUSER] AS [dbo]
GO
