/****** Object:  StoredProcedure [dbo].[sp_select_QUR0000A_WO_S]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUR0000A_WO_S]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUR0000A_WO_S]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
 Modification History                                    
=========================================================
22 Jul 2003	Lewis To		Change ignor all system parameter company code
========================================================= */
CREATE procedure [dbo].[sp_select_QUR0000A_WO_S]

                                                                                                                                                                                                                                                       
@cocde	 nvarchar(6),
@printven	nvarchar(1),
@cftr	 nvarchar(1),
@fty	 nvarchar(20),
@showqa   nvarchar(20),
@from	 nvarchar(20),
@to	 nvarchar(20),
@sortBy		nvarchar(4)	-- By Customer Item or By Item


AS
Begin
	Select	
	                'P' as code,   	--1
	                @cocde,		
		cus.cbi_cusnam,	
		hdr.quh_cus1ad, 
		hdr.quh_cus1st, 
		cty.ysi_dsc, 
		hdr.quh_cus1zp,
		hdr.quh_cus1cp,	

		hdr.quh_qutno,	
                                cus.cbi_cusno,	--10
		hdr.quh_rvsdat,	
		hdr.quh_valdat,	
		agt.yai_fulnam,	
                                rep.ysr_dsc,	

---		Details Group by Item & Packing
		dtl.qud_itmno,	

---		No Item to be displayed if  'To be midified' is checked 
                                dtl.qud_tbm,	
		dtl.qud_cusitm,	
		dtl.qud_itmdsc,	
		dtl.qud_curcde,	

--                              if   @cftr =  '0' then orignal else convert to PC 
                               @cftr as 'cftr',	-- 20
		dtl.qud_cus1dp,	
		dum.ysi_dsc,	
                                ftr.ycf_oper,	
                                ftr.ycf_value,	
		dtl.qud_inrqty,	
		dtl.qud_mtrqty,	
		dtl.qud_cft,	
		dtl.qud_pckitr,	
                               @showqa,		
		dtl.qud_moq,	-- 30
		dtl.qud_moa,	
                                dtl.qud_colcde,	
                                dtl.qud_coldsc,	
	                dtl.qud_cusqty,	

---		For Internal User Only:
---       		If @fty = 0(Yes), then no printing on vensa, venno, venitm & ftyprc
		@fty,		
		 ven.vbi_vensna,	
		 dtl.qud_venno,	
		 dtl.qud_venitm,	-- 38

		case  dtl.qud_tbm when 'Y' then
		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(dtl.qud_ftyprc as nvarchar(17)),'.', 'D'), '0','K'), '9', 'H'),  '8', 'R') , '7', 'E'), '6', 'T'), '5', 'N'), '4', 'I'), '3', 'P'), '2', 'C'), '1', 'U')+replace(replace(dtl.qud_fcurcde,'HKD','2'),'USD','1')+ ' (' + ltrim(str(qud_qutseq)) + ')'
		else
		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(dtl.qud_ftyprc as nvarchar(17)),'.', 'D'), '0','K'), '9', 'H'),  '8', 'R') , '7', 'E'), '6', 'T'), '5', 'N'), '4', 'I'), '3', 'P'), '2', 'C'), '1', 'U')+replace(replace(dtl.qud_fcurcde,'HKD','2'),'USD','1')
		end,		--39		
                              --assortatment
                                inf.qai_assitm,	-- 40
                                inf.qai_assdsc,	
                                inf.qai_coldsc,	
                                inf.qai_cussku,	
                                inf.qai_upcean,	
                                inf.qai_cusrtl,	
                                ltrim(inf.qai_untcde),
                                dtl.qud_qutseq,	
                                inf.qai_cusitm,	
                                inf.qai_colcde,	
                                ltrim(str(inf.qai_inrqty,10,0)),  		--50
                                ltrim(str(inf.qai_mtrqty,10,0)),	

                                rtrim(dtl.qud_note),	
                                imm.ibi_imgpth,	
		prc.ysi_dsc,	
                                pay.ysi_dsc,	
		prd.yst_trmdsc,	
		fgt.yst_trmdsc,	
		Case @sortBy When 'CUST' then dtl.qud_cusitm else dtl.qud_itmno end + STR(dtl.qud_inrqty,10,0) + STR(dtl.qud_mtrqty,10, 0) + STR(dtl.qud_cft,10, 2) + dum.ysi_dsc + STR(dtl.qud_cus1dp,13,4),  --58

                               ltrim(replace(cast(imm.ibi_lnecde as nvarchar(10)), '/' ,'_')),	
                                imm.ibi_itmno,			-- 60
                                imm.ibi_venno,	
                               ltrim(replace(cast( imc.icf_colcde  as nvarchar(30)),'-','_')), 
                               ltrim(replace(cast( imo.ivi_venitm as nvarchar(20)),'/','_')),  
	              @printven				-- 64
---	Sub-report for Color Code & Color Description
From 	
QUOTNHDR hdr
left join QUOTNDTL dtl on hdr.quh_cocde = dtl.qud_cocde and hdr.quh_qutno = dtl.qud_qutno
left join CUBASINF cus on hdr.quh_cus1no = cus.cbi_cusno
left join SYSETINF cty on hdr.quh_cus1cy = cty.ysi_cde and cty.ysi_typ = '02'
left join SYSETINF prc on hdr.quh_prctrm = prc.ysi_cde and prc.ysi_typ = '03'
left join SYSETINF pay on hdr.quh_paytrm = pay.ysi_cde and pay.ysi_typ = '04'
left join SYSETINF dum on dtl.qud_untcde = dum.ysi_cde and dum.ysi_typ = '05'
left join SYAGTINF agt on hdr.quh_cusagt = agt.yai_agtcde
left join SYSALREP rep on hdr.quh_salrep = rep.ysr_code1
left join SYSMPTRM prd on hdr.quh_smpprd = prd.yst_trmcde
left join SYSMPTRM fgt on hdr.quh_smpprd = fgt.yst_trmcde
left join SYCONFTR ftr on dtl.qud_untcde = ftr.ycf_code1 and ftr.ycf_code2 = 'PC'
left join QUASSINF inf on hdr.quh_cocde = inf.qai_cocde and dtl.qud_qutno = inf.qai_qutno and dtl.qud_qutseq = inf.qai_qutseq
left join VNBASINF ven on dtl.qud_venno = ven.vbi_venno
left join IMBASINF imm on dtl.qud_itmno = imm.ibi_itmno
left join IMCOLINF imc on dtl.qud_colcde = imc.icf_colcde and dtl.qud_itmno = imc.icf_itmno
left join IMVENINF imo on dtl.qud_itmno = imo.ivi_itmno and dtl.qud_venno = imo.ivi_venno 
WHERE 	
hdr.quh_cocde = @cocde and hdr.quh_qutno >= @from and hdr.quh_qutno <= @to
and	cus.cbi_cusno is not null
and	ven.vbi_venno is not null
and	imm.ibi_itmno is not null
order by 	1, 9, 58, dtl.qud_colcde


	 
End






GO
GRANT EXECUTE ON [dbo].[sp_select_QUR0000A_WO_S] TO [ERPUSER] AS [dbo]
GO
