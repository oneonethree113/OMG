/****** Object:  StoredProcedure [dbo].[sp_list_HLTDTL_form]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_HLTDTL_form]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_HLTDTL_form]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_list_HLTDTL_form]

@cocde		nvarchar(6),
@qutno		nvarchar(20)

As

declare
@sendate	nvarchar(5),
@senday	nvarchar(2),
@sendmnt	nvarchar(2),
@selrat		numeric(16,11)

create table #TMP_HLTDTL
(
tmp_seq	int IDENTITY(1,1) PRIMARY KEY CLUSTERED,
tmp_qutseq	int,
tmp_program	nvarchar(100),
tmp_bp		nvarchar(100),
tmp_bpstyno	nvarchar(100),
tmp_contact	nvarchar(100),
tmp_desc	nvarchar(100),
tmp_ftycst	numeric(13,2),
tmp_elc		numeric(13,2),
tmp_retail	numeric(13,2)
)


/* Get Sell Rate */
select @selrat = ysi_selrat from sysetinf  where ysi_typ = '06' and ysi_cde = 'HKD'


INSERT INTO #TMP_HLTDTL (tmp_qutseq, tmp_program, tmp_bp, tmp_bpstyno, tmp_contact, tmp_desc, tmp_ftycst, tmp_elc, tmp_retail)
select 
	qud_qutseq, 
	quh_Year + ' ' + quh_Season + ' '+ quh_Desc as 'quh_program',
	'Pacific Global' as 'bp', 
	qud_cusstyno, 
	'Daisy / Mary' as 'contact', 
	qud_itmdsc, 	
	case ltrim(rtrim(qud_fcurcde)) when 'HKD' then isnull(qud_ftycst,0)*@selrat else isnull(qud_ftycst,0) end as 'ftycst', 
	isnull(qec001.qec_amt,0), 
	isnull(qud_cususd,0)
from QUOTNDTL (nolock)
left join QUOTNHDR (nolock) on quh_cocde = qud_cocde and quh_qutno = qud_qutno
left join SYCOMINF (nolock) on yco_cocde = qud_cocde
left join VNBASINF (nolock) on vbi_venno = qud_venno
left join SYSETINF sys03 (nolock) on sys03.ysi_cde = qud_prctrm and ysi_typ = '03'
left join QUELCDTL qed02 (nolock) on qed02.qed_qutno = qud_qutno and qed02.qed_qutseq = qud_qutseq and qed02.qed_grpcde = '001' and qed02.qed_cecde = '02'
left join QUELCDTL qed09 (nolock) on qed09.qed_qutno = qud_qutno and qed09.qed_qutseq = qud_qutseq and qed09.qed_grpcde = '001' and qed09.qed_cecde = '09'
left join QUELCDTL qed10 (nolock) on qed10.qed_qutno = qud_qutno and qed10.qed_qutseq = qud_qutseq and qed10.qed_grpcde = '001' and qed10.qed_cecde = '10'
left join QUELC qec001 (nolock) on qec001.qec_qutno = qud_qutno and qec001.qec_qutseq = qud_qutseq and qec001.qec_grpcde = '001'
left join QUELC qec002 (nolock) on qec002.qec_qutno = qud_qutno and qec002.qec_qutseq = qud_qutseq and qec002.qec_grpcde = '002'
left join QUELC qec003 (nolock) on qec003.qec_qutno = qud_qutno and qec003.qec_qutseq = qud_qutseq and qec003.qec_grpcde = '003'
where 
	qud_cocde = @cocde and qud_qutno = @qutno
order by 	
	qud_qutseq

/* Get Send Date */
set @sendmnt = month(getdate())
set @senday = day(getdate())

set @sendate = @sendmnt + "/" + @senday





select 
	a.tmp_seq 'tmp_seq1',
	a.tmp_qutseq 'tmp_qutseq1',
	@sendate 'tmp_datesent1',
	a.tmp_program 'tmp_program1',
	a.tmp_bp 'tmp_bp1', 
	a.tmp_bpstyno 'tmp_bpstyno1',
	a.tmp_contact 'tmp_contact1',
	a.tmp_desc 'tmp_desc1',
	a.tmp_ftycst 'tmp_ftycst1',
	a.tmp_elc 'tmp_elc1',
	a.tmp_retail 'tmp_retail1',
	b.tmp_seq 'tmp_seq2',
	b.tmp_qutseq 'tmp_qutseq2',
	b.tmp_program 'tmp_program2',
	@sendate 'tmp_datesent2',
	b.tmp_bp 'tmp_bp2', 
	b.tmp_bpstyno 'tmp_bpstyno2',
	b.tmp_contact 'tmp_contact2',
	b.tmp_desc 'tmp_desc2',
	b.tmp_ftycst 'tmp_ftycst2',
	b.tmp_elc 'tmp_elc2',
	b.tmp_retail 'tmp_retail2'
from #TMP_HLTDTL a
left join #TMP_HLTDTL b on a.tmp_seq = b.tmp_seq - 1
where a.tmp_seq % 2 = 1

drop TABLE #TMP_HLTDTL






GO
GRANT EXECUTE ON [dbo].[sp_list_HLTDTL_form] TO [ERPUSER] AS [dbo]
GO
