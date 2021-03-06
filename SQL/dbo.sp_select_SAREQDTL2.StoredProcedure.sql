/****** Object:  StoredProcedure [dbo].[sp_select_SAREQDTL2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAREQDTL2]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAREQDTL2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE  PROCEDURE [dbo].[sp_select_SAREQDTL2] 

@cocde	nvarchar(6),
@reqno	nvarchar(20)

AS

declare 	@mode 	nvarchar(3),	@cancel	nvarchar(3)

set @mode = ''

select 	@mode as 'mode',	srd_cocde ,		srd_reqno ,
	srd_reqseq ,	srd_itmno ,		case  srd_itmsts
					 	when 'CMP' then 'CMP - Active Item with complete Info.'
						when 'INC' then 'INC - Active Item with incomplete Info.'
						when 'HLD' then 'HLD - Active Item Hold by the system'
						when 'DIS' then 'DIS - Discontinue Item'
						when 'INA' then 'INA - Inactive Item'
						when 'CLO' then 'CLO - Closed (UCP Item)'
						when 'TBC' then 'TBC - To be confirmed Item'
						when 'OLD' then 'OLD - Old Item'
					end as 'srd_itmsts',
	srd_venitm ,	srd_cusitm,	srd_engdsc ,	
	isnull((case srd_chndsc
		when '' then ibi_chndsc
		else srd_chndsc end),'') as 'srd_chndsc',
			srd_vencol ,	srd_coldsc ,	
	srd_cuscol ,	srd_pckseq ,	srd_untcde ,	
	srd_inrqty ,		srd_mtrqty ,	srd_cft ,		
	srd_stkqty ,	srd_smpunt ,	srd_cusqty ,	
	srd_smpqty ,	srd_curcde ,	srd_untcde as 'srd_untcde2',
	srd_ftyprc ,		srd_ftycst, 		srd_smpftyprc ,
	srd_note ,		srd_tbm ,		srd_canflg ,
	cast(srd_timstp as int) as 'srd_timstp',
			@cancel as 'cancel',	srd_qutitmsts,	
	srd_itmtyp,		srd_colcde,		srd_qutno, 
	srd_prdven + ' - ' + vbi_vensna as 'srd_prdven',
			srd_prdsub,	srd_cus1no,
	srd_cus2no,	srd_hkprctrm,	srd_ftyprctrm,
	srd_trantrm,	srd_effdat,		srd_expdat ,
	srd_itmnotmp,	srd_itmnoven,		srd_itmnovenno
from 	SAREQDTL
left join 	IMBASINF on	srd_cocde = ibi_cocde		and 
			srd_itmno = ibi_itmno
left join	VNBASINF on	vbi_venno = srd_prdven
where	srd_cocde = @cocde	and
	srd_reqno = @reqno
order by 	srd_reqseq




GO
GRANT EXECUTE ON [dbo].[sp_select_SAREQDTL2] TO [ERPUSER] AS [dbo]
GO
