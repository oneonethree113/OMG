/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_upditm]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_QUOTNDTL_upditm]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_QUOTNDTL_upditm]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  procedure [dbo].[sp_list_QUOTNDTL_upditm] 

@cocde	varchar(6),
@qutno	varchar(30),
@opt	char(3)
as

declare @key_cus1no as nvarchar(6)
declare @key_cus2no as nvarchar(6)

select @key_cus1no = isnull(quh_cus1no,''), @key_cus2no = isnull(quh_cus2no,'') from QUOTNHDR (nolock) where quh_cocde = @cocde and quh_qutno = @qutno

if @opt = 'DTL'
begin
	
	create table #tmp_DTL(
		UPD		char(1) , 
		NO		int , 
		qud_qutno		varchar(30) , 
		qud_qutseq		int,
		qud_itmno		varchar(30),
		qud_colcde		varchar(30),
		qud_untcde		varchar(300) , 
		qud_conftr	int,
		qud_ftytmpitm	nvarchar(1),
		qud_curcde		nvarchar(6),
		qud_basprc		numeric(13,4),
		vw_itmno		varchar(30) , 
		vw_colcde		varchar(30) , 
		vw_pckunt		varchar(100) , 
		vw_conftr	int,
		vw_ftytmpitm	nvarchar(1),
		vw_basprc		numeric(13,4),
		qce_spcurcde		nvarchar(6),		
		qce_amt		numeric(13,4),
		vw_engdsc		varchar(50) , 
		vw_alsitmno	varchar(30) , 
		vw_alscolcde	varchar(30) ,
		vw_remark	nvarchar(255)
	)
	
	insert into 	
		#tmp_DTL
	select   distinct                    ---20140116 for multi-color
		'N' as 'UPD' ,
		qud_qutseq as 'NO',
		qud_qutno ,
		qud_qutseq,
		qud_itmno,
		qud_colcde,
		qud_untcde + '/' + ltrim(rtrim( str(qud_inrqty))) + '/' + rtrim(ltrim( str(qud_mtrqty)))+ '/' + rtrim(ltrim(  (qud_prctrm)))+ '/' + rtrim(ltrim( (qud_ftyprctrm)))+ '/' + rtrim(ltrim(  (qud_trantrm)))   as 'qud_untcde', 
		qud_conftr,
		qud_ftytmpitm,
		qud_curcde,
		qud_basprc,
		'' as 'vw_itmno',
		'' as 'vw_colcde',
		'' as 'vw_pckunt',
		0 as 'vw_conftr',
		'' as 'vw_ftytmpitm',
		0 as 'vw_basprc',
		'' as qpe_curcde,
		0  as 'qce_amt',
		'' as 'vw_engdsc',
		'' as 'vw_alsitmno',
		'' as 'vw_alscolcde',
		'' as 'vw_remark'

	from
		QUOTNDTL qud (nolock)
		inner join IMPRCINF imu (nolock) 
			on 
			( 
			
			qud_itmno = imu_itmno
    		and ltrim(rtrim(qud_venno))  =ltrim(rtrim(imu_prdven)) --20161012
			and qud_untcde  = imu_pckunt
			and qud_inrqty =  imu_inrqty
			and qud_mtrqty =  imu_mtrqty
			and qud_prctrm = imu_hkprctrm
			and qud_ftyprctrm =imu_ftyprctrm
			and qud_trantrm  =imu_trantrm
			and
			 (

			 qud_basprc <> imu_basprc
				OR (datediff(day,qud.qud_effdat,imu.imu_effdat   ) > 1
			or datediff(day,qud.qud_effdat,imu.imu_effdat   ) < -1
			or datediff(day,qud.qud_expdat,imu.imu_expdat   ) > 1	
			or datediff(day,qud.qud_expdat,imu.imu_expdat   ) < -1	
				)	
				OR ( qud_cft<> imu_cft)                                                            --20161012

			  )	
			)
		left join IMBASINF old (nolock) 
		on qud_itmno = old.ibi_itmno
	where 
		( isnull(old.ibi_itmsts,'') <> 'OLD' or  isnull(qud_ftytmpitm,'') = 'Y' ) and qud_tbm <> 'Y' and 
		qud_cocde = @cocde and
		qud_qutno = @qutno
--		and qud_apprve <> 'Y'


	select *	 from #tmp_DTL
	
	drop table #tmp_DTL 

end
else if @opt = 'LST'
begin

	select distinct 
		qud_itmno,
		qud_qutseq,
		new.ibi_itmno as 'vw_itmno',
		isnull(new.ibi_engdsc,'') as 'vw_engdsc',
		isnull(col.icf_colcde,'') as 'vw_colcde', 
		isnull(rtrim(ltrim(pck.ipi_pckunt)) + '/' +  rtrim(ltrim(str(pck.ipi_inrqty))) + '/' +  rtrim(ltrim(str(pck.ipi_mtrqty))) ,'') as 'vw_pckunt',
		--' ' as 'vw_pckunt',
		isnull(new.ibi_alsitmno,'') as 'ibi_alsitmno',
		isnull(new.ibi_alscolcde,'') as 'ibi_alscolcde',
		--Added by Mark Lau 20061109
		 'The matched item is in ' + case new.ibi_itmsts 	
						--when 'HLD' then 'Hold'
						when 'DIS' then  'Discontinued'
						--when 'INA' then 'Inactive'
						--when 'TBC' then 'To Be Confirmed '
						--when 'OLD' then 'Old Item'
				end + ' Status.' as 'Remarks'
	from 
		QUOTNDTL qud (nolock)
		left join IMBASINF old (nolock) on qud_itmno = old.ibi_itmno
		left join IMBASINF new (nolock) on qud_itmno = new.ibi_alsitmno 
		left join IMCOLINF col (nolock) on new.ibi_itmno = col.icf_itmno
		left join IMPCKINF pck (nolock) on new.ibi_itmno = pck.ipi_itmno
	where
		(isnull(old.ibi_itmsts,'') <> 'OLD'  or  isnull(qud_ftytmpitm,'') = 'Y' ) and qud_tbm <> 'Y' and 
		--qud_qutitmsts <> 'INCOMPLETE' and
		--qud_cocde = 'UCPP' and
		--qud_qutno = 'UQ0601914'
		qud_cocde = @cocde and
		qud_qutno = @qutno
	order by 
		qud_itmno, qud_qutseq, vw_itmno
end









GO
GRANT EXECUTE ON [dbo].[sp_list_QUOTNDTL_upditm] TO [ERPUSER] AS [dbo]
GO
