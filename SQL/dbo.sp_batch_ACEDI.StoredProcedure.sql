/****** Object:  StoredProcedure [dbo].[sp_batch_ACEDI]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_batch_ACEDI]
GO
/****** Object:  StoredProcedure [dbo].[sp_batch_ACEDI]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











--*************************************************************
--*Description	: Account EDI batch
--*ALTER  Date	: 2014-10-27
--*ALTER  By	: Marco Chan
--*************************************************************
/*
=========================================================
 Modification History                                    
=========================================================
Date		Name		Description
11/19/2015	Marco Chan	Change 5th additional edi to 3rd every month
=========================================================     
*/
-- Feb 25 Cutoff
-- New System start with invoice ALTER  at 25 Feb
-- Old System run 26 Feb, 2 Mar, every Monday 


-- UCP start from I1500597
-- UCPP start from UI1500041
-- PG start from GI1500020

-- Fix for sod_ftyprc to sod_dvftyprc at 20170406


--drop procedure sp_batch_ACEDI
CREATE     procedure [dbo].[sp_batch_ACEDI]
@batch_cocde nvarchar(6)--, @batch_type nvarchar(10)
as
begin

-- Temporary fix for missing currency problem 

if (select count(*) from SHINVHDR (nolock) where hiv_untamt = '' and hiv_credat > '2015-01-01' ) >0
begin
	update SHINVHDR set hiv_untamt = cpi_curcde
	from SHINVHDR (nolock)
	left join SHIPGHDR (nolock) on hih_shpno = hiv_shpno
	left join CUPRCINF (nolock) on cpi_cusno = hih_cus1no
	where hiv_untamt = '' and hiv_credat > '2015-01-01'

end






declare @SHdateFm datetime, @SAdateFm datetime, @dateTo datetime
declare @SHPostFlag char(1), @SAPostFlag char(1)

select @SHdateFm = aeb_shbatdat, @SAdateFm = aeb_sabatdat from ACEDIBAT where aeb_cocde = @batch_cocde

Set @dateTo = Convert(char(10), getdate()-1, 101)  +   ' 23:59:59.998'

set @SHPostFlag = 'N'
set @SAPostFlag = 'N'


--if datepart(dw,getdate()) = 2  or datepart(dd,getdate()) = 5	-- Monday or 5th
if datepart(dw,getdate()) = 2  or datepart(dd,getdate()) = 3	-- Monday or 3rd
begin
	set @SHPostFlag = 'Y'
end
set @SAPostFlag = 'Y'


-- For testing
--set @SHPostFlag = 'Y'
--set @SAPostFlag = 'N'
--set @SHdateFm = '2015-09-06'
--set @SAdateFm = '2014-01-01'
--set @dateTo = '2015-09-28'



declare @pstdat as datetime

select @pstdat = aeb_pstdat from ACEDIBAT where aeb_cocde = @batch_cocde

-- For testing
--set @pstdat = '2015-05-01'


--Get Account Number from Company Control Table
declare @AC_SH nvarchar(15), @AC_SA nvarchar(15),@AC_SHADJ nvarchar(15),@AC_SATRM nvarchar(15)
select @AC_SH = pma_invacno_new, @AC_SA = pma_siacno_new, @AC_SHADJ = pma_iaacno_new, @AC_SATRM = pma_stacno_new from PCMAC where pma_pcno = 'STANDARD'

declare @batno as nvarchar(50)
select @batno = replace(convert(nvarchar(20), getdate(),112) +  convert(nvarchar(20), getdate(),114),':', '')

declare @cocde	nvarchar(6),@type nvarchar(5), @docno nvarchar(20), @invdat datetime, @slnonb datetime

declare @lastverno int, @verno int
declare @last_slnonb datetime

declare @ToNavPostFlag char(1), @ToNavRevFlag char(1)

declare @actionType char(1)

declare @navinvno nvarchar(50)

declare @chk_curcde nvarchar(20), @chk_ttlamt numeric(13,4), @chk_prctrm nvarchar(20), @chk_paytrm nvarchar(20), @chk_damt numeric(13,4), @chk_pamt numeric(13,4), @chk_deposit numeric(13,4), @chk_slnonb datetime
declare @last_curcde nvarchar(20), @last_ttlamt numeric(13,4), @last_prctrm nvarchar(20), @last_paytrm nvarchar(20), @last_damt numeric(13,4), @last_pamt numeric(13,4), @last_deposit numeric(13,4)
declare @chgflg01 char(1),@chgflg02 char(1),@chgflg03 char(1),@chgflg04 char(1),@chgflg05 char(1),@chgflg06 char(1),@chgflg07 char(1),@chgflg08 char(1),@chgflg09 char(1),@chgflg10 char(1)

declare @cus1no nvarchar(10)
declare @diff numeric(13,4)
declare @dtl_ttlamt numeric(13,4)

declare @nav_batchno nvarchar(50)

declare @last_navinvno nvarchar(50)

create table #TMP_ACEDIDTL
(
	[tmp_edibatno] 	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_navbatno]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL default '',
	[tmp_navbatlneno] [nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL default '',

	[tmp_cocde] 	[nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_invno]	[nvarchar] (20) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,	
	[tmp_verno]	int NOT NULL,	
	[tmp_acttyp]	[nvarchar] (20) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,	
	[tmp_invdat]	datetime NOT NULL,
	[tmp_slnonb]	datetime NOT NULL,
	[tmp_pstdat]	datetime NOT NULL,

	[tmp_seq]	int identity(1,1),

	[tmp_navinvno]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_navlneno]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_navdoctyp]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_navactyp]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_account]	[nvarchar] (30) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[tmp_postdsc]	[nvarchar] (300) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,	
	[tmp_apptodoc]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,

	[tmp_dtltyp]	[nvarchar] (20) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,	
	[tmp_cus1no]	[nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,	
	[tmp_cus2no]	[nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_doctyp]	[nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_dpcde]	[nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_dpdsc]	[nvarchar] (200) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_paytrm] 	[nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_prctrm] 	[nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_shpno]	[nvarchar] (20) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_shpseq]	int NOT NULL,
	[tmp_curcde] 	[nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_amount] 	[numeric](13, 2) NOT NULL ,

	[tmp_season]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_concty]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_cbm]	[numeric](13,4) NOT NULL,
	[tmp_saltem]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_cusven]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_dsgven]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_prdven]	[nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_jobord]	[nvarchar] (30) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_scno]	[nvarchar] (30) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_pono]	[nvarchar] (30) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_itmno]	[nvarchar] (30) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_shpqty]	int NOT NULL,
	[tmp_pckunt]	[nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_selprc]	[numeric](13, 4) NOT NULL ,
	[tmp_fcurcde] 	[nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[tmp_ftyprc]	[numeric](13, 4) NOT NULL 
)


--select * into #TMP_ACEDIDTL_SH_UCPP from #TMP_ACEDIDTL
--select * into #TMP_ACEDIDTL_SH_UCP from #TMP_ACEDIDTL
--select * into #TMP_ACEDIDTL_SH_PG from #TMP_ACEDIDTL
--select * into #TMP_ACEDIDTL_SH_OTH from #TMP_ACEDIDTL

--select * into #TMP_ACEDIDTL_SA_UCPP from #TMP_ACEDIDTL
--select * into #TMP_ACEDIDTL_SA_UCP from #TMP_ACEDIDTL
--select * into #TMP_ACEDIDTL_SA_PG from #TMP_ACEDIDTL
--select * into #TMP_ACEDIDTL_SA_OTH from #TMP_ACEDIDTL

select * into #TMP_ACEDIDTL_SH from #TMP_ACEDIDTL
select * into #TMP_ACEDIDTL_SA from #TMP_ACEDIDTL
select * into #TMP_ACEDIDTL_ALL from #TMP_ACEDIDTL





declare @new_nav_start_date as datetime
set @new_nav_start_date = '2015-02-25'



-- Shipping Invoice Part
if @SHPostFlag = 'Y'
begin
	declare cur_Invoice cursor
	for
	-- SH1. Normal Update
	select distinct hiv_cocde, 'SH1', hiv_invno, hiv_invdat, hih_slnonb
	from SHIPGHDR
	left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno
	left join SHINVHDR on hih_cocde = hiv_cocde and hid_shpno = hiv_shpno and hid_invno = hiv_invno
	where	
		hiv_upddat between @SHdateFm and @dateTo
		and hiv_invsts <> 'C' and (hih_shpsts = 'OPE' or hih_shpsts = 'REL') 
		and hiv_credat > '2015-01-01'
		and hiv_cocde = @batch_cocde
		and ((hiv_cocde = 'UCP' and hiv_invno >= 'I1500597') or (hiv_cocde = 'PG' and hiv_invno >= 'GI1500020') or (hiv_cocde = 'UCPP' and hiv_invno >= 'UI1500041') or hiv_cocde = 'GU')
	union
	-- SH2. Invoice without detail (cancelled)
	select distinct hiv_cocde, 'SH2', hiv_invno, hiv_invdat, hih_slnonb
	from SHINVHDR 
	left join SHIPGHDR on hiv_cocde = hih_cocde and hiv_shpno = hih_shpno
	left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno and hid_invno = hiv_invno
	where hiv_upddat between @SHdateFm and @dateTo
		and hiv_invsts <> 'C'	and hid_cocde is null
		and hiv_credat > '2015-01-01'
		and hiv_cocde = @batch_cocde
		and ((hiv_cocde = 'UCP' and hiv_invno >= 'I1500597') or (hiv_cocde = 'PG' and hiv_invno >= 'GI1500020') or (hiv_cocde = 'UCPP' and hiv_invno >= 'UI1500041') or hiv_cocde = 'GU')
	union
	-- SH3. Invoice header date change but invoice date without change
	select distinct hiv_cocde, 'SH3', hiv_invno, hiv_invdat, hih_slnonb
	from SHINVHDR 
	left join SHIPGHDR on hiv_cocde = hih_cocde and hiv_shpno = hih_shpno
	left join SHIPGDTL on hih_cocde = hid_cocde and hih_shpno = hid_shpno and hid_invno = hiv_invno
	where (not hiv_upddat between @SHdateFm and @dateTo) and (hih_upddat between @SHdateFm and @dateTo )
		and hiv_invsts <> 'C' and (hih_shpsts = 'OPE' or hih_shpsts = 'REL')
		and hiv_credat > '2015-01-01'
		and hiv_cocde = @batch_cocde
		and ((hiv_cocde = 'UCP' and hiv_invno >= 'I1500597') or (hiv_cocde = 'PG' and hiv_invno >= 'GI1500020') or (hiv_cocde = 'UCPP' and hiv_invno >= 'UI1500041') or hiv_cocde = 'GU')
	order by 1,3,2

	open cur_Invoice
	fetch next from cur_Invoice into @cocde, @type, @docno, @invdat, @slnonb

	while @@fetch_status = 0
	begin
--		select @cocde, @type, @docno, @invdat, @slnonb
--		print @cocde + ' : ' + @type + ' : ' + @docno 

		if (select count(*) from #TMP_ACEDIDTL) > 0 
		begin
			delete from #TMP_ACEDIDTL
			DBCC CHECKIDENT (#TMP_ACEDIDTL, RESEED, 0)
		end
		
		select @verno = isnull(max(isnull(aeh_verno,0)),0) from ACEDIHDR where aeh_cocde = @cocde and aeh_invno = @docno

		-- According to Company assign into different batch
		if @cocde = 'UCPP'
		begin
			set @nav_batchno = 'EDI-UCPP'
		end
		else if @cocde = 'UCP'
		begin
			set @nav_batchno = 'EDI-UCP'
		end
		else if @cocde = 'PG'
		begin
			set @nav_batchno = 'EDI-PG'
		end
		else if @cocde = 'GU'
		begin
			set @nav_batchno = 'EDI-GU'
		end
		else if @cocde = 'MS'
		begin
			set @nav_batchno = 'EDI-MS'
		end
		else
		begin
			set @nav_batchno = 'EDI-OTH'
		end

		set @ToNavPostFlag = 'N'
		set @ToNavRevFlag = 'N'

		if @type = 'SH1'
		begin
			if @verno = 0
			begin
				-- Post Only
				set @ToNavPostFlag = 'Y'
				set @ToNavRevFlag = 'N'
			end
			else
			begin
				-- Reverse Previous version and Post Current version
				set @ToNavPostFlag = 'Y'
				set @ToNavRevFlag = 'Y'
			end
		end
		else if @type = 'SH2'
		begin
			-- (Invoice cancelled) Reverse Previous version
			if @verno = 0
			begin
				set @ToNavPostFlag = 'N'
				set @ToNavRevFlag = 'N'
			end
			else
			begin
				set @ToNavPostFlag = 'N'
				set @ToNavRevFlag = 'Y'
			end
		end
		else if @type = 'SH3'
		begin
			-- check if change ETD date, Reverse Previous version and Post Current version
			if @verno = 0 
			begin
				set @ToNavPostFlag = 'N'
				set @ToNavRevFlag = 'N'
			end
			else
			begin
				select @last_slnonb = aeh_slnonb from ACEDIHDR where aeh_cocde = @cocde and aeh_invno = @docno and aeh_verno = @verno
				if @last_slnonb <> @slnonb
				begin
					set @ToNavPostFlag = 'Y'
					set @ToNavRevFlag = 'Y'
				end
				else
				begin
					set @ToNavPostFlag = 'N'
					set @ToNavRevFlag = 'N'
				end
			end
		end

		set @lastverno = @verno
		-- assign version number
		set @verno = @verno + 1

		set @navinvno = @docno + '_' + right('000' + convert(varchar(5),@verno), 3)


		--select @ToNavPostFlag, @ToNavRevFlag


		if  @ToNavRevFlag = 'Y'
		begin
			set @actionType = 'R'

			insert into ACEDIHDR (aeh_edibatno, aeh_cocde, aeh_invno, aeh_verno, aeh_acttyp, aeh_invdat,aeh_slnonb,aeh_pstdat,aeh_curcde,aeh_ttlamt,aeh_prctrm,aeh_paytrm,aeh_damt,aeh_pamt,aeh_deposit,aeh_chgdsc, aeh_chgflg01,aeh_chgflg02,aeh_chgflg03,aeh_chgflg04,aeh_chgflg05,aeh_chgflg06,aeh_chgflg07,aeh_chgflg08,aeh_chgflg09,aeh_chgflg10,aeh_creusr,aeh_updusr,aeh_credat,aeh_upddat) 
				select @batno, aeh_cocde, aeh_invno, aeh_verno, @actionType, aeh_invdat,aeh_slnonb,aeh_pstdat,aeh_curcde,-1*aeh_ttlamt,aeh_prctrm,aeh_paytrm,-1*aeh_damt,-1*aeh_pamt,-1*aeh_deposit,'','','','','','','','','','','','mis','mis',getdate(),getdate() from ACEDIHDR where aeh_cocde = @cocde and aeh_invno = @docno and aeh_verno = @lastverno

			set @last_navinvno = @docno + '_' + right('000' + convert(varchar(5),@lastverno), 3)

--			insert into #TMP_ACEDIDTL_SH			
			insert into #TMP_ACEDIDTL_ALL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, 
			tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select
			@batno, @nav_batchno,'',
			@cocde, @docno, @lastverno, @actionType,
			--@invdat, @slnonb, @slnonb
			aed_invdat, aed_slnonb, aed_pstdat,
			@last_navinvno + '_R',aed_navlneno,'Credit Memo',aed_navactyp,
			aed_account, '' ,case aed_dtltyp when 'C' then @last_navinvno else '' end, aed_dtltyp, aed_cus1no, aed_cus2no,
			aed_doctyp, aed_dpcde, aed_dpdsc,aed_paytrm, aed_prctrm, 
			aed_shpno, aed_shpseq,
			aed_curcde, -1*aed_amount,
			aed_season, aed_concty,	aed_cbm, aed_saltem, 
			aed_cusven, aed_dsgven, aed_prdven,
			aed_jobord, aed_scno, aed_pono, aed_itmno, aed_shpqty,
			aed_pckunt, aed_selprc,	aed_fcurcde, aed_ftyprc
			from ACEDIDTL where aed_cocde = @cocde and aed_invno = @docno and aed_verno = @lastverno and aed_acttyp = 'P'

			if (select sum(tmp_amount) from #TMP_ACEDIDTL_ALL where tmp_cocde = @cocde and tmp_invno = @docno and tmp_verno = @lastverno and tmp_acttyp = 'R' and tmp_dtltyp = 'C') = 0
			begin
				delete from #TMP_ACEDIDTL_ALL where tmp_cocde = @cocde and tmp_invno = @docno and tmp_verno = @lastverno and tmp_acttyp = 'R' and tmp_dtltyp = 'C'
			end
		end

		if @ToNavPostFlag = 'Y'
		begin
			set @actionType = 'P'

			set @chgflg01 = ''
			set @chgflg02 = ''
			set @chgflg03 = ''
			set @chgflg04 = ''
			set @chgflg05 = ''
			set @chgflg06 = ''
			set @chgflg07 = ''
			set @chgflg08 = ''
			set @chgflg09 = ''
			set @chgflg10 = ''

			select @chk_curcde = hiv_untamt, @chk_ttlamt = round(hiv_ttlamt,2), @chk_prctrm = hiv_prctrm, @chk_paytrm = hiv_paytrm from SHINVHDR where hiv_cocde = @cocde and hiv_invno = @docno
			select @chk_pamt = isnull(sum(round(hdp_amt,2)),0) from SHDISPRM  where hdp_cocde = @cocde and hdp_invno = @docno and hdp_type = 'P'
			select @chk_damt = isnull(sum(round(hdp_amt,2)),0) from SHDISPRM  where hdp_cocde = @cocde and hdp_invno = @docno and hdp_type = 'D'
			select @chk_deposit = isnull(sum(round(hdp_amt,2)),0) from SHDISPRM where hdp_cocde = @cocde and hdp_invno = @docno and hdp_type = 'D' and hdp_cde = '05'

			if @verno > 1
			begin
				-- Check last version
				select @last_curcde = aeh_curcde, @last_ttlamt = aeh_ttlamt, @last_prctrm = aeh_prctrm, @last_paytrm = aeh_paytrm, @last_damt = aeh_damt, @last_pamt = aeh_pamt, @last_deposit = aeh_deposit, @last_slnonb = aeh_slnonb from ACEDIHDR where aeh_cocde = @cocde and aeh_invno = @docno and aeh_verno = @lastverno and aeh_acttyp = 'P'

				-- Flag 1: Total Amount of Invoice is changed (including replacement, cancel invoice)
				if @last_curcde <> @chk_curcde or @last_ttlamt <> @chk_ttlamt
				begin
					set @chgflg01 = 'Y'
				end

				-- Flag 2: Payment term is changed
				if @last_paytrm <> @chk_paytrm
				begin
					set @chgflg02 = 'Y'
				end

				-- Flag 3: Discount adjustment
				if @last_damt <> @chk_damt
				begin
					set @chgflg03 = 'Y'
				end

				-- Flag 4: Premium adjustment
				if @last_pamt <> @chk_pamt
				begin
					set @chgflg04 = 'Y'
				end

				-- Flag 5: Deposit adjustment
				if @last_damt <> @chk_damt
				begin
					set @chgflg05 = 'Y'
				end
				
				-- Flag 6: Shipment date is changed
				if @last_slnonb <> @slnonb
				begin
					set @chgflg06 = 'Y'
				end
				
				-- Flag 7: Shipment date is changed across to other month
				if month(@last_slnonb) <> month(@slnonb)
				begin
					set @chgflg07 = 'Y'
				end
			end			

			-- insert into ACEDIHDR
			--select @batno,@cocde,@docno,@verno,@actionType,@invdat, @slnonb
			insert into ACEDIHDR (aeh_edibatno, aeh_cocde, aeh_invno, aeh_verno, aeh_acttyp, aeh_invdat,aeh_slnonb,aeh_pstdat, aeh_curcde,aeh_ttlamt,aeh_prctrm,aeh_paytrm,aeh_damt,aeh_pamt,aeh_deposit,aeh_chgdsc, aeh_chgflg01,aeh_chgflg02,aeh_chgflg03,aeh_chgflg04,aeh_chgflg05,aeh_chgflg06,aeh_chgflg07,aeh_chgflg08,aeh_chgflg09,aeh_chgflg10,aeh_creusr,aeh_updusr,aeh_credat,aeh_upddat) 
				values 	(@batno,@cocde,@docno,@verno,@actionType,@invdat, @slnonb,@slnonb,@chk_curcde,@chk_ttlamt,@chk_prctrm,@chk_paytrm,@chk_damt,@chk_pamt,@chk_deposit,'', @chgflg01,@chgflg02,@chgflg03,@chgflg04,@chgflg05,@chgflg06,@chgflg07,@chgflg08,@chgflg09,@chgflg10,'mis','mis',getdate(),getdate())


			-- insert into ACEDIDTL (Line Item)
			insert into #TMP_ACEDIDTL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select 
			@batno, '','',
			@cocde, @docno, @verno, @actionType,
			@invdat, @slnonb, @slnonb, @navinvno,'','Invoice','G/L Account',
			'','','','L',hih_cus1no,hih_cus2no,
			'SH','','',hiv_paytrm,hiv_prctrm,
			hid_shpno, hid_shpseq,
			hiv_untamt,hid_ttlamt,
			sod_season,hih_bilcty,hid_ttlvol,soh_saltem,
			hid_cusven, ibi_venno, hid_venno,
			hid_jobno,hid_ordno,hid_purord,hid_itmno,hid_shpqty,
			hid_untcde,hid_selprc,sod_dvfcurcde,sod_dvftyprc
			from SHINVHDR (nolock)
			left join SHIPGDTL (nolock) on hiv_cocde = hid_cocde and hiv_invno = hid_invno
			left join SHIPGHDR (nolock) on hih_cocde = hid_cocde and hih_shpno = hid_shpno
			left join SCORDDTL (nolock) on sod_cocde = hid_cocde and sod_ordno = hid_ordno and sod_ordseq = hid_ordseq
			left join SCORDHDR (nolock) on sod_cocde = soh_cocde and sod_ordno = soh_ordno
			left join IMBASINF (nolock) on ibi_itmno = hid_itmno
			where hiv_cocde = @cocde and hiv_invno = @docno

			-- insert into ACEDIDTL (Discount / Premimum)
			insert into #TMP_ACEDIDTL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select
			@batno,'','', 
			@cocde, @docno, @verno, @actionType,
			@invdat, @slnonb, @slnonb, @navinvno, '', 'Invoice', 'G/L Account', 
			ydp_account_new,'','',hdp_type,hih_cus1no,hih_cus2no,
			'SH',left(hdp_cde,2),hdp_dsc,hiv_paytrm,hiv_prctrm,
			hih_shpno, 0,
			hiv_untamt, case hdp_type when 'D' then -1 * hdp_amt when 'P' then hdp_amt else 0 end,
			'','',0,cbi_saltem,
			'','','',
			'','','','',0,
			'',0,'',0
			from SHINVHDR (nolock)
			left join SHIPGHDR (nolock) on hih_cocde = hiv_cocde and hih_shpno = hiv_shpno
			left join SHDISPRM (nolock) on hiv_cocde = hdp_cocde and hiv_invno = hdp_invno
			left join SYDISPRM (nolock) on left(hdp_cde,2) = ydp_cde and hdp_type = ydp_type
			left join CUBASINF (nolock) on cbi_cusno = hih_cus1no
			where hiv_cocde = @cocde and hiv_invno = @docno and hdp_cocde is not null and hdp_amt > 0

			update #TMP_ACEDIDTL set tmp_amount = round(tmp_amount,2)

			-- Rounding difference
			select @dtl_ttlamt = sum(tmp_amount) from #TMP_ACEDIDTL
			set @diff = round(@chk_ttlamt - @dtl_ttlamt,2)

			if @diff <> 0 
			begin
				insert into #TMP_ACEDIDTL
				(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
				tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
				tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
				tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
				tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
				tmp_shpno, tmp_shpseq,
				tmp_curcde, tmp_amount,
				tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
				tmp_cusven, tmp_dsgven, tmp_prdven,
				tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
				tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
				select
				top 1
				@batno, '','',
				@cocde, @docno, @verno, @actionType,
				@invdat, @slnonb, @slnonb, @navinvno, '', 'Invoice', 'G/L Account',
				'','','','R',hih_cus1no,hih_cus2no,
				'SH','','',@chk_paytrm,@chk_prctrm,
				'', 0,
				hiv_untamt,@diff,
				'','',0,cbi_saltem,
				'','','',
				'','','','',0,
				'',0,'',0
				from SHINVHDR (nolock)
--				left join SHIPGDTL (nolock) on hiv_cocde = hid_cocde and hiv_invno = hid_invno
--				left join SHIPGHDR (nolock) on hih_cocde = hid_cocde and hih_shpno = hid_shpno
				left join SHIPGHDR (nolock) on hih_cocde = hiv_cocde and hih_shpno = hiv_shpno
				left join CUBASINF (nolock) on cbi_cusno = hih_cus1no
				where hiv_cocde = @cocde and hiv_invno = @docno
			end

			-- insert into ACEDIDTL (Customer Total)
			insert into #TMP_ACEDIDTL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select
			top 1
			@batno, '','',
			@cocde, @docno, @verno, @actionType,
			@invdat, @slnonb, @slnonb, @navinvno, '', 'Invoice','Customer',
			'','','','C',hih_cus1no,hih_cus2no,
			'SH','','',@chk_paytrm,@chk_prctrm,
			'', 0,
			hiv_untamt,hiv_ttlamt,
			'','',0,'',
			'','','',
			'','','','',0,
			'',0,'',0
			from SHINVHDR (nolock)
			left join SHIPGDTL (nolock) on hiv_cocde = hid_cocde and hiv_invno = hid_invno
			left join SHIPGHDR (nolock) on hih_cocde = hid_cocde and hih_shpno = hid_shpno
			where hiv_cocde = @cocde and hiv_invno = @docno
			and hiv_ttlamt > 0  -- Added for handle replacement case : Customer 0 will not be sent to NAV and handled as follows
					
			-- Added for sending 1 d 1 c for replacement 0 case
			if (select hiv_ttlamt from SHINVHDR (nolock) where hiv_cocde = @cocde and hiv_invno = @docno ) = 0
			begin
				insert into #TMP_ACEDIDTL
				(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
				tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
				tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
				tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
				tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
				tmp_shpno, tmp_shpseq,
				tmp_curcde, tmp_amount,
				tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
				tmp_cusven, tmp_dsgven, tmp_prdven,
				tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
				tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
				select
				top 1
				@batno, '','',
				@cocde, @docno, @verno, @actionType,
				@invdat, @slnonb, @slnonb, @navinvno, '', 'Replacement','Customer',
				'','','','C',tmp_cus1no,tmp_cus2no,
				'SH','','',@chk_paytrm,@chk_prctrm,
				'', 0,
				tmp_curcde,sum(tmp_amount),
				'','',0,'',
				'','','',
				'','','','',0,
				'',0,'',0
				from #TMP_ACEDIDTL (nolock)
				where tmp_amount > 0
				group by tmp_cus1no,tmp_cus2no,tmp_curcde

				insert into #TMP_ACEDIDTL
				(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
				tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
				tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
				tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
				tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
				tmp_shpno, tmp_shpseq,
				tmp_curcde, tmp_amount,
				tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
				tmp_cusven, tmp_dsgven, tmp_prdven,
				tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
				tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
				select
				top 1
				@batno, '','',
				@cocde, @docno, @verno, @actionType,
				@invdat, @slnonb, @slnonb, @navinvno, '', 'Replacement','Customer',
				'','','','C',tmp_cus1no,tmp_cus2no,
				'SH','','',@chk_paytrm,@chk_prctrm,
				'', 0,
				tmp_curcde,sum(tmp_amount),
				'','',0,'',
				'','','',
				'','','','',0,
				'',0,'',0
				from #TMP_ACEDIDTL (nolock)
				where tmp_amount < 0
				group by tmp_cus1no,tmp_cus2no,tmp_curcde
			end



			-- Convert Seq into Navision Line Number
			update #TMP_ACEDIDTL set tmp_navlneno = convert(varchar(20),tmp_seq * 10000)

			-- Posting Description
			--update #TMP_ACEDIDTL set tmp_postdsc = tmp_navinvno + '_' + tmp_navlneno + '_' + @actionType + case tmp_dtltyp when 'L' then '' when 'C' then '' when 'R' then '_Rounding' else '_' + tmp_dpcde + '_' + tmp_dpdsc end
			update #TMP_ACEDIDTL set tmp_postdsc = tmp_navinvno + '_L_' + tmp_navlneno + case tmp_dtltyp when 'L' then '' when 'C' then '' when 'R' then '_Rounding' else '_' + case tmp_dpcde when 'D' then 'Disc' else 'Prem' end + tmp_dpdsc end
			
			-- Assign Account Number
			update #TMP_ACEDIDTL set tmp_account = pma_invacno_new from #TMP_ACEDIDTL, PCMDV, PCMAC where tmp_dsgven = pdv_vencde and pdv_pcno = pma_pcno and tmp_account = ''
			update #TMP_ACEDIDTL set tmp_account = @AC_SH where tmp_account = ''
			update #TMP_ACEDIDTL set tmp_account = tmp_cus1no where tmp_navactyp = 'Customer'



--			insert into #TMP_ACEDIDTL_SH
			insert into #TMP_ACEDIDTL_ALL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select
			tmp_edibatno, @nav_batchno, '', 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc
			from #TMP_ACEDIDTL

		end
	
		fetch next from cur_Invoice into @cocde, @type,	@docno,	@invdat, @slnonb
	end
	close cur_Invoice
	deallocate cur_Invoice

/*
	update #TMP_ACEDIDTL_SH set tmp_navbatlneno = convert(varchar(20),tmp_seq * 10000)

	insert into ACEDIDTL
	(aed_edibatno,aed_navbatno,aed_navbatlneno,
	aed_cocde,aed_invno,aed_verno,aed_acttyp,
	aed_invdat,aed_slnonb,aed_seq,
	aed_navinvno,aed_navlneno,aed_navdoctyp,aed_navactyp,aed_account,
	aed_postdsc,aed_apptodoc,aed_dtltyp,aed_cus1no,aed_cus2no,
	aed_doctyp,aed_dpcde,aed_dpdsc,aed_paytrm,aed_prctrm,
	aed_shpno,aed_shpseq,aed_curcde,aed_amount,
	aed_season,aed_concty,aed_cbm,aed_saltem,
	aed_cusven,aed_dsgven,aed_prdven,
	aed_jobord,aed_scno,aed_pono,aed_itmno,
	aed_shpqty,aed_pckunt,aed_selprc,aed_fcurcde,aed_ftyprc,
	aed_creusr,aed_updusr,aed_credat,aed_upddat)
	select 
	tmp_edibatno,tmp_navbatno,tmp_navbatlneno,
	tmp_cocde,tmp_invno,tmp_verno,tmp_acttyp,
	tmp_invdat,tmp_slnonb,tmp_seq,
	tmp_navinvno,tmp_navlneno,tmp_navdoctyp,tmp_navactyp,tmp_account,
	tmp_postdsc,tmp_apptodoc,tmp_dtltyp,tmp_cus1no,tmp_cus2no,
	tmp_doctyp,tmp_dpcde,tmp_dpdsc,tmp_paytrm,tmp_prctrm,
	tmp_shpno,tmp_shpseq,tmp_curcde,tmp_amount,
	tmp_season,tmp_concty,tmp_cbm,tmp_saltem,
	tmp_cusven,tmp_dsgven,tmp_prdven,
	tmp_jobord,tmp_scno,tmp_pono,tmp_itmno,
	tmp_shpqty,tmp_pckunt,tmp_selprc,tmp_fcurcde,tmp_ftyprc,
	'mis','mis',getdate(),getdate()
	from #TMP_ACEDIDTL_SH
	order by tmp_seq

	update ACEDIBAT set aeb_shbatdat = Convert(char(10), getdate(), 101), aeb_shedibatno = @batno
*/
end



-- Sample Invoice Part
if @SAPostFlag = 'Y'
begin
	declare cur_SampleInvoice cursor
	for
	-- SA. Normal Update
	select distinct sih_cocde, 'SA1', sih_invno, sih_issdat, '01/01/1900'
	from	SAINVHDR
	left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
	where	sih_invno <> '' 
	and sih_upddat between @SAdateFm and @dateTo
	and	sih_invsts = 'REL'
	and sih_cocde = @batch_cocde
	and sid_invno is not null
	and sih_credat > @new_nav_start_date
	union all
	-- SA. Invoice without Detail (Cancelled)
	select distinct sih_cocde, 'SA2', sih_invno, sih_issdat, '01/01/1900'
	from	SAINVHDR
	left join SAINVDTL on sih_cocde = sid_cocde and sih_invno = sid_invno
	where	sih_invno <> '' 
	and sih_upddat between @SAdateFm and @dateTo
	and	sih_invsts = 'REL'
	and sih_cocde = @batch_cocde
	and sid_invno is null 
	and sih_credat > @new_nav_start_date
	order by 2,1,3

	open cur_SampleInvoice
	fetch next from cur_SampleInvoice into @cocde, @type, @docno, @invdat, @slnonb

	while @@fetch_status = 0
	begin

--		select '001', @cocde, @type, @docno, @invdat, @slnonb
--		print @cocde + ' : ' + @type + ' : ' + @docno 

		if (select count(*) from #TMP_ACEDIDTL) > 0 
		begin
			delete from #TMP_ACEDIDTL
			DBCC CHECKIDENT (#TMP_ACEDIDTL, RESEED, 0)
		end
		
		select @verno = isnull(max(isnull(aeh_verno,0)),0) from ACEDIHDR where aeh_cocde = @cocde and aeh_invno = @docno

		-- According to Company assign into different batch
		if @cocde = 'UCPP'
		begin
			set @nav_batchno = 'EDI-UCPP'
		end
		else if @cocde = 'UCP'
		begin
			set @nav_batchno = 'EDI-UCP'
		end
		else if @cocde = 'PG'
		begin
			set @nav_batchno = 'EDI-PG'
		end
		else if @cocde = 'GU'
		begin
			set @nav_batchno = 'EDI-GU'
		end
		else if @cocde = 'MS'
		begin
			set @nav_batchno = 'EDI-MS'
		end
		else
		begin
			set @nav_batchno = 'EDI-OTH'
		end

		set @ToNavPostFlag = 'N'
		set @ToNavRevFlag = 'N'

		if @type = 'SA1'
		begin
			if @verno = 0
			begin
				-- Post Only
				set @ToNavPostFlag = 'Y'
				set @ToNavRevFlag = 'N'
			end
			else
			begin
				-- Reverse Previous version and Post Current version
				set @ToNavPostFlag = 'Y'
				set @ToNavRevFlag = 'Y'
			end
		end
		else if @type = 'SA2'
		begin
			-- (Invoice cancelled) Reverse Previous version
			if @verno = 0
			begin
				set @ToNavPostFlag = 'N'
				set @ToNavRevFlag = 'N'
			end
			else
			begin
				set @ToNavPostFlag = 'N'
				set @ToNavRevFlag = 'Y'
			end
		end

		set @lastverno = @verno
		-- assign version number
		set @verno = @verno + 1

		set @navinvno = @docno + '_' + right('000' + convert(varchar(5),@verno), 3)

		if  @ToNavRevFlag = 'Y'
		begin
			set @actionType = 'R'

			insert into ACEDIHDR (aeh_edibatno, aeh_cocde, aeh_invno, aeh_verno, aeh_acttyp, aeh_invdat,aeh_slnonb, aeh_pstdat, aeh_curcde,aeh_ttlamt,aeh_prctrm,aeh_paytrm,aeh_damt,aeh_pamt,aeh_deposit,aeh_chgdsc, aeh_chgflg01,aeh_chgflg02,aeh_chgflg03,aeh_chgflg04,aeh_chgflg05,aeh_chgflg06,aeh_chgflg07,aeh_chgflg08,aeh_chgflg09,aeh_chgflg10,aeh_creusr,aeh_updusr,aeh_credat,aeh_upddat) 
				select @batno, aeh_cocde, aeh_invno, aeh_verno, @actionType, aeh_invdat,aeh_slnonb,aeh_pstdat, aeh_curcde,-1*aeh_ttlamt,aeh_prctrm,aeh_paytrm,-1*aeh_damt,-1*aeh_pamt,-1*aeh_deposit,'','','','','','','','','','','','mis','mis',getdate(),getdate() from ACEDIHDR where aeh_cocde = @cocde and aeh_invno = @docno and aeh_verno = @lastverno

			set @last_navinvno = @docno + '_' + right('000' + convert(varchar(5),@lastverno), 3)

--			insert into #TMP_ACEDIDTL_SA
			insert into #TMP_ACEDIDTL_ALL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, 
			tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select
			@batno, @nav_batchno,'',
			@cocde, @docno, @lastverno, @actionType,
			--@invdat, @invdat, @invdat, 
			aed_invdat, aed_slnonb, aed_pstdat,
			@last_navinvno + '_R',aed_navlneno,'Credit Memo',aed_navactyp,
			aed_account, aed_postdsc,case aed_dtltyp when 'C' then @last_navinvno else '' end, aed_dtltyp, aed_cus1no, aed_cus2no,
			aed_doctyp, aed_dpcde, aed_dpdsc,aed_paytrm, aed_prctrm, 
			aed_shpno, aed_shpseq,
			aed_curcde, -1*aed_amount,
			aed_season, aed_concty,	aed_cbm, aed_saltem, 
			aed_cusven, aed_dsgven, aed_prdven,
			aed_jobord, aed_scno, aed_pono, aed_itmno, aed_shpqty,
			aed_pckunt, aed_selprc,	aed_fcurcde, aed_ftyprc
			from ACEDIDTL where aed_cocde = @cocde and aed_invno = @docno and aed_verno = @lastverno and aed_acttyp = 'P'
		end


		if @ToNavPostFlag = 'Y'
		begin
			set @actionType = 'P'

			set @chgflg01 = ''
			set @chgflg02 = ''
			set @chgflg03 = ''
			set @chgflg04 = ''
			set @chgflg05 = ''
			set @chgflg06 = ''
			set @chgflg07 = ''
			set @chgflg08 = ''
			set @chgflg09 = ''
			set @chgflg10 = ''

			select @chk_curcde = sih_curcde, @chk_ttlamt = sih_netamt, @chk_prctrm = sih_prctrm, @chk_paytrm = '', @chk_damt = sih_discnt from SAINVHDR where sih_cocde = @cocde and sih_invno = @docno
			select @chk_pamt = 0
--			select @chk_damt = 0
			select @chk_deposit = 0

			if @verno > 1
			begin
				-- Check last version
				select @last_curcde = aeh_curcde, @last_ttlamt = aeh_ttlamt, @last_prctrm = aeh_prctrm, @last_paytrm = aeh_paytrm, @last_damt = aeh_damt, @last_pamt = aeh_pamt, @last_deposit = aeh_deposit, @last_slnonb = aeh_slnonb from ACEDIHDR where aeh_cocde = @cocde and aeh_invno = @docno and aeh_verno = @lastverno and aeh_acttyp = 'P'

				-- Flag 1: Total Amount of Invoice is changed (including replacement, cancel invoice)
				if @last_curcde <> @chk_curcde or @last_ttlamt <> @chk_ttlamt
				begin
					set @chgflg01 = 'Y'
				end

				-- Flag 2: Payment term is changed
				if @last_paytrm <> @chk_paytrm
				begin
					set @chgflg02 = 'Y'
				end

				-- Flag 3: Discount adjustment
				if @last_damt <> @chk_damt
				begin
					set @chgflg03 = 'Y'
				end
			end			

			-- insert into ACEDIHDR
			insert into ACEDIHDR (aeh_edibatno, aeh_cocde, aeh_invno, aeh_verno, aeh_acttyp, aeh_invdat,aeh_slnonb,aeh_curcde,aeh_ttlamt,aeh_prctrm,aeh_paytrm,aeh_damt,aeh_pamt,aeh_deposit,aeh_chgdsc, aeh_chgflg01,aeh_chgflg02,aeh_chgflg03,aeh_chgflg04,aeh_chgflg05,aeh_chgflg06,aeh_chgflg07,aeh_chgflg08,aeh_chgflg09,aeh_chgflg10,aeh_creusr,aeh_updusr,aeh_credat,aeh_upddat) 
				values 	(@batno,@cocde,@docno,@verno,@actionType,@invdat,@invdat,@chk_curcde,@chk_ttlamt,@chk_prctrm,@chk_paytrm,@chk_damt,@chk_pamt,@chk_deposit,'', @chgflg01,@chgflg02,@chgflg03,@chgflg04,@chgflg05,@chgflg06,@chgflg07,@chgflg08,@chgflg09,@chgflg10,'mis','mis',getdate(),getdate())

			-- insert into ACEDIDTL (Line Item)
			insert into #TMP_ACEDIDTL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select 
			@batno, '','',
			@cocde, @docno, @verno, @actionType,
			@invdat, @invdat, @invdat, @navinvno,'','Invoice','G/L Account',
			'','','','L',sih_cus1no,sih_cus2no,
			'SA','','',cpi_paytrm,sih_prctrm,
			'', 0,
			--sid_curcde,round(sum(sid_ttlamt * (1-(sih_discnt/100.0))),2),
			sid_curcde,round(sum(sid_ttlamt),2),
			isnull(quh_season,''), '',0,isnull(left(right(sih_saltem,2),1),''),
			sid_cusven, isnull(ibi_venno,''), sid_venno,
			'','',0,sid_itmno,sid_chgqty,
			sid_curcde,sid_selprc,sid_fcurcde,sid_ftyprc
			from SAINVHDR (nolock)
			left join SAINVDTL (nolock) on sih_cocde = sid_cocde and sih_invno = sid_invno
			left join QUOTNDTL (nolock) on qud_cocde = sid_cocde and qud_qutno = sid_qutno and qud_qutseq = sid_qutseq
			left join QUOTNHDR (nolock) on qud_cocde = quh_cocde and qud_qutno = quh_qutno
			left join IMBASINF (nolock) on ibi_itmno = sid_itmno
			left join CUPRCINF on sih_cus1no = cpi_cusno
			where sid_cocde = @cocde and sid_invno = @docno
			group by sih_cocde, sih_cus1no, cpi_paytrm, sih_prctrm, sih_curcde,sih_cus2no, sih_discnt,
				sid_curcde,quh_Season,sih_saltem,sid_cusven,ibi_venno,sid_venno,sid_itmno,
				sid_chgqty,sid_curcde,sid_selprc,sid_fcurcde,sid_ftyprc

			-- insert into ACEDIDTL (Discount)
			insert into #TMP_ACEDIDTL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select 
			@batno, '','',
			@cocde, @docno, @verno, @actionType,
			@invdat, @invdat, @invdat, @navinvno,'','Invoice','G/L Account',
			'','','','L',sih_cus1no,sih_cus2no,
			'SA','D','Sample Discount','','',
			'', 0,
			sih_curcde,round(sih_ttlamt * (-1 * sih_discnt/100.0),2),
			'','',0,isnull(left(right(sih_saltem,2),1),''),
			'', '', '',
			'','',0,'',0,
			'',0,'',0
			from SAINVHDR (nolock)
			where sih_cocde = @cocde and sih_invno = @docno and sih_discnt <> 0


			-- Rounding difference
			select @dtl_ttlamt = sum(case tmp_dtltyp when 'D' then -1*tmp_amount else tmp_amount end) from #TMP_ACEDIDTL
			set @diff = @chk_ttlamt - @dtl_ttlamt

			if @diff <> 0 
			begin
				insert into #TMP_ACEDIDTL
				(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
				tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
				tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
				tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
				tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
				tmp_shpno, tmp_shpseq,
				tmp_curcde, tmp_amount,
				tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
				tmp_cusven, tmp_dsgven, tmp_prdven,
				tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
				tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
				select
				top 1
				@batno, '','',
				@cocde, @docno, @verno, @actionType,
				@invdat, @invdat, @invdat,@navinvno, '', 'Invoice', 'G/L Account',
				'','','','R',sih_cus1no,sih_cus2no,
				'SA','','',@chk_paytrm,@chk_prctrm,
				'', 0,
				sih_curcde,@diff,
				'','',0,cbi_saltem,
				'','','',
				'','','','',0,
				'',0,'',0
				from SAINVHDR (nolock)
				left join CUBASINF on cbi_cusno = sih_cus1no
				where sih_cocde = @cocde and sih_invno = @docno
			end

			-- insert into ACEDIDTL (Customer Total)
			insert into #TMP_ACEDIDTL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select
			top 1
			@batno, '','',
			@cocde, @docno, @verno, @actionType,
			@invdat, @invdat, @invdat, @navinvno, '', 'Invoice','Customer',
			'','','','C',sih_cus1no,sih_cus2no,
			'SA','','',@chk_paytrm,@chk_prctrm,
			'', 0,
			sih_curcde,sih_netamt,
			'','',0,isnull(left(right(sih_saltem,2),1),''),
			'','','',
			'','','','',0,
			'',0,'',0
			from SAINVHDR (nolock)
			where sih_cocde = @cocde and sih_invno = @docno
			and sih_netamt > 0  -- Added for handle replacement case : Customer 0 will not be sent to NAV and handled as follows
					
			-- Added for sending 1 d 1 c for replacement 0 case
			if (select sih_netamt from SAINVHDR (nolock) where sih_cocde = @cocde and sih_invno = @docno ) = 0
			begin
				insert into #TMP_ACEDIDTL
				(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
				tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
				tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
				tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
				tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
				tmp_shpno, tmp_shpseq,
				tmp_curcde, tmp_amount,
				tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
				tmp_cusven, tmp_dsgven, tmp_prdven,
				tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
				tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
				select
				top 1
				@batno, '','',
				@cocde, @docno, @verno, @actionType,
				@invdat, @invdat, @invdat, @navinvno, '', 'Replacement','Customer',
				'','','','C',tmp_cus1no,tmp_cus2no,
				'SA','','',@chk_paytrm,@chk_prctrm,
				'', 0,
				tmp_curcde,sum(tmp_amount),
				'','',0,tmp_saltem,
				'','','',
				'','','','',0,
				'',0,'',0
				from #TMP_ACEDIDTL (nolock)
				where tmp_amount > 0
				group by tmp_cus1no,tmp_cus2no,tmp_curcde,tmp_saltem

				insert into #TMP_ACEDIDTL
				(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
				tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
				tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
				tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
				tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
				tmp_shpno, tmp_shpseq,
				tmp_curcde, tmp_amount,
				tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
				tmp_cusven, tmp_dsgven, tmp_prdven,
				tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
				tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
				select
				top 1
				@batno, '','',
				@cocde, @docno, @verno, @actionType,
				@invdat, @slnonb, @slnonb, @navinvno, '', 'Replacement','Customer',
				'','','','C',tmp_cus1no,tmp_cus2no,
				'SA','','',@chk_paytrm,@chk_prctrm,
				'', 0,
				tmp_curcde,sum(tmp_amount),
				'','',0,tmp_saltem,
				'','','',
				'','','','',0,
				'',0,'',0
				from #TMP_ACEDIDTL (nolock)
				where tmp_amount < 0
				group by tmp_cus1no,tmp_cus2no,tmp_curcde,tmp_saltem
			end






			-- Convert Seq into Navision Line Number
			update #TMP_ACEDIDTL set tmp_navlneno = convert(varchar(20),tmp_seq * 10000)

			-- Posting Description
--			update #TMP_ACEDIDTL set tmp_postdsc = tmp_navinvno + '_' + tmp_navlneno + '_' + @actionType + case tmp_dtltyp when 'L' then '' when 'C' then '' when 'R' then '_Rounding' else '_' + tmp_dpcde + '_' + tmp_dpdsc end
			update #TMP_ACEDIDTL set tmp_postdsc = tmp_navinvno + '_L_' + tmp_navlneno + case tmp_dtltyp when 'L' then '' when 'C' then '' when 'R' then '_Rounding' else '_' + case tmp_dpcde when 'D' then 'Disc' else 'Prem' end + tmp_dpdsc end

			-- Assign Account Number
			update #TMP_ACEDIDTL set tmp_account = pma_siacno_new from #TMP_ACEDIDTL, PCMDV, PCMAC where tmp_dsgven = pdv_vencde and pdv_pcno = pma_pcno and tmp_account = ''
			update #TMP_ACEDIDTL set tmp_account = @AC_SA where tmp_account = ''
			update #TMP_ACEDIDTL set tmp_account = tmp_cus1no where tmp_navactyp = 'Customer'

--			insert into #TMP_ACEDIDTL_SA
			insert into #TMP_ACEDIDTL_ALL
			(tmp_edibatno, tmp_navbatno, tmp_navbatlneno, 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc)
			select
			tmp_edibatno, @nav_batchno, '', 
			tmp_cocde, tmp_invno, tmp_verno, tmp_acttyp,
			tmp_invdat, tmp_slnonb, tmp_pstdat, tmp_navinvno, tmp_navlneno, tmp_navdoctyp, tmp_navactyp,
			tmp_account, tmp_postdsc,tmp_apptodoc, tmp_dtltyp, tmp_cus1no, tmp_cus2no,
			tmp_doctyp, tmp_dpcde, tmp_dpdsc,tmp_paytrm, tmp_prctrm, 
			tmp_shpno, tmp_shpseq,
			tmp_curcde, tmp_amount,
			tmp_season, tmp_concty,	tmp_cbm, tmp_saltem, 
			tmp_cusven, tmp_dsgven, tmp_prdven,
			tmp_jobord, tmp_scno, tmp_pono, tmp_itmno, tmp_shpqty,
			tmp_pckunt, tmp_selprc,	tmp_fcurcde, tmp_ftyprc
			from #TMP_ACEDIDTL
		end

		fetch next from cur_SampleInvoice into @cocde, @type,	@docno,	@invdat, @slnonb
	end
	close cur_SampleInvoice
	deallocate cur_SampleInvoice

/*
	update #TMP_ACEDIDTL_SA set tmp_navbatlneno = convert(varchar(20),tmp_seq * 10000)

	insert into ACEDIDTL
	(aed_edibatno,aed_navbatno,aed_navbatlneno,
	aed_cocde,aed_invno,aed_verno,aed_acttyp,
	aed_invdat,aed_slnonb,aed_seq,
	aed_navinvno,aed_navlneno,aed_navdoctyp,aed_navactyp,aed_account,
	aed_postdsc,aed_apptodoc,aed_dtltyp,aed_cus1no,aed_cus2no,
	aed_doctyp,aed_dpcde,aed_dpdsc,aed_paytrm,aed_prctrm,
	aed_shpno,aed_shpseq,aed_curcde,aed_amount,
	aed_season,aed_concty,aed_cbm,aed_saltem,
	aed_cusven,aed_dsgven,aed_prdven,
	aed_jobord,aed_scno,aed_pono,aed_itmno,
	aed_shpqty,aed_pckunt,aed_selprc,aed_fcurcde,aed_ftyprc,
	aed_creusr,aed_updusr,aed_credat,aed_upddat)
	select 
	tmp_edibatno,tmp_navbatno,tmp_navbatlneno,
	tmp_cocde,tmp_invno,tmp_verno,tmp_acttyp,
	tmp_invdat,tmp_slnonb,tmp_seq,
	tmp_navinvno,tmp_navlneno,tmp_navdoctyp,tmp_navactyp,tmp_account,
	tmp_postdsc,tmp_apptodoc,tmp_dtltyp,tmp_cus1no,tmp_cus2no,
	tmp_doctyp,tmp_dpcde,tmp_dpdsc,tmp_paytrm,tmp_prctrm,
	tmp_shpno,tmp_shpseq,tmp_curcde,tmp_amount,
	tmp_season,tmp_concty,tmp_cbm,tmp_saltem,
	tmp_cusven,tmp_dsgven,tmp_prdven,
	tmp_jobord,tmp_scno,tmp_pono,tmp_itmno,
	tmp_shpqty,tmp_pckunt,tmp_selprc,tmp_fcurcde,tmp_ftyprc,
	'mis','mis',getdate(),getdate()
	from #TMP_ACEDIDTL_SA
	order by tmp_seq

	update ACEDIBAT set aeb_sabatdat = Convert(char(10), getdate(), 101), aeb_saedibatno = @batno
*/
end


	update #TMP_ACEDIDTL_ALL set tmp_navbatlneno = convert(varchar(20),tmp_seq * 10000)

	update #TMP_ACEDIDTL_ALL set tmp_pstdat = @pstdat where tmp_pstdat < @pstdat


	insert into ACEDIDTL
	(aed_edibatno,aed_navbatno,aed_navbatlneno,
	aed_cocde,aed_invno,aed_verno,aed_acttyp,
	aed_invdat,aed_slnonb,aed_pstdat, aed_seq,
	aed_navinvno,aed_navlneno,aed_navdoctyp,aed_navactyp,aed_account,
	aed_postdsc,aed_apptodoc,aed_dtltyp,aed_cus1no,aed_cus2no,
	aed_doctyp,aed_dpcde,aed_dpdsc,aed_paytrm,aed_prctrm,
	aed_shpno,aed_shpseq,aed_curcde,aed_amount,
	aed_season,aed_concty,aed_cbm,aed_saltem,
	aed_cusven,aed_dsgven,aed_prdven,
	aed_jobord,aed_scno,aed_pono,aed_itmno,
	aed_shpqty,aed_pckunt,aed_selprc,aed_fcurcde,aed_ftyprc,
	aed_creusr,aed_updusr,aed_credat,aed_upddat)
	select 
	tmp_edibatno,tmp_navbatno,tmp_navbatlneno,
	tmp_cocde,tmp_invno,tmp_verno,tmp_acttyp,
	tmp_invdat,tmp_slnonb,tmp_pstdat, tmp_seq,
	tmp_navinvno,tmp_navlneno,tmp_navdoctyp,tmp_navactyp,tmp_account,
	tmp_postdsc,tmp_apptodoc,tmp_dtltyp,tmp_cus1no,tmp_cus2no,
	tmp_doctyp,tmp_dpcde,tmp_dpdsc,tmp_paytrm,tmp_prctrm,
	tmp_shpno,tmp_shpseq,tmp_curcde,tmp_amount,
	tmp_season,tmp_concty,tmp_cbm,tmp_saltem,
	tmp_cusven,tmp_dsgven,tmp_prdven,
	tmp_jobord,tmp_scno,tmp_pono,tmp_itmno,
	tmp_shpqty,tmp_pckunt,tmp_selprc,tmp_fcurcde,tmp_ftyprc,
	'mis','mis',getdate(),getdate()
	from #TMP_ACEDIDTL_ALL
	order by tmp_seq


	
if @SHPostFlag = 'Y'
begin
	update ACEDIBAT set aeb_shbatdat = Convert(char(10), getdate(), 101), aeb_shedibatno = @batno where aeb_cocde = @batch_cocde
end

if @SAPostFlag = 'Y'
begin
	update ACEDIBAT set aeb_sabatdat = Convert(char(10), getdate(), 101), aeb_saedibatno = @batno where aeb_cocde = @batch_cocde
end




drop table #TMP_ACEDIDTL
drop table #TMP_ACEDIDTL_SH
drop table #TMP_ACEDIDTL_SA
drop table #TMP_ACEDIDTL_ALL

end
GO
