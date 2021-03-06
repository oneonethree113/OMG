/****** Object:  StoredProcedure [dbo].[sp_list_SYBATRPT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYBATRPT]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYBATRPT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_list_SYBATRPT] 

@cocde	nvarchar(6)

AS


SELECT 

yrp_cocde,
yrp_rptid,
yrp_rptdsc,
yrp_orgpth,
yrp_schdul,
yrp_schval,
yrp_frmdat,
yrp_todat,
yrp_creusr,
yrp_updusr,
yrp_credat,
yrp_upddat,
cast(yrp_timstp as int) as yrp_timstp
 
FROM SYBATRPT

WHERE

yrp_cocde = @cocde and
(getdate() between convert(nvarchar(10), yrp_frmdat, 101) + ' 00:00:00'  and  convert(nvarchar(10), yrp_todat, 101) + ' 23:59:59.998') and 
(
yrp_schdul = 'D' or

(yrp_schdul = 'W' and
yrp_schval = case when datepart(dw,getdate()) = 1 then 'SUN' else
case when datepart(dw,getdate()) = 2 then 'MON' else
case when datepart(dw,getdate()) = 3 then 'TUE' else
case when datepart(dw,getdate()) = 4 then 'WED' else
case when datepart(dw,getdate()) = 5 then 'THU' else
case when datepart(dw,getdate()) = 6 then 'FRI' else
case when datepart(dw,getdate()) = 7 then 'SAT' 
end end end end end end end
) or

(yrp_schdul = 'M' and
datepart(d,getdate()) = cast(yrp_schval as  int)
) 

)

order by yrp_rptid



GO
GRANT EXECUTE ON [dbo].[sp_list_SYBATRPT] TO [ERPUSER] AS [dbo]
GO
