/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_assortment_ca]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCR00001_assortment_ca]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_assortment_ca]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









-- Checked by Allan Yuen at 27/07/2003


CREATE  PROCEDURE [dbo].[sp_select_SCR00001_assortment_ca]
@cocde		nvarchar(6),	
@SCfrom		nvarchar(20),	@SCto		nvarchar(20)
,@printcusals		nvarchar(1)
AS
select
	-- SCASSINF
	sai_ordno,				
	case when @printcusals = '1' and sod_cusstyno <> '' then sod_cusstyno else sai_itmno end as 'sai_itmno',
	sai_assitm,				sai_assdsc,				sai_coldsc = isNull(sai_coldsc,''),
	sai_cussku = isNull(sai_cussku,''),	sai_upcean = isNull(sai_upcean,''),	sai_cusrtl,
	sai_untcde = ltrim(sai_untcde),			
	sai_cusitm,
	sai_colcde = isNull(sai_colcde,''),			
	sai_inrqty = ltrim(str(sai_inrqty,10,0)),
	sai_mtrqty = ltrim(str(sai_mtrqty,10,0)),
	sai_cusstyno,

	-- SCORDDTL
	sod_ordno,
	sod_ordseq,	

	-- SYSETINF 
	ysi_dsc as 'unit'
	
	From 	SCORDDTL, SCASSINF,SYSETINF, --imcusals,
		 scordhdr
	WHERE	
		--sod_cocde = sai_cocde and
		sod_ordno = sai_ordno
	and	sod_ordno = soh_ordno
	and	sod_ordseq = sai_ordseq
	--and	sod_cocde = ysi_cocde 
	and sai_untcde = ysi_cde and ysi_typ = '05'
	and 	sod_ordno >= @SCfrom and sod_ordno <= @SCto and sod_cocde = @cocde
	--and sai_itmno *= ica_itmno and soh_cus1no *= ica_cusno and ica_apvsts = 'Y'
	order by	sai_itmno, sai_assitm,  isNull(sai_colcde,'')




GO
GRANT EXECUTE ON [dbo].[sp_select_SCR00001_assortment_ca] TO [ERPUSER] AS [dbo]
GO
