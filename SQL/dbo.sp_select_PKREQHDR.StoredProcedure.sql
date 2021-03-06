/****** Object:  StoredProcedure [dbo].[sp_select_PKREQHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKREQHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKREQHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE  procedure [dbo].[sp_select_PKREQHDR]
                                                                                                                                                                                                                                                                 
@cocde nvarchar(6),
@reqno nvarchar(20)


---------------------------------------------- 

 
AS
 

begin

select 
prh_cocde, prh_reqno, prh_ver, 
convert(varchar(10),prh_issdat,101)as 'prh_issdat', 
convert(varchar(10),prh_revdat,101)as'prh_revdat', prh_status, prh_cus1no, c1.cbi_cussna as 'cus1name'
 , prh_cus2no, c2.cbi_cussna as 'cus2name',
 prh_saldiv, prh_saltem, prh_salrep + ' - ' + yup_usrnam as 'prh_salrep' , prh_ToNo, prh_ToVer, 
prh_ToSts, convert(varchar(10),prh_ToIsdat,101)as'prh_ToIsdat', convert(varchar(10),prh_ToRevdat,101)as 'prh_ToRevdat', prh_ToRefqut, prh_potyp,
 prh_ScNo, prh_ScVer, prh_ScSts, convert(varchar(10),prh_ScIsdat,101)as'prh_ScIsdat', convert(varchar(10),prh_ScRevdat,101) as 'prh_ScRevdat',
 convert(varchar(10),prh_ScPodat,101)as'prh_ScPodat',  Convert(varchar(10),prh_ScCandat,101) as 'prh_ScCandat' , convert(varchar(10),prh_ScShpdatstr,101) as 'prh_ScShpdatstr', convert(varchar(10),prh_ScShpdatend,101) as 'prh_ScShpdatend' , 
prh_ScRemark, prh_creusr, prh_updusr, prh_credat, prh_upddat , cast(prh_timstp as int) as prh_timstp




from PKREQHDR

left join syusrprf on prh_salrep = yup_usrid
left join cubasinf c1 on prh_cus1no =  c1.cbi_cusno
left join cubasinf c2 on prh_cus2no = c2.cbi_cusno

where prh_reqno = @reqno and prh_cocde = @cocde 

end











GO
GRANT EXECUTE ON [dbo].[sp_select_PKREQHDR] TO [ERPUSER] AS [dbo]
GO
