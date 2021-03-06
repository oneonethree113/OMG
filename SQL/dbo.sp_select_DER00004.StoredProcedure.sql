/****** Object:  StoredProcedure [dbo].[sp_select_DER00004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_DER00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_DER00004]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003


CREATE procedure [dbo].[sp_select_DER00004]

                                                                                                                                                                                                                                                       
@cocde	 nvarchar(6)

AS

Begin

-- Shipping
Select 	1,
	@cocde,
	inv.hiv_invno,
	shi.hih_shpno,
	shi.hih_issdat,
	shi.hih_rvsdat,
	shi.hih_cus1no + ' - ' + pri.cbi_cussna,
	case isnull( shi.hih_cus2no, '') when '' then '' else shi.hih_cus2no + ' - ' + sec.cbi_cussna end,
	inv.hiv_untamt,
	inv.hiv_ttlamt
             
From	SHIPGHDR shi 
	left join CUBASINF pri on shi.hih_cus1no = pri.cbi_cusno
	left join CUBASINF sec on shi.hih_cus2no = sec.cbi_cusno
, SHINVHDR inv
Where	shi.hih_cocde = inv.hiv_cocde and shi.hih_shpno = inv.hiv_shpno
and	shi.hih_shpsts = 'HLD' and shi.hih_cocde = @cocde


union
-- Sample Invoice
Select 	2,
	@cocde,
	sai.sih_invno,
	'',
	sai.sih_issdat,
	sai.sih_rvsdat,
	sai.sih_cus1no + ' - ' + pri.cbi_cussna,
	case isnull( sai.sih_cus2no, '') when '' then '' else sai.sih_cus2no + ' - ' + sec.cbi_cussna end,
	sai.sih_curcde,
	sai.sih_netamt             

From	SAINVHDR sai
left join CUBASINF pri on sai.sih_cus1no = pri.cbi_cusno
left join CUBASINF sec on sai.sih_cus2no = sec.cbi_cusno
Where
sai.sih_invsts = 'HLD' and sai.sih_cocde = @cocde

union
-- Credit /Debit Note
Select 	3,
	@cocde,
	case scd.hnh_nottyp when 'C' then '(C) ' + scd.hnh_noteno else '(D) ' + scd.hnh_noteno end,
	scd.hnh_refno,
	scd.hnh_credat,
	scd.hnh_issdat,
	scd.hnh_pricus + ' - ' + pri.cbi_cussna,
	case isnull(scd.hnh_seccus, '') when '' then '' else scd.hnh_seccus + ' - ' + sec.cbi_cussna end,
	scd.hnh_ttlunt,
	scd.hnh_ttlamt
            
From	SHCBNHDR scd
left join CUBASINF pri on scd.hnh_pricus = pri.cbi_cusno
left join CUBASINF sec on scd.hnh_seccus = sec.cbi_cusno
WHERE		
scd.hnh_notsts = 'HLD' and scd.hnh_cocde = @cocde
ORDER BY 1, 2, 3
            
End




GO
GRANT EXECUTE ON [dbo].[sp_select_DER00004] TO [ERPUSER] AS [dbo]
GO
