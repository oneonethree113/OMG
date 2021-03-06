/****** Object:  StoredProcedure [dbo].[sp_select_IMR00018]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00018]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00018]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE      PROCEDURE [dbo].[sp_select_IMR00018]

@cocde as nvarchar(6),
@stage as nvarchar(30),
@fromvenno as nvarchar(6),
@tovenno as nvarchar(6),
@fromcredat as nvarchar(10),
@tocredat as nvarchar(10)
,@usrid as nvarchar(30)
-------------------------------


as

declare @string as nvarchar(4000)


declare 	@VenTypFm	as	char(1),
	@VenTypTo	as	char(1)
	

SET @VenTypFm=''
SET @VenTypTo=''

--select distinct @VenTypFm = 
--		case when isnull(yuc_flgcstext,'')='1' then 'E'
--		 	when isnull(yuc_flgcstext,'')='0' then case when isnull(yuc_flgcst,'') = '1' then 'I' else '' end 
--			else '' end,
--	 @VenTypTo = 
--		case when isnull(yuc_flgcst,'')='1' then 'J'
--		 	when isnull(yuc_flgcst,'')='0' then case when isnull(yuc_flgcstext,'') = '1' then 'E' else '' end 
--			else '' end
		--,yuc_usrid,yuc_flgcst,yuc_flgcstext
--from SYMUSRCO
--where yuc_usrid=@usrid

--select @VenTypFm,@VenTypTo

---	 EXT	INT	Ven Fm	Ven To
---------------------------------------------------------------------
--	   1	  1	     E	     J
--	   1	  0	     E	     E
--	   0	  1	     I	     J
--	   0	  0	   N/A	   N/A
----------------------------------------------------------------------

set @string = 
'select 
a.ied_stage, a.ied_ucpno, a.ied_venno, a.ied_prdven, convert(varchar,a.ied_credat,101) as ied_credat ,  a.ied_lnecde, a.ied_engdsc, 
a.ied_untcde, a.ied_conftr,  a.ied_inrqty, a.ied_mtrqty, a.ied_ftyprc ,
a.ied_sysmsg + '' ('' +a.ied_xlsfil  + '')'' as ied_sysmsg
,''' + 
replace(@stage,'@',' ') + ''',''' + @fromvenno + ''','''  + @tovenno + ''',''' + @fromcredat + ''',''' + @tocredat +  '''
,vbi_ventyp
 from
 (
select 
ied_cocde,
ied_venno,
ied_prdven,
ied_cusven,
ied_cus1no,
ied_cus2no,
ied_ucpno,
ied_itmseq,
ied_recseq,
0 as ''ied_seqno'',
ied_venitm,
ied_ditmno,
ied_mode,
ied_itmsts,
ied_stage,
ied_itmtyp,
ied_catlvl4,
ied_lnecde,
ied_engdsc,
ied_chndsc,
ied_finishing,
ied_matcde,
ied_nat,
ied_prdtyp,
ied_prdsztyp,
ied_prdszunt,
ied_prdszval,
ied_vencol,
ied_vencoldsc,
ied_untcde,
ied_inrqty,
ied_mtrqty,
ied_cft,
ied_conftr,
ied_inrlin,
ied_inrwin,
ied_inrhin,
ied_mtrlin,
ied_mtrwin,
ied_mtrhin,
ied_pckM,
ied_grswgt,
ied_netwgt,
ied_pckitr,
ied_sysmsg,
ied_xlsfil,
ied_chkdat,
ied_prctrm,
ied_curcde,
ied_ftycst,
ied_ftyprc,
ied_fcurcde,
ied_fmlopt,
ied_basprc,
ied_moqum,
ied_moq,
ied_moaccy,
ied_moa,
ied_qutdat,
ied_expdat,
ied_refresh,
ied_remark,
ied_bomcst,
ied_bomprc,
ied_creusr,
ied_updusr,
ied_credat,
ied_upddat,
ied_timstp
from imitmexdat

union 

select 
ied_cocde,
ied_venno,
ied_prdven,
ied_cusven,
ied_cus1no,
ied_cus2no,
ied_ucpno,
ied_itmseq,
ied_recseq,
ied_seqno,
ied_venitm,
ied_ditmno,
ied_mode,
ied_itmsts,
ied_stage,
ied_itmtyp,
ied_catlvl4,
ied_lnecde,
ied_engdsc,
ied_chndsc,
ied_finishing,
ied_matcde,
ied_nat,
ied_prdtyp,
ied_prdsztyp,
ied_prdszunt,
ied_prdszval,
ied_vencol,
ied_vencoldsc,
ied_untcde,
ied_inrqty,
ied_mtrqty,
ied_cft,
ied_conftr,
ied_inrlin,
ied_inrwin,
ied_inrhin,
ied_mtrlin,
ied_mtrwin,
ied_mtrhin,
ied_pckM,
ied_grswgt,
ied_netwgt,
ied_pckitr,
ied_sysmsg,
ied_xlsfil,
ied_chkdat,
ied_prctrm,
ied_curcde,
ied_ftycst,
ied_ftyprc,
ied_fcurcde,
ied_fmlopt,
ied_basprc,
ied_moqum,
ied_moq,
ied_moaccy,
ied_moa,
ied_qutdat,
ied_expdat,
ied_refresh,
ied_remark,
ied_bomcst,
ied_bomprc,
ied_creusr,
ied_updusr,
ied_credat,
ied_upddat,
ied_timstp
from imitmexdath


) a
 left join VNBASINF on a.ied_venno = vbi_venno
 where
--a.iid_cocde = ''' +@cocde + ''' and 
 a.ied_stage in (' + replace(@stage,'@','''') + ') and 
 a.ied_venno  between ''' + @fromvenno + ''' and ''' + @tovenno + ''' and
 a.ied_credat  between ''' + @fromcredat + ' 00:00:00' + ''' and ''' + @tocredat + ' 23:59:59' + ''' 
-- and ''' + @VenTypFm + '''<>'''' 
--and  isnull(vbi_ventyp,'''') between ''' + @VenTypFm + ''' and ''' + @VenTypTo + '''
 order by a.ied_stage, a.ied_venno,  cast(a.ied_credat as smalldatetime)'

--select @string,len(@string)

exec( @string)

--exec( @string)






GO
