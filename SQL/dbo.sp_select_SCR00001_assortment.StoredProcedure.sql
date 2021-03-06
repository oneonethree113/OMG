/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_assortment]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCR00001_assortment]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_assortment]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 27/07/2003


CREATE PROCEDURE [dbo].[sp_select_SCR00001_assortment]
@cocde		nvarchar(6),	
@SCfrom		nvarchar(20),	@SCto		nvarchar(20)

AS
select
	-- SCASSINF
	sai_ordno,				sai_itmno,
	sai_assitm,				sai_assdsc,				sai_coldsc = isNull(sai_coldsc,''),
	sai_cussku = isNull(sai_cussku,''),	sai_upcean = isNull(sai_upcean,''),	sai_cusrtl,
	sai_untcde = ltrim(sai_untcde),			
	sai_cusitm,
	sai_colcde = isNull(sai_colcde,''),			
	sai_inrqty = ltrim(str(sai_inrqty,10,0)),
	sai_mtrqty = ltrim(str(sai_mtrqty,10,0)),

	-- SCORDDTL
	sod_ordseq,	

	-- SYSETINF 
	ysi_dsc

	From 	SCORDDTL, SCASSINF,SYSETINF
	WHERE	
		--sod_cocde = sai_cocde and
		sod_ordno = sai_ordno
	and	sod_ordseq = sai_ordseq
	--and	sod_cocde = ysi_cocde 
	and sai_untcde = ysi_cde and ysi_typ = '05'
	and 	sod_ordno >= @SCfrom and sod_ordno <= @SCto and sod_cocde = @cocde
	order by	sai_itmno, sai_assitm,  isNull(sai_colcde,'')


GO
GRANT EXECUTE ON [dbo].[sp_select_SCR00001_assortment] TO [ERPUSER] AS [dbo]
GO
