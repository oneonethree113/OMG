/****** Object:  StoredProcedure [dbo].[sp_select_CUITMPRC_SC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUITMPRC_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUITMPRC_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE   PROCEDURE [dbo].[sp_select_CUITMPRC_SC]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cis_cocde nvarchar(6) ,
@cis_itmno nvarchar(20),
@cis_cusno nvarchar(6),
@cis_seccus nvarchar(6),
@sod_credat datetime


---------------------------------------------- 
 
AS
BEGIN




	create table #RESULT
	(	cis_cocde	nvarchar(6),
		cis_cusno	nvarchar(6),
		cis_seccus	nvarchar(6),
		cis_itmno	nvarchar(20),
		cis_itmdsc	nvarchar(800),
		cis_itmventyp	char(1),
		cis_cusitm	nvarchar(20),
		cis_colcde	nvarchar(30),
		cis_coldsc	nvarchar(300),
		cis_cuscol	nvarchar(30),
		cip_venno	nvarchar(6),
		cip_prdven	nvarchar(6),
		cis_cusven	nvarchar(6),
		cis_tradeven	nvarchar(6),
		cis_examven	nvarchar(6),
		cis_untcde	nvarchar(6),
		cis_inrqty	int,
		cis_mtrqty	int,
		cis_cft		numeric(11, 4),
		cis_cbm		numeric(11, 4),
		cis_refdoc	nvarchar(20),
		cis_docdat	datetime,
		cis_qutno	nvarchar(20),
		cis_qutseq	int,
		cip_cus1no	nvarchar(6),
		cip_cus2no	nvarchar(6),
		cip_ftyprctrm	nvarchar(10),
		cip_hkprctrm	nvarchar(10),
		cip_trantrm	nvarchar(10),
		cip_effdat	datetime,
		cip_expdat	datetime,
		cis_cussku	nvarchar(20),
		cip_fcurcde	nvarchar(6),
		cip_ftycst	numeric(13, 4),
		cip_bomcst	numeric(13, 4),
		cip_ftyprc	numeric(13, 4),
		cip_curcde	nvarchar(6),
		cip_minprc	numeric(13, 4),
		cip_basprc	numeric(13, 4),
		cis_ordqty	int,
		cis_selprc	numeric(13, 4),
		cis_hrmcde	nvarchar(12),
		cis_dtyrat	numeric(6, 3),
		cis_dept	nvarchar(20),
		cis_typcode	nvarchar(1),
		cis_code1	nvarchar(25),
		cis_code2	nvarchar(25),
		cis_code3	nvarchar(25),
		cis_cususdcur	nvarchar(10),
		cis_cususd	numeric(11, 4),
		cis_cuscadcur	nvarchar(10),
		cis_cuscad	numeric(11, 4),
		cis_colpck	nvarchar(100),
		cis_inrdin	numeric(11, 4),
		cis_inrwin	numeric(11, 4),
		cis_inrhin	numeric(11, 4),
		cis_mtrdin	numeric(11, 4),
		cis_mtrwin	numeric(11, 4),
		cis_mtrhin	numeric(11, 4),
		cis_inrdcm	numeric(11, 4),
		cis_inrwcm	numeric(11, 4),
		cis_inrhcm	numeric(11, 4),
		cis_mtrdcm	numeric(11, 4),
		cis_mtrwcm	numeric(11, 4),
		cis_mtrhcm	numeric(11, 4),
		ibi_itmsts	nvarchar(50),
		ibi_typ		nvarchar(4),
		cip_qutdat	datetime,
		cip_imqutdat	datetime,
		cis_creusr	nvarchar(30),
		cis_updusr	nvarchar(30),
		cis_credat	datetime,
		cis_upddat	datetime,
		cis_timstp	int,
		h_ibi_itmsts	nvarchar(50),
		h_ibi_typ	nvarchar(4),
		h_imu_burcde	nvarchar(4),
		h_imu_basprc	numeric(13, 4),
		cis_pckitr	nvarchar(300),
		cis_tirtyp	char(1),
		h_cis_tirtyp	char(1),
		icf_colcde	nvarchar(30),
		ibi_venno	nvarchar(6),
		ibi_alsitmno	nvarchar(20),
		ibi_alscolcde	nvarchar(30),
		cis_conftr	int,
		cis_contopc	nvarchar(1),
		cis_pcprc	numeric(13, 4),
		ibi_ftytmp	nvarchar(1),
		cis_cusstyno	nvarchar(30),
		imu_std		nvarchar(3),
		ivi_venitm	nvarchar(20),
		vbi_vensts	nvarchar(3),
		cis_moq		int,
		cis_moqunttyp	nvarchar(6),
		cis_moa		numeric(11, 4),
		cis_season	nvarchar(30),
		cis_year	nvarchar(4),
		cip_latest	nvarchar(1),
		cip_effcpo	nvarchar(1),
		cip_markup	numeric(13,4),
		cip_mumin	numeric(13,4),
		cip_mrkprc	numeric(13,4),
		cip_muminprc	numeric(13,4),
		cip_commsn	numeric(13,4),
		cip_itmcom	numeric(13,4),
		cip_pckcst	numeric(13,4),
		cip_stdprc	numeric(13,4),
		cis_name_f1	nvarchar(150),
		cis_dsc_f1	nvarchar(150),
		cis_name_f2	nvarchar(150),
		cis_dsc_f2	nvarchar(150),
		cis_name_f3	nvarchar(150),
		cis_dsc_f3	nvarchar(150),
		cis_itmchidsc nvarchar(800)
	)
	




if (select count(*) from IMBASINF (nolock) join VNBASINF (nolock) on vbi_venno = ibi_venno and vbi_ventyp = 'E' where ibi_itmno = @cis_itmno) > 0
begin
	---- Create Temp IM Table  ----
	select	* 
	into	#IM_EXT
	from	(
		select	ibi_itmno, 
			bas.ibi_alsitmno, 
			bas.ibi_typ, 
			bas.ibi_itmsts, 
			bas.ibi_venno, 
			icf_colcde, 
			icf_vencol, 
			ipi_pckunt, 
			ipi_inrqty, 
			ipi_mtrqty,
			ipi_conftr, 
			ipi_cft, 
			ipi_cbm, 
			'N' as'ResultStatus' , 
			isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', 
			bas.ibi_ftytmp,
			bas.ibi_chndsc 
		from	IMBASINF bas (nolock)
			left join IMCOLINF (nolock) on
				icf_itmno = bas.ibi_itmno 
			left join IMPCKINF (nolock) on
				ipi_itmno = bas.ibi_itmno 
			left join IMVENINF (nolock) on
				ivi_itmno = bas.ibi_itmno and
				ivi_def = 'Y'
		where	bas.ibi_itmno = @cis_itmno and
			bas.ibi_itmsts <> 'CLO' 
		
		UNION 
		
		select	bas.ibi_itmno, 
			bas.ibi_alsitmno, 
			bas.ibi_typ, 
			bas.ibi_itmsts, 
			bas.ibi_venno, 
			icf_colcde, 
			icf_vencol, 
			ipi_pckunt, 
			ipi_inrqty, 
			ipi_mtrqty,
			ipi_conftr, 
			ipi_cft, 
			ipi_cbm, 
			'A' as'ResultStatus',
			isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', 
			bas.ibi_ftytmp,
			bas.ibi_chndsc 
		from 	IMBASINF bas (nolock)
			left join IMBASINF old (nolock) on
				bas.ibi_alsitmno = old.ibi_itmno 
			left join IMCOLINF (nolock) on
				icf_itmno = bas.ibi_itmno 
			left join IMPCKINF (nolock) on
				ipi_itmno = bas.ibi_itmno 
			left join IMVENINF (nolock) on
				ivi_itmno = bas.ibi_itmno and
				ivi_def = 'Y'
		where	bas.ibi_alsitmno = @cis_itmno and
			bas.ibi_itmsts <> 'CLO' and
			isnull(old.ibi_itmsts,'') <> 'OLD' 
		) as table_im
	
	-- Find Latest CIH Pricing for each CIH Item entry
	select	*
	into	#CUITMPRC_EXT
	from	(	select	cip_cocde,	cip_cusno,	cip_seccus,
				cip_itmno,	cip_venno ,	cip_prdven ,
				cip_colcde,	cip_untcde,
				cip_conftr,	cip_inrqty,	cip_mtrqty,
				cip_hkprctrm,	cip_ftyprctrm, 	cip_trantrm,
				max(cip_upddat) as cip_upddat,	'N' as cip_latest,
				'Y' as cip_effcpo
			from	CUITMPRC (nolock)
			where	cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and
				cip_seccus = @cis_seccus and
				@sod_credat between cip_effdat and cip_expdat
			group by cip_cocde, cip_cusno, cip_seccus, cip_itmno,cip_venno ,cip_prdven , cip_colcde,
				cip_untcde, cip_conftr, cip_inrqty, cip_mtrqty, cip_hkprctrm,
				cip_ftyprctrm, cip_trantrm
			union
			select	cip_cocde,	cip_cusno,	cip_seccus,
				cip_itmno,	cip_venno,	cip_prdven ,
				cip_colcde,	cip_untcde,
				cip_conftr,	cip_inrqty,	cip_mtrqty,
				cip_hkprctrm,	cip_ftyprctrm, 	cip_trantrm,
				max(cip_upddat) as cip_upddat,	'N' as cip_latest,
				'N' as cip_effcpo
			from	CUITMPRC (nolock)
				join IMPRCINF (nolock) on
					imu_itmno = cip_itmno and
					imu_prdven = cip_prdven and
					imu_pckunt = cip_untcde and
					imu_inrqty = cip_inrqty and
					imu_mtrqty = cip_mtrqty and
					imu_ftyprctrm = cip_ftyprctrm and
					imu_hkprctrm = cip_hkprctrm and
					imu_trantrm = cip_trantrm and
					imu_status = 'ACT'
			where	cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and
				cip_seccus = @cis_seccus and
				--(@sod_credat < cip_expdat or @sod_credat > cip_expdat) and 
				@sod_credat <= cip_expdat and 
				@sod_credat not between cip_effdat and cip_expdat
				--@sod_credat < cip_expdat and -- Add Marco 20140730
				/*(select count(*) from CUITMPRC (nolock) where cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and cip_seccus = @cis_seccus and 
				cip_inrqty = imu_inrqty and cip_mtrqty = imu_mtrqty and 
				cip_ftyprctrm = imu_hkprctrm and cip_hkprctrm = imu_hkprctrm and
				cip_trantrm = imu_trantrm and @sod_credat between cip_effdat and cip_expdat) = 0 
				and
				(select count(*) from CUITMPRC (nolock) where cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and cip_seccus = @cis_seccus and 
				@sod_credat between cip_effdat and cip_expdat) = 0 */
			group by cip_cocde, cip_cusno, cip_seccus, cip_itmno, cip_venno ,cip_prdven , cip_colcde,
				cip_untcde, cip_conftr, cip_inrqty, cip_mtrqty, cip_hkprctrm,
				cip_ftyprctrm, cip_trantrm
		) as table_cih
	
	 
	update	#CUITMPRC_EXT
	set	cip_latest = 'Y'
	from	#CUITMPRC_EXT tmp
	where	(select count(*) from CUITMPRC cih (nolock) where cih.cip_cocde = tmp.cip_cocde and cih.cip_cusno = tmp.cip_cusno and 
		cih.cip_seccus = tmp.cip_seccus and cih.cip_itmno = tmp.cip_itmno and cih.cip_colcde = tmp.cip_colcde and 
		cih.cip_untcde = tmp.cip_untcde and cih.cip_conftr = tmp.cip_conftr and cih.cip_inrqty = tmp.cip_inrqty and
		cih.cip_mtrqty = tmp.cip_mtrqty and cih.cip_hkprctrm = tmp.cip_hkprctrm and cih.cip_ftyprctrm = tmp.cip_ftyprctrm and
		cih.cip_trantrm = tmp.cip_trantrm and cih.cip_upddat > tmp.cip_upddat) = 0
	
	 --select * from #CUITMPRC_EXT

declare @cur_cocde_ext nvarchar(6)
declare @cur_cusno_ext nvarchar(6)
declare @cur_seccus_ext nvarchar(6)
declare @cur_itmno_ext nvarchar(20)
declare @cur_venno_ext nvarchar(10)
declare @cur_prdven_ext nvarchar(10)
declare @cur_colcde_ext nvarchar(30)
declare @cur_untcde_ext nvarchar(6)
declare @cur_conftr_ext numeric(18,0)
declare @cur_inrqty_ext int
declare @cur_mtrqty_ext int
declare @cur_hkprctrm_ext nvarchar(10)
declare @cur_ftyprctrm_ext nvarchar(10)
declare @cur_trantrm_ext nvarchar(10)
declare @cur_upddat_ext datetime
declare @cur_count_ext int

declare cur_EXT cursor
for
select distinct cip_cocde, cip_cusno, cip_seccus, cip_itmno, cip_venno,
		cip_prdven, cip_colcde, cip_untcde, cip_conftr, cip_inrqty,
		cip_mtrqty, cip_hkprctrm, cip_ftyprctrm, cip_trantrm,cip_upddat from #CUITMPRC_EXT



open cur_EXT
fetch next from cur_EXT into 
		 @cur_cocde_ext, @cur_cusno_ext, @cur_seccus_ext, @cur_itmno_ext, @cur_venno_ext,
		@cur_prdven_ext, @cur_colcde_ext, @cur_untcde_ext, @cur_conftr_ext, @cur_inrqty_ext,
		@cur_mtrqty_ext, @cur_hkprctrm_ext, @cur_ftyprctrm_ext, @cur_trantrm_ext , @cur_upddat_ext
		
 

while @@fetch_status = 0
begin


select @cur_count_ext = count(*) from #CUITMPRC_EXT
where cip_cocde = @cur_cocde_ext and  cip_cusno = @cur_cusno_ext and  cip_seccus = @cur_seccus_ext and 
          cip_itmno = @cur_itmno_ext and cip_venno = @cur_venno_ext and cip_prdven = @cur_prdven_ext and 
	 cip_colcde = @cur_colcde_ext and  cip_untcde = @cur_untcde_ext and  cip_conftr = @cur_conftr_ext and  
	cip_inrqty = @cur_inrqty_ext and cip_mtrqty = @cur_mtrqty_ext and  cip_hkprctrm = @cur_hkprctrm_ext and 
	 cip_ftyprctrm = @cur_ftyprctrm_ext and  cip_trantrm = @cur_trantrm_ext 

 

if @cur_count_ext > 1 
begin 

 

if exists(select * from #CUITMPRC_EXT tint
	left join CUITMPRC prc (nolock)  on 
	prc.cip_cocde = @cur_cocde_ext and  prc.cip_cusno = @cur_cusno_ext and  prc.cip_seccus = @cur_seccus_ext and 
	prc.cip_itmno = @cur_itmno_ext and prc.cip_venno = @cur_venno_ext and prc.cip_prdven = @cur_prdven_ext and 
	prc.cip_colcde = @cur_colcde_ext and  prc.cip_untcde = @cur_untcde_ext and  prc.cip_conftr = @cur_conftr_ext and  
	prc.cip_inrqty = @cur_inrqty_ext and prc.cip_mtrqty = @cur_mtrqty_ext and  prc.cip_hkprctrm = @cur_hkprctrm_ext and 
	prc.cip_ftyprctrm = @cur_ftyprctrm_ext and  prc.cip_trantrm = @cur_trantrm_ext and prc.cip_upddat = @cur_upddat_ext
	where 
	tint.cip_cocde = @cur_cocde_ext and  tint.cip_cusno = @cur_cusno_ext and  tint.cip_seccus = @cur_seccus_ext and 
	tint.cip_itmno = @cur_itmno_ext and tint.cip_venno = @cur_venno_ext and tint.cip_prdven = @cur_prdven_ext and 
	tint.cip_colcde = @cur_colcde_ext and  tint.cip_untcde = @cur_untcde_ext and  tint.cip_conftr = @cur_conftr_ext and  
	tint.cip_inrqty = @cur_inrqty_ext and tint.cip_mtrqty = @cur_mtrqty_ext and  tint.cip_hkprctrm = @cur_hkprctrm_ext and 
	tint.cip_ftyprctrm = @cur_ftyprctrm_ext and  tint.cip_trantrm = @cur_trantrm_ext and tint.cip_upddat = @cur_upddat_ext and 
	@sod_credat between prc.cip_effdat and prc.cip_expdat )
	
begin 

delete #CUITMPRC_EXT from  #CUITMPRC_EXT tint
left join CUITMPRC prc (nolock) on 
prc.cip_cocde = @cur_cocde_ext and  prc.cip_cusno = @cur_cusno_ext and  prc.cip_seccus = @cur_seccus_ext and 
prc.cip_itmno = @cur_itmno_ext and prc.cip_venno = @cur_venno_ext and prc.cip_prdven = @cur_prdven_ext and 
prc.cip_colcde = @cur_colcde_ext and  prc.cip_untcde = @cur_untcde_ext and  prc.cip_conftr = @cur_conftr_ext and  
prc.cip_inrqty = @cur_inrqty_ext and prc.cip_mtrqty = @cur_mtrqty_ext and  prc.cip_hkprctrm = @cur_hkprctrm_ext and 
prc.cip_ftyprctrm = @cur_ftyprctrm_ext and  prc.cip_trantrm = @cur_trantrm_ext and prc.cip_upddat = tint.cip_upddat
where
tint.cip_cocde = @cur_cocde_ext and  tint.cip_cusno = @cur_cusno_ext and  tint.cip_seccus = @cur_seccus_ext and 
tint.cip_itmno = @cur_itmno_ext and tint.cip_venno = @cur_venno_ext and tint.cip_prdven = @cur_prdven_ext and 
tint.cip_colcde = @cur_colcde_ext and  tint.cip_untcde = @cur_untcde_ext and  tint.cip_conftr = @cur_conftr_ext and  
tint.cip_inrqty = @cur_inrqty_ext and tint.cip_mtrqty = @cur_mtrqty_ext and  tint.cip_hkprctrm = @cur_hkprctrm_ext and 
tint.cip_ftyprctrm = @cur_ftyprctrm_ext and  tint.cip_trantrm = @cur_trantrm_ext  and 
@sod_credat not between prc.cip_effdat and prc.cip_expdat

end 
end 

fetch next from cur_EXT into 
		 @cur_cocde_ext, @cur_cusno_ext, @cur_seccus_ext, @cur_itmno_ext, @cur_venno_ext,
		@cur_prdven_ext, @cur_colcde_ext, @cur_untcde_ext, @cur_conftr_ext, @cur_inrqty_ext,
		@cur_mtrqty_ext, @cur_hkprctrm_ext, @cur_ftyprctrm_ext, @cur_trantrm_ext , @cur_upddat_ext
end

close cur_EXT
deallocate cur_EXT


	if ltrim(rtrim(@cis_seccus)) = ''
	begin
		insert into #RESULT
		select	cis_cocde,
			cis_cusno,
			cis_seccus,
			cis_itmno,
			cis_itmdsc,
			cis_itmventyp,
			cis_cusitm,
			cis_colcde,
			cis_coldsc,
			cis_cuscol,
			cih.cip_venno,
			cih.cip_prdven,
			cis_cusven,
			cis_tradeven,
			cis_examven,
			cis_untcde,
			cis_inrqty,
			cis_mtrqty,
			cis_cft = case ResultStatus
					when 'N' then isnull(ipi_cft,0)
					when 'A' then isnull(ipi_cft,0)
					when 'H' then isnull(ipi_cft,0)
					when 'HA' then isnull(ipi_cft,0)
					else 0 end,
			cis_cbm = case ResultStatus
					when 'N' then isnull(ipi_cbm,0)
					when 'A' then isnull(ipi_cbm,0)
					when 'H' then isnull(ipi_cbm,0)
					when 'HA' then isnull(ipi_cbm,0)
					else 0 end,
			cis_refdoc,
			cis_docdat,
			cis_qutno,
			cis_qutseq,
			cih.cip_cus1no,
			cih.cip_cus2no,
			cih.cip_ftyprctrm,
			cih.cip_hkprctrm,
			cih.cip_trantrm,
			cih.cip_effdat,
			cih.cip_expdat,
			cis_cussku,
			cih.cip_fcurcde,
			cih.cip_ftycst,
			cih.cip_bomcst,
			cih.cip_ftyprc,
			cih.cip_curcde,
			cih.cip_muminprc as 'cip_minprc',
			cih.cip_basprc,
			cis_ordqty,
			cih.cip_adjprc as 'cis_selprc',
			cis_hrmcde,
			cis_dtyrat, 
			cis_dept,
			cis_typcode,
			cis_code1,
			cis_code2,
			cis_code3,
			cis_cususdcur,
			cis_cususd,
			cis_cuscadcur,
			cis_cuscad,
			cast(cis_colcde as nvarchar(30)) + ' / ' + cast(cis_untcde as nvarchar(6)) + ' / ' + 
				cast(cis_inrqty as nvarchar(10)) + ' / ' + cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
				cast(Case when ipi_cft = 0 or ipi_cft is null then isnull(ipi_cft,cis_cft) 
					else ipi_cft end as nvarchar(10)) + ' / ' +
				cast(Case when ipi_cbm = 0 or ipi_cbm is null then isnull(ipi_cbm,cis_cbm)
					else ipi_cbm end as nvarchar(10)) + ' / ' +
				cis_ftyprctrm + ' / ' + cis_hkprctrm + ' / ' + cis_trantrm as 'cis_colpck',
			cis_inrdin,
			cis_inrwin,
			cis_inrhin,
			cis_mtrdin,
			cis_mtrwin,
			cis_mtrhin,
			cis_inrdcm,
			cis_inrwcm,
			cis_inrhcm,
			cis_mtrdcm,
			cis_mtrwcm,
			cis_mtrhcm,
			case ResultStatus
				when 'N' then
					Case ibi_itmsts
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'A' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'H' then 'N/A'
				when 'HA' then 'N/A'		
				else 'MISSING'
				end as 'ibi_itmsts',
			isnull(ibi_typ,'N/A') as 'ibi_typ',
			cih.cip_qutdat,
			cih.cip_imqutdat,
			cis_creusr,
			cis_updusr,
			cis_credat,
			cis_upddat,
			cast(cis_timstp as int ) as 'cis_timstp',
			case ResultStatus
				when 'H' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'HA' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'N' then 'N/A'
				when 'A' then 'N/A'
				else 'N/A'
				end as 'h_ibi_itmsts',
			case ResultStatus
				when 'H' then isnull(ibi_typ,'N/A')
				when 'HA' then isnull(ibi_typ,'N/A')
				else 'N/A'
				end as 'h_ibi_typ',
			'N/A' as 'h_imu_bcurcde',
			0 as 'h_imu_basprc',
			cis_pckitr,
			case ResultStatus
				when 'N' then isnull(cis_tirtyp,'0') 
				when 'A' then isnull(cis_tirtyp,'0') 
				else '0'
				end as 'cis_tirtyp',
			case ResultStatus
				when 'H' then isnull(cis_tirtyp,'2') 
				when 'HA' then isnull(cis_tirtyp,'2') 
				else '2'
				end as 'h_cis_tirtyp',
			isnull(icf_colcde , '@#') as 'icf_colcde',
			ibi_venno , 
			ibi_alsitmno , 
			ibi_alscolcde ,
			cis_conftr,
			cis_contopc,
			cis_pcprc,
			isnull(ibi_ftytmp,'') as 'ibi_ftytmp',
			isnull(cis_cusstyno,'') as 'cis_cusstyno',
			'' as 'imu_std',
			ivi_venitm,
			vbi_vensts,
			cis_moq,
			cis_moqunttyp,
			cis_moa,
			cis_season,
			cis_year,
			cip_latest,
			tmp.cip_effcpo,
			cih.cip_markup,
			cih.cip_mumin,
			cih.cip_mrkprc,
			cih.cip_muminprc,
			cih.cip_commsn,
			cih.cip_itmcom,
			cih.cip_pckcst,
			cih.cip_stdprc,
			cis_name_f1,
			cis_dsc_f1,
			cis_name_f2,
			cis_dsc_f2,
			cis_name_f3,
			cis_dsc_f3,
			ibi_chndsc as 'cis_itmchidsc'
		from	CUITMPRC cih (nolock)
			join #CUITMPRC_EXT tmp on
				tmp.cip_cocde = cih.cip_cocde and
				tmp.cip_cusno = cih.cip_cusno and
				tmp.cip_seccus = cih.cip_seccus and
				tmp.cip_itmno = cih.cip_itmno and
				tmp.cip_colcde = cih.cip_colcde and
				tmp.cip_untcde = cih.cip_untcde and
				tmp.cip_inrqty = cih.cip_inrqty and
				tmp.cip_mtrqty = cih.cip_mtrqty and
				tmp.cip_hkprctrm = cih.cip_hkprctrm and
				tmp.cip_ftyprctrm = cih.cip_ftyprctrm and
				tmp.cip_trantrm = cih.cip_trantrm and
				tmp.cip_upddat = cih.cip_upddat
			left join CUITMHIS (nolock) on
				cis_cocde = cih.cip_cocde and
				cis_cusno = cih.cip_cusno and
				cis_seccus = cih.cip_seccus and
				cis_itmno = cih.cip_itmno and
				cis_colcde = cih.cip_colcde and
				cis_untcde = cih.cip_untcde and
				cis_inrqty = cih.cip_inrqty and
				cis_mtrqty = cih.cip_mtrqty and
				cis_conftr = cih.cip_conftr and
				cis_hkprctrm = cih.cip_hkprctrm and
				cis_ftyprctrm = cih.cip_ftyprctrm and
				cis_trantrm = cih.cip_trantrm
			left join IMVENINF (nolock) on
				ivi_itmno = cih.cip_itmno and
				ivi_venno = cih.cip_prdven
			left join VNBASINF (nolock) on
				vbi_venno = cih.cip_prdven
			left join #IM_EXT on
				(ibi_itmno = @cis_itmno  or ibi_alsitmno = @cis_itmno) and
				ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_colcde)) and
				cis_untcde = ipi_pckunt and
				cis_inrqty = ipi_inrqty and
				cis_mtrqty = ipi_mtrqty and
				cis_conftr = ipi_conftr and 
				cis_cft = ipi_cft and 
				cis_cbm = ipi_cbm --12-17-2014 BN FIX
		where	ivi_def = 'Y' and
			cis_itmno in(	select ibi.ibi_itmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno or (ibi.ibi_alsitmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD')
					UNION
					select ibi.ibi_alsitmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD'
					) and
			cis_cusno in (	select cbi_cusno from CUBASINF (nolock)
					where (cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and cbi_cusno  <> ''
				   	UNION
				   	select cbi_cusali from CUBASINF (nolock)
					where cbi_cusno = @cis_cusno and cbi_cusali <> '' ) and
			cis_seccus = ''
		order by cis_colcde, cis_untcde, cis_inrqty, cis_mtrqty, cis_conftr desc, cis_ftyprctrm, cis_hkprctrm, cis_trantrm
	end
	else
	begin
		insert into #RESULT
		select	cis_cocde,
			cis_cusno,
			cis_seccus,
			cis_itmno,
			cis_itmdsc,
			cis_itmventyp,
			cis_cusitm,
			cis_colcde,
			cis_coldsc,
			cis_cuscol,
			cih.cip_venno,
			cih.cip_prdven,
			cis_cusven,
			cis_tradeven,
			cis_examven,
			cis_untcde,
			cis_inrqty,
			cis_mtrqty,
			cis_cft = case ResultStatus
					when 'N' then isnull(ipi_cft,0)
					when 'A' then isnull(ipi_cft,0)
					when 'H' then isnull(ipi_cft,0)
					when 'HA' then isnull(ipi_cft,0)
					else 0 end,
			cis_cbm = case ResultStatus
					when 'N' then isnull(ipi_cbm,0)
					when 'A' then isnull(ipi_cbm,0)
					when 'H' then isnull(ipi_cbm,0)
					when 'HA' then isnull(ipi_cbm,0)
					else 0 end,
			cis_refdoc,
			cis_docdat,
			cis_qutno,
			cis_qutseq,
			cih.cip_cus1no,
			cih.cip_cus2no,
			cih.cip_ftyprctrm,
			cih.cip_hkprctrm,
			cih.cip_trantrm,
			cih.cip_effdat,
			cih.cip_expdat,
			cis_cussku,
			cih.cip_fcurcde,
			cih.cip_ftycst,
			cih.cip_bomcst,
			cih.cip_ftyprc,
			cih.cip_curcde,
			cih.cip_muminprc as 'cip_minprc',
			cih.cip_basprc,
			cis_ordqty,
			cih.cip_adjprc as 'cis_selprc',
			cis_hrmcde,
			cis_dtyrat, 
			cis_dept,
			cis_typcode,
			cis_code1,
			cis_code2,
			cis_code3,
			cis_cususdcur,
			cis_cususd,
			cis_cuscadcur,
			cis_cuscad,
			cast(cis_colcde as nvarchar(30)) + ' / ' + cast(cis_untcde as nvarchar(6)) + ' / ' + 
				cast(cis_inrqty as nvarchar(10)) + ' / ' + cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
				cast(Case when ipi_cft = 0 or ipi_cft is null then isnull(ipi_cft,cis_cft) 
					else ipi_cft end as nvarchar(10)) + ' / ' +
				cast(Case when ipi_cbm = 0 or ipi_cbm is null then isnull(ipi_cbm,cis_cbm)
					else ipi_cbm end as nvarchar(10)) + ' / ' +
				cis_ftyprctrm + ' / ' + cis_hkprctrm + ' / ' + cis_trantrm as 'cis_colpck',
			cis_inrdin,
			cis_inrwin,
			cis_inrhin,
			cis_mtrdin,
			cis_mtrwin,
			cis_mtrhin,
			cis_inrdcm,
			cis_inrwcm,
			cis_inrhcm,
			cis_mtrdcm,
			cis_mtrwcm,
			cis_mtrhcm,
			case ResultStatus
				when 'N' then
					Case ibi_itmsts
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'A' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'H' then 'N/A'
				when 'HA' then 'N/A'		
				else 'MISSING'
				end as 'ibi_itmsts',
			isnull(ibi_typ,'N/A') as 'ibi_typ',
			cih.cip_qutdat,
			cih.cip_imqutdat,
			cis_creusr,
			cis_updusr,
			cis_credat,
			cis_upddat,
			cast(cis_timstp as int ) as 'cis_timstp',
			case ResultStatus
				when 'H' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'HA' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'N' then 'N/A'
				when 'A' then 'N/A'
				else 'N/A'
				end as 'h_ibi_itmsts',
			case ResultStatus
				when 'H' then isnull(ibi_typ,'N/A')
				when 'HA' then isnull(ibi_typ,'N/A')
				else 'N/A'
				end as 'h_ibi_typ',
			'N/A' as 'h_imu_bcurcde',
			0 as 'h_imu_basprc',
			cis_pckitr,
			case ResultStatus
				when 'N' then isnull(cis_tirtyp,'0') 
				when 'A' then isnull(cis_tirtyp,'0') 
				else '0'
				end as 'cis_tirtyp',
			case ResultStatus
				when 'H' then isnull(cis_tirtyp,'2') 
				when 'HA' then isnull(cis_tirtyp,'2') 
				else '2'
				end as 'h_cis_tirtyp',
			isnull(icf_colcde , '@#') as 'icf_colcde',
			ibi_venno , 
			ibi_alsitmno , 
			ibi_alscolcde ,
			cis_conftr,
			cis_contopc,
			cis_pcprc,
			isnull(ibi_ftytmp,'') as 'ibi_ftytmp',
			isnull(cis_cusstyno,'') as 'cis_cusstyno',
			'' as 'imu_std',
			ivi_venitm,
			vbi_vensts,
			cis_moq,
			cis_moqunttyp,
			cis_moa,
			cis_season,
			cis_year,
			cip_latest,
			tmp.cip_effcpo,
			cih.cip_markup,
			cih.cip_mumin,
			cih.cip_mrkprc,
			cih.cip_muminprc,
			cih.cip_commsn,
			cih.cip_itmcom,
			cih.cip_pckcst,
			cih.cip_stdprc,
			cis_name_f1,
			cis_dsc_f1,
			cis_name_f2,
			cis_dsc_f2,
			cis_name_f3,
			cis_dsc_f3,
			ibi_chndsc as 'cis_itmchidsc'
		from	CUITMPRC cih (nolock)
			join #CUITMPRC_EXT tmp on
				tmp.cip_cocde = cih.cip_cocde and
				tmp.cip_cusno = cih.cip_cusno and
				tmp.cip_seccus = cih.cip_seccus and
				tmp.cip_itmno = cih.cip_itmno and
				tmp.cip_colcde = cih.cip_colcde and
				tmp.cip_untcde = cih.cip_untcde and
				tmp.cip_inrqty = cih.cip_inrqty and
				tmp.cip_mtrqty = cih.cip_mtrqty and
				tmp.cip_hkprctrm = cih.cip_hkprctrm and
				tmp.cip_ftyprctrm = cih.cip_ftyprctrm and
				tmp.cip_trantrm = cih.cip_trantrm and
				tmp.cip_upddat = cih.cip_upddat
			left join CUITMHIS (nolock) on
				cis_cocde = cih.cip_cocde and
				cis_cusno = cih.cip_cusno and
				cis_seccus = cih.cip_seccus and
				cis_itmno = cih.cip_itmno and
				cis_colcde = cih.cip_colcde and
				cis_untcde = cih.cip_untcde and
				cis_inrqty = cih.cip_inrqty and
				cis_mtrqty = cih.cip_mtrqty and
				cis_conftr = cih.cip_conftr and
				cis_hkprctrm = cih.cip_hkprctrm and
				cis_ftyprctrm = cih.cip_ftyprctrm and
				cis_trantrm = cih.cip_trantrm
			left join IMVENINF (nolock) on
				ivi_itmno = cih.cip_itmno and
				ivi_venno = cih.cip_prdven
			left join VNBASINF (nolock) on
				vbi_venno = cih.cip_prdven
			left join #IM_EXT on
				(ibi_itmno = @cis_itmno  or ibi_alsitmno = @cis_itmno) and
				ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_colcde)) and
				cis_untcde = ipi_pckunt and
				cis_inrqty = ipi_inrqty and
				cis_mtrqty = ipi_mtrqty and
				cis_conftr = ipi_conftr and 
				cis_cft	=    ipi_cft and 
				cis_cbm = ipi_cbm --12-17-2014 BN FIX
		where	ivi_def = 'Y' and
			cis_itmno in (select ibi.ibi_itmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno or (ibi.ibi_alsitmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD')
					UNION
					select ibi.ibi_alsitmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD'
					) and
			cis_cusno in (select cbi_cusno from CUBASINF (nolock)
					where (cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and cbi_cusno  <> ''
				   	UNION
				   	select cbi_cusali from CUBASINF (nolock)
					where cbi_cusno = @cis_cusno and cbi_cusali <> '') and
			cis_seccus in (select cbi_cusno from cubasinf (nolock)
					where (cbi_cusali = @cis_seccus or cbi_cusno = @cis_seccus) and cbi_cusno <> ''
				   	UNION
				   	select cbi_cusali from CUBASINF (nolock) where cbi_cusno = @cis_seccus and cbi_cusali  <> '')
		order by cis_colcde, cis_untcde, cis_inrqty, cis_mtrqty, cis_conftr desc, cis_ftyprctrm, cis_hkprctrm, cis_trantrm
	end

	alter table #RESULT add ibi_typ_im varchar(20)

	update #RESULT set ibi_typ_im = b.ibi_typ from #RESULT a,IMBASINF b where a.cis_itmno = b.ibi_itmno

	select	rst.*
	from	#RESULT rst
	order by cis_colcde, cis_untcde, cis_inrqty, cis_mtrqty, cis_conftr desc, cip_ftyprctrm, cip_hkprctrm, cip_trantrm

end
else
begin
	---- Create Temp IM Table  ----
	select	* 
	into	#IM_INT
	from	(
		select	ibi_itmno, 
			bas.ibi_alsitmno, 
			bas.ibi_typ, 
			bas.ibi_itmsts, 
			bas.ibi_venno, 
			icf_colcde, 
			icf_vencol, 
			ipi_pckunt, 
			ipi_inrqty, 
			ipi_mtrqty,
			ipi_conftr, 
			ipi_cft, 
			ipi_cbm, 
			'N' as'ResultStatus' , 
			isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', 
			bas.ibi_ftytmp,
			bas.ibi_chndsc
		from	IMBASINF bas (nolock)
			left join IMCOLINF (nolock) on
				icf_itmno = bas.ibi_itmno 
			left join IMPCKINF (nolock) on
				ipi_itmno = bas.ibi_itmno 
		where	bas.ibi_itmno = @cis_itmno and
			bas.ibi_itmsts <> 'CLO' 
		
		UNION 
		
		select	bas.ibi_itmno, 
			bas.ibi_alsitmno, 
			bas.ibi_typ, 
			bas.ibi_itmsts, 
			bas.ibi_venno, 
			icf_colcde, 
			icf_vencol, 
			ipi_pckunt, 
			ipi_inrqty, 
			ipi_mtrqty,
			ipi_conftr, 
			ipi_cft, 
			ipi_cbm, 
			'A' as'ResultStatus',
			isnull(bas.ibi_alscolcde,'') as 'ibi_alscolcde', 
			bas.ibi_ftytmp,
			bas.ibi_chndsc 
		from 	IMBASINF bas (nolock)
			left join IMBASINF old (nolock) on
				bas.ibi_alsitmno = old.ibi_itmno 
			left join IMCOLINF (nolock) on
				icf_itmno = bas.ibi_itmno 
			left join IMPCKINF (nolock) on
				ipi_itmno = bas.ibi_itmno
		where	bas.ibi_alsitmno = @cis_itmno and
			bas.ibi_itmsts <> 'CLO' and
			isnull(old.ibi_itmsts,'') <> 'OLD' 
		
		) as table_im
	
	-- Find Latest CIH Pricing for each CIH Item entry
	select	*
	into	#CUITMPRC_INT
	from	(	select	cip_cocde,		cip_cusno,		cip_seccus,
				cip_itmno,		cip_venno,		cip_prdven,
				cip_colcde,		cip_untcde,		cip_conftr,
				cip_inrqty,		cip_mtrqty,		cip_hkprctrm,
				cip_ftyprctrm, 		cip_trantrm,		max(cip_upddat) as cip_upddat,
				'N' as cip_latest,	'Y' as cip_effcpo
			from	CUITMPRC (nolock)
			where	cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and
				cip_seccus = @cis_seccus and
				@sod_credat between cip_effdat and cip_expdat
			group by cip_cocde, cip_cusno, cip_seccus, cip_itmno, cip_venno,
				cip_prdven, cip_colcde, cip_untcde, cip_conftr, cip_inrqty,
				cip_mtrqty, cip_hkprctrm, cip_ftyprctrm, cip_trantrm
			union
			select	cip_cocde,		cip_cusno,		cip_seccus,
				cip_itmno,		cip_venno,		cip_prdven,
				cip_colcde,		cip_untcde,		cip_conftr,
				cip_inrqty,		cip_mtrqty,		cip_hkprctrm,
				cip_ftyprctrm, 		cip_trantrm,		max(cip_upddat) as cip_upddat,
				'N' as cip_latest,	'N' as cip_effcpo
			from	CUITMPRC (nolock)
				join IMPRCINF (nolock) on
					imu_itmno = cip_itmno and
					imu_prdven = cip_prdven and
					imu_pckunt = cip_untcde and
					imu_inrqty = cip_inrqty and
					imu_mtrqty = cip_mtrqty and
					imu_ftyprctrm = cip_ftyprctrm and
					imu_hkprctrm = cip_hkprctrm and
					imu_trantrm = cip_trantrm and
					imu_status = 'ACT'
			where	cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and
				cip_seccus = @cis_seccus and
				--(@sod_credat < cip_expdat or @sod_credat > cip_expdat) and 
				@sod_credat <= cip_expdat and 
				@sod_credat not between cip_effdat and cip_expdat
				 --and -- Add Marco 20140730
				/*(select count(*) from CUITMPRC (nolock) where cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and cip_seccus = @cis_seccus and 
				cip_inrqty = imu_inrqty and cip_mtrqty = imu_mtrqty and 
				cip_ftyprctrm = imu_hkprctrm and cip_hkprctrm = imu_hkprctrm and
				cip_trantrm = imu_trantrm and @sod_credat between cip_effdat and cip_expdat) = 0
				and 
				(select count(*) from CUITMPRC (nolock) where cip_itmno = @cis_itmno and
				cip_cusno = @cis_cusno and cip_seccus = @cis_seccus and 
				@sod_credat between cip_effdat and cip_expdat) = 0*/
			group by cip_cocde, cip_cusno, cip_seccus, cip_itmno, cip_venno,
				cip_prdven, cip_colcde, cip_untcde, cip_conftr, cip_inrqty,
				cip_mtrqty, cip_hkprctrm, cip_ftyprctrm, cip_trantrm
		) as table_cih

	
	 

	update	#CUITMPRC_INT
	set	cip_latest = 'Y'
	from	#CUITMPRC_INT tmp
	where	(select count(*) from CUITMPRC cih (nolock) where cih.cip_cocde = tmp.cip_cocde and cih.cip_cusno = tmp.cip_cusno and 
		cih.cip_seccus = tmp.cip_seccus and cih.cip_itmno = tmp.cip_itmno and cih.cip_colcde = tmp.cip_colcde and 
		cih.cip_untcde = tmp.cip_untcde and cih.cip_conftr = tmp.cip_conftr and cih.cip_inrqty = tmp.cip_inrqty and
		cih.cip_mtrqty = tmp.cip_mtrqty and cih.cip_hkprctrm = tmp.cip_hkprctrm and cih.cip_ftyprctrm = tmp.cip_ftyprctrm and
		cih.cip_trantrm = tmp.cip_trantrm and cih.cip_upddat > tmp.cip_upddat) = 0

	


declare @cur_cocde nvarchar(6)
declare @cur_cusno nvarchar(6)
declare @cur_seccus nvarchar(6)
declare @cur_itmno nvarchar(20)
declare @cur_venno nvarchar(10)
declare @cur_prdven nvarchar(10)
declare @cur_colcde nvarchar(30)
declare @cur_untcde nvarchar(6)
declare @cur_conftr numeric(18,0)
declare @cur_inrqty int
declare @cur_mtrqty int
declare @cur_hkprctrm nvarchar(10)
declare @cur_ftyprctrm nvarchar(10)
declare @cur_trantrm nvarchar(10)
declare @cur_upddat datetime
declare @cur_count int

declare cur_INT cursor
for
select distinct cip_cocde, cip_cusno, cip_seccus, cip_itmno, cip_venno,
		cip_prdven, cip_colcde, cip_untcde, cip_conftr, cip_inrqty,
		cip_mtrqty, cip_hkprctrm, cip_ftyprctrm, cip_trantrm,cip_upddat from #CUITMPRC_INT



open cur_INT
fetch next from cur_INT into 
		 @cur_cocde, @cur_cusno, @cur_seccus, @cur_itmno, @cur_venno,
		@cur_prdven, @cur_colcde, @cur_untcde, @cur_conftr, @cur_inrqty,
		@cur_mtrqty, @cur_hkprctrm, @cur_ftyprctrm, @cur_trantrm , @cur_upddat
		
 

while @@fetch_status = 0
begin


select @cur_count = count(*) from #CUITMPRC_INT
where cip_cocde = @cur_cocde and  cip_cusno = @cur_cusno and  cip_seccus = @cur_seccus and 
          cip_itmno = @cur_itmno and cip_venno = @cur_venno and cip_prdven = @cur_prdven and 
	 cip_colcde = @cur_colcde and  cip_untcde = @cur_untcde and  cip_conftr = @cur_conftr and  
	cip_inrqty = @cur_inrqty and cip_mtrqty = @cur_mtrqty and  cip_hkprctrm = @cur_hkprctrm and 
	 cip_ftyprctrm = @cur_ftyprctrm and  cip_trantrm = @cur_trantrm 

 

if @cur_count > 1 
begin 

 

if exists(select * from #CUITMPRC_INT tint
	left join CUITMPRC prc (nolock)  on 
	prc.cip_cocde = @cur_cocde and  prc.cip_cusno = @cur_cusno and  prc.cip_seccus = @cur_seccus and 
	prc.cip_itmno = @cur_itmno and prc.cip_venno = @cur_venno and prc.cip_prdven = @cur_prdven and 
	prc.cip_colcde = @cur_colcde and  prc.cip_untcde = @cur_untcde and  prc.cip_conftr = @cur_conftr and  
	prc.cip_inrqty = @cur_inrqty and prc.cip_mtrqty = @cur_mtrqty and  prc.cip_hkprctrm = @cur_hkprctrm and 
	prc.cip_ftyprctrm = @cur_ftyprctrm and  prc.cip_trantrm = @cur_trantrm and prc.cip_upddat = @cur_upddat
	where 
	tint.cip_cocde = @cur_cocde and  tint.cip_cusno = @cur_cusno and  tint.cip_seccus = @cur_seccus and 
	tint.cip_itmno = @cur_itmno and tint.cip_venno = @cur_venno and tint.cip_prdven = @cur_prdven and 
	tint.cip_colcde = @cur_colcde and  tint.cip_untcde = @cur_untcde and  tint.cip_conftr = @cur_conftr and  
	tint.cip_inrqty = @cur_inrqty and tint.cip_mtrqty = @cur_mtrqty and  tint.cip_hkprctrm = @cur_hkprctrm and 
	tint.cip_ftyprctrm = @cur_ftyprctrm and  tint.cip_trantrm = @cur_trantrm and tint.cip_upddat = @cur_upddat and 
	@sod_credat between prc.cip_effdat and prc.cip_expdat )
	
begin 

delete #CUITMPRC_INT from  #CUITMPRC_INT tint
left join CUITMPRC prc (nolock) on 
prc.cip_cocde = @cur_cocde and  prc.cip_cusno = @cur_cusno and  prc.cip_seccus = @cur_seccus and 
prc.cip_itmno = @cur_itmno and prc.cip_venno = @cur_venno and prc.cip_prdven = @cur_prdven and 
prc.cip_colcde = @cur_colcde and  prc.cip_untcde = @cur_untcde and  prc.cip_conftr = @cur_conftr and  
prc.cip_inrqty = @cur_inrqty and prc.cip_mtrqty = @cur_mtrqty and  prc.cip_hkprctrm = @cur_hkprctrm and 
prc.cip_ftyprctrm = @cur_ftyprctrm and  prc.cip_trantrm = @cur_trantrm and prc.cip_upddat = tint.cip_upddat
where
tint.cip_cocde = @cur_cocde and  tint.cip_cusno = @cur_cusno and  tint.cip_seccus = @cur_seccus and 
tint.cip_itmno = @cur_itmno and tint.cip_venno = @cur_venno and tint.cip_prdven = @cur_prdven and 
tint.cip_colcde = @cur_colcde and  tint.cip_untcde = @cur_untcde and  tint.cip_conftr = @cur_conftr and  
tint.cip_inrqty = @cur_inrqty and tint.cip_mtrqty = @cur_mtrqty and  tint.cip_hkprctrm = @cur_hkprctrm and 
tint.cip_ftyprctrm = @cur_ftyprctrm and  tint.cip_trantrm = @cur_trantrm  and 
@sod_credat not between prc.cip_effdat and prc.cip_expdat

end 
end 

fetch next from cur_INT into 
		 @cur_cocde, @cur_cusno, @cur_seccus, @cur_itmno, @cur_venno,
		@cur_prdven, @cur_colcde, @cur_untcde, @cur_conftr, @cur_inrqty,
		@cur_mtrqty, @cur_hkprctrm, @cur_ftyprctrm, @cur_trantrm , @cur_upddat
end

close cur_INT
deallocate cur_INT	



	
	--if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = '#RESULT') drop table #RESULT

	if ltrim(rtrim(@cis_seccus)) = ''
	begin
		insert into #RESULT
		select	cis_cocde,
			cis_cusno,
			cis_seccus,
			cis_itmno,
			cis_itmdsc,
			cis_itmventyp,
			cis_cusitm,
			cis_colcde,
			cis_coldsc,
			cis_cuscol,
			cih.cip_venno,
			cih.cip_prdven,
			cis_cusven,
			cis_tradeven,
			cis_examven,
			cis_untcde,
			cis_inrqty,
			cis_mtrqty,
			cis_cft = case ResultStatus
					when 'N' then isnull(ipi_cft,0)
					when 'A' then isnull(ipi_cft,0)
					when 'H' then isnull(ipi_cft,0)
					when 'HA' then isnull(ipi_cft,0)
					else 0 end,
			cis_cbm = case ResultStatus
					when 'N' then isnull(ipi_cbm,0)
					when 'A' then isnull(ipi_cbm,0)
					when 'H' then isnull(ipi_cbm,0)
					when 'HA' then isnull(ipi_cbm,0)
					else 0 end,
			cis_refdoc,
			cis_docdat,
			cis_qutno,
			cis_qutseq,
			cih.cip_cus1no,
			cih.cip_cus2no,
			cih.cip_ftyprctrm,
			cih.cip_hkprctrm,
			cih.cip_trantrm,
			cih.cip_effdat,
			cih.cip_expdat,
			cis_cussku,
			cih.cip_fcurcde,
			cih.cip_ftycst,
			cih.cip_bomcst,
			cih.cip_ftyprc,
			cih.cip_curcde,
			cih.cip_muminprc as 'cip_minprc',
			cih.cip_basprc,
			cis_ordqty,
			cih.cip_adjprc as 'cis_selprc',
			cis_hrmcde,
			cis_dtyrat, 
			cis_dept,
			cis_typcode,
			cis_code1,
			cis_code2,
			cis_code3,
			cis_cususdcur,
			cis_cususd,
			cis_cuscadcur,
			cis_cuscad,
			cast(cis_colcde as nvarchar(30)) + ' / ' + cast(cis_untcde as nvarchar(6)) + ' / ' + 
				cast(cis_inrqty as nvarchar(10)) + ' / ' + cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
				cast(Case when ipi_cft = 0 or ipi_cft is null then isnull(ipi_cft,cis_cft) 
					else ipi_cft end as nvarchar(10)) + ' / ' +
				cast(Case when ipi_cbm = 0 or ipi_cbm is null then isnull(ipi_cbm,cis_cbm)
	--				else ipi_cbm end as nvarchar(10)) as 'cis_colpck',
					else ipi_cbm end as nvarchar(10)) + ' / ' +
				cis_ftyprctrm + ' / ' + cis_hkprctrm + ' / ' + cis_trantrm as 'cis_colpck',
			cis_inrdin,
			cis_inrwin,
			cis_inrhin,
			cis_mtrdin,
			cis_mtrwin,
			cis_mtrhin,
			cis_inrdcm,
			cis_inrwcm,
			cis_inrhcm,
			cis_mtrdcm,
			cis_mtrwcm,
			cis_mtrhcm,
			case ResultStatus
				when 'N' then
					Case ibi_itmsts
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'A' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'H' then 'N/A'
				when 'HA' then 'N/A'		
				else 'MISSING'
				end as 'ibi_itmsts',
			isnull(ibi_typ,'N/A') as 'ibi_typ',
			cih.cip_qutdat,
			cih.cip_imqutdat,
			cis_creusr,
			cis_updusr,
			cis_credat,
			cis_upddat,
			cast(cis_timstp as int ) as 'cis_timstp',
			case ResultStatus
				when 'H' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'HA' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'N' then 'N/A'
				when 'A' then 'N/A'
				else 'N/A'
				end as 'h_ibi_itmsts',
			case ResultStatus
				when 'H' then isnull(ibi_typ,'N/A')
				when 'HA' then isnull(ibi_typ,'N/A')
				else 'N/A'
				end as 'h_ibi_typ',
			'N/A' as 'h_imu_bcurcde',
			0 as 'h_imu_basprc',
			cis_pckitr,
			case ResultStatus
				when 'N' then isnull(cis_tirtyp,'0') 
				when 'A' then isnull(cis_tirtyp,'0') 
				else '0'
				end as 'cis_tirtyp',
			case ResultStatus
				when 'H' then isnull(cis_tirtyp,'2') 
				when 'HA' then isnull(cis_tirtyp,'2') 
				else '2'
				end as 'h_cis_tirtyp',
			isnull(icf_colcde , '@#') as 'icf_colcde',
			ibi_venno , 
			ibi_alsitmno , 
			ibi_alscolcde ,
			cis_conftr,
			cis_contopc,
			cis_pcprc,
			isnull(ibi_ftytmp,'') as 'ibi_ftytmp',
			isnull(cis_cusstyno,'') as 'cis_cusstyno',
			'' as 'imu_std',
			ivi_venitm,
			vbi_vensts,
			cis_moq,
			cis_moqunttyp,
			cis_moa,
			cis_season,
			cis_year,
			cip_latest,
			tmp.cip_effcpo,
			cih.cip_markup,
			cih.cip_mumin,
			cih.cip_mrkprc,
			cih.cip_muminprc,
			cih.cip_commsn,
			cih.cip_itmcom,
			cih.cip_pckcst,
			cih.cip_stdprc,
			cis_name_f1,
			cis_dsc_f1,
			cis_name_f2,
			cis_dsc_f2,
			cis_name_f3,
			cis_dsc_f3,
			case isnull(cis_itmchidsc, '') when '' then ibi_chndsc else cis_itmchidsc end as 'cis_itmchidsc' 
		from	CUITMPRC cih (nolock)
			join #CUITMPRC_INT tmp on
				tmp.cip_cocde = cih.cip_cocde and
				tmp.cip_cusno = cih.cip_cusno and
				tmp.cip_seccus = cih.cip_seccus and
				tmp.cip_itmno = cih.cip_itmno and
				tmp.cip_venno = cih.cip_venno and
				tmp.cip_prdven = cih.cip_prdven and
				tmp.cip_colcde = cih.cip_colcde and
				tmp.cip_untcde = cih.cip_untcde and
				tmp.cip_inrqty = cih.cip_inrqty and
				tmp.cip_mtrqty = cih.cip_mtrqty and
				tmp.cip_hkprctrm = cih.cip_hkprctrm and
				tmp.cip_ftyprctrm = cih.cip_ftyprctrm and
				tmp.cip_trantrm = cih.cip_trantrm and
				tmp.cip_upddat = cih.cip_upddat
			left join CUITMHIS (nolock) on
				cis_cocde = cih.cip_cocde and
				cis_cusno = cih.cip_cusno and
				cis_seccus = cih.cip_seccus and
				cis_itmno = cih.cip_itmno and
				cis_colcde = cih.cip_colcde and
				cis_untcde = cih.cip_untcde and
				cis_inrqty = cih.cip_inrqty and
				cis_mtrqty = cih.cip_mtrqty and
				cis_conftr = cih.cip_conftr and
				cis_hkprctrm = cih.cip_hkprctrm and
				cis_ftyprctrm = cih.cip_ftyprctrm and
				cis_trantrm = cih.cip_trantrm
			left join IMVENINF (nolock) on
				ivi_itmno = cih.cip_itmno and
				ivi_venno = cih.cip_prdven
			left join VNBASINF (nolock) on
				vbi_venno = cih.cip_prdven
			left join #IM_INT on
				(ibi_itmno = @cis_itmno  or ibi_alsitmno = @cis_itmno) and
				ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_colcde)) and
				cis_untcde = ipi_pckunt and
				cis_inrqty = ipi_inrqty and
				cis_mtrqty = ipi_mtrqty and
				cis_conftr = ipi_conftr  and 
				cis_cft	=    ipi_cft and 
				cis_cbm = ipi_cbm --12-17-2014 BN FIX
		where	cis_itmno in(	select ibi.ibi_itmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno or (ibi.ibi_alsitmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD')
					UNION
					select ibi.ibi_alsitmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD'
					) and
			cis_cusno in (	select cbi_cusno from CUBASINF (nolock)
					where (cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and cbi_cusno  <> ''
				   	UNION
				   	select cbi_cusali from CUBASINF (nolock)
					where cbi_cusno = @cis_cusno and cbi_cusali <> '' ) and
			cis_seccus = ''


	end
	else
	begin
		insert into #RESULT
		select	cis_cocde,
			cis_cusno,
			cis_seccus,
			cis_itmno,
			cis_itmdsc,
			cis_itmventyp,
			cis_cusitm,
			cis_colcde,
			cis_coldsc,
			cis_cuscol,
			cih.cip_venno,
			cih.cip_prdven,
			cis_cusven,
			cis_tradeven,
			cis_examven,
			cis_untcde,
			cis_inrqty,
			cis_mtrqty,
			cis_cft = case ResultStatus
					when 'N' then isnull(ipi_cft,0)
					when 'A' then isnull(ipi_cft,0)
					when 'H' then isnull(ipi_cft,0)
					when 'HA' then isnull(ipi_cft,0)
					else 0 end,
			cis_cbm = case ResultStatus
					when 'N' then isnull(ipi_cbm,0)
					when 'A' then isnull(ipi_cbm,0)
					when 'H' then isnull(ipi_cbm,0)
					when 'HA' then isnull(ipi_cbm,0)
					else 0 end,
			cis_refdoc,
			cis_docdat,
			cis_qutno,
			cis_qutseq,
			cih.cip_cus1no,
			cih.cip_cus2no,
			cih.cip_ftyprctrm,
			cih.cip_hkprctrm,
			cih.cip_trantrm,
			cih.cip_effdat,
			cih.cip_expdat,
			cis_cussku,
			cih.cip_fcurcde,
			cih.cip_ftycst,
			cih.cip_bomcst,
			cih.cip_ftyprc,
			cih.cip_curcde,
			cih.cip_muminprc as 'cip_minprc',
			cih.cip_basprc,
			cis_ordqty,
			cih.cip_adjprc as 'cis_selprc',
			cis_hrmcde,
			cis_dtyrat, 
			cis_dept,
			cis_typcode,
			cis_code1,
			cis_code2,
			cis_code3,
			cis_cususdcur,
			cis_cususd,
			cis_cuscadcur,
			cis_cuscad,
			cast(cis_colcde as nvarchar(30)) + ' / ' + cast(cis_untcde as nvarchar(6)) + ' / ' + 
				cast(cis_inrqty as nvarchar(10)) + ' / ' + cast(cis_mtrqty as nvarchar(10)) + ' / ' + 
				cast(Case when ipi_cft = 0 or ipi_cft is null then isnull(ipi_cft,cis_cft) 
					else ipi_cft end as nvarchar(10)) + ' / ' +
				cast(Case when ipi_cbm = 0 or ipi_cbm is null then isnull(ipi_cbm,cis_cbm)
					else ipi_cbm end as nvarchar(10)) + ' / ' +
				cis_ftyprctrm + ' / ' + cis_hkprctrm + ' / ' + cis_trantrm as 'cis_colpck',
			cis_inrdin,
			cis_inrwin,
			cis_inrhin,
			cis_mtrdin,
			cis_mtrwin,
			cis_mtrhin,
			cis_inrdcm,
			cis_inrwcm,
			cis_inrhcm,
			cis_mtrdcm,
			cis_mtrwcm,
			cis_mtrhcm,
			case ResultStatus
				when 'N' then
					Case ibi_itmsts
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'A' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end
				when 'H' then 'N/A'
				when 'HA' then 'N/A'		
				else 'MISSING'
				end as 'ibi_itmsts',
			isnull(ibi_typ,'N/A') as 'ibi_typ',
			cih.cip_qutdat,
			cih.cip_imqutdat,
			cis_creusr,
			cis_updusr,
			cis_credat,
			cis_upddat,
			cast(cis_timstp as int ) as 'cis_timstp',
			case ResultStatus
				when 'H' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'HA' then
					Case ibi_itmsts 	
						when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
						else 'CMP'
					end
				when 'N' then 'N/A'
				when 'A' then 'N/A'
				else 'N/A'
				end as 'h_ibi_itmsts',
			case ResultStatus
				when 'H' then isnull(ibi_typ,'N/A')
				when 'HA' then isnull(ibi_typ,'N/A')
				else 'N/A'
				end as 'h_ibi_typ',
			'N/A' as 'h_imu_bcurcde',
			0 as 'h_imu_basprc',
			cis_pckitr,
			case ResultStatus
				when 'N' then isnull(cis_tirtyp,'0') 
				when 'A' then isnull(cis_tirtyp,'0') 
				else '0'
				end as 'cis_tirtyp',
			case ResultStatus
				when 'H' then isnull(cis_tirtyp,'2') 
				when 'HA' then isnull(cis_tirtyp,'2') 
				else '2'
				end as 'h_cis_tirtyp',
			isnull(icf_colcde , '@#') as 'icf_colcde',
			ibi_venno , 
			ibi_alsitmno , 
			ibi_alscolcde ,
			cis_conftr,
			cis_contopc,
			cis_pcprc,
			isnull(ibi_ftytmp,'') as 'ibi_ftytmp',
			isnull(cis_cusstyno,'') as 'cis_cusstyno',
			'' as 'imu_std',
			ivi_venitm,
			vbi_vensts,
			cis_moq,
			cis_moqunttyp,
			cis_moa,
			cis_season,
			cis_year,
			cip_latest,
			tmp.cip_effcpo,
			cih.cip_markup,
			cih.cip_mumin,
			cih.cip_mrkprc,
			cih.cip_muminprc,
			cih.cip_commsn,
			cih.cip_itmcom,
			cih.cip_pckcst,
			cih.cip_stdprc,
			cis_name_f1,
			cis_dsc_f1,
			cis_name_f2,
			cis_dsc_f2,
			cis_name_f3,
			cis_dsc_f3,
			case isnull(cis_itmchidsc, '') when '' then ibi_chndsc else cis_itmchidsc end as 'cis_itmchidsc' 
		from	CUITMPRC cih (nolock)
			join #CUITMPRC_INT tmp on
				tmp.cip_cocde = cih.cip_cocde and
				tmp.cip_cusno = cih.cip_cusno and
				tmp.cip_seccus = cih.cip_seccus and
				tmp.cip_itmno = cih.cip_itmno and
				tmp.cip_venno = cih.cip_venno and
				tmp.cip_prdven = cih.cip_prdven and
				tmp.cip_colcde = cih.cip_colcde and
				tmp.cip_untcde = cih.cip_untcde and
				tmp.cip_inrqty = cih.cip_inrqty and
				tmp.cip_mtrqty = cih.cip_mtrqty and
				tmp.cip_hkprctrm = cih.cip_hkprctrm and
				tmp.cip_ftyprctrm = cih.cip_ftyprctrm and
				tmp.cip_trantrm = cih.cip_trantrm and
				tmp.cip_upddat = cih.cip_upddat
			left join CUITMHIS (nolock) on
				cis_cocde = cih.cip_cocde and
				cis_cusno = cih.cip_cusno and
				cis_seccus = cih.cip_seccus and
				cis_itmno = cih.cip_itmno and
				cis_colcde = cih.cip_colcde and
				cis_untcde = cih.cip_untcde and
				cis_inrqty = cih.cip_inrqty and
				cis_mtrqty = cih.cip_mtrqty and
				cis_conftr = cih.cip_conftr and
				cis_hkprctrm = cih.cip_hkprctrm and
				cis_ftyprctrm = cih.cip_ftyprctrm and
				cis_trantrm = cih.cip_trantrm
			left join IMVENINF (nolock) on
				ivi_itmno = cih.cip_itmno and
				ivi_venno = cih.cip_prdven
			left join VNBASINF (nolock) on
				vbi_venno = cih.cip_prdven
			left join #IM_INT on
				(ibi_itmno = @cis_itmno  or ibi_alsitmno = @cis_itmno) and
				ltrim(rtrim(cis_colcde)) = ltrim(rtrim(icf_colcde)) and
				cis_untcde = ipi_pckunt and
				cis_inrqty = ipi_inrqty and
				cis_mtrqty = ipi_mtrqty and
				cis_conftr = ipi_conftr and 
				cis_cft	=    ipi_cft and 
				cis_cbm = ipi_cbm --12-17-2014 BN FIX
		where	cis_itmno in (select ibi.ibi_itmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno or (ibi.ibi_alsitmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD')
					UNION
					select ibi.ibi_alsitmno from IMBASINF ibi (nolock) 
					left join IMBASINF als (nolock) on ibi.ibi_alsitmno = als.ibi_itmno
					where ibi.ibi_itmno = @cis_itmno and isnull(als.ibi_itmsts,'') <> 'OLD'
					) and
			cis_cusno in (select cbi_cusno from CUBASINF (nolock)
					where (cbi_cusali = @cis_cusno or cbi_cusno = @cis_cusno) and cbi_cusno  <> ''
				   	UNION
				   	select cbi_cusali from CUBASINF (nolock)
					where cbi_cusno = @cis_cusno and cbi_cusali <> '') and
			cis_seccus in (select cbi_cusno from cubasinf (nolock)
					where (cbi_cusali = @cis_seccus or cbi_cusno = @cis_seccus) and cbi_cusno <> ''
				   	UNION
				   	select cbi_cusali from CUBASINF (nolock) where cbi_cusno = @cis_seccus and cbi_cusali  <> '')
	end
	
	-- Change PV to Default PV --
	update	#RESULT
	set	cip_prdven = ivi_venno
	from	#RESULT
		join IMVENINF (nolock) on
			ivi_itmno = cis_itmno and
			ivi_def = 'Y'


	alter table #RESULT add ibi_typ_im varchar(20)

	update #RESULT set ibi_typ_im = b.ibi_typ from #RESULT a,IMBASINF b where a.cis_itmno = b.ibi_itmno
	 




	-- Return Data --
	select	rst.*
	from	#RESULT rst
	where	(select count(*) from #RESULT tmp where rst.cis_cusno = tmp.cis_cusno and rst.cis_seccus = tmp.cis_seccus and 
			rst.cis_itmno = tmp.cis_itmno and rst.cis_untcde = tmp.cis_untcde and rst.cis_inrqty = tmp.cis_inrqty and
			rst.cis_mtrqty = tmp.cis_mtrqty and rst.cis_conftr = tmp.cis_conftr and rst.cis_colcde = tmp.cis_colcde and
			rst.cip_ftyprctrm = tmp.cip_ftyprctrm and rst.cip_hkprctrm = tmp.cip_hkprctrm and rst.cip_trantrm = tmp.cip_trantrm) = 1
	UNION 
	select	rst.*
	from	#RESULT rst
	where	cip_latest = 'Y' and
		(select count(*) from #RESULT tmp where rst.cis_cusno = tmp.cis_cusno and rst.cis_seccus = tmp.cis_seccus and 
			rst.cis_itmno = tmp.cis_itmno and rst.cis_untcde = tmp.cis_untcde and rst.cis_inrqty = tmp.cis_inrqty and
			rst.cis_mtrqty = tmp.cis_mtrqty and rst.cis_conftr = tmp.cis_conftr and rst.cis_colcde = tmp.cis_colcde and
			rst.cip_ftyprctrm = tmp.cip_ftyprctrm and rst.cip_hkprctrm = tmp.cip_hkprctrm and rst.cip_trantrm = tmp.cip_trantrm) > 1
	order by cis_colcde, cis_untcde, cis_inrqty, cis_mtrqty, cis_conftr desc, cip_ftyprctrm, cip_hkprctrm, cip_trantrm

end

END



GO
GRANT EXECUTE ON [dbo].[sp_select_CUITMPRC_SC] TO [ERPUSER] AS [dbo]
GO
